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
<link rel="stylesheet" type="text/css" href="/resources/css/jquery.jqzoom.css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src='/resources/js/jquery/jquery.jqzoom-core.js'></script>

<script type="text/javascript">
    var $dialog;
    $(function() {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
    });

    var tab = parent.tab;
    function spf_afterRemove() {
        $dialog.close();
        tab.removeSelectedTabItem();
        if (tab.isTabItemExist('mat0101')) {
            tab.reload('mat0101');
        }
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout2 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 0px">
    <div id="layout2">
        <div align="center">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;">物料信息</td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="15%" class="l-table-edit-cc" rowspan="6" style="cursor: pointer;"><c:if test="${materialDetail.photoPath!=null}">
                            <a href="${materialDetail.photoPath}/big.jpg" class="wenjunImage"> <img src="${materialDetail.photoPath}/small.jpg" id="headImage"
                                onerror="this.src='/resources/picture/none.gif'" width="100" height="120" />
                            </a>
                        </c:if> <c:if test="${materialDetail.photoPath==null}">
                            <img src="${materialDetail.photoPath}/small.jpg" id="headImage" onerror="this.src='/resources/picture/none.gif'" width="100" height="120" />
                        </c:if></td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">编号</td>
                    <td width="25%" class="l-table-edit-c">${materialDetail.no }
                    <td width="20%" class="l-table-edit-t">名称</td>
                    <td width="20w%" class="l-table-edit-c">${materialDetail.name }
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">旧名称</td>
                    <td width="20%" class="l-table-edit-c">${materialDetail.oldName }</td>
                    <td width="20%" class="l-table-edit-t">商务名称</td>
                    <td width="20%" class="l-table-edit-c">${materialDetail.bpName }</td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">物料类型</td>
                    <td width="20%" class="l-table-edit-c">${materialDetail.processRunning.type.name }</td>
                    <td width="20%" class="l-table-edit-t">物料状态</td>
                    <td width="20%" class="l-table-edit-c">${materialDetail.processRunning.state.name }</td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t"><spring:message code="mat.Unit" /></td>
                    <td width="20%" class="l-table-edit-c" colspan="3">${materialDetail.unit.name}</td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">物料描述</td>
                    <td width="80%" class="l-table-edit-c" colspan="3">${materialDetail.description }</td>
                </tr>
            </table>
            <br>
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;">详细信息</td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">

                <tr>
                    <td width="20%" class="l-table-edit-t">净重</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.netWeight }</td>
                    <td width="20%" class="l-table-edit-t">毛重</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.roughWeight }</td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">长</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.length }</td>
                    <td width="20%" class="l-table-edit-t">宽</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.width }</td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">高</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.height }</td>
                    <td width="20%" class="l-table-edit-t"></td>
                    <td width="30%" class="l-table-edit-c"></td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">重量单位</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.weightUnit.name}</td>
                    <td width="20%" class="l-table-edit-t">长度单位</td>
                    <td width="30%" class="l-table-edit-c">${materialDetail.lengthUnit.name}</td>
                </tr>
            </table>
            <br />
        </div>
    </div>
    <div id="matRelatedInfo"><%@include file="matRelatedInfo.jsp"%></div>
</body>
</html>

