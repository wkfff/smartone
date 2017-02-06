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
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/dateString.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog = null;
    var $bomitemgrid=null;
    var $bomCategory;
    var $bomItemData = {};
    var tab = parent.tab;
    $(function () {
         $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
         });
         $bomCategory = getBOMCategoryList();
         spf_bomitem_initGrid();
         spf_bomItemDataInit();
     });

    function spf_bomItemDataInit(){
        $bomItemData.id = '';
        $bomItemData.material.id = '';
        $bomItemData.material.no = '';
        $bomItemData.amount = 1;
        $bomItemData.startDate = '${paramMap.startDate}';
        $bomItemData.endDate = '${paramMap.endDate}';
        $bomItemData.changeNo = {};
        $bomItemData.changeNo.no = '${paramMap.changeNo}';
    }

    function spf_bomitem_initGrid() {
        $bomitemgrid = $("#BOMItemInfo").ligerGrid({
            onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
            },
            columns: [
                { display: '', name: 'id', width: 0,hide:1 },
                { display: '', name: 'material.no', width: 0,hide:1 },
                { display: '<spring:message code="hrms.materialNumber"/>', name: 'material.id', width: 160,
                    editor: { type: 'select', ext :function (rowdata) {
                            return {
                                onBeforeOpen : f_selectMaterial,
                                render : function(){
                                    return rowdata.record.material.id;
                                }
                            };
                        }
                    }
                },
                { display: 'BOM<spring:message code="bom.sub-itemType"/>', name: 'bomCategory', width: 90,
                    editor: {
                        type: 'select', data: $bomCategory, dataValueField: 'ID',dataDisplayField: 'NAME',
                        displayColumnName: 'NAME', valueColumnName: 'ID'
                    }, render: function (item) {
                        for (var i = 0; i < $bomCategory.length; i++) {
                            if ($bomCategory[i]['ID'] == item.bomCategory) {
                                return $bomCategory[i]['NAME'];
                            }
                        }
                        return item.bomCategory;
                    }
                },
                { display: '<spring:message code="hrms.quantity"/>', name: 'amount', width: 90,
                    editor: { type: 'text', height: 100 }
                },
                { display: '<spring:message code="mat.Unit"/>', name: 'material.unit.name', width: 90 },
                { display: '<spring:message code="bom.lossRate"/>', name: 'looseRate', width: 90,
                    editor: { type: 'float', height: 100 }
                },
                { display: '<spring:message code="hrms.changeNumber"/>', name: 'chanegNo.no', width: 120
                },
                { display: '<spring:message code="bom.startDate1"/>', name: 'startDate', width: 120,
                    type: 'date', format: 'yyyy-MM-dd'
                },
                { display: '<spring:message code="hrms.endDate"/>', name: 'endData', width: 120,
                    type: 'date', format: 'yyyy-MM-dd'
                },
                { display: '<spring:message code="hrms.description"/>', name: 'material.description', width: 220
                }
            ],
            enabledEdit: true,rownumbers:true,resizable:false,
            fixedCellHeight:true,
            url: '/bom/bomInfo/getBOMItemList?',
            usePager:true,
            parms: [
                    {name : 'bomNo',value:$('#BOM_NO').val()}
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewBOMItemDetail(rowdata);
            }
        });
    }
    function f_selectMaterial(rowdata) {
        $.ligerDialog.open({ title: '<spring:message code="bom.selectMaterials"/>', width: 700, height: 400,
            url: '/utility/matInfo/viewMaterialList?'+Math.random(),
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: f_selectMaterialOK },
                { text: '<spring:message code="cancel"/>', onclick: f_selectMaterialCancel }
            ]
        });
        return false;
    }
    function f_selectMaterialOK(item, dialog) {
        var data = dialog.frame.spf_selectMaterial();
        if (!data) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        var row = $bomitemgrid.getSelectedRow();
        row.material.id = data.MAT_ID;
        row.material.no = data.MAT_NO;
        row.material.unit.name = data.MAT_UNIT_NAME;
        row.material.unit.code = data.MAT_UNIT_CODE;
        row.material.description = data.MAT_DESCRIPTION;
        $bomitemgrid.updateRow(row,$bomitemgrid.getSelectedRow());

        dialog.close();
    }
    function f_selectMaterialCancel(item, dialog) {
        dialog.close();
    }

    function spf_viewBOMItemDetail(rowdata){
        if(rowdata.BOM_CATEGORY_CODE=='BOMCategory001'){
            if(tab.isTabItemExist('doc0102')){
                tab.removeTabItem('doc0102');
            }
            tab.addTabItem({ tabid : 'doc0102',text: '<spring:message code="hrms.DocumentInformation"/>', url: '/doc/docInfo/viewDocumentDetail?MENU_CODE=doc0102&docNo='+rowdata.material.no });
        }else{
            if(tab.isTabItemExist('mat0102')){
                tab.removeTabItem('mat0102');
            }
            tab.addTabItem({ tabid : 'mat0102',text: '<spring:message code="hrms.materialInformation"/>', url: '/mat/matInfo/viewMaterialDetail?MENU_CODE=mat0102&matNo='+rowdata.material.no });
        }
    }
    function spf_refresh(BOM_NO){
        if(tab.isTabItemExist('bom0202')){
            tab.removeTabItem('bom0202');
        }
        tab.addTabItem({ tabid : 'bom0202',text: '<spring:message code="bom.editBom"/>', url: '/bom/bomManage/updateBOM?MENU_CODE=bom0202&bomNo='+BOM_NO });
    }

    function spf_addBOMItem() {
        var newRowData = {
            id: '',
            changeNo : {},
            startDate: '',
            endDate: '',
            description: ''
        };
        newRowData.material = {};
        newRowData.material.id = '';
        newRowData.material.no = '';
        newRowData.changeNo.no = '';
        newRowData.material.unit= {};
        newRowData.material.unit.name= '';
        newRowData.material.unit.code= '';

        if('${paramMap.USE_CN}'=='1'){
            newRowData.startDate = $bomItemData.S_DATE;
            newRowData.startDate = $bomItemData.E_DATE
        }else{
            newRowData.startDate = '<fmt:formatDate value="${bom.startDate}" pattern="yyyy-MM-dd"/>';
        }

        var row = $bomitemgrid.getRow(0);
        $bomitemgrid.addRow(newRowData,row,true);
    }

    function spf_deleteBOMItem(){
        var row = $bomitemgrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        if (row.no == undefined || row.no == ''){
            $bomitemgrid.deleteRow(row);
            return;
        }
        $.ligerDialog.confirm('<spring:message code="bom.areYouSureToRemoveTheMaterial"/>',function(yes) {
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/bom/bomManage/deleteBOMItem?bomNo='+$('#BOM_NO').val()+'&bomItemNo='+row.no+'&T_CHANGE_NO='+row.CHANGE_NO+'&changeNo='+$bomItemData.changeNo,
                    function (result){
                       $.ligerDialog.closeWaitting();
                       if (result.code == 0) {
                           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function () {
                               spf_bomitem_initGrid();
                           });
                       } else {
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.getMessage());
                       }
                   });
             }
        });
    }

    function spf_save() {
        if($('#BOM_NO').val()==null||$('#BOM_NO').val()==''){
            return;
        }
        if(spf_checkData()){
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             var bom = {};
             bom.no = $("#BOM_NO").val();
             bom.processRunning = {};
             bom.processRunning.type = {};
             bom.processRunning.type.no = $("#BOM_TYPE_NO").val();
             bom.processRunning.state = {};
             bom.processRunning.state.no = $("#BOM_STATUS_NO").val();
             bom.factoryId = $("#FACTORY_ID").val();
             bom.looseRate = $("#LOSS_RATE").val();
             bom.description = $("#DESCRIPTION").val();

             $.post("/bom/bomManage/transferBOM",
                 [
                    { name: 'jsonData', value: JSON.stringify(bom)}
                 ]
             , function (result) {
                $.ligerDialog.closeWaitting();
                 if (result.code == 0) {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function () {
                        spf_refresh($('#BOM_NO').val());
                     });
                 } else {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                 }
             });
        }
     }

    function spf_checkData() {
        if ($("#BOM_NO").val() == null || $("#BOM_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="bom.bomNumber"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#BOM_STATUS_NO").val() == null || $("#BOM_STATUS_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="bom.bomStatus"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
       return true;
    }

    function spf_saveBOMItem() {
         var itemArray = getBOMItemJSONWithoutCN();
         console.log(itemArray);
         if ( itemArray.length == 0){
             return ;
         }
         $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
         $.post("/bom/bomManage/transferBOMItems",
             [
                { name: 'bomNo', value: $('#BOM_NO').val() },
                { name: 'changeNo', value: 0},
                { name: 'jsonData', value: JSON.stringify(itemArray) }
             ]
           , function (result) {
             $.ligerDialog.closeWaitting();
               if (result.code == 0) {
                   $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function () {
                        $bomitemgrid.loadData(true); //加载数据
                   });
               } else {
                   $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
               }
           });
      }

      function getBOMItemJSONWithoutCN(){
         $bomitemgrid.endEdit();
         var rows = $bomitemgrid.getData();
         var bomItemArray = [];
          $(rows).each(function (index, row) {
                if(this.__status == 'update' && this.endDate !=null && this.changeNo.no != $bomItemData.changeNo){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="bom.tip1"/>') ;
                    return null;
                }
                if(this.material.no == null || this.material.no  == undefined){
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.materialNumber"/>'+". " + '<spring:message code="input.required"/>') ;
                     return null;
                }
                if(this.bomCategory == null || this.bomCategory == undefined){
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mat.materialType"/>'+". " + '<spring:message code="input.required"/>') ;
                     return null;
                }
                if(this.amount == null || this.amount == undefined || isNaN(this.amount)){
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.quantity"/>'+". " + '<spring:message code="input.required"/>') ;
                     this.amount = 1;
                     return null;
                }
                if(this.looseRate == null || this.looseRate == ""|| this.looseRate == undefined){
                     this.looseRate = 0;
                }
                if(this.startDate == null || this.startDate == ""|| this.startDate == undefined){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="bom.startDate1"/>'+". " + '<spring:message code="input.required"/>') ;
                    return null;
                }
                
                var bomItem = {};
                bomItem.no = this.no;
                bomItem.material = {};
                bomItem.material.no = this.material.no;
                bomItem.amount = this.amount;
                bomItem.looseRate = this.looseRate;
                bomItem.factoryId = this.factoryId;
                bomItem.looseRate = this.looseRate;
                bomItem.description = this.description;
                bomItem.startDate = this.startDate;
                bomItem.endDate = this.endDate;
                bomItem.bomCategory = 0;
                bomItem.changeNo = {};
                bomItem.changeNo.no = this.changeNo.no;
                bomItemArray.push(bomItem);
        });
        return bomItemArray;
    }

    function getBOMCategoryList(){
        var BOMCategoryList;
        $.ajax({
           type: 'post',
           url: '/utility/otherInfo/getSyCodeSelectList?PARENT_CODE=BOMCategoryCode',
           dataType: 'json',
           async: false,
           success: function (list) {
               BOMCategoryList = list ;
           }
        });
        return BOMCategoryList;
    }

    function spf_viewBOMTree() {
        location.href='/bom/bomInfo/viewBOMTree?MENU_CODE=bom0104&bomNo='+$('#BOM_NO').val();
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
    <input type="hidden" name="BOM_NO" id="BOM_NO" value="${bom.no}" size="30"/>
    <input type="hidden" name="BOM_TYPE_NO" id="BOM_TYPE_NO" value="${bom.processRunning.type.no}"/>
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
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.materialNumber"/></td>
           <td width="30%" class="l-table-edit-c">
               ${bom.material.id}
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.startDate1"/></td>
           <td width="30%" class="l-table-edit-c">
                <fmt:formatDate value="${bom.startDate}" pattern="yyyy-MM-dd"/><input type="hidden" id="S_DATE" value="<fmt:formatDate value="${bom.startDate}" pattern="yyyy-MM-dd"/>">
           </td>
      </tr>
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.bomType"/></td>
           <td width="30%" class="l-table-edit-c">
                ${bom.processRunning.type.name}
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.bomStatus"/></td>
           <td width="30%" class="l-table-edit-c">
                <SipingSoft:selectStatusNo name="BOM_STATUS_NO" selected="${bom.processRunning.state.no}" objectTypeNo="${bom.processRunning.type.no}" curStatusNo="${bom.processRunning.state.no}" processResult="${bom.processRunning.result}"/>
           </td>
       </tr>
       <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.productionPlant"/></td>
           <td width="30%" class="l-table-edit-c">
              <input type="text" name="FACTORY_ID" id="FACTORY_ID" value="${bom.factoryId}" size="30"/>
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.lossRate"/></td>
           <td width="35%" class="l-table-edit-c">
              <input type="text" name="LOSS_RATE" id="LOSS_RATE" value="${bom.looseRate}" size="30"/>
           </td>
        </tr>
       <tr>
            <td width="20%" class="l-table-edit-t"><spring:message code="bom.description"/></td>
            <td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3">
               <textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION">${bom.description}</textarea>
           </td>
       </tr>
    </table>
    <c:if test="${paramMap.USE_CN==\"1\"}">
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                <td width="25%" align="left" style="font-weight: bold;">
                    <spring:message code="bom.changNumberInfomation"/>
                </td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px">
                </td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
               <td width="20%" class="l-table-edit-t"><spring:message code="hrms.changeNumber"/></td>
               <td width="30%" class="l-table-edit-c" colspan="3">
                   ${paramMap.CHANGE_NO}
                   <input type="hidden" id="CHANGE_NO" value="${paramMap.CHANGE_NO}"/>
               </td>
             </tr>
             <tr>
               <td width="20%" class="l-table-edit-t"><spring:message code="bom.startDate1"/></td>
               <td width="30%" class="l-table-edit-c" >
                   ${paramMap.S_DATE}
                   <input type="hidden" id="CN_S_DATE" value="${paramMap.S_DATE}"/>
               </td>
               <td width="20%" class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
               <td width="30%" class="l-table-edit-c" >
                   ${paramMap.E_DATE}
                   <input type="hidden" id="CN_E_DATE" value="${paramMap.E_DATE}"/>
               </td>
           </tr>
        </table>
    </c:if>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="bom.bom"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px">
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_saveBOMItem()"><spring:message code="hrms.save"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_deleteBOMItem()"><spring:message code="hrms.delete"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_addBOMItem()"><spring:message code="hrms.add"/></a>
            </td>
        </tr>
    </table>
    <div id="BOMItemInfo">
</div>
</body>
</html>
