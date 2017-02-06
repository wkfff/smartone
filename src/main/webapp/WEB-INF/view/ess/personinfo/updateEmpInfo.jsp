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
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    var $grid ;
    var $dialog ;
    $(function () {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
    });
    // 初始调用
    function spf_save() {
        if(spf_checkData()){
             $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
             $.post("/hrm/empinfo/updateEmpInfo",
                     [
                    { name: 'EMPID', value: $("#EMPID").val()},
                    { name: 'GENDER_CODE', value: $("#GENDER_CODE").val()},
                    { name: 'NATION_CODE', value: $("#NATION_CODE").val()},
                    { name: 'NATIONALITY_CODE', value: $("#NATIONALITY_CODE").val()},
                    { name: 'BORNPLACE_CODE', value: $("#BORNPLACE_CODE").val()},
                    { name: 'POLITY_CODE', value: $("#POLITY_CODE").val()},
                    { name: 'BIRTHDAY', value: $("#BIRTHDAY").val()},
                    { name: 'EDU_HIS_CODE', value: $("#EDU_HIS_CODE").val()},
                    { name: 'DEGREE_CODE', value: $("#DEGREE_CODE").val()},
                    { name: 'MAJOR_CODE', value: $("#MAJOR_CODE").val()},
                    { name: 'IDCARD_NO', value: $("#IDCARD_NO").val()},
                    { name: 'MARITAL_STATUS_CODE', value: $("#MARITAL_STATUS_CODE").val()},
                    { name: 'HOME_PROVINCE', value: $("#HOME_PROVINCE").val()},
                    { name: 'HOME_CITY', value: $("#HOME_CITY").val()},
                    { name: 'HOME_AREA', value: $("#HOME_AREA").val()},
                    { name: 'HOME_ADDRESS', value: $("#HOME_ADDRESS").val()},
                    { name: 'IDCARD_POSTALCODE', value: $("#IDCARD_POSTALCODE").val()},
                    { name: 'CELLPHONE', value: $("#CELLPHONE").val()},
                    { name: 'HOME_PHONE', value: $("#HOME_PHONE").val()},
                    { name: 'OFFICE_PHONE', value: $("#OFFICE_PHONE").val()},
                    { name: 'FAX', value: $("#FAX").val()},
                    { name: 'P_EMAIL', value: $("#P_EMAIL").val()},
                    { name: 'C_EMAIL', value: $("#C_EMAIL").val()},
                    { name: 'WORKAGE', value: $("#WORKAGE").val()},
                    { name: 'SHIFT_CODE', value: $("#SHIFT_CODE").val()},
                    { name: 'FILE_RELATION_CODE', value: $("#FILE_RELATION_CODE").val()},
                    { name: 'FILE_RELATION_ADDRESS', value: $("#FILE_RELATION_ADDRESS").val()},
                    { name: 'SSN', value: $("#SSN").val()},
                    { name: 'HAFN', value: $("#HAFN").val()},
                    { name: 'SI_REMARK', value: $("#SI_REMARK").val()},
                    { name: 'FUND_REMARK', value: $("#FUND_REMARK").val()},
                    { name: 'ADDED_INFOR1', value: $("#ADDED_INFOR1").val()},
                    { name: 'ADDED_INFOR2', value: $("#ADDED_INFOR2").val()}
                      ],
             function (result){
                $.ligerDialog.closeWaitting();
                 if (result == "Y"){
                     $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                         parent.f_ChildWindowClose() ;
                     });
                 }else{
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
                 }
             });
        }
     }
    function spf_checkData(){
        if ($("#IDCARD_NO").val() == null || $("#IDCARD_NO").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.IDnumber"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        var telereg = /^[0-9]{1,}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;

        if ($("#CELLPHONE").val() != null && $("#CELLPHONE").val() != "") {
            if (!mobreg.test($("#CELLPHONE").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.mobileTelephone" />' + '格式错误');
                return false;
            }}
         if ($("#HOME_PHONE").val() != null && $("#HOME_PHONE").val() != "") {
             if (!telereg.test($("#HOME_PHONE").val())) {
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.fixedTelephone" />' + '格式错误');
                 return false;
             }}
         if ($("#P_EMAIL").val() != null && $("#P_EMAIL").val() != "") {
             if (!mailreg.test($("#P_EMAIL").val())) {
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.e-mail" />' + '格式错误');
                 return false;
             }}
        return true;
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
        <div id='' title=' ' style="border: 0px;">
                <table width="99.2%" cellpadding="1" cellspacing="1" style="height: 30px; font-size: 12px;">
                    <tr>
                        <td>&nbsp;</td>
                        <td style="font-weight: bold;">&nbsp;</td>
                        <td>&nbsp;</td>
                        <td><a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
                    </tr>
                </table>
                <table width="99.2%" align="center" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr height="30px;">
                        <td width="20%" class="l-table-edit-t"
                            ><spring:message code="hrms.sex" /></td>
                        <td width="30%" class="l-table-edit-c"><input type="hidden"
                            id="EMPID" name="EMPID" value="${personalInfo.EMPID}"> <SipingSoft:selectSyCode
                                parentCode="GenderCode" name="GENDER_CODE" limit="all"
                                selected="${personalInfo.GENDER_CODE}" /></td>
                        <td width="20%" class="l-table-edit-t" ><spring:message code="hrms.nation" /></td>
                        <td width="30%" class="l-table-edit-c"><SipingSoft:selectSyCode
                                parentCode="NationCode" name="NATION_CODE" limit="all"
                                selected="${personalInfo.NATION_CODE}" /></td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.birthDate" /></td>
                        <td  class="l-table-edit-c"><input type="text"
                            name="BIRTHDAY" id="BIRTHDAY" value="${personalInfo.BIRTHDAY}"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                            readonly="readonly" /></td>
                        <td  class="l-table-edit-t" ><spring:message code="hrms.eduHis" /></td>
                        <td  class="l-table-edit-c"><SipingSoft:selectSyCode
                                parentCode="EduHisCode" name="EDU_HIS_CODE" limit="all"
                                selected="${personalInfo.EDU_HIS_CODE}" /></td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.politicalLandscape" /></td>
                        <td  class="l-table-edit-c"><SipingSoft:selectSyCode
                                parentCode="PolityCode" name="POLITY_CODE" limit="all"
                                selected="${personalInfo.POLITY_CODE}" /></td>
                        <td  class="l-table-edit-t" ><spring:message code="hrms.major" /></td>
                        <td  class="l-table-edit-c"><SipingSoft:selectSyCode
                                parentCode="SubjectCode" name="MAJOR_CODE" limit="all"
                                selected="${personalInfo.MAJOR_CODE}" /></td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.IDnumber" /><font color="red">*</font></td>
                        <td class="l-table-edit-c"><input type="text"
                            name="IDCARD_NO" id="IDCARD_NO" value="${personalInfo.IDCARD_NO}" />
                        </td>
                        <td  class="l-table-edit-t" ><spring:message code="hrms.maritalStatus" /></td>
                        <td  class="l-table-edit-c"><SipingSoft:selectSyCode
                                parentCode="MaritalStatusCode" name="MARITAL_STATUS_CODE"
                                limit="all" selected="${personalInfo.MARITAL_STATUS_CODE}" /></td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.mobileTelephone" /></td>
                        <td  class="l-table-edit-c"><input type="text"
                            name="CELLPHONE" id="CELLPHONE" value="${personalInfo.CELLPHONE}" />
                        </td>
                        <td  class="l-table-edit-t" ><spring:message code="hrms.fixedTelephone" /></td>
                        <td  class="l-table-edit-c"><input type="text"
                            name="HOME_PHONE" id="HOME_PHONE"
                            value="${personalInfo.HOME_PHONE}" /></td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.e-mail" /></td>
                        <td  class="l-table-edit-c" colspan="3"><input type="text"
                            name="P_EMAIL" id="P_EMAIL" value="${personalInfo.P_EMAIL}" />
                            <font color="red">* (<spring:message code="hrms.validteEmail" />)</font>
                        </td>
                    </tr>
                    <tr height="30px;">
                        <td  class="l-table-edit-t" ><spring:message code="hrms.socialSecurityNumber" /></td>
                        <td  class="l-table-edit-c"><input type="text"
                            name="SSN" id="SSN" value="${personalInfo.SSN}" /></td>
                        <td  class="l-table-edit-t" ><spring:message code="hrms.fundNumber" /></td>
                        <td  class="l-table-edit-c"><input type="text"
                            name="HAFN" id="HAFN" value="${personalInfo.HAFN}" /></td>
                </tr>
                <tr height="30px;">
                    <td  class="l-table-edit-t" ><spring:message code="hrms.mailingAddress" /></td>
                    <td  class="l-table-edit-c" colspan="3">
                        <SipingSoft:area provinceID="HOME_PROVINCE" cityID="HOME_CITY" countyID="HOME_AREA" provinceSelected="${personalInfo.HOME_PROVINCE}"
                                citySelected="${personalInfo.HOME_CITY}" countySelected="${personalInfo.HOME_AREA}" />
                    <input type="text" name="HOME_ADDRESS" size="40" id="HOME_ADDRESS"
                        value="${personalInfo.HOME_ADDRESS}" /></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>