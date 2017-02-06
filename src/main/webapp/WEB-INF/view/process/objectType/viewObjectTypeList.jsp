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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $tree = null;
    var $returnTypeSelectList;
    //扩展一个 多行文本框 的编辑器
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
        $("#layout1").ligerLayout({
            leftWidth : 180
        });
        $tree = $("#objectTypeTree").ligerTree({
            method : 'POST',
            url : '/process/objectType/getObjectTypeList',
            checkbox : false,
            idFieldName : 'no',
            parentIDFieldName : 'parentNo',
            textFieldName : 'name',
            nodeWidth : 150,
            checkbox : false,
            onSelect : onSelect
        });
    });
    function onSelect(node) {
        if (node.data.parentType.no == '0')
            return;
        document.getElementById("objectTypeInfoFrame").src = '/process/objectType/viewObjectTypeDetail?MENU_CODE=process0101&typeNo=' + node.data.no;
    }
    var tab = parent.tab;
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
<body style="padding: 0px">
    <div id="layout1">
        <div position="left" id="shiftList" class="l-scroll" style="height: 95%; overflow: auto;" title="<spring:message code="process.typeList"/>">
            <!--不带复选框-->
            <ul id="objectTypeTree"></ul>
        </div>
        <div position="center" class="l-tab-content" id='shiftParameterInfo' title="<spring:message code="process.typeOfInformation"/>">
            <div id="objectTypeInfo" style="width: 100%; height: 100%; color: #000000;">
                <iframe id="objectTypeInfoFrame" frameborder="no" border="no" style="width: 100%; height: 100%; color: #000000;"> </iframe>
            </div>
        </div>
    </div>
</body>
</html>
