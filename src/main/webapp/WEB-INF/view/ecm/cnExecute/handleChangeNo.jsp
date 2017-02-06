<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    var $tree;
    var $data;
    $(function() {
        $("#layout1").ligerLayout({
            leftWidth : 180
        });
        spf_initCNList();
    });

    var tab = parent.tab;

    var spf_initCNList = function() {
        $.post('/ecm/cnInfo/getChangeNoList', {}, function(result) {
            $tree = $("#changeNoTree").ligerTree({
                data : result.Rows,
                checkbox : false,
                parentIcon : null,
                childIcon : null,
                idFieldName : 'no',
                parentIDFieldName : 'id',
                textFieldName : 'id',
                topParentIDValue : '',
                isexpandFieldName : '',
                nodeWidth : 150,
                checkbox : false,
                onSelect : onSelect
            });
        });
    }

    var spf_showCNDetail = function(node) {
        $("#cnInfoFrame").attr('src', '/ecm/cnExecute/viewChangeNoDetail?changeNo=' + node.data.no);
    }

    function onSelect(node) {
        spf_showCNDetail(node);
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 0px">
    <div id="layout1">
        <div position="left" id="shiftList" class="l-scroll" style="height: 95%; overflow: auto;" title="变更号列表">
            <ul id="changeNoTree"></ul>
        </div>
        <div position="center" class="l-tab-content" id='shiftParameterInfo' title="变更对象">
            <div id="salesInfo" style="width: 100%; height: 100%; color: #000000;">
                <iframe id="cnInfoFrame" frameborder="no" border="no" style="width: 100%; height: 100%; color: #000000;"> </iframe>
            </div>
        </div>
    </div>
</body>
</html>
