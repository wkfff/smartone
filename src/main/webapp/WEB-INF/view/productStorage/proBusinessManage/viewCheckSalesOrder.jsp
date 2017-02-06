<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>

<script type="text/javascript">
    var $pruchaseOrderDetail_grid;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create : function(container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue : function(input, editParm) {
            return input.val();
        },
        setValue : function(input, value, editParm) {
            input.val(value);
        },
        resize : function(input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width)
                input.width(column.editor.width);
            else
                input.width(width);
            if (column.editor.height)
                input.height(column.editor.height);
            else
                input.height(height);
        }
    };
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        spf_pro_initGrid();
    });

    //销售单详情
    function spf_pro_initGrid() {
        $pruchaseOrderDetail_grid = $("#salesOrderDetail").ligerGrid(
            {
                checkbox : false,
                columns : [
                    {display : '<spring:message code="hrms.itemCode"/>',name : 'PRODUCT_ID',width : '120'},
                    {display : '货品名称',name : 'PRODUCT_NAME',width : '120'},
                    {display : '规格',name : 'SPECIFICATION',width : '100'},
                    {display : '单位',name : 'UNIT_CODE_NAME',width : '100'},
                    {display : '单价',name : 'PRICE',width : '100'},
                    {display : '数量',name : 'QUANTITY',width : '100'},
                    {display : '原价',name : 'MONEY',width : '100'},
                    {display : '折扣',name : 'DISCOUNT',width : '100'},
                    {display : '折后价',name : 'DISCOUNT_MONEY',width : '100'},
                    {display : '<spring:message code="hrms.remarks"/>',name : 'REMARKS',width : '220'}
                ],
                enabledEdit : true,
                usePager : true,
                rownumbers : true,
                url : '/productStorage/proBusinessManage/getSalesOrderDetailForCheck?SALES_ORDER_ID='+'${salesOrder.SALES_ORDER_ID}',
                width : '100%',
                height : '100%',
                pageSize : 10
            });
    }
</script>
</head>
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

.tableLabel{
    height:22px;
    line-height:22px;
    color:#014d7e;
    font-family:"宋体";
    text-align:center;
    background-color:#c1dbfa;
    font-size:12px;
}

</style>
<body style="padding: 2px">
    <div id="layout1">
        <div style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                        <td>
                            <div class="tableLabel"><spring:message code="hrms.serialNumber"/></div>
                        </td>
                        <td class="l-table-edit-c">
                            <input name="SALES_ORDER_ID" id="SALES_ORDER_ID" type="text" value="${salesOrder.SALES_ORDER_ID}" class="inputClass" readonly="readonly" style="height:20px;"/>
                        </td>
                        <td>
                            <div class="tableLabel">客户名称</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input name="CUST_NAME" id="CUST_NAME" type="text" value="${salesOrder.CUST_NAME}" class="inputClass" readonly="readonly" style="height:20px;"/>
                        </td>
                        <td>
                            <div class="tableLabel">下单人</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="ORDER_PER" id="ORDER_PER" readonly="readonly" value="${salesOrder.ORDER_PER}" class="inputClass"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">下单日期</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="ORDER_DATE" id="ORDER_DATE" class="inputClass" value="${salesOrder.ORDER_DATE}" readonly="readonly"/>
                        </td>
                        <td>
                            <div class="tableLabel">销售方式</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="SALES_MODE_NAME" id="SALES_MODE_NAME" class="inputClass" value="${salesOrder.SALES_MODE_NAME}" readonly="readonly"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">发票抬头</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="INVOICE_TITLE" id="INVOICE_TITLE" value="${salesOrder.INVOICE_TITLE}" readonly="readonly" class="inputClass">
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">总金额</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="ORIGINAL_PRICE" id="ORIGINAL_PRICE" class="inputClass" value="${salesOrder.ORIGINAL_PRICE}" readonly="readonly"/>
                        </td>
                        <td>
                            <div class="tableLabel">订单折扣</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="DISCOUNT" id="DISCOUNT" class="inputClass" value="${salesOrder.DISCOUNT}" readonly="readonly"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">折后金额</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="DISCOUNT_PRICE" id="DISCOUNT_PRICE" value="${salesOrder.DISCOUNT_PRICE}" readonly="readonly" class="inputClass">
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">运输方式</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="TRANSPORT_MODE" id="TRANSPORT_MODE" class="inputClass" value="${salesOrder.TRANSPORT_MODE}" readonly="readonly"/>
                        </td>
                        <td>
                            <div class="tableLabel">交货日期</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="DELIVERY_DATE" id="DELIVERY_DATE" class="inputClass" value="${salesOrder.DELIVERY_DATE}" readonly="readonly"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">收货人</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="CONSIGNEE" id="CONSIGNEE" value="${salesOrder.CONSIGNEE}" readonly="readonly" class="inputClass">
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">收货地址</div>
                        </td>
                        <td class="l-table-edit-c" colspan="3">
                            <input type="text" name="DELIVERY_ADDRESS" id="DELIVERY_ADDRESS" class="inputClass" 
                                value="${salesOrder.DELIVERY_ADDRESS}" readonly="readonly" style="width: 550px;"/>
                        </td>
                        <td>
                            <div class="tableLabel">备注</div>
                        </td>
                        <td class="l-table-edit-c">
                            <input type="text" name="REMARKS" id="REMARKS" class="inputClass" value="${salesOrder.REMARKS}" readonly="readonly"/>
                        </td>
                    </tr>
                </table>
        </div>
        <div align="center">
            <div id="salesOrderDetail"></div>
        </div>
    </div>
</body>
</html>