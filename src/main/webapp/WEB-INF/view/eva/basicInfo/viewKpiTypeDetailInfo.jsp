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
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript"> 
	var $grid;
	var $mc1stSelectList;
	var $mc2ndSelectList;
	var $ptSelectList;
	var $dtSelectList;
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
			leftWidth : 250,
			height : '99%'
		});
		$mc1stSelectList = getMC1STSelectList();
		$mc2ndSelectList = getMC2NDSelectList();
		$ptSelectList = getParameterTypeSelectList();
		$dtSelectList = getDataTypeSelectList();
		spf_inputKpiTypeInfo();
	});
	function getMC1STSelectList() {
		//请求服务器
		var mcSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getMC1STSelectList?TABLE_NAME=PA_HR_V',
			dataType : 'json',
			async : false,
			success : function(list) {
				mcSelectList = list;
			}
		});
		return mcSelectList;
	}
	function getMC2NDSelectList() {
		//请求服务器
		var mcSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getMC2NDSelectList?TABLE_NAME=PA_HR_V',
			dataType : 'json',
			async : false,
			success : function(list) {
				mcSelectList = list;
			}
		});
		return mcSelectList;
	}
	function getParameterTypeSelectList() {
		//请求服务器
		var ptSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getParameterTypeSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				ptSelectList = list;
			}
		});
		return ptSelectList;
	}
	function getDataTypeSelectList() {
		//请求服务器
		var dtSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getDataTypeSelectList?PARENT_CODE=DataType&DEPTH=2',
			dataType : 'json',
			async : false,
			success : function(list) {
				dtSelectList = list;
			}
		});
		return dtSelectList;
	}
	function spf_inputKpiTypeInfo() {
		$grid = $("#inputItemInfo").ligerGrid({
			checkbox : false,
			columns : [
					{display : '',name : 'EVA_TYPE_NO',width : 10,hide : 1},
					{display : '',name : 'EVA_TYPE_ID',width : 10,hide : 1},
					{display : '考核类别',name : 'EVA_TYPE_NAME',width : 150,editor: { type: 'text', height: 100 },frozen:true},
					{display : '描述',name : 'DESCRIPTION',width : 630,editor: { type: 'text', height: 100 },frozen:true}
					],
			enabledEdit : true,
			usePager : true,
			rownumbers : true,
			url : '/eva/kpi/getEvaKpiTypeInfo',
			width : '99%',
			height : '99%'
		});
	}
	function spf_search() {
		$grid.setOptions({
			parms : [ 
				{name : 'keyWord',value : $("#keyWord").attr('value')},
				{name : 'DEPTID',value : $("#DEPTID").attr('value')},
				{name : 'PA_MONTH',value : $("#year").attr('value') + $("#month").attr('value')}
			],
			newPage : 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_add() {
		$grid.addRow();
	}
	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据
	}
	function spf_save() {
		var jsonData = '[';
		var rows = $grid.getData();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$(rows).each(
			function(index, row) {
				if (this.EVA_TYPE_NAME == null|| this.EVA_TYPE_NO == ''|| this.EVA_TYPE_NAME == 'undefined') {
					$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.parameterType"/>'
						+ ". "+ '<spring:message code="input.required"/>');
					return false;
				}
				if (jsonData.length > 1) {
					jsonData += ',{';
				} else {
					jsonData += '{';
				}
				jsonData += ' "__status": "' + this.__status+ '", ';
				jsonData += ' "EVA_TYPE_NO": "' + MyCheckNull(this.EVA_TYPE_NO)+ '", ';
				jsonData += ' "EVA_TYPE_NAME": "'+ MyCheckNull(this.EVA_TYPE_NAME) + '", ';
				jsonData += ' "DESCRIPTION": "'+ MyCheckNull(this.DESCRIPTION) + '"';
				jsonData += '}';
			});
		jsonData += ']';
		var jsonList = eval("(" + jsonData + ")");
		if (jsonData.length == 2) {
			return;
		}
		if (jsonList.length == rows.length) {
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/eva/kpi/addAndupdateKpiTypeInfo", [ {
				name : 'jsonData',
				value : jsonData
			} ], 
			function(result) {
				$.ligerDialog.closeWaitting();
				if (result == "Y") {
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>',
						function() {
							$grid.loadData(true); //加载数据
							parent.f_ChildWindowClose(); //加载数据
						});
				} else {
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	}
	function spf_delete() {
		var row = $grid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.post("/eva/kpi/deleteKpiTypeInfo", 
			[ 
				{name : 'EVA_TYPE_NO',value : MyCheckNull(row.EVA_TYPE_NO)},
				{name : 'EVA_TYPE_ID',value : MyCheckNull(row.EVA_TYPE_ID)} 
			], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function() {
					$grid.loadData(true); //加载数据
					parent.f_ChildWindowClose(); //加载数据
				});
			} else {
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		});
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
	<div id="layout1">
		<div align="left" position="center" id=''>
			<div align="left">
				<table width="99%" cellpadding="1" cellspacing="1"
					style="height: 30px; font-size: 12px;">
					<tr>
						<td align="right">
							<a class="l-button"
								style="width: 79px; height: 20px; float: right; margin-left: 10px; "
								onclick="spf_add()">
								<spring:message code="hrms.add" />
							</a> 
							<a class="l-button"
								style="width: 79px; height: 20px; float: right; margin-left: 10px; "
								onclick="spf_save()">
								<spring:message code="hrms.save" />
							</a>
								<a class="l-button"
								style="width: 79px; height: 20px; float: right; margin-left: 10px; "
								onclick="spf_delete()">
								<spring:message code="hrms.delete" />
							</a>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='inputItemInfo'></div>
		</div>
	</div>
</body>
</html>
