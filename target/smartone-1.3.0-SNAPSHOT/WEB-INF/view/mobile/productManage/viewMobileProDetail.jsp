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
    $("#menuTable td").live("tap", function() {
        $(this).siblings().removeClass("menuTab").end().addClass("menuTab");
        $("#tabShowDiv"+$(this).attr("id")).siblings("div").hide().end().show();
    });
    $(".doc_li").live("tap", function(){
        var doc_id = $(this).children(".doc_id").val();
        var doc_type_id = $(this).children(".doc_type_id").val();
        
        if($("#ul"+doc_id).css("display")!="none"){
            $("#ul"+doc_id).hide();
        }else{
            $("#ul"+doc_id).show();
        }
        
        if($("#ul"+doc_id+" div").length<=0){
            $.post("/doc/docInfo/getFileList", 
                [   
                    { name: 'DOC_ID', value: doc_id }
                ]
                , function (result){
                    var temp = "";
                    $.each(
                        result.Rows,
                        function(i, item) {
                            temp = temp + "<div class='doc_li3' doc_id='"+doc_id+"' file_id='"+item.FILE_ID+"' doc_type_id='"+doc_type_id+"'>"+item.FILE_NAME+"</div>";
                        }
                    );
                    $("#ul"+doc_id).html(temp);
                }
            );
        }
    });
    $(".doc_li3").live("tap",function(){
        location.href ='/doc/docManage/downloadFile?DOC_ID='+$(this).attr("doc_id")+'&FILE_ID='
                +$(this).attr("file_id")+'&DOC_TYPE_ID='+$(this).attr("doc_type_id");
    });
</script>
<style type="text/css">
div{
    font-family:"微软雅黑";
}
.proDetailTable{
    width: 100%; 
    font-family: '微软雅黑'; 
    color: #456f9a;
    font-size:12px;
    border-collapse:collapse;
}
.doc_li,.doc_li2,.doc_li3{
    width: 100%;
    height:30px;
    line-height:30px;
    list-style:none;
    font-family: '微软雅黑'; 
    color: #456f9a;
    font-size:12px;
}
.menuTab{
    background-color:#e66e25;color:white;
}
#tabShowDivtab1 td,#tabShowDivtab2 td,.doc_li,.doc_li3{
    border-bottom:1px solid #dddddd;
}
.doc_li2{
    width:90%;
    margin-left:15px;
}
.proDetailTable-td-line{
    text-align: center;
    width: 30%;
    color: #0066FF;
}
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>商品简介</h1>
        </div>
        <div data-role="content" style="background-color: white;">

            <div style="width: 100%">
                <table class="proDetailTable">
                    <tr>
                        <td rowspan="4" width="100" align="left"><img src="/resources/picture/product/${product.PRODUCT_ID }.jpg" id="proImage" onerror="this.src='/resources/picture/none.gif'"
                            class="proImage" style="width: 100px; height: 100px;" pno="${product.PRODUCT_NO }" pid="${product.PRODUCT_ID }" /></td>
                    </tr>
                    <tr height="25">
                        <td colspan="2" width="100">${product.PRODUCT_NAME }</td>
                    </tr>
                    <tr height="30">
                        <td style="width: 40px;"><spring:message code="hrms.unitPrice" />:</td>
                        <td>￥${product.salePrice }
                            <input id="salePrice${product.PRODUCT_NO }" type="hidden" value="${product.salePrice }"/>
                            <input id="PRODUCT${product.PRODUCT_NO }" type="hidden" value="${product }"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="width: 120px;">
                            <div style="width:50%;float:left;text-align:center;line-height:30px;"><input id="number${product.PRODUCT_NO }" type="number" class="buyCount" value="1"/></div>
                            <div style="width:30%;float:left;text-align:center;line-height:30px;height: 50px;margin-left: 10px;">
                                <img class="addToCart" pno="${product.PRODUCT_NO }" src="/resources/images/myimage/cart.png" style="width: 50px;height: 50px;"/></div>
                        </td>
                    </tr>
                </table>
            </div>

            <div style="width: 100%">
                <table style="width: 100%;background-color:#dddddd;border:0px;border-collapse:collapse;" id="menuTable">
                    <tr height="30">
                        <td align="center" class="menuTab" id="tab1">商品详情</td>
                    </tr>
                </table>
                <div style="width:100%;" id="tabShowDivtab1">
                    <table class="proDetailTable">
                        <tr height="25">
                            <td class="proDetailTable-td-line"><spring:message code="mobile.productNo"/></td>
                            <td width="70%">
                                ${product.PRODUCT_ID }
                            </td>
                        </tr>
                        <tr height="25">
                            <td class="proDetailTable-td-line"><spring:message code="hrms.product.name"/></td>
                            <td>
                                ${product.PRODUCT_NAME }
                            </td>
                        </tr>
                        <tr height="25">
                            <td class="proDetailTable-td-line"><spring:message code="mobile.product"/><spring:message code="hrms.specification"/></td>
                            <td>
                                ${product.SPECIFICATION }
                            </td>
                        </tr>
                        <tr height="25">
                            <td class="proDetailTable-td-line"><spring:message code="mobile.product"/><spring:message code="hrms.productCategory"/></td>
                            <td>
                                ${product.PRODUCT_CATEGORY_NAME}
                            </td>
                        </tr>
                        <tr height="25">
                            <td class="proDetailTable-td-line"><spring:message code="hrms.unit"/></td>
                            <td>
                                ${product.UNIT_CODE }
                            </td>
                        </tr>
                        <tr height="40">
                            <td class="proDetailTable-td-line"><spring:message code="hrms.description" /></td>
                            <td>${product.REMARK }</td>
                        </tr>
                    </table>
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