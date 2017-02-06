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
    $("#savePayment").live("tap",function(){
        if($("#paymentMode").val() != ""){
            $("#PAYMENT_CODE").val($("#paymentMode").val());
            $("#PAYMENT_NAME").text($("#paymentMode option:selected").text());
        }else{
            $("#PAYMENT_CODE").val("");
            $("#PAYMENT_NAME").text("");
        }
    });

    $("#custButton").live("tap",function(){
        if($("#custSelect").val() != ""){
            $("#CUST_NO").val($("#custSelect").val());
            $("#CUST_ADDRESS").val($("#custSelect option:selected").attr("address"));
            $("#CUST_NAME").text($("#custSelect option:selected").text());
            $("#SALES_MODE_NO").val($("#custSelect option:selected").attr("salesModeNo"));
        }else{
            $("#CUST_NO").val("");
            $("#CUST_ADDRESS").val("");
            $("#CUST_NAME").text("");
            $("#SALES_MODE_NO").val("${saleMode.SALES_MODE_NO }");
        }
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/mobile/mobileOrder/getNewPriceByCu?salesModeNo='+$("#SALES_MODE_NO").val(),
            dataType : 'json',
            async: false,
            success : function(data) {
                $.each(
                    data,
                    function(i, item) {
                        $("#salePrice"+item.PRODUCT_NO).val(item.PRICE);
                        $("#priceLabel"+item.PRODUCT_NO).text(item.PRICE);
                    }
                );
                initCount();
            }
        });
    });
    
    $("#receiverButton").live("tap",function(){
        if($("#receiverSelect").val() != ""){
            $("#RECEIVER_NAME").text($("#receiverSelect option:selected").text());
            if($("#receiverSelect option:selected").attr("RECEIVER_MOBILE1") != null && 
                    $("#receiverSelect option:selected").attr("RECEIVER_MOBILE1") != "null"){
                $("#RECEIVER_MOBILE1").text($("#receiverSelect option:selected").attr("RECEIVER_MOBILE1"));
            }
            if($("#receiverSelect option:selected").attr("RECEIVER_ADDRESS") != null && 
                    $("#receiverSelect option:selected").attr("RECEIVER_ADDRESS") != "null"){
                $("#RECEIVER_ADDRESS").text($("#receiverSelect option:selected").attr("RECEIVER_ADDRESS"));
            }
        }else{
            $("#RECEIVER_NAME").text("");
            $("#RECEIVER_MOBILE1").text("");
            $("#RECEIVER_ADDRESS").text("");
        }
    });
    
    $("#invoiceButton").live("tap",function(){
        $("#invoiceTitleType").text($("#INVOICE_TITLE_TYPE").val());
        $("#invoiceTitleContent").text($("#INVOICE_TITLE_CONTENT").val());
        $("#invoiceContent").text($("#INVOICE_CONTENT").val());
    });
    
    $("#transButton").live("tap",function(){
        $("#TRANSPORT_MODE").text($("#inputTrans").val());
    });
    
    $(".addProduct").live("tap",function(){
        spf_search(1);
    });
    
    $("#submitOrder").live("tap",function(){
        spf_save();
    });
    
    $(".updateCust").live("tap",function(){
        if($("#custSelect option").length == 0){
            $.post("/mobile/mobileOrder/getMobileCustomerList", 
                [   
                    { name: 'ownerId', value: "${sessionScope.LoginUser.adminID }" },
                    { name: 'page', value: '1'},
                    { name: 'pagesize', value: '99'}
                ]
                , function (result){
                    var temp = "<option value=''>请选择</option>";
                    $.each(
                        result.Rows,
                        function(i, item) {
                            temp = temp + "<option value='"+item.CUST_NO+"' address='"+item.ADDRESS_TOTAL+"' salesModeNo='"+item.CUST_SALES_MODE_CODE+"'>"+item.CUST_NAME+"</option>";
                        }
                    );
                    $("#custSelect").html(temp);
                }
            );
        }
    });
    
    $(".updateReceiver").live("tap",function(){
        var cno = "0";
        if($("#CUST_NO").val() != ""){
            cno = $("#CUST_NO").val();
        }
        $.post("/mobile/mobileOrder/getMobileCustomerReceiverList", 
            [   
                { name: 'ownerId', value: "${sessionScope.LoginUser.adminID }" },
                { name: 'page', value: '1'},
                { name: 'pagesize', value: '10'},
                { name: 'CUST_NO',value: cno}
            ]
            , function (result){
                var temp = "<option value=''>请选择</option>";
                $.each(
                    result,
                    function(i, item) {
                        temp = temp + "<option value='"+item.RECEIVER_ID+"' RECEIVER_MOBILE1='"+item.RECEIVER_MOBILE1+
                            "' RECEIVER_ADDRESS='"+item.RECEIVER_ADDRESS+"'>"+item.RECEIVER_NAME+"</option>";
                    }
                );
                $("#receiverSelect").html(temp);
            }
        );
    });
    
    var product;

    $(document).ready(function() {
        if ($("#PRODUCT_CATEGORY_ID").val() != "") {
            $("#tipSearch").html("${paramMap.ROOT_CATEGORY }\/${paramMap.CATEGORY_NAME }");
        } else {
            if ($("#search").val() == "") {
                $("#tipSearch").html("共有${page.allCount}件商品");
            } else {
                $("#tipSearch").html(
                        "与\"" + $("#search").val()
                            + "\"有关的共有${page.allCount}件商品");
            }
        }
        initCount();
    });
    
    function initCount(){
        var $price = $(".priceClass");
        var $buy = $(".buyCount");
        
        var sum1 = 0;
        var sum2 = 0;
        for(var i=0;i<$buy.length;i++){
            sum1 = sum1 + parseFloat($buy[i].value);
            sum2 = sum2 + parseFloat($buy[i].value)*parseFloat($price[i].value);
        }
        $("#count").text(sum1);
        $("#totalMoney").text(sum2);
    }
    
    function spf_save(){
        if(spf_checkSubmit()){
            var customer = '[{'+
            '"address" : "'+$("#CUST_ADDRESS").val()+'",'+
            '"customerName" : "'+$("#CUST_NAME").text()+'",'+
            '"customerNo" : "'+$("#CUST_NO").val()+'"'+
            '}]';
            var custId = "";
            if("${sessionScope.LoginUser.accountType}" == "CU"){
                custId = "${customer.CUST_ID }";
            }
            var owner = '[{'+
                '"empId" : "${sessionScope.LoginUser.adminID }",'+
                '"empName" : "${sessionScope.LoginUser.chineseName }"'+
            '}]';
            var price = '[{'+
                '"discount" : "1",'+
                '"discountPrice" : "'+$("#totalMoney").text()+'",'+
                '"price" : "'+$("#totalMoney").text()+'"'+
            '}]';
            var receiver = '[{'+
                '"address" : "'+$("#RECEIVER_ADDRESS").text()+'",'+
                '"mobile" : "'+$("#RECEIVER_MOBILE1").text()+'",'+
                '"name" : "'+$("#RECEIVER_NAME").text()+'"'+
            '}]';
            var salesMode = '[{'+
                '"salesModeNo" : "'+$("#SALES_MODE_NO").val()+'"'+
                /* '"salesModeName" : "${saleMode.SALES_MODE_NAME }",'+
                '"salesModeNo" : "${saleMode.SALES_MODE_NO }"'+ */
            '}]';
            
            var jsonData = '[' ; 
            for(var i=0;i<$(".proDetailTable").length;i++){
                var productNo = $($(".proDetailTable")[i]).attr("pno");
                if (jsonData.length > 1){
                   jsonData += ',' ;
                }
                
                var sellingPrice = '{'+
                    '"\'discount\'" : "\'1\'",'+
                    '"\'discountPrice\'" : "\''+parseFloat($("#salePrice"+productNo).val())*parseFloat($("#number"+productNo).val())+'\'",'+
                    '"\'price\'" : "\''+$("#salePrice"+productNo).val()+'\'"'+
                '}';
                var unit = '{'+
                    '"\'unitId\'" : "\''+$("#UNIT_CODE"+productNo).val()+'\'",'+
                    '"\'unitName\'" : "\''+$("#UNIT_NAME"+productNo).val()+'\'"'+
                '}';
                
                var p = '{'+
                    '"amount" : "'+parseFloat($("#salePrice"+productNo).val())*parseFloat($("#number"+productNo).val())+'",'+
                    '"id" : "'+$("#PRODUCT_ID"+productNo).val()+'",'+
                    '"name" : "'+$("#PRODUCT_NAME"+productNo).val()+'",'+
                    '"no" : "'+productNo+'",'+
                    '"quantity" : "'+$("#number"+productNo).val()+'",'+
                    '"sellingPrice" : '+sellingPrice+','+
                    '"specification" : "'+$("#SPECIFICATION"+productNo).val()+'",'+
                    '"unit" : '+unit+
                '}';
                jsonData = jsonData + p;
            }
            jsonData = jsonData + "]";
            
            $.post("/mobile/mobileOrder/saveCart", 
                [   
                    { name: 'customer', value: customer },
                    { name: 'owner', value: owner },
                    { name: 'price', value: price },
                    { name: 'receiver', value: receiver },
                    { name: 'salesMode', value: salesMode },
                    { name: 'jsonData', value: jsonData },
                    { name: 'CUST_ID',value: custId},
                    { name: 'invoiceType',value: $("#invoiceType").text() },
                    { name: 'invoiceTitleType',value: $("#invoiceTitleType").text() },
                    { name: 'invoiceTitleContent',value: $("#invoiceTitleContent").text() },
                    { name: 'invoiceContent',value: $("#invoiceContent").text() },
                    { name: 'paymentMode',value: $("#PAYMENT_CODE").val()},
                    { name: 'consignee', value: $("#RECEIVER_NAME").text() },
                    { name: 'deliveryAddress', value: $("#RECEIVER_ADDRESS").text() },
                    { name: 'deliveryDate', value: $("#DELIVERY_DATE").text() },
                    { name: 'invoiceTitle', value: $("#INVOICE").text() },
                    { name: 'orderDate', value: new Date() },
                    { name: 'transportMode', value: $("#TRANSPORT_MODE").text() }
                ], function (data){
                    if(data == 'Y'){
                        $.mobile.changePage("#e7");
                        $("#listNumTip").html("");
                    } else {
                        showTips("添加订单失败", 100, 2 );
                    }
                }
            );
        }
    }
    
    function spf_checkSubmit(){
        var flag = true;
        if(!isNaN($("#count").text()) && parseFloat($("#count").text())==0){
            alert("当前购物车没有添加任何商品");
            flag = false;
            return flag;
        }
        if($("#isAddrEmpty").val()=='addrEmpty'){
            alert("请在个人中心完善收货人信息");
            flag = false;
            return flag;
        }
        if(isNaN($("#count").text()) || parseFloat($("#count").text())<0){
            alert("请输入正确的数目");
            flag = false;
            return flag;
        }
        if($("#CUST_NO").val()==""){
            alert("请选择客户");
            flag = false;
            return flag;
        }
        if(isNaN($("#totalMoney").text())){
            alert("存在该客户不能购买的商品！");
            flag = false;
            return flag;
        }
        return flag;
    }
    
    function changeTitleType(){
        if($("#INVOICE_TITLE_TYPE").val()=="公司"){
            $("#titleSpan").show();
        }else{
            $("#titleSpan").hide();
        }
    }
</script>
<style type="text/css">
div {
    font-family: "微软雅黑";
}
.proDetailTable {
    width: 100%;
    border-collapse: collapse;
    margin-top: 3px;
    background-color: white;
}
#paymentMode{
    width:100%;
}
#cartContent a{
    font-size:14px;
}
</style>
</head>
<body>
    <div data-role="page" id="e1" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>清单</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';" id="cartContent">
            
            <input type="hidden" id="PRODUCT_CATEGORY_ID" value=""/>
            <input type="hidden" id="CATEGORY_NAME" value=""/>
            <input type="hidden" id="ROOT_CATEGORY" value=""/>
            <input type="hidden" id="search" value="" />
            <input type="hidden" id="M_AREA_NO" value=""/>
            <input type="hidden" id="M_AREA_NAME" value=""/>
            <input type="hidden" id="ORDER_BY" value=""/>
            <input type="hidden" id="ASC_OR_DESC" value=""/>
            
            <input type="hidden" id="SALES_MODE_NO" value="${saleMode.SALES_MODE_NO }"/>
            <c:if test="${customer.RECEIVERS=='[]'}">
                <input type="hidden" id="isAddrEmpty" value="addrEmpty"/>
            </c:if>
            <div style="width: 100%">
                <c:if test="${fn:length(sessionScope.cartProList)==0 }">
                    <div style="width:100%;height:50px;text-align:center;line-height:50px;">当前购物车尚未添加任何商品</div>
                </c:if>
                <c:forEach var="product" items="${sessionScope.cartProList }">
                    <input id="salePrice${product.PRODUCT_NO }" type="hidden" value="${product.salePrice }" class="priceClass"/>
                    <input id="PRODUCT_ID${product.PRODUCT_NO }" type="hidden" value="${product.PRODUCT_ID }"/>
                    <input id="PRODUCT_NAME${product.PRODUCT_NO }" type="hidden" value="${product.PRODUCT_NAME }"/>
                    <input id="SPECIFICATION${product.PRODUCT_NO }" type="hidden" value="${product.SPECIFICATION }"/>
                    <input id="UNIT_CODE${product.PRODUCT_NO }" type="hidden" value="${product.UNIT_CODE_ID }"/>
                    <input id="UNIT_NAME${product.PRODUCT_NO }" type="hidden" value="${product.UNIT_CODE }"/>
                    <input id="REMARK${product.PRODUCT_NO }" type="hidden" value="${product.REMARK }"/>
                    
                    <table class="proDetailTable" pno="${product.PRODUCT_NO }">
                        <tr>
                            <td rowspan="4" width="100" align="left"><img src="/resources/picture/product/${product.PRODUCT_ID }.jpg" id="proImage" onerror="this.src='/resources/picture/none.gif'"
                                class="proImage" style="width: 100px; height: 100px;" pno="${product.PRODUCT_NO }" pid="${product.PRODUCT_ID }" /></td>
                        </tr>
                        <tr height="25">
                            <td colspan="3" width="100">${product.PRODUCT_NAME }</td>
                        </tr>
                        <tr height="30">
                            <td width="20%"><spring:message code="hrms.unitPrice" />:</td>
                            <td width="28%"><label id="priceLabel${product.PRODUCT_NO }">￥${product.salePrice }</label></td>
                            <td width="50%">
                                <div style="width:40%;float:left;text-align:center;line-height:30px;">
                                    <input id="number${product.PRODUCT_NO }" type="number" class="buyCount" onchange="initCount()" value="${product.QUANTITY }"/></div>
                                <div style="width:60%;float:left;text-align:center;line-height:30px;">
                                    <img class="deleteFromCart" pno="${product.PRODUCT_NO }" src="/resources/images/myimage/delete.png"/></div>
                            </td>
                        </tr>
                    </table>
                </c:forEach>
            </div>
            
            <div style="width:100%;border-bottom:1px solid #c5c5c5;">
                <table style="width:100%;height:70px;margin-top:10px;">
                    <tr>
                        <td width="80">数量:</td>
                        <td align="left">
                            <label id="count"></label>
                        </td>
                        <td>
                            <div class="addProduct" style="width:70px;height:25px;color:white;text-align:center;line-height:25px;color:white;background-color:#e66e25;">添加商品</div>
                        </td>
                    </tr>
                    <tr>
                        <td>合计金额:</td>
                        <td align="left">
                            <label id="totalMoney"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>支付方式:</td>
                        <td align="left">
                            <input type="hidden" id="PAYMENT_CODE"/>
                            <label id="PAYMENT_NAME"></label>
                        </td>
                        <td width="80" align="center">
                            <a href="#e2" 
                                data-rel="dialog"
                                data-transition="pop">修改</a></td>
                    </tr>
                    <tr>
                        <td>配送方式:</td>
                        <td>
                            <label id="TRANSPORT_MODE"></label>
                        </td>
                        <td width="80" align="center">
                            <a href="#e6" 
                                data-rel="dialog"
                                data-transition="pop">修改</a>
                        </td>
                    </tr>
                </table>
            </div>
            
            <c:if test="${sessionScope.LoginUser.accountType == 'EM' }">
                <div style="width:100%;border-bottom:1px solid #c5c5c5;">
                    <table style="width:100%;height:20px;margin-top:10px;">
                        <tr>
                            <td width="80">客户:</td>
                            <td align="left">
                                <input type="hidden" id="CUST_NO"/>
                                <input type="hidden" id="CUST_ADDRESS"/>
                                <label id="CUST_NAME"></label>
                            </td>
                            <td width="80" align="center">
                                <a class="updateCust" href="#e3" 
                                    data-rel="dialog"
                                    data-transition="pop">修改</a></td>
                        </tr>
                    </table>
                </div>
            </c:if>
            <c:if test="${sessionScope.LoginUser.accountType == 'CU' }">
                <div style="display:none;">
                    <input type="hidden" id="CUST_NO" value="${customer.CUST_NO }"/>
                    <input type="hidden" id="CUST_ADDRESS" value="${customer.ADDRESS_TOTAL }"/>
                    <label id="CUST_NAME">${customer.CUST_NAME }</label>
                </div>
            </c:if>
            
            <div style="width:100%;border-bottom:1px solid #c5c5c5;">
                <table style="width:100%;">
                    <tr height="30">
                        <td style="font-size:14px;">收货人信息&nbsp;</td>
                        <td width="80" align="center">
                            <a href="#e4"
                                class="updateReceiver"
                                data-rel="dialog"
                                data-transition="pop">修改</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label id="RECEIVER_NAME"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label id="RECEIVER_MOBILE1"></label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label id="RECEIVER_ADDRESS"></label>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="width:100%;">
                <table style="width:100%;">
                    <tr height="30">
                        <td style="font-size:14px;">发票信息</td>
                        <td style="width:80px;" align="center">
                            <a href="#e5"
                                class="updateInvoice"
                                data-rel="dialog"
                                data-transition="pop">修改</a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label id="invoiceType"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label id="invoiceTitleType"></label>
                            &nbsp;&nbsp;&nbsp;&nbsp;<label id="invoiceTitleContent"></label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <label id="invoiceContent"></label>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="width:100%;margin-top:50px;">
                <table style="width:100%;">
                    <tr>
                        <td align="left">
                            <div style="clear:both;">
                                <img id="back" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
                            </div>
                        </td>
                        <td align="right">
                            <div id="submitOrder" style="width:70px;height:25px;color:white;text-align:center;line-height:25px;color:white;background-color:#e66e25;">提交订单</div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
    
    <!-- 一下是点击各修改按钮后相关弹出界面 -->
    <div data-role="page" id="e2" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>支付方式</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><SipingSoft:selectSyCode parentCode="PaymentMode" name="paymentMode" limit="all"/></td>
                </tr>
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#e1" id="savePayment" data-role="button">保存</a></div></td>
                </tr>
            </table>
        </div>
    </div>
    
    <div data-role="page" id="e3" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>客户列表</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="custSelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right">
                        <div style="width:100px;"><a id="custButton" data-role="button" href="#e1">确定</a></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div data-role="page" id="e4" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>收货人列表</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="receiverSelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right">
                        <div style="width:100px;"><a id="receiverButton" data-role="button" href="#e1">确定</a></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div data-role="page" id="e5" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>发票信息</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <!-- <tr>
                    <td width="10%" align="right"><input name="INVOICE_TITLE_TYPE_RADIO" type="radio" value="个人"/></td>
                    <td width="20%" align="center">个人</td>
                    <td width="10%" align="right"><input name="INVOICE_TITLE_TYPE_RADIO" type="radio" value="单位"/></td>
                    <td width="20%" align="center">单位</td>
                    <td width="40%">
                        <span id="titleSpan" style="display:none;"><input name="INVOICE_TITLE_CONTENT_IN" id="INVOICE_TITLE_CONTENT_IN" type="text"/></span></td>
                </tr> -->
                <tr>
                    <td>发票抬头:</td>
                    <td>
                        <select id="INVOICE_TITLE_TYPE" onchange="changeTitleType()">
                            <option value="个人" selected="selected">个人</option>
                            <option value="公司">公司</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <span id="titleSpan" style="display:none;"><input id="INVOICE_TITLE_CONTENT" type="text"/></span>
                    </td>
                </tr>
                <tr>
                    <td>发票内容:</td>
                    <td><input id="INVOICE_CONTENT" type="text"/></td>
                </tr>
                <tr>
                    <td align="right" colspan="2"><div style="width:100px;"><a id="invoiceButton" data-role="button" href="#e1">确定</a></div></td>
                </tr>
            </table>
        </div>
    </div>
    
    <div data-role="page" id="e6" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>配送方式</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><input id="inputTrans" type="text"/></td>
                </tr>
                <tr>
                    <td align="right"><div style="width:100px;"><a id="transButton" data-role="button" href="#e1">确定</a></div></td>
                </tr>
            </table>
        </div>
    </div>
    
    <div data-role="page" id="e7" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>成功</h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td width="45%" align="right">
                        <img src="/resources/images/myimage/success.jpg" width="25" height="25"/> </td>
                    <td align="left">提交订单成功</td>
                </tr>
            </table>
            <table style="width:100%;margin-top: 50px;">
                <tr>
                    <td align="center">
                        <div class="homePage" style="width:70px;height:25px;color:white;text-align:center;line-height:25px;color:white;background-color:#518def;">继续挑选</div>
                    </td>
                    <td align="center">
                        <div class="myOrder" style="width:70px;height:25px;color:white;text-align:center;line-height:25px;color:white;background-color:#e66e25;">查看订单</div>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
</body>
</html>