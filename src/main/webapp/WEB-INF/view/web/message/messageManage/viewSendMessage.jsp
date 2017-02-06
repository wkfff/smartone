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
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
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

    $(function() {

        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#messageInfoList").ligerGrid({
            columns : [ {
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
                width : '340',
                frozen : true,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="prostor.published"/>',
                name : 'CREATE_DATE',
                width : '200',
                frozen : true
            } ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            parms : [ {
                name : 'OWNER',
                value : ""
            } ],
            url : "/message/messageManage/getMessageList",
            pageSize : 10,
            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
            width : '99.8%',
            height : '500'
        });
    }

    function spf_changeMessageType() {
        if ($("#MESSAGE_TYPE").val() == "DEPTID") {
            spf_clear();
            $("#deptDiv").siblings().hide().end().show();
        } else {
            $("#deptDiv").hide();
            spf_clear();
            if ($("#MESSAGE_TYPE").val() == "SCREEN_GRANT_ID") {
                $.ligerDialog.open({
                    title : '<spring:message code="prostor.theRoleOfInformation"/>',
                    name : 'winselector' + Math.random(),
                    width : 800,
                    height : 450,
                    url : '/utility/roleInfo/searchRole',
                    buttons : [ {
                        text : '<spring:message code="okay"/>',
                        onclick : spf_selectOK
                    }, {
                        text : '<spring:message code="cancel"/>',
                        onclick : spf_selectCancel
                    } ]
                });
            } else {
                spf_clear();
                $("#deptDiv").siblings().hide().end().hide();
            }
        }
        ;

    }

    function spf_clear() {
        $("#SCREEN_GRANT_ID").val("");
        $("#ROLE_NAME").val("");
        $("#DEPTID").val("");
        $("#DEPTIDtree").val("");
    }

    function spf_afterSave() {
        spf_clear();
        $("#MESSAGE_TITLE").val("");
        $("#MESSAGE_CONTENT").val("");
        $("#MESSAGE_TYPE").val("");
        $("#empsTable").html("");
        $("#deptDiv").hide();
        $("#roleDiv").hide();
    }

    function spf_selectOK(item, dialog) {
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $("#DEPTID").val("");
        $("#DEPTIDtree").val("");
        $("#roleDiv").siblings().hide().end().show();

        $("#SCREEN_GRANT_ID").val(data.SCREEN_GRANT_ID);
        $("#ROLE_NAME").val(data.SCREEN_GRANT_NAME);

        dialog.close();
    }
    function spf_selectCancel(item, dialog) {
        dialog.close();
    }

    function spf_choseEmp() {
        $.ligerDialog.open({
            title : '<spring:message code="hrms.empInfo"/>',
            name : 'winselector' + Math.random(),
            width : 800,
            height : 450,
            url : '/utility/empInfo/viewHrSearchEmployee',
            buttons : [ {
                text : '<spring:message code="okay"/>',
                onclick : spf_initSelectEmpInfo2
            }, {
                text : '<spring:message code="cancel"/>',
                onclick : spf_selectCancel2
            } ]
        });
    }

    function spf_initSelectEmpInfo2(item, dialog) {
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        var temp = '<tr height="30"><td width="50"></td><td>'
                + data.CHINESENAME
                + ',['
                + data.EMPID
                + ']'
                + '<input class="empidClass" type="hidden" value="'+data.EMPID+'"/></td><td align="right"><a class="removeEmpClass" onclick="spf_removeEmp(this)"><spring:message code="prostor.remove"/></a></td></tr>';
        $("#empsTable").append(temp);

        dialog.close();
    }
    function spf_selectCancel2(item, dialog) {
        dialog.close();
    }
    function spf_removeEmp(a) {
        $(a).parent().parent().remove();
    }

    function spf_sendMessage() {
        if ($("#MESSAGE_CONTENT").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.Pleasefillinmessage"/>');
            return;
        }
        if ($("#MESSAGE_TYPE").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.Pleaseselectmessage"/>');
            return;
        }

        var $emp = $(".empidClass");
        var jsonData = '[';
        for (var i = 0; i < $emp.length; i++) {
            if (jsonData.length > 1) {
                jsonData += ',{';
            } else {
                jsonData += '{';
            }
            jsonData += ' "EMPID": "' + $emp[i].value + '"';
            jsonData += '}';
        }
        jsonData += ']';

        if ($("#MESSAGE_TYPE").val() == "DEPTID" && $("#DEPTID").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.Pleaseselectsend"/>');
            return;
        } else if ($("#MESSAGE_TYPE").val() == "SCREEN_GRANT_ID" && $("#SCREEN_GRANT_ID").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.Pleaserolesend"/>');
            return;
        } else if ($("#MESSAGE_TYPE").val() == "EMPID") {
            if (jsonData.length == 2) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.pleaseaddstaftosend"/>');
                return;
            }
        }
        $("#MESSAGE_CONTENT").text($("#MESSAGE_CONTENT").val().replace(/\n/g, ""));
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/message/messageManage/sendMessageInfo", [ {
            name : 'MESSAGE_TITLE',
            value : $("#MESSAGE_TITLE").val()
        }, {
            name : 'MESSAGE_CONTENT',
            value : $("#MESSAGE_CONTENT").val()
        }, {
            name : 'MESSAGE_TYPE',
            value : $("#MESSAGE_TYPE").val()
        }, {
            name : 'DEPTID',
            value : $("#DEPTID").val()
        }, {
            name : 'SCREEN_GRANT_ID',
            value : $("#SCREEN_GRANT_ID").val()
        }, {
            name : 'jsonData',
            value : jsonData
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                    spf_afterSave();
                    $grid.loadData(true); //加载数据 
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
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
    width: 100%;
    margin: 0;
    padding: 0;
}

#messageTable td {
    font-size: 14px;
}

select {
    width: 100px;
}

#DEPTID {
    width: 150px;
}

.removeEmpClass {
    display: block;
    width: 35px;
    height: 25px;
    margin-right: 5px;
    color: green;
    text-decoration: none;
    line-height: 25px;
    text-align: center;
    cursor: pointer;
}

select {
    width: 150px;
}
</style>
</head>
<body style="padding: 2px">
    <div style="width: 800px; margin: 0 auto;">
        <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="95%" align="left" style="font-weight: bold;"><spring:message code="prostor.Newsrelease" /></td>
            </tr>
        </table>
        <br />
        <table id="messageTable" style="margin: 0 auto; width: 800px;">
            <tr>
                <td width="50"><spring:message code="prostor.title" />:</td>
                <td width="750" align="right"><input id="MESSAGE_TITLE" name="MESSAGE_TITLE" type="text" style="width: 750px; height: 20px;" /></td>
            </tr>
            <tr height="70">
                <td width="50"><spring:message code="prostor.content" />:</td>
                <td><textarea id="MESSAGE_CONTENT" name="MESSAGE_CONTENT" style="width: 750px; height: 50px;"></textarea></td>
            </tr>
        </table>
        <table width="800" style="margin: 0 auto; font-size: 14px;">
            <tr>
                <td width="50"><spring:message code="hrms.type" />:</td>
                <td width="150" align="left"><SipingSoft:selectMessageType name="MESSAGE_TYPE" limit="all" /></td>
                <td width="500" align="center"><label id="deptDiv" style="display: none;"><SipingSoft:deptTree name="DEPTID" /></label> <label id="roleDiv" style="display: none;"> <input
                        type="text" id="ROLE_NAME" name="ROLE_NAME" disabled="disabled" style="width: 150px; background-color: white; color: black; border: 1px solid #A3C0E8; font-size: 14px;" /> <input
                        type="hidden" id="SCREEN_GRANT_ID" name="SCREEN_GRANT_ID" />
                </label></td>
                <td width="100" align="right"><a class="l-button" style="width: 79px; height: 20px;" onclick="spf_sendMessage()"> <spring:message code="prostor.Newsrelease" />
                </a></td>
            </tr>
            <tr height="10">
                <td colspan="4"></td>
            </tr>
        </table>
        <div style="background-color: #d9e8fb; font-size: 14px; width: 800px; margin: 0 auto;">
            <a style="display: block; line-height: 30px; width: 80px; height: 30px; margin-left: 3px; cursor: pointer; text-decoration: none; color: black;" href="javascript:spf_choseEmp()"><spring:message
                    code="prostor.addRecipient" /></a>
            <table style="width: 100%; font-size: 12px; background-color: #ecf4fd;" id="empsTable">
            </table>
        </div>
        <div style="margin-top: 20px; width: 800px;">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="95%" align="left" style="font-weight: bold;"><spring:message code="prostor.historyrecordsreleased" /></td>
                </tr>
            </table>
            <div id="messageInfoList"></div>
        </div>
    </div>
</body>
</html>
