<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var $checkListInfo;
    $(function() {
        f_initGrid();
        $("#ENAME").ligerComboBox({
            onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
        });
    });
    function f_initGrid() {
        $checkListInfo = $("#showCheckListInfo").ligerGrid({
            columns : [ {
                display : '审核类型',
                name : 'TYPE_NAME',
                width : '150'
            }, {
                display : '审核人ID',
                name : 'EMPID',
                width : '200'
            }, {
                display : '审核人姓名',
                name : 'ENAME',
                width : '200'
            }, {
                display : '状态',
                name : 'CHECK_KEY',
                width : '200',
                render: function (item){
                    if(item.CHECK_KEY == 0 ){
                        return '<p style="color: red;">关闭</p>';
                    }else{
                        return '<p style="color: green;">启用</p>';
                    }
                }
            }],
            usePager : true,
            rownumbers : true,
            url : "/system/checkSettings/getCheckedListInfo",
            width : '99.8%',
            height : '95%'
        });
    }
function spf_add(){
    $("#TYPE").val('save');
    $("#ENAME").val('');
    $("#EMPID").val('');
    $("#checkType").val('');
    $('#eidtInfo').show(500);
}
function spf_cancelEditInfo(){
    $('#eidtInfo').hide(500);
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
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel},
                    { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                ]
    });
    return false;
}
function spf_selectOK(item, dialog){
    var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
    var data = fn();
    $("#ENAME").val(data.CHINESENAME);
    $("#EMPID").val(data.EMPID);
    dialog.close();
}
function spf_selectCancel(item, dialog){
    dialog.close();
}
function spf_selectClear(item, dialog){
    $("#ENAME").val("");
    $("#EMPID").val("");
    dialog.close();
}
function spf_save(){
    var checkType = $("#checkType").val();
    var empid = $("#EMPID").val();
    var typeFlag = $("#TYPE").val();
    var type_no = $("#TYPE_NO").val();
    var check_key = $("#typeStatus").val();
    if(checkType==""){
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','请选择类型');
        return;
    }
    if(empid==""){
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','请选择审核人');
        return;
    }
    if(check_key==""){
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','请选择状态');
        return;
    }
    $.ajax({
        type: 'post',
        url: '/system/checkSettings/saveOrUpdateCheckedType',
        data:{CHECKTYPE:checkType,EMPID:empid,TYPE:typeFlag,TYPE_NO:type_no,CHECK_KEY:check_key},
        dataType: 'json',
        async: false,
        success: function (returnMsg){
            $.ligerDialog.closeWaitting();
            if (returnMsg == "Y"){
                $.ligerDialog.success('保存成功','<spring:message code="hrms.warning"/>');
                $checkListInfo.loadData(true);
            }else{
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', returnMsg);
            }
        }
    });
}
function spf_update(){
    var row = $checkListInfo.getSelectedRow();
    if (!row || row.length == 0) {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
        return;
    }
    $("#ENAME").val(row.ENAME);
    $("#EMPID").val(row.EMPID);
    $("#checkType").val(row.TYPE_ID);
    $("#TYPE").val('update');
    $("#TYPE_NO").val(row.TYPE_NO);
    $("#typeStatus").val(row.CHECK_KEY);
    $('#eidtInfo').show(500);
}
function spf_delete(){
    var row = $checkListInfo.getSelectedRow();
    if (!row || row.length == 0) {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
        return;
    }
    $.ligerDialog.confirm('确定删除吗?','<spring:message code="hrms.warning"/>', function (yes){
        if(yes){
            $.ajax({
                type: 'post',
                url: '/system/checkSettings/deleteCheckedType',
                data:{TYPE_NO:row.TYPE_NO},
                dataType: 'json',
                async: false,
                success: function (returnMsg){
                    $.ligerDialog.closeWaitting();
                    if (returnMsg > 0){
                        $.ligerDialog.success('删除成功','<spring:message code="hrms.warning"/>');
                        $checkListInfo.loadData(true);
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '删除失败');
                    }
                }
            });
        }
    });
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
#eidtInfo{
    display: none;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <table cellpadding="0" cellspacing="0" class="l-table-edit" height="50">
            <tr>
                <td align="left"><SipingSoft:button /></td>
            </tr>
        </table>
        <div id="eidtInfo">
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1" bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t">审核类型</td>
                    <td class="l-table-edit-c">
                        <SipingSoft:selectCheckType name="checkType" limit="all"/>
                        <input type="hidden" name="TYPE" id="TYPE"/>
                        <input type="hidden" name="TYPE_NO" id="TYPE_NO"/>
                    </td>
                    <td class="l-table-edit-t">审核人</td>
                    <td class="l-table-edit-c">
                        <input width="120" name="ENAME" id="ENAME" type="text" style="height:20px;"/>
                        <input type="hidden" name="EMPID" id="EMPID"/>
                    </td>
                    <td class="l-table-edit-t">状态</td>
                    <td class="l-table-edit-c">
                        <select id="typeStatus" >
                            <option value="">请选择</option>
                            <option value="1">启用</option>
                            <option value="0">关闭</option>
                        </select>
                    </td>
                </tr>
            </table>
            <br>
            <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 20px; font-size: 12px;">
                <tr>
                    <td class="l-table-edit-c" width="92.5%">&nbsp;&nbsp;&nbsp;</td>
                    <td class="l-table-edit-c" width="7%">
                        <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; 
                            " onclick="spf_cancelEditInfo()">取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <div id="showCheckListInfo"></div>
    </div>
</body>
</html>