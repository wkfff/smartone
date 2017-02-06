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
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $grid = null ;
    var tab = parent.tab;
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
        $grid = $("#materialInfo").ligerGrid({
            columns: [
                { display: '<spring:message code="hrms.materialNumber"/>', name: 'id', width: 120},
                { display: '<spring:message code="mat.materialName"/>', name: 'name', width: 160},
                { display: '<spring:message code="mat.materialType"/>', name: 'processRunning.type.name', width: 120},
                { display: '<spring:message code="mat.materialStatus"/>', name: 'processRunning.state.name', width: 120},
                { display: '<spring:message code="mat.materialDescription"/>', name: 'description', width: 220, editor:{type:'textarea', height: 100}},
                { display: '<spring:message code="hrms.detailedInformation"/>', width: 90,
                    render: function (item) {
                       return '<div style="cursor: pointer;" onClick="spf_showDetail(\''+item.no+'\')"><spring:message code="hrms.clickToView"/></div>';
                    }
                }
            ],
            enabledEdit: true,
            usePager: true,
            rownumbers:true,
            pageSize:20,
            url: '/mat/matInfo/getMaterialList',
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_showDetail(rowdata.no);
            }
        });
    }
    function spf_showDetail(MAT_NO){
        if(tab.isTabItemExist('mat0102')){
            tab.removeTabItem('mat0102');
        }
        tab.addTabItem({ tabid : 'mat0102',text: '<spring:message code="mat.materialDetails"/>', url: '/mat/matInfo/viewMaterialDetail?matNo='+MAT_NO });
    }
    function spf_update(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        if(tab.isTabItemExist('mat0202')){
            tab.removeTabItem('mat0202');
        }
        tab.addTabItem({ tabid : 'mat0202',text: '<spring:message code="mat.updateMaterial"/>', url: '/mat/matManage/updateMaterial?MENU_CODE=mat0202&matNo='+row.no });
    }
    function spf_delete() {
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }

        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/mat/matManage/removeMaterial", [ {
            name : 'matNo',
            value : row.no
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result.code == 0) {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                    $grid.loadData(true);
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
            }
        });
    }

    function spf_add(){
        if(tab.isTabItemExist('mat0201')){
            tab.removeTabItem('mat0201');
        }
        tab.addTabItem({ tabid : 'mat0201',text: '<spring:message code="mat.addMaterial"/>', url: '/mat/matManage/addMaterial?MENU_CODE=mat0201' });
    }
    function spf_search() {
        $grid.setOptions({ parms: [
               { name: 'keyWord', value: $("#keyWord").attr('value')},
               { name: 'E_DATE', value: $("#E_DATE").attr('value')},
               { name: 'S_DATE', value: $("#S_DATE").attr('value')},
               { name: 'MAT_TYPE_NO', value: $("#MAT_TYPE_NO").attr('value')},
               { name: 'MAT_STATUS_NO', value: $("#MAT_STATUS_NO").attr('value')}
            ],
            newPage: 1
        });
        $grid.loadData(true);
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
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.createDate" /></td>
                        <td width="35%" class="l-table-edit-c"><input type="text" name="S_DATE" id="S_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /> ~ <input type="text"
                            name="E_DATE" id="E_DATE" value="" size="25" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="mat.materialType" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectObjectType name="MAT_TYPE_NO" parentTypeNo="3" onChange="spf_search()" limit="all" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="mat.materialStatus" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="MAT_STATUS_NO" objectTypeNo="3" onChange="spf_search()" limit="all" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='materialInfo'></div>
        </div>
    </div>
</body>
</html>
