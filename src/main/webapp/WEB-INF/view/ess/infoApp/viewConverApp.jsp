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
// GET THE DATA OF THIS EMPLOEE
var START_DATE = null
var REMARK = ''
var statusName = '${statusName}'
var applyStatus = ${applyStatus}
// 0申请中1申请成功2申请失败3未申请
$(function ()
{
    $("#layout1").ligerLayout({
        allowLeftResize: false,      //是否允许 左边可以调整大小
        allowRightResize: false,     //是否允许 右边可以调整大小
        allowTopResize: false,      //是否允许 头部可以调整大小
        allowBottomResize: false     //是否允许 底部可以调整大小
    });
});

function spf_application(){
    if(spf_checkData()){
        if(statusName != '正式'){
            if(applyStatus == 3){
                $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
                $.post("/ess/infoApp/submitTransfer",
                    [   
                        { name: 'EMPID', value: $("#EMPID").val() },
                        { name: 'DEPTID', value: $("#DEPTID").val() },
                        { name: 'POST_ID', value: $("#POST_ID").val() },
                        { name: 'STATUS_CODE', value: 'EmpStatus2' },
                        { name: 'START_DATE', value: $("#START_DATE").val() },
                        { name: 'TRANS_CODE', value: '${TRANS_CODE}' },
                        { name: 'TRANS_NO', value: '${TRANS_NO}' },
                        { name: 'REMARK', value: $("#REMARK").val() },
                        { name: 'TYPE', value: 'upgrade'},
                        { name: 'POST_LEVEL_ID', value: $("#POST_LEVEL").val()},
                        { name: 'CON_PER', value: $("#CON_PER").val()}
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
            }else if(applyStatus == 0){
                alert('您已经提交申请，请耐心等待！')
            }else if(applyStatus == 1){
                alert('您已经申请成功！')
            }else{
                alert('您的申请被拒绝！')
            }
        }else{
            alert('您已经是正式员工！')
        }
    }
}

function spf_refresh(){
    location.href="/ess/infoApp/viewConverApp?MENU_CODE=hr0217";
}

function spf_checkData(){
    if ($("#CON_PER").val() == null || $("#CON_PER").val() == "") {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '合同年限'+". " + '<spring:message code="input.required"/>') ;
        return false;
    }
    if ($("#START_DATE").val() == null || $("#START_DATE").val() == "") {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startedTime" />'+". " + '<spring:message code="input.required"/>') ;
        return false;
    }
    return true;
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
                        <td width="25%" align="left" style="font-weight: bold;"><span>转正申请</span></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message code="hrms.application" /></a></td>
                    </tr>
                </table>
                <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.EmpSearch" /></td>
                        <td class="l-table-edit-c" width="35%"><input type="text" name="EMP_NAME" id="EMP_NAME" value="${basicInfo.CHINESENAME}" validate="{required:true}" readonly="true" /> <input type="hidden" name="EMPID"
                            id="EMPID" value="${basicInfo.EMPID}" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.dept" /><font color="red">*</font></td>
                        <td width="35%" class="l-table-edit-c">
                             <!-- <SipingSoft:selectDept name="DEPTID" /> -->
                             <input type="text" name="DEPARTNAME" id="DEPARTNAME" value="${basicInfo.DEPTNAME}" validate="{required:true}" readonly="true"/> 
                             <input type="hidden" name="DEPTID"
                            id="DEPTID" value="${basicInfo.DEPTID}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.EmpStatus" /><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="35%"><!-- <SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE" /></td> -->
                        <input type="text" name="STATUS_NAME" id="STATUS_NAME" value="转正" validate="{required:true}" readonly="true"/> 
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.post" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><!-- <SipingSoft:selectPost name="POST_ID" onChange="spf_getPostLevel()" /> -->
                            <input type="text" name="POST_NAME" id="POST_NAME" value="${basicInfo.POST_NAME}" validate="{required:true}" readonly="true"/>
                            <input type="hidden" name="POST_ID"
                            id="POST_ID" value="${basicInfo.POST_ID}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="hrms.startedTime" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><input type="text" name="START_DATE" id="START_DATE"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})" validate="{required:true}" /></td>
                        <td class="l-table-edit-t"><spring:message code="hrms.jobLevel" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><span id="levelSpan"> <!-- <select name="POST_LEVEL" id="POST_LEVEL" style="width: 200px; height: 23px; font-size: 12px;">
                                    <option value="">
                                        <spring:message code="hrms.selection" />
                                    </option>
                            </select> -->
                            <input type="text" name="POST_GRADE_NAME" id="POST_GRADE_NAME" value="${basicInfo.POST_GRADE_NAME}" validate="{required:true}" readonly="true" />
                            </span></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><span>合同年限</span><font color="red">*</font></td>
                        <td class="l-table-edit-c"><span id="levelSpan"> <select name="CON_PER" id="CON_PER" style="width: 200px; height: 23px; font-size: 12px;">
                                <option value="1">1年</option>
                                <option value="2">2年</option>
                                <option value="3">3年</option>
                                <option value="4">4年</option>
                                <option value="5">5年</option>
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
