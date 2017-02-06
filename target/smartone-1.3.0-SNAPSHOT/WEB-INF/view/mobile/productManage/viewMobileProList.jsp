<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css">

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    $(document).ready(function() {
        if ($("#PRODUCT_CATEGORY_ID").val() != "") {
            $("#tipSearch").html("${paramMap.ROOT_CATEGORY }\/${paramMap.CATEGORY_NAME }");
        }else if($("#M_AREA_NO").val() != ""){
            $("#tipSearch").html($("#M_AREA_NAME").val());
        } else {
            if ($("#search").val() == "") {
                $("#tipSearch").html('搜索到${page.allCount}条结果');
            } else {
                $("#tipSearch").html("与\"" + $("#search").val()+ "\"有关的共有${page.allCount}件商品");
            }
        }
    });
    
    $("#goPage").live("tap",function(){
        if(isNaN($("#pageNum").val())||$("#pageNum").val()<1){
            alert("请输入正确的页码");
            $("#pageNum").val("");
        }else{
            var pageNo = 1;
            if($("#pageNum").val()>${page.allPages }){
                pageNo = ${page.allPages };
            }else{
                pageNo = $("#pageNum").val();
            }
            spf_search(parseInt(pageNo));
        }
    });
    
    function getProByNameOrder(){
        $("#ORDER_BY").val("NLSSORT(PRODUCT_NAME,'NLS_SORT = SCHINESE_PINYIN_M')");
        if($("#ASC_OR_DESC").val()!="ASC"){
            $("#ASC_OR_DESC").val("ASC");
        }else{
            $("#ASC_OR_DESC").val("DESC");
        }
        spf_search(1);
    }
    
    function getProByPriceOrder(){
        $("#ORDER_BY").val("UNIT_PRICE");
        if($("#ASC_OR_DESC").val()!="ASC"){
            $("#ASC_OR_DESC").val("ASC");
        }else{
            $("#ASC_OR_DESC").val("DESC");
        }
        spf_search(1);
    }
</script>
<style type="text/css">
div {
    font-family: "微软雅黑";
}

.proDetailTable {
    width: 100%;
    font-family: '微软雅黑';
    color: #456f9a;
    font-size: 12px;
    border-collapse: collapse;
    margin-top: 5px;
    background-color: white;
}

.ui-content{
    padding : 2px;
}
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <div data-role="content" style="background-color: #eeeeee;">
            <input type="hidden" id="PRODUCT_CATEGORY_ID" value="${paramMap.PRODUCT_CATEGORY_ID }"/>
            <input type="hidden" id="CATEGORY_NAME" value="${paramMap.CATEGORY_NAME }"/>
            <input type="hidden" id="ROOT_CATEGORY" value="${paramMap.ROOT_CATEGORY }"/>
            <input type="hidden" id="M_AREA_NO" value="${paramMap.M_AREA_NO }"/>
            <input type="hidden" id="M_AREA_NAME" value="${paramMap.M_AREA_NAME }"/>
            <input type="hidden" id="ORDER_BY" value="${paramMap.ORDER_BY }"/>
            <input type="hidden" id="ASC_OR_DESC" value="${paramMap.ASC_OR_DESC }"/>
        
            <div style="width: 100%;">
                <table style="width: 100%">
                    <tr>
                        <td width="70%"><input type="search" name="search" id="search" value="${paramMap.keyWord }" style="font-family: '微软雅黑'; color: #456f9a;" /></td>
                        <td width="3%">&nbsp;</td>
                        <td><input type="submit" name="submit" id="searchButton" value="<spring:message code='search' />" /></td>
                    </tr>
                </table>
            </div>
            <table style="width:100%;">
                <tr>
                    <td align="left"><div id="tipSearch" style="font-size: 13px; color: #456f9a;"></div></td>
                    <td style="font-size:14px; width:150px;color: #456f9a;">
                        <a href="javascript:getProByNameOrder()">名称排序</a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="javascript:getProByPriceOrder()">价格排序</a>
                    </td>
                </tr>
            </table>

            <div style="width: 100%">
                <c:forEach var="product" items="${productList }">
                    <table class="proDetailTable" pno="${product.PRODUCT_NO }" pid="${product.PRODUCT_ID }">
                        <tr>
                            <td rowspan="4" width="90" align="left">
                                <img src="/resources/picture/product/${product.PRODUCT_ID }.jpg" id="proImage" onerror="this.src='/resources/picture/none.gif'"
                                    class="proImage" style="width: 100px; height: 100px;" pno="${product.PRODUCT_NO }" pid="${product.PRODUCT_ID }" /></td>
                        </tr>
                        <tr style="height: 25px;">
                            <td colspan="3" width="100" >${product.PRODUCT_NAME }</td>
                        </tr>
                        <tr>
                            <td>规格：</td>
                            <td colspan="2" width="100" >${product.SPECIFICATION }</td>
                        </tr>
                        <tr>
                            <td style="width: 40px;"><spring:message code="hrms.unitPrice" />:</td>
                            <td width="20%">￥${product.salePrice }
                                <input id="salePrice${product.PRODUCT_NO }" type="hidden" value="${product.salePrice }"/>
                                <input id="PRODUCT${product.PRODUCT_NO }" type="hidden" value="${product }"/>
                            </td>
                            <td style="padding-right: 20px;">
                                <div style="width:50%;float:left;text-align:center;line-height:30px;"><input id="number${product.PRODUCT_NO }" type="number" class="buyCount" value="1"/></div>
                                <div style="width:50%;float:left;text-align:center;line-height:30px;">
                                    <img class="addToCart" style="width: 50px;height: 50px;" pno="${product.PRODUCT_NO }" src="/resources/images/myimage/cart.png"/></div>
                            </td>
                        </tr>
                    </table>
                </c:forEach>
            </div>

            <div style="width: 100%; text-align: center; font-size: 12px; margin-top: 5px;">
                <a href="javascript:spf_search(${page.prePage })"><spring:message code='mobile.prePage' /></a>
                &nbsp;&nbsp;<a href="#e2" data-rel="dialog" style="font-size:14px;">${page.currentPage }/${page.allPages }</a>&nbsp;&nbsp;
                <a href="javascript:spf_search(${page.nextPage })"><spring:message code='mobile.nextPage' /></a>
            </div>
            <div style="clear:both;">
                <img id="back" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
            </div>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
    
    <!-- 一下是点击各修改按钮后相关弹出界面 -->
    <div data-role="page" id="e2" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>请输入页码</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><input id="pageNum" type="text"/></td>
                    <td align="right"><div style="width:100px;"><a href="#e1" id="goPage" data-role="button">前往</a></div></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>