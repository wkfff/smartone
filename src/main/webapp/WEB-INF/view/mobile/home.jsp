<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Home</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

<link rel="stylesheet" href="/resources/css/mobile/idangerous.swiper.css" />
<link rel="stylesheet" href="/resources/css/mobile/style.css" />

<!-- jquery mobile css -->
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css" />
<!-- <link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" /> -->

<!-- jquery mobile js -->
<script src="/resources/js/jquery/jquery-1.7.1.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>

<!-- Swiper -->
<script src="/resources/js/swiper/idangerous.swiper-1.8.min.js"></script>
<!-- Swiper Scrollbar plugin -->
<script src="/resources/js/swiper/idangerous.swiper.scrollbar-1.0.js"></script>
<!-- Demos code -->
<script src="/resources/js/swiper/swiper-demos.js?v=1.8"></script>

<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">

</script>
<style type="text/css">
html{
    width: 98%;
}
.areaTitle {
    width: 100%;
    font-family: "微软雅黑";
    border-top:1px solid #e6e6e6;
    color: #fca20e;
}
.areaTitle1 {
    width: 48%;
    text-align: left;
    height: 40px;
    line-height: 40px;
    font-size: 18px;
    float: left;
    text-indent: 1em;
}
.areaTitle2 {
    width: 48%;
    text-align: right;
    height: 40px;
    line-height: 40px;
    font-size: 12px;
    float: left;
}

.areaDiv {
    background-color: white;
    width:100%;
}
.proImage {
    margin-bottom: 2px;
    width: 100px;
    height: 100px;
}
.ui-content{
    padding : 2px;
}
.proNameArea{
    height: 40px;
    text-align: left;
    position: relative;
    width: 90%;
    top: -20px;
    font-size: 10px;
}
.priceArea{
    position: relative;
    bottom: 20px;
    color: red;
    background-color: rgb(236, 236, 236);
    width: 100px;
    text-align: center;
    opacity:0.6;
}
.login-area{
    width: 100%;
    height: 35px;
    line-height: 35px;
    text-align: right;
    font-size: 17px;
}
</style>
</head>
<body>
    <div data-role="page" id="e1" data-theme="b">
        <div data-role="header" data-theme="c">
            <c:if test="${sessionScope.LoginUser==null }">
            <div class="login-area">欢迎你,
                <a id="login-link">登录</a>&nbsp;&nbsp;&nbsp;&nbsp;没有账号?马上
                <a id="regist-link">注册</a>&nbsp;&nbsp;&nbsp;
            </div>
            </c:if>
            <div role="main" class="main">
                <div class="home-device">
                    <div class="swiper-main">
                        <div class="swiper-container swiper1">
                            <div class="swiper-wrapper">
                                <c:if test="${fn:length(advList)==0 }">
                                    <div class="swiper-slide">
                                        <img src="/resources/images/myimage/welcome.gif" style="height: 100%;height: 160px;"
                                            onerror="this.src='/resources/picture/none.gif'"/>
                                    </div>
                                </c:if>
                                <c:forEach var="advItem" items="${advList}">
                                    <div class="swiper-slide">
                                        <img src="/resources/picture/mobileAdv/${advItem.PHOTOPATH }" style="width:100%; height: 160px;" pno="${advItem.PRODUCT_NO }" pid="${advItem.PRODUCT_ID }"
                                            onerror="this.src='/resources/picture/none.gif'" class="proImage" />
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="pagination pagination1"></div>
                </div>
            </div>
        </div>
        <div data-role="content" >
            <input type="hidden" id="PRODUCT_CATEGORY_ID" value="${PRODUCT_CATEGORY_ID }"/>
            <input type="hidden" id="CATEGORY_NAME" value="${CATEGORY_NAME }"/>
            <input type="hidden" id="ROOT_CATEGORY" value="${ROOT_CATEGORY }"/>
            <input type="hidden" id="M_AREA_NO" value="${M_AREA_NO }"/>
            <input type="hidden" id="M_AREA_NAME" value="${M_AREA_NAME }"/>
            <input type="hidden" id="ORDER_BY" value="${ORDER_BY }"/>
            <input type="hidden" id="ASC_OR_DESC" value="${ASC_OR_DESC }"/>
            <div style="width: 100%;" align="right">
                <table style="width: 100%;">
                    <tr>
                        <td><input type="search" id="search" placeholder="输入关键字查找"/></td>
                        <td><button id="searchButton" data-inline="true">搜索</button></td>
                    </tr>
                </table>
            </div>

            <c:forEach var="areaItem" items="${areaList}">
                <c:if test="${areaItem.proList!='[]'}">
                <div class="areaDiv">
                    <div class="areaTitle">
                        <div class="areaTitle1">${areaItem.M_AREA_NAME }</div>
                        <div class="areaTitle2" no="${areaItem.M_AREA_NO }" name="${areaItem.M_AREA_NAME }">●●●</div>
                    </div>
                    <c:forEach var="proItem" items="${areaItem.proList}" begin="0" end="2">
                        <div style="width:33%;float:left;left: 1%;position:relative;">
                            <img src="/resources/picture/product/${proItem.PRODUCT_ID }.jpg" id="proImage" onerror="this.src='/resources/picture/none.gif'" 
                                pno="${proItem.PRODUCT_NO }" pid="${proItem.PRODUCT_ID }" class="proImage" />
                            <div class="priceArea">￥${proItem.salePrice }</div>
                            <div class="proNameArea">${proItem.PRODUCT_NAME }</div>
                        </div>
                    </c:forEach>
                </div>
                </c:if>
            </c:forEach>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
</body>
</html>