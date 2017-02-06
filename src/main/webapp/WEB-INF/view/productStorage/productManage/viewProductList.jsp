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
    var $grid;
    var proColumnsList;
    var colums;
    var columsName = "";
    
    var salesModelString = "";
    
    var inStorageString = "";
    
    var products;
    
    var flag1 = true;
    var flag2 = true;
    var storRows = "";

    $(function() {
        proColumnsList = ${proColumnsList};
        spf_initColumns(proColumnsList);
        f_initGrid(colums);
        f_getSalesModel();
        f_getStorage();

        $("input[type='radio']").click(function(){
            if($(this).val()==2){
                $("#idLabel").text('(<spring:message code="input.required"/>)');
                $("#PRODUCT_ID_IN").attr("disabled","");
            }else{
                $("#idLabel").text("");
                $("#PRODUCT_ID_IN").val("");
                $("#PRODUCT_ID_IN").attr("disabled","disabled");
            }
        });
        
        $("#showDown").mouseover(function(){
            if(flag1){
                $(this).attr("src","/resources/images/myimage/showUpOver.gif");
            }else{
                $(this).attr("src","/resources/images/myimage/showDownOver.gif");
            }
        });
        $("#showDown").mouseout(function(){
            if(flag1){
                $(this).attr("src","/resources/images/myimage/showUp.gif");
            }else{
                $(this).attr("src","/resources/images/myimage/showDown.gif");
            }
        });
        
        $("#showDown2").mouseover(function(){
            if(flag2){
                $(this).attr("src","/resources/images/myimage/showUpOver.gif");
            }else{
                $(this).attr("src","/resources/images/myimage/showDownOver.gif");
            }
        });
        $("#showDown2").mouseout(function(){
            if(flag2){
                $(this).attr("src","/resources/images/myimage/showUp.gif");
            }else{
                $(this).attr("src","/resources/images/myimage/showDown.gif");
            }
        });
        
        changeShowButton();
        changeShowButton2();
        $("#showDown").click(function(){
            if(flag1){
                $("#storageDiv").stop(true,true);
                $("#storageDiv").slideUp(400);
                $(this).attr("src","/resources/images/myimage/showDownOver.gif");
                flag1 = false;
            }else{
                $("#storageDiv").stop(true,true);
                $("#storageDiv").slideDown(400);
                $(this).attr("src","/resources/images/myimage/showUpOver.gif");
                flag1 = true;
            }
        });
        $("#showDown2").click(function(){
            if(flag2){
                $("#salesModelDiv").stop(true,true);
                $("#salesModelDiv").slideUp(400);
                $(this).attr("src","/resources/images/myimage/showDownOver.gif");
                flag2 = false;
            }else{
                $("#salesModelDiv").stop(true,true);
                $("#salesModelDiv").slideDown(400);
                $(this).attr("src","/resources/images/myimage/showUpOver.gif");
                flag2 = true;
            }
        });
    });
    function changeShowButton(){
        if(flag1){
            $("#showDown").attr("src","/resources/images/myimage/showUp.gif");
        }else{
            $("#showDown").attr("src","/resources/images/myimage/showDown.gif");
        }
    }
    function changeShowButton2(){
        if(flag2){
            $("#showDown2").attr("src","/resources/images/myimage/showUp.gif");
        }else{
            $("#showDown2").attr("src","/resources/images/myimage/showDown.gif");
        }
    }
    
    function f_getSalesModel() {
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/proBusinessManage/getSalesModelList?STATUS=1&pagesize=10&page=1',
            dataType : 'json',
            success : function(data) {
                var temp =
                    "<tr height='40'>"+
                        "<td align='right' style='font-size:14px;'><p style='float:right;'><label style='color:red;'>*</label><spring:message code="productStorage.purchasePrice"/></p>"+
                        "</td>"+
                        "<td align='left'>&nbsp;&nbsp;"+
                            "&nbsp;&nbsp;&nbsp;&nbsp;"+
                            "<input type='text' name='UNIT_PRICE_IN' id='UNIT_PRICE_IN' class='inputClass' onblur='checkNum(this.id)'/>"+
                        "</td>"+
                    "</tr>";
                $("#salesModelDiv table").append(temp);
                temp = "";
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp =
                        "<tr height='40'>"+
                            "<td align='right' style='font-size:14px;'>"+item.SALES_MODE_NAME+
                            "</td>"+
                            "<td align='left'>&nbsp;&nbsp;"+
                                "&nbsp;&nbsp;&nbsp;&nbsp;"+
                                "<input type='text' name='SALE"+item.SALES_MODE_NO+"' id='SALE"+item.SALES_MODE_NO+"' class='inputClass' onblur='checkNum(this.id)'/>"+
                            "</td>"+
                        "</tr>";
                        salesModelString = salesModelString+""
                        $("#salesModelDiv table").append(temp);
                        temp = "";
                    }
                );
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    function f_getStorage() {
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/storageManage/getStorageList',
            dataType : 'json',
            success : function(data) {
                var temp = '<tr><th><spring:message code="prostor.storage.name"/></th>'+
                               '<th><spring:message code="prostor.storeQuantity"/></th>'+
                               '<th>预警值</th>'+
                               /* '<th><spring:message code="hrms.maximum"/></th>'+ */
                               '<th><spring:message code="prostor.storeAddr"/></th></tr>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp +
                        "<tr height='40'>"+
                            "<td width='30%' align='center' style='font-size:14px;'>"+item.STORAGENAME+
                                "&nbsp;&nbsp;&nbsp;&nbsp;"+
                            "</td>"+
                            "<td width='20%' align='center' class='storageTd'>&nbsp;&nbsp;"+
                                "<input type='text' name='STOR"+item.STORAGENO+"' id='STOR"+item.STORAGENO+"' class='inputClass2' onblur='checkNum(this.id)'/>"+
                            "</td>"+
                            "<td width='20%' align='center' class='storageTd'>&nbsp;&nbsp;"+
                                "<input type='text' name='MIN"+item.STORAGENO+"' id='MIN"+item.STORAGENO+"' class='inputClass2' onblur='checkNum(this.id)'/>"+
                            "</td>"+
                            /* "<td width='14%' align='center' class='storageTd'>&nbsp;&nbsp;"+
                                "<input type='text' name='MAX"+item.STORAGENO+"' id='MAX"+item.STORAGENO+"' class='inputClass2' onblur='checkNum(this.id)'/>"+
                            "</td>"+ */
                            "<td align='center'>"+
                            "<input type='text' name='ADDR"+item.STORAGENO+"' id='ADDR"+item.STORAGENO+"' class='inputClass3'/></td>"+
                        "</tr>";
                    }
                );
                $("#storageDiv table").html(temp);
                storRows = data.Rows;
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    //初始化表标题
    function spf_initColumns(paColumns){
        colums = [];
        //columsName用于Excel导出时传的表标题，以免又从数据库读取，影响效率
        columsName = "";
        $(paColumns).each(function(index, row){
            if(row.COLUMN_NAME == "STATUS"){
                colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:80 ,
                    render : function(item) {
                        if(item.STATUS == 0){
                            return '<label style="color:red"><spring:message code="hrms.disable"/></label>';
                        }else{
                            return '<spring:message code="hrms.enable"/>';
                        }
                    }
                });
            }else if(row.COLUMN_NAME == "SHOWDETAIL"){
                colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:80 ,
                    render : function(item) {
                        return "<a class='clickA' href='javascript:spf_showProDetail()'><spring:message code='hrms.clickToView'/></a>";
                    }
                });
            }else{
                colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:120 }) ;
                columsName = columsName + "" +row.ITEM_NAME + ",";
            }
        });
    }
    
    function f_initGrid() {
        $grid = $("#searchProductList").ligerGrid({
            columns : colums,
            usePager : true,
            rownumbers : true,
            url : "/productStorage/productManage/getProductList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'500',
            enabledSort:false,
            onDblClickRow:spf_showProDetail
        });
    }
    
    var tab = parent.tab;
    function spf_showProDetail(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        if (tab.isTabItemExist('prosto0106')) {
            tab.removeTabItem('prosto0106');
        }
        tab.addTabItem({
            tabid:'prosto0106',
            text:'<spring:message code="prostor.productDetail"/>',
            url: '/productStorage/productManage/viewProductDetail?PRODUCT_NO='+row.PRODUCT_NO
        });
    }
    
    function checkNum(id){
        if($("#"+id).val()!=""){
            if(isNaN($("#"+id).val())){
                $("#"+id).css('color','red');
                return false;
            }else{
                $("#"+id).css('color','black');
                return true;
            }
        }
        return true;
    }
    
    function spf_search() {
        if(!checkNum("S_SUM")||!checkNum("E_SUM")){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="input.number"/>');
            return;
        }

        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()},
                        {name:'PRODUCT_CATEGORY_ID',value : $("#PRODUCT_CATEGORY_ID").val()},
                        {name:'STATUS',value : $("#STATUS").val()},
                        {name:'S_SUM',value : $("#S_SUM").val()},
                        {name:'E_SUM',value : $("#E_SUM").val()},
                        {name:'UNIT_CODE_ID',value : $("#UNIT_CODE_ID").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }

    function spf_clear_input(){
        $(".inputClass").val("");
        $(".inputClass2").val("");
        $(".inputClass3").val("");
        $(".typeClass").val("");
        $("#STATUS_IN").val("1");
        $("#UNIT_CODE_ID_IN").val("");
        $("#PRODUCT_ID_B").attr("disabled","");
        $("#PRODUCT_CATEGORY_ID_IN").val("");
        $("#PRODUCT_CATEGORY_ID_INtree").val("");
        $("#propertyDiv table").html("");
        $("#proDiv").hide(500);
    }
    
    function spf_update(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        //spf_add();
        spf_clear_input();
        $("#storageDetailDiv").hide();
        $("#showProductDetailDiv").show(500);
        $("#PRODUCT_NO").val(""+row.PRODUCT_NO);
        $("#PRODUCT_NAME_IN").val(""+row.PRODUCT_NAME);
        $("#PRODUCT_ID_IN").val(""+row.PRODUCT_ID);
        $("#PRODUCT_ID_IN").attr("disabled","disabled");
        $("#SPECIFICATION_IN").val(row.SPECIFICATION);
        if(row.UNIT_PRICE != null && row.UNIT_PRICE != "null"){
            $("#UNIT_PRICE_IN").val(""+row.UNIT_PRICE);
        }
        $("#STATUS_IN").val(""+row.STATUS_ID);
        $("#PRODUCT_CAS_IN").val(row.PRODUCT_CAS);
        $("#PRODUCT_NUM_IN").val(row.PRODUCT_NUM);
        
        $("#PRODUCT_CATEGORY_ID_IN").val(row.PRODUCT_CATEGORY_ID);
        $("#PRODUCT_CATEGORY_ID_INtree").val(row.PRODUCT_CATEGORY_NAME);
        
        spf_choseCategory(row.PRODUCT_CATEGORY_ID);
        
        $("#UNIT_CODE_ID_IN").val(row.UNIT_CODE_ID);
        $("#REMARK_IN").val(row.REMARK);
        
        $("#storageDiv").slideUp(400);
        $("#salesModelDiv").slideUp(400);
        flag1 = false;
        flag2 = false;
        changeShowButton();
        changeShowButton2();
        
        
        var storages = inStorageString.split(",");
        var salesModel = salesModelString.split(",");
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/productManage/getProductListUpdate?PRODUCT_NO='+row.PRODUCT_NO,
            dataType : 'json',
            async: false,
            success : function(data) {
                $.each(
                    data.storList,
                    function(i, item) {
                        $("#STOR"+item.STORAGE_NO).val(item.STOR);
                        $("#MIN"+item.STORAGE_NO).val(item.MIN_QUANTITY);
                        $("#MAX"+item.STORAGE_NO).val(item.MAX_QUANTITY);
                        $("#ADDR"+item.STORAGE_NO).val(item.STOR_ADDR);
                    }
                );
                $.each(
                    data.saleList,
                    function(i, item) {
                        $("#SALE"+item.SALES_MODE_NO).val(item.PRICE);
                    }
                );
                $.each(
                    data.p_valueList,
                    function(i, item) {
                        $("#"+item.PROPERTY_ID).val(item.P_VALUE_ID);
                    }
                );
                
                $("#radio1").attr("checked","checked");
                $("#idLabel").hide();
                $("#productTypeSpan").hide();
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
        
    }
    
    function spf_add(){
        $("#radio1").attr("checked","checked");
        $("#idLabel").show();
        $("#productTypeSpan").show();
        spf_clear_input();
        $("#storageDetailDiv").show(500);
        $("#storageDiv").slideDown(500);
        $("#salesModelDiv").slideDown(500);
        flag1 = true;
        flag2 = true;
        changeShowButton();
        changeShowButton2();
        
        $("#showProductDetailDiv").show(500);
    }
    function spf_clear(){
        spf_clear_input();
        $("#showProductDetailDiv").hide(500);
    }
    
    function f_save(){
        if($("#PRODUCT_NAME_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseFillInTheNameOfGoods"/>') ;
            return ;
        }
        if($("#PRODUCT_ID_IN").val() == ""&& $("#radio2").attr("checked")){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseFillInTheCodingOfGoods"/>') ;
            return ;
        }
        if($("#UNIT_CODE_ID_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseFillOutTheGoodsUnits"/>') ;
            return ;
        }
        if($("#STATUS_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectState"/>') ;
            return ;
        }
        if($("#PRODUCT_CATEGORY_ID_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectTheCategoryOfGoods"/>') ;
            return ;
        }
        var input = $(".inputClass2");
        for(var i=0;i<input.length;i++){
            if(!checkNum(input[i].id)){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="input.number"/>');
                return;
            }else{
                if($(input[i]).val()<0){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterAPositiveNumber"/>');
                    return;
                }
            }
        }
        if($("#UNIT_PRICE_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.atLeastOnePurchasePrice"/>') ;
            return ;
        }
        
        var input2 = $("#salesModelDiv input");
        for(var i=0;i<input2.length;i++){
            if(!checkNum(input2[i].id)){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="input.number"/>');
                return;
            }else{
                if($(input2[i]).val()<0){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterAPositiveNumber"/>');
                    return;
                }
            }
        }
        /* var storNumFlag=true;
        var minMaxFlag=true;
        $.each(storRows,function(i,item) {
            var min = $('#MIN'+item.STORAGENO).val();
            var max = $('#MAX'+item.STORAGENO).val();
            var num = $('#STOR'+item.STORAGENO).val();
            if(parseFloat(min)>parseFloat(max)){
                minMaxFlag = false;
            }
            if(parseFloat(num)>parseFloat(max)){
                storNumFlag = false;
            }
        });
        if(minMaxFlag == false){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.minimumInventory"/>！');
            return;
        }
        if(storNumFlag == false){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.inventoryLevels"/>！');
            return;
        } */
        var remark_in = $("#REMARK_IN").val().replace(/\n/g,"");
        $("#REMARK_IN").val(remark_in);
        
        if(true){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url:'/productStorage/productManage/addOrUpdateProduct',
                type:'POST',
                success: function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                        spf_add();
                        $grid.loadData(true);
                        spf_clear();
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                },
                error:function(){
                    alert("wrong");
                }
            };
            $('#form1').ajaxSubmit(options);
        }else{
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.theCommodityCodeAlreadyExists"/>');
        }
    }
    
    function spf_delete(){
        var rows = $grid.getSelectedRows(); 
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        if (rows.length > 1) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>');
            return;
        }
        $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    var jsonData = '[' ; 
                    $(rows).each(function (index, row){
                         if (jsonData.length > 1){
                            jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         }  
                         jsonData += ' "PRODUCT_NO": "' + this.PRODUCT_NO + '",';
                         jsonData += ' "PRODUCT_ID": "' + this.PRODUCT_ID + '"';
                         jsonData += '}' ;  
                    }); 
                    jsonData += ']' ;  
                    if(jsonData.length == 2){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                        return ;
                    } 
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/productStorage/productManage/deleteProduct", 
                        [   
                            { name: 'jsonData', value: jsonData }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid.loadData(true); //加载数据 
                                    spf_clear();
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
    }
    
    function spf_choseCategory(id){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/system/basicMaintenance/getPropertyList?CATEGORY_ID='+id,
            dataType : 'json',
            async: false,
            success : function(data) {
                var temp = "<tr height='40'>";
                $.each(
                    data.Rows,
                    function(i, item) {
                        if(i>0&&i%4==0){
                            temp = temp + '</tr><tr height="40">';
                        }
                        temp = temp + ""+
                                        "<td width='80' align='center' style='font-size:12px;'>"+item.PROPERTY_NAME+
                                        "</td>"+
                                        "<td align='left'>"+
                                            "<select id='"+item.PROPERTY_ID+"' name='"+item.PROPERTY_ID+"' class='propertyClass'></select>"+
                                        "</td>";
                    }
                );
                temp = temp + "</tr>";
                $("#propertyDiv table").html(temp);
                spf_initProperty();
                spf_proDiv();
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    function spf_initProperty(){
        var $property = $("#propertyDiv select");
        for(var i = 0;i<$property.length;i++){
            var pid = $property[i].id;
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/system/basicMaintenance/getPropertyValueList?PROPERTY_ID='+$property[i].id,
                dataType : 'json',
                async: false,
                success : function(data) {
                    var temp = '<option value=""><spring:message code="hrms.selection"/></option>'; 
                    $.each(
                        data.Rows,
                        function(k, item) {
                            temp = temp + '<option value="'+item.P_VALUE_ID+'">'+item.P_VALUE+'</option>';
                        }
                    );
                    $("#"+pid).html(temp);
                },
                error : function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }
    }
    
    function spf_proDiv(){
        if($("#PRODUCT_CATEGORY_ID_IN").val()!=""){
            $("#proDiv").slideDown(400);
        }else{
            $("#proDiv").slideUp(400);
        }
    }
    function spf_impExcel(){
        if (tab.isTabItemExist('prosto0112')) {
            tab.removeTabItem('prosto0112');
        }
        tab.addTabItem({
            tabid:'prosto0112',
            text:'货品导入',
            url: '/productStorage/productManage/productImport'
        });
    }
    function spf_insExcel(colums){
        location.href='/productStorage/productManage/viewProductReport?keyWord=' + $("#keyWord").val() + 
                "&UNIT_CODE_ID="+$("#UNIT_CODE_ID").val()+"&PRODUCT_CATEGORY_ID="+$("#PRODUCT_CATEGORY_ID").val()+
                "&S_SUM="+$("#S_SUM").val()+"&E_SUM="+$("#E_SUM").val()+"&STATUS="+$("#STATUS").val();
    }

    var tabTaobao = parent.tab;
    function spf_goTaobao(){
        if (tabTaobao.isTabItemExist('taobao0111')) {
            tabTaobao.removeTabItem('taobao0111');
        }
        tabTaobao.addTabItem({
            tabid:'taobao0111',
            text:'淘宝店铺',
            url: '/productStorage/taoBaoProManage/viewTaoBaoProList'
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
#showProductDetailDiv{
    display:none;
}
#searchProductList{
    margin-top:10px;
}
.divTitle{
    font-size:12px;
    line-height:23px;
    font-weight: bold;
    background-image:url('/resources/images/myimage/divTitle.gif');
    border:1px solid #A3C0E8;
}
.inputClass{
    width:150px;
    height:20px;
    border:1px solid #A3C0E8;
}
.inputClass2,.inputClass3{
    width:80%;
    height:20px;
    border:1px solid #A3C0E8;
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
select{
    width:150px;
    font-size:12px;
}
.propertyClass{
    width:100px;
}
.typeClass{
    width:60px;
    color:gray;
}
.clickA{
    text-decoration:none;
    color:green;
}
#storageDiv td{
    border-left:1px solid #c1dbfa;
    border-right:1px solid #c1dbfa;
}
#storageDiv table th{
    font-size:14px;
    text-align:center;
    background-image:url('/resources/images/myimage/divTitle.gif');
    border:1px solid #c1dbfa;
    border-top:0px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <div style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr height="24">
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="keyWord"/></div></td>
                        <td class="l-table-edit-c" width="23%">
                            <input width="120" type="text" name="keyWord" id="keyWord" class="inputClass" 
                                title="<spring:message code="productStorage.enterProductID"/>"/></td>
                        <td><div class="tableLabel"><spring:message code="hrms.unit"/></div></td>
                        <td class="l-table-edit-c" colspan="3">
                            <SipingSoft:selectProductUnit name="UNIT_CODE_ID" limit="all" />
                        </td>
                        <td width="10%"><div class="tableLabel"><spring:message code="hrms.productCategory"/></div></td>
                        <td class="l-table-edit-c" width="23%">
                            <SipingSoft:categoryTree name="PRODUCT_CATEGORY_ID"/></td>
                    </tr>
                    <tr height="24">
                        <td width="10%"><div class="tableLabel"><spring:message code="prostor.storeQuantity"/></div></td>
                        <td class="l-table-edit-c" title="<spring:message code="productStorage.searchInventoryOf"/>">
                            <input type="text" name="S_SUM" id="S_SUM" value="" size="12" onblur="checkNum(this.id)"/> ~ 
                            <input type="text" name="E_SUM" id="E_SUM" value="" size="13" onblur="checkNum(this.id)"/></td>
                        <td width="10%"><div class="tableLabel"><spring:message code="hrms.active"/></div></td>
                        <td class="l-table-edit-c" width="23%">
                            <SipingSoft:selectStatus name="STATUS" limit="all" onChange="spf_search()"/></td>
                        
                    </tr>
                </table>
            </div>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_impExcel()">
                            <spring:message code="hrms.excelImport"/>
                        </a>
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_insExcel()">
                            <spring:message code="hrms.excelExport"/>
                        </a>
                    </td>
                    <!-- <td align="right">
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_goTaobao()">
                            &nbsp;淘宝店铺
                        </a>
                    </td> -->
                </tr>
            </table>
            
            
            <div id = "showProductDetailDiv">
                
                <form name="form1" method="post" action="" id="form1">
                    <input type="hidden" id="PRODUCT_NO" name="PRODUCT_NO" class="inputClass"/>
                    <div style="width:99%;margin:0 auto;border-bottom:1px solid #A3C0E8;
                            border-left: 1px solid #A3C0E8;border-right: 1px solid #A3C0E8;">
                        <table width="100%">
                            <tr height="25">
                                <td class="divTitle" style="border-left:0px;border-right:0px;">
                                    &nbsp;&nbsp;<spring:message code="prostor.productInformation"/>
                                </td>
                            </tr>
                        </table>
                        
                        <table width="99%" align="center" cellpadding="0"
                            cellspacing="0" style="margin-top:3px;margin-bottom:3px;">
                            <tr height="24">
                                <td width="20%"><div class="tableLabel"><spring:message code="hrms.product.name"/><label style="color:red;">*</label></div></td>
                                <td width="30%" class="l-table-edit-c">
                                    <input width="120" type="text" name="PRODUCT_NAME_IN" id="PRODUCT_NAME_IN" class="inputClass"/></td>
                                <td width="20%"><div class="tableLabel"><spring:message code="hrms.productCode"/></div></td>
                                <td width="30%" class="l-table-edit-c">
                                    <input type="text" name="PRODUCT_ID_IN" id="PRODUCT_ID_IN" class="inputClass" disabled="disabled" style="background-color:white;"/>
                                    <span id="productTypeSpan">
                                    <input type="radio" name="PRODUCT_ID_TYPE" id="radio1" value="1"/><spring:message code="hrms.intern"/>&nbsp;
                                    <input type="radio" name="PRODUCT_ID_TYPE" id="radio3" value="3"/><spring:message code="hrms.productCategory"/>&nbsp;
                                    <input type="radio" name="PRODUCT_ID_TYPE" id="radio2" value="2"/><spring:message code="hrms.extern"/>
                                    <label id="idLabel" style="color:red;"></label>
                                    </span>
                                    </td>
                            </tr>
                            <tr height="24">
                                <td><div class="tableLabel"><spring:message code="hrms.specification"/></div></td>
                                <td class="l-table-edit-c">
                                    <input type="text" name="SPECIFICATION_IN" id="SPECIFICATION_IN" class="inputClass"/></td>
                                <td><div class="tableLabel"><spring:message code="hrms.active"/><label style="color:red;">*</label></div></td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:selectStatus name="STATUS_IN" selected="1"/></td>
                            </tr>
                            <tr height="24">
                                <td><div class="tableLabel"><spring:message code="hrms.unit"/><label style="color:red;">*</label></div></td>
                                <td class="l-table-edit-c" colspan="3">
                                    <SipingSoft:selectProductUnit name="UNIT_CODE_ID_IN" limit="all" />
                                </td>
                                <!-- <td><div class="tableLabel">CAS</div></td>
                                <td class="l-table-edit-c">
                                    <input type="text" name="PRODUCT_CAS_IN" id="PRODUCT_CAS_IN" class="inputClass"/></td> -->
                            </tr>
                            <%-- <tr height="24">
                                <td><div class="tableLabel"><spring:message code="hrms.productNumber"/></div></td>
                                <td class="l-table-edit-c" colspan="3">
                                    <input type="text" name="PRODUCT_NUM_IN" id="PRODUCT_NUM_IN" class="inputClass"/></td>
                            </tr> --%>
                            <tr height="48">
                                <td><div class="tableLabel" style="height:48px;line-height:46px;"><spring:message code="hrms.description"/></div></td>
                                <td colspan="3" class="l-table-edit-c">
                                    <textarea style="width:37%;height:46px;" name="REMARK_IN" id="REMARK_IN" class="inputClass"></textarea>
                                    
                            </tr>
                            <tr height="24">
                                <td><div class="tableLabel"><spring:message code="hrms.productCategory"/><label style="color:red;">*</label></div></td>
                                <td class="l-table-edit-c" colspan="3">
                                    <SipingSoft:categoryTree name="PRODUCT_CATEGORY_ID_IN"/>
                                </td >
                            </tr>
                        </table>
                    </div>
                    <div style="width:100%;margin:0 auto;margin-top:5px;">
                        <div id="proDiv" style="width:99%;margin:0 auto;display:none;">
                            <div class="divTitle" style="width:100%;">
                                <table width='100%' style="font-size:12px;line-height:23px;font-weight: bold;">
                                    <tr height="100%">
                                        <td align="left">&nbsp;&nbsp;<spring:message code="hrms.property"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div id="propertyDiv" style="border:1px solid #A3C0E8;width:100%;border-top:0px;">
                                <table width="100%"></table>
                            </div>
                        </div>
                    </div>
                    
                    <div style="width:99%;margin:0 auto;margin-top:10px;">
                        <div style="width:52%;margin-left:0px;float:left;" id="storageDetailDiv">
                            <div class="divTitle" style="width:96%;">
                                <table width='100%' style="font-size:12px;line-height:23px;font-weight: bold;">
                                    <tr height="100%">
                                        <td align="left">&nbsp;&nbsp;<spring:message code="prostor.storeInformation"/></td>
                                        <td align="right"><img id="showDown" src="/resources/images/myimage/showDown.gif" style="margin-right:5px;"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div id="storageDiv" style="border:1px solid #A3C0E8;width:96%;border-top:0px;">
                                <table width="100%"></table>
                            </div>
                        </div>
    
                        <div style="width:48%;float:left;">
                            <div class="divTitle" style="width:100%;">
                                <table width='100%' style="font-size:12px;line-height:23px;font-weight: bold;">
                                    <tr height="100%">
                                        <td align="left">&nbsp;&nbsp;<spring:message code="prostor.priceInformation"/></td>
                                        <td align="right"><img id="showDown2" src="/resources/images/myimage/showDown.gif" style="margin-right:5px;"/></td>
                                    </tr>
                                </table>
                            </div>
                            <div id="salesModelDiv" style="border:1px solid #A3C0E8;width:100%;border-top:0px;">
                                <table width='100%'>
                                </table>
                            </div>
                        </div>
                    </div>
            </form>
            <table width="99%" align="center">
                <tr>
                    <td height="30">
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right;"
                            onclick="f_save()"><spring:message code="hrms.save"/></a>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-right: 10px;"
                            onclick="spf_clear()"><spring:message code="cancel"/></a>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="searchProductList"></div>
</div>
</body>
</html>
