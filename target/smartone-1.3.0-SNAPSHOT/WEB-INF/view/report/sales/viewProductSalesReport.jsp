<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %> 
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
 cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
    <site-control permitted-cross-domain-policies="master-only"/>
    <allow-access-from domain="http://192.168.10.101/*"/>
    <allow-http-request-headers-from domain="*.adobe.com" headers="SOAPAction"/>
</cross-domain-policy>
 <html>
 <title></title>
 <head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" >
<link href="/resources/css/jqpagination.css" rel="stylesheet" type="text/css" >
<!-- JS -->
<script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>  
<script src="/resources/js/jqpagination/jquery.jqpagination.min.js" type="text/javascript"></script>
<script src="/resources/js/tablesorter/jquery.tablesorter.min.js" type="text/javascript"></script>  
<script src="/resources/js/tablesorter/jquery.metadata.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var currentPage = 1;
    var totalPages = 0;
    var pageSize = 10;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,
            //是否允许 左边可以调整大小
            allowRightResize: false,
            //是否允许 右边可以调整大小
            allowTopResize: false,
            //是否允许 头部可以调整大小
            allowBottomResize: false 
            //是否允许 底部可以调整大小
        });
        $(".reportType").click(function(){
            var reportTypeName = $("input:checked").val()+"Div";
            $("#"+reportTypeName).siblings().hide();
            $("#"+reportTypeName).show(100);
        });
        //spf_initGrid();
        $("#YEARLYDiv").hide();
        refreshDataM();
        refreshDataY();
        //$("#productMonthlyTable").tablesorter();
        //$("#productYearlyTable").tablesorter();
        $('#paginationM').jqPagination({
            current_page : 1,
            max_page : totalPages,
            page_string : '<spring:message code="report.the"/>{current_page}<spring:message code="report.page"/>,<spring:message code="report.total"/>{max_page}<spring:message code="report.page"/>',
            paged: function(page) {
                currentPage = page;
                refreshDataM();
            }
        });
        $('#paginationY').jqPagination({
            current_page : 1,
            max_page : totalPages,
            page_string : '<spring:message code="report.the"/>{current_page}<spring:message code="report.page"/>,<spring:message code="report.total"/>{max_page}<spring:message code="report.page"/>',
            paged: function(page) {
                currentPage = page;
                refreshDataY();
            }
        });
        $('#productMonthlyTable th').click(function(c){
            if($(this).attr("class")=="desc"){
                $(this).attr("class","sc");
            }else{
                if($(this).attr("class")=="sc"){
                    $(this).attr("class","desc");
                }else{
                    $("#productMonthlyTable th").removeClass("desc");
                    $("#productMonthlyTable th").removeClass("sc");
                    $(this).addClass("desc");
                }
            }
            refreshDataM();
        });
        $('#productYearlyTable th').click(function(c){
            if($(this).attr("class")=="desc"){
                $(this).attr("class","sc");
            }else{
                if($(this).attr("class")=="sc"){
                    $(this).attr("class","desc");
                }else{
                    $("#productYearlyTable th").removeClass("desc");
                    $("#productYearlyTable th").removeClass("sc");
                    $(this).addClass("desc");
                }
            }
            refreshDataY();
        });
    });

    function refreshDataM() {
        var paYear = $("#paYear").val();
        var orderby = "";
        if($("#productMonthlyTable .desc").attr("id")!=undefined){
            orderby = $("#productMonthlyTable .desc").attr("id") + " "
                +$("#productMonthlyTable .desc").attr("class");
        }
        if($("#productMonthlyTable .sc").attr("id")!=undefined){
            orderby = $("#productMonthlyTable .sc").attr("id");
        }
        $.ajax({
            type : "post",
            dataType : "json",
            url : '/report/sales/getProductMonthlySalesList',
            data : "PA_YEAR=" + paYear + "&pagesize=" + pageSize + "&page="
                + currentPage+"&orderby=" + orderby,
            async : false,
            success : function(data) {
                $("#databodyM").html("");
                var innerHtml = [];
                var total = 0;
                for ( var i = 0; i < data.Rows.length; i++) {
                    total = 0;
                    innerHtml.push("<tr>");
                    if(data.Rows[i].PRODUCT_NAME.length > 9){
                        innerHtml.push("<td class='t1'>" + data.Rows[i].PRODUCT_NAME.substr(0,8)+ "..</td>");
                    }
                    else{
                        innerHtml.push("<td class='t1'>" + data.Rows[i].PRODUCT_NAME+ "</td>");
                    }
                    innerHtml.push("<td>" + data.Rows[i].JAN_SUM + "</td>");
                    total += data.Rows[i].JAN_SUM;
                    innerHtml.push("<td>" + data.Rows[i].FEB_SUM + "</td>");
                    total += data.Rows[i].FEB_SUM;
                    innerHtml.push("<td>" + data.Rows[i].MAR_SUM + "</td>");
                    total += data.Rows[i].MAR_SUM;
                    innerHtml.push("<td>" + data.Rows[i].APR_SUM + "</td>");
                    total += data.Rows[i].APR_SUM;
                    innerHtml.push("<td>" + data.Rows[i].MAY_SUM + "</td>");
                    total += data.Rows[i].MAY_SUM;
                    innerHtml.push("<td>" + data.Rows[i].JUN_SUM + "</td>");
                    total += data.Rows[i].JUN_SUM;
                    innerHtml.push("<td>" + data.Rows[i].JUL_SUM + "</td>");
                    total += data.Rows[i].JUL_SUM;
                    innerHtml.push("<td>" + data.Rows[i].AUG_SUM + "</td>");
                    total += data.Rows[i].AUG_SUM;
                    innerHtml.push("<td>" + data.Rows[i].SEP_SUM + "</td>");
                    total += data.Rows[i].SEP_SUM;
                    innerHtml.push("<td>" + data.Rows[i].OCT_SUM + "</td>");
                    total += data.Rows[i].OCT_SUM;
                    innerHtml.push("<td>" + data.Rows[i].NOV_SUM + "</td>");
                    total += data.Rows[i].NOV_SUM;
                    innerHtml.push("<td>" + data.Rows[i].DEC_SUM + "</td>");
                    total += data.Rows[i].DEC_SUM;
                    innerHtml.push("<td>" + total + "</td>");
                }
                $("#databodyM").append(innerHtml.join(""));
                //$("#productMonthlyTable").trigger("update");
                totalPages = parseInt(data.Total/pageSize);
                if((data.Total-totalPages*pageSize)>0){
                    totalPages ++;
                }
            }
        });
    }
    
    function refreshDataY() {
    	var orderby = "";
        if($("#productYearlyTable .desc").attr("id")!=undefined){
            orderby = $("#productYearlyTable .desc").attr("id") + " "
                +$("#productYearlyTable .desc").attr("class")
        }
        if($("#productYearlyTable .sc").attr("id")!=undefined){
            orderby = $("#productYearlyTable .sc").attr("id");
        }
        $.ajax({
            type : "post",
            dataType : "json",
            url : '/report/sales/getProductYearlySalesList',
            data : "PA_YEAR=${ZER_AGO}" + "&pagesize=" + pageSize + "&page="
                + currentPage+"&orderby=" + orderby,
            async : false,
            success : function(data) {
                $("#databodyY").html("");
                var innerHtml = [];
                var total = 0;
                for ( var i = 0; i < data.Rows.length; i++) {
                    total = 0;
                    innerHtml.push("<tr>");
                    if(data.Rows[i].PRODUCT_NAME.length > 18){
                        innerHtml.push("<td class='t1'>" + data.Rows[i].PRODUCT_NAME.substr(0,17)+ "..</td>");
                    }
                    else{
                        innerHtml.push("<td class='t1'>" + data.Rows[i].PRODUCT_NAME+ "</td>");
                    }
                    innerHtml.push("<td>" + data.Rows[i].FOU_AGO_SUM + "</td>");
                    total += data.Rows[i].FOU_AGO_SUM;
                    innerHtml.push("<td>" + data.Rows[i].THR_AGO_SUM + "</td>");
                    total += data.Rows[i].THR_AGO_SUM;
                    innerHtml.push("<td>" + data.Rows[i].TWO_AGO_SUM + "</td>");
                    total += data.Rows[i].TWO_AGO_SUM;
                    innerHtml.push("<td>" + data.Rows[i].ONE_AGO_SUM + "</td>");
                    total += data.Rows[i].ONE_AGO_SUM;
                    innerHtml.push("<td>" + data.Rows[i].ZER_AGO_SUM + "</td>");
                    total += data.Rows[i].ZER_AGO_SUM;
                    innerHtml.push("<td>" + total + "</td>");
                }
                $("#databodyY").append(innerHtml.join(""));
                //$("#productYearlyTable").trigger("update");
                totalPages = parseInt(data.Total/pageSize);
                if((data.Total-totalPages*pageSize)>0){
                    totalPages ++;
                }
            }
        });
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99%;
    margin: 0;
    padding: 0;
}

h4 {
    margin: 20px;
}

/*月度表格斜线*/
#productSalesMonth table {
    border-collapse: collapse;
    border: 1px #525152 solid;
    width: 1000px;
    margin: 0auto;
}

#productSalesYear table {
    border-collapse: collapse;
    border: 1px #525152 solid;
    width: 1000px;
    margin: 0auto;
}

#productSalesMonth th {
    height:31px;
    overflow:hidden;
    border: 1px #000000 solid;
    text-align: center;
    font-size: 12px;
    background: #C1DBFA;
    width : 7.1%
}

#productSalesYear th {
    height:31px;
    overflow:hidden;
    border: 1px #000000 solid;
    text-align: center;
    font-size: 12px;
    background: #C1DBFA;
    width : 14%
}

#productSalesMonth td {
    height:31px;
    overflow:hidden;
    border: 1px #000000 solid;
    text-align: center;
    font-size: 12px;
    background: white;
    width : 7.1%
}

#productSalesYear td {
    height:31px;
    overflow:hidden;
    border: 1px #000000 solid;
    text-align: center;
    font-size: 12px;
    background: white;
    width : 14%
}

#productSalesMonth #out {
    border-top: 40px #C1DBFA solid; /*上边框宽度等于表格第一行行高*/
    width: 0px; /*让容器宽度为0*/
    height: 0px; /*让容器高度为0*/
    border-left: 80px yellow solid; /*左边框宽度等于表格第一行第一格宽度*/
    position: relative; /*让里面的两个子容器绝对定位*/
}

#productSalesYear #out {
    border-top: 41px #C1DBFA solid; /*上边框宽度等于表格第一行行高*/
    width: 0px; /*让容器宽度为0*/
    height: 0px; /*让容器高度为0*/
    border-left: 142px yellow solid; /*左边框宽度等于表格第一行第一格宽度*/
    position: relative; /*让里面的两个子容器绝对定位*/
}

#productSalesMonth #up {
    font-style: normal;
    display: block;
    position: absolute;
    top: -40px;
    left: -40px;
    width: 35px;
}

#productSalesYear #up {
    font-style: normal;
    display: block;
    position: absolute;
    top: -40px;
    left: -50px;
    width: 35px;
}

#productSalesMonth #down {
    font-style: normal;
    display: block;
    position: absolute;
    top: -25px;
    left: -70px;
    width: 55x;
}

#productSalesYear #down {
    font-style: normal;
    display: block;
    position: absolute;
    top: -25px;
    left: -105px;
    width: 55x;
}

#productSalesMonth .t1,#productSalesYear .t1 {
    background: yellow
}

#productSalesMonth .desc, #productSalesYear .desc {
    background-color: #ff0000
}

#productSalesMonth .sc, #productSalesYear .sc {
    background-color: #00ff00
}
</style>
</head>
<body style="padding: 2px">
    <table align="center" cellpadding="0" cellspacing="0" style="margin-left:20px">
        <tr height="50">
            <td class="l-table-edit-c" width="100%" align="left">
                <input type="radio" name="reportType" id="MONTHLY" class="reportType" value="MONTHLY" checked="checked"/>
                    <label for="NO" style="font-family:verdana;color:blue;font-size:150%;height: 50px"><spring:message code="report.statisticsByMonth"/></label>
                <input type="radio" name="reportType" id="YEARLY" class="reportType" value="YEARLY" style="margin-left:25px;"/>
                    <label for="YES" style="font-family:verdana;color:blue;font-size:150%;height: 50px"><spring:message code="report.statisticsByYear"/></label>
            </td>
        </tr>
    </table>
    <div id="layout1" style="margin-left:20px">
        <!-- 月度报表 -->
        <div id='MONTHLYDiv'>
            <table width="90%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="report.years"/></td>
                    <td width="80%" class="l-table-edit-c">
                        <SipingSoft:date yearName="paYear" onChange="refreshDataM();"/>
                    </td>
                </tr>
            </table>
            <br />
            <div id='productSalesMonth' style='height:400px; width:95%'>
                <table id="productMonthlyTable">
                    <thead>
                        <tr>
                            <th style="width:80px;" id="PRODUCT_NAME">
                                <div id="out">
                                    <div id="up"><spring:message code="report.month"/></div><div id="down"><spring:message code="report.product"/></div>
                                </div>
                            </th>
                            <th id="JAN_SUM"><spring:message code="report.january"/></th>
                            <th id="FEB_SUM"><spring:message code="report.february"/></th>
                            <th id="MAR_SUM"><spring:message code="report.march"/></th>
                            <th id="APR_SUM"><spring:message code="report.april"/></th>
                            <th id="MAY_SUM"><spring:message code="report.may"/></th>
                            <th id="JUN_SUM"><spring:message code="report.june"/></th>
                            <th id="JUL_SUM"><spring:message code="report.july"/></th>
                            <th id="AUG_SUM"><spring:message code="report.august"/></th>
                            <th id="SEP_SUM"><spring:message code="report.september"/></th>
                            <th id="OCT_SUM"><spring:message code="report.october"/></th>
                            <th id="NOV_SUM"><spring:message code="report.november"/></th>
                            <th id="DEC_SUM"><spring:message code="report.december"/></th>
                            <th id="total"><spring:message code="report.totalSales"/></th>
                        </tr>
                    </thead>
                    <tbody id="databodyM">
                    </tbody>
                </table>
            </div>
            <div class="pagination" id="paginationM">
                <a href="#" class="first" data-action="first">&laquo;</a>
                <a href="#" class="previous" data-action="previous">&lsaquo;</a>
                <input type="text" readonly="readonly" data-max-page="40" />
                <a href="#" class="next" data-action="next">&rsaquo;</a>
                <a href="#" class="last" data-action="last">&raquo;</a>
            </div>
        </div>
        
        <!-- 年度报表 -->
        <div id='YEARLYDiv'>
            <br />
            <div id='productSalesYear' style='height:400px; width:95%'>
                <table id="productYearlyTable">
                    <thead>
                        <tr>
                            <th style="width:80px;" id="PRODUCT_NAME">
                                <div id="out">
                                    <div id="up"><spring:message code="report.years"/></div><div id="down"><spring:message code="report.product"/></div>
                                </div>
                            </th>
                            <th id="FOU_AGO_SUM">${FOU_AGO}<spring:message code="hrms.year"/></th>
                            <th id="THR_AGO_SUM">${THR_AGO}<spring:message code="hrms.year"/></th>
                            <th id="TWO_AGO_SUM">${TWO_AGO}<spring:message code="hrms.year"/></th>
                            <th id="ONE_AGO_SUM">${ONE_AGO}<spring:message code="hrms.year"/></th>
                            <th id="ZER_AGO_SUM">${ZER_AGO}<spring:message code="hrms.year"/></th>
                            <th id="total"><spring:message code="report.totalSales"/></th>
                        </tr>
                    </thead>
                    <tbody id="databodyY">
                    </tbody>
                </table>
            </div>
            <div class="pagination" id="paginationY">
                <a href="#" class="first" data-action="first">&laquo;</a>
                <a href="#" class="previous" data-action="previous">&lsaquo;</a>
                <input type="text" readonly="readonly" data-max-page="40" />
                <a href="#" class="next" data-action="next">&rsaquo;</a>
                <a href="#" class="last" data-action="last">&raquo;</a>
            </div>
        </div>
    </div>
</body>
</html>