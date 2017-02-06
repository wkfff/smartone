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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function (){
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,      //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
    });
    function spf_application(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
            $.post("/ess/infoApp/addCardtimeApp",
                    [
                    { name: 'EMPID', value: $("#EMPID").val() },
                    { name: 'ATTENDANCETIME', value: $("#attendanceTime").val()},
                    { name: 'appType', value: 'CardtimeApply'},
                    { name: 'APPLYREASON', value: $("#applyReason").val()}
                    ],
            function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>',
                        '<spring:message code="hrms.warning"/>', function (){
                            $("#attendanceTime").val('');
                            $("#applyReason").val('');
                        });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_checkData(){
        var attendanceTime = $("#attendanceTime").val();
        var applyReason = $("#applyReason").val();
        if (attendanceTime == null || attendanceTime == "") { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.attendanceTime"/>'+". " + '<spring:message code="input.required"/>') ; 
            return false;
        }
        if (applyReason == null || applyReason == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.applyReason"/>'+". " + '<spring:message code="input.required"/>') ; 
            return false;
        }
        return true;
    }
</script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
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
                <table width="99.6%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                code="hrms.AttendanceApplication" /></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message
                                    code="hrms.application" /></a></td>
                    </tr>
                </table>
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.EmpSearch" /></td>
                            <td width="35%" class="l-table-edit-c">
                            <c:if test="${isSupervisor}">
                                    <input type="text" name="EMPID_NAME" id="EMPID_NAME" value="${basicInfo.CHINESENAME}" />
                                    <input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID}" />
                                    <input type="hidden" name="TIME_STAMP" id="TIME_STAMP" value="${timeStamp}" />
                                </c:if> 
                                <c:if test="${!isSupervisor}">
                                    <input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID}" /> 
                                        ${basicInfo.EMPID}
                                </c:if></td>
                            <td width="15%" class="l-table-edit-t"><spring:message
                                    code="hrms.applicant" /></td>
                            <td width="35%" class="l-table-edit-c">
                                ${basicInfo.CHINESENAME}</td>
                        </tr>
                        <tr>
                            <td width="20%" class="l-table-edit-t"><spring:message code="hrms.normalAttendanceTime" /><font color="red">*</font></td>
                            <td width="80%" class="l-table-edit-c" colspan="3">
                                <input type="text" name="attendanceTime" id="attendanceTime" 
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})" />
                            </td>
                        </tr>
                        <tr>
                            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.applyReason" /><font color="red">*</font></td>
                            <td width="85%" class="l-table-edit-c" colspan="3"><textarea
                                    rows="" cols="" style="height: 100px; width: 600px"
                                    id="applyReason" name="applyReason"></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>