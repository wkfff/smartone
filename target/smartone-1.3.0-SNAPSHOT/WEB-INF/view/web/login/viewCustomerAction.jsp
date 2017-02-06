<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/dateString.js" type="text/javascript"></script>
<script type="text/javascript">
    var $actiongrid = null ;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm) {
            return input.val();
        },
        setValue: function (input, value, editParm) {
            input.val(value);
        },
        resize: function (input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    function initCustAction () {
        //布局
        $("#actionlayout").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    }

    function f_initGrid() {
        var today = new Date();
        var sDate = dateString(today.getTime());
        var eDate = dateString(today.getTime()+3*(24*60*60*1000));
        $actiongrid = $("#customerActionInfo").ligerGrid({
            onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
            },
            columns: [
                { display: '', name: 'CUST_ACTION_NO', width: 0,hide: 1},
                { display: '', name: 'EMP_ID', width: 0,hide: 1},
                { display: '', name: 'CUST_ID', width: 0,hide: 1},
                { display: '业务人员', name: 'EMP_NAME', width: 90,frozen:true},
                { display: '活动时间', name: 'CUST_ACTION_TIME', width: 120, frozen:true},
                { display: '活动类型', name: 'ACTION_TYPE', width: 120, frozen:true},
                { display: '客户名称', name: 'CUST_NAME', width: 140},
                { display: '活动方式', name: 'CUST_ACTION_WAY', width: 100},
                { display: '活动内容', name: 'CUST_ACTION_CONTENT', width: 160},
                { display: '状态', name: 'CUST_ACTION_STATE', width: 90 }
            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/cust/custAction/getCustomerActionList',
            parms: [
                { name: 'S_DATE', value: sDate},
                { name: 'E_DATE', value: eDate},
                { name: 'REMINDER', value: 1},
            ],
            width: '99.6%', height: '100%'
            });
    }

    </script>

<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#actionlayout {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="actionlayout">
        <div position="center" id='' title=' '>
            <div position="top">
                <input type="hidden" name = "ADMIN_ID" id = "ADMIN_ID" value = "${admin.adminID}">
                <input type="hidden" name = "ADMIN_NAME" id = "ADMIN_NAME" value = "${admin.chineseName}">
            </div>
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px; ">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                    <td width="25%" align="left" style="font-weight: bold;"> 待办事项 </td>
                    <td width="65%" align="right">
                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <div position="center" id='customerActionInfo'></div>
        </div>
    </div>
</body>
</html>
