<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    // 初始调用
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
    $(function() {
        f_initGrid();
    });
    function f_initGrid() {
        $grid = $("#orderDetail").ligerGrid({
            columns:[
                        {display : '<spring:message code="hrms.productCode"/>',name : 'PRODUCT_ID',width : 100},
                        {display : '货品名称',name : 'PRODUCT_NAME',width : 120},
                        {display : '规格',name : 'SPECIFICATION',width : 80},
                        {display : '<spring:message code="hrms.productCategory"/>',name : 'PRODUCT_CATEGORY',width : 100},
                        {display : '<spring:message code="hrms.unit"/>',name : 'UNIT_NAME',width : 80},
                        {display : '应出库量',name : 'QUANTITY',width : 80},
                        {display : '<spring:message code="hrms.unitPrice"/>',name : 'PRICE',width : 80},
                        {display : '总金额',name : '',width : 80,render:function(item){
                            return (parseFloat(item.PRICE))*(parseFloat(item.QUANTITY));
                        }},
                        {display : '折扣',name : 'DISCOUNT',width : 80},
                        {display : '折后金额',name : 'MONEY_SUM',width : 90},
                        {display : '已出库量',name : 'OUT_QUANTITY',width : 80},
                        {display : '<spring:message code="hrms.remarks"/>',name : 'REMARK',width : 200,editor: { type: 'textarea',height:80}}
                    ],
            enabledEdit: true,
            usePager: true,
            rownumbers:true,
            url : '/productStorage/proStorageManage/getSalesOrderInfo',
            parms: [
                    { name: 'SALES_ORDER_NO', value: ${paraMap.SALES_ORDER_NO}},
                    { name: 'SALES_MODE_NO', value: ${paraMap.SALES_MODEL_NO}}
                   ],
            pageSize:5,
            pageSizeOptions:[5,10,15],
            height: '88%'
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
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 5px">
    <div id="layout1">
        <table width="100%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="11.1%" class="l-table-edit-t" nowrap="nowrap">销售单号</td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.SALES_ORDER_ID}</td>
                <td width="11.1%" class="l-table-edit-t" nowrap="nowrap">销售方式</td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.SALES_MODE_NAME}</td>
                <td width="11.1%" class="l-table-edit-t" nowrap="nowrap">发票类型</td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.INVOICE_TYPE}</td>
            </tr>
            <tr>
                <td class="l-table-edit-t" nowrap="nowrap">下单人</td>
                <td class="l-table-edit-c">${paraMap.ORDERED_PERSON}</td>
                <td class="l-table-edit-t" nowrap="nowrap">付款方式</td>
                <td class="l-table-edit-c">${paraMap.PAYMENTMODE}</td>
                <td class="l-table-edit-t" nowrap="nowrap">发票抬头</td>
                <td class="l-table-edit-c">${paraMap.INVOICE_TITLE_TYPE}&nbsp;&nbsp;${paraMap.INVOICE_TITLE_CONTENT}</td>
            </tr>
            <tr>
                <td class="l-table-edit-t" nowrap="nowrap">客户名称</td>
                <td class="l-table-edit-c">${paraMap.CUST_NAME}</td>
                <td class="l-table-edit-t" nowrap="nowrap">下单日期</td>
                <td class="l-table-edit-c">${paraMap.ORDER_DATE}</td>
                <td class="l-table-edit-t" nowrap="nowrap">发票内容</td>
                <td class="l-table-edit-c">${paraMap.INVOICE_CONTENT}</td>
            </tr>
        </table>
        <div id="orderDetail" style="margin-top:5px;"></div>
        <table width="100%" style="margin-top:5px;" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="11.1%" class="l-table-edit-t"><spring:message code="hrms.projectQuantity"/></td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.TOTAL_MONEY}</td>
                <td width="11.1%" class="l-table-edit-t">折扣</td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.DISCOUNT}</td>
                <td width="11.1%" class="l-table-edit-t">折后金额</td>
                <td width="22.2%" class="l-table-edit-c">${paraMap.DISCOUNT_PRICE}</td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="hrms.consignee"/></td>
                <td class="l-table-edit-c">${paraMap.CONSIGNEE}</td>
                <td class="l-table-edit-t"><spring:message code="hrms.deliveryAddress"/></td>
                <td class="l-table-edit-c" nowrap="nowrap" colspan="4">${paraMap.DELIVERY_ADDRESS}</td>
            </tr>
        </table>
    </div>
</body>
</html>