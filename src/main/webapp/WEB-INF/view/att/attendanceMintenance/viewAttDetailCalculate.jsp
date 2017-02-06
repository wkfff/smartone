<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $dialog ;
	$(function (){
		$("#loading").hide();
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize: false,//是否允许 左边可以调整大小
			allowRightResize: false,//是否允许 右边可以调整大小
			allowTopResize: false,//是否允许 头部可以调整大小
			allowBottomResize: false//是否允许 底部可以调整大小
		});
		$("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid){
			if(tabid=="tabitem1"){
				//已经分组人员    
				$("#typeCode").attr("value", "EMP") ;
			}
			if(tabid=="tabitem2"){
				//已经分组人员   
				$("#typeCode").attr("value", "DEPARTMENT") ;
			}
		}}); 
	});
	$(function (){
		$("#EMPID_NAME").ligerComboBox({
			onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
		});
	});
	function spf_selectEmp(){
		$.ligerDialog.open({
			title: '<spring:message code="employee.information"/>', 
			name:'winselector'+Math.random(),
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
		$("#EMPID_NAME").val(data.CHINESENAME);
		$("#EMPID").val(data.EMPID); 
		$("#deptName").html(data.DEPTNAME);
		dialog.close();
	}
	function spf_selectCancel(item, dialog){
		dialog.close();
	}
	function spf_selectClear(item, dialog){
		$("#EMPID_NAME").val("");
		$("#EMPID").val(""); 
		$("#deptName").html("");
		dialog.close();
	}
	function spf_initSelectEmpInfo(data){ 
		if($("#typeCode").val() == "EMP"){
			$("#EMPID").attr("value", data.EMPID);
			$("#name").html(data.CHINESENAME);
			$("#deptName").html(data.DEPTNAME);
		}
		$dialog.close() ;
	} 
	function spf_checkData(type){
		var fromDate = $("#FROM_DATE").val();
		var toDate = $("#TO_DATE").val();
		var empID = "";
		var deptID = "";
		var supervisorID = "";
		if(type == "EMP"){  
			empID = $("#EMPID").val(); 
			if (fromDate == null || fromDate == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
				return false; 
			}
			if (toDate == null || toDate == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
				return false; 
			}
			if (empID == null || empID == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.empid"/>') ; 
				return false; 
			}
		}
		if(type == "DEPARTMENT"){
			deptID = $("#DEPTID").val();
			if (fromDate == null || fromDate == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
				return false; 
			}
			if (toDate == null || toDate == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
				return false; 
			}
			if (deptID == null || deptID == "") { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dept"/>') ; 
				return false; 
			}
		}
		return true;
	}
	function  spf_Calculate(){
		var typeCpde = $("#typeCode").val();
		if(spf_checkData(typeCpde)){
			var urlParam="";
			if(typeCpde == "DEPARTMENT"){ 
				urlParam='caltype=DEPT&deptID='+$("#DEPTID").val();
			}else if(typeCpde == "EMP"){  
				urlParam='caltype=EMP&empID='+$("#EMPID").val();
			}
			$.ligerDialog.confirm('<spring:message code="hrms.beganToCalculate"/>','<spring:message code="hrms.warning"/>', function (yes){
				if(yes){
					$("#loading").show();
					$.ajax({
						type:'post',
						cache:false,
						contentType:'application/json',
						url: '/att/attendanceMintenance/detailCalculate?'+urlParam+'&from_date='+$("#FROM_DATE").val()+'&to_date='+$('#TO_DATE').val(),
						dataType:'json',
						success:function(responseStr){ 
							$("#calculateResult_"+typeCpde).html(responseStr) ;
							$("#loading").hide();
						}
					});
				}
			});
		}
	}
	</script>
</head>
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
<body style="padding: 2px">
	<div id="layout1">
		<div align="left" position="center" id='' title=' '>
			<div align="left">
				<div id="loading"
					style="width: 99%; text-align: center; padding-top: 200px; position: absolute;">
					<img src="/resources/images/loading.gif">
				</div>
				<div id='detailCalculate'>
					<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td width="20%" class="l-table-edit-t"><spring:message
									code="hrms.startDate" /></td>
							<td width="30%" class="l-table-edit-c">
								<input type="hidden" id="typeCode" name="typeCode" value="EMP">
								<input type="text" name="FROM_DATE" id="FROM_DATE" value="${sDate}" size="30"
									onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
									readonly="readonly" /></td>
							<td width="20%" class="l-table-edit-t"><spring:message
									code="hrms.endDate" /></td>
							<td width="30%" class="l-table-edit-c"><input type="text"
								name="TO_DATE" id="TO_DATE" value="${eDate}" size="30"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
								readonly="readonly" /></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="l-table-edit">
						<tr>
							<td align="left" height="30px"><a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_Calculate()"><spring:message code="calculate" /></a>
							</td>
						</tr>
					</table>
					<table width="99.6%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td class="l-table-edit-c" colspan="4">
								<div id="navtab1"
									style="width: 100%; overflow: hidden; border: 1px solid #A3C0E8;">
									<div title='<spring:message code="hrms.individual"/>'>
										<table width="99.6%" cellpadding="0" cellspacing="0"
											class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
											<tr>
												<td width="20%" class="l-table-edit-t">
													<spring:message code="hrms.name" />
												</td>
												<td width="30%" class="l-table-edit-c">
													<input type="text" name="EMPID_NAME" id="EMPID_NAME" value="${basicInfo.CHINESENAME }" />
													<input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }" />
												</td>
												<td width="20%" class="l-table-edit-t">
													<spring:message code="hrms.dept" /></td>
												<td width="30%" class="l-table-edit-c">
													<div id="deptName"></div>
												</td>
											</tr>
										</table>
										<table height="100px;" cellpadding="0" cellspacing="0"
											class="l-table-edit">
											<tr>
												<td colspan="4"><div id="calculateResult_EMP"></div></td>
											</tr>
										</table>
									</div>
									<div title='<spring:message code="hrms.dept"/>'>
										<table width="99.6%" cellpadding="0" cellspacing="0"
											class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
											<tr>
												<td width="20%" class="l-table-edit-t">
													<spring:message code="hrms.dept" /></td>
												<td width="80%" class="l-table-edit-c" nowrap="nowrap">
													<%-- <SipingSoft:deptTree name="DEPTID" limit="ar"/>  --%>
													<SipingSoft:deptTree name="DEPTID" limit="hr" />
												</td>
											</tr>
										</table>
										<table height="100px;" cellpadding="0" cellspacing="0"
											class="l-table-edit">
											<tr>
												<td colspan="4"><div id="calculateResult_DEPARTMENT"></div></td>
											</tr>
										</table>
									</div>
								</div>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
