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
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
//初始化数据
    var $matchoosedialog;
    $(function () {
        $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
        });
    });

    var tab = parent.tab;

    function spf_save() {
        if(spf_checkData()){
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             var bom = {};
             bom.processRunning = {};
             bom.processRunning.type = {};
             bom.processRunning.type.no = $("#BOM_TYPE_NO").val();
             bom.material = {};
             bom.material.no = $("#MAT_V_NO").val();
             bom.factoryId = $("#FACTORY_ID").val();
             bom.looseRate = $("#LOSS_RATE").val();
             bom.description = $("#DESCRIPTION").val();
             bom.startDate = $("#S_DATE").val();

             $.post("/bom/bomManage/transferBOM",
                 [  
                    { name: 'jsonData', value: JSON.stringify(bom) }
                 ]
             , function (result) {
                 $.ligerDialog.closeWaitting();
                 if (result.code == 0) {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function () {
                        spf_refresh(result.message);
                     });
                 } else {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                 }
             });
        }
     }
    function spf_checkData() {
        if ($("#MAT_V_NO").val() == null || $("#MAT_V_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.materialNumber"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#BOM_TYPE_NO").val() == null || $("#BOM_TYPE_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="bom.bomType"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        return true;
    }

    function spf_refresh(BOM_NO){
        if(tab.isTabItemExist('bom0201')){
                tab.removeTabItem('bom0201');
        }
        if(tab.isTabItemExist('bom0202')){
                tab.removeTabItem('bom0202');
        }
        tab.addTabItem({ tabid : 'bom0202',text: '<spring:message code="bom.editBom"/>', url: '/bom/bomManage/updateBOM?MENU_CODE=bom0202&bomNo='+BOM_NO });
    }

    function spf_selectMaterialNo(){
        $('#MAT_V_NO').val('');
        $('#MAT_V_ID').val('');
        var $title;
        var $url;
        var $name;
        $title = "<spring:message code="bom.selectMaterials"/>";
        $name = "bomselector"+Math.random();
        $url = "/utility/matInfo/viewMaterialList";

        $matchoosedialog = $.ligerDialog.open({
            title: $title,
            name: $name,
            width: 800,
            height: 400,
            url: $url,
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectObjectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectObjectCancel }
            ]
        });
    }

    function spf_selectObjectOK(item, dialog) {
        var fn=null;
        fn = dialog.frame.spf_selectMaterial || dialog.frame.window.spf_selectMaterial;
        var data = fn();
        if (!data) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $('#MAT_V_ID').val(data.MAT_ID);
        $('#MAT_V_NO').val(data.MAT_NO);
        dialog.close();
    }

    function spf_selectObjectCancel(item, dialog) {
        dialog.close();
    }

</script>
    <style type="text/css">
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" style="width:99.6%;margin:0; padding:0;">
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.basicInfo"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
                <SipingSoft:button/>
            </td>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.bomType"/><font color="red">*</font></td>
           <td width="30%" class="l-table-edit-c">
             <SipingSoft:selectObjectType name="BOM_TYPE_NO" parentTypeNo="4"/>
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.materialNumber"/><font color="red">*</font></td>
           <td width="30%" class="l-table-edit-c">
                <input type="text" name="MAT_V_ID" id="MAT_V_ID" onClick="spf_selectMaterialNo();" size="30"/>
                <input type="hidden" name="MAT_V_NO" id="MAT_V_NO"/>
           </td>
      </tr>
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.productionPlant"/></td>
           <td width="30%" class="l-table-edit-c">
              <input type="text" name="FACTORY_ID" id="FACTORY_ID" value="" size="30"/>
           </td>
           <td width="20%" class="l-table-edit-t"><spring:message code="bom.lossRate"/></td>
           <td width="30%" class="l-table-edit-c">
              <input type="text" name="LOSS_RATE" id="LOSS_RATE" value="" size="30"/>
           </td>
       </tr>
       <tr>
            <td width="20%" class="l-table-edit-t"><spring:message code="bom.description"/></td>
            <td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3" >
                 <textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION" ></textarea>
            </td>
       </tr>
    </table>

    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.additionalInformation"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
            </td>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t"><spring:message code="hrms.effectDate"/></td>
           <td width="80%" class="l-table-edit-c">
           <input type="text" name="S_DATE"
                    id="S_DATE" value="" size="25"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" />
           </td>
      </tr>
    </table>
</div>
</body>
</html>
