<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    $(function() {
        initAreaSelectCss();
        checkData();
    });

    function initTaglib() {
        $("#receiverProvince").val($("[name=RECEIVER_PROVINCE]").val());
        $("#receiverCity").val($("[name=RECEIVER_CITY]").val());
        $("#receiverArea").val($("[name=RECEIVER_AREA]").val());
    }
    function checkTip()
    {
        if($("#receiverMobileTip").text()==""&&$("#receiverMobileTip").text()=="")
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
        $("#RECEIVER_MOBILE").blur(function() {
            var receiverMobile = $.trim($("#RECEIVER_MOBILE").val());
            if (receiverMobile != "") {
                if (!mobreg.test($("#RECEIVER_MOBILE").val())) {
                    $("#receiverMobileTip").text("<spring:message code="cust.mobileWrongFormat"/>");
                    $(".submit").attr("disabled", true);
                } else {
                    $("#receiverMobileTip").text("");
                    checkTip();
                }
            } else {
                $("#receiverMobileTip").text("");
                checkTip();
            }
        });

        $("#RECEIVER_EMAIL").blur(function() {
            var receiverEmail = $.trim($("#RECEIVER_EMAIL").val());
            if (receiverEmail != "") {
                if (!mailreg.test($("#RECEIVER_EMAIL").val())) {
                    $("#receiverEmailTip").text("<spring:message code="cust.emailWrong"/>");
                    $(".submit").attr("disabled", true);
                } else {
                    $("#receiverEmailTip").text("");
                    checkTip();
                }
            } else {
                $("#receiverEmailTip").text("");
                checkTip();
            }
        });
        //初始化检查mobile字段
        var receiverMobile = $.trim($("#RECEIVER_MOBILE").val());
        if (receiverMobile != "") {
            if (!mobreg.test($("#RECEIVER_MOBILE").val())) {
                $("#receiverMobileTip").text("<spring:message code="cust.mobileWrongFormat"/>");
                $(".submit").attr("disabled", true);
            } else {
                $("#receiverMobileTip").text("");
                $(".submit").attr("disabled", false);
            }
        } else {
            $("#receiverMobileTip").text("");
            $(".submit").attr("disabled", false);
        }
        //初始化检查Email字段
        var receiverEmail = $.trim($("#RECEIVER_EMAIL").val());
        if (receiverEmail != "") {
            if (!mailreg.test($("#RECEIVER_EMAIL").val())) {
                $("#receiverEmailTip").text("<spring:message code="cust.emailWrong"/>");
                $(".submit").attr("disabled", true);
            } else {
                $("#receiverEmailTip").text("");
                $(".submit").attr("disabled", false);
            }
        } else {
            $("#receiverEmailTip").text("");
            $(".submit").attr("disabled", false);
        }
    }

    function initAreaSelectCss() {
        $(":text").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("#RECEIVER_ADDRESS").width("170");
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
        <input type="hidden" name="receiver.address.province.codeNo" id="receiverProvince"> <input type="hidden" name="receiver.address.city.codeNo" id="receiverCity"> <input
            type="hidden" name="receiver.address.area.codeNo" id="receiverArea">
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 80px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="65%" align="left" style="font-weight: bold;"><spring:message code="cust.informationConsignee"/><span><font style="font-weight: normal;font-size:12px;">(默认收货人是联系人，可变更)</font></span></span></td>
            </tr>
        </table>
        <table width="680px" cellpadding="0" cellspacing="0" style="font-size: 12px;">
            <tr>
                <td width="170px；" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
                <td class="l-table-edit-c" width="500px;"><input type="text" id="RECEIVER_NAME" name="receiver.receiverName" value="${customer.receiver.receiverName}" /></td>
            </tr>
            <tr>
                <td width="170px；" class="l-table-edit-t"><spring:message code="cust.email"/></td>
                <td class="l-table-edit-c" width="500px;"><input type="text" id="RECEIVER_EMAIL" name="receiver.email" value="${customer.receiver.email}" /> <font color="red" size="-1">&nbsp;<label
                        id="receiverEmailTip"></label></font></td>
            </tr>
            <tr>
                <td width="170px；" class="l-table-edit-t"><spring:message code="hrms.phoneNumber"/></td>
                <td class="l-table-edit-c" width="500px;"><input type="text" id="RECEIVER_MOBILE" name="receiver.mobilePhone" value="${customer.receiver.mobilePhone}" /> <font color="red"
                    size="-1">&nbsp;<label id="receiverMobileTip"></label></font></td>
            </tr>
            <tr>
                <td width="170px；" class="l-table-edit-t"><spring:message code="hrms.fixedTelephone"/></td>
                <td class="l-table-edit-c" width="500px;"><input type="text" id="RECEIVER_TELEPHONE" name="receiver.telePhone" value="${customer.receiver.telePhone}" /></td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="hrms.deliveryAddress"/></td>
                <td colspan="3">
                    <div style="font-size: 12px;">
                        <SipingSoft:area provinceID="RECEIVER_PROVINCE" cityID="RECEIVER_CITY" countyID="RECEIVER_AREA" provinceSelected="${customer.receiver.address.province.codeNo}"
                            citySelected="${customer.receiver.address.city.codeNo}" countySelected="${customer.receiver.address.area.codeNo}" />
                        <input type="text" id="RECEIVER_ADDRESS" name="receiver.address.address" value="${customer.receiver.address.address}" />
                    </div>
                </td>
            </tr>
        </table>
        <div class="step">
            <h2>
            <input type="submit" name="_target1" class="submit" value="<spring:message code="cust.previous"/>"
                    onclick="initTaglib()" style="background: url('/resources/images/button/button.gif'); width: 81px; height: 25px; border: 0; color: #2C4D79;" />
            
               <input type="submit" name="_finish" class="submit" value="<spring:message code="cust.complete"/>"
                    onclick="initTaglib()" style="background: url('/resources/images/button/button.gif'); width: 81px; height: 25px; border: 0; color: #2C4D79;" />
            </h2>
        </div>
    </form>
</body>
</html>