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
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
    <script type="text/javascript">
    
//初始化数据 
    $(function ()
        {
            //布局
             $("#layout1").ligerLayout({  
                     allowLeftResize: false,      //是否允许 左边可以调整大小
                     allowRightResize: false,     //是否允许 右边可以调整大小
                     allowTopResize: false,      //是否允许 头部可以调整大小
                     allowBottomResize: false     //是否允许 底部可以调整大小
              }
             ); 
             if($("#ASSET_ID").val()==null || $("#ASSET_ID").val()==''|| $("#ASSET_ID").val()=='undefined'){
                 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="ass.tip"/>', function afterClick(){
                     top.tab.removeTabItem('ass0202');
                 });
             }
             if($("#type").val()!='add'){
                 $("#ASSET_ID").attr("readonly","readonly");
             }
             $("#USER_NAME").ligerComboBox({
                 onBeforeOpen: spf_selectEmp, valueFieldID: 'USER_ID',width:150
             });
        });

    function spf_selectEmp()
    {
        $.ligerDialog.open({ 
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
            ]
        });
        return false;
    }
    function spf_selectOK(item, dialog)
    {
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#USER_NAME").val(data.CHINESENAME);
        $("#USER_ID").val(data.EMPID); 
        dialog.close();
    }
    function spf_selectCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectClear(item, dialog)
    {
        $("#USER_NAME").val("");
        $("#USER_ID").val("");
        dialog.close();
    }

/*  *************************************************** */

    function spf_update(){
        spf_save();
    }
    function spf_add(){
        spf_save();
    }
    function spf_save() { 
        if(spf_checkData()){                  
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post("/ass/assManage/transferAsset", 
                     [  
                        { name: 'type', value: $("#type").val()},
                        { name: 'ASSET_ID', value: $("#ASSET_ID").val()},
                        { name: 'ASSET_NAME', value: $("#ASSET_NAME").val()},
                        { name: 'ASSET_EN_NAME', value: $("#ASSET_EN_NAME").val()},                     
                        { name: 'ASSET_CATEGORY_CODE', value: $("#ASSET_CATEGORY_CODE").val()},  
                        { name: 'ASSET_MODEL', value: $("#ASSET_MODEL").val()},  
                        { name: 'MANUFACTURER', value: $("#MANUFACTURER").val()},  
                        { name: 'MANUFACTURE_DATE', value: $("#MANUFACTURE_DATE").val()},
                        { name: 'INTERNATIONAL_NUMBER', value: $("#INTERNATIONAL_NUMBER").val()},
                        { name: 'PURCHASE_DATE', value: $("#PURCHASE_DATE").val()},
                        { name: 'NET_SALVAGE_VALUE', value: $("#NET_SALVAGE_VALUE").val()},
                        { name: 'REMARK', value: $("#REMARK").val()},  
                        { name: 'SERVICE_LIFE', value: $("#SERVICE_LIFE").val()},  
                        { name: 'ORIGINAL_VALUE', value: $("#ORIGINAL_VALUE").val()},
                        { name: 'NET_VALUE', value: $("#NET_VALUE").val()},
                        { name: 'DEPRECIATION_WAY', value: $("#DEPRECIATION_WAY").val()},
                        { name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},  
                        { name: 'STATUS_REMARK', value: $("#STATUS_REMARK").val()},  
                        { name: 'DEPTID', value: $("#DEPTID").val()},
                        { name: 'USER_ID', value: $("#USER_ID").val()},
                        { name: 'ALLOW_BORROW', value: $("#ALLOW_BORROW").val()},
                        { name: 'DESCRIPTION', value: $("#DESCRIPTION").val()}
                      ]
             , function (result)
             {
                $.ligerDialog.closeWaitting();
                 if (result == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                        spf_refresh();
                     });
                 }
                 else
                 {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                 }
             });
        }
     }
    function spf_checkData()
    {     
        //return true;
        if ($("#ASSET_ID").val() == null || $("#ASSET_ID").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.assetID"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }  
        if ($("#ASSET_NAME").val() == null || $("#ASSET_NAME").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.assetName"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }  
        if ($("#ASSET_CATEGORY_CODE").val() == null || $("#ASSET_CATEGORY_CODE").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.assetClasses"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        } 
        if ($("#STATUS_CODE").val() == null || $("#STATUS_CODE").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.assetStatus"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
       if ($("#ALLOW_BORROW").val() == null || $("#ALLOW_BORROW").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.whetherToAllowLending"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
       if ($("#PURCHASE_DATE").val() == null || $("#PURCHASE_DATE").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.dateOfPurchase"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
       if ($("#DEPTID").val() == null || $("#DEPTID").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.department"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }      
        return true;     
    } 

    function f_alert()
    {
        alert($("#USER_ID").val());
    }
    
    function spf_categorySuccess(){
        $dialog.close() ;
        $("#categorySelection").load(location.href + ' #categorySelection>*');  //局部刷新，但在IE上不好用
        spf_refresh();
    }
    function spf_refresh(){
        var type = '${type}';
        if(type == 'add'){
            location.href="/ass/assManage/addAsset?MENU_CODE=ass0201";
        }else if(type == 'update'){
            var ASSET_ID = '${assetDetail.ASSET_ID}';
            location.href="/ass/assManage/updateAsset?MENU_CODE=ass0202&ASSET_ID=" + ASSET_ID;
        }
    }
    
    function spf_checkAssetID()
    {   
         var assetID = $("#ASSET_ID").val(); 
         $.post('/ass/assManage/checkAssetID',{"ASSET_ID":assetID},function(back){  
             $('#TipID').html(back);
            });
    } 

    function spf_createCategory(){
        //alert('create new category!');
        $dialog = $.ligerDialog.open({
            isDrag: false,
            title: '<spring:message code="ass.creatingAnewCategory"/>',
            width: 350, height: 200,
            url: '/ass/assManage/addCategory?1=1'
        });
    }
</script>
    
<style type="text/css"> 
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <input type="hidden" id="type" name="type" value='${type}' />
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img
                    src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="ass.Information"/></td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><SipingSoft:button /></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.assetClasses"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c" id="categorySelection">
                    <SipingSoft:selectSyCode parentCode="AssetCategoryCode"
                        name="ASSET_CATEGORY_CODE"
                        selected="${assetDetail.ASSET_CATEGORY_CODE}" limit="all" /> <span
                    id="TipCategory"
                    style="color: black; font-size: 12px; cursor: pointer"
                    onclick="spf_createCategory()"><spring:message code="ass.assetClasses"/>？</span>
                </td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.assetID"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="ASSET_ID" id="ASSET_ID" value="${assetDetail.ASSET_ID}"
                    size="30" onchange="spf_checkAssetID();" /> <span id="TipID"
                    style="color: red; font-size: 12px;"></span></td>
                <td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.assetName"/><font
                    color="red">*</font></td>
                <td width="20%" class="l-table-edit-c" nowrap="nowrap"><input
                    type="text" name="ASSET_NAME" id="ASSET_NAME"
                    value="${assetDetail.ASSET_NAME}" size="30" /> <span id="TipName"
                    style="color: red; font-size: 12px;"></span></td>
            </tr>
        </table>
        <br>
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img
                    src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="ass.assetInformation"/></td>
                <td width="65%" align="right">&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.assetStatus"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
                        parentCode="ReturnTypeCode" selected="${assetDetail.STATUS_CODE}"
                        name="STATUS_CODE" limit="all" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.whetherToAllowLending"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
                        parentCode="yesOrno" name="ALLOW_BORROW"
                        selected="${assetDetail.ALLOW_BORROW}" limit="all" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.dateOfPurchase"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input
                    style="width: 177px" type="text" name="PURCHASE_DATE"
                    id="PURCHASE_DATE" value="${assetDetail.PURCHASE_DATE}"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                    readonly="readonly" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.engliseName"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="ASSET_EN_NAME" id="ASSET_EN_NAME"
                    value="${assetDetail.ASSET_EN_NAME}" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.useOfPersonnel"/></td>
                <td width="20%" class="l-table-edit-c"><input
                    style="width: 177px" type="text" id="USER_NAME" id="USER_NAME"
                    value="${assetDetail.USER_NAME}" /> <input type="hidden"
                    id="USER_ID" name="USER_ID" value="${assetDetail.USER_ID}" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.department"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:deptTree
                        name="DEPTID" selected="${assetDetail.DEPTID}" limit="hr" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.manufacturer"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="MANUFACTURER" id="MANUFACTURER"
                    value="${assetDetail.MANUFACTURER}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.model"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="ASSET_MODEL" id="ASSET_MODEL"
                    value="${assetDetail.ASSET_MODEL}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.dateOfManufacture"/></td>
                <td width="20%" class="l-table-edit-c"><input
                    style="width: 177px" type="text" name="MANUFACTURE_DATE"
                    id="MANUFACTURE_DATE" value="${assetDetail.MANUFACTURE_DATE}"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                    readonly="readonly" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.originalValue"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="ORIGINAL_VALUE" id="ORIGINAL_VALUE"
                    value="${assetDetail.ORIGINAL_VALUE}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.netWorth"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="NET_VALUE" id="NET_VALUE" value="${assetDetail.NET_VALUE}"
                    size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.residualRate"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="NET_SALVAGE_VALUE" id="NET_SALVAGE_VALUE"
                    value="${assetDetail.NET_SALVAGE_VALUE}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.depreciationMethods"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="DEPRECIATION_WAY" id="DEPRECIATION_WAY"
                    value="${assetDetail.DEPRECIATION_WAY}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.internationalCode"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="INTERNATIONAL_NUMBER" id="INTERNATIONAL_NUMBER"
                    value="${assetDetail.INTERNATIONAL_NUMBER}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.life"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text"
                    name="SERVICE_LIFE" id="SERVICE_LIFE"
                    value="${assetDetail.SERVICE_LIFE}" size="30" /></td>
            </tr>
        </table>
        <br>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.assetDescription"/></td>
                <td width="80%" class="l-table-edit-c" colspan="5" nowrap="nowrap">
                    <textarea rows="3" cols="150" id="DESCRIPTION" name="DESCRIPTION">${assetDetail.DESCRIPTION}</textarea>
                </td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="ass.remark"/></td>
                <td width="20%" class="l-table-edit-c" colspan="5" nowrap="nowrap">
                    <textarea rows="3" cols="150" id="REMARK" name="REMARK">${assetDetail.REMARK}</textarea>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
