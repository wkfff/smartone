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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid ;
	var mcCode="";
	var $reasonSelectList ;
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create: function (container, editParm)
		{
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue: function (input, editParm)
		{
			return input.val();
		},
		setValue: function (input, value, editParm)
		{
			input.val(value);
		},
		resize: function (input, width, height, editParm)
		{
			var column = editParm.column;
			if (column.editor.width) input.width(column.editor.width);
			else input.width(width);
			if (column.editor.height) input.height(column.editor.height);
			else input.height(height);
		}
	};
	// 初始调用
	$(function ()
	{
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize: false,		 //是否允许 左边可以调整大小
			allowRightResize: false,	 //是否允许 右边可以调整大小
			allowTopResize: false,		 //是否允许 头部可以调整大小
			allowBottomResize: false	 //是否允许 底部可以调整大小
		});
		$reasonSelectList = getReasonSelectList() ;
		mcCode = '${paraMap.MC_CODE}';
		if(mcCode == 'EMPID'){
			f_initGrid_empID();
		}else{
			f_initGrid(mcCode);
		}
	});
	function getReasonSelectList(){
		//请求服务器
		var reasonSelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getReasonSelectList',
			dataType: 'json',
			async: false,
			success: function (list)
			{
				reasonSelectList = list ;
			}
		});
		return reasonSelectList ;
	}
	function f_initGrid_empID()
	{
		$grid = $("#empInfo").ligerGrid({
			checkbox: true,
			columns: [
				{ display: '', name: 'ITEM_NO', width: 10,hide: 1},
				{ display: '<spring:message code="hrms.empid"/>', name: 'FIELD1_VALUE',width:90 },
				{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:90},
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:120},
				{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME',width:90},
				{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}},
				{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}},
				{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 90, editor: { type: 'float' }},
				{ display: '<spring:message code="hrms.adjustmentReason"/>', name: 'REASON_CODE', width: 120,align: 'center',isSort: false,
					editor: {
						type: 'select', data: $reasonSelectList, dataValueField: 'REASON_CODE',dataDisplayField: 'REASON_NAME',
						displayColumnName: 'REASON_NAME', valueColumnName: 'REASON_CODE'
					}, render: function (item)
					{
						for (var i = 0; i < $reasonSelectList.length; i++)
						{
							if ($reasonSelectList[i]['REASON_CODE'] == item.REASON_CODE)
								return $reasonSelectList[i]['REASON_NAME']
						}
						return item.REASON_NAME;
					}
				},
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
					editor: { type: 'textarea', height: 100 }
				}
			],
			enabledEdit: true,usePager: true, rownumbers:true,
			url: '/pa/wagebase/getPaBasicItemDataEmpInfo?ITEM_NO=${paraMap.ITEM_NO}&MC_CODE=${paraMap.MC_CODE}',
			width: '99.6%', height: '100%'
		});
	}
	function f_initGrid(mcCode)
	{
		$.post('/utility/otherInfo/getMCName?TABLE_NAME=PA_HR_V&MC_CODE='+mcCode,function(back){
			$grid = $("#empInfo").ligerGrid({
				checkbox: true,
				columns: [
					{ display: '', name: 'ITEM_NO', width: 10,hide: 1},
					{ display: back, name: 'FIELD1_VALUE',width:120 },
					{ display: '<spring:message code="name"/>', name: 'NAME',width:120,frozen:true},
					{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'},frozen:true},
					{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}},
					{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 120, editor: { type: 'float' }},
					{ display: '<spring:message code="hrms.adjustmentReason"/>', name: 'REASON_CODE', width: 120,align: 'center',isSort: false,
						editor: {
							type: 'select', data: $reasonSelectList, dataValueField: 'REASON_CODE',dataDisplayField: 'REASON_NAME',
							displayColumnName: 'REASON_NAME', valueColumnName: 'REASON_CODE'
						}, render: function (item)
						{
							for (var i = 0; i < $reasonSelectList.length; i++)
							{
								if ($reasonSelectList[i]['REASON_CODE'] == item.REASON_CODE)
									return $reasonSelectList[i]['REASON_NAME']
							}
							return item.REASON_NAME;
						}
					},
					{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
						editor: { type: 'textarea', height: 100 }
					}
				],
				enabledEdit: true,usePager: true,
				url: '/pa/wagebase/getPaBasicItemDataOtherInfo?ITEM_NO=${paraMap.ITEM_NO}&MC_CODE=${paraMap.MC_CODE}',
				width: '99.6%', height: '100%'
			});
		});
	}

	function spf_search()
	{
		$grid.setOptions({ 
			params: [
				{ name: 'keyWord', value: $("#keyWord").attr('value')},
				{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
				{ name: 'STATUS_CODE', value: $("#STATUS_CODE").attr('value')}
			],
			newPage: 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_save()
	{
		 var jsonData = '[' ;
		 var rows = $grid.getCheckedRows();
		 if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
			 return ;
		 }
		$(rows).each(function (index, row){
			if(this.START_DATE == null || this.START_DATE == '' || this.START_DATE == 'undefined' ){
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			}if(this.END_DATE == null || this.END_DATE == '' || this.END_DATE == 'undefined' ){
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'	 +". " + '<spring:message code="input.required"/>') ;
				 return false;
			}if(this.RETURN_VALUE == null || this.RETURN_VALUE == '' || this.RETURN_VALUE == '0' || this.RETURN_VALUE == '0.0' || this.RETURN_VALUE == 'undefined' ){
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.value"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			}if(this.REASON_CODE == null || this.REASON_CODE == '' || this.REASON_CODE == 'undefined' ){
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.adjustmentReason"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			}else{
				 if (jsonData.length > 1){
					jsonData += ',{' ;
				 }
				 else{
					jsonData += '{' ;
				 }
				 jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '", ' ;
				 jsonData += ' "FIELD1_VALUE": "' + this.FIELD1_VALUE + '", ' ;
				 jsonData += ' "RETURN_VALUE": "' + this.RETURN_VALUE + '", ' ;
				 jsonData += ' "REASON_CODE": "' + this.REASON_CODE + '", ' ;
				 jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
				 jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
				 jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK)+ '"' ;
				 jsonData += '}' ;
			}
		});
		jsonData += ']' ;
		var jsonList = eval("(" + jsonData + ")");
		if(jsonData.length == 2){
			return ;
		}
		if(jsonList.length == rows.length){
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/pa/wagebase/addPaBasicItemDataInfo",
				[
					{ name: 'jsonData', value: jsonData }
				]
			, function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						$grid.loadData(true); //加载数据
						parent.f_ChildWindowClose() ; //加载数据
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	}
</script>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<c:choose>
				<c:when test="${paraMap.MC_CODE == 'EMPID'}">
					<table width="99.6%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td width="10%" class="l-table-edit-t">
								<spring:message code="keyWord" /></td>
							<td width="23%" class="l-table-edit-c"><input name="keyWord"
								type="text" id="keyWord" size="30" /></td>
							<td width="10%" class="l-table-edit-t">
								<spring:message code="hrms.EmpStatus" /></td>
							<td width="23%" class="l-table-edit-c">
								<SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE"
								onChange="spf_search();" limit="all" /></td>
							<td width="10%" class="l-table-edit-t">
								<spring:message code="hrms.dept" /></td>
							<td width="23%" class="l-table-edit-c">
								<SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="l-table-edit"
						height="30">
						<tr>
							<td align="left">
							<a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_search()"><spring:message code="search" /></a>
							<a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<table cellpadding="0" cellspacing="0" class="l-table-edit"
						height="30">
						<tr>
							<td align="left"><a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
