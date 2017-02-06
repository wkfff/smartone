<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    $(function() {
        initAreaSelectCss();
        checkData();//验证数据
        checkTip();
    });

    //因为地址框是id属性，不能缓存值，所以设置隐藏域来保存值====以及判断是否缓存联系人的信息
    function initTaglib() {
		$("#contactProvince").val($("[name=CONTACT_PROVINCE]").val());
        $("#contactCity").val($("[name=CONTACT_CITY]").val());
        $("#contactArea").val($("[name=CONTACT_AREA]").val());
        if($("#receiverName").val()==null||$("#receiverName").val()=="")
        {
        	$("#receiverName").val($("#CONTACT_NAME").val());
        }
        if($("#receiverEmail").val()==null||$("#receiverEmail").val()=="")
        {
            $("#receiverEmail").val($("#CONTACT_EMAIL").val());
        }
        if($("#receiverMobilePhone").val()==null||$("#receiverMobilePhone").val()=="")
        {
            $("#receiverMobilePhone").val($("#CONTACT_MOBILE").val());
        }
        if($("#receiverTelePhone").val()==null||$("#receiverTelePhone").val()=="")
        {
            $("#receiverTelePhone").val($("#CONTACT_TELEPHONE").val());
        }
        if($("#receiverProvince").val()==null||$("#receiverProvince").val()=="")
        {
        	$("#receiverProvince").val($("[name=CONTACT_PROVINCE]").val());
            $("#receiverCity").val($("[name=CONTACT_CITY]").val());
            $("#receiverArea").val($("[name=CONTACT_AREA]").val());
        }
        if($("#receiverAddress").val()==null||$("#receiverAddress").val()=="")
        {
            $("#receiverAddress").val($("#CONTACT_ADDRESS").val());
        }
    }
    //校验
    function checkTip()
    {
        if($("#contactMobileTip").text()==""&&$("#contactEmailTip").text()=="")
         {
            $(".submit").attr("disabled", false);
         }else
        {
             $(".submit").attr("disabled", true);
        }
    }
    
    function checkData() {
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        $("#CONTACT_MOBILE").blur(function() {
            var contactMobile = $.trim($("#CONTACT_MOBILE").val());
            if (contactMobile != "") {
                if (!mobreg.test($("#CONTACT_MOBILE").val())) {
                    $("#contactMobileTip").text("<spring:message code="cust.mobileWrongFormat"/>！");
                    $(".submit").attr("disabled", true);
                } else {
                    $("#contactMobileTip").text("");
                    checkTip();
                }
            } else {
                $("#contactMobileTip").text("");
                checkTip();
            }
        });

        $("#CONTACT_EMAIL").blur(function() {
            var contactEmail = $.trim($("#CONTACT_EMAIL").val());
            if (contactEmail != "") {
                if (!mailreg.test($("#CONTACT_EMAIL").val())) {
                    $("#contactEmailTip").text("<spring:message code="cust.emailWrong"/>！");
                    $(".submit").attr("disabled", true);
                } else {
                    $("#contactEmailTip").text("");
                    checkTip();
                }
            } else {
                $("#contactEmailTip").text("");
                checkTip();
            }
        });
    }

    function initAreaSelectCss() {
        $(":text").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("#CONTACT_ADDRESS").width("170");
    }
</script>
<style type="text/css">
.step h2 {
    padding-left: 500px;
    line-height: 100px;
}
</style>
</head>
<body>
    <form action="customerInfoFillWizard" method="post">
        <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
            <input type="hidden" id="CONTACT_ID" name="CONTACT_ID">

            <!-- 因为地址选择框中没有name属性，所以这里用隐藏域缓存值 -->
             <input type="hidden" name="contact.address.province.codeNo" id="contactProvince"> 
             <input type="hidden"   name="contact.address.city.codeNo" id="contactCity"> 
             <input type="hidden" name="contact.address.area.codeNo" id="contactArea">

             <!-- 缓存联系人的信息，回显到收货人中去 -->
             <input type="hidden"  name="receiver.receiverName"  value="${customer.receiver.receiverName}" id="receiverName">
             <input type="hidden" name="receiver.email" value="${customer.receiver.email}" id="receiverEmail" >
             <input type="hidden" name="receiver.mobilePhone" value="${customer.receiver.mobilePhone}" id="receiverMobilePhone" >
             <input type="hidden" name="receiver.telePhone" value="${customer.receiver.telePhone}" id="receiverTelePhone" >
             <input type="hidden" name="receiver.address.province.codeNo" value="${customer.receiver.address.province.codeNo}" id="receiverProvince"> 
             <input type="hidden"   name="receiver.address.city.codeNo" value="${customer.receiver.address.city.codeNo}"  id="receiverCity"> 
             <input type="hidden" name="receiver.address.area.codeNo"  value="${customer.receiver.address.area.codeNo}"  id="receiverArea">
             <input type="hidden" name="receiver.address.address" value="${customer.receiver.address.address}" id="receiverAddress">

            <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 50px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="65%" align="left" style="font-weight: bold;"><spring:message code="cust.contactInformation1"/></td>
                </tr>
            </table>
            <table width="680px" height="auto" cellpadding="0" cellspacing="0" style="font-size: 12px;margin-top: 20px">
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
                    <td width="500px;" class="l-table-edit-c"><input type="text" id="CONTACT_NAME" name="contact.contactName" value="${customer.contact.contactName}" /> <font color="red"
                        size="-1">&nbsp;<label id="contactNameTip"></label></font></td>
                </tr>
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="hrms.type"/></td>
                    <td width="500px;" class="l-table-edit-c"><select id="CONTACT_TYPE" name="contact.contactType.codeName">
                            <option><spring:message code="cust.keyContact"/></option>
                            <option><spring:message code="cust.theNonKeyContacts"/></option>
                    </select></td>
                </tr>
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="hrms.fixedTelephone"/></td>
                    <td class="l-table-edit-c" width="500px;"><input type="text" id="CONTACT_TELEPHONE" name="contact.telePhone" value="${customer.contact.telePhone}" /></td>
                </tr>
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="hrms.phoneNumber"/></td>
                    <td class="l-table-edit-c" width="500px;"><input type="text" id="CONTACT_MOBILE" name="contact.mobilePhone" value="${customer.contact.mobilePhone}" /> <font color="red"
                        size="-1">&nbsp;<label id="contactMobileTip"></label></font></td>
                </tr>
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="cust.email"/></td>
                    <td class="l-table-edit-c" width="500px;"><input type="text" id="CONTACT_EMAIL" name="contact.email" value="${customer.contact.email}" /> <font color="red" size="-1">&nbsp;<label
                            id="contactEmailTip"></label></font></td>
                </tr>
                <tr>
                    <td width="170px;" class="l-table-edit-t"><spring:message code="hrms.fax"/></td>
                    <td class="l-table-edit-c" width="500px;" colspan="3"><input type="text" id="CONTACT_FAX" name="contact.fax" value="${customer.contact.fax}" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="mobile.officeAddress"/></td>
                    <td>
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="CONTACT_PROVINCE" cityID="CONTACT_CITY" countyID="CONTACT_AREA" provinceSelected="${customer.contact.address.province.codeNo}" 
                                citySelected="${customer.contact.address.city.codeNo}" countySelected="${customer.contact.address.area.codeNo}" />
                            <input type="text" id="CONTACT_ADDRESS" name="contact.address.address" value="${customer.contact.address.address}" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="step">
            <h2>
             <input type="submit" name="_target0" class="submit"
                    value="<spring:message code="cust.previous"/>" onclick="initTaglib()" style="background: url('/resources/images/button/button.gif'); width: 81px; height: 25px; border: 0; color: #2C4D79;" />
                 <input type="submit" name="_target2" class="submit"
                    value="<spring:message code="cust.next"/>" onclick="initTaglib()" style="background: url('/resources/images/button/button.gif'); width: 81px; height: 25px; border: 0; color: #2C4D79;" />
            </h2>
        </div>
    </form>
</body>
</html>