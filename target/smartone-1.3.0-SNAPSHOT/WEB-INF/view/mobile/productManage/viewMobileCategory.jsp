<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
<!-- <link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>
<script type="text/javascript">
	$(".rootCategoryDiv").live("tap", function() {
	    if($(this).next(".rootDetail").css("display")!="none"){
	        $(this).next(".rootDetail").hide();
	    }else{
	        $(this).next(".rootDetail").show();
	    }
	});
	$(".sonCategoryDiv").live("tap", function() {
	    $("#PRODUCT_CATEGORY_ID").val($(this).attr("value"));
	    $("#CATEGORY_NAME").val($(this).text());
	    $("#ROOT_CATEGORY").val($(this).parent("div").prev("div").text());
	    spf_search(1);
    });
</script>
<style type="text/css">
div{
    font-family:"微软雅黑";
}
div[data-role="page"]{
    height:100%;
}
.rootCategoryDiv{
    clear:both;
    width:100%;
    height:30px;
    line-height:30px;
    font-size:18px;
    margin-bottom:5px;
    color: blue;
}
.rootDetail{
    width:100%;
}
.sonCategoryDiv{
    width:24%;
    height:25px;
    text-align:center;
    line-height:25px;
    background-color:white;
    border:1px solid #d9d9d9;
    float:left;
}
</style>
</head>
<body>
	<div data-role="page" data-theme="b">
		<div data-role="header" data-theme="b">
			<h1>类目浏览</h1>
		</div>
		<div data-role="content">
            <input type="hidden" id="PRODUCT_CATEGORY_ID" value=""/>
            <input type="hidden" id="CATEGORY_NAME" value=""/>
            <input type="hidden" id="ROOT_CATEGORY" value=""/>
            <input type="hidden" id="search" value="" />
            <input type="hidden" id="M_AREA_NO" value=""/>
            <input type="hidden" id="M_AREA_NAME" value=""/>
            <input type="hidden" id="ORDER_BY" value=""/>
            <input type="hidden" id="ASC_OR_DESC" value=""/>
		    <div style="width:100%;height:300px;font-size:15px;">
            <c:forEach var="category" items="${categoryList }">
                <div class="rootCategoryDiv">&gt;${category.CATEGORY_NAME }</div>
                <div class="rootDetail" style="width:100%;">
                    <div class="sonCategoryDiv" value="${category.CATEGORY_ID }">全部</div>
                    <c:forEach var="sonCategory" items="${category.sonList }">
		                <div class="sonCategoryDiv" value="${sonCategory.CATEGORY_ID }">${sonCategory.CATEGORY_NAME }</div>
		            </c:forEach>
                </div>
            </c:forEach>
            </div>
		</div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
	</div>
</body>
</html>