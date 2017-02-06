<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    $(function() {
        initAreaSelectCss();
        initStatus();
    });

    function initStatus() {
        var telereg = /^[0-9]{1,}$/;
        if($.trim($("#CUST_NAME").val()) == "")
            {
            $("#customerNameTip").text("*<spring:message code="cust.required"/>");
             $("#submitButton").attr("disabled", true); 
            }
        if($.trim($("[name='custSalesMode.codeNo']").val()) == "")
        {
            $("#custSalesModeTip").text("*<spring:message code="cust.required"/>");
            $("#submitButton").attr("disabled", true); 
        }
        function checkTip()
        {
            if($("#customerNameTip").text()==""&&$("#custSalesModeTip").text()==""&&$("#taxPayerCodeTip").text()==""&&$("#bankCodeTip").text()=="")
             {
                $("#submitButton").attr("disabled", false);
             }
        }
        //初始化客户经理的值
        if($("#ownerName").val()=="")
        {
            $("#ownerName").val($("[name='userName']").val());
        } 
        $("#CUST_NAME").blur(function(){
            if($.trim($("#CUST_NAME").val())!="")
                {
                    $("#customerNameTip").text("");
                    checkTip();
                }else{
                    $("#customerNameTip").text("*<spring:message code="cust.required"/>");
                }
        });

        $("[name='custSalesMode.codeNo']").blur(function(){
            if($.trim($(this).val())!="")
                {
                    $("#custSalesModeTip").text("");
                    checkTip();
                }else{
                    $("#custSalesModeTip").text("*<spring:message code="cust.required"/>");
                }
        });

        $("#BANK_ACCOUNT").blur(function(){
            if($("#BANK_ACCOUNT").val()!="")
            {
                if($("#BANK_ACCOUNT").val().length<16||$("#BANK_ACCOUNT").val().length>19)
                {
                    $("#bankCodeTip").text("<spring:message code="cust.account"/>");
                    $("#submitButton").attr("disabled", true);
                }else{
                    $("#bankCodeTip").text(""); 
                    checkTip();
                }  
            }else{
                $("#bankCodeTip").text(""); 
                checkTip();
            }
        });

        $("#TAXPAYER_IDCODE").blur(function(){
            if($("#TAXPAYER_IDCODE").val()!="")
            {
                if($("#TAXPAYER_IDCODE").val().length>20)
                {
                    $("#taxPayerCodeTip").text("<spring:message code="cust.taxpayer"/>");
                    $("#submitButton").attr("disabled", true);
                }else{
                    $("#taxPayerCodeTip").text(""); 
                    checkTip();
                }
            }else{
                $("#taxPayerCodeTip").text(""); 
                checkTip();
            }
        });
        $("#CREDIT_AMOUNT").blur(function(){
            if ($("#CREDIT_AMOUNT").val() == ""||!telereg.test($("#CREDIT_AMOUNT").val())) {
                $("#CREDIT_AMOUNT").val(0);
                }
        });
    }
    //用于给属性赋值
    function initSelectArea() {
        $("#registerProvince").val($("[name=PROVINCE]").val());
        $("#registerCity").val($("[name=CITY]").val());
        $("#registerArea").val($("[name=AREA]").val());
        $("#officeProvince").val($("[name=OFFICE_PROVINCE]").val());
        $("#officeCity").val($("[name=OFFICE_CITY]").val());
        $("#officeArea").val($("[name=OFFICE_AREA]").val());
        //判断回显联系人是否存在地址，没有则把办公地址缓存，回显到联系人页面
        if($("#contactProvince").val()==null||$("#contactProvince").val()=="")
        {
            $("#contactProvince").val($("[name=OFFICE_PROVINCE]").val());
            $("#contactCity").val($("[name=OFFICE_CITY]").val());
            $("#contactArea").val($("[name=OFFICE_AREA]").val());	
        }
        if($("#contactAddress").val()=="")
        {
        	$("#contactAddress").val($("#OFFICE_ADDRESS").val());
        }
    }

    //用于初始化文本框的状态
    function initAreaSelectCss() {
        $("[name='customerType.codeNo']").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("[name='customerStatus.codeNo']").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("[name='customerLevel.codeNo']").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("[name='custSalesMode.codeNo']").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $(":text").css({
            border : "1px solid #c1dcfa",
            width : "200",
            height : "17"
        });

        $("#ADDRESS").width("150");
        $("#OFFICE_ADDRESS").width("150");
        if ($("#CREDIT_AMOUNT").val() == "") {
            $("#CREDIT_AMOUNT").val(0);
        }
    }

    function spf_initSelectEmpInfo(employee)
    {
        $("#ownerId").val(employee.EMPID);
        $("#ownerName").val(employee.CHINESENAME);
        $dialog.close();
    }

    function searchEmp(){
        $dialog = $.ligerDialog.open({
            isDrag: false,width: 500, height: 300,
            title:'<spring:message code="employee.information"/>',
            url: '/utility/empInfo/viewCustSearchEmployee'
        });
   }
</script>
<style type="text/css">
.step h2 {
    padding-left: 550px;
}
</style>
</head>
<body style="padding: 2px">
    <form action="customerInfoFillWizard" method="post">
        <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
            <input type="hidden" id="type" name="type" value='${type}' /> 

            <!-- 因为地址选择框中没有name属性，所以这里用隐藏域缓存值 -->
            <input type="hidden" name="CUST_ID" id="CUST_ID" value="" /> 
            <input type="hidden" name="registerAddress.province.codeNo" id="registerProvince"> 
            <input type="hidden" name="registerAddress.city.codeNo" id="registerCity"> 
            <input type="hidden" name="registerAddress.area.codeNo" id="registerArea">
            <input type="hidden" name="officeAddress.province.codeNo" id="officeProvince"> 
            <input type="hidden" name="officeAddress.city.codeNo" id="officeCity">
            <input type="hidden" name="officeAddress.area.codeNo" id="officeArea">

            <!-- 缓存联系人的地址 -->
            <input type="hidden" name="contact.address.province.codeNo" value="${customer.contact.address.province.codeNo}" id="contactProvince"> 
            <input type="hidden"   name="contact.address.city.codeNo" value="${customer.contact.address.city.codeNo}"  id="contactCity"> 
            <input type="hidden" name="contact.address.area.codeNo"  value="${customer.contact.address.area.codeNo}"  id="contactArea">
            <input type="hidden" name="contact.address.address" value="${customer.contact.address.address}" id="contactAddress">

            <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 50px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="65%" align="left" style="font-weight: bold;"><spring:message code="cust.basicCustomerInformation"/></td>
                </tr>
            </table>
            <table width="680px" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.customerName"/><font color="red">*</font></td>
                    <td width="500px" class="l-table-edit-c"><input type="text" name="customerName" id="CUST_NAME" value="${customer.customerName}" size="30" /> <font color="red" size="-1">&nbsp;<label
                            id="customerNameTip"></label></font></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.customerType"/><font color="red">*</font></td>
                    <td width="500px;" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="customerType.codeNo" selected="${customer.customerType.codeNo}" /></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.salesMode"/><font color="red">*</font></td>
                    <td width="500px;" class="l-table-edit-c"><SipingSoft:selectSalesMode name="custSalesMode.codeNo" limit="all" selected="${customer.custSalesMode.codeNo}" /> <font color="red"
                        size="-1">&nbsp;<label id="custSalesModeTip"></label></font></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.customerStatus"/><font color="red">*</font></td>
                    <td width="500px;" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerStatusCode" name="customerStatus.codeNo" selected="${customer.customerStatus.codeNo}" /></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.customerRating"/><font color="red">*</font></td>
                    <td width="500px;" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerLevelCode" name="customerLevel.codeNo" selected="${customer.customerLevel.codeNo}" /></td>
                </tr>
                <tr>
                <c:if test="${isSupervisor}">
                    <td width="180px" class="l-table-edit-t"><spring:message code="hrms.customerManager"/></td>
                    <td width="500px;" class="l-table-edit-c">
                        <input type="text" name="owner.empName" id="ownerName" onclick="searchEmp()" value="${customer.owner.empName}" size="30" />
                        <input type="hidden" name="userName"   size="30"  value="${userName}"/>
                        <input type="hidden" name="owner.empId" id="ownerId" value="${ownerId}">
                    </td>
                </c:if>
                <%-- <c:if test="${!isSupervisor}">
                    <td width="180px" class="l-table-edit-t">客户经理</td>
                    <td width="500px;" class="l-table-edit-c">
                        <input type="text" name="OWNER" id="OWNER" readonly="readonly" value="${admin.chineseName}" size="30" />
                        <input type="hidden" name="OWNER_ID" id="OWNER_ID" readonly="readonly" value="${admin.adminID}" size="30" />
                    </td>
                </c:if> --%>
            </tr>  
                <tr>
                    <td class="l-table-edit-t"><spring:message code="cust.lineOfCredit"/></td>
                    <td class="l-table-edit-c"><input type="text" name="credit.amount" id="CREDIT_AMOUNT" value="${customer.credit.amount}" size="30" /> <font color="red" size="-1">&nbsp;<label
                            id="creditTip"></label></font></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="cust.phone"/></td>
                    <td width="500px;" class="l-table-edit-c"><input type="text" name="telePhone" id="TELEPHONE" value="${customer.telePhone}" size="30" /></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="cust.theTaxpayerIdentificationNumber"/></td>
                    <td width="500px;" class="l-table-edit-c"><input type="text" name="taxPayerCode" id="TAXPAYER_IDCODE" value="${customer.taxPayerCode}" size="30" />
                    <font color="red" size="-1">&nbsp;<label id="taxPayerCodeTip"></label></font>
                    </td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="mobile.bankName"/></td>
                    <td width="500px;" class="l-table-edit-c"><input type="text" name="bankName" id="BANK" value="${customer.bankName}" size="30" /></td>
                </tr>
                <tr>
                    <td width="180px" class="l-table-edit-t"><spring:message code="cust.bankAccount"/></td>
                    <td width="500px;" class="l-table-edit-c"><input type="text" name="bankCode" id="BANK_ACCOUNT" value="${customer.bankCode}" size="30" /> <font color="red" size="-1">&nbsp;<label
                            id="bankCodeTip"></label></font></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="cust.registeredAddress"/></td>
                    <td style="padding-bottom: 2px;">
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="PROVINCE" cityID="CITY" countyID="AREA" provinceSelected="${customer.registerAddress.province.codeNo}"
                                citySelected="${customer.registerAddress.city.codeNo}" countySelected="${customer.registerAddress.area.codeNo}" />
                            <input type="text" id="ADDRESS" name="registerAddress.address" value="${customer.registerAddress.address}" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="mobile.officeAddress"/></td>
                    <td>
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="OFFICE_PROVINCE" cityID="OFFICE_CITY" countyID="OFFICE_AREA" provinceSelected="${customer.officeAddress.province.codeNo}"
                                citySelected="${customer.officeAddress.city.codeNo}" countySelected="${customer.officeAddress.area.codeNo}" />
                            <input type="text" name="officeAddress.address" id="OFFICE_ADDRESS" value="${customer.officeAddress.address}" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="step" style="padding-top:10px;">
            <h2>
                <input type="submit" onclick="initSelectArea()" name="_target1" id="submitButton"   value="<spring:message code="cust.next"/>" style="background: url('/resources/images/button/button.gif'); width: 81px; height: 25px; border: 0;font-weight:normal; font-size:12px;color: #2C4D79;"
 />
            </h2>
        </div>
    </form>
</body>
</html>