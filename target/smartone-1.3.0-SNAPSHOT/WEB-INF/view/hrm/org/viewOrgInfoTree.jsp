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
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    var $deptTree;
    var tab = parent.tab;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            leftWidth : 180
        });
        $deptTree = $("#deptTree").ligerTree({
            url : '/hrm/org/getOrgInfoTreeList',
            checkbox : false,
            idFieldName : 'DEPTID',
            parentIDFieldName : 'PARENT_DEPT_ID',
            textFieldName : 'DEPTNAME',
            topParentIDValue : '',
            isexpandFieldName : 'ISEXPAND',
            onSelect: onSelect
        });
    });
    
    function onSelect(node){
        document.getElementById("orgInfoFrame").src = '/hrm/org/viewDeptInfo?MENU_CODE=hr0602&DEPTNO=' + node.data.DEPTNO;
    }
    
    function spf_refresh(){
        location.href="/hrm/org/viewOrgInfoTree?MENU_CODE=hr0602";
    }
    
    function spf_add(){
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
            width: $("#layout1").width()-60, height: $("#layout1").height()-60, url: '/hrm/org/addDeptInfo'
        });
    }
</script>
<!-- CSS -->
<style type="text/css">
    .OrgBox {
        font-size: 12px;
        padding: 5px 5px 5px 5px;
        clear: left;
        float: left;
        text-align: center;
        position: absolute;
        background-image: url(http://www.on-cn.cn/tempimg/org.jpg);
        width: 70px;
        height: 106px;
    }
    .OrgBox img {
        width: 60px;
        height: 70px;
    }
    .OrgBox div {
        color: #FFA500;
        font-weight: 800;
    }
</style>

<style type="text/css">
    body {
        padding: 5px;
        margin: 0;
        padding-bottom: 15px;
    }
    #layout1 {
        width: 99.6%;
        margin: 0;
        padding: 0;
    }
    .l-page-top {
        height: 80px;
        background: #f8f8f8;
        margin-bottom: 3px;
    }
    h4 {
        margin: 20px;
    }
</style>
</head>

<body style="padding: 0px">
    <div id="layout1">
        <div position="left" id="orgList" class="l-scroll"
            style="height: 95%; overflow: auto;" title="部门列表&nbsp;&nbsp;<a href='javascript:spf_add()'>添加</a>">
            <!--不带复选框-->
            <ul id="deptTree"></ul>
        </div>
        <div position="center" id='orgInfo' title="部门信息">
            <!--不带复选框-->
            <div id="orgInfo" position="center" style="width: 100%; height: 100%; color: #000000;">
                <iframe id="orgInfoFrame" frameborder="no" border="no"
                    style="width: 100%; height: 100%; color: #000000;"></iframe>
            </div>
        </div>
    </div>
</body>

</html>
