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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
function spf_save(){
    if(spf_checkData()){
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/empinfo/addQualificationInfo", 
                [
                  	{ name: 'QUAL_TYPE_CODE', value: $("#QUAL_TYPE_CODE").val()},
                  	{ name: 'QUAL_CARD_NAME', value: $("#QUAL_CARD_NAME").val()},
                  	{ name: 'EMPID', value: $("#EMPID").val()},
                  	{ name: 'QUAL_CARD_NO', value: $("#QUAL_CARD_NO").val()},
                  	{ name: 'QUAL_LOCATION', value: $("#QUAL_LOCATION").val()},
                  	{ name: 'OPEN_DATE', value: $("#OPEN_DATE").val()},
                  	{ name: 'START_DATE', value: $("#START_DATE").val()},
                  	{ name: 'END_DATE', value: $("#END_DATE").val()},  
                  	{ name: 'ANNUAL_DATE', value: $("#ANNUAL_DATE").val()},
                  	{ name: 'REMARK', value: $("#REMARK").val()} 
                 ]
            , function (result)
            {
            	$.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
		               parent.f_ChildWindowClose() ;
                    });
                }
                else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
    }
}

function spf_checkData(){
	var QUAL_TYPE_CODE = $("#QUAL_TYPE_CODE").val(); 
	var QUAL_CARD_NAME = $("#QUAL_CARD_NAME").val(); 
	var QUAL_LOCATION = $("#QUAL_LOCATION").val(); 
	var OPEN_DATE = $("#OPEN_DATE").val(); 
    if (QUAL_TYPE_CODE == null || QUAL_TYPE_CODE == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.certificateType"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }
    if (QUAL_CARD_NAME == null || QUAL_CARD_NAME == "") { 
      	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.certificateName"/>'+". " + '<spring:message code="input.required"/>') ; 
      	 return false; 
    }
    if (QUAL_LOCATION == null || QUAL_LOCATION == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.certificationOffice"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }  
    if (OPEN_DATE == null || OPEN_DATE == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.evidenceDate"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }
    return true; 
}
</script>
<style type="text/css">
	body {padding: 5px;margin: 0;padding-bottom: 15px;}
	#layout1 {width: 99.8%;margin: 0;padding: 0;}
</style>
</head>
<body style="padding: 2px">
	<div id='layout1'>
		<form name="form1" method="post" action="" id="form1">
			<table width="100%" border="0">
				<tr>
					<td height="2">
						<input type="hidden" name="EMPID" id="EMPID" value="${paramMap.EMPID }" />
					</td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
							<tr>
								<td width="160px;" class="l-table-edit-t"><spring:message
										code="hrms.certificateType" /></td>
								<td width="60px;" class="l-table-edit-c" colspan="2">
									<SipingSoft:selectSyCode
										parentCode="QualTypeCode" name="QUAL_TYPE_CODE" limit="all" />
								</td>
							</tr>
							<tr>
								<td width="160px;" class="l-table-edit-t"><spring:message
										code="hrms.certificateName" /></td>
								<td width="60px;" class="l-table-edit-c" colspan="2"><input
									type="text" name="QUAL_CARD_NAME" id="QUAL_CARD_NAME" value=""
									validate="{required:true}" /></td>
							</tr>
							<tr>
								<td width="160px;" class="l-table-edit-t"><spring:message
										code="hrms.certificateNumber" /></td>
								<td width="60px;" class="l-table-edit-c" colspan="2"><input
									type="text" name="QUAL_CARD_NO" id="QUAL_CARD_NO" value=""
									validate="{required:true}" /></td>
							</tr>
							<tr>
								<td width="160px;" class="l-table-edit-t"><spring:message
										code="hrms.certificationOffice" /></td>
								<td width="60px;" class="l-table-edit-c" colspan="2"><input
									type="text" name="QUAL_LOCATION" id="QUAL_LOCATION" value=""
									validate="{required:true}" /></td>
							</tr>
							<tr>
								<td width="160px;" class="l-table-edit-t"><spring:message
										code="hrms.evidenceDate" /></td>
								<td width="60px;" class="l-table-edit-c" colspan="2"><input
									type="text" name="OPEN_DATE" id="OPEN_DATE" value=""
									onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
									validate="{required:true}" readonly="readonly" /></td>
							</tr>
							<tr>
								<td class="l-table-edit-t"><spring:message
										code="hrms.endDate" /></td>
								<td class="l-table-edit-c" colspan="2"><input type="text"
									name="END_DATE" id="END_DATE" value=""
									onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td class="l-table-edit-t"><spring:message
										code="hrms.annualDate" /></td>
								<td class="l-table-edit-c" colspan="2"><input type="text"
									name="ANNUAL_DATE" id="ANNUAL_DATE" value=""
									onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
									readonly="readonly" /></td>
							</tr>
							<tr>
								<td class="l-table-edit-t"><spring:message
										code="hrms.remarks" /></td>
								<td class="l-table-edit-c" colspan="2"><textarea rows="3"
										cols="" style="width: 300px" id="REMARK"
										name="REMARK"></textarea></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><a class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_save();"><spring:message code="hrms.save" /></a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
