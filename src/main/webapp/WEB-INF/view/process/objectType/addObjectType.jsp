<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function() {
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
    });

    var tab = parent.tab;

    function spf_save() {
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');

            var $typeJson = {};
            $typeJson.name = $("#OBJECT_TYPE_NAME").val();
            $typeJson.active = false;
            $typeJson.description = $("#DESCRIPTION").val();
            $typeJson.parentType = {};
            $typeJson.parentType.no = $("#PARENT_TYPE_NO").val();

            $.post("/process/objectType/transferObjectType", [{
                name : 'jsonData',
                value : JSON.stringify($typeJson)
            }], function(result) {
                $.ligerDialog.closeWaitting();
                if (result.code == '0') {
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                        spf_refresh(result.message);
                    });
                } else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                }
            });
        }
    }
    function spf_checkData()
    {
        if ($("#OBJECT_TYPE_NAME").val() == null || $("#OBJECT_TYPE_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="process.typeName"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        return true;
    }

    function spf_refresh(OBJECT_TYPE_NO) {
        if (tab.isTabItemExist('process0102')) {
            tab.removeTabItem('process0102');
        }
        if (tab.isTabItemExist('process0101')) {
            tab.removeTabItem('process0101');
        }
        tab.addTabItem({
            tabid : 'process0101',
            text : '<spring:message code="process.typeList"/>',
            url : '/process/objectType/viewObjectTypeList?MENU_CODE=process0101'
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
</style>
</head>
<body style="padding: 2px">
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.basicInfo" /></td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><SipingSoft:button /></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="20%" class="l-table-edit-t"><spring:message code="process.typeName" /><font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c"><input type="text" name="OBJECT_TYPE_NAME" id="OBJECT_TYPE_NAME" value="" size="30" /></td>
                <td width="20%" class="l-table-edit-t"><spring:message code="process.theirType" /></td>
                <td width="30%" class="l-table-edit-c"><SipingSoft:selectObjectType name="PARENT_TYPE_NO" parentTypeNo="0" /></td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t"><spring:message code="process.typeDescription" /></td>
                <td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3"><textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION"></textarea></td>
            </tr>
        </table>
    </div>
</body>
</html>
