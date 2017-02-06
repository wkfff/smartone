<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
    <script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
    <script src="/resources/js/function.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
        var salesOrdersListgrid;
        $(function(){
            initGrid();
        });

        function initGrid(){
            salesOrdersListgrid = $("#salesOrderGrid").ligerGrid({
                columns:[
                    {display:"<spring:message code="hrms.serialNumber"/>", name:"salesOrderId",width:'150'},
                    {display:"<spring:message code="hrms.placeOrderPerson"/>", name:"owner.empName"},
                    {display:"<spring:message code="hrms.customerName"/>", name:"customer.customerName"},
                    {display:"<spring:message code="hrms.salesMode"/>", name:"salesMode.salesModeName"},
                    {display:"<spring:message code="prostor.sales.order.search.date"/>", name:"orderDate", dateFormat: "yyyy-MM-dd",width:'150'},
                    {display:"<spring:message code="hrms.projectQuantity"/>", name:"price.price"},
                    {display:"<spring:message code="hrms.discount"/>", name:"price.discount"},
                    {display:"<spring:message code="productStorage.foldTheAmount"/>", name:"price.discountPrice"},
                    {display:"<spring:message code="productStorage.theAmountReceived"/>", name:"receivedMoney",editor:{type:'float'}},
                    {display:"<spring:message code="hrms.transportMode"/>", name:"transportMode"},
                    {display:"<spring:message code="hrms.delivery.date"/>", name:"deliveryDate"},
                    {display:"<spring:message code="hrms.approvalActive"/>", name:"affirmFlag.codeName"},
//                    {display:"<spring:message code="productStorage.reviewer"/>", name:"affirmedEmp.empName"},
                    {display:"<spring:message code="productStorage.theDatabaseState"/>", name:"statusFlag.codeName"},
                    {display:"<spring:message code="hrms.confirmationActive"/>", name:"traStatusFlag.codeName"},
                    {display:"<spring:message code="prostor.storage.remark"/>", name:"remark",editor:{type:'text'},width:'150'} ,
                    { display: '<spring:message code="productStorage.seeDetails"/>', render:function(item){
                        return '<div style="cursor: pointer;" onClick="showDetail(\''+item.salesOrderNo+'\')">...</div>';
                    }}
                ],
                enabledEdit: true,
                url:"/productStorage/proBusinessManage/getAllSalesOrders",
                method: "post",
                userPager:true,
                isScroll: true, frozen:false,
                rownumbers: true,
                pageSizeOptions: [5,10, 20, 50],
                showTitle: false,width:'100%',columnWidth:120,height : '100%'
            })
        }

        function showDetail(SALES_ORDER_NO){
            $dialog = $.ligerDialog.open({
                isDrag: true,
                title: '<spring:message code="productStorage.salesOrderDetails"/>',
                width: 900 ,
                height: 480,
                left:120,
                top:60,
                showMax : true,
                showMin : true,
                isResize : true,
                url:'/productStorage/proStorageManage/viewSaleOrderDetail?SALES_ORDER_NO=' + SALES_ORDER_NO
            });
        }



        //添加销售单
        var tab = parent.tab;
        function spf_add() {
            if (tab.isTabItemExist('prosto0202')) {
                tab.removeTabItem('prosto0202');
            }
            tab.addTabItem({
                tabid:'prosto0202',
                text:'<spring:message code="productStorage.salesOrder"/>',
                url: '/productStorage/proBusinessManage/viewProductSale?MENU_CODE=prosto0205'
            });
        }

        function spf_search() {
            salesOrdersListgrid.setOptions({
                parms: [
                    {name: 'keyWord', value: $("#keyWord").val()},
                    {name: 's_date', value: $("#s_date").val()},
                    {name: 'e_date', value: $("#e_date").val()}
                ],
                newPage: 1
            });
            salesOrdersListgrid.loadData(true);
        }

    function spf_delete() {
        var selectedRow = salesOrdersListgrid.getSelectedRow();
        if (!selectedRow || selectedRow.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }

       if (selectedRow.length > 1) {
           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>');
           return;
       }

        if (selectedRow.affirmFlag.codeId != "affirm0"){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.weHaveAuditedCanNotBeDeleted"/>!');
            return;
        }
        if (selectedRow.traStatusFlag.codeId=='SaleOrderState1'){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.weHaveAuditedCanNotBeDeleted"/>!');
            return;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>', '<spring:message code="hrms.warning"/>',
                function (yes) {
                    if (yes) {
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.ajax({
                    url:'/productStorage/proBusinessManage/deleteSalesOrder',
                    data:"salesOrderNo="+selectedRow.salesOrderNo+"&processId="+selectedRow.processid,
                    method:'get',
                    dataType:'json',
                    success:function (result) {
                            $.ligerDialog.closeWaitting();
                            if (result == "Y") {
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>', function () {
                                    salesOrdersListgrid.loadData(true);
                                        });
                            } else if (result == "N") {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>',
                                        '<spring:message code="prostor.storage.delete.failure"/>');
                            } else {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotdelete"/>');
                                    }
                                }
                            }
                        );
                            }
                });

    }
        //进入销售单打印界面
        function spf_printPreview() {
            var row = salesOrdersListgrid.getSelectedRow();
            if (!row || row.length == 0) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
                return;
            }
            var id = row.salesOrderId;
            if (tab.isTabItemExist('prosto0209')) {
                tab.removeTabItem('prosto0209');
            }
            tab.addTabItem({
                tabid:'prosto0209',
                text:'<spring:message code="productStorage.salesOrderPrintPreview"/>',
                url: '/productStorage/proBusinessManage/viewSalesOrderPreview?SALES_ORDER_ID='+id
            });
        }
        function spf_confirm(){
            var row = salesOrdersListgrid.getSelectedRow();
            if (!row || row.length == 0) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message
                code="hrms.chooseLine"/>');
                return;
            }
            var remark = row.remark;
            if(remark==null){remark=""}
            if(checkData(row)){
                $.ligerDialog.confirm('<spring:message code="productStorage.pleaseCheckBefore"/>?','<spring:message code="hrms.warning"/>',function (yes){
                    if(yes){
                        $.ajax({
                            type: 'post',
                            data: {
                                RECEIVEDMONEY:row.receivedMoney,
                                DISCOUNT_PRICE:row.price.discountPrice,
                                REMARKS:remark,
                                STATUS_ID:row.traStatusFlag.codeId,
                                SALES_ORDER_ID:row.salesOrderId
                                },
                            url: '/productStorage/proBusinessManage/updateSalesOrderStatus',
                            dataType: 'json',
                            async: false,
                            success: function (returnMsg){
                                if(returnMsg=='Y'){
                                    $.ligerDialog.success('<spring:message code="productStorage.confirmSuccessful"/>！','<spring:message code="hrms.warning"/>', function (){
                                        salesOrdersListgrid.loadData(true);
                                    });
                                }else{
                                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', returnMsg);
                                }
                            }
                       });
                    }
                });
            }
        }
        function checkData(row){
            if (row.receivedMoney == ""||row.receivedMoney == null||row.receivedMoney==0||row.receivedMoney=='undefined') {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterTheAmountReceived"/>！');
                return false;
            }
            if (parseFloat(row.receivedMoney)>parseFloat(row.price.discountPrice)) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.theAmountReceived1"/>！');
                return false;
            }
            if (parseFloat(row.receivedMoney)<0) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.theAmountCanNotBeNegative"/>！');
                return false;
            }
            if (row.traStatusFlag.codeId=='SaleOrderState1') {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.theOrderIsCompleteConfirmation"/>！');
                return false;
            }
            if (row.affirmFlag.codeId!='affirm1') {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '该订单审核尚未通过！');
                return false;
            }
            if (row.statusFlag.codeId=='outStatus0') {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '该订单尚未出库！');
                return false;
            }
            return true;
        }
    function spf_insExcel(){
        var row = salesOrdersListgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        location.href='/productStorage/proBusinessManage/salesOrderToExcel?salesOrderNo=' + row.salesOrderNo;
    }

    function spf_excelSaleOrder(){
        var fromDate = $("#s_date").val();
        var toDate = $("#e_date").val();
        if (fromDate==""&&toDate=="") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','请选择下单日期，以导出该时间段的销售单记录');
            return;
        }
        $.ligerDialog.confirm('确定导出吗？','<spring:message code="hrms.warning"/>',function (yes){
            if(yes){
                location.href='/productStorage/proBusinessManage/manySaleOrdersToExcel?FROM_DATE='+fromDate+"&END_DATE="+toDate
            }
        });
    }
    function spf_changeManager(){
        var row = salesOrdersListgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        $dialog = $.ligerDialog.open({
             isDrag: false, width: 800, height: 400,
             title:'<spring:message code="hrms.selectNewStaff"/>',
             url: '/utility/empInfo/viewCustSearchEmployeeB',
             buttons: [
                { text: '<spring:message code="okay"/>', onclick: btnChangeEMPID },
                { text: '<spring:message code="cancel"/>', onclick: btnCancel}
            ]
        });
    }
    function btnChangeEMPID(){
        var fn = $dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var NEW_EMP = fn();
        if (!NEW_EMP) {
           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
           return;
        }
        var jsonData = '[' ;
        var row = salesOrdersListgrid.getSelectedRow();
        $(row).each(function (index, row) {
           if (jsonData.length > 1){
               jsonData += ',{' ;
           }
           else{
               jsonData += '{' ;
           }
           jsonData += ' "NEW_OWNER_ID": "' + NEW_EMP.EMPID + '", ' ;
           jsonData += ' "CUST_ID": "' + this.customerId + '"' ;
           jsonData += '}' ;
       });
       jsonData += ']' ;
       $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
       $.post("/cust/custManage/changeCustomerEMPID",
           [{ name: 'jsonData', value: jsonData }],
           function (result) {
               $.ligerDialog.closeWaitting();
               if (result == "Y") {
                   $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>');
               }
               else {
                   $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
               }
           });
       $dialog.close();
       spf_search();
   }

   function btnCancel() {
       $dialog.close();
   }
    </script>
    <style type="text/css">
        body {
            padding: 5px;
            margin: 0;
        }
        .inputClass {
            width: 200px;
            height: 23px;
            border: 1px solid #A3C0E8;
        }
        .label, .value{
            display: inline-block;
        }
        .label{
            width: 120px;
            padding: 5px 0;
        }
        .value{
            margin-right: 20px;
        }
        .sp-button{
            float: left;
            margin: 10px;
            margin-left: -10px;
        }
        .clearfix:before,
        .clearfix:after {
            content: " "; /* 1 */
            display: table; /* 2 */
        }

        .clearfix:after {
            clear: both;
        }

        /**
         * For IE 6/7 only
         * Include this rule to trigger hasLayout and contain floats.
         */
        .clearfix {
            *zoom: 1;
        }

    </style>
</head>
<body>
<div>
    <div id="salesOrderSearch">
        <div class="form">
            <div class="l-table-edit-t label"><spring:message code="keyWord"/></div>
            <div class="l-table-edit-c value"><input class="inputClass" id="keyWord" type="text" 
                         title="<spring:message code="productStorage.search"/>"/></div>
            <div class="l-table-edit-t label"><spring:message code="prostor.sales.order.search.date"/></div>
            <div class="l-table-edit-c value">
                <input type="text" id="s_date"
                       onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>, isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                       readonly="readonly" class="inputClass"/> ~
                <input type="text" id="e_date"
                       onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>, isShowClear:true, readOnly:true,dateFmt:'yyyy-MM-dd'})"
                       readonly="readonly" class="inputClass"/>
            </div>
        </div>
    </div>
    <div class="clearfix ">
        <div class="sp-button">
            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_printPreview()">
                <spring:message code="hrms.printPreview"/>
           </a>
           <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_insExcel()">
                Excel单条导出
           </a>
           <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_excelSaleOrder()">
                Excel多条导出
           </a>
           <SipingSoft:button />
        </div>
    </div>

    <div id="salesOrderGrid"></div>
</div>
</body>
</html>
