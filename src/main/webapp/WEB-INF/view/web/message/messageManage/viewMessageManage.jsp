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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    var $grid;
    $.ligerDefaults.Grid.editors['textarea'] = {
        create : function(container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue : function(input, editParm) {
            return input.val();
        },
        setValue : function(input, value, editParm) {
            input.val(value);
        },
        resize : function(input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width)
                input.width(column.editor.width);
            else
                input.width(width);
            if (column.editor.height)
                input.height(column.editor.height);
            else
                input.height(height);
        }
    };
    // 初始调用
    $(function() {
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#messageListDiv").ligerGrid({
            columns : [ {
                display : '',
                name : 'MESSAGE_NO',
                width : '',
                frozen : true,
                hide : 1
            }, {
                display : '<spring:message code="prostor.newsTitle"/>',
                name : 'MESSAGE_TITLE',
                width : '120',
                frozen : true,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="prostor.messageType"/>',
                name : 'MESSAGE_TYPE_NAME',
                width : '120',
                frozen : true
            }, {
                display : '<spring:message code="prostor.messageContent"/>',
                name : 'MESSAGE_CONTENT',
                width : '300',
                frozen : true,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="prostor.publisher"/>',
                name : 'ENAME',
                width : '100',
                frozen : true
            }, {
                display : '<spring:message code="prostor.published"/>',
                name : 'CREATE_DATE',
                width : '200',
                frozen : true
            }, ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            url : "/message/messageManage/getMessageList",
            pageSize : 10,
            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
            width : '99.8%',
            height : '500'
        });
    }

    function spf_search() {
        $grid.setOptions({
            parms : [ {
                name : 'keyWord',
                value : $("#keyWord").val()
            }, {
                name : 'MESSAGE_TYPE_ID',
                value : $("#MESSAGE_TYPE_ID").val()
            } ],
            newPage : 1
        });
        $grid.loadData(true);
    }

    function spf_delete() {
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        if (row.length > 1) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>');
            return;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>', '<spring:message code="hrms.warning"/>', function(yes) {
            if (yes) {
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post("/message/messageManage/deleteMessage", [ {
                    name : 'MESSAGE_NO',
                    value : row.MESSAGE_NO
                } ], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            $grid.loadData(true); //加载数据 
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
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

#showProductDetailDiv {
    display: none;
}

#hrSearchEmp {
    margin-top: 5px;
}

select {
    width: 120px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t" width="15%"><spring:message code="keyWord" /></td>
                    <td class="l-table-edit-c" width="35%"><input type="text" name="keyWord" id="keyWord" style="width: 120px;" /></td>
                    <td class="l-table-edit-t" width="15%"><spring:message code="prostor.messageType" /></td>
                    <td class="l-table-edit-c" width="35%"><SipingSoft:selectMessageType name="MESSAGE_TYPE_ID" limit="all" /></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px"><SipingSoft:button /></td>
                </tr>
            </table>

        </div>
        <div id="messageListDiv"></div>
    </div>
</body>
</html>
