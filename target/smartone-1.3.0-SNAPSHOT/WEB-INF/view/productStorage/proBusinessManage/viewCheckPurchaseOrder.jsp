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
<script src="/resources/js/ligerUI/js/core/base.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>

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
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        spf_pro_initGrid();
    });

    //采购单详情
    function spf_pro_initGrid() {
        $pruchaseOrderDetail_grid = $("#purchaseOrderDetail").ligerGrid(
            {   checkbox : false,
                columns : [
                    {display : '<spring:message code="hrms.itemCode"/>',name : 'PRODUCT_ID',width : '15%'},
                    {display : '<spring:message code="hrms.nameAndSpecification"/>',name : 'NAME_SPECIFICATION',width : '15%',
                        editor : {type : 'textarea',height : 100}},
                    //{display : 'CAS',name : 'PRODUCT_CAS',width : '10%'},
                    {display : '<spring:message code="hrms.supplier"/>',name : 'SUPPLIER',width : '15%',
                        editor : {type : 'textarea',height : 100}
                    },
                    {display : '<spring:message code="hrms.unitPrice"/>',name : 'UNIT_PRICE',width : '7%'},
                    {display : '<spring:message code="hrms.quantity"/>',name : 'QUANTITY',width : '8%'},
                    {display : '<spring:message code="hrms.amountOfMoney"/>',name : 'SUM_MONEY',width : '10%'},
                    {display : '<spring:message code="hrms.expectedDeliveryDate"/>',name : 'ARRIVAL_DATE',width : '15%',
                        editor : {type : 'textarea',height : 100}},
                    {display : '<spring:message code="hrms.remarks"/>',name : 'REMARKS',align : 'left',width : '15%',
                        editor : {type : 'textarea',height : 100}
                    }
                ],
                enabledEdit : true,
                usePager : true,
                rownumbers : false,
                url : "/productStorage/proBusinessManage/getPurchaseOrderDetailList?PURCHASE_ORDER_ID="+"${purchaseOrder.ORDER_ID}",
                width : '100%',
                height : '100%',
                pageSize : 10,
                showTitle : false
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
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.serialNumber"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" name="ORDER_ID" id="ORDER_ID" type="text" value="${purchaseOrder.ORDER_ID}" class="inputClass" readOnly style="height:20px;"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.purchaser"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" name="EMPID_NAME" id="EMPID_NAME" type="text" value="${purchaseOrder.CHINESENAME}" class="inputClass" readOnly style="height:20px;"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.payableAmount"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="PAYABLE_AMOUNT" id="PAYABLE_AMOUNT" readonly="readonly" value="${purchaseOrder.PAYABLE_AMOUNT}"
                                class="inputClass"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.purchaseDate"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="PURCHASE_DATE" id="PURCHASE_DATE" class="inputClass" value="${purchaseOrder.PURCHASE_DATE}" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.paymentMode"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="PURCHASE_DATE" id="PURCHASE_DATE" class="inputClass" value="${purchaseOrder.PAYMENT_MODE}" readOnly/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.transportMode"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="TRANSPORT_MODE" id="TRANSPORT_MODE" value="${purchaseOrder.TRANSPORT_MODE}" readOnly class="inputClass">
                        </td>
                    </tr>
                    <tr>
                        <td class="tableLabel"><spring:message code="hrms.remarks"/></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="width: 390px; height: 50px" id="REMARKS"
                                name="REMARKS" readOnly>${purchaseOrder.REMARKS}</textarea></td>
                    </tr>
                </table>
        </div>
        <div align="center">
            <div id="purchaseOrderDetail"></div>
        </div>
    </div>
</body>
</html>