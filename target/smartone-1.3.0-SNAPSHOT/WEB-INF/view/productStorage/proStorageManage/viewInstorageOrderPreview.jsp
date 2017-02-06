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
            <c:forEach items="${instorageOrderDetail}" var="pur" varStatus="i">
                <c:if test="${i.index%10==0 }">
                    <tr>
                        <td colspan="11" align="center" id="td${i.index }">
                            <h4>${instorageOrder.CPNY_NAME } 入库单</h4>
                        </td>
                    </tr>
                    <tr height="20px">
                        <td colspan="4">入库单号:${instorageOrder.INSTORAGE_ID }</td>
                        <td colspan="5">采购单号:${instorageOrder.PURCHASE_ORDER_ID }</td>
                    </tr>
                    <tr height="20px">
                        <td colspan="4">入库日期:${instorageOrder.IN_DATE }</td>
                        <td colspan="5">供货商:${instorageOrder.SUPPLIER_NAME }</td>
                    </tr>
                    <tr class="showBorder">
                        <td width="25px">序号</td>
                        <td width="70px">货品编号</td>
                        <td width="100px">品名</td>
                        <td width="100px">规格</td>
                        <!-- <td width="60px">CAS</td> -->
                        <td width="40px">单位</td>
                        <td width="40px">单价</td>
                        <td width="40px">数量</td>
                        <td width="40px">金额</td>
                        <td width="40px">仓库</td>
                    </tr>
                </c:if>
                <tr class="showBorder">
                    <td>${i.index+1}</td>
                    <td>${pur.PRODUCT_ID}</td>
                    <td>${pur.PRODUCT_NAME}</td>
                    <td>${pur.SPECIFICATION}</td>
                    <!--<td>${pur.PRODUCT_CAS}</td>  -->
                    <td>${pur.UNIT_NAME}</td>
                    <td style="text-align:right">${pur.UNIT_PRICE}</td>
                    <td style="text-align:right">${pur.QUANTITY}</td>
                    <td style="text-align:right"><fmt:formatNumber value="${pur.SUMMONEY}" pattern="0.00"/></td>
                    <td>${pur.STORAGE_NAME}</td>
                </tr>
                <!-- 商品条数<10 -->
                <c:if test="${instorageOrderDetailCnt < 10 }">
                    <c:if test="${(i.index + 1) == instorageOrderDetailCnt }">
                        <tr height="30px">
                            <td colspan="12">备注:${instorageOrder.REMARKS }</td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                            <td colspan="2">总数量:${instorageOrder.QUANTITY_SUM }</td>
                            <td colspan="3">总金额:${instorageOrder.PRICE_SUM }元</td>
                        </tr>
                        <tr >
                            <td colspan="2"></td>
                            <td>入库人:${instorageOrder.ENAME }</td>
                            <td colspan="2">制单人:${basicInfo.CHINESENAME }</td>
                        </tr>
                        <tr height="20px">
                            <td colspan="10" style="text-align:center;vertical-align:bottom;">
                                                                                               第<fmt:formatNumber value="${(i.index)/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${instorageOrderDetailCnt/10+1}" pattern="0"/>页
                            </td>
                        </tr>
                    </c:if>
                </c:if>
                <!-- 商品条数>=10 -->
                <c:if test="${instorageOrderDetailCnt >= 10 }">
                    <c:if test="${(i.index + 1) == instorageOrderDetailCnt }">
                        <tr height="30px">
                            <td colspan="12">备注:${instorageOrder.REMARKS }</td>
                        </tr>
                        <tr>
                            <td colspan="5"></td>
                            <td colspan="2">总数量:${instorageOrder.QUANTITY_SUM }</td>
                            <td colspan="3">总金额:${instorageOrder.PRICE_SUM }元</td>
                        </tr>
                        <tr >
                            <td colspan="2"></td>
                            <td>入库人:${instorageOrder.ENAME }</td>
                            <td colspan="2">制单人:${basicInfo.CHINESENAME }</td>
                        </tr>
                    </c:if>
                    <!-- 商品总条数能被10整除 -->
                    <c:if test="${instorageOrderDetailCnt % 10 == 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${instorageOrderDetailCnt/10}" pattern="0"/>页</td>
                            </tr>
                        </c:if> 
                    </c:if>
                    <!-- 商品总条数不能被10整除 -->
                    <c:if test="${instorageOrderDetailCnt % 10 != 0 }">
                        <c:if test="${(i.index +1)%10==0  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10}" pattern="0"/>页/共<fmt:formatNumber value="${instorageOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
                            </tr>
                        </c:if>
                        <c:if test="${i.index +1==instorageOrderDetailCnt  }">
                            <tr height="20px">
                                <td colspan="10" style="text-align:center;vertical-align:bottom;">第<fmt:formatNumber value="${i.index/10+1}" pattern="0"/>页/共<fmt:formatNumber value="${instorageOrderDetailCnt/10 + 1}" pattern="0"/>页</td>
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
