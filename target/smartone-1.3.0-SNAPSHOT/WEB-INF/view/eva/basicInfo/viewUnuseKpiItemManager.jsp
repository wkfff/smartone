<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid_d;
	var $grid_i;
	var paramNo = "";
	var lockFlag = "0";
	var $dialogUpload;
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create : function(container, editParm) {
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue : function(input, editParm) {
			return input.val();
		},
		setValue : function(input, value, editParm) {
			input.val(value);
		},
		resize : function(input, width, height, editParm) {
			var column = editParm.column;
			if (column.editor.width)
				input.width(column.editor.width);
			else
				input.width(width);
			if (column.editor.height)
				input.height(column.editor.height);
			else
				input.height(height);
		}
	};
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			leftWidth : 220,
			height : '99.6%',
			allowLeftResize : false
		});
		spf_inputKpiTypeInfo();
		spf_initGrid_kpiItem();
	});
	function spf_inputKpiTypeInfo() {
		$.ajax({
			type : 'post',
			cache : false,
			contentType : 'application/json',
			url : '/eva/kpi/getEvaKpiTypeInfo',
			dataType : 'json',
			success : function(data) {
				var temp = "<option value=''>--<spring:message code="hrms.selection"/>--</option>";
				$.each(data.Rows, function(i, item) {
					var url = "<option value='"+item.EVA_TYPE_ID+"'>"
							+ item.EVA_TYPE_NAME + "</option>"
					temp = temp + url;
				});
				$("#EVA_TYPE_ID").html(temp);
			},
			error : function() {
				$.ligerDialog.error('Send Error');
			}
		});
	}
	function spf_initGrid_kpiItem() {
		$grid_d = $("#kpiItemInfo").ligerGrid({
			checkbox : true,
			columns : [ {display : '',name : 'EVA_KPI_NO',width : 10,hide : 1},
						{display : '<spring:message code="eva.indexID"/>',name : 'EVA_KPI_ID',width : 10,hide : 1}, 
						{display : '<spring:message code="eva.calculation"/>',name : 'EVA_KPI_NAME',width : 120}, 
						{display : '<spring:message code="eva.definition"/>',name : 'KPI_DEFINE',width : 200,editor : {type : 'textarea',height : 100}}, 
						{display : '<spring:message code="eva.calculation1"/>',name : 'CAL_DES',width : 200,editor : {type : 'textarea',height : 100}}, 
						{display : '<spring:message code="eva.appraisalStandards"/>',name : 'KPI_STANDARD',width : 80},
						{display : '<spring:message code="hrms.productCategory"/>',name : 'EVA_TYPE_NAME',width : 120}
					],
			enabledEdit : true,
			usePager : true,
			rownumbers : true,
			url : '/eva/kpi/getEvaKpiItemInfo?userFlag2=1',
			parms : [ 
						{name : 'EMPID',value : "${paraMap.EMPID}"}
					],
			width : '99.8%',
			height : '99.8%',
			pageSize : 20,
		});
	}
	function spf_search() {
		$grid_d.setOptions({
			parms : [ 
					{name : 'keyWord',value : $("#keyWord").attr('value')}, 
					{name : 'EVA_TYPE_ID',value : $("#EVA_TYPE_ID").attr('value')},
					{name : 'EMPID',value : "${paraMap.EMPID}"}],
			newPage : 1
		}); //设置数据参数 
		$grid_d.loadData(true); //加载数据
	}
	function spf_search_i() {
		$grid_i.setOptions({
			parms : [ {
				name : 'PA_MONTH',
				value : $("#year").attr('value') + $("#month").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数 
		$grid_i.loadData(true); //加载数据
	}
	
	function save_manager(){
		var jsonData = '[' ; 
		var rows = $grid_d.getCheckedRows(); 
		if (!rows || rows.length == 0) { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			 return ; 
		}
		$(rows).each(function (index, row){ 
			 if (jsonData.length > 1){
				jsonData += ',{' ;
			 }else{
				jsonData += '{' ;
			 }
			 jsonData += ' "EMPID": "' + "${paraMap.EMPID}" + '", ' ;	
			 jsonData += ' "EVA_KPI_ID": "' + this.EVA_KPI_ID + '"' ;
			 jsonData += '}' ;
		}); 
		jsonData += ']' ;  
		var jsonList = eval("(" + jsonData + ")");
		if(jsonData.length == 2){
			return ;
		} 
		if(jsonList.length == rows.length){ 
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/eva/kpi/addKpiManagerInfo",[ {
					name : 'jsonData',
					value : jsonData
				} ]
				, function (result)
				{
				$.ligerDialog.closeWaitting();
					if (result == "Y"){
						$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
							$grid_d.loadData(true); //加载数据 
							parent.d_ChildWindowClose(); //加载数据
						});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
				}
			});
		}
	}
	
	function f_ChildWindowClose() {
		$grid_d.loadData(true); //加载数据 
	}
</script>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
	<div position="top">
		<table width="99%" cellpadding="0" cellspacing="0"
			class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td width="15%" class="l-table-edit-t"><spring:message code="keyWord"/></td>
				<td width="35%" class="l-table-edit-c"><input name="keyWord"
					type="text" id="keyWord" size="30" /></td>
				<td width="15%" class="l-table-edit-t"><spring:message code="eva.category"/></td>
				<td width="35%" class="l-table-edit-c"><select id="EVA_TYPE_ID"
					name="EVA_TYPE_ID" onchange="spf_search()"></select></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="l-table-edit"
			height="30">
			<tr>
				<td align="left">
					<a class="l-button"
						style="width: 79px; height: 20px; float: right; margin-left: 10px; "
						onclick="save_manager()"><spring:message code="hrms.save"/></a>
					<a class="l-button"
						style="width: 79px; height: 20px; float: right; margin-left: 10px; "
						onclick="spf_search()"><spring:message code="search"/></a>
				</td>
			</tr>
		</table>
	</div>
	<div id="layout1">
		<div position="center" id='kpiItemInfo' title='<spring:message code="eva.calculation"/>'></div>
	</div>
</body>
</html>
