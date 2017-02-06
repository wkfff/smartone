<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
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
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%--<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%> --%>
<script type="text/javascript">
    var $grid1;
    var $grid2;
    var $grid3;
    var $orderStatusList;
    var orderDetail;
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm){
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm){
            return input.val();
        },
        setValue: function (input, value, editParm){
            input.val(value);
        },
        resize: function (input, width, height, editParm){
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    $(function(){
        init_login();
        $(".itemB").live("click",function(){
            var menuId = $(this).parent("ul").attr("id").substr(2,5);
            showMainRight(menuId);
        });
    });
    
    function showMainRight(menuId){
        $(".itemRight").hide();
        $("#right"+menuId).show();
    }
    
    var taoBaoDialog;
    function init_login(){
        var seller = "${sessionScope.taoBaoSeller}";
        if(seller == null||seller == ""){
            taoBaoDialog = $.ligerDialog.open({ 
                title: '登陆淘宝店铺',
                name:'winselector'+Math.random(),
                width: 500, 
                height: 350, 
                url: '/productStorage/taoBaoProManage/viewTaoBaoLogin'
            });
        }else{
            spf_getOrderStatus();
            $("#rightitem1").show();
            spf_initTaoBaoProList(1);
            $(".itemA").live("click",function(){
                spf_menuClick($(this).attr("id"));
            });
            $("#custOwner").ligerComboBox({
                onBeforeOpen: spf_selectEmp, valueFieldID: 'empId',width:150
            });
        }
    }
    
    function spf_viewTaoBaoProList(nick,sessionKey){
        window.location = "/productStorage/taoBaoProManage/viewTaoBaoProList?nick="+nick+"&sessionKey="+sessionKey;
    }
    
    function quitTaobao(){
        $.ligerDialog.waitting('退出中...');
        $.post("/productStorage/taoBaoProManage/quitTaobao", 
            function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    window.location.reload();
                }
            }
        );
    }
    
    function spf_selectEmp(){
        $.ligerDialog.open({ 
            title: '员工信息',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectEmpOK },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectEmpClear }
                    ]
        });
        return false;
    }
    
    function spf_selectEmpOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn();
        dialog.close();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#custOwner").val(data.CHINESENAME+"["+data.EMPID+"]");
        $("#custOwnerId").val(data.EMPID);
    }
    
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    
    function spf_selectEmpClear(item, dialog){
        $("#custOwner").val("");
        $("#custOwnerId").val("");
        dialog.close();
    }
    
    
    function spf_getOrderStatus(){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/taoBaoProManage/getTaoBaoStatus?parentCode=TaobaoOrderType',
            dataType : 'json',
            async: false,
            success : function(data) {
                $orderStatusList = data;
                $(data).each(function (index, row){
                    var temp = '<option value="'+row.CODE_ID+'">'+row.CODE_NAME+'</option>';
                    $("#orderStatus").append(temp);
                });
            }
        });
    }
    
    //日期格式转换
    function spf_getTimeFormat(time){
        var myDate;
        if(time == null||time == undefined||time == ""||isNaN(time)||time<0){
            myDate = new Date();
        }else{
            myDate = new Date(time);
        }
        var year = myDate.getFullYear();
        var month = myDate.getMonth();
        month = month+1;
        var day = myDate.getDate();
        
        var hour = myDate.getHours();
        var minute = myDate.getMinutes();
        var second = myDate.getSeconds();
        
        var dateString = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
        return dateString;
    }
    
    function spf_menuClick(menuId){
        /* $(".itemRight").hide();
        $("#right"+menuId).show(); */
        showSonMenu(menuId);
    }
    
    function showSonMenu(menuId){
        if($("#ul"+menuId).css("display")!="none"){
            $("#ul"+menuId).hide(200);
        }else{
            $("#ul"+menuId).show(200);
        }
    }
    
    function spf_initTaoBaoProList(status){
        $grid1 = $("#proDiv").ligerGrid({
            checkbox: true,
            columns: [
                      {display: '商家编码', name: 'outerId', width: '120',editor: { type: 'text', height: 100 },render:function(item){
                          if(item.outerId=="" || item.outerId=="-"){
                              item.outerId="-";
                              return "-";
                          }else{
                              return item.outerId;
                          }
                      }},
                      {display: '宝贝名称', name: 'title', width: '200',editor: { type: 'textarea', height: 100 }},
                      {display: '宝贝单价', name: 'price', width: '80'},
                      {display: '库存', name: 'num', width: '80',editor: { type: 'float' }},
                      {display: '类别', name: 'catName', width: '100'},
                      {display: '是否关联', name: 'relation', width: '100',render:function(item){
                              if(item.outerId!="" && item.outerId!="-"){
                                  return "<p style='color:green;'>已关联</p>";
                              }else{
                                  return "<p style='color:red;'>未关联</p>";
                              }
                          }
                      }
                  ],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            url : "/productStorage/taoBaoProManage/getTaoBaoProList?status="+status,
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            enabledSort:false
        });
    }
    
    function spf_initTaoBaoTradeList(){
        $grid2 = $("#orderDiv").ligerGrid({
            checkbox:true,
            columns: [
                {display: '订单编号', name: 'tid', width: '130'},
                {display: '总金额', name: 'totalFee', width: '70'},
                {display: '买家昵称', name: 'buyerNick', width: '120'},
                {display: '创建时间', name: 'created', width: '130', render:function(item){
                      return spf_getTimeFormat(item.created);
                    }
                },
                {display: '订单状态', name: 'status', align: 'center',width:'130',isSort: false,
                    render: function (item){
                        for (var i = 0; i < $orderStatusList.length; i++){
                            if ($orderStatusList[i]['CODE_ID'] == item.status)
                                return $orderStatusList[i]['CODE_NAME']
                        }
                        return item.status;
                    }
                },
                {display: '操作', name: '', width: '80',render:function(item){
                       
                        return '<a class="detailA" href="javascript:f_showOrderDetail(\''+item.tid+'\')">查看明细</a>';
                            /* +'&nbsp;&nbsp;<a class="detailA" href="javascript:f_sendGoods()">发货</a>'; */
                    }
                },
                {display: '导入状态', name: 'type', align: 'center',width:'80',isSort: false,
                    render: function (item){
                        if(item.type=="IN_ALREADY"){
                            return "<p style='color:green;'>已导入</p>";
                        }else{
                            return "<p style='color:red;'>未导入</p>";
                        }
                    }
                }
            ],
            usePager : false,
            rownumbers : true,
            enabledEdit: true,
            url : "/productStorage/taoBaoProManage/getTaoBaoTradeList",
            parms : [
                     {name:'start_created',value : $("#startDate").val()},
                     {name:'end_created',value : $("#endDate").val()},
                     {name:'status',value : $("#orderStatus").val()}
                 ],
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            enabledSort:false
        });
    }
    
  //查看订单详细情况
    function f_showOrderDetail(tid){
        var rows = $grid2.rows;
        var row;
        for(var i=0;i<rows.length;i++){
            if(rows[i].tid == tid){
                row = rows[i];
                break;
            }
        }
      
        showMainRight("item3");
        //var row = $grid2.getSelectedRow();
        $("#tradeTid").html(row.tid);
        $("#receiverName").html(row.receiverName);
        $("#buyerNick").html(row.buyerNick);
        $("#created").html(spf_getTimeFormat(row.created));
        $("#receiverMobile").html(row.receiverMobile);
        $("#receiverAddress").html(row.receiverState+row.receiverCity+row.receiverDistrict+row.receiverAddress);

        f_initOrderList(row);
    }
    
    var sendWindow;
    function f_sendGoods(){
        var row = $grid2.getSelectedRow();
        if(row.status == "WAIT_SELLER_SEND_GOODS"){
            sendWindow = $.ligerDialog.open({ 
                title: '发货明细',
                name:'winselector'+Math.random(),
                width: 800, 
                height: 480, 
                url: '/productStorage/taoBaoProManage/viewSendGoods?trade='+JSON.stringify(row)
            });
        }else{
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '该订单不能发货！') ; 
            return;
        }
    }
    
    function f_closeSendWindow(){
        sendWindow.close();
    }
    
    //将淘宝店铺上的宝贝添加到系统中
    function f_showDetail(did,lab){
        $("#"+did).slideDown(200);
        if(lab == 2){
            $("#d2saveButton").attr("href","javascript:f_saveCustFromOrder()");
            $("#custLabel").text("客户所属销售经理：");
        }else if(lab == 3){
            $("#d2saveButton").attr("href","javascript:f_saveOrderFromTaobao()");
            $("#custLabel").text("订单所属下单人：");
        }
    }
    
    function f_hideDetail(did){
        if(did=="detail1"){
            $("#PRODUCT_CATEGORY_ID_IN").val("");
            $("#PRODUCT_CATEGORY_ID_INtree").val("");
            $("#salesModeNo").val("");
        }else if(did=="detail2"){
            $("#custOwnerId").val("");
            $("#custOwner").val("");
            $("#salesMode2").val("");
        }
        $("#"+did).slideUp(200);
    }
    
    //同步商品至系统中
    function f_saveItemToSystem(){
        if($("#PRODUCT_CATEGORY_ID_IN").val()==""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择商品类别!') ; 
            return;
        }
        if($("#salesModeNo").val()==""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择宝贝单价对应销售方式!') ; 
            return;
        }
        var rows = $grid1.getSelectedRows();
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        var jsonData = '[' ;
        $(rows).each(function (index, row){
            if (jsonData.length > 1){
               jsonData += ',{' ;
            }
            else{
               jsonData += '{' ;
            }
            jsonData += ' "PRODUCT_NAME_IN": "' + this.title + '",';
            jsonData += ' "PRODUCT_ID_IN": "' + this.outerId + '",';
            jsonData += ' "STATUS_IN": "1",';
            jsonData += ' "PRODUCT_ID_TYPE": "2",';
            jsonData += ' "price": "' + this.price + '",';
            jsonData += ' "numIid": "' + this.numIid + '",';
            jsonData += ' "PRODUCT_CATEGORY_ID_IN": "' + $("#PRODUCT_CATEGORY_ID_IN").val() + '",';
            jsonData += ' "salesMode": "' + $("#salesModeNo").val() + '"';
            jsonData += '}' ;  
        });
        jsonData += ']';
        $.ligerDialog.waitting('保存中...');
        $.post("/productStorage/taoBaoProManage/addOrUpdateProduct", 
            [   
                { name: 'jsonData', value: jsonData }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        f_hideDetail("detail1");
                        $grid1.loadData(true);
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
    }
    
    //淘宝上商品类名为Item,固用Item表示商品
    function spf_removeItem(){
        var rows = $grid1.getSelectedRows();
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        var jsonData = '[' ;
        $(rows).each(function (index, row){
            if (jsonData.length > 1){
               jsonData += ',{' ;
            }
            else{
               jsonData += '{' ;
            }
            jsonData += ' "num_iid": "' + this.numIid + '"';
            jsonData += '}' ;  
        });
        jsonData += "]";
        
        $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    $.ligerDialog.waitting('删除中...');
                    $.post("/productStorage/taoBaoProManage/removeProFromTaoBao", 
                        [   
                            { name: 'jsonData', value: jsonData }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if(result == "Y"){
                                $.ligerDialog.success('成功移除商品','<spring:message code="hrms.warning"/>');
                                spf_initTaoBaoProList(1);
                            }else{
                                if(result == ""||rsult == null){
                                    result = "操作失败，可能是网络原因，请稍后再试!";
                                }
                                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
    }
    
    //通过订单获取客户信息并存入系统中
    function f_saveCustFromOrder(){
        if($("#custOwnerId").val() == ""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择客户所属销售经理') ; 
            return;
        }
        if($("#salesMode2").val()==""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择客户默认销售方式!') ; 
            return;
        }
        var rows = $grid2.getSelectedRows();
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        var num = 0;
        var flag = true;
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        for(var i=0;i<rows.length&&flag;i++){
            var flag2 = false;
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/taoBaoProManage/checkCustIdByTaobaoId?TAOBAO_ID='+rows[i].buyerNick,
                dataType : 'json',
                async: false,
                success : function(data) {
                    if(data=="Y"){
                        flag2 = true;
                    }
                },
                error : function() {
                    $.ligerDialog.error('操作失败，可能是网络原因，请稍后再试!');
                    flag = false;
                    return;
                }
            });
            
            if(flag2){
                var customer = {
                    //customerId : $("#CUST_ID").val(),
                    customerName : rows[i].buyerNick,
                    owner : { empId : $("#custOwnerId").val()},
                    //telePhone : $("#TELEPHONE").val(),
                    /* registerAddress : {
                        province : { codeNo : $("[name='PROVINCE']").val() } ,
                        city : { codeNo : $("[name='CITY']").val() },
                        area : { codeNo : $("[name='AREA']").val() },
                        address : $("[name='ADDRESS']").val()
                    },
                    officeAddress : {
                        province : { codeNo : $("[name='OFFICE_PROVINCE']").val() },
                        city : { codeNo : $("[name='OFFICE_CITY']").val() },
                        area : { codeNo : $("[name='OFFICE_AREA']").val() },
                        address : $("[name='OFFICE_ADDRESS']").val()
                    }, */
                    /* credit : { amount : 'CustomerLevel001' },
                    bankName : $("#BANK").val(),
                    bankCode : $("#BANK_ACCOUNT").val(), */
                    //taxPayerCode : $("#TAXPAYER_IDCODE").val(),
                    custSalesMode : {
                        codeNo : $("#salesMode2").val()
                    },
                    taobaoId : rows[i].buyerNick,
                    customerStatus : { codeNo : "CustomerStatus001"},
                    customerType : { codeNo : "CustomerType001"},
                    customerLevel : { codeNo : "CustomerLevel001"}
                };
                console.log(JSON.stringify(customer));

                $.ajax({
                    url : '/cust/custManage/addCustomer',
                    type: 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    async: false,
                    data : JSON.stringify(customer),
                    success : function(result) {
                        if (result.code == "0") {
                            flag = true;
                        } else {
                            flag = false;
                        }
                    }
                });
            }
            num++;
        }
        $.ligerDialog.closeWaitting();
        if(num == rows.length && flag){
            $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>');
            f_hideDetail("detail2");
        }else{
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '操作未正确结束!') ; 
        }
    }
    
    //将淘宝订单生成销售单存入系统中
    function f_saveOrderFromTaobao(){
        if($("#custOwnerId").val() == ""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择下单人') ; 
            return;
        }
        if($("#salesMode2").val() == ""){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择订单所属销售方式') ; 
            return;
        }
        var rows = $grid2.getSelectedRows();
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        var errorStatus = 0;
        var jsonData = '[' ;
        $(rows).each(function (index, row){
            //只有买家付款且未发货的订单可导入
            if(row.status == "WAIT_SELLER_SEND_GOODS"){
                if (jsonData.length > 1){
                    jsonData += ',{' ;
                }else{
                    jsonData += '{' ;
                }
                jsonData += ' "tid": "' + this.tid + '"';
                jsonData += '}' ;
            }else{
                errorStatus++;
            }
        });
        jsonData += "]";
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/productStorage/taoBaoProManage/saveOrderFromTaobao", 
            [   
                { name: 'jsonData', value: jsonData },
                { name: 'EMPID', value: $("#custOwnerId").val() },
                { name: 'SALES_MODE_NO', value: $("#salesMode2").val() }
            ]
            , function (list){
                $.ligerDialog.closeWaitting();
                var errorCnt = parseInt(errorStatus)+parseInt(list.length);
                if(errorCnt>0){
                    var errorMessage = "";
                    $(list).each(function (index, row){
                        errorMessage = errorMessage + "订单号:" + this.tid+"<br/>错误原因:"+this.msg+"</br></br>";
                    });
                    if(errorStatus>0){
                        errorMessage = errorMessage + "有"+errorStatus+"条订单状态不是'等待卖家发货',不可导入";
                    }
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '操作成功，但有'+errorCnt+'条订单未插入</br></br>'+errorMessage);
                }else{
                    $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>');
                    f_hideDetail("detail2");
                }
            }
        );
    }

    function f_initOrderList(row){
        //var row = $grid2.getSelectedRow();
        var orderData = {Rows:row.orders};
        $grid3 = $("#orderDetailDiv").ligerGrid({
            columns: [
                      {display: '商家编码', name: 'outerIid', width: '150'},
                      {display: '宝贝名称', name: 'title', width: '200',editor: { type: 'textarea', height: 100 }},
                      {display: '宝贝单价', name: 'price', width: '140'},
                      {display: '购买数量', name: 'num', width: '140'},
                      {display: '总价', name: 'totalFee', width: '140'}
                  ],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            data:orderData,
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            enabledSort:false
        });
    }
    
    function spf_save(){
        var rows = $grid1.getSelectedRows();
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        var jsonData = '[' ;
        $(rows).each(function (index, row){
            if (jsonData.length > 1){
                jsonData += ',{' ;
            }else{
                jsonData += '{' ;
            }
            jsonData += ' "num_iid": "' + this.numIid + '",';
            jsonData += ' "title": "' + this.title + '",';
            jsonData += ' "price": "' + this.price + '",';
            jsonData += ' "outer_id": " ' + this.outerId + '",';
            jsonData += ' "num": "' + this.num + '"';
            jsonData += '}' ;
        });
        jsonData += "]";
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/productStorage/taoBaoProManage/updateItem", 
            [
                { name: 'jsonData', value: jsonData }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if(result == "Y"){
                    $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>');
                    spf_initTaoBaoProList(1);
                }else{
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
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
    width: 1000px;
    margin: 0 auto;
    padding: 0;
    margin-top: 10px;
}
.title{
    /* background-color:#e5f4ff; */
    background-image:url("/resources/images/taobao/taobao001.gif");
    width:100%;
    height:25px;
    line-height:25px;
    text-align:right;
    /* border-bottom:1px solid #8fc2e5; */
    color:#2c8ee3;
    font-size:12px;
}
.nav{
    /* background-color:#e5f4ff; */
    width:100%;
    height:25px;
    line-height:25px;
    /* border-bottom:1px solid #8fc2e5; */
    color:#2c8ee3;
    font-weight:bold;
    font-size:15px;
}
#left{
    float:left;
    width:200px;
    height:100%;
}
#right{
    float:left;
    width:800px;
    height:100%;
}
#sellerDiv{
    width:190px;
    border:1px solid #d5e5f5;
}
#doDiv{
    width:190px;
    margin-top:5px;
    border:1px solid #d5e5f5;
}
.itemTitle{
    width:100%;
    height:25px;
    line-height:25px;
    color:#4581a9;
    font-size:14px;
    font-weight:bold;
    background-image:url("/resources/images/taobao/taobao002.gif");
}
.item{
    width:100%;
    color:#414141;
    margin-top:8px;
    font-size:12px;
    font-family:'宋体';
}
.item table{
    width:100%;
    font-size:12px;
    font-family:'宋体';
    color:#414141;
}
.itemA{
    display:block;
    line-height:25px;
    width:160px;
    margin:0 auto;
    height:25px;
    padding-left:10px;
    cursor: pointer;
}
.itemA:hover{
    background-color:#498cd0;
    color:white;
}
.itemB{
    display:block;
    line-height:25px;
    width:150px;
    margin:0 auto;
    height:25px;
    padding-left:10px;
    cursor: pointer;
}
.itemB:hover{
    background-color:#498cd0;
    color:white;
}
#logo{
    width:1000px;
    height:100px;
    margin:0 auto;
    border:1px solid #d5e5f5;
}
.itemRight{
    display:none;
}
select{
    width:150px;
    height:23px;
    border:1px solid #aecaf0;
}
.detailA{
    color:green;
}
.titleLab{
    width:100px;
    font-size:14px;
    text-align:center;
    color:#414141;
}
.contLab{
    font-size:12px;
    width:160px;
    text-align:left;
    color:#414141;
    font-family:"宋体";
}
</style>
</head>
<body style="padding: 2px">
    <div id="logo">
        <div class="title">
            <c:if test="${sessionScope.taoBaoSeller == null }">
                &nbsp;<a href="javascript:init_login()" style="color:#2c8ee3">登录</a>&nbsp;
            </c:if>
            <c:if test="${sessionScope.taoBaoSeller != null }">
                &nbsp;您好，${sessionScope.taoBaoSeller.nick }，
                <a href="javascript:quitTaobao()" style="color:#2c8ee3">退出</a>&nbsp;
            </c:if>
        </div>
        <div style="height:75px;margin-left:10px;">
            <img alt="" src="/resources/images/myimage/tianmao_cat.png" style="height:65px;margin-top:5px;"/>
            <img alt="" src="/resources/images/myimage/tianmao.png"/>
        </div>
    </div>
    <div id="layout1">
        <div id="left">
            <div id="sellerDiv">
                <div class="itemTitle">
                    &nbsp;店铺信息
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">店名</td>
                            <td valign="top">${sessionScope.taoBaoShop.title }</td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">卖家</td>
                            <td valign="top">${sessionScope.taoBaoSeller.nick }</td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">评分</td>
                            <td valign="top">${sessionScope.taoBaoShop.shopScore.deliveryScore }（发货速度）</td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">评分</td>
                            <td valign="top">${sessionScope.taoBaoShop.shopScore.itemScore }（商品描述）</td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">评分</td>
                            <td valign="top">${sessionScope.taoBaoShop.shopScore.serviceScore }（服务态度）</td>
                        </tr>
                    </table>
                </div>
                <div class="item">
                    <table>
                        <tr>
                            <td width="10">&nbsp;</td>
                            <td width="40" valign="top">描述</td>
                            <td valign="top">${sessionScope.taoBaoShop.desc }</td>
                        </tr>
                    </table>
                </div>
                <br/>
            </div>
            <div id="doDiv">
                <div class="itemTitle">
                    &nbsp;店铺管理
                </div>
                <div class="item">
                    <ul>
                        <li class="itemA" id="item1">宝贝管理</li>
                        <li>
                            <ul id="ulitem1" style="padding-left:10px;display:none;">
                                <li class="itemB" onclick="javascript:spf_initTaoBaoProList(1)">在售宝贝</li>
                                <!-- <li class="itemB" onclick="javascript:spf_initTaoBaoProList(2)">库存宝贝</li>
                                <li class="itemB" onclick="javascript:spf_initTaoBaoProList(3)">售完宝贝</li>
                                <li class="itemB" onclick="javascript:spf_initTaoBaoProList(4)">违规宝贝</li> -->
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="item">
                    <ul>
                        <li class="itemA" id="item2">淘宝交易</li>
                        <li>
                            <ul id="ulitem2" style="padding-left:10px;display:none;">
                                <li class="itemB" onclick="javascript:spf_initTaoBaoTradeList()">我的订单</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <br/>
            </div>
        </div>
        
        
        
        <div id="right">
            <div class="itemRight" id="rightitem1">
                <table width="99%" align="center">
                    <tr height="40">
                        <td>
                            <a class="l-button"
                                style="width: 79px;float:left; height: 20px;"
                                onclick="f_showDetail('detail1','1')">同步至系统</a>
                            <a class="l-button"
                                style="width: 79px;float:left;margin-left:10px; height: 20px;"
                                onclick="spf_removeItem()">删除宝贝</a>
                            <a class="l-button"
                                style="width: 79px;float:left;margin-left:10px; height: 20px;"
                                onclick="spf_save()">保存修改</a>
                        </td>
                    </tr>
                </table>
                <div id="detail1" style="width:100%;height: 30px;display: none;">
                    <table style="width:100%;font-size:12px;">
                        <tr>
                            <td width="80">&nbsp;商品类目：</td>
                            <td width="220"><SipingSoft:categoryTree name="PRODUCT_CATEGORY_ID_IN"/></td>
                            <td width="120" align="right">单价对应销售方式：</td>
                            <td>
                                <SipingSoft:selectSalesMode name="salesModeNo" limit="all"/>
                            </td>
                            <td align="right">
                                <a class="l-button"
                                    style="width: 79px; height: 20px;float:right;"
                                    onclick="f_saveItemToSystem()">保存</a>
                                <a class="l-button"
                                    style="width: 79px; height: 20px;float:right;margin-right:10px;"
                                    onclick="f_hideDetail('detail1')">取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="proDiv"></div>
            </div>
            
            <div class="itemRight" id="rightitem2">
                <table style="width:100%;font-size:12px;">
                    <tr>
                        <td width="60">开始日期:</td>
                        <td width="160">
                            <input type="text" name="startDate" id="startDate" style="width:125px;height:23px;font-size:12px;border:1px solid #d5e5f5;"
                                onclick="WdatePicker({lang:<spring:message
                                code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                readonly="readonly" value="${startDate }"/>
                        </td>
                        <td width="60">结束日期:</td>
                        <td width="160">
                            <input type="text" name="endDate" id="endDate" style="width:125px;height:23px;font-size:12px;border:1px solid #d5e5f5;"
                                onclick="WdatePicker({lang:<spring:message
                                code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                readonly="readonly" value="${endDate }"/>
                        </td>
                        <td width="60">交易状态:</td>
                        <td width="180">
                            <select id="orderStatus" style="width:150px;height:23px;border:1px solid #d5e5f5;">
                                <option value="">请选择</option>
                            </select>
                        </td>
                        <td align="right">
                            <a class="l-button"
                                style="width: 79px;height: 20px;"
                                onclick="spf_initTaoBaoTradeList()">搜索订单</a>
                        </td>
                    </tr>
                    <tr height="40">
                        <td colspan="7">
                            <a class="l-button"
                                style="width: 79px;float:left; height: 20px;"
                                onclick="f_showDetail('detail2','2')">生成客户</a>
                            <a class="l-button"
                                style="width: 79px;float:left;margin-left:10px; height: 20px;"
                                onclick="f_showDetail('detail2','3')">生成销售单</a>
                        </td>
                    </tr>
                </table>
                <div id="detail2" style="width:100%;height: 30px;display: none;">
                    <table style="width:100%;font-size:12px;">
                        <tr>
                            <td width="120"><label id="custLabel">客户所属销售经理：</label></td>
                            <td width="220">
                                <input type="hidden" id="custOwnerId"/>
                                <input type="text" id="custOwner"/>
                            </td>
                            <td><div>销售方式:</div></td>
                            <td>
                                <div><SipingSoft:selectSalesMode name="salesMode2" limit="all"/></div>
                            </td>
                            <td align="right">
                                <a id="d2saveButton" class="l-button"
                                    style="width: 79px; height: 20px;float:right;">保存</a>
                                <a class="l-button"
                                    style="width: 79px; height: 20px;float:right;margin-right:10px;"
                                    onclick="f_hideDetail('detail2')">取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="orderDiv"></div>
            </div>
            
            <div class="itemRight" id="rightitem3">
                <table style="width:100%;font-size:12px;">
                    <tr height="40">
                        <td colspan="7">
                            <a class="l-button"
                                style="width: 79px;float:left; height: 20px;"
                                onclick="showMainRight('item2')">返回</a>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr style="background-color:#F0F7FF;color:#2c8ee3;font-size:14px;">
                        <td>订单编号:</td>
                        <td colspan="5"><label id="tradeTid"></label></td>
                    </tr>
                    <tr height="30">
                        <td class="titleLab">收件人名称:</td>
                        <td class="contLab" id="receiverName"></td>
                        <td class="titleLab">买家昵称:</td>
                        <td class="contLab" id="buyerNick"></td>
                        <td class="titleLab">创建时间:</td>
                        <td class="contLab" id="created"></td>
                    </tr>
                    <tr height="30">
                        <td class="titleLab">收件人电话:</td>
                        <td class="contLab" id="receiverMobile"></td>
                        <td class="titleLab">收货人地址:</td>
                        <td class="contLab" id="receiverAddress" colspan="3"></td>
                    </tr>
                </table>
                <div id="orderDetailDiv"></div>
            </div>
            
        </div>
    </div>
</body>
</html>
