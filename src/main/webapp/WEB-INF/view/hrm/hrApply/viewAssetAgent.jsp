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
    $(function () {
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
        $("#TOOL_TYPE_CODE").ligerComboBox({
            onBeforeOpen: spf_selectTool, valueFieldID: 'TOOL_NO', width:150
        });
    });

    function spf_previewTool(){
            $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.itemsLendingConditions"/>',
            width: 620,
            height: 200,
            url: '/ass/assInfo/viewBorrowRecord?ASSET_ID='+ $("#TOOL_TYPE_CODE").val()
        });
    }

    function spf_selectTool(){
        $.ligerDialog.open({
            title: '<spring:message code="hrms.assetsList"/>',
            name:'winselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/toolInfo/searchTool',
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectOK2 },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel2 },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectClear2 }
                    ]
        });
        return false;
    }

    function spf_selectOK2(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return ;
        }
        $("#TOOL_TYPE_CODE").val(data.ASSET_NAME);
        $("#TOOL_NO").val(data.ASSET_NO);
        dialog.close();
    }
    function spf_selectCancel2(item, dialog){
        dialog.close();
    }
    function spf_selectClear2(item, dialog){
        $("#TOOL_TYPE_CODE").val("");
        dialog.close();
    }
    function spf_initGrid(){
        $grid = $("#affirmorInfo").ligerGrid({
        checkbox: false,
            columns: [
            { display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',hide:1},
            { display: '<spring:message code="hrms.name"/>', name: 'AFFIRMOR_NAME'},
            { display: '<spring:message code="hrms.approvalLevel"/>', name: 'AFFIRM_LEVEL'}
            ],
            usePager: false, rownumbers:true,
            url: '/ess/infoApp/getAffirmorList?appType=OtApply',
            parms: [{ name: 'EMPID', value: $("#EMPID").attr('value')},
                    { name: 'TOOL_TYPE_CODE', value: $("#TOOL_TYPE_CODE").attr('value')},
                    { name: 'BORROW_DATE', value: $("#BORROW_DATE").attr('value')},
                    { name: 'TOOL_FROM_TIME', value: $("#TOOL_FROM_TIME").attr('value')},
                    { name: 'RETURN_DATE', value: $("#RETURN_DATE").attr('value')},
                    { name: 'TOOL_TO_TIME', value: $("#TOOL_TO_TIME").attr('value')}
                ],
            width: '99.6%', height: '100%'
        });
    }

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

    function spf_application(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
            $.post("/ess/infoApp/addToolApp",
                [
                    { name: 'EMPID', value: $("#EMPID").val()},
                    { name: 'ASSET_NO', value: $("#TOOL_NO").val()},
                    { name: 'BORROW_DATE', value: $("#BORROW_DATE").val() },
                    { name: 'RETURN_DATE', value: $("#RETURN_DATE").val() },
                    { name: 'TOOL_TYPE_CODE', value: $("#TOOL_TYPE_CODE").val() },
                    { name: 'TOOL_CONTENT', value: $("#TOOL_CONTENT").val() },
                    { name: 'TOOL_REMARK', value: $("#TOOL_REMARK").val() },
                    { name: 'appType', value: 'ToolApply'}
                ],
            function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.applicationSuccessful"/>','<spring:message code="hrms.warning"/>', function (){
                        spf_showToolInfo();
                        $("#BORROW_DATE").val('');
                        $("#RETURN_DATE").val('');
                        $("#TOOL_REMARK").val('');
                        $("#TOOL_CONTENT").val('');
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_showToolInfo(){
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.itemInformation"/>',
            width: $("#layout1").width()-60,
            height: $("#layout1").height()-60,
            url: '/ess/viewApp/viewToolInfoApp?MENU_CODE=ess0602'
        });
    }
    function spf_checkData(){
        var borrowDate = $("#BORROW_DATE").val();
        var toolContent = $("#TOOL_CONTENT").val();
        var TOOL_TYPE_CODE = $("#TOOL_TYPE_CODE").val();

        if (borrowDate == null || borrowDate == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.borrowingDate"/>'+"." + '<spring:message code="input.required"/>');
            return false;
        }
        if (TOOL_TYPE_CODE == null || TOOL_TYPE_CODE == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.pleaseSelectTheBorrowedItems"/>');
            return false;
        }
        if (toolContent == null || toolContent == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.pleaseFillInTheReasonToBorrow"/>');
            return false;
        }
        return true;
    }
    function spf_initSelectEmpInfo(data) {
        $("#EMPID").attr("value", data.EMPID);
        var url = (location.href).split("?");
        var _url = url[1].split("&");
        location.href = url[0] + "?" + _url[0] + "&EMPID=" + data.EMPID;
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
    var tab = parent.tab;
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
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="hrms.itemsLoanApplication"/></td>
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
                            <td class="l-table-edit-t" width="15%"><spring:message code="hrms.borrowItems"/><font color="red">*</font></td>
                            <td class="l-table-edit-c" width="35%">
                                <table>
                                    <tr>
                                    <!--    <td class="l-table-edit-c"><SipingSoft:selectAssetID name="TOOL_TYPE_CODE" limit="all"/></td>  -->
                                        <td><input type="text" name="TOOL_TYPE_CODE" id="TOOL_TYPE_CODE" value=""/>
                                            <input type="hidden" name="TOOL_NO" id="TOOL_NO" value="" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="l-table-edit-t"><spring:message code="hrms.borrowingDate"/><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="BORROW_DATE" id="BORROW_DATE" value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                validate="{required:true}" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message code="hrms.expectedReturnDate"/></td>
                            <td class="l-table-edit-c" colspan="3"><input type="text"
                                name="RETURN_DATE" id="RETURN_DATE" value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                                validate="{required:true}" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message code="hrms.reasonToBorrow"/><font color="red">*</font></td>
                            <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                    cols="" style="height: 50px; width: 600px" id="TOOL_CONTENT"
                                    name="TOOL_CONTENT" validate="{required:true}"></textarea></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
                            <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                    cols="" style="height: 50px; width: 600px" id="TOOL_REMARK"
                                    name="TOOL_REMARK"></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
