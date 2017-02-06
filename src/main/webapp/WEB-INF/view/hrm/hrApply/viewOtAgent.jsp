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
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid ;
    $(function (){
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,      //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
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

    function searchEmp() {
        $dialog = $.ligerWindow.show({
            isDrag : false,
            title : '<spring:message code="employee.information"/>',
            width : 800,
            height : 400,
            left : 160,
            top : 90,
            url : '/utility/empInfo/viewHrSearchEmployee'
        });
    }

    function spf_application(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
            $.post("/ess/infoApp/addOvertimeApp",
                    [
                        { name: 'EMPID', value: $("#EMPID").val() },
                        { name: 'OT_FROM_TIME', value: $("#OT_FROM_TIME").val() },
                        { name: 'OT_TO_TIME', value: $("#OT_TO_TIME").val() },
                        { name: 'OT_TYPE_CODE', value: $("#OT_TYPE_CODE").val() },
                        { name: 'OT_DEDUCTION', value: $("#OT_DEDUCTION").val() },
                        { name: 'OT_CONTENT', value: $("#OT_CONTENT").val() },
                        { name: 'appType', value: 'OtApply'}
                    ]
        , function (result) {
            $.ligerDialog.closeWaitting();
                if (result == "Y") {
                    $.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>','<spring:message code="hrms.warning"/>', function (){
                        $("#OT_FROM_TIME").val('');
                        $("#OT_TO_TIME").val('');
                        $("#OT_CONTENT").val('');
                    });
                } else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }

    function spf_checkData() {
        var otContent = $("#OT_CONTENT").val();
        var otTypeCode = $("#OT_TYPE_CODE").val();
        var otFromTime = $("#OT_FROM_TIME").val();
        var otToTime = $("#OT_TO_TIME").val();

        if (otFromTime == null || otFromTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startedTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (otToTime == null || otToTime == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endTime"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (otTypeCode == null || otTypeCode == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.otType"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (otContent == null || otContent == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingContent"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        return true;
    }
    //查看开始日期的班次情况
    function spf_reviewShift_start(){
        var ot_from_time = $("#OT_FROM_TIME").val();
        var ot_time = ot_from_time.substring(0,10);
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.workingShift.information"/>',
            width: 820,
            height: 200,
            url: '/ess/infoApp/searchEmpShift?OT_DATE=' + ot_time +'&EMPID='+$("#EMPID").val()
        });
    }
    //查看结束日期的班次情况
    function spf_reviewShift_end(){
        var ot_end_time = $("#OT_TO_TIME").val();
        var ot_time = ot_end_time.substring(0,10);
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.workingShift.information"/>',
            width: 820,
            height: 200,
            url: '/ess/infoApp/searchEmpShift?OT_DATE=' + ot_time +'&EMPID='+$("#EMPID").val()
        });
    }
    function spf_initSelectEmpInfo(data) {
        $("#EMPID").attr("value", data.EMPID);
        var url = (location.href).split("?");
        var _url = url[1].split("&");
        location.href = url[0] + "?" + _url[0] + "&EMPID=" + data.EMPID;
//      $dialog.close();
    }
    function f_ChildWindowClose (){
        $grid.loadData(true); //加载数据
    }
    function getApp (){
        spf_initGrid();
    }

    function spf_showOTInfo(){
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'加班信息',
            width: $("#layout1").width()-60,
            height: $("#layout1").height()-60,
            url: '/ess/viewApp/viewOtInfoApp?MENU_CODE=ess0607'
        });
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
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="5%" align="center"><img
                                src="/resources/images/title/top_1.gif" /></td>
                            <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                    code="hrms.otApplication" /></td>
                            <td width="5%" align="right">&nbsp;</td>
                            <td align="right" height="30px;"><a class="l-button"
                                style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                                onclick="spf_application()"><spring:message code="hrms.application" /></a></td>
                        </tr>
                    </table>
                    <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t" width="15%"><spring:message
                                    code="hrms.EmpSearch" /></td>
                            <td width="35%" class="l-table-edit-c" nowrap="nowrap">
                                <input type="text" name="EMPID_NAME" id="EMPID_NAME" value="${basicInfo.CHINESENAME}" />
                                <input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }" />
                            </td>
                            <td class="l-table-edit-t" width="15%"><spring:message
                                    code="hrms.applicant" /></td>
                            <td class="l-table-edit-c" width="35%">${basicInfo.CHINESENAME}</td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.startedTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c">
                                <table>
                                    <tr>
                                        <td align="left" class="l-table-edit-c">
                                            <input type="text" name="OT_FROM_TIME" id="OT_FROM_TIME"
                                        onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                        validate="{required:true}" />
                                        </td>
                                        <td align="right">
                                            <span onClick="spf_reviewShift_start();" style="cursor: pointer; font-weight: bold; font-size: 12px;">
                                                <!--  班次--> <spring:message code="hrms.workingShift.information" />
                                        </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.endTime" /><font color="red">*</font></td>
                            <td class="l-table-edit-c">
                                <table>
                                    <tr>
                                        <td align="left" class="l-table-edit-c">
                                            <input type="text" name="OT_TO_TIME" id="OT_TO_TIME"
                                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                                validate="{required:true}" />
                                        </td>
                                        <td align="right">
                                            <span onClick="spf_reviewShift_end();" style="cursor: pointer; font-weight: bold; font-size: 12px;">
                                                <spring:message code="hrms.workingShift.information" />
                                        </span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.otType" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode
                                    parentCode="OTTypeCode" name="OT_TYPE_CODE"
                                    selected="WorkingOtType01" onChange="getApp();" limit="all" />
                            </td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.deductionHours" /></td>
                            <td class="l-table-edit-c"><SipingSoft:selectDeduction name="OT_DEDUCTION" onChange="getApp();" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.workingContent" /><font color="red">*</font></td>
                            <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                    cols="" style="height: 100px; width: 600px" id="OT_CONTENT"
                                    name="OT_CONTENT" validate="{required:true}"></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>