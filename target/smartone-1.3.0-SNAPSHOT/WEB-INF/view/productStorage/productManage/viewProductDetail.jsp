<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta http-equiv="Pragma" content="No-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Expires" content="-1">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" type="text/css" href="/resources/css/jquery.jqzoom.css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
<script src="/resources/js/json2.js" type="text/javascript"></script> 
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src='/resources/js/jquery/jquery.jqzoom-core.js'></script> 
<script type="text/javascript">
	var $stockGrid;
    var $dialog ;
    $(function (){
        //布局	
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        spf_stock_initGrid();
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid)
            {  
                if(tabid=="tabitem1"){ 
                    //已经分组人员 
                    spf_stock_initGrid();
                } 
                if(tabid=="tabitem2"){
                    spf_sale_initGrid();
                }
                if(tabid=="tabitem3"){
                    spf_doc_initGrid();
                }
            } 
        });
        
        $("#proImage").mouseover(function(e){
            $("#showProImageBig").attr("src",$(this).attr("src"));
            $("#showProImageBig").css({
                "left":(e.pageX+10)+"px",
                "top":(e.pageY+10)+"px"
            });
            $("#showProImageBig").stop(true,true);
            $("#showProImageBig").show(100);
        });
        $("#proImage").mouseout(function(e){
            //$("#showProImageBig").attr("src",$(this).attr("src"));
            $("#showProImageBig").hide(500);
        });
        $("#proImage").mousemove(function(e){
            if($("#showProImageBig").css("display")!="none"){
                $("#showProImageBig").css({
                    "left":(e.pageX+10)+"px",
                    "top":(e.pageY+20)+"px"
                });
            }
        });
    });
    
    var tab = parent.tab;
    function spf_afterRemove(){
        $dialog.close();
        tab.removeSelectedTabItem(); //关闭当前窗口
        if(tab.isTabItemExist('prosto0106')){  //刷新物料列表窗口
            tab.reload('prosto0106');
        }
    }
    
    function spf_stock_initGrid(){
        $stockgrid = $("#stockInfo").ligerGrid({
            checkbox: false,
            columns: [
                        { display: '<spring:message code="prostor.storage.search.name"/>', name: 'STORAGE_NAME', width: 120},
                        { display: '<spring:message code="prostor.storeQuantity"/>', name: 'LEFT_QUANTITY', width: 100},  
                        { display: '<spring:message code="hrms.unit"/>', name: 'CODE_NAME', width: 100 },
                        { display: '<spring:message code="prostor.storeAddr"/>', name: 'STOR_ADDR', width: 200}
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/productStorage/productManage/getProStorDetailList',
            parms: [
                    { name: 'PRODUCT_NO',value: '${product.PRODUCT_NO}'}
                   ],
            width: '99.6%', height: '100%'
        });
    }
    
    function spf_sale_initGrid(){
        $stockgrid = $("#saleInfo").ligerGrid({
            checkbox: false,
            columns: [
                        { display: '<spring:message code="hrms.salesMode"/>', name: 'SALES_MODE_NAME', width: 120},
                        { display: '<spring:message code="hrms.unitPrice"/>', name: 'PRICE', width: 100}
                    ],
            enabledEdit: false,usePager: true, rownumbers:true,
            url: '/productStorage/productManage/getProSaleDetailList',
            parms: [    
                    { name: 'PRODUCT_NO',value: '${product.PRODUCT_NO}'}
                   ],
            width: '99.6%', height: '100%'
        });
    }
    
    function spf_doc_initGrid()
    {
        $grid = $("#docInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.serialNumber"/>', name: 'DOC_ID', width: 0, hide:1},
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'ORI_ID', width: 150},
                        { display: '<spring:message code="hrms.docName"/>', name: 'DOC_NAME', width: 150},
                        { display: '<spring:message code="hrms.docVersion"/>', name: 'DOC_VERSION', width: 150},
                        { display: '<spring:message code="hrms.docType"/>', name: 'DOC_TYPE', width:150},
                        { display: '<spring:message code="hrms.active"/>', name: 'DOC_STATUS', width: 100},
                        { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 200},
                        { display: '<spring:message code="hrms.detailedInformation"/>',  width: 150,
                            render: function (item)  
                            { 
                               return '<div style="cursor: pointer;color:green;" onClick="spf_viewDocumentDetail(\''+item.DOC_ID+'\')"><spring:message code="hrms.clickToView"/></div>';
                            }
                        }
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/doc/docInfo/getWorkDocumentList',
            parms: [
                        {name:'OBJECT_ID',value : '${product.PRODUCT_ID}'},
                        {name:'OBJECT_TYPE_ID',value : 'PRODUCT'}
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
                spf_viewDocumentDetail(rowdata.DOC_ID);
            }
        });
    }
    var tab = parent.tab;
    function spf_viewDocumentDetail(DOC_ID){
        if(tab.isTabItemExist('doc0102')){
            tab.removeTabItem('doc0102');
        }
        tab.addTabItem({ tabid : 'doc0102',text: '文档信息', url: '/doc/docInfo/viewDocumentDetail?MENU_CODE=doc0102&DOC_ID='+DOC_ID });
    }
    function spf_uploadPhoto() {
        $dialog = $.ligerDialog.open({
            isDrag : false,
            title : '上传头像',
            width : 420,
            height : 220,
            url : '/upload/fileUpload/uploadProImage?PRODUCT_ID=${product.PRODUCT_ID}&PRODUCT_NO=${product.PRODUCT_NO}'
        });
    }
    function spf_photo_ChildWindowClose() {
        $("#proImage").attr("src","/resources/picture/product/${product.PRODUCT_ID }.jpg");
        $dialog.close();
    }
    </script>
<style type="text/css">
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout2{  width:99.8%;margin:0; padding:0;}
    #layout3{  width:99.8%;margin:0; padding:0;}
    #showProImageBig{
        display:none;
        position:absolute;
        width:600px;
        height:450px;
        border:3px solid #A3C0E8;
    }
</style>    
</head>
<body style="padding:0px">
    <div id="layout2" >
        <div align="center">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                    <td width="25%" align="left" style="font-weight: bold;">
                        <spring:message code="prostor.productInformation"/>
                    </td>
                    <td width="5%" align="left">
                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="65%" align="right">
                        &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table> 
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="15%" class="l-table-edit-cc" rowspan="6" style="cursor: pointer;">
                        <img src="/resources/picture/product/${product.PRODUCT_ID }.jpg" id="proImage"
                            onerror="this.src='/resources/picture/none.gif'"
                            onClick="spf_uploadPhoto()" width="170" height="150"/>
                    </td>
                </tr>
                <tr height="25">
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.productCode"/></td>
                    <td class="l-table-edit-c">  
                        ${product.PRODUCT_ID }
                    </td>
                </tr>
                <tr height="25">
                    <td class="l-table-edit-t"><spring:message code="hrms.product.name"/></td>
                    <td class="l-table-edit-c">  
                        ${product.PRODUCT_NAME }
                    </td>
                </tr>
                <tr height="25">
                    <td class="l-table-edit-t"><spring:message code="hrms.specification"/></td>
                    <td class="l-table-edit-c">
                        ${product.SPECIFICATION }
                    </td>
                </tr>
                <tr height="25">
                    <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                    <td class="l-table-edit-c">
                        <c:if test="${product.STATUS==0}">
                            <spring:message code="hrms.disable"/>
                        </c:if>
                        <c:if test="${product.STATUS==1}">
                            <spring:message code="hrms.enable"/>
                        </c:if>
                    </td>
                </tr>
                <tr height="50">
                    <td class="l-table-edit-t" ><spring:message code="hrms.description"/></td>
                    <td class="l-table-edit-c">
                        ${product.REMARK }
                    </td>
                </tr>
            </table>
            <br/>
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                    <td width="25%" align="left" style="font-weight: bold;">
                        <spring:message code="prostor.productDetail"/>
                    </td>
                    <td width="5%" align="left">
                        &nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="65%" align="right">
                        &nbsp;&nbsp;&nbsp;
                    </td>
                </tr>
            </table> 
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="20%" class="l-table-edit-t"><spring:message code="prostor.storeQuantity"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${product.LEFT_QUANTITY }
                    </td>
                    <td width="20%" class="l-table-edit-t"><spring:message code="hrms.unit"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${product.UNIT_CODE }
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t"><spring:message code="hrms.productCategory"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${product.PRODUCT_CATEGORY_NAME}
                    </td>
                    <td width="20%" class="l-table-edit-t"><spring:message code="hrms.unitPrice"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${product.UNIT_PRICE}
                    </td>
                </tr>
                <c:forEach items="${p_valueList}" var="property" varStatus="i">
                    <c:if test="${i.index == 0}" >
                        <tr>
                    </c:if>
                    <c:if test="${i.index != 0}" >
                        <c:if test="${i.index%2 == 0}" >
                            </tr>
                        </c:if>
                    </c:if>
                    <td width="20%" class="l-table-edit-t">${property.PROPERTY_NAME }</td>
                    <td class="l-table-edit-c">
                        ${property.P_VALUE}
                    </td>
                    <c:if test="${i.index != 0}" >
                        <c:if test="${i.index%2 == 0}" >
                            <tr>
                        </c:if>
                    </c:if>
                </c:forEach>
            </table>
            <br/>
        </div>
    </div>
    <div id="layout3" id='' title=' '> 
        <div id='' title=' ' style="border: 0px;">
            <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                    <td width="25%" align="left" style="font-weight: bold;">
                        <spring:message code="prostor.Other"/>
                    </td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;
                    </td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;
                    </td>
                </tr> 
            </table>  
        <div>
            <table width="99.6%" cellpadding="0" cellspacing="0"class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            </table>
        </div>
        <div align="left" style="heigth:30%">
            <div id="navtab1">
                <div title='<spring:message code="prostor.storeInformation"/>'>
                    <div id="stockInfo"></div>
                </div>
                <div title='<spring:message code="hrms.salesMode"/>'>
                    <div id="saleInfo"></div>
                </div>
                <div title='<spring:message code="prostor.doc"/>'>
                    <div id="docInfo"></div>
                </div>
            </div>
        </div>
    </div>
</div>
<img src="" id="showProImageBig"/>
</body>
</html>

