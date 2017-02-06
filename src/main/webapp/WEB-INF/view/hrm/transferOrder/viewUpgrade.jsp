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
$(function (){
    $("#EMP_NAME").ligerComboBox({
        onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
    });
    spf_getPostLevel();
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
    $("#STATUS_CODE").val(data.STATUS_CODE);
    $("#POST_ID").val(data.POST_ID);
    $("#DEPTID").val(data.DEPTID);
    spf_getPostLevel();
    $("#POST_LEVEL").val(data.POST_LEVEL_ID);
    dialog.close();
}
function spf_selectCancel(item, dialog){
    dialog.close();
}
function spf_selectClear(item, dialog){
    $("#EMP_NAME").val('');
    $("#EMPID").val('');
    $("#STATUS_CODE").val('');
    $("#POST_ID").val('');
    $("#DEPTID").val('');
    $("#POST_LEVEL").val('');
    dialog.close();
}   
function spf_application(){
    if(spf_checkData()){
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/hrm/transferOrder/saveTransferOrder",
            [
                { name: 'EMPID', value: $("#EMPID").val() },
                { name: 'DEPTID', value: $("#DEPTID").val() },
                { name: 'POST_ID', value: $("#POST_ID").val() },
                { name: 'STATUS_CODE', value: $("#STATUS_CODE").val() },
                { name: 'START_DATE', value: $("#START_DATE").val() },
                { name: 'TRANS_CODE', value: '${TRANS_CODE}' },
                { name: 'TRANS_NO', value: '${TRANS_NO}' },
                { name: 'REMARK', value: $("#REMARK").val() },
                { name: 'TYPE', value: 'upgrade'},
                { name: 'POST_LEVEL_ID', value: $("#POST_LEVEL").val()}
            ],
        function (result){
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
    if ($("#DEPTID").val() == null || $("#DEPTID").val() == "") {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '部门'+". " + '<spring:message code="input.required"/>') ;
        return false;
    }
    if ($("#POST_LEVEL").val() == null || $("#POST_LEVEL").val() == "") {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '职位等级'+". " + '<spring:message code="input.required"/>') ;
        return false;
    }
    if ($("#START_DATE").val() == null || $("#START_DATE").val() == "") {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startedTime" />'+". " + '<spring:message code="input.required"/>') ;
        return false;
    }
    return true;
}
function spf_refresh(){
    location.href="/hrm/transferOrder/viewUpgrade?MENU_CODE=hr0202";
}
function spf_getPostLevel(){
    if ($("#POST_ID").val() != "") {
        $.ajax({
            type:'post',
            cache : false,
            async : false,
            contentType : 'application/json',
            url : '/hrm/position/getPostLevelDataInfo?POST_ID='+$("#POST_ID").val(),
            dataType : 'json',
            success : function(data) {
                var temp = "<select name='POST_LEVEL' id='POST_LEVEL' style='width: 120px;height:20px;font-size: 12px;'>";
                var temp = temp + "<option value=''>"+'<spring:message code="hrms.selection" />'+"</option>";
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp+"<option value=\""+item.POST_GRADE_ID+"\">"+item.POST_GRADE_NAME+"</option>";
                    }
                )
                temp = temp+"</select>";
                /* var levels = document.getElementById("POST_LEVEL");
                alert(levels.innerHTML); */
                $("#levelSpan").html(temp);
            },
            error : function() {
                $.ligerDialog.error('Send Error');
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
            <div position="top">
                <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.upgrade" /></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message code="hrms.application" /></a></td>
                    </tr>
                </table>
                <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.EmpSearch" /></td>
                        <td class="l-table-edit-c" width="35%"><input type="text" name="EMP_NAME" id="EMP_NAME" value="" validate="{required:true}" /> <input type="hidden" name="EMPID"
                            id="EMPID" value="" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.dept" /><font color="red">*</font></td>
                        <td width="35%" class="l-table-edit-c">
                            <%-- <SipingSoft:deptTree name="DEPTID"/> --%> <SipingSoft:selectDept name="DEPTID" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.EmpStatus" /><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="35%"><SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE" /></td>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.post" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><SipingSoft:selectPost name="POST_ID" onChange="spf_getPostLevel()" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.startedTime" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><input type="text" name="START_DATE" id="START_DATE"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})" validate="{required:true}" /></td>
                        <td class="l-table-edit-t"><spring:message code="hrms.jobLevel" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><span id="levelSpan"> <select name="POST_LEVEL" id="POST_LEVEL" style="width: 200px; height: 23px; font-size: 12px;">
                                    <option value="">
                                        <spring:message code="hrms.selection" />
                                    </option>
                            </select>
                        </span></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.remarks" /></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows="" cols="" style="height: 100px; width: 600px" id="REMARK" name="REMARK"></textarea></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
