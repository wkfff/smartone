<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<script type="text/javascript">
    var $grid;
    var $dialog;
    var $CurrencyUnitSelectList;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        $("#navtab1").ligerTab({
            onAfterSelectTabItem : function(tabid) {
                if (tabid == "tabitem1") {
                    spf_material_initGrid();
                }
            }
        });
        spf_material_initGrid();
    });

    function spf_material_initGrid() {
        $docgrid = $("#docInfo").ligerGrid({
            columns : [ {
                display : '物料编号',
                name : 'OBJ_ID',
                width : 150
            }, {
                display : '文档编号',
                name : 'DOC_ID',
                width : 150
            }, {
                display : '查看文档',
                width : 200,
                render : function(item) {
                    return '<div style="cursor: pointer;" onClick="spf_viewDocumentDetail(\'' + item.DOC_ID + '\')">查看文档</div>';
                }
            } ],
            usePager : false,
            rownumbers : true,
            fixedCellHeight : true,
            url : '/doc/docInfo/getDocObjectList?objectNo=${materialDetail.no}',
            parms : [ {
                name : 'OBJ_TYPE',
                value : 'MAT'
            } ],
            onDblClickRow : function(rowdata, rowindex, rowDomElement) {
                spf_viewDocumentDetail(rowdata.DOC_ID);
            },
            width : '99.6%',
            height : '100%',
        });
    }

    function spf_viewDocumentDetail(DOC_NO) {
        if (tab.isTabItemExist('doc0102')) {
            tab.removeTabItem('doc0102');
        }
        tab.addTabItem({
            tabid : 'doc0102',
            text : '文档信息',
            url : '/doc/docInfo/viewDocumentDetail?MENU_CODE=doc0102&docNo=' + DOC_NO
        });
    }
</script>

<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout3 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout3" id='' title=' '>
        <div position="center" id='' title=' ' style="border: 0px;">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;">相关信息</td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <div align="left" style="heigth: 30%">
                <div id="navtab1">
                    <div title='文档相关'>
                        <div id="docInfo"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>