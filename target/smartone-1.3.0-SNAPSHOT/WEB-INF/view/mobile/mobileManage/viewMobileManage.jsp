<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />

<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
    type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">

    $(function(){
        f_initArea();
        $(".areaOption").live("click",function(){
            if($(this).attr("chose") == "false"){
                $(this).attr("chose","true");
                $(this).css("background-color","#d9e8fb");
            }else{
                $(this).attr("chose","false");
                $(this).css("background-color","white");
            }
        });
        $(".areaOption").live("mouseover",function(){
            $(this).css("background-color","#d9e8fb");
        });
        $(".areaOption").live("mouseout",function(){
            if($(this).attr("chose") == "true"){
                $(this).css("background-color","#d9e8fb");
            }else{
                $(this).css("background-color","white");
            }
        });
        spf_initSalesMode();
    });
    
    
    function f_initArea(){
        $.post("/mobile/mobileManage/getMobileAreaList", 
            [
                { name: 'page', value: '1' },
                { name: 'pagesize', value: '10'}
            ]
            , function (data){
                var temp = "";
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp +
                            "<tr height='50' class='itemTr'>"+
                                "<td align='right' style='font-size:15px;' width='150'><spring:message code="report.the"/>"+(i+1)+
                                "<spring:message code="mobile.column"/></td>"+
                                "<td align='center' width='400'>"+
                                    "<input id='areaNo"+item.M_AREA_NO+"' type='hidden' value='"+item.M_AREA_NO+"'/>"+
                                    "<input id='areaName"+item.M_AREA_NO+"' type='text' class='inputClass' value='"+item.M_AREA_NAME+"'/>"+
                                    "&nbsp;&nbsp;<input id='areaSort"+item.M_AREA_NO+"' type='text' style='width:40px;' value='"+item.ORDERNO+"'/>"+
                                "</td>"+
                                "<td align='left' width='120'><a href='javascript:spf_showDetail("+item.M_AREA_NO+")' class='setButton'><spring:message code="mobile.goodsSet"/></a></td>"+
                                "<td align='left' width='130'><a href='javascript:spf_delete("+item.M_AREA_NO+")' style='color:green;'><spring:message code="hrms.delete"/></a></td>"+
                            "</tr>";
                    }
                );
                $("#areaDivTable").html(temp);
            }
        );
    }
    
    function spf_add(){
        var temp =
        "<tr height='50' class='itemTr'>"+
            "<td align='right' style='font-size:15px;' width='150'><spring:message code="report.the"/>"+($("#areaDivTable tr").length+1)+"<spring:message code="mobile.column"/></td>"+
            "<td align='center' width='400'>"+
                "<input type='hidden' value=''/>"+
                "<input type='text' class='inputClass'/>"+
                "&nbsp;&nbsp;<input type='text' style='width:40px;' value='1' "+
            "</td>"+
            "<td align='left' width='120'></td>"+
            "<td align='left' width='130'></td>"+
        "</tr>";
        $("#areaDivTable").append(temp);
    }
    
    function spf_delete(no){
        $.ligerDialog.confirm('<spring:message code="mobile.areDeleteTheZone"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/mobile/mobileManage/deleteMobileArea", 
                        [   
                            { name: 'M_AREA_NO', value: no }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    f_initArea(); //加载数据 
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
    }
    
    function spf_save(){
        var $itemTr = $(".itemTr");
        var jsonData = '[' ; 

        for(var i=0;i<$itemTr.length;i++){
            if($($itemTr[i]).children("td:eq(1)").children("input:eq(0)").val()!="" 
                    && $($itemTr[i]).children("td:eq(1)").children("input:eq(1)").val()==""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mobile.Pleasefillintheareaname"/>') ;
                return;
            }
            if($($itemTr[i]).children("td:eq(1)").children("input:eq(1)").val()!=""){
                if (jsonData.length > 1){
                    jsonData += ',{' ;
                 }
                 else{
                    jsonData += '{' ;
                 }
                 jsonData += ' "M_AREA_NO": "' + $($itemTr[i]).children("td:eq(1)").children("input:eq(0)").val() + '",';
                 jsonData += ' "M_AREA_NAME": "' + $($itemTr[i]).children("td:eq(1)").children("input:eq(1)").val() + '",';
                 jsonData += ' "ORDERNO": "'+$($itemTr[i]).children("td:eq(1)").children("input:eq(2)").val()+'"';
                 jsonData += '}';
            }
        }
        jsonData += ']' ;
        
        if(jsonData.length == 2){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        } 
        $.ligerDialog.waitting('数据保存中...');
        $.post("/mobile/mobileManage/saveOrUpdateMobileArea", 
            [
                { name: 'jsonData', value: jsonData }
            ],function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        f_initArea();
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
    }
        
    function spf_showDetail(no){
        $("#showAreaDiv").slideUp(400);
        $("#areaTitle").text($("#areaName"+no).val());
        $("#M_AREA_NO").val($("#areaNo"+no).val());
        
        spf_initAreaProduct(1);
        spf_initNotAreaProduct(1);
        $("#showAreaProDiv").slideDown(400);
    }
    
    function spf_backToArea(){
        $("#showAreaDiv").slideDown(400);
        $("#areaTitle").text("");
        $("#M_AREA_NO").val("");
        
        $("#showAreaProDiv").slideUp(400);
    }
    
    function spf_initAreaProduct(page){
        $.post("/mobile/mobileManage/getProductByArea", 
            [
                { name: 'M_AREA_NO', value: $("#M_AREA_NO").val() },
                { name: 'page', value: page },
                { name: 'pagesize', value: 10}
            ]
            , function (data){
                var temp = "";
                $.each(
                    data.Rows,
                    function(i, item) {
                        if(item.PRODUCT_NAME.length>16){
                            temp = temp + "<div chose='false' class='areaOption' pno='"+item.PRODUCT_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME.substr(0,16)+"......</div>";
                        }else{
                            temp = temp + "<div chose='false' class='areaOption' pno='"+item.PRODUCT_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME+"</div>";
                        }
                    }
                );
                $("#areaSelect").html(temp);
                
                $("#currentPage2").text(data.page.currentPage);
                $("#allPage2").text(data.page.allPages);
                $("#prePage2").attr("href","javascript:spf_initAreaProduct("+data.page.prePage+")");
                $("#nextPage2").attr("href","javascript:spf_initAreaProduct("+data.page.nextPage+")");
            }
        );
    }
    function spf_initNotAreaProduct(page){
        $.post("/mobile/mobileManage/getProductByArea", 
            [   
                { name: 'NOT_M_AREA_NO', value: $("#M_AREA_NO").val() },
                { name: 'page', value: page },
                { name: 'pagesize', value: 10},
                { name: 'keyWord', value: $("#keyWord").val()}
            ]
            , function (data){
                var temp = "";
                $.each(
                    data.Rows,
                    function(i, item) {
                        if(item.PRODUCT_NAME.length>16){
                            temp = temp + "<div chose='false' class='areaOption' pno='"+item.PRODUCT_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME.substr(0,16)+"......</div>";
                        }else{
                            temp = temp + "<div chose='false' class='areaOption' pno='"+item.PRODUCT_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME+"</div>";
                        }
                    }
                );
                $("#notAreaSelect").html(temp);
                
                $("#currentPage1").text(data.page.currentPage);
                $("#allPage1").text(data.page.allPages);
                $("#prePage1").attr("href","javascript:spf_initNotAreaProduct("+data.page.prePage+")");
                $("#nextPage1").attr("href","javascript:spf_initNotAreaProduct("+data.page.nextPage+")");
            }
        );
    }
    
    function spf_goRight(){
        var $leftChose = $("#notAreaSelect .areaOption[chose='true']");
        var rightLength = $("#areaSelect .areaOption").length;
        if((rightLength+$leftChose.length)>6){
            $.ligerDialog.warn('<spring:message code="mobile.Cornesix"/>','<spring:message code="hrms.warning"/>');
        }else{
            $("#notAreaSelect .areaOption[chose='true']").appendTo($("#areaSelect")).end().trigger("click");
        }
    }
    function spf_goLeft(){
        $("#areaSelect .areaOption[chose='true']").appendTo($("#notAreaSelect")).end().trigger("click");
    }
    
    function spf_saveProductToArea(){
        var $proItems = $("#areaSelect .areaOption");
        
        var jsonData = '[' ; 

        for(var i=0;i<$proItems.length;i++){
            if (jsonData.length > 1){
                jsonData += ',{' ;
             }
             else{
                jsonData += '{' ;
             }  
             jsonData += ' "PRODUCT_NO": "' + $($proItems[i]).attr("pno") + '"';
             jsonData += '}' ;  
        }
        jsonData += ']' ;
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/mobile/mobileManage/saveProductToArea", 
            [   
                { name: 'jsonData', value: jsonData },
                { name: 'M_AREA_NO', value: $("#M_AREA_NO").val() }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        spf_initAreaProduct(1);
                        spf_initNotAreaProduct(1);
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
    }
        
    function spf_initSalesMode(){
        $.post("/productStorage/proBusinessManage/getSalesModelList", 
            [   
                { name: 'STATUS', value: '1' }
            ]
            , function (data){
                var temp = '<option value=""><spring:message code="hrms.selection"/></option>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        if(item.MOBILE_STATUS == 1){
                            temp = temp + '<option value="'+item.SALES_MODE_NO+'" selected="selected">'+item.SALES_MODE_NAME+'</option>';
                        }else{
                            temp = temp + '<option value="'+item.SALES_MODE_NO+'">'+item.SALES_MODE_NAME+'</option>';
                        }
                    }
                );
                $("#salesMode").html(temp);
            }
        );
    }
    
    function spf_updateSalesMode(){
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/productStorage/proBusinessManage/updateSalesMobileStatus", 
                [   
                    { name: 'SALES_MODE_NO', value: $("#salesMode").val() }
                ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if(result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                            spf_initSalesMode();
                        });
                    }
                }
            );
    }
</script>

<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
#showAreaDiv{
    width:800px;
    margin:0 auto;
    border:1px solid #c5c5c5;
}
#showAreaProDiv{
    display:none;
    width:800px;
    height:800px;
    margin:0 auto;
    border:1px solid #c5c5c5;
}
.setButton{
    display:block;
    width:90px;
    height:30px;
    background-color:#fe9e00;
    color:white;
    font-size:15px;
    text-align:center;
    line-height:30px;
    text-decoration: none;
}
.inputClass{
    width:300px;
    height:30px;
    text-align:center;
}
.proSelect{
    width:300px;
    height:400px;
    overflow:hidden;
    border:1px solid #c5c5c5;
}
.areaOption{
    width:300px;
    height:30px;
    text-align:left;
    line-height:30px;
    font-size:14px;
    border-bottom:1px solid #c5c5c5;
    cursor:pointer;
}
a{
    color:green;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div id="showAreaDiv">
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;font-size:15px;"><spring:message code="mobile.salesChannels"/></td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="100%">
                <tr>
                    <td width="150" align="right"><spring:message code="mobile.mobileTerminalPriceDisplayed"/></td>
                    <td width="400" align="center">
                        <select id="salesMode" class="inputClass"></select>
                    </td>
                    <td>
                        <input type='button' class='setButton' value='<spring:message code="hrms.save"/>' onclick="spf_updateSalesMode()"/>
                    </td>
                </tr>
            </table>
        
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;margin-top:50px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;font-size:15px;"><spring:message code="mobile.productArea"/></td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table id="areaDivTable" style="width:100%">
            
            </table>
            <table style="width:100%;">
                <tr height='50'>
                    <td align='right' style='font-size:18px;' width='150'>
                        <a href='javascript:spf_add()' style='color:green;'><spring:message code="eva.add"/>+</a>
                    </td>
                    <td align='center' width='650'>
                    </td>
                </tr>
            </table>
            <table width="100%" style="margin-top:50px;">
                <tr height="50">
                    <td width="550">
                    </td>
                    <td align="left">
                        <input type='button' class='setButton' value='<spring:message code="hrms.save"/>' onclick="spf_save()"/>
                    </td>
                </tr>
            </table>
        </div>
        
        <div id="showAreaProDiv">
            <input type="hidden" id="M_AREA_NO"/>
        
            <div style="width:640px;margin:0 auto;">
                <table width="100%">
                    <tr height="50">
                        <td colspan="3" align="center" id="areaTitle"><spring:message code="mobile.areaDetails"/></td>
                    </tr>
                    <tr>
                        <td align="left">
                            <input type="text" id="keyWord" style="width:170px;height:25px;float:left;"/>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                                onclick="javascript:spf_initNotAreaProduct(1)"><spring:message code="search"/></a>
                        </td>
                        <td colspan="2"></td>
                    </tr>
                    <tr height="30">
                        <td width="300"><spring:message code="mobile.productList"/></td>
                        <td></td>
                        <td width="300"><spring:message code="mobile.areaCommodity"/></td>
                    </tr>
                    <tr>
                        <td align="right">
                             <div id="notAreaSelect" class="proSelect"></div>
                        </td>
                        <td align="center">
                            <div style="width:30px;height:30px;">
                                <img id="goRight" title="<spring:message code="mobile.moveToTheRight"/>" src="/resources/images/myimage/goRight.gif" style="width:20px;height:20px;cursor:pointer;" onclick="spf_goRight()"/>
                            </div>
                            <div style="width:30px;height:30px;">
                                <img id="goLeft" title="<spring:message code="mobile.moveToTheLeft"/>" src="/resources/images/myimage/goLeft.gif" style="width:20px;height:20px;cursor:pointer;" onclick="spf_goLeft()"/>
                            </div>
                        </td>
                        <td align="left">
                             <div id="areaSelect" class="proSelect"></div>
                        </td>
                    </tr>
                    <tr style="font-size:14px;">
                        <td align="center">
                            <a id="prePage1" href=""><spring:message code="mobile.prePage"/></a>
                            &nbsp;<spring:message code="report.the"/><label id="currentPage1"></label><spring:message code="mobile.page"/>&nbsp;
                            <a id="nextPage1" href=""><spring:message code="mobile.nextPage"/></a>
                            &nbsp;<spring:message code="report.total"/><label id="allPage1"></label><spring:message code="mobile.prePage"/>
                        </td>
                        <td></td>
                        <td align="center">
                            <a id="prePage2" href=""><spring:message code="mobile.prePage"/></a>
                            &nbsp;<spring:message code="report.the"/><label id="currentPage2"></label><spring:message code="mobile.prePage"/>&nbsp;
                            <a id="nextPage2" href=""><spring:message code="mobile.nextPage"/></a>
                            &nbsp;<spring:message code="report.total"/><spring:message code=""/><label id="allPage2"></label><spring:message code="mobile.prePage"/>
                        </td>
                    </tr>
                    <tr height="100">
                        <td colspan="3" align="right">
                            <a class="l-button"
                                style="width: 79px;float:right;margin-right:10px; height: 20px; "
                                onclick="javascript:spf_saveProductToArea()"><spring:message code="hrms.save"/></a>
                            <a class="l-button"
                                style="width: 79px;float:right;margin-right:10px; height: 20px; "
                                onclick="javascript:spf_backToArea()"><spring:message code="mobile.returnToArea"/></a>
                        </td>
                    </tr>
                </table>
            </div>
            
            
        </div>
    </div>
</body>
</html>
