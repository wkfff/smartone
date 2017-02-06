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
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    var $dialog;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
    });
    function spf_save() {
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.post("/ess/password/updatePassword", [ {
                name : 'ADMINID',
                value : $("#ADMINID").val()
            }, {
                name : 'PASSWORD',
                value : $("#PASSWORD").val()
            }, {
                name : 'NEW_PASSWORD',
                value : $("#NEW_PASSWORD").val()
            }, {
                name : 'C_PASSWORD',
                value : $("#C_PASSWORD").val()
            } ], function(result) {
                $.ligerDialog.closeWaitting();
                if (result == "Y") {
                    $.ligerDialog.success('<spring:message code="newPassword.okay.loginAgain"/>', '<spring:message code="hrms.warning"/>', function() {
                        parent.parent.location.href = "/login/out";
                        parent.f_ChildWindowClose();
                    });
                } else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_checkData() {
        var password = $("#PASSWORD").val();
        var newPassword = $("#NEW_PASSWORD").val();
        var cPassword = $("#C_PASSWORD").val();

        if (password == null || password == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="current.password"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }

        if (newPassword == null || newPassword == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="new.password"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if (cPassword == null || cPassword == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="confirmation.password"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if (newPassword != null && newPassword != "" && cPassword != null && cPassword != "" && newPassword != cPassword) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="newPassword.confirmationPassword"/>');
            $("#NEW_PASSWORD").attr("value", "");
            $("#C_PASSWORD").attr("value", "");
            return false;
        }

        if (newPassword != null || newPassword != "") {
            if (newPassword.length < 6) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="password6"/>' + ". " + '<spring:message code="input.required"/>');
                return false;
            }
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
            <form name="form1" method="post" action="" id="form1">
                <table width="100%" border="0">
                    <tr>
                        <td height="2"></td>
                    </tr>
                    <tr>
                        <td width="50px;" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                        <td width="100px;" align="left" style="font-weight: bold;"><spring:message code="change.password" /></td>
                        <td align="right">&nbsp;</td>
                        <td align="right" height="30px;"></td>
                    </tr>
                </table>
                <table width="100%" border="0" style="margin-left: 5%;">
                    <tr>
                        <td width="100px;" class="l-table-edit-t"><spring:message code="hrms.empid" /></td>
                        <td class="l-table-edit-c" colspan="2">
                            <input id="aid" value="${admin.adminID}" readonly="readonly"/>
                            <input type="hidden" name="ADMINID" id="ADMINID" value="${admin.adminID}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.cName" /></td>
                        <td class="l-table-edit-c" colspan="2">
                            <input id="aname" value="${admin.chineseName}" readonly="readonly"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="current.password" /></td>
                        <td class="l-table-edit-c" colspan="2"><input type="password" name="PASSWORD" id="PASSWORD" value="" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="new.password" /></td>
                        <td class="l-table-edit-c" colspan="2"><input type="password" name="NEW_PASSWORD" id="NEW_PASSWORD" value="" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="confirmation.password" /></td>
                        <td class="l-table-edit-c" colspan="2"><input type="password" name="C_PASSWORD" id="C_PASSWORD" value="" /></td>
                    </tr>
                    <tr height="10px;"></tr>
                </table>
                <table width="50%" border="0" style="margin-left: 250px;">
                    <tr>
                        <td></td>
                        <td><a id="savePsw" class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                            onclick="spf_save()">保存</a></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>