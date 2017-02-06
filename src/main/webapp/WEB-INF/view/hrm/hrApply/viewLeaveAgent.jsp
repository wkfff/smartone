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

    var navtab = null;
    $(function (){
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid){
            var empID = $("#EMPID").val();
            if(tabid=="tabitem2"){
            }
        }});
        var empID = $("#EMPID").val();
       /* spf_ld_initGrid(empID);*/
    });
    /*function spf_ld_initGrid(empID){
        $grid = $("#ldInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME'},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME'},
                { display: '<spring:message code="hrms.leaveType"/>', name: 'LEAVE_TYPE_NAME'},
                { display: '<spring:message code="hrms.startedTime"/>', name: 'LEAVE_FROM_TIME'},
                { display: '<spring:message code="hrms.endTime"/>', name: 'LEAVE_TO_TIME'},
                { display: '<spring:message code="hrms.leaveLength"/>', name: 'LEAVE_LENGTH'}
            ],
            usePager: true,
            url: '/ess/viewApp/getEmpLeaveDetailInfo?EMPID='+empID,
            width: '99%',height:'98%'
        });
    }*/
    function spf_qv_initGrid(empID){
        $grid = $("#qvInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME'},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME'},
                { display: '<spring:message code="hrms.year"/>', name: 'VAC_ID'},
                { display: '<spring:message code="hrms.leaveType"/>', name: 'VAC_TP_NAME'},
                { display: '<spring:message code="hrms.startDate"/>', name: 'STRT_DATE'},
                { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE'},
                { display: '<spring:message code="hrms.leaveLength"/>', name: 'TOT_VAC_CNT'},
                { display: '<spring:message code="hrms.deductionHours"/>', name: 'DEL_VAC_CNT'}
            ],
            usePager: true,
            url: '/att/attendanceMintenance/getEsslLeaveInfo?EMPID='+empID,
            width: '99%',height:'98%'
        });
    }
    function spf_initSelectEmpInfo(data) {
        $("#EMPID").attr("value", data.EMPID);
        var url = (location.href).split("?");
        var _url = url[1].split("&");
        location.href = url[0] + "?" + _url[0] + "&EMPID=" + data.EMPID;
    }
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
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#EMPID_NAME").val("");
        $("#EMPID").val("");
        dialog.close();
    }
    $(function (){
        $("#LEAVE_WA_EMPID_NAME").ligerComboBox({
            onBeforeOpen: spf_selectWAEmp, valueFieldID: 'LEAVEWAEMPID',width:150
        });
    });
    function spf_selectWAEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>',
            name:'waselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/empInfo/viewHrSearchEmployeeB',
            buttons: [
                    { text: '<spring:message code="okay"/>', onclick: spf_selectWAOK },
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectWACancel },
                    { text: '<spring:message code="clear"/>', onclick: spf_selectWAClear }
                    ]
            });
        return false;
    }
    function spf_selectWAOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#LEAVE_WA_EMPID_NAME").val(data.EMPID+","+data.CHINESENAME);
        $("#LEAVEWAEMPID").val(data.EMPID);
        dialog.close();
    }
    function spf_selectWACancel(item, dialog){
        dialog.close();
    }
    function spf_selectWAClear(item, dialog){
        $("#LEAVE_WA_EMPID_NAME").val("");
        $("#LEAVEWAEMPID").val("");
        dialog.close();
    }
    function spf_application(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
            $.post("/ess/infoApp/addLeaveApp",
                    [
                        { name: 'EMPID', value: $("#EMPID").val() },
                        { name: 'LEAVE_FROM_TIME', value: $("#LEAVE_FROM_TIME").val() },
                        { name: 'LEAVE_TO_TIME', value: $("#LEAVE_TO_TIME").val() },
                        { name: 'LEAVE_TYPE_CODE', value: $("#LEAVE_TYPE_CODE").val() },
                        { name: 'LEAVE_WA_EMPID', value: $("#LEAVEWAEMPID").val() },
                        { name: 'LEAVE_REASON', value: $("#LEAVE_REASON").val() },
                        { name: 'appType', value: 'LeaveApply'}
                    ]
            , function (result)
            {
            $.ligerDialog.closeWaitting();
                if (result == "Y") {
                    $.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        $grid.loadData(true); //加载数据
                        $("#LEAVE_FROM_TIME").val('');
                        $("#LEAVE_TO_TIME").val('');
                        $("#LEAVE_REASON").val('');
                        $("#LEAVE_WA_EMPID_NAME").val('');
                    });
                }
                else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_checkData(){
        var leaveTypeCode = $("#LEAVE_TYPE_CODE").val();
        var leaveWAEmpID = $("#LEAVEWAEMPID").val();
        var leaveReason = $("#LEAVE_REASON").val();
        var leaveFromTime = $("#LEAVE_FROM_TIME").val();
        var leaveToTime = $("#LEAVE_TO_TIME").val();
        if (leaveFromTime == null || leaveFromTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startedTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (leaveToTime == null || leaveToTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (leaveTypeCode == null || leaveTypeCode == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.leaveType"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (leaveWAEmpID == null || leaveWAEmpID == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingAgent"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if ($("#LEAVEWAEMPID").val() == $("#EMPID").val()) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '代理人不能是本人！') ;
            return false;
        }
        if (leaveReason == null || leaveReason == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.leaveReason"/>'+". " + '<spring:message code="input.required"/>') ;
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
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="5%" align="center"><img
                                src="/resources/images/title/top_1.gif" /></td>
                            <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                    code="hrms.leaveApplication" /></td>
                            <td width="5%" align="right">&nbsp;</td>
                            <td align="right" height="30px;"><a class="l-button"
                                style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                                onclick="spf_application()"><spring:message
                                        code="hrms.application" /></a></td>
                        </tr>
                    </table>
                    <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t" width="15%"><spring:message
                                    code="hrms.EmpSearch" /></td>
                            <td width="35%" class="l-table-edit-c" nowrap="nowrap">
                                <input type="text" name="EMPID_NAME" id="EMPID_NAME" value="${basicInfo.CHINESENAME }" />
                                <input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }" />
                            </td>
                            <td class="l-table-edit-t" width="15%"><spring:message code="hrms.applicant" /></td>
                            <td class="l-table-edit-c" width="35%">${basicInfo.CHINESENAME}</td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.startedTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="LEAVE_FROM_TIME" id="LEAVE_FROM_TIME"
                                value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                validate="{required:true}" /></td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.endTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="LEAVE_TO_TIME" id="LEAVE_TO_TIME" value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                validate="{required:true}" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.leaveType" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode
                                    parentCode="LeaveTypeCode" name="LEAVE_TYPE_CODE" limit="all" />
                            </td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.workingAgent" /><font color="red">*</font></td>
                            <td class="l-table-edit-c" colspan="3"><input type="text"
                                name="LEAVE_WA_EMPID_NAME" id="LEAVE_WA_EMPID_NAME" value=""
                                validate="{required:true}" /> <input type="hidden"
                                name="LEAVEWAEMPID" id="LEAVEWAEMPID" value="" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.leaveReason" /><font color="red">*</font></td>
                            <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                    cols="" style="height: 100px; width: 600px" id="LEAVE_REASON"
                                    name="LEAVE_REASON" validate="{required:true}"></textarea></td>
                        </tr>
                    </table>
                </form>
                <!--
                <table width="99.5%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                code="hrms.leaveDetail" /></td>
                        <td width="65%" align="right">&nbsp;</td>
                        <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
                <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-c" colspan="4">
                            <div id="navtab1"
                                style="width: 100%; overflow: hidden; border: 1px solid #A3C0E8;">
                                <div title='<spring:message code="hrms.leaveDetail"/>'>
                                    <div id="ldInfo"></div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>-->
            </div>
        </div>
    </div>
</body>
</html>