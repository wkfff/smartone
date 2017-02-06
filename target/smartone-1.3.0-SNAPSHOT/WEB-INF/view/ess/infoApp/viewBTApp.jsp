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
    var $grid ;
    // 初始调用
    $(function () {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,      //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        spf_initGrid();
        getIdCardProvince('','','');
    });

    function spf_initGrid() {
        $grid = $("#affirmorInfo").ligerGrid({
        checkbox: false,
        columns: [
                    { display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',hide:1},
                    { display: '<spring:message code="hrms.name"/>', name: 'AFFIRMOR_NAME'},
                    { display: '<spring:message code="hrms.approvalLevel"/>', name: 'AFFIRM_LEVEL'}
                ],
        usePager: false, rownumbers:true,
        url: '/ess/infoApp/getAffirmorList?appType=BTApply',
        parms: [{ name: 'EMPID', value: $("#EMPID").attr('value')},
                { name: 'BT_TYPE_CODE', value: $("#BT_TYPE_CODE").attr('value')}
                ],
        width: '98%', height: '89%'
        });
    }
    /*
    *弹出框收缩js
    */
    $(function ()
            {
                $("#EMPID_NAME").ligerComboBox({
                    onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
                });
            });
            function spf_selectEmp()
            {
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
            function spf_selectOK(item, dialog)
            {
                var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
                var data = fn();
                if (!data)
                {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                    return ;
                }
                $("#EMPID_NAME").val(data.EMPID+","+data.CHINESENAME);
                $("#EMPID").val(data.EMPID);
                spf_initGrid();
                dialog.close();
            }
            function spf_selectCancel(item, dialog)
            {
                dialog.close();
            }
            function spf_selectClear(item, dialog)
            {
                $("#EMPID_NAME").val("");
                $("#EMPID").val("");
                dialog.close();
            }
        /*
        *弹出框收缩js
        */
        $(function ()
                {
                    $("#BT_WA_EMPID_NAME").ligerComboBox({
                        onBeforeOpen: spf_selectWAEmp, valueFieldID: 'BTWAEMPID',width:150
                    });
                });
        function spf_selectWAEmp()
                {
                    $.ligerDialog.open({
                        title: '<spring:message code="employee.information"/>',
                        name:'winselector'+Math.random(),
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
        function spf_selectWAOK(item, dialog)
                {
                    var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
                    var data = fn();
                    if (!data)
                    {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                        return;
                    }
                    $("#BT_WA_EMPID_NAME").val(data.EMPID+","+data.CHINESENAME);
                    $("#BTWAEMPID").val(data.EMPID);
                    dialog.close();
                }
    function spf_selectWACancel(item, dialog)
                {
                    dialog.close();
                }
    function spf_selectWAClear(item, dialog)
                {
                    $("#BT_WA_EMPID_NAME").val("");
                    $("#BTWAEMPID").val("");
                    dialog.close();
                }
            /*
            *弹出框收缩js
            */
    function spf_application(){
        if(spf_checkData()){
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/ess/infoApp/addBTApp",
                [
                        { name: 'EMPID', value: $("#EMPID").val() },
                        { name: 'BT_FROM_TIME', value: $("#BT_FROM_TIME").val() },
                        { name: 'BT_TO_TIME', value: $("#BT_TO_TIME").val() },
                        { name: 'BT_TYPE_CODE', value: $("#BT_TYPE_CODE").val() },
                        { name: 'BT_CONTENT', value: $("#BT_CONTENT").val() },
                        { name: 'BT_WA_EMPID', value: $("#BTWAEMPID").val() },
                        { name: 'TIME_STAMP', value: $("#TIME_STAMP").val() },
                        { name: 'BT_CITY', value: $("#IDCARD_CITY").val()},
                        { name: 'BT_PROVINCE', value: $("#IDCARD_PROVINCE").val()},
                        { name: 'appType', value: 'BTApply'}
                    ],
        function (result){
            $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        $("#BT_FROM_TIME").val('');
                        $("#BT_TO_TIME").val('');
                        $("#BT_CONTENT").val('');
                        $("#BT_WA_EMPID_NAME").val('');
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_checkData() {
        var btContent = $("#BT_CONTENT").val();
        var btTypeCode = $("#BT_TYPE_CODE").val();
        var btCity = $("#IDCARD_CITY").val();
        var btProvice = $("#IDCARD_PROVINCE").val();
        var btFromTime = $("#BT_FROM_TIME").val();
        var btToTime = $("#BT_TO_TIME").val();

        if (btFromTime == null || btFromTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startedTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (btToTime == null || btToTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if ($("#BTWAEMPID").val() == $("#EMPID").val()) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '代理人不能是本人！') ;
            return false;
        }
        if (btTypeCode == null || btTypeCode == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.btType"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (btCity == null || btCity == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.btCity"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (btTypeCode == "BT2" && btProvice != "100000") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.btType"/>'+". " + '<spring:message code="hrms.btCity"/>'+". " + '<spring:message code="hrms.inconsistent"/>') ;
            return false;
        }
        if (btTypeCode == "BT1" && btProvice == "100000") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.btType"/>'+". " + '<spring:message code="hrms.btCity"/>'+". " + '<spring:message code="hrms.inconsistent"/>') ;
            return false;
        }
        if (btContent == null || btContent == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingContent"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        return true;
    }

    function f_ChildWindowClose (){
        $grid.loadData(true);
    }

    function getApp (){
        spf_initGrid();
    }
</script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<%@ include file="/resources/js/pcc.jsp"%>
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
                                code="hrms.btApplication" /></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message
                                    code="hrms.application" /></a></td>
                    </tr>
                </table>
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td width="15%" class="l-table-edit-t"><spring:message
                                    code="hrms.EmpSearch" /></td>
                            <td width="35%" class="l-table-edit-c"><c:if
                                    test="${isSupervisor}">
                                    <input type="text" name="EMPID_NAME" id="EMPID_NAME"
                                        value="${basicInfo.CHINESENAME}" validate="{required:true}"
                                        onclick="foncation();" />
                                    <input type="hidden" name="EMPID" id="EMPID"
                                        value="${basicInfo.EMPID}" />
                                    <input type="hidden" name="TIME_STAMP" id="TIME_STAMP"
                                        value="${timeStamp}" />
                                </c:if> <c:if test="${!isSupervisor}">
                                    <input type="hidden" name="EMPID" id="EMPID"
                                        value="${basicInfo.EMPID}" />
                                    ${basicInfo.EMPID}
                            </c:if></td>
                            <td width="15%" class="l-table-edit-t"><spring:message
                                    code="hrms.applicant" /></td>
                            <td width="35%" class="l-table-edit-c">
                                ${basicInfo.CHINESENAME}</td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.startedTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="BT_FROM_TIME" id="BT_FROM_TIME"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})" />
                            </td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.endTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="BT_TO_TIME" id="BT_TO_TIME"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})" />
                            </td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.workingAgent" /></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="BT_WA_EMPID_NAME" id="BT_WA_EMPID_NAME" value="" /> <input
                                type="hidden" name="BTWAEMPID" id="BTWAEMPID" value="" /></td>
                            <td class="l-table-edit-t"><spring:message code="hrms.btType" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="BTTypeCode" name="BT_TYPE_CODE"
                                    onChange="getApp();" limit="all" /></td>
                        </tr>
                    </table>
                </form>
                <br>
                <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t">
                            <spring:message code="hrms.btCity" /><font color="red">*</font></td>
                        <td width="85%" class="l-table-edit-c" colspan="3" nowrap="nowrap">
                            <select name="IDCARD_PROVINCE" id="IDCARD_PROVINCE"
                            onChange="getArea('city','IdCard','');">
                        </select> <select name="IDCARD_CITY" id="IDCARD_CITY"
                            onChange="getArea('county','IdCard','');">
                                <option value="">
                                    <spring:message code="hrms.selection" />
                                </option>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message
                                code="hrms.workingContent" /><font color="red">*</font></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="height: 100px; width: 600px" id=BT_CONTENT
                                name="BT_CONTENT" validate="{required:true}"></textarea></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
