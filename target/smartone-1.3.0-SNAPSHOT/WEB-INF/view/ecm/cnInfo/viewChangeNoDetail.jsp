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
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/ecm/cnObjectList.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>

<script type="text/javascript">
    var $curgrid = null;
    var $documentgrid = null;
    var $materialgrid = null;
    var $bomgrid = null;

    $(function() {
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        spf_navTabGridInit();
        spf_navTabInit();
        $curgrid = $materialgrid;
    });

    function spf_navTabInit() {
        $("#navtab1").ligerTab({
            onAfterSelectTabItem : function(tabid) {
                if (tabid == "tabitem1") {
                    $curgrid = $documentgrid;
                    $curgrid.loadData(true);
                }
                if (tabid == "tabitem2") {
                    $curgrid = $bomgrid;
                    $curgrid.loadData(true);
                }
                if (tabid == "tabitem3") {
                    $curgrid = $materialgrid;
                    $curgrid.loadData(true);
                }
            }
        });
    }

    function spf_navTabGridInit() {
        $documentgrid = spf_object_initGrid('ecmDocumentInfo', 'DOC', '${changeNo.no}');
        $bomgrid = spf_object_initGrid('ecmBOMInfo', 'BOM', '${changeNo.no}');
        $materialgrid = spf_object_initGrid('ecmMaterialInfo', 'MAT', '${changeNo.no}');
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
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;">基本信息</td>
                <td width="65%" align="right">&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>

        <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="20%" class="l-table-edit-t">变更号<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c">
                    ${changeNo.no}</td>
                <td width="20%" class="l-table-edit-t"><spring:message
                        code="hrms.documentNumber" /></td>
                <td width="30%" class="l-table-edit-c"></td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">变更类型<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c">
                    ${changeNo.processRunning.type.name}</td>
                <td width="20%" class="l-table-edit-t">变更状态<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c">
                    ${changeNo.processRunning.state.name}</td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">起始日期<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c">
                    <fmt:formatDate value="${changeNo.startDate}" pattern="yyyy-MM-dd"/></td>
                <td width="20%" class="l-table-edit-t">结束日期</td>
                <td width="30%" class="l-table-edit-c">
                    <fmt:formatDate value="${changeNo.endDate}" pattern="yyyy-MM-dd"/></td>
            </tr>

        </table>
        <br>
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img
                    src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;">变更号信息</td>
                <td width="65%" align="right">&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <div id="businessInfo">
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
                class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="20%" class="l-table-edit-t">变更原因<font color="red">*</font></td>
                    <td width="85%" class="l-table-edit-c" nowrap="nowrap"><textarea
                            rows="2" cols="150" id="REASON" name="REASON">${changeNo.reason}</textarea>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">变更号描述</td>
                    <td width="85%" class="l-table-edit-c" nowrap="nowrap"><textarea
                            rows="2" cols="150" id="DESCRIPTION" name="DESCRIPTION">${changeNo.description}</textarea>
                    </td>
                </tr>
            </table>
            <!-- 修改对象列表 -->
            <table width="99.6%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;">对象列表</td>
                    <td width="65%" align="right">&nbsp;</td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <div align="left" style="heigth: 30%">
                <div id="navtab1">
                    <div title='修改文档'>
                        <div id="ecmDocumentInfo"></div>
                    </div>
                    <div title='修改BOM'>
                        <div id="ecmBOMInfo"></div>
                    </div>
                    <div title='修改物料'>
                        <div id="ecmMaterialInfo"></div>
                    </div>
                </div>
                </div>
            </div>
        </div>
</body>
</html>
