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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/ecm/cnObjectList.js" type="text/javascript"></script>

<script type="text/javascript">
    var $OBJECT_CATEGORY='DOC';
    var $curgrid = null;
    var $documentgrid=null;
    var $materialgrid=null;
    var $bomgrid=null;
    $(function () {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        $("#CHANGE_NO").attr("readonly","readonly");
        spf_navTabGridInit();
        spf_navTabInit();
        $curgrid = $materialgrid;
    });

    function spf_navTabInit(){
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid) {
                if(tabid=="tabitem1"){
                    $curgrid = $documentgrid;
                    $curgrid.loadData(true);
                    $OBJECT_CATEGORY='DOC';
                }
                if(tabid=="tabitem2"){
                    $curgrid = $bomgrid;
                    $curgrid.loadData(true);
                    $OBJECT_CATEGORY='BOM';
                }
                if(tabid=="tabitem3"){
                    $curgrid = $materialgrid;
                    $curgrid.loadData(true);
                    $OBJECT_CATEGORY='MAT';
                }
            }
         });
    }

    function spf_navTabGridInit(){
        $documentgrid = spf_object_initGrid('ecmDocumentInfo','DOC', '${changeNo.no}');
        $bomgrid = spf_object_initGrid('ecmBOMInfo','BOM', '${changeNo.no}');
        $materialgrid = spf_object_initGrid('ecmMaterialInfo','MAT', '${changeNo.no}');
    }

    function reloadECMObject(){
        $curgrid.loadData(true);
    }

    function spf_update(){
        spf_save();
    }
    function spf_add(){
        spf_save();
    }
    function spf_save() {
        if(spf_checkData()){
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             var changeNo = {};
             changeNo.no = $("#CHANGE_NO").val();
             changeNo.description = $("#DESCRIPTION").val();
             changeNo.startDate = $("#S_DATE").val();
             changeNo.endDate = $("#E_DATE").val();
             changeNo.reason = $("#REASON").val()
             changeNo.processRunning ={};
             changeNo.processRunning.type ={};
             changeNo.processRunning.type.no =$("#CHANGE_TYPE_NO").val();
             changeNo.processRunning.state ={};
             changeNo.processRunning.state.no =$("#CHANGE_STATUS_NO").val();

             $.post("/ecm/cnManage/transferChangeNo",
                     [
                        { name: 'jsonData', value: JSON.stringify(changeNo)}
                      ]
             , function (result) {
                $.ligerDialog.closeWaitting();
                 if (result.code == 0) {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                        spf_refresh();
                     });
                 } else {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                 }
             });
        }
     }
    function spf_checkData() {
        if ($("#CHANGE_NO").val() == null || $("#CHANGE_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更号id'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#REASON").val() == null || $("#REASON").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更原因'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        if ($("#CHANGE_STATUS_NO").val() == null || $("#CHANGE_STATUS_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更状态'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#S_DATE").val() == null || $("#S_DATE").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更日期'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        return true;
    }

    function spf_refresh(){
        var CHANGE_NO = '${changeNo.no}';
        location.href="/ecm/cnManage/updateChangeNo?MENU_CODE=ecm0104&changeNo=" + CHANGE_NO;
    }
    var tab = parent.tab;
    function spf_checkChangeNo() {
         var changeNo = $("#CHANGE_NO").val();
         $.post('/ecm/cnCheck/checkDuplicate',{"type":"changeNo","CHANGE_NO":changeNo},function(back){
             $('#TipID').html(back);
         });
    }

    function spf_addObjects(){
        var _jasonData = changeSelectedRowToString('add');
        if(_jasonData == null){
            return;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
           $.post("/ecm/cnManage/addObjects",
                   [
                        { name: 'changeNo',value: $("#CHANGE_NO").val()},
                        { name: 'jsonData', value: _jasonData }
                   ]
           , function (result) {
            $.ligerDialog.closeWaitting();
               if (result.code == 0) {
                   $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                   {
                       reloadECMObject();
                   });
               } else {
                   $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
               }
           });
    }

    function spf_deleteECMObject(){
        var _jasonData = changeSelectedRowToString('delete');
        if(_jasonData == null){
            return;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
           $.post("/ecm/cnManage/deleteObjects",
                   [
                        { name: 'changeNo',value: $("#CHANGE_NO").val()},
                        { name: 'jsonData', value: _jasonData }
                   ]
           , function (result) {
            $.ligerDialog.closeWaitting();
               if (result.code == 0) {
                   $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                   {
                        reloadECMObject();
                   });
               } else {
                   $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.messag);
               }
           });
    }

    function changeSelectedRowToString(flag){
        var jsonData = '[' ;
        var rowAmount = 0;
        var changeNo = $("#CHANGE_NO").val();
        var rows = $curgrid.getCheckedRows();
        if(rows && rows.length > 0){
            rowAmount = rowAmount + rows.length;
            jsonData = changeRowsToString(rows, jsonData, changeNo, flag);
        }
        if(rowAmount==0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return null;
        }
        jsonData += ']';
        var jsonList = eval("(" + jsonData + ")");
        if(jsonData.length == 2 || jsonData.length == 0 || jsonList.length != rowAmount){
             return null;
        }
        return jsonData;
    }

    function changeRowsToString(rows, jsonData, changeNo, flag){
        $(rows).each(function (index, row)
            {
                 index = index + 1;
                 if(flag=="add"&&this.IS_INCLUDED==0 ||flag=="delete"&&this.IS_INCLUDED==1){
                     if (jsonData.length > 1){
                        jsonData += ',{' ;
                     }
                     else{
                        jsonData += '{' ;
                     }
                     jsonData += ' "OBJECT_ID": "' + this.OBJECT_ID + '", ' ;
                     jsonData += ' "OBJECT_CATEGORY": "' + this.OBJECT_CATEGORY + '", ' ;
                     jsonData += ' "CHANGE_NO": "' + changeNo + '" ' ;
                     jsonData += '}' ;
                 }
            });
        return jsonData;
    }

    function spf_addECMObject(){
        var $title = '';
        var $url = '';
        if($OBJECT_CATEGORY=='DOC'){
            var $title = '文档列表';
            var $url = '/utility/docInfo/viewDocumentList';
        }
        if($OBJECT_CATEGORY=='BOM'){
            var $title = 'BOM列表';
            var $url = '/utility/bomInfo/viewBOMList';
        }
        if($OBJECT_CATEGORY=='MAT'){
            var $title = '流列表';
            var $url = '/utility/matInfo/viewMaterialList';
        }
        if($OBJECT_CATEGORY=='XXX'){
            var $title = '流列表';
            var $url = '/utility/matInfo/viewMaterialList';
        }
        $.ligerDialog.open({
            title: $title,
            name:'objectselector'+Math.random(),
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
        var fn ;
        if($OBJECT_CATEGORY=='DOC'){
            fn = dialog.frame.spf_selectDocument || dialog.frame.window.spf_selectDocument;
        }
        if($OBJECT_CATEGORY=='BOM'){
            fn = dialog.frame.spf_selectBOM || dialog.frame.window.spf_selectBOM;
        }
        if($OBJECT_CATEGORY=='MAT'){
            fn = dialog.frame.spf_selectMaterial || dialog.frame.window.spf_selectMaterial;
        }
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        var $obj_id;
        if($OBJECT_CATEGORY=='DOC'){
            $obj_id=data.DOC_ID;
        }
        if($OBJECT_CATEGORY=='BOM'){
            $obj_id=data.BOM_ID;
        }
        if($OBJECT_CATEGORY=='MAT'){
            $obj_id=data.MAT_ID;
        }
        $.post('/ecm/cnManage/addObject',{"OBJECT_ID": $obj_id,"OBJECT_CATEGORY": $OBJECT_CATEGORY,"CHANGE_NO": $('#CHANGE_NO').val()},function(result){
             if(result=='Y'){
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        reloadECMObject();
                    });
             }else{
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
             }
         });
        dialog.close();
    }
    function spf_selectObjectCancel(item, dialog)
    {
        dialog.close();
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
        <input type="hidden" name="CHANGE_TYPE_NO" id="CHANGE_TYPE_NO" value="${changeNo.processRunning.type.no}" />
        <input type="hidden" name="CHANGE_NO" id="CHANGE_NO" value="${changeNo.no}" />
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img
                    src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;">基本信息</td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><SipingSoft:button /></td>
            </tr>
        </table>

        <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="20%" class="l-table-edit-t">变更号<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c"> ${changeNo.id}
                </td>
                <td width="20%" class="l-table-edit-t">
                <spring:message code="hrms.documentNumber" /></td>
                <td width="30%" class="l-table-edit-c"></td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">变更类型<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c">
                    ${changeNo.processRunning.type.name}</td>
                <td width="20%" class="l-table-edit-t">变更状态</td>
                <td width="30%" class="l-table-edit-c"><SipingSoft:selectStatusNo
                        name="CHANGE_STATUS_NO"
                        selected="${changeNo.processRunning.state.no}"
                        objectTypeNo="${changeNo.processRunning.type.no}"
                        curStatusNo="${changeNo.processRunning.state.no}"
                        processResult="${changeNo.processRunning.result}" /></td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">起始日期<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c"><input type="text"
                    name="S_DATE" id="S_DATE" value="<fmt:formatDate value="${changeNo.startDate}" pattern="yyyy-MM-dd"/>"
                    size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" /></td>
                <td width="20%" class="l-table-edit-t">结束日期</td>
                <td width="30%" class="l-table-edit-c"><input type="text"
                    name="E_DATE" id="E_DATE" value="<fmt:formatDate value="${changeNo.endDate}" pattern="yyyy-MM-dd"/>"
                    size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" /></td>
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
                    <td width="80%" class="l-table-edit-c" nowrap="nowrap"><textarea
                            rows="2" cols="100" id="REASON" name="REASON">${changeNo.reason}</textarea>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">变更号描述</td>
                    <td width="80%" class="l-table-edit-c" nowrap="nowrap"><textarea
                            rows="2" cols="100" id="DESCRIPTION" name="DESCRIPTION">${changeNo.description}</textarea>
                    </td>
                </tr>
            </table>
            <table width="99.6%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;">变更内容</td>
                    <td width="5%" align="right">&nbsp;</td>
                    <td align="right" height="30px;"><a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                        onclick="spf_deleteECMObject()">删除</a> <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                        onclick="spf_addECMObject()">添加</a></td>
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
                    <!-- <div title='修改工艺'>
                <div id="ecmXXXInfo"></div>
            </div> -->
                </div>
            </div>
        </div>
</body>
</html>
