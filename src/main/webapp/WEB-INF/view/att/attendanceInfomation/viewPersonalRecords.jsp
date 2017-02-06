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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<script src="/resources/js/json2.js" type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
var $grid ;
var $dialog ;
//扩展一个 多行文本框 的编辑器
$.ligerDefaults.Grid.editors['textarea'] = {
	create:function (container, editParm){
		var input = $("<textarea class='l-textarea' />");
		container.append(input);
		return input;
	},
	getValue: function (input, editParm){
		return input.val();},
	setValue: function (input, value, editParm){
		input.val(value);},
	resize: function (input, width, height, editParm){
		var column = editParm.column;
		if (column.editor.width) input.width(column.editor.width);
		else input.width(width);
		if (column.editor.height) input.height(column.editor.height);
		else input.height(height);
	}
};
// 初始调用
$(function (){
//布局
	$("#layout1").ligerLayout({	
		allowLeftResize: false,	//是否允许 左边可以调整大小
		allowRightResize: false,	//是否允许 右边可以调整大小
		allowTopResize: false,	//是否允许 头部可以调整大小
		allowBottomResize: false	//是否允许 底部可以调整大小
	});
	f_initGrid();
});
function f_initGrid(){  
	$grid = $("#arDetailInfo").ligerGrid({
	checkbox: false,
	columns: [
		{ display: '', name: 'RECORD_NO' ,width: 10,hide:1},
		{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width: 110},
		{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME',width: 150},
		{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width: 150},
		{ display: '<spring:message code="hrms.time"/>', name: 'R_TIME',width: 160},
		/* { display: '<spring:message code="hrms.inOrOutMarking"/>', name: 'CARD_DOOR_NAME',width: 130}, */
		{ display: '<spring:message code="hrms.active"/>', name: 'IN_FLAG_NAME',width: 130},
		{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 220,
			editor: { type: 'textarea', height: 120 }
		}],
	enabledEdit: true, usePager: true, rownumbers: true,
	url: '/att/attendanceMintenance/getAttCardRecordInfo',
	parms: [	
		{ name: 'S_DATE', value: $("#S_DATE").val()},
		{ name: 'E_DATE', value: $("#E_DATE").val()},
		{ name: 'EMPID', value: '${EMPID}'}
		], 
	width: '99.6%', height: '100%' }); 
}
/*
*提交改变数据
*/
function spf_save(){
	var rows = $grid.getData() ; 
	var jsonData = '[' ;
	$(rows).each(function(index, row){ 
	if(this.__status != null && this.__status == 'update'){
	if (jsonData.length > 1){
		jsonData += ',{' ;
	}else{
		jsonData += '{' ;
	}
	if(this.LOCK_YN_CODE == 'N'){ 
		jsonData += ' "PK_NO": "' + this.PK_NO + '", ' ;
		jsonData += ' "ITEM_NO": "' + this.ITEM_NO+ '", ' ;
		jsonData += ' "UNIT_CODE": "' + this.UNIT_CODE + '", ' ;
		jsonData += ' "DATE_TYPE": "' + this.DATE_TYPE + '", ' ;
		jsonData += ' "QUANTITY": "' + this.QUANTITY + '"' ;
		jsonData += '}' ;
		}
	}
});

jsonData += ']' ;
if(jsonData.length == 2){
	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	return ; 
}
$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
$.post('/att/attendanceMintenance/updateAttDetailInfo', 
	[	
		{ name: 'jsonData', value: jsonData },
	],function (result){
		if (result == "Y"){
			$.ligerDialog.closeWaitting();
			$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',function (){
				$grid.loadData(true);
			});
		}else{ 
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		}
	});
}

	function spf_search(){
		$grid.setOptions({ parms: [
									{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
									{ name: 'E_DATE', value: $("#E_DATE").attr('value')}, 
									/* { name: 'CARD_DOOR_TYPE', value: $("#CARD_DOOR_TYPE").attr('value')}, */
									{ name: 'EMPID', value: '${EMPID}'}
								],
							newPage: 1
						}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_delete(){
		$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
			if(yes){ 
					var rows = $grid.getSelectedRow();  
					if (!rows || rows.length == 0) { 
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
						return ; 
					}
					var jsonData = '[' ;
					if(rows.LOCK_YN_CODE == 'N'){
						if (jsonData.length > 1){
							jsonData += ',{' ;
						}else{
							jsonData += '{' ;
						}
						jsonData += ' "PK_NO": "' + rows.PK_NO + '"' ;
						jsonData += '}' ;
					}else{
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dayLockedNotOperation"/>') ;
						return ;
					}
					jsonData += ']' ;
					if(jsonData.length == 2){
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>') ;
						return ;
					}
					$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
					$.post('/att/attendanceMintenance/deleteAttDetailInfo', 
						[
							{ name: 'jsonData', value: jsonData },
						]
				, function (result){
					$.ligerDialog.closeWaitting();
					if (result == "Y"){
						$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function (){
							$grid.loadData(true); //加载数据
						});
					}else{
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
					}
				});
			}
		});
	}

	function spf_add(){
		$dialog = $.ligerDialog.open({isDrag: false, 
			title:'<spring:message code="hrms.add"/>', 
			width: 1100, height: 500, 
			url: '/att/attendanceMintenance/addAttDetailInfo'
		});
	}

	function f_ChildWindowClose (){
		$grid.loadData(true); //加载数据
		$dialog.close() ;
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
		<div align="left" position="center" id='' title=' '>
			<div align="left">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.startDate" /></td>
						<td width="35%" class="l-table-edit-c"><input type="text"
							name="S_DATE" id="S_DATE" value="${S_DATE }" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.endDate" /></td>
						<td width="35%" class="l-table-edit-c"><input type="text" name="E_DATE"
							id="E_DATE" value="${E_DATE }" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
					</tr>
					<%-- <tr>
						<td class="l-table-edit-t"><spring:message
								code="hrms.inOrOutMarking" /></td>
						<td  class="l-table-edit-c" colspan="3"><SipingSoft:selectSyCode
								parentCode="CardDoorType" name="CARD_DOOR_TYPE" limit="all"
								onChange="spf_search();" /></td>
					</tr> --%>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
				<div position="center" id='arDetailInfo'></div>
			</div>
		</div>
	</div>
</body>
</html>
