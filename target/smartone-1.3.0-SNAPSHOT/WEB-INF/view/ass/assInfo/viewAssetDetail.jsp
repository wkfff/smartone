<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>   
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript">
    var $grid ;
    var $dialog ;
    // 初始调用
    $(function ()
   {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
        if($("#ASSET_ID").html()==null || $("#ASSET_ID").html()==''|| $("#ASSET_ID").html()=='undefined'){
             $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="ass.tip"/>', function afterClick(){
                 top.tab.removeTabItem('ass0102');
             });
        }
    });
    function spf_click(){
        tab.addTabItem({ tabid : 'ass0102',text: '<spring:message code="ass.Details"/>', url: '/ass/assInfo/viewAssetDetail?MENU_CODE=ass0102' });       
    }
    </script>
    
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding: 2px">
    <div id="layout1" id='' title=' '>
        <div position="center" id='' title=' ' style="border: 0px;">
            <%@include file="viewBasicInfo.jsp"%>
            <br>
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="ass.DatailInformation"/></td>
                    <td width="5%" align="left">&nbsp;</td>
                    <td width="65%" align="right"></td>
                </tr>
            </table>
            <table width="99.2%" align="center" cellpadding="0" cellspacing="0"
                class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="20%" class="l-table-edit-t"><spring:message code="ass.engliseName"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${assetDetail.ASSET_EN_NAME }</td>
                    <td width="20%" class="l-table-edit-t"><spring:message code="ass.assetType"/></td>
                    <td width="30%" class="l-table-edit-c">
                        ${assetDetail.ASSET_CATEGORY }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.department"/></td>
                    <td width="20%" class="l-table-edit-c">${assetDetail.DEPTNAME
                        }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.useOfPersonnel"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.USER_NAME }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.purchase"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.PURCHASE_DATE }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.originalValue"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.ORIGINAL_VALUE }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.manufacturer"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.MANUFACTURER }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.dateOfManufacture"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.MANUFACTURE_DATE }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.model"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.ASSET_MODEL }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.internationalCode"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.INTERNATIONAL_NUMBER }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.life"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.SERVICE_LIFE }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.depreciationMethods"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.DEPRECIATION_WAY }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.residualRate"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.NET_SALVAGE_VALUE }</td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.netWorth"/></td>
                    <td width="20%" class="l-table-edit-c">
                        ${assetDetail.NET_VALUE }</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="ass.assetStatus"/></td>
                    <td width="20%" class="l-table-edit-c" colspan="3">
                        ${assetDetail.STATUS }</td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>
