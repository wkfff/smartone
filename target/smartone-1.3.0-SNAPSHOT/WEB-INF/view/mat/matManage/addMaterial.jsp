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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    $(function() {
    	$("#MAT_ID").attr("disabled",true);
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
    });

    function spf_uploadPhoto() {
        var MAT_NO = $('#MAT_NO').val();
        if (MAT_NO == null || MAT_NO == '' || MAT_NO == 'undefined') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mat.itemNumber"/>' + ". " + '<spring:message code="input.required"/>');
            return;
        }
        $dialog = $.ligerDialog.open({
            isDrag : false,
            title : '<spring:message code="mat.uploadPictures"/>',
            width : 420,
            height : 200,
            url : '/upload/fileUpload/uploadMaterialPic?MAT_NO=' + MAT_NO
        });
    }
    function spf_photo_ChildWindowClose(picPath) {
        $("#MAT_NO").attr("readonly", "readonly");
        $("#PHOTOPATH").val("/resources/picture/material/" + $("#MAT_NO").val());
        $("#headImage").attr("src", $("#PHOTOPATH").val() + "/small.jpg" + "?" + Math.random());
        $dialog.close();
    }

    function spf_update() {
        spf_save();
    }
    function spf_add() {
        spf_save();
    }
    function spf_save() {
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');

            var $matJson = {};
            $matJson.no= $("#MAT_NO").val();
            $matJson.id= $("#MAT_ID").val();
            $matJson.name= $("#MAT_NAME").val();
            $matJson.separated = false;
            $matJson.description= $("#MAT_DESCRIPTION").val();
            $matJson.bpName= $("#BP_NAME").val();
            $matJson.oldName= $("#OLD_NAME").val();
            $matJson.photoPath = $("#PHOTOPATH").val();
            $matJson.length = $("#LENGTH").val();
            $matJson.width = $("#WIDTH").val();
            $matJson.height = $("#HEIGHT").val();
            $matJson.netWeight = $("#NET_WEIGHT").val();
            $matJson.roughWeight = $("#ROUGH_WEIGHT").val();
            $matJson.processRunning = {};
            $matJson.processRunning.type = {};
            $matJson.processRunning.type.no = $("#MAT_TYPE_NO").val();
            $matJson.unit = {};
            $matJson.unit.id= $("#MAT_UNIT_CODE").val();
            $matJson.weightUnit = {};
            $matJson.weightUnit.id= $("#WEIGHT_UNIT_CODE").val();
            $matJson.lengthUnit = {};
            $matJson.lengthUnit.id= $("#LENGTH_UNIT_CODE").val();

            $.post("/mat/matManage/transferMaterial", [ {
                name : 'jsonData',
                value : JSON.stringify($matJson)
            }, {
                name : 'idType',
                value : $('#id_type:checked').val()
            }], function(result) {
                $.ligerDialog.closeWaitting();
                if (result.code == 0) {
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                        spf_refresh();
                    });
                } else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                }
            });
        }
    }
    function spf_checkData() {
        if ($("#MAT_ID").val() == "" && $("#type").val() == "update") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mat.materialID"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#MAT_NAME").val() == null || $("#MAT_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mat.materialName"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#MAT_TYPE_NO").val() == null || $("#MAT_TYPE_NO").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mat.materialType"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        return true;
    }

    function spf_refresh() {
        location.href = "/mat/matManage/addMaterial?MENU_CODE=mat0201";
    }
    var tab = parent.tab;
    function spf_checkMaterialID(id) {
    	  if(id==1){
              $("#MAT_ID").attr("disabled",true);
          }else{
              $("#MAT_ID").attr("disabled",false);
          }
        if ($('#id_type:checked').val() != 'O') {
            $('#tipid').html('<font color="green"><spring:message code="hrms.available"/></font>');
            return;
        }
        var materialID = $("#MAT_NO").val();
        if (materialID == '') {
            $('#tipid').html('<font color="red"><spring:message code="hrms.required"/></font>');
            return;
        }
        $.post('/mat/matCheck/checkDuplicate', {
            "MAT_NO" : materialID,
            "type" : "materialID"
        }, function(result) {
            $('#tipid').html(result);
        });
    }
    function spf_checkMaterialName() {
        var materialName = $("#MAT_NAME").val();
        $.post('/mat/matCheck/checkDuplicate', {
            "type" : "materialName",
            "MAT_NAME" : materialName
        }, function(back) {
            $('#tipname').html(back);
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
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.basicInfo" /></td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><SipingSoft:button /></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="15%" class="l-table-edit-t"><spring:message code="hrms.materialNumber" /><font color="red">*</font></td>
                <td width="35%" class="l-table-edit-c" >
                    <input type="text" name="MAT_ID" id="MAT_ID" value="" size="30" onchange="spf_checkMaterialID();" />
                    <span id="tipid" style="color: green; font-size: 12px; width: 10px"><spring:message code="hrms.available" /></span>
                    <input type="radio" name="id_type" id="id_type" value="1" onChange="spf_checkMaterialID(this.value);" checked /> <spring:message code="hrms.intern" />
                    <input type="radio" name="id_type" id="id_type" value="2" onChange="spf_checkMaterialID();" /> <spring:message code="hrms.extern" />
                    <input type="radio" name="id_type" id="id_type" value="3" onChange="spf_checkMaterialID();" /> <spring:message code="hrms.mix" /></td>
                <td width="15%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="mat.materialName" /><font color="red">*</font></td>
                <td width="35%" class="l-table-edit-c" nowrap="nowrap"><input type="text" name="MAT_NAME" id="MAT_NAME" value="${materialDetail.MAT_NAME}" size="30"
                    onchange="spf_checkMaterialName();" /> <span id="tipname" style="color: red;N56 font-size: 12px;"></span></td>
            </tr>
            <tr>
                <td width="15%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="mat.oldName" /></td>
                <td width="35%" class="l-table-edit-c" nowrap="nowrap"><input type="text" name="OLD_NAME" id="OLD_NAME" value="${materialDetail.OLD_NAME}" size="30" /> <span id="TipName"
                    style="color: red; font-size: 12px;"></span></td>
                <td width="15%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="mat.businessName" /></td>
                <td width="35%" class="l-table-edit-c" nowrap="nowrap"><input type="text" name="BP_NAME" id="BP_NAME" value="${materialDetail.BP_NAME}" size="30" /> <span id="TipName"
                    style="color: red; font-size: 12px;"></span></td>
            </tr>
            <tr>
                <td width="15%" class="l-table-edit-t"><spring:message code="mat.materialType" /></td>
                <td width="35%" class="l-table-edit-c"><SipingSoft:selectObjectType name="MAT_TYPE_NO" parentTypeNo="3" /></td>
                <td width="15%" class="l-table-edit-t"><spring:message code="mat.Unit" /></td>
                <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="MatUnitCode" limit="all" selected="${materialDetail.MAT_UNIT_CODE}" name="MAT_UNIT_CODE" />
                </td>
            </tr>
        </table>
        <br>
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.materialInformation" /></td>
                <td width="65%" align="right">&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <div id="businessInfo">
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.netWeight" /></td>
                    <td width="35%" class="l-table-edit-c"><input type="number" name="NET_WEIGHT" id="NET_WEIGHT" value="${materialDetail.NET_WEIGHT}" size="30" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.grossWeight" /></td>
                    <td width="35%" class="l-table-edit-c"><input type="number" name="ROUGH_WEIGHT" id="ROUGH_WEIGHT" value="${materialDetail.ROUGH_WEIGHT}" size="30" /></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.length" /></td>
                    <td width="35%" class="l-table-edit-c"><input type="number" name="LENGTH" id="LENGTH" value="${materialDetail.LENGTH}" size="30" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.width" /></td>
                    <td width="35%" class="l-table-edit-c"><input type="number" name="WIDTH" id="WIDTH" value="${materialDetail.WIDTH}" size="30" /></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.height" /></td>
                    <td width="35%" class="l-table-edit-c"><input type="number" name="HEIGHT" id="HEIGHT" value="${materialDetail.HEIGHT}" size="30" /></td>
                    <td width="15%" class="l-table-edit-t"></td>
                    <td width="35%" class="l-table-edit-c"></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.weightUnit" /></td>
                    <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="WeightUnitCode" limit="all" selected="${materialDetail.WEIGHT_UNIT_CODE}" name="WEIGHT_UNIT_CODE" />
                    </td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.lengthUnit" /></td>
                    <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="LengthUnitCode" limit="all" selected="${materialDetail.LENGTH_UNIT_CODE}" name="LENGTH_UNIT_CODE" />
                    </td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="mat.materialDescription" /></td>
                    <td width="80%" class="l-table-edit-c" colspan="3" nowrap="nowrap"><textarea rows="2" cols="150" id="MAT_DESCRIPTION" name="MAT_DESCRIPTION">${materialDetail.MAT_DESCRIPTION}</textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
