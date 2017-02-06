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

<script type="text/javascript">
    $(function () {
        $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
        });
        var maxQuantity;
        var leftQuantity;
    });

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
             changeNo.description = $("#DESCRIPTION").val();
             changeNo.id = $("#CHANGE_ID").val();
             changeNo.startDate = $("#S_DATE").val();
             changeNo.endDate = $("#E_DATE").val();
             changeNo.reason = $("#REASON").val()
             changeNo.processRunning ={};
             changeNo.processRunning.type ={};
             changeNo.processRunning.type.no =$("#CHANGE_TYPE_NO").val();

             $.post("/ecm/cnManage/transferChangeNo",
                     [
                        { name: 'jsonData', value: JSON.stringify(changeNo)},
                        { name: 'idTypeNo', value:$('#id_type:checked').val()},
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
        if ($("#CHANGE_ID").val() == ""&&$("#ID_TYPE:checked").val() == "O") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更号id'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#REASON").val() == null || $("#REASON").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更原因'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        if ($("#CHANGE_TYPE_NO").val() == null || $("#CHANGE_TYPE_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更类型'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#S_DATE").val() == null || $("#S_DATE").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '变更日期'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        return true;
    }

    function spf_refresh(){
        location.href="/ecm/cnManage/addChangeNo?MENU_CODE=ecm0103";
    }
    var tab = parent.tab;
    function spf_checkChangeNo() {
         if($('#id_type:checked').val()!='2'){
            $('#tipid').html('<font color="green">可用</font>');
            return;
         }
         var changeNo = $("#CHANGE_NO").val();
         if(changeNo==''){
            $('#tipid').html('<font color="red">必填</font>');
            return;
         }
         $.post('/ecm/cnCheck/checkDuplicate',{"CHANGE_NO":changeNo,"type":"changeNo"},function(result){
                $('#tipid').html(result);
         });
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
                <td width="30%" class="l-table-edit-c" colspan="3"><input
                    type="text" name="CHANGE_ID" id="CHANGE_ID" size="30"
                    onchange="spf_checkChangeNo();" /> <span id="tipid"
                    style="color: red; font-size: 12px; width: 10px"></span> <input
                    type="radio" name="id_type" id="id_type" value="1"
                    onChange="spf_checkChangeNo();" checked />内部 <input type="radio"
                    name="id_type" id="id_type" value="2"
                    onChange="spf_checkChangeNo();" />外部 <input type="radio"
                    name="id_type" id="id_type" value="3"
                    onChange="spf_checkChangeNo();" />混合</td>
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">变更类型<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c" colspan="3"><SipingSoft:selectObjectType
                        name="CHANGE_TYPE_NO" parentTypeNo="1" />
            </tr>
            <tr>
                <td width="20%" class="l-table-edit-t">起始日期<font color="red">*</font></td>
                <td width="30%" class="l-table-edit-c"><input type="text"
                    name="S_DATE" id="S_DATE" value="" size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" /></td>
                <td width="20%" class="l-table-edit-t">结束日期</td>
                <td width="30%" class="l-table-edit-c"><input type="text"
                    name="E_DATE" id="E_DATE" value="" size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" /></td>
            </tr>
        </table>
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
                            rows="2" cols="100" id="REASON" name="REASON"></textarea>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t">变更号描述</td>
                    <td width="80%" class="l-table-edit-c" nowrap="nowrap"><textarea
                            rows="2" cols="100" id="DESCRIPTION" name="DESCRIPTION"></textarea>
                    </td>
                </tr>
            </table>
        </div>
        <br>
    </div>
</body>
</html>
