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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $dialog;
    var $grid;

    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            topHeight : 32,
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        spf_initGrid();
    });

    //限额休假
    function spf_initGrid() {
        $grid = $("#familyInfo").ligerGrid({
            checkbox : false,
            columns : [ {
                display : '',
                name : 'MENU_CODE',
                width : 10,
                hide : 1
            }, {
                display : '<spring:message code="hrms.empid"/>',
                name : 'EMPID',
                width : 120,
                frozen : true
            }, {
                display : '<spring:message code="hrms.shortcutMenu"/>',
                name : 'MENU_INTRO',
                width : 180,
                frozen : true
            }, {
                display : '<spring:message code="hrms.active"/>',
                name : 'STATUS_NAME',
                width : 180,
                frozen : true
            }, {
                display : '<spring:message code="hrms.add"/>',
                name : 'MENU_CODE',
                width : 60,
                frozen : true,
                render : function(row, index) {
                    if (row.STATUS_CODE == 0) {
                        return '<img style="cursor: pointer;" src="/resources/images/add.gif" onclick="spf_save(' + row.EMPID + ',' + row.MENU_NO + ')" >';
                    } else {
                        return '';
                    }
                }
            }, {
                display : '<spring:message code="hrms.delete"/>',
                name : 'RDelete',
                width : 60,
                frozen : true,
                render : function(row, index) {
                    if (row.STATUS_CODE == 1) {
                        return '<img style="cursor: pointer;" src="/resources/images/delete.gif" onclick="spf_delete(' + row.EMPID + ',' + row.MENU_NO + ')" >';
                    } else {
                        return '';
                    }
                }
            } ],
            enabledEdit : false,
            usePager : true,
            rownumbers : true,
            url : "/myhome/getShort",
            width : '99.6%',
            height : '100%'
        });
    }

    function spf_delete(empID, menuNo) {
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>', '<spring:message code="hrms.warning"/>', function(yes) {
            if (yes) {

                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post("/login/deleteShortcutInfo", [ {
                    name : 'EMPID',
                    value : empID
                }, {
                    name : 'MENU_NO',
                    value : menuNo
                } ], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            parent.f_ChildWindowClose();
                            $grid.loadData(true); //加载数据
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
    }
    function spf_save(empID, menuNo) {
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/login/saveShortcutInfo", [ {
            name : 'EMPID',
            value : empID
        }, {
            name : 'MENU_NO',
            value : menuNo
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                    parent.f_ChildWindowClose();
                    $grid.loadData(true); //加载数据
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
    }
    function spf_search() {
        $grid.setOptions({
            parms : [ {
                name : 'MENU_CODE',
                value : $("#MENU_CODE").val()
            }, {
                name : 'STATUS_CODE',
                value : $("#STATUS_CODE").val()
            } ],
            newPage : 1
        }); //设置数据参数
        $grid.loadData(true); //加载数据
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
        <div position="top">
            <table width="100%" border="0">
                <tr>
                    <td height="2"></td>
                </tr>
                <tr>
                    <td align="center" valign="middle">
                        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="menu.main" /></td>
                                <td class="l-table-edit-c"><SipingSoft:selectMenu name="MENU_CODE" limit="all" onChange="spf_search()" /></td>
                                <td class="l-table-edit-t"><spring:message code="hrms.active" /></td>
                                <td class="l-table-edit-c"><SipingSoft:selectStatus name="STATUS_CODE" limit="all" onChange="spf_search()" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div position="center" id="familyInfo"></div>
    </div>
</body>
</html>
