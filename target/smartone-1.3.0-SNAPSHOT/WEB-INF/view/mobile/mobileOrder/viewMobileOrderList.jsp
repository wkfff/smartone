<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>我的订单</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0">
<!-- <link rel="stylesheet" nhref="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    $("#menuTable td").live("tap", function() {
        $(this).siblings().removeClass("menuTab").end().addClass("menuTab");
        $("#tabShowDiv"+$(this).attr("id")).siblings("div").hide().end().show();
    });
    
    $("#tab1").live("tap",function(){
        spf_initTab(1,"","","","tab1","inDoing");
    });
    
    $("#tab2").live("tap",function(){
        spf_initTab(1,"","affirm2","","tab2","");
    });
    
    $("#tab3").live("tap",function(){
        spf_initTab(1,"outStatus1","affirm1","SaleOrderState1","tab3","");
    });
    
    $(".goPage").live("tap",function(){
        spf_initTab($(this).attr("value"),$("#outStatus").val(),$("#currentAffirm").val(),$("#currentTraStatus").val(),$("#currentTab").val());
    });
    
    $(function(){
        spf_initTab(1,"","","","tab1","inDoing");
    });
    
    function spf_initTab(page,outStatus,affirm,traStatus,tabid,inDoing){
        $(".tabDivClass").hide();
        $("#div"+tabid).show();
        
        $("#outStatus").val(outStatus);
        $("#currentTab").val(tabid);
        $("#currentAffirm").val(affirm);
        $("#currentTraStatus").val(traStatus);
        $.post("/mobile/mobileOrder/getMySalesOrders", 
            [   
                { name: 'AFFIRM_FLAG', value: affirm },
                { name: 'OUT_STATUS', value: outStatus},
                { name: 'TRA_STATUS', value: traStatus },
                { name: 'IN_DOGING', value: inDoing },
                { name: 'page', value: page},
                { name: 'pagesize', value: '5'}
            ], function (result){
                var temp = "";
                $.each(result.Rows,function(i, item) {
                    var products = "";
                    var flag = true;
                    $.each(item.soldProducts,function(k, proItem) {
                        if(k>2){
                            if(flag){
                                products = products +
                                '<div style="float:left;width:10%;padding-top:50px;">'+
                                    '......'+
                                '</div>';
                                flag = false;
                            }
                        }else{
                            var productName = proItem.name;
                            if(productName.length > 8){
                                productName = productName.substr(0,8)+"......";
                            }
                            products = products + 
                            '<div class="proOrderDiv">'+
                                '<table style="width:100%;">'+
                                    '<tr height="65">'+
                                        '<td>'+
                                            '<img src="/resources/picture/product/'+proItem.id+'.jpg" id="proImage" onerror="this.src=\'/resources/picture/none.gif\'" '+
                                            'class="proImage" style="width: 60px; height: 60px;" pno="'+proItem.no+'" pid="'+proItem.id+'" />'+
                                        '</td>'+
                                    '</tr>'+
                                    '<tr height="20"><td align="center">'+productName+'</td></tr>'+
                                '</table>'+
                            '</div>';
                        }
                    });

                    temp = temp + 
                    '<table class="orderTable">'+
                        '<tr style="height:20px;">'+
                            '<td colspan="3" class="orderDate">'+item.orderDate+'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label style="color:#e66e25;">￥'+item.price.discountPrice+'</label></td>'+
                        '</tr>'+
                        '<tr>'+
                            '<td width="70%;">客户：'+item.customer.customerName+'</td>'+
                            '<td align="left" style="font-size:14px;color:blue;width:30%;text-align:right;"><a href="/mobile/mobileOrder/viewSalesOrderDetail?SALES_ORDER_NO='+item.salesOrderNo+'">查看明细&nbsp;&nbsp;</a></td>'+
                        '</tr>'+
                        '<tr>'+
                            '<td colspan="3">'+products+'</td>'+
                        '</tr>'+
                        '<tr style="height:10px;">'+
                            '<td colspan="3" align="right">共'+item.soldProducts.length+'件&nbsp;&nbsp;&nbsp;&nbsp;</td>'+
                        '</tr>'+
                    '</table>';
                });
                if(temp == ""){
                    $("#div"+tabid).html("<div style='width:100%;height:100px;line-height:100px;text-align:center;background-color:white;'>您没有"+$("#"+tabid).text()+"的订单</div>");
                }else{
                    $("#div"+tabid).html(temp);
                }
                $("#prePage").attr("value",result.page.prePage);
                $("#nextPage").attr("value",result.page.nextPage);
                $("#currentPage").text(result.page.currentPage);
                $("#allPages").text(result.page.allPages);
            }
        );
    }
</script>
<style type="text/css">
div{
    font-family:"微软雅黑";
    font-size:14px;
}
.proDetailTable{
    width: 100%; 
    font-family: '微软雅黑'; 
    color: #456f9a;
    font-size:14px;
    border-collapse:collapse;
}
.menuTab{
    background-color:#e66e25;color:white;
}
#tabShowDivtab1 td,#tabShowDivtab2 td{
    border-bottom:1px solid #dddddd;
}
.ui-content{
    padding : 2px;
}
.tabDivClass{
    display:none;
}
.orderTable{
    background-color:white;
    width:100%;
    margin-top:5px;
}
.orderDate{
    border-top:1px dashed #c5c5c5;
}
.proOrderDiv{
    float:left;
    width:30%;
    font-size:12px;
    height:100px;
    float:left;
    text-align:center;
}
a{
    color: #456f9a;
}
.ui-content{
    padding : 2px;
}
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>我的订单</h1>
        </div>
        <div data-role="content">
            <div style="width: 100%">
                <table style="width: 100%;background-color:#dddddd;border:0px;border-collapse:collapse;" id="menuTable">
                    <tr height="30">
                        <td width="33.3%" align="center" class="menuTab" id="tab1">处理中</td>
                        <td width="33.3%" align="center" id="tab2">已取消</td>
                        <td align="center" id="tab3">已完成</td>
                    </tr>
                </table>
                <div class="tabDivClass" id="divtab1"></div>
                <div class="tabDivClass" id="divtab2"></div>
                <div class="tabDivClass" id="divtab3"></div>
                
                <div style="width: 100%; text-align: center; font-size: 12px; margin-top: 5px;">
                    <a class="goPage" id="prePage" value="" href="">上一页</a>
                    &nbsp;第<label id="currentPage"></label>页&nbsp;
                    <a class="goPage" id="nextPage" value="" href="">下一页</a>
                    &nbsp;共<label id="allPages"></label>页
                    <input type="hidden" id="outStatus" value=""/>
                    <input type="hidden" id="currentTab" value=""/>
                    <input type="hidden" id="currentAffirm" value=""/>
                    <input type="hidden" id="currentTraStatus" value=""/>
                </div>
            </div>
            <div style="clear:both;margin-top:50px;">
                <img id="back" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
            </div>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
</body>
</html>