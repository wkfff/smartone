<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
	<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
	// 初始调用页面布局
	var $grid;
	$(function ()
	{
		$("#layout1").ligerLayout({  
			allowLeftResize: false,      //是否允许 左边可以调整大小
			allowRightResize: false,     //是否允许 右边可以调整大小
			allowTopResize: false,      //是否允许 头部可以调整大小
			allowBottomResize: false     //是否允许 底部可以调整大小
		});
	});
	/*
	*弹出框收缩js
	*/ 
	$(function (){ 
		$("#EMP_NAME").ligerComboBox({
			onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
		});
	});
	function spf_selectEmp(){
		$.ligerDialog.open({ 
			title: '<spring:message code="employee.information"/>', 
			name:'empselector'+Math.random(),
			width: 800, 
			height: 400, 
			url: '/utility/empInfo/viewHrSearchEmployeeB', 
			buttons: [
				{ text: '<spring:message code="okay"/>', onclick: spf_selectOK },
				{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
				{ text: '<spring:message code="clear"/>', onclick: spf_selectClear }
			]
		});
		return false;
	}
	function spf_selectOK(item, dialog){
		var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
		var data = fn(); 
		if (!data)
		{
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return;
		}
		$("#EMP_NAME").val(data.CHINESENAME);
		$("#EMPID").val(data.EMPID);
		dialog.close();
	}
	function spf_selectCancel(item, dialog){
		dialog.close();
	}
	function spf_selectClear(item, dialog){
		$("#EMP_NAME").val('');
		$("#EMPID").val('');
		dialog.close();
	}
	function spf_application(){
		if(spf_checkData()){ 
			$.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
			$.post("/hrm/transferOrder/saveTransferOrder", 
				[
					{ name: 'EMPID', value: $("#EMPID").val() },
					{ name: 'PUN_TYPE_CODE', value: $("#PUN_TYPE_CODE").val() },
					{ name: 'PUN_REASON', value: $("#PUN_REASON").val() },
					{ name: 'PUN_AMOUNT', value: $("#PUN_AMOUNT").val() },
					{ name: 'PUNISHED_DATE', value: $("#PUN_DATE").val() },
					{ name: 'TRANS_CODE', value: '${TRANS_CODE}' },
					{ name: 'TRANS_NO', value: '${TRANS_NO}' },
					{ name: 'REMARK', value: '' },
					{ name: 'TYPE', value: 'punishment'}
				]
			, function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>','<spring:message code="hrms.warning"/>', function ()
					{
						spf_refresh();
					});
				}
				else
				{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	}
	function spf_checkData(){
		if ($("#EMPID").val() == null || $("#EMPID").val() == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.EmpSearch" />'+". " + '<spring:message code="input.required"/>') ; 
			return false; 
		}
		if ($("#PUN_DATE").val() == null || $("#PUN_DATE").val() == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.correctionsDate"/>'+". " + '<spring:message code="input.required"/>') ; 
			return false; 
		}
		if ($("#PUN_AMOUNT").val() != "" && isNaN($("#PUN_AMOUNT").val())) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.punishmentAmount"/>'+". " + '<spring:message code="input.number"/>') ; 
            return false; 
        }
        if ($("#PUN_AMOUNT").val() != "" && $("#PUN_AMOUNT").val()<0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.punishmentAmount"/>'+". " + '<spring:message code="productStorage.pleaseEnterAPositiveNumber"/>') ; 
            return false; 
        }
        if ($("#PUN_REASON").val() == null || $("#PUN_REASON").val() == "") { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.punishmentReason"/>'+". " + '<spring:message code="input.required"/>') ; 
            return false; 
        }
		return true; 
	}
	function spf_refresh(){
		location.href="/hrm/transferOrder/viewPunishment?MENU_CODE=hr0208";
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
			<div position="top">
				<table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img
							src="/resources/images/title/top_1.gif" /></td>
						<td width="25%" align="left" style="font-weight: bold;"><spring:message
							code="hrms.punishment" /></td>
						<td width="5%" align="right">&nbsp;</td>
						<td align="right" height="30px;"><a class="l-button"
							style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
							onclick="spf_application()"><spring:message code="hrms.application" /></a>
						</td>
					</tr>
				</table>
				<table width="99.5%" align="center" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td class="l-table-edit-t" width="15%">
							<spring:message code="hrms.EmpSearch" /></td>
						<td class="l-table-edit-c" width="35%"><input type="text"
							name="EMP_NAME" id="EMP_NAME" value=""
							validate="{required:true}" /> <input type="hidden"
							name="EMPID" id="EMPID" value="" /></td>
						<td class="l-table-edit-t" width="15%">
							<spring:message code="hrms.correctionsDate"/><font color="red">*</font>
						</td>
						<td class="l-table-edit-c" width="35%">
							<input type="text"
								name="PUN_DATE" id="PUN_DATE"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})"
								validate="{required:true}" />
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-t" width="15%"><spring:message code="hrms.punishmentType"/><font color="red">*</font></td>
						<td class="l-table-edit-c" width="35%">
							<SipingSoft:selectSyCode parentCode="PunCode" name="PUN_TYPE_CODE"/>
						</td> 
						<td class="l-table-edit-t" width="15%"><spring:message code="hrms.punishmentAmount"/></td>
						<td class="l-table-edit-c" width="35%">
							<input type="text" name="PUN_AMOUNT" id="PUN_AMOUNT" />
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-t" width="15%">
							<spring:message code="hrms.punishmentReason"/><font color="red">*</font>
						</td>
						<td class="l-table-edit-c" colspan="3" ><textarea rows=""
							cols="" style="height: 100px; width: 600px" id="PUN_REASON"
							name="PUN_REASON" validate="{required:true}"></textarea></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
