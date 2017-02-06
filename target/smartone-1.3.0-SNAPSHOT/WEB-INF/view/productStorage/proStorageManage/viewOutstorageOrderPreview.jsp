<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <!-- JS -->
    <script src="/resources/js/function.js" type="text/javascript"></script>
    <script type="text/javascript">
        //打印
        function spf_print(){
            window.print();
        }
        window.onload=function(){ 
            var sumMoney = document.getElementById("SUM_MONEY").innerHTML;
            document.getElementById("SUM_MONEY").innerHTML = '合计金额：'+numtochinese(sumMoney);
            var sumDiscountMoney = document.getElementById("SUM_DISCOUNT_MONEY").innerHTML;
            document.getElementById("SUM_DISCOUNT_MONEY").innerHTML = '大写：'+numtochinese(sumDiscountMoney);
        }
    </script>
    </head>
    <style type="text/css">
    body {
        font-family:"宋体";
    }
    /* print only */
    @media print {
        h4 {
          page-break-before: always;
          font-weight:normal;
          font-size:12pt;
         }
        #td0 h4 {
            font-weight:normal;
            font-size:12pt;
            page-break-before:avoid;
         }
        #hideTable {
          display: none;
        }
    }
    table {
        border-collapse:collapse;
        border:none;
        font-size:8px;
    }
    #printTable .showBorder td {
        border:solid #000 1px;
        text-align:center;
        padding:2px;
    }

    </style>
    <body>
        <table align="center" id="printTable" width="650px">
            <c:forEach items="${outstorageOrderDetail}" var="pur" varStatus="i">
                <c:if test="${i.index%10==0 }">
                    <tr>
                        <td colspan="11" align="center" id="td${i.index }">
                            <h4>${outstorageOrder.CPNY_NAME } 送货单</h4>
                        </td>
                    </tr>
                    <tr height="20px">
                        <td colspan="11">送货单编号:${outstorageOrder.OUTSTORAGE_ID }</td>
                    </tr>
                    <tr height="20px">
                        <td colspan="11">送货地址:${outstorageOrder.DELIVERY_ADDRESS }</td>
                    </tr>
                    <tr height="20px">
                        <td colspan="5">联系电话:${outstorageOrder.PHONE_NUM }</td>
                        <td colspan="5">联系人:${outstorageOrder.CONSIGNEE }</td>
                    </tr>
                    <tr height="20px">
                        <td colspan="5">客户名称:${outstorageOrder.CUST_NAME }</td>
                        <td colspan="5">客户编号:${outstorageOrder.CUST_ID }</td>
                    </tr>
                    <tr height="20px">
                        <td colspan="5">日期:${outstorageOrder.OUT_DATE }</td>
                        <td colspan="5" style="text-align:left">订单编号:${outstorageOrder.SALES_ORDER_ID }</td>
                    </tr>
                    <tr class="showBorder">
                        <td width="25px">序号</td>
                        <td width="100px">货品编号</td>
                        <td width="100px">品名</td>
                        <td width="75px">规格</td>
                        <!--<td width="60px">CAS</td>  -->
                        <td width="25px">单位</td>
                        <td width="40px">单价</td>
                        <td width="30px">数量</td>
                        <td width="50px">金额</td>
                        <td width="25px">折扣</td>
                        <td width="50px">折扣金额</td>
                    </tr>
                </c:if>
                <tr class="showBorder">
                    <td>${i.index+1}</td>
                    <td>${pur.PRODUCT_ID}</td>
                    <td>${pur.PRODUCT_NAME}</td>
                    <td>${pur.SPECIFICATION}</td>
                    <td>${pur.UNIT_NAME}</td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.PRICE}" pattern="0.00"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.QUANTITY}" pattern="0.00"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.MONEY}" pattern="0.00"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.DISCOUNT}" pattern="0.00"/></td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.DIS_MONEY}" pattern="0.00"/></td>
                </tr>
                <!-- 商品条数<10 -->
                <c:if test="${outstorageOrderDetailCnt < 10 }">
                    <c:if test="${(i.index + 1) == outstorageOrderDetailCnt }">
                        <tr height="20px" class="showBorder">
                            <td colspan="9" style="text-align:left" id="SUM_MONEY"><fmt:formatNumber value="${outstorageOrder.MONEY}" pattern="0.00"/></td>
                            <td style="text-align:right"><fmt:formatNumber value="${outstorageOrder.MONEY}" pattern="0.00"/></td>
                        </tr>
                        <tr height="30px">
                            <td colspan="2">折扣:<fmt:formatNumber value="${outstorageOrder.DISCOUNT }" pattern="0.00"/></td>
                            <td colspan="4">折后合计金额:<fmt:formatNumber value="${outstorageOrder.DIS_MONEY }" pattern="0.00"/>元</td>
                            <td colspan="5" id="SUM_DISCOUNT_MONEY"><fmt:formatNumber value="${outstorageOrder.DIS_MONEY }" pattern="0.00"/></td>
                        </tr>
                        <tr>
                            <td colspan="3">制单:${basicInfo.CHINESENAME } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;业务：${outstorageOrder.CHINESENAME }</td>
                            <td colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;送货:</td>
                            <td colspan="3">&nbsp;&nbsp;&nbsp;签收:</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="7">服务热线:${outstorageOrder.CPNY_TEL_NO1 } &nbsp;${outstorageOrder.CPNY_TEL_NO }</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="7">公司地址:${outstorageOrder.CPNY_ADDR }</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="10" style="text-align:center;vertical-align:bottom;">
                                                                                           第<fmt:formatNumber value="${(i.index)/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${outstorageOrderDetailCnt/10+1}" pattern="0"/>页
                            </td>
                        </tr>
                    </c:if>
                </c:if>
                <!-- 商品条数>=10 -->
                <c:if test="${outstorageOrderDetailCnt >= 10 }">
                    <c:if test="${(i.index + 1) == outstorageOrderDetailCnt }">
                        <tr class="showBorder" height="20px">
                            <td colspan="9" style="text-align:left" id="SUM_MONEY"><fmt:formatNumber value="${outstorageOrder.MONEY}" pattern="0.00"/></td>
                            <td style="text-align:right"><fmt:formatNumber value="${outstorageOrder.MONEY}" pattern="0.00"/></td>
                        </tr>
                        <tr height="30px">
                            <td colspan="2">折扣:<fmt:formatNumber value="${salesOrder.DISCOUNT }" pattern="0.00"/></td>
                            <td colspan="4">折后合计金额:<fmt:formatNumber value="${salesOrder.DISCOUNT_PRICE }" pattern="0.00"/>元</td>
                            <td colspan="5" id="SUM_DISCOUNT_MONEY"><fmt:formatNumber value="${salesOrder.DISCOUNT_PRICE }" pattern="0.00"/></td>
                        </tr>
                        <tr>
                            <td colspan="3">制单:${basicInfo.CHINESENAME } &nbsp;业务：${outstorageOrder.CHINESENAME }</td>
                            <td colspan="4">送货:</td>
                            <td colspan="3">签收:</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="7">服务热线:${outstorageOrder.CPNY_TEL_NO } &nbsp;${outstorageOrder.CPNY_TEL_NO1 }</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="7">公司地址:${outstorageOrder.CPNY_ADDR }</td>
                        </tr>
                    </c:if>
                    <!-- 商品总条数能被10整除 -->
                    <c:if test="${outstorageOrderDetailCnt % 10 == 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${outstorageOrderDetailCnt/10}" pattern="0"/>页</td>
                            </tr>
                        </c:if> 
                    </c:if>
                    <!-- 商品总条数不能被10整除 -->
                    <c:if test="${outstorageOrderDetailCnt % 10 != 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${outstorageOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
                            </tr>
                        </c:if>
                        <c:if test="${i.index +1==outstorageOrderDetailCnt  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${outstorageOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
                            </tr>
                        </c:if>
                    </c:if>
                </c:if>
            </c:forEach>
        </table>
        <table align="center" cellpadding="0" cellspacing="0" id="hideTable">
            <tr>
                <td align="left" height="30px">
                    <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-right: 10px;"
                        onclick="spf_print()">打印</a>
                </td>
            </tr>
        </table>
    </body>
</html>