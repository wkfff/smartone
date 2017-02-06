<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    var $grid_in;
    var $dialog;
    var $dialog_h;
    var storNameJson = eval(${requestScope.storageName});
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
        $("#layout2").hide();
    });
    function f_initGrid() {
        $grid = $("#SalesOrder").ligerGrid({
            columns : [
                        {display : '<spring:message code="productStorage.salesOrderNo"/>',name : 'SALES_ORDER_ID',width :200},
                        {display : '<spring:message code="productStorage.buySingle"/>',name : 'ORDERED_PERSON',width : 200},
                        {display : '<spring:message code="hrms.customerName"/>',name : 'CUST_NAME',width : 200},
                        {display : '<spring:message code="prostor.sales.order.search.date"/>',name : 'ORDER_DATE',width : 200},
                        {display : '<spring:message code="hrms.salesMode"/>',name : 'SALES_MODE_NAME',width : 200},
                        {display : '<spring:message code="productStorage.seeDetails"/>',isSort: false,width : 200,render: function (item){
                            return '<div style="cursor: pointer;" onClick="spf_showSalesOrderDetail(\''+item.SALES_ORDER_NO+'\')">...</div>';
                            }
                        }
                ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            isScroll :true,
            url : "/productStorage/proStorageManage/getSaleOrderList",
            pageSize:5,
            pageSizeOptions:[5,10,15],
            width:'99.8%',
            height:'100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_showSaleOrderDetail(rowdata);
            }
        });
    }
    function spf_showSaleOrderDetail(rowdata){
        $("#layout1").hide(100);
        $("#layout2").show();
        var columnStor = "";
        var stor_no = 0;
        $.each(storNameJson,function(i,item){
            stor_no = item.STORAGE_NO;
            columnStor = columnStor +
                         "{display : \'"+item.STORAGE_NAME+"\',columns:[{display : \'<spring:message code="productStorage.inventory"/>\',name : \'STOCKNUM"+stor_no+"\',width : 120,"+
                         "render:function(row){return spf_getLeftQuantity(row.PRODUCT_NO,"+stor_no+");}},"+
                         "{display : \'<spring:message code="productStorage.theAmountOfTheLibrary"/>\',name : \'CUNUM"+stor_no+"\',width : 120,render:function(r){"+
                         "return \'<input id=\"curr"+stor_no+"\" class=\"storClass\" onkeydown=\"spf_onlyNum();\" "+
                         "onkeyup=\"checkGreaterthan(this.value,"+stor_no+");\"/>\'}}]},";
        });
        var storNameSub = "["+columnStor.substring(0,columnStor.length-1)+"]";
        var storNameSubObj = eval(storNameSub);
        $grid_in = $("#SalesOrderDetail").ligerGrid({
            columns: [
                    {display : '<spring:message code="hrms.productName"/>',name : 'PRODUCT_NAME',width : 150},
                    {display : '<spring:message code="hrms.productSpecification"/>',name : 'SPECIFICATION',width : 90},
                    {display : '<spring:message code="mat.Unit"/>',name : 'UNIT_NAME',width : 90},
                    {display : '<spring:message code="hrms.productCategory"/>',name : 'PRODUCT_CATEGORY',width : 120},
                    {display : '<spring:message code="hrms.unitPrice"/>',name : 'PRICE',width : 90},
                    {display : '<spring:message code="productStorage.Amount"/>',name : 'MONEY_SUM',width : 100},
                    {display : '<spring:message code="productStorage.amountShouldTheLibrary"/>',name : 'QUANTITY',width : '120'},
                    {display : '<spring:message code="productStorage.hasALibraryVolume"/>',name : 'OUT_QUANTITY',width : '120'},
                    {display : '<spring:message code="productStorage.stock"/>',columns:storNameSubObj},
                    {display : '<spring:message code="productStorage.theTotalAmountOfTheLibrary"/>',name : 'CURRENT_QUANTITY',width : '120',render:function(rowdata){
                        return '<input id = "currSum" disabled="disabled" class="storClass"/>';
                    }}
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/productStorage/proStorageManage/getSalesOrderDetail',
            parms: [
                    {name: 'SALES_ORDER_NO', value: rowdata.SALES_ORDER_NO},
                    {name: 'SALES_MODE_NO', value: rowdata.SALES_MODEL_NO}
                   ],
            pageSize:10,
            pageSizeOptions:[10,20,30],
            width: '99.8%',
            height: '84%',
            onAfterShowData: changInputId
        });
        $("#SALES_ORDER_ID").val(rowdata.SALES_ORDER_ID);
        $("#ORDERED_PERSON").val(rowdata.ORDERED_PERSON);
        $("#CUST_NAME").val(rowdata.CUST_NAME);
        $("#SALES_MODE_NAME").val(rowdata.SALES_MODE_NAME);
        $("#SALES_ORDER_NO").val(rowdata.SALES_ORDER_NO);
        $("#CUST_NO").val(rowdata.CUST_NO);
        $("#MOBILEPHONE").val(rowdata.MOBILEPHONE);
        $("#DISCOUNT").val(rowdata.DISCOUNT);
    }
    
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    function spf_showSalesOrderDetail(SALES_ORDER_NO){
        $dialog = $.ligerDialog.open({
            isDrag: true,
            title: '<spring:message code="productStorage.salesOrderDetails"/>',
            width: 900 ,
            height: 450,
            left:120,
            top:60,
            showMax : true,
            showMin : true,
            isResize : true,
            url:'/productStorage/proStorageManage/viewSaleOrderDetail?SALES_ORDER_NO=' + SALES_ORDER_NO
        });
    }
    function spf_cancelOrderDetail(){
        $.ligerDialog.confirm('<spring:message code="productStorage.afterTheCancel"/>?','<spring:message code="hrms.warning"/>',function (yes){
            if(yes){
                $("#voiceReminder").attr('value','remindNo');
                $('#remindInfo').html('');
                $("#layout2").hide(500);
                $("#layout1").show(500);
            }
        });
    }
    function changeId(id,newId){
        $("#"+id).attr("id",newId);
    }
    function spf_getLeftQuantity(proNo,storNo){
        var proCnt = 0;
        $.ajax({
            type: 'post',
            url: '/productStorage/proStorageManage/getLeftQuantity?STORAGE_NO='+storNo+'&PRODUCT_NO='+proNo,
            dataType: 'json',
            async: false,
            success: function (result){
                proCnt = result;
            }
       });
       return '<div id="div'+storNo+proNo+'" ><input id ="stor'+storNo+proNo+'" value = "'+proCnt+'" class="storClass" disabled="disabled"/></div>';
    }
    function spf_onlyNum(){
        if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39)){
           if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)||(event.keyCode==110)||(event.keyCode==190))){
               event.returnValue=false;
           }
        }
    }
    function checkGreaterthan(currNo,stor_no){
        var flag = true;
        var currentNum = 0;
        var currentTotal = 0;
        var total = 0;
        var row = $grid_in.getSelectedRow();
        var storageId = "stor"+stor_no+row.PRODUCT_NO;
        var currOutNumId = "curr"+stor_no+row.PRODUCT_NO;
        var currOutSumNumId = "currSum"+row.PRODUCT_NO;
        var storNum = $("#"+storageId).val();
        if(parseFloat(currNo)>parseFloat(storNum)){
            $.ligerDialog.warn('<spring:message code="productStorage.theStorageCapacity"/>！');
            $('#'+currOutNumId).trigger("blur");
            $('#'+currOutNumId).val('');
            flag = false;
        }
        if(parseFloat(currNo)+parseFloat(row.OUT_QUANTITY)>parseFloat(row.QUANTITY)&&flag==true){
            $.ligerDialog.warn('<spring:message code="productStorage.totalAmountOf"/>！');
            $('#'+currOutNumId).trigger("blur");
            $('#'+currOutNumId).val('');
        }
        $.each(storNameJson,function(j,item){
            var storNo = item.STORAGE_NO;
            currentNum = document.getElementById("curr"+storNo+row.PRODUCT_NO).value;
            if(currentNum!=''&&currentNum!=null){
                currentTotal = parseFloat(currentNum);
                total += currentTotal;
            }
        });
        if(parseFloat(total)+parseFloat(row.OUT_QUANTITY)>parseFloat(row.QUANTITY)){
            $.ligerDialog.warn('<spring:message code="productStorage.totalAmountOf"/>！');
            $('#'+currOutNumId).trigger("blur");
            $('#'+currOutNumId).val('');
            return false;
        }
        $('#'+currOutSumNumId).val(total);
    }
    function changInputId(){
        for(var i=0;i<$grid_in.rows.length;i++){
            var row = $grid_in.rows[i];
            changeId('currSum','currSum'+row.PRODUCT_NO);
            var minStorNum = null;
            $.each(storNameJson,function(j,item){
                var stor_no = item.STORAGE_NO;
                changeId('curr'+stor_no,'curr'+stor_no+row.PRODUCT_NO);
                $.ajax({
                    type: 'post',
                    url: '/productStorage/proStorageManage/getMinStorQuantity?STORAGE_NO='+stor_no+'&PRODUCT_NO='+row.PRODUCT_NO,
                    dataType: 'json',
                    async: false,
                    success: function (result){
                        minStorNum = result;
                    }
                });
                if(minStorNum!=null && parseFloat($("#stor"+stor_no+row.PRODUCT_NO).val())<parseFloat(minStorNum)){
                    var flag = 'low';
                    var id = "stor"+stor_no+row.PRODUCT_NO;
                    document.getElementById("stor"+stor_no+row.PRODUCT_NO).style.background="#FFFF33";//黄色
                    document.getElementById("div"+stor_no+row.PRODUCT_NO).title="<spring:message code="productStorage.belowTheWarningLevel"/>"+minStorNum;
                }
                if(parseFloat($("#stor"+stor_no+row.PRODUCT_NO).val())<parseFloat(row.QUANTITY)){
                    var flag = 'lack';
                    var id = "stor"+stor_no+row.PRODUCT_NO;
                    document.getElementById("stor"+stor_no+row.PRODUCT_NO).style.background="#FF0000";//红色
                    document.getElementById("div"+stor_no+row.PRODUCT_NO).title="<spring:message code="productStorage.lackOfInventory"/>"+row.QUANTITY;
                }
            });
        }
        return false;
    }
    
    function spf_outStor(){
        var out_date = $("#OUT_DATE").val();
        if(out_date==''||out_date==null){
            $.ligerDialog.warn('<spring:message code="productStorage.pleaseSelectTheDeliveryTime"/>');
            return;
        }
        var BtnFlag = false;
        for(var i=0;i<$grid_in.rows.length;i++){
            var r = $grid_in.rows[i];
            $.each(storNameJson,function(j,item){
                var num = $("#curr"+item.STORAGE_NO+r.PRODUCT_NO).val();
                if(num!=''&&num!=null&&num!=0){
                    BtnFlag = true;
                }
            });
        }
        if(BtnFlag == true){
            $.ligerDialog.confirm('<spring:message code="productStorage.determineOutOfIt"/>?','<spring:message code="hrms.warning"/>',function (yes){
                if(yes){
                    $.ligerDialog.waitting('正在出库...');
                    var jsonData = '[';
                    var cust_no = $("#CUST_NO").val();
                    var cust_name = $("#CUST_NAME").val();
                    var sales_order_id = $("#SALES_ORDER_ID").val();
                    var mobilePhone = $("#MOBILEPHONE").val();
                    var out_marks = $("#OUT_REMARKS").val();
                    var sal_ord_no = $("#SALES_ORDER_NO").val();
                    var discount = $("#DISCOUNT").val();
                    var choose = 'remindNo';

                    for(var i=0;i<$grid_in.rows.length;i++){
                        var row = $grid_in.rows[i];
                        var pro_num = row.PRODUCT_NUM;
                        var pro_cas = row.PRODUCT_CAS;
                        if(pro_num==null){pro_num=''}
                        if(pro_cas==null){pro_cas=''}
                        $.each(storNameJson,function(j,item){
                            var currNum = $("#curr"+item.STORAGE_NO+row.PRODUCT_NO).val();
                            if(currNum!=''&&currNum!=null&&currNum!=0){
                                if (jsonData.length > 1){
                                    jsonData += ',{';
                                }else{
                                    jsonData += '{';
                                }
                                jsonData += '"STOR_NAME":"'+item.STORAGE_NAME+'",';
                                jsonData += '"PRO_NO":"'+row.PRODUCT_NO+'",';
                                jsonData += '"PRO_NAME":"'+row.PRODUCT_NAME+'",';
                                jsonData += '"CURR_OUT_NUM":"'+currNum+'",';
                                jsonData += '"SAL_ORD_NO":"'+sal_ord_no+'",';
                                jsonData += '"PRO_ID":"'+row.PRODUCT_ID+'",';
                                
                                jsonData += '"PRO_NUM":"'+pro_num+'",';
                                jsonData += '"PRO_CAS":"'+pro_cas+'",';
                                jsonData += '"SPECIFICATION":"'+MyCheckNull(row.SPECIFICATION)+'",';
                                jsonData += '"UNIT_NAME":"'+row.UNIT_NAME+'",';
                                jsonData += '"STOR_NO":"'+item.STORAGE_NO+'",';
                                jsonData += '"DISCOUNT":"'+row.DISCOUNT+'",';
                                jsonData += '"PRO_PRICE":"'+row.PRICE+'"';
                                jsonData += '}';
                            }
                        });
                    }
                    jsonData += ']';
                    $.post("/productStorage/proStorageManage/saveOutStorage",
                            [
                                {name: 'jsonData', value: jsonData},
                                {name: 'CUST_NO', value: cust_no},
                                {name: 'CUST_NAME', value: cust_name},
                                {name: 'SALES_ORDER_ID', value: sales_order_id},
                                {name: 'PHONE_NUM', value: mobilePhone},
                                {name: 'OUT_REMARKS', value: out_marks},
                                {name: 'OUT_DATE', value: out_date},
                                {name: 'DISCOUNT', value: discount},
                                {name: 'voiceRemind',value: choose}
                            ],
                            function (returnMsg){
                                $.ligerDialog.closeWaitting();
                                if (returnMsg == "Y"){
                                    $.ligerDialog.success('<spring:message code="productStorage.completionOfTheLibrary"/>','<spring:message code="hrms.warning"/>', function (){
                                        location.href="/productStorage/proStorageManage/viewProductOutStorage?MENU_CODE=prosto0105";
                                    });
                                }else{
                                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', returnMsg);
                                }
                    });
                }
            });
        }
    }
    var tab = parent.tab;
    function spf_viewHistory(){
        if (tab.isTabItemExist('prosto0108')) {
            tab.removeTabItem('prosto0108');
        }
        tab.addTabItem({
            tabid:'prosto0108',
            text:'<spring:message code="productStorage.theDatabaseRecords"/>',
            url: '/productStorage/proStorageManage/viewOutStorHistory'
        });
    }

    function chooseRemindYes(){
        var choose = $("#voiceReminder").val();
        var saleOrderNo = $("#SALES_ORDER_NO").val();
        if(choose=='remindYes'){
            $('#remindInfo').css('color','red');
            $('#remindInfo').html('对不起，你尚未开通语音提醒功能！');return;
            $.ajax({
                type: 'post',
                url: '/productStorage/proStorageManage/checkReceiverPhoneNum?saleOrderNo='+saleOrderNo,
                dataType: 'json',
                async: false,
                success: function (result){
                    if(result=='N'){
                        $('#remindInfo').css('color','red');
                        $('#remindInfo').html('提醒：系统检测出该订单未添加收货人联系方式，收货人无法收到语音提醒哦！');
                    }else{
                        $('#remindInfo').css('color','green');
                        $('#remindInfo').html('出库之后系统将语音通知电话为'+result+'的收货人做好收货准备');
                    }
                }
            });
        }else{
            $('#remindInfo').html('');
        }
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

#SalesOrder {
    margin-top: 5px;
}

#layout2 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}

.storClass {
    width: 100%;
    border: 0px;
    background: white;
    text-align: center;
    color: black;
}

#showAlt_lack,#showAlt_low {
    position: absolute;
    display: none;
    width: 120px;
    height: 25px;
}
</style>
</head>
<body style="padding: 2px">
    <div style="width: 99.8%">
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center">&nbsp;&nbsp;&nbsp;</td>
                <td width="25%" align="left" style="font-weight: bold;">&nbsp;&nbsp;&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                <td class="l-table-edit-c" width="65%"><a class="l-button"
                    style="width: 80px; height: 20px; float: right; margin-right: 10px;" onclick="spf_viewHistory()"><spring:message code="productStorage.viewHistory"/></a></td>
            </tr>
        </table>
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td class="l-table-edit-c" width="12%"></td>
                <td class="l-table-edit-c" width="87.5%"><input type="text" name="keyWord" id="keyWord" style="float: left; width: 300px; height: 25px;" class="showTips"
                    title="<spring:message code="productStorage.youCanEnterTheSales"/>" /> <a class="l-button"
                    style="width: 79px; height: 20px; float: left; margin-left: 10px;" onclick="spf_search()"><spring:message code="search"/></a></td>
            </tr>
        </table>
    </div>
    <div id="layout1">
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="productStorage.theOutboundSalesOrders"/></td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <div id="SalesOrder" style="width: 99.8%"></div>
    </div>
    <div id="layout2">
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="productStorage.detailsOfTheLibrary"/></td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td class="l-table-edit-t"><spring:message code="hrms.salesOrderCode"/></td>
                <td class="l-table-edit-c"><input type="text" name="SALES_ORDER_ID" id="SALES_ORDER_ID" disabled="disabled" /></td>
                <td class="l-table-edit-t"><spring:message code="hrms.placeOrderPerson"/></td>
                <td class="l-table-edit-c"><input type="text" name="ORDERED_PERSON" id="ORDERED_PERSON" disabled="disabled" /></td>
                <td class="l-table-edit-t"><spring:message code="hrms.customerName"/></td>
                <td class="l-table-edit-c"><input type="text" name="CUST_NAME" id="CUST_NAME" disabled="disabled" /></td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="hrms.salesMode"/></td>
                <td class="l-table-edit-c"><input type="text" name="SALES_MODE_NAME" id="SALES_MODE_NAME" disabled="disabled" /></td>
                <td class="l-table-edit-t"><spring:message code="productStorage.timeTheLibrary"/></td>
                <td class="l-table-edit-c"><input type="text" name="OUT_DATE" id="OUT_DATE"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>
                <td class="l-table-edit-t"><spring:message code="productStorage.noteTheLibrary"/></td>
                <td class="l-table-edit-c"><input type="text" name="OUT_REMARKS" id="OUT_REMARKS" /></td>
            </tr>
        </table>
        <div id="SalesOrderDetail" style="width: 99.8%"></div>
        <label id="remindInfo"></label>
        <table width="99.8%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td class="l-table-edit-c" width="10.5%"></td>
                <td class="l-table-edit-c" width="70%"><input type="hidden" id="CUST_NO" /></td>
                <td class="l-table-edit-c" width="19%"><input type="hidden" id="SALES_ORDER_NO" /></td>
            </tr>
            <tr>
                <td class="l-table-edit-t" width="10.5%">是否语音提醒收货人</td>
                <td class="l-table-edit-c" width="70%">
                    <select id="voiceReminder" style="width: 40px;height: 30px;" onchange="chooseRemindYes()">
                        <option value="remindYes">是</option>
                        <option value="remindNo" selected="selected">否</option>
                    </select>
                </td>
                <td class="l-table-edit-c" width="19%">
                    <a id="outstorehouse" class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; " 
                        onclick="spf_outStor()"><spring:message code="productStorage.confirmTheLibrary"/></a> 
                    <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; " 
                        onclick="spf_cancelOrderDetail()"><spring:message code="prostor.back"/></a>
                </td>
            </tr>
            <tr>
                <td class="l-table-edit-c" width="10.5%"></td>
                <td class="l-table-edit-c" width="70%"><input type="hidden" id="MOBILEPHONE" /></td>
                <td class="l-table-edit-c" width="19%"><input type="hidden" id="DISCOUNT" /></td>
            </tr>
        </table>
    </div>
</body>
</html>
