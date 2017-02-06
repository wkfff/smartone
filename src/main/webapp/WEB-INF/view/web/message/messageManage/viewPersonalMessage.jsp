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
        f_initGrid(1);
    });

    function f_initGrid(page) {
        $.ajax({
            type : 'post',
            cache : false,
            contentType : 'application/json',
            url : '/message/messageManage/getMyMessageList?IS_READ=1&page=' + page + '&pagesize=10',
            data : {
                IS_READ : '1'
            },
            dataType : 'json',
            async : false,
            success : function(data) {
                var jsonData = '[';

                var temp = '';
                $.each(data.Rows, function(i, item) {
                    temp = temp + '<div class="newTitle">' + '<table class="titleTable">' + '<tr height="25">' + '<td width="80" style="font-size:13px;font-weight:bold;" align="center">'
                            + item.MESSAGE_TYPE_NAME + ': </td>' + '<td width="500" style="font-size:12px;" align="left">' + item.MESSAGE_TITLE + '</td>' + '<td width="150" style="font-size:12px;">'
                            + item.SEND_DATE + '</td>' + '<td width="70" align="right"><a class="detailA" href="javascript:showContent(' + i + ')">详细&nbsp;</a></td>' + '</tr>' + '</table>' + '</div>'
                            + '<div class="newContent" id="content'+i+'">' + item.MESSAGE_CONTENT + '<br/>' + '<div style="width:800px;margin-right:5px;text-align:right;">发件人：' + item.CHINESENAME
                            + '&nbsp;&nbsp;</div>' + '</div>';
                    if (jsonData.length > 1) {
                        jsonData += ',{';
                    } else {
                        jsonData += '{';
                    }
                    jsonData += ' "MESSAGE_NO": "' + item.MESSAGE_NO + '",';
                    jsonData += ' "MESSAGE_TYPE_ID": "' + item.MESSAGE_TYPE_ID + '"';
                    jsonData += '}';
                });
                if (temp == '') {
                    $("#showNewsDiv").html("<label style='width:100%;display:block;line-height:25px;border:1px solid #ecf4fd;'>&nbsp;&nbsp;&nbsp;&nbsp;您暂时没有新短消息!</label>");
                } else {
                    $("#showNewsDiv").html(temp);
                }
                $("#currentPage").text(data.page.currentPage);
                $("#allCount").text(data.page.allCount);
                $("#prePage").attr("href", "javascript:f_initGrid(" + data.page.prePage + ")");
                $("#nextPage").attr("href", "javascript:f_initGrid(" + data.page.nextPage + ")");

                jsonData += ']';
                if (jsonData.length > 2) {
                    $.post("/message/messageManage/addReadMessage", [ {
                        name : 'jsonData',
                        value : jsonData
                    } ], function(result) {
                        if (result == "Y") {
                            //parent.spf_getMessages();
                        }
                    });
                }
            },
            error : function() {
                $.ligerDialog.error('获取最新消息失败');
            }
        });
    }

    function f_initHistoryGrid(page) {
        $.ajax({
            type : 'post',
            cache : false,
            contentType : 'application/json',
            url : '/message/messageManage/getMyMessageList?IS_READ=2&page=' + page + '&pagesize=10',
            dataType : 'json',
            async : false,
            success : function(data) {
                var jsonData = '[';

                var temp = '';
                $.each(data.Rows, function(i, item) {
                    temp = temp + '<div class="newTitle">' + '<table class="titleTable">' + '<tr height="25">' + '<td width="80" style="font-size:13px;font-weight:bold;" align="center">'
                            + item.MESSAGE_TYPE_NAME + ': </td>' + '<td width="500" style="font-size:12px;" align="left">' + item.MESSAGE_TITLE + '</td>' + '<td width="150" style="font-size:12px;">'
                            + item.SEND_DATE + '</td>' + '<td width="70" align="right"><a class="detailA" href="javascript:showContent2(' + i + ')">详细&nbsp;</a></td>' + '</tr>' + '</table>'
                            + '</div>' + '<div class="newContent" id="content2'+i+'">' + item.MESSAGE_CONTENT + '<br/>' + '<div style="width:800px;margin-right:5px;text-align:right;">发件人：'
                            + item.CHINESENAME + '&nbsp;&nbsp;</div>' + '</div>';
                });
                if (temp == '') {
                    $("#showHistoryDiv").html("<label style='width:100%;display:block;line-height:25px;border:1px solid #ecf4fd;'>&nbsp;&nbsp;&nbsp;&nbsp;历史记录为空!</label>");
                } else {
                    $("#showHistoryDiv").html(temp);
                }
                $("#currentPage").text(data.page.currentPage);
                $("#allCount").text(data.page.allCount);
                $("#prePage").attr("href", "javascript:f_initHistoryGrid(" + data.page.prePage + ")");
                $("#nextPage").attr("href", "javascript:f_initHistoryGrid(" + data.page.nextPage + ")");
            },
            error : function() {
                $.ligerDialog.error('获取历史消息失败');
            }
        });
    }

    function gotoNewMessage() {
        $("#historyMessage").hide();
        $("#newMessage").show();
        f_initGrid(1);
    }

    function gotoHistoryMessage() {
        $("#newMessage").hide();
        $("#historyMessage").show();
        f_initHistoryGrid(1);
    }

    function showContent(i) {
        if ($("#content" + i).css("display") == "none") {
            $("#content" + i).show();
        } else {
            $("#content" + i).hide();
        }
    }

    function showContent2(i) {
        if ($("#content2" + i).css("display") == "none") {
            $("#content2" + i).show();
        } else {
            $("#content2" + i).hide();
        }
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
    background-color: #f7fbfe;
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

.newTitle {
    width: 800px;
    height: 25px;
    background-color: #ecf4fd;
    line-height: 25px;
    margin-top: 10px;
}

.newContent {
    width: 800px;
    display: none;
    font-size: 12px;
    padding-top: 3px;
    padding-bottom: 3px;
    text-indent: 2em;
    border: 1px solid #ecf4fd;
}

.titleTable {
    width: 800px;
    border: 1px solid #ecf4fd;
}

.detailA {
    display: block;
    width: 40px;
    height: 25px;
    font-size: 11px;
    cursor: pointer;
    line-height: 25px;
    color: green;
    text-align: center;
    text-decoration: none;
}

.beforeTitle {
    font-size: 15px;
}

.titleLabel {
    font-size: 12px;
    height: 25px;
    text-align: center;
}

.contentLabel {
    font-size: 12px;
    font-family: '宋体';
    color: gray;
}

.tab {
    display: block;
    width: 90px;
    height: 25px;
    background-color: #ecf4fd;
    text-align: center;
    line-height: 25px;
    cursor: pointer;
}

.tab:hover {
    background-color: #f5edd7;
}

#pageDiv a {
    color: green;
}
</style>
</head>
<body style="padding: 2px">
    <div style="width: 1000px; height: 1000px; margin: 0 auto; border: 1px solid #ecf4fd; background-color: white;">
        <table width="1000" height="130" style="border-bottom: 1px solid #ecf4fd;">
            <tr>
                <td rowspan="3" width="180"><img src="/resources/picture/employee/${basicInfo.EMPID }.jpg" id="headImage" onerror="this.src='/resources/photo/none.gif'" width="130" height="130" />
                </td>
            </tr>
            <tr height="100">
                <td align="left" colspan="2" style="font-size: 14px;">姓名: ${basicInfo.CHINESENAME }</td>
            </tr>
            <tr>
                <td width="91"><label class="tab" onclick="gotoNewMessage()">最新消息</label></td>
                <td align="left"><label class="tab" onclick="gotoHistoryMessage()">历史消息</label></td>
            </tr>
        </table>
        <div style="width: 160px; float: left; background-color: #fffdf3; border: 1px solid #f0e4c0; padding-left: 1px; padding-top: 1px; margin-top: 20px;">
            <table>
                <tr>
                    <td style="width: 158px; height: 30px; background-color: #f5edd7; font-size: 15px;" align="center">个人信息</td>
                </tr>
            </table>
            <table width="158" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="40%" class="titleLabel" nowrap="nowrap"><spring:message code="hrms.empid" /></td>
                    <td width="60%" class="contentLabel" nowrap="nowrap">${basicInfo.EMPID }</td>
                </tr>
                <tr>
                    <td class="titleLabel" nowrap="nowrap"><spring:message code="hrms.name" /></td>
                    <td class="contentLabel" nowrap="nowrap">${basicInfo.CHINESENAME }</td>
                </tr>
                <tr>
                    <td class="titleLabel" nowrap="nowrap"><spring:message code="hrms.dept" /></td>
                    <td class="contentLabel" nowrap="nowrap">${basicInfo.DEPTNAME }</td>
                </tr>
                <tr>
                    <td class="titleLabel" nowrap="nowrap"><spring:message code="hrms.hireDate" /></td>
                    <td class="contentLabel" nowrap="nowrap">${basicInfo.JOIN_DATE }</td>
                </tr>
                <tr>
                    <td class="titleLabel" nowrap="nowrap"><spring:message code="hrms.post" /></td>
                    <td class="contentLabel" nowrap="nowrap">${basicInfo.POST_NAME }</td>
                </tr>

                <tr>
                    <td class="titleLabel" nowrap="nowrap"><spring:message code="hrms.EmpStatus" /></td>
                    <td class="contentLabel" nowrap="nowrap">${basicInfo.STATUS_NAME}</td>
                </tr>
                <tr height="10">
                    <td colspan="2">&nbsp;</td>
                </tr>
            </table>
        </div>
        <div style="width: 800px; float: left; padding-left: 20px;">

            <div id="newMessage">
                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="left"><img src="/resources/images/title/top_1.gif" /></td>
                        <td width="95%" align="left" style="font-weight: bold;">最新消息</td>
                    </tr>
                </table>

                <div id="showNewsDiv" style="width: 800px;"></div>
            </div>

            <div id="historyMessage" style="display: none;">
                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="left"><img src="/resources/images/title/top_1.gif" /></td>
                        <td width="95%" align="left" style="font-weight: bold;">历史消息</td>
                    </tr>
                </table>

                <div id="showHistoryDiv" style="width: 800px;"></div>

                <div id="pageDiv" style="width: 800px; height: 30px; text-align: center; margin-top: 50px;">
                    <a id="prePage" href="">上一页</a>&nbsp; 第<label id="currentPage"></label>页&nbsp; <a id="nextPage" href="">下一页</a>&nbsp; 共<label id="allCount"></label>条记录
                </div>
            </div>
        </div>
    </div>
</body>
</html>
