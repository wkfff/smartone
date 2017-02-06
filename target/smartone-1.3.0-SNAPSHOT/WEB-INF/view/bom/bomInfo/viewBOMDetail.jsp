<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog = null;
    var $bomitemgrid=null;
    $(function () {
        $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
        });
        spf_bomitem_initGrid();
    });

    function spf_bomitem_initGrid() {
        $bomitemgrid = $("#BOMItemInfo").ligerGrid({
            columns: [
                        { display: '', name: 'BOM_ITEM_ID', width: 0,hide:1 },
                        { display: '<spring:message code="hrms.materialNumber"/>', name: 'MAT_V_ID', width: 160},
                        { display: '<spring:message code="bom.sub-itemType"/>', name: 'BOM_CATEGORY', width: 90},
                        { display: '<spring:message code="hrms.quantity"/>', name: 'AMOUNT', width: 90},
                        { display: '<spring:message code="mat.Unit"/>', name: 'AMOUNT_UNIT', width: 90},
                        { display: '<spring:message code="hrms.changeNumber"/>', name: 'CHANGE_NO', width: 120},
                        { display: '<spring:message code="bom.lossRate"/>', name: 'LOSS_RATE', width: 120},
                        { display: '<spring:message code="hrms.startDate"/>', name: 'S_DATE', width: 120},
                        { display: '<spring:message code="hrms.endDate"/>', name: 'E_DATE', width: 120},
                        { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 220}
                    ],
            enabledEdit: false,rownumbers:true,resizable:false,
            fixedCellHeight:true,
            url: '/bom/bomInfo/getBOMItemList',
            usePager:true,
            parms: [
                { name: 'bomNo', value: $("#BOM_NO").val()}
            ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewBOMItemDetail(rowdata);
            }
        });
    }
    function spf_viewBOMItemDetail(rowdata){
        if(rowdata.BOM_CATEGORY_CODE=='BOMCategory001'){
            if(tab.isTabItemExist('doc0102')){
                tab.removeTabItem('doc0102');
            }
            tab.addTabItem({ tabid : 'doc0102',text: '<spring:message code="hrms.DocumentInformation"/>', url: '/doc/docInfo/viewDocumentDetail?MENU_CODE=doc0102&docNo='+rowdata.MAT_V_NO });
        }else{
            if(tab.isTabItemExist('mat0102')){
                tab.removeTabItem('mat0102');
            }
            tab.addTabItem({ tabid : 'mat0102',text: '<spring:message code="hrms.materialInformation"/>', url: '/mat/matInfo/viewMaterialDetail?MENU_CODE=mat0102&matNo='+rowdata.MAT_V_NO });
        }
    }
    var tab = parent.tab;
    function spf_refresh(BOM_NO){
        if(tab.isTabItemExist('bom0202')){
            tab.removeTabItem('bom0202');
        }
        tab.addTabItem({ tabid : 'bom0202',text: '<spring:message code="bom.editBom"/>', url: '/bom/bomManage/updateBOM?MENU_CODE=bom0202&BOM_NO='+BOM_NO });
    }

    function spf_search() {
        $bomitemgrid.setOptions({ parms: [
            { name: 'bomNo', value: $("#BOM_NO").val()},
            { name: 'changeNo', value: $("#CHANGE_NO").attr('value')},
            { name: 'queryDate', value: $("#QUERY_DATE").attr('value')}
           ],
           newPage: 1
         });
        $bomitemgrid.loadData(true);
    }
    function spf_viewBOMTree() {
        if(tab.isTabItemExist('bom0104')){
            tab.removeTabItem('bom0104');
        }
        tab.addTabItem({ tabid : 'bom0104',text: '<spring:message code="bom.tree"/>', url: '/bom/bomInfo/viewBOMTree?MENU_CODE=bom0104&BOM_NO='+$('#BOM_NO').val()+'&QUERY_DATE='+$("#QUERY_DATE").attr('value')+'&CHANGE_NO='+$("#CHANGE_NO").attr('value') });
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
<body style="padding:2px" >
<div id="layout1" style="width:99.6%;margin:0; padding:0;">
    <input hidden="hidden" type="text" name="BOM_NO" id="BOM_NO" value="${bom.no}" size="30"/>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.basicInfo"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_viewBOMTree()"><spring:message code="bom.viewBOMTree"/></a>
                <SipingSoft:button/>
            </td>
        </tr>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.materialNumber"/></td>
           <td width="30%" class="l-table-edit-c">
               ${bom.material.id}
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.effectDate"/></td>
           <td width="30%" class="l-table-edit-c">
                <fmt:formatDate value="${bom.startDate}" pattern="yyyy-MM-dd"/>
           </td>
      </tr>
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.bomType"/></td>
           <td width="30%" class="l-table-edit-c">
               ${bom.processRunning.type.name}
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.bomStatus"/></td>
           <td width="30%" class="l-table-edit-c">
               ${bom.processRunning.state.name}
           </td>
       </tr>
       <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.productionPlant"/></td>
           <td width="30%" class="l-table-edit-c">
              ${bom.factoryId}
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.lossRate"/></td>
           <td width="30%" class="l-table-edit-c">
              ${bom.looseRate}
           </td>
       </tr>
       <tr>
            <td width="20%" class="l-table-edit-t"><spring:message code="bom.description"/></td>
            <td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3">
               <textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION">${bom.description}</textarea>
           </td>
       </tr>
    </table>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;"  title="<spring:message code="bom.materialMessage"/>">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="bom.materialCompositionInquiry"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
            </td>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.queryDate"/><font color="red"></font></td>
           <td width="30%" class="l-table-edit-c">
                <input type="text" name="QUERY_DATE" id="QUERY_DATE" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" size="30"/>
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.changeNumber"/><font color="red"></font></td>
           <td width="30%" class="l-table-edit-c">
               <input type="text" name="CHANGE_NO" id="CHANGE_NO" size="30"/>
           </td>
      </tr>
    </table>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="bom.bom"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px">
            </td>
        </tr>
    </table>
    <div id="BOMItemInfo">
</div>
</body>
</html>
