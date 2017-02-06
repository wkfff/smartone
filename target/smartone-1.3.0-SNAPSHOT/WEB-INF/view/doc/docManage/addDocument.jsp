<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function (){
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

             var $documentJson = {};
             $documentJson.name = $("#DOC_NAME").val();
             $documentJson.id = $("#DOC_T_ID").val();
             $documentJson.description = $("#DESCRIPTION").val();
             $documentJson.part = $("#DOC_PART").val();
             $documentJson.version = $("#DOC_VERSION").val();
             $documentJson.processRunning = {};
             $documentJson.processRunning.type = {};
             $documentJson.processRunning.type.no = $("#DOC_TYPE_NO").val();
             $.post("/doc/docManage/transferDocument", [
                        { name: 'jsonData', value: JSON.stringify($documentJson) },
                        { name: 'idType', value: $('#id_type:checked').val() }
                      ]
             ,  function (result){
                $.ligerDialog.closeWaitting();
                 if (result.code != 1000){
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        spf_refresh(result.code);
                     });
                 }else{
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                 }
             });
        }
     }
    function spf_checkData(){
        if ($("#DOC_T_ID").val() == ""&& $("#id_type:checked").val() == "0") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docNumber"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#DOC_NAME").val() == null || $("#DOC_NAME").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docName"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#DOC_TYPE_NO").val() == null || $("#DOC_TYPE_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docType"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
       if ( $("#DOC_PART").val() == null || $("#DOC_PART").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.documentationSection"/>'+ '<spring:message code="input.required"/>') ;
             return false;
       }
       if ( $("#DOC_PART").val().length > 6) {
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.documentationSection"/>'+ '值过多') ;
           $("#DOC_PART").val("");
           return false;
       }
       if ( $("#DOC_VERSION").val() == null || $("#DOC_VERSION").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docVersion"/>' + '<spring:message code="input.required"/>') ;
             return false;
        }
        if (!(/^(\+|-)?\d+$/.test( $("#DOC_VERSION").val()))) {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docVersion"/>' + '<spring:message code="hrms.shouldBeApositiveInteger"/>') ;
             $("#DOC_VERSION").val(1);
             return false;
       }
       return true;
    }

    function spf_refresh(DOC_ID){
        if(tab.isTabItemExist('doc0201')){
                tab.removeTabItem('doc0201');
        }
        if(tab.isTabItemExist('doc0202')){
                tab.removeTabItem('doc0202');
        }
        tab.addTabItem({ tabid : 'doc0202',text: '<spring:message code="hrms.editDocument"/>', url: '/doc/docManage/updateDocument?MENU_CODE=doc0202&documentId='+DOC_ID });
    }
    $(function (){
        $("#DOC_TYPE_NAME").ligerComboBox({
            onBeforeOpen: spf_selectDocType
        });
    });
    function spf_selectDocType(){
        $.ligerDialog.open({
            title: '<spring:message code="hrms.docType"/>',
            name:'doctypeselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/docInfo/viewDocTypeList',
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectDocTypeOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectDocTypeCancel },
                { text: '<spring:message code="clear"/>', onclick: spf_selectDocTypeClear }
            ]
        });
        return false;
    }
    function spf_selectDocTypeOK(item, dialog) {
        var fn = dialog.frame.spf_selectDocType || dialog.frame.window.spf_selectDocType;
        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#DOC_TYPE_NO").val(data.DOC_TYPE_NO);
        $("#DOC_TYPE_NAME").val(data.DOC_TYPE_NAME);
        dialog.close();
    }

    function spf_selectDocTypeCancel(item, dialog){
        dialog.close();
    }

    function spf_selectDocTypeClear(item, dialog){
        $("#DOC_TYPE_NO").val("");
        $("#DOC_TYPE_NAME").val("");
        dialog.close();
    }

    function checkDocumentID(){
         if($('#id_type:checked').val()!='2'){
            $('#tipid').html('<font color="green"><spring:message code="hrms.available"/></font>');
            return;
         }
         var documentID = $("#DOC_T_ID").val();
         if(documentID==''){
            $('#tipid').html('<font color="red"><spring:message code="hrms.required"/></font>');
            return;
         }
         $.post('/doc/docInfo/checkDocumentID?documentID='+documentID,function(result){
             if(result=='0'){
                $('#tipid').html('<font color="green"><spring:message code="hrms.available"/></font>');
             }else{
                $('#tipid').html('<font color="red"><spring:message code="hrms.unavailable"/></font>');
             }
         });
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
           <td width="15%" class="l-table-edit-t"><spring:message code="hrms.docNumber"/><font color="red">*</font></td>
           <td width="35%" class="l-table-edit-c">
                <input type="text" name="DOC_T_ID" id="DOC_T_ID" value="" size="30" onChange="checkDocumentID();" />
                <span id="tipid" style="color:red;font-size: 12px;width:10px"></span>
                <input type="radio" name="id_type" id="id_type" value="1" onChange="checkDocumentID();" checked/><spring:message code="hrms.intern"/>
                <input type="radio" name="id_type" id="id_type" value="2" onChange="checkDocumentID();" /><spring:message code="hrms.extern"/>
                <input type="radio" name="id_type" id="id_type" value="3" onChange="checkDocumentID();" /><spring:message code="hrms.mix"/>
           </td>
           <td width="15%" class="l-table-edit-t"><spring:message code="hrms.docName"/><font color="red">*</font></td>
           <td width="35%" class="l-table-edit-c">
                <input type="text" name="DOC_NAME" id="DOC_NAME" value="" size="30"/>
            </td>
      </tr>
       <tr>
           <td width="15%" class="l-table-edit-t"><spring:message code="hrms.documentationSection"/><font color="red">*</font></td>
           <td width="35%" class="l-table-edit-c">
              <input type="text" name="DOC_PART" id="DOC_PART" value="" size="30" />
           </td>
           <td width="15%" class="l-table-edit-t"><spring:message code="hrms.docVersion"/><font color="red">*</font></td>
               <td width="35%" class="l-table-edit-c">
              <input type="text" name="DOC_VERSION" id="DOC_VERSION" value="" size="30"/>
           </td>
       </tr>
      <tr>
           <td width="15%" class="l-table-edit-t"><spring:message code="hrms.docType"/><font color="red">*</font></td>
           <td width="35%" class="l-table-edit-c">
                <SipingSoft:selectObjectType name="DOC_TYPE_NO" parentTypeNo="2"/>
           </td>
           <td width="15%" class="l-table-edit-t"></td>
           <td width="35%" class="l-table-edit-c"></td>
       </tr>
       <tr>
            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.docDescription"/></td>
            <td width="35%" class="l-table-edit-c" nowrap="nowrap" colspan="3">
                 <textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION" ></textarea>
            </td>
       </tr>
    </table>
</div>
</body>
</html>