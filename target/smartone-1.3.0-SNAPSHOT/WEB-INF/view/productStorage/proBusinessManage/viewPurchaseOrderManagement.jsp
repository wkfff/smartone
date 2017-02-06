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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
<script type="text/javascript">
    var $dialog;
    var $pruchaseOrder_grid;
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
    //采购单基本信息
    function spf_pro_initGrid() {
        $pruchaseOrder_grid = $("#purchaseOrderInfo").ligerGrid(
            {
                checkbox : false,
                columns : [
                    {display : 'PID',name : 'PROCESSID',width : '1%',hide:1},
                    {display : '<spring:message code="hrms.serialNumber"/>',name : 'ORDER_ID',width : '15%'},
                    {display : '<spring:message code="hrms.purchaser"/>',name : 'CHINESENAME',width : '7%'},
                    {display : '<spring:message code="hrms.purchaseDate"/>',name : 'PURCHASE_DATE',width : '10%',type : 'date',
                        format : 'yyyy-MM-dd'
                    },
                    {display : '<spring:message code="hrms.payableAmount"/>',name : 'PAYABLE_AMOUNT',width : '10%'},
                    {display : '<spring:message code="hrms.paymentMode"/>',name : 'PAYMENT_MODE',width : '10%'},
                    {display : '<spring:message code="hrms.transportMode"/>',name : 'TRANSPORT_MODE',width : '10%',
                        editor : {type : 'textarea',height : 100}
                    },
                    {display : '入库状态',name : 'STATUS',width : '7%',
                        render: function (item){ 
                            if(item.STATUS == 'PurchaseOrderState0' ){
                                return '<p style="color: black;">未完成</p>';
                            }else if (item.STATUS == 'PurchaseOrderState1' ){
                                return '<p style="color: green;">已完成</p>';
                            }
                        }   
                    },
                    {display : '审核状态',name : 'AFFIRM_FLAG',width : '7%',
                        render: function (item){ 
                            if(item.AFFIRM_FLAG == 'affirm0' ){
                                return '<p style="color: black;">未审核</p>';
                            }else if (item.AFFIRM_FLAG == 'affirm1' ){
                                return '<p style="color: green;">已通过</p>';
                            }else if (item.AFFIRM_FLAG == 'affirm2' ){
                                return '<p style="color: red;">已否决</p>';
                            }
                        }   
                    },
                    {display : '<spring:message code="hrms.checker"/>',name : 'CHECKER',width : '7%'},
                    {display : '<spring:message code="hrms.remarks"/>',name : 'REMARKS',width : '10%',
                        editor : {type : 'textarea',height : 100}
                    },
                    {display : '<spring:message code="hrms.detailedInformation"/>',width : '10%',
                        render : function(item) {
                            return "<a class='clickA' href='javascript:spf_showPurchaseOrderDetail("+item.ORDER_NO+")'><spring:message code='hrms.clickToView'/></a>";
                        }   
                    }
                ],
                enabledEdit : true,
                usePager : true,
                rownumbers : true,
                url : "/productStorage/proBusinessManage/getPurchaseOrderList",
                width : '100%',
                height : '100%',
                pageSize : 15,
                pageSizeOptions: [15,20,30,40,50],
                showTitle : false
            });
    }
    //搜索
    function spf_search(){
        $pruchaseOrder_grid.setOptions({ 
            parms: [    
            { name: 'keyWord', value: $("#keyWord").attr('value')},
            { name: 'PAYMENT_MODE', value: $("#PAYMENT_MODE").attr('value')},
            { name: 'STATUS', value: $("#STATUS").attr('value')}, 
            { name: 'S_DATE', value: $("#S_DATE").attr('value')},
            { name: 'E_DATE', value: $("#E_DATE").attr('value')},
            { name: 'AFFIRM_FLAG', value: $("#AFFIRM_FLAG").attr('value')}
          ],
            newPage: 1
        }); //设置数据参数
        $pruchaseOrder_grid.loadData(true); //加载数据
    }
    //查看采购单详情
    function spf_showPurchaseOrderDetail(no) {
        $dialog = $.ligerDialog.open({
            isDrag : true,
            title : '采购单详情',
            width : 850,
            height : 380,
            left : 120,
            top : 50,
            showMax : true,
            showMin : true,
            isResize : true,
            url : '/productStorage/proBusinessManage/showPurchaseOrderDetail?PURCHASE_ORDER_NO=' + no
        });
    }
    
    var tab = parent.tab;
    //修改采购单
    function spf_update1() {
        var row = $pruchaseOrder_grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
            return;
        } 
        var affirmFlag = row.AFFIRM_FLAG;
        var id = row.ORDER_ID;
        
        if (affirmFlag == 'affirm1') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','已通过的采购单不能修改！');
            return;
        }else if(affirmFlag == 'affirm2')  {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','已否决的采购单不能修改！');
            return;
        }
        if (tab.isTabItemExist('prosto0204')) {
            tab.removeTabItem('prosto0204');
        }
        tab.addTabItem({
            tabid:'prosto0204',
            text:'采购单修改',
            url: '/productStorage/proBusinessManage/viewPurchaseOrderModify?PURCHASE_ORDER_ID='+id
        });
    }
    //添加采购单 
    function spf_add() {
        if (tab.isTabItemExist('prosto0201')) {
            tab.removeTabItem('prosto0201');
        }
        tab.addTabItem({
            tabid:'prosto0201',
            text:'采购单添加',
            url: '/productStorage/proBusinessManage/viewProductPurchase'
        });
    }
    //删除未审核的采购单
    function spf_delete() {
        var row = $pruchaseOrder_grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
            return;
        }
        var affirmFlag = row.AFFIRM_FLAG;
        if (affirmFlag == 'affirm1') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','已通过的采购单不能删除！');
            return;
        }else if(affirmFlag == 'affirm2')  {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','已否决的采购单不能删除！');
            return;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>',
        function(yes) {
            if (yes) {
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/productStorage/proBusinessManage/deletePurchaseOrder',
                [
                 {name : 'PURCHASE_ORDER_ID',value : row.ORDER_ID},
                 {name : 'PROCESSID',value : row.PROCESSID}
                ],
                function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>',
                            function() {
                                $pruchaseOrder_grid.loadData(true); //加载数据  
                            });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','删除失败');
                    }
                });
            }
        });
    }
    //进入采购单打印界面
    function spf_printPreview() {
        var row = $pruchaseOrder_grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
            return;
        } 
        //var affirmFlag = row.AFFIRM_FLAG;
        var no = row.ORDER_NO;
        /*
        if (affirmFlag == 'affirm0') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','未审核的采购单不能打印！');
            return;
        } else if (affirmFlag == 'affirm2') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','已否决的采购单不能打印！');
            return;
        }
        */
        if (tab.isTabItemExist('prosto0206')) {
            tab.removeTabItem('prosto0206');
        }
        tab.addTabItem({
            tabid:'prosto0206',
            text:'采购单打印预览',
            url: '/productStorage/proBusinessManage/viewPurchaseOrderPreview?PURCHASE_ORDER_NO='+no
        });
    }
    //将选中的采购单导出到Excel
    function spf_insExcel(){
        var row = $pruchaseOrder_grid.getSelectedRow();
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        location.href='/productStorage/proBusinessManage/purchaseOrderToExcel?PURCHASE_ORDER_NO=' + row.ORDER_NO
                +"&PURCHASER="+MyCheckNull(row.CHINESENAME)+"&PURCHASE_DATE="+MyCheckNull(row.PURCHASE_DATE)+"&PAYABLE_AMOUNT="+MyCheckNull(row.PAYABLE_AMOUNT)
                +"&PAYMENT_MODE="+MyCheckNull(row.PAYMENT_MODE)+"&CHECKER="+MyCheckNull(row.CHECKER)+"&TRANSPORT_MODE="+MyCheckNull(row.TRANSPORT_MODE);

        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
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
.clickA{
    text-decoration:none;
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
                <table width="99%" cellpadding="0" cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr height="24">
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="keyWord"/></div></td>
                        <td class="l-table-edit-c" width="20%">
                            <input width="120" type="text" name="keyWord" id="keyWord" class="inputClass" 
                                title="可输入流水号关键字进行搜索"/></td>
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="hrms.purchaseDate"/></div></td>
                        <td class="l-table-edit-c" width="23%" colspan="2">
                            <input type="text"
                                name="S_DATE" id="S_DATE" value="" size="30"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" /> ~ <input type="text" name="E_DATE"
                                id="E_DATE" value="" size="30"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" />
                        </td>
                    </tr>
                    <tr height="24">
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="hrms.paymentMode"/></div></td>
                        <td class="l-table-edit-c" width="20%">
                            <SipingSoft:selectSyCode parentCode="PaymentMode" name="PAYMENT_MODE" onChange="spf_search()"
                            limit="all" />
                        </td>
                        <td width="10%">
                            <div class="tableLabel">入库状态</div></td>
                        <td class="l-table-edit-c" width="23%">
                            <SipingSoft:selectSyCode parentCode="PurchaseOrderState" name="STATUS"
                            limit="all" onChange="spf_search()"/>
                        </td>
                        <td width="10%">
                            <div class="tableLabel">审核状态</div></td>
                        <td class="l-table-edit-c" width="23%">
                            <SipingSoft:selectSyCode parentCode="affirmStatus" name="AFFIRM_FLAG"
                            limit="all" onChange="spf_search()"/>
                        </td>
                    </tr>
                </table>
            </div>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_printPreview()">
                                <spring:message code="hrms.printPreview"/>
                        </a>
                        <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_insExcel()">
                                <spring:message code="hrms.excelExport"/>
                        </a>
                        <SipingSoft:button />
                    </td>
                </tr>
            </table>
            <div id="purchaseOrderInfo"></div>
        </div>
</body>
</html>