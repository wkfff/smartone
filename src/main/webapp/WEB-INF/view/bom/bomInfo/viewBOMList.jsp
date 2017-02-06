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
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $grid = null ;
    var $returnTypeSelectList ;
    $(function () {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#bomInfo").ligerGrid({
            columns: [
                { display: '<spring:message code="bom.bomNumber"/>', name: 'id', width: 150},
                { display: '<spring:message code="hrms.materialNumber"/>', name: 'material.id', width: 150},
                { display: '<spring:message code="bom.bomType"/>', name: 'processRunning.type.name', width: 150},
                { display: '<spring:message code="bom.bomStatus"/>', name: 'processRunning.state.name', width:150},
                { display: '<spring:message code="bom.description"/>', name: 'description', width: 220 },
                { display: '<spring:message code="hrms.detailedInformation"/>',  width: 120,
                    render: function (item) {
                       return '<div style="cursor: pointer;" onClick="spf_viewBOMDetail(\''+item.no+'\')"><spring:message code="hrms.clickToView"/></div>';
                    }
                }
            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/bom/bomInfo/getBOMList',
            parms: [
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewBOMDetail(rowdata.no);
            }
        });
    }
    var tab = parent.tab;
    function spf_viewBOMDetail(BOM_NO){
        if(tab.isTabItemExist('bom0102')){
            tab.removeTabItem('bom0102');
        }
        tab.addTabItem({ tabid : 'bom0102',text: '<spring:message code="bom.information"/>', url: '/bom/bomInfo/viewBOMDetail?MENU_CODE=bom0102&bomNo='+BOM_NO });
    }

    function spf_add(){
        if(tab.isTabItemExist('bom0201')){
            tab.removeTabItem('bom0201');
        }
        tab.addTabItem({ tabid : 'bom0201',text: '<spring:message code="bom.addBom"/>', url: '/bom/bomManage/addBOM?MENU_CODE=bom0201' });
    }

    function spf_update(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        if(tab.isTabItemExist('bom0202')){
            tab.removeTabItem('bom0202');
        }
        tab.addTabItem({ tabid : 'bom0202',text: '<spring:message code="bom.editBom"/>', url: '/bom/bomManage/updateBOM?MENU_CODE=bom0202&bomNo='+row.no });
    }

    function spf_delete() {
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '确定删除BOM结构信息？', function(result) {
            if (result) {
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/bom/bomManage/removeBOM', [ {
                    name : 'bomNo',
                    value : row.no
                }], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == 0) {
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            spf_search();
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                    }
                });
            }
        });
    }

    function spf_search() {
        $grid.setOptions({ parms: [
                        { name: 'keyWord', value: $("#keyWord").attr('value')},
                        { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                        { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                        { name: 'BOM_STATUS_NO', value: $("#BOM_STATUS_NO").attr('value')},
                        { name: 'BOM_TYPE_NO', value: $("#BOM_TYPE_NO").attr('value')}
                       ],
               newPage: 1
             }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function spf_afterRemove(){
        $dialog.close();
        $grid.loadData(true); //加载数据
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
    <div id="layout1">
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord" type="text" id="keyWord" size="30" /></td>
                        <td class="l-table-edit-t"><spring:message code="hrms.createDate" /></td>
                        <td class="l-table-edit-c"><input type="text" name="S_DATE" id="S_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /> ~ <input type="text"
                            name="E_DATE" id="E_DATE" value="" size="25" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="bom.bomType" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectObjectType name="BOM_TYPE_NO" parentTypeNo="4" onChange="spf_search()" limit="all" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="bom.bomStatus" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="BOM_STATUS_NO" objectTypeNo="4" onChange="spf_search()" limit="all" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='bomInfo'></div>
        </div>
    </div>
</body>
</html>
