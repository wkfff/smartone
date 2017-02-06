<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Order Detail</title>
<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<!-- <link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>
<script type="text/javascript">
</script>
<style>
    body{
        font-size:0.75em;
    }
</style>
</head>
<body>
    <div data-role="page" data-theme="b" style="height:100%;">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.orderDetail'/></h1>
        </div>
        <div data-role="content" style="background-color:#eeeeee;height:100%;padding:2px;color:black;">
            <table class="border" style="width:100%;background-color:#ffffff;margin-top:5px;border-collapse: collapse;">
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='mat.orderNumber'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.salesOrderId }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;">客户</td>
                    <td style="border:1px solid #cccccc;">${salesOrder.customer.customerName }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='mobile.orderTime'/></td>
                    <td style="border:1px solid #cccccc;"><fmt:formatDate  value="${salesOrder.orderDate }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /><br/>  </td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='mobile.orderTotalAmount'/></td>
                    <td style="color:red;border:1px solid #cccccc;">${salesOrder.price.price }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='mobile.shippingMethod'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.transportMode }</td>
                </tr>
            </table>
            <table class="border" style="width:100%;background-color:#ffffff;margin-top:5px;border-collapse: collapse;">
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='hrms.invoiceTitle'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.invoiceTitleType }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='hrms.invoiceContent'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.invoiceContent }</td>
                </tr>
            </table>
            <table class="border" style="width:100%;background-color:#ffffff;margin-top:5px;border-collapse: collapse;">
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='hrms.deliveryAddress'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.receiver.address.wholeAddress }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='cust.receiver'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.receiver.receiverName }</td>
                </tr>
                <tr>
                    <td style="width:30%;padding:6px;border:1px solid #cccccc;"><spring:message code='hrms.phoneNumber'/></td>
                    <td style="border:1px solid #cccccc;">${salesOrder.receiver.mobilePhone }</td>
                </tr>
            </table>
            <c:forEach var="product" items="${salesOrder.soldProducts }" varStatus="i">
                <hr style="border:1px dashed #cccccc;width:100%;">
                <table class="proDetailTable" style="width:100%;background-color:#ffffff;margin-top:5px;border-collapse: collapse;">
                    <tr>
                        <td rowspan="5" width="90" align="left"><img src="/resources/picture/product/${product.id }.jpg" id="proImage" onerror="this.src='/resources/picture/none.gif'"
                            class="proImage" style="width: 80px; height: 80px;" pno="${product.no }" pid="${product.id }" /></td>
                    </tr>
                    <tr height="40">
                        <td colspan="2" width="100" style="color:black;">${product.name }</td>
                    </tr>
                    <tr height="25">
                        <td style="color:black;">￥${product.sellingPrice.discountPrice }</td>
                    </tr>
                    <tr height="25">
                        <td style="color:black;">x${product.quantity }</td>
                    </tr>
                </table>
            </c:forEach>
                <hr style="border:1px dashed #cccccc;width:100%;">
            <div style="clear:both;">
                <a href="javascript:spf_viewMobileOrderList()">
                    <img class="backToOrderList" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
                </a>
            </div>
        </div>
    </div>
</body>
</html>