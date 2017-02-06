<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
 <!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始调用
    $(function () {
        //布局
        $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
        });
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid){
            }
        });
        spf_showWaringInfo();
        f_tip();
    });
    function f_tip() {
     $.ligerDialog.tip({  title: '提示信息',content:'您好！${admin.channelName}的${admin.contactName}' });
    }
    function spf_firstLogin(){
        $.post('/login/checkFirstLogin',{"ADMINID":''},function(back){
            if(back == 'Y'){
                $dialog = $.ligerDialog.open({isDrag: true,showMax: false,showMin: false,
                    title: '<spring:message code="change.password"/>',
                    width: 450 ,
                    height: 320 ,
                    url: '/ess/password/changePassword?MENU_CODE=ess0401'
                 });
             }
        });
    }
    function spf_showWaringInfo(){
        setTimeout('spf_orderInfo_initGrid()',0);
        setTimeout('spf_productInfo_initGrid()',1000);
    }
    function spf_orderInfo_initGrid() {
        $birthday_grid = $("#orderInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '', name: 'ORDER_NO', width: 10,hide: 1},
                { display: '产品数量', name: 'PRO_QUANTITY', width: 90},
                { display: '产品名称', name: 'PRO_NAME', width: 140},
                { display: '经销商名称', name: 'CHANNEL_NAME', width: 140},
                { display: '已付金额', name: 'MONEY_PAID', width: 90},
                { display: '总金额', name: 'MONEY_TOTAL', width: 90},
                { display: '订单状态', name: 'ORDER_STATE', width: 90},
                { display: '详细信息', width: 90,
                    render: function (item)
                    {
                       return '<div style="cursor: pointer;" onClick="spf_showDetail(\''+item.ORDER_ID+'\')">点此查看</div>';
                    }
                }
             ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: '/ord/ordInfo/getOrderList',
             parms: [
                    { name: 'page', value: 1},
                    { name: 'pagesize', value: 5}
                    ],
             pageSize: 5,
             pageSizeOptions: [5,10,20,30,50],
             width: '99.7%'
        });
    }
    function spf_productInfo_initGrid() {
        $productInfo_grid = $("#productInfo").ligerGrid({
            checkbox: false,
            columns: [
                        { display: '', name: 'PRODUCT_ID', width: 10,hide: 1},
                        { display: '产品名称', name: 'PRODUCT_NAME', width: 150},
                        { display: '产品描述', name: 'PRO_DESCRIPTION', width: 350}
                    ],
            enabledEdit: false, usePager: false, rownumbers:true,
            url: '/pro/proInfo/getProductList',
            parms: [
                    { name: 'ACTIVITY',value: $("#ACTIVITY").attr('value')},
                    { name: 'qryType', value: $("#qryType").attr('value')},
                    { name: 'page', value: 1},
                    { name: 'pagesize', value: 5}
                 ],
            width: '99.6%'
        });
    }
    var tab = parent.tab;
        function spf_showPage(type) {
        if(type=='order'){
            if(tab.isTabItemExist('ord0101')){
                tab.removeTabItem('ord0101');
            }
            tab.addTabItem({ tabid : 'ord0101',text: '订单列表', url: '/ord/ordInfo/viewOrderList'});
        }else if(type=='product'){
            if(tab.isTabItemExist('pro0101')){
                tab.removeTabItem('pro0101');
            }
            tab.addTabItem({ tabid : 'pro0101',text: '产品列表', url: '/pro/proInfo/viewProductList'});
        }
    }
    </script>
</head>
<style type="text/css">
     body{ padding:5px; margin:0; padding-bottom:15px;}
     #layout1{  width:99.8%;margin:0; padding:0;  }
</style>
<body style="padding: 2px">
    <div id="layout1">
        <div align="left">
            <div id="navtab1">
                <div title='<spring:message code="homepage.one"/>'>
                    <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="99.5%" align="center">
                                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('order');">
                                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                                        <td width="25%" align="left" style="font-weight: bold;">订单列表（点此查看更多）</td>
                                        <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                        <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                    </tr>
                                </table>
                                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                                    <tr>
                                        <td align="left" colspan="4">
                                            <div id="orderInfo"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="99.5%" align="center">
                                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('product');">
                                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                                        <td width="25%" align="left" style="font-weight: bold;">产品（点此查看更多）</td>
                                        <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                        <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                    </tr>
                                </table>
                                <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                                    <tr>
                                        <td align="left" colspan="4">
                                            <div id="productInfo"></div>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <br />
                </div>
            </div>
        </div>
    </div>
    </div>
</body>
</html>