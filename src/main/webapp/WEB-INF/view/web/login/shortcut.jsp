<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        setTimeout('spf_shortInfo()', 2000);
    });
    function spf_shortInfo() {
        $.post('/login/getShortcutsInfo', function(back) {
            $("#shortInfo").html(back);
        });
    }
    function spf_add() {
        $dialog = $.ligerWindow.show({
            isDrag : true,
            title : '<spring:message code="hrms.add"/>',
            width : 800,
            height : 400,
            left : 120,
            top : 80,
            url : '/login/addShortcutInfo?EMPID=${basicInfo.EMPID}'
        });
    }
    function f_ChildWindowClose() {
        spf_shortInfo(); //加载数据
    }
    function spf_page(i, no) {
        $.post('/system/basicMaintenance/getMenuInfo', {
            "MENU_NO" : no
        }, function(backs) {
            $.post('/login/getMenuLoad', {
                "tid" : backs.split("-")[0]
            }, function(back) {
                $dialog = $.ligerWindow.show({
                    isDrag : true,
                    title : back,
                    width : 800,
                    height : 400,
                    left : 120,
                    top : 80,
                    url : backs.split("-")[1]
                });
            });
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
<body style="padding: 10px">
    <div id="layout1">
        <div align="center">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.shortcut" /></td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center" title='<spring:message code="hrms.shortcut"/>'><img style="cursor: pointer;" alt="" src="/resources/images/settings.gif" onclick="spf_add();" />
                    </td>
                    <td width="94.5%" align="center">
                        <div id="shortInfo"></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
