<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        //打印
        function spf_print(){
            window.print();
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
        font-size:8pt;
    }
    #printTable .showBorder td {
        border:solid #000 1px;
        text-align:center;
        padding:2px;
    }

    </style>
    <body>
        <table align="center" id="printTable" width="650px">
            <c:forEach items="${purchaseOrderDetail}" var="pur" varStatus="i">
                <c:if test="${i.index%10==0 }">
                    <tr>
                        <td colspan="11" align="center" id="td${i.index }">
                            <h4>${purchaseOrder.CPNY_NAME } 采购单</h4>
                        </td>
                    </tr>
                    <tr height="20px">
                        <td colspan="3">采购单号:${purchaseOrder.ORDER_ID }</td>
                        <td colspan="2">采购日期:${purchaseOrder.PURCHASE_DATE }</td>
                        <td colspan="2">运输方式:${purchaseOrder.TRANSPORT_MODE }</td>
                        <td colspan="3">付款方式:${purchaseOrder.PAYMENT_MODE }</td>
                    </tr>
                    <tr class="showBorder">
                        <td width="25px">序号</td>
                        <td width="70px">货品编号</td>
                        <td width="100px">品名</td>
                        <td width="100px">规格</td>
                        <!--<td width="60px">CAS</td>  -->
                        <td width="25px">单位</td>
                        <td width="150px">供货商</td>
                        <td width="40px">单价</td>
                        <td width="40px">数量</td>
                        <td width="40px">金额</td>
                    </tr>
                </c:if>
                <tr class="showBorder">
                    <td>${i.index+1}</td>
                    <td>${pur.PRODUCT_ID}</td>
                    <td>${pur.PRODUCT_NAME}</td>
                    <td>${pur.SPECIFICATION}</td>
                    <!--<td>${pur.PRODUCT_CAS}</td>  -->
                    <td>${pur.UNIT_CODE}</td>
                    <td>${pur.SUPPLIER}</td>
                    <td style="text-align:right">${pur.UNIT_PRICE}</td>
                    <td style="text-align:right">${pur.QUANTITY}</td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.SUM_MONEY}" pattern="0.00"/></td>
                </tr>
                <!-- 商品条数<10 -->
                <c:if test="${purchaseOrderDetailCnt < 10 }">
                    <c:if test="${(i.index + 1) == purchaseOrderDetailCnt }">
                        <tr height="30px">
                            <td colspan="12">备注:${purchaseOrder.REMARKS }</td>
                        </tr>
                        <tr>
                            <td colspan="6"></td>
                            <td>总数量:${purchaseOrder.SUM_QUANTITY }</td>
                            <td colspan="3">总金额:${purchaseOrder.PAYABLE_AMOUNT }元</td>
                        </tr>
                        <tr >
                            <td colspan="2"></td>
                            <td colspan="4">审核人:${purchaseOrder.CHECKER }</td>
                            <td colspan="3">采购人:${purchaseOrder.CHINESENAME }</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="10" style="text-align:center;vertical-align:bottom;">
                                                                                             第<fmt:formatNumber value="${(i.index)/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${purchaseOrderDetailCnt/10+1}" pattern="0"/>页
                            </td>
                        </tr>
                    </c:if>
                </c:if>
                <!-- 商品条数>=10 -->
                <c:if test="${purchaseOrderDetailCnt >= 10 }">
                    <c:if test="${(i.index + 1) == purchaseOrderDetailCnt }">
                        <tr height="30px">
                            <td colspan="12">备注:${purchaseOrder.REMARKS }</td>
                        </tr>
                        <tr>
                            <td colspan="6"></td>
                            <td>总数量:${purchaseOrder.SUM_QUANTITY }</td>
                            <td colspan="3">总金额:${purchaseOrder.PAYABLE_AMOUNT }元</td>
                        </tr>
                        <tr >
                            <td colspan="2"></td>
                            <td colspan="4">审核人:${purchaseOrder.CHECKER }</td>
                            <td colspan="3">采购人:${purchaseOrder.CHINESENAME }</td>
                        </tr>
                    </c:if>
                    <!-- 商品总条数能被10整除 -->
                    <c:if test="${purchaseOrderDetailCnt % 10 == 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${purchaseOrderDetailCnt/10}" pattern="0"/>页</td>
                            </tr>
                        </c:if> 
                    </c:if>
                    <!-- 商品总条数不能被10整除 -->
                    <c:if test="${purchaseOrderDetailCnt % 10 != 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${purchaseOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
                            </tr>
                        </c:if>
                        <c:if test="${i.index +1==purchaseOrderDetailCnt  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${purchaseOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
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
