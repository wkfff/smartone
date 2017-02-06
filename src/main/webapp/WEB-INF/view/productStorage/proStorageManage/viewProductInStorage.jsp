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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    var $grid;
    // 初始调用
    var suppliers;
    var proColumnsList;
    // 记录行号
    var no = 0;
    var no2 = 0;
    // 记录列数（列是不确定性的，仓库可能增加或减少）
    var columns = 0;
    
    $(function() {
        
        //获取列
        proColumnsList = ${proInColumns};
        //初始化列，并增加两行
        spf_initColumns(1);
        spf_initColumns(2);
        //获取供应商列表
        initSuppliers();
        //获取仓库列表
        getInstorageList();
        //初始化有采购单采购单列表
        f_initGrid();
        //有无采购单点击事件
        $(".typeClass").click(function(){
            var dname = $("input:checked").val()+"Div";
            $("#"+dname).siblings().hide();
            $("#"+dname).show(500);
        });
        
        //点击其他地方，则商品列表清空隐藏
        $(document).click(function(e){
            var element = e.target;
            $("#showProductDiv").html();
            $("#showProductDiv").hide();
        });
        
        //换选中色加添加行事件
        $("#myEditableTable tr").live("click",function(event){
            //将兄弟行全部置为白色
            $(this).siblings().children("td").children("input,select").css("background-color","white").end().siblings().css("background-color","white");
            //将自个弄成选中青色
            $(this).children("td").children("input,select").css("background-color","#dcf8a8").end().css("background-color","#dcf8a8");
            //如果选择的是最后一行，那么添加新一行
            if($(this).index() == $(this).siblings().length){
                no++;
                /* if(no<11){ */
                    var tr = "<tr>";
                    for(var i=0;i<columns;i++){
                        //第一列显示行号
                        if(i==0){
                            tr=tr+"<td id='"+no+"'>"+no+"</td>";
                        //第二列显示ID，并且有隐藏输入框存取NO值
                        }else if(i==1){
                            tr=tr+"<td class='productId'><input type='text' class='tableInput' "+
                            " name='PRODUCT_ID"+no+"' id='PRODUCT_ID"+no+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)' onblur='spf_fill_pro(this.id)'/>"+
                            "<input type='hidden' id='PRODUCT_NO"+no+"' name='PRODUCT_NO"+no+"'/></td>";
                        //第三列显示货物品名
                        }else if(i==2){
                            tr=tr+"<td class='productName'><input type='text' class='nameInput' "+
                            " name='PRODUCT_NAME"+no+"' id='PRODUCT_NAME"+no+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)'/></td>";
                        //这几列显示各仓库入库量
                        }else if(i==6){
                            tr=tr+"<td><input type='text' class='tableInput'/></td>";
                        }else if(i>=8&&i<columns){
                            tr=tr+"<td><input type='text' class='countInput' onkeyup='sumSta("+no+")'/></td>";
                        }else{
                            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled'/></td>";
                        }
                    }
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                    tr=tr+"<td><img class='removeTr' src='/resources/images/delete.gif'/></td>";
                    tr=tr+"</tr>";
                    $("#myEditableTable").append(tr);
                /* } */
            }
            event.stopPropagation();
        });
        
        $("#myEditableTable2 tr").live("click",function(){
            //将兄弟行全部置为白色
            $(this).siblings().children("td").children("input,select").css("background-color","white").end().siblings().css("background-color","white");
            //将自个弄成选中青色
            $(this).children("td").children("input,select").css("background-color","#dcf8a8").end().css("background-color","#dcf8a8");
            //如果选择的是最后一行，那么添加新一行
            if($(this).index() == $(this).siblings().length){
                no2++;
                /* if(no2<11){ */
                    var tr = "<tr>";
                    for(var i=0;i<columns;i++){
                        //第一列显示行号
                        if(i==0){
                            tr=tr+"<td id='"+no2+"'>"+no2+"</td>";
                        //第二列显示ID，并且有隐藏输入框存取NO值
                        }else if(i==1){
                            tr=tr+"<td class='productId'><input type='text' class='tableInput' "+
                            " name='PRODUCT_ID2"+no2+"' id='PRODUCT_ID2"+no2+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)' onblur='spf_fill_pro(this.id)'/>"+
                            "<input type='hidden' id='PRODUCT_NO2"+no2+"' name='PRODUCT_NO2"+no2+"'/></td>";
                        //第三列显示货物品名
                        }else if(i==2){
                            tr=tr+"<td class='productName'><input type='text' class='nameInput' "+
                            " name='PRODUCT_NAME2"+no2+"' id='PRODUCT_NAME2"+no2+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)'/></td>";
                        //这几列显示各仓库入库量
                        }else if(i==6){
                            tr=tr+"<td><input type='text' class='tableInput'/></td>";
                        }else if(i>=8&&i<columns){
                            tr=tr+"<td><input type='text' class='countInput' onkeyup='sumSta2("+no2+")'/></td>";
                        }else{
                            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled'/></td>";
                        }
                    }
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                    tr=tr+"<td><img class='removeTr' src='/resources/images/delete.gif'/></td>";
                    tr=tr+"</tr>";
                    $("#myEditableTable2").append(tr);
                /* } */
            }
        });
        
        //选择模糊查询下拉框商品后
        $(".proItemDiv").live("click",function(){
            var inputId = $(this).attr("title");
            var comments = $(this).text().split("~");
            var inputId = $(this).attr("title");
            var preName = inputId.substring(0,12);
            
            var id = inputId;
            
            if(preName == "PRODUCT_NAME"){
                //将截取的内容的货物编码赋值
                $("#"+inputId).parent().prev().children("input").val(comments[1]);
                id = $("#"+inputId).parent().prev().children("input").attr("id");
            }else{
                //将截取的内容的货物编码赋值
                $("#"+inputId).val(comments[0]);
            }
            
            //alert(id);
            spf_fill_pro(id);
        });
        
        $(".removeTr").live("click",function(event){
            if($(this).parent().parent().siblings().length>2){
                $(this).parent().parent().remove();
            }else{
                $(this).parent().parent().find("input").val("");
            }
            event.stopPropagation();
        });
        $("#YESDiv").hide();
    });
    
    //查询供货商（初始化，若有采购单，则会查询该采购单下的供货商而已）
    function initSuppliers(){
        var suppliers = ${supplierList};
        var option;
        $(suppliers).each(function(index, row){
            option = "<option value='"+row.SUPPLIER_NO+"'>"+row.SUPPLIER_NAME+"</option>";
            $("#SUPPLIER").append(option);
        });
    }
    //查询供货商2-有采购单界面下-查询该采购单下的供货商
    function initSuppliers2(orderId){
        $.ajax({
            type:'post',
            cache : false,
            async : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/getSupplierList?PURCHASE_ORDER_ID='+orderId,
            dataType : 'json',
            success : function(data) {
                var temp = '<option value=""><spring:message code="hrms.selection"/></option>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp + "<option value='"+item.SUPPLIER_NO+"'>"+item.SUPPLIER_NAME+"</option>";
                    }
                );
                $("#SUPPLIER2").html(temp);
                if($("#choseInsList2").val()!=""){
                    //alert($("#choseInsList2 option:selected").attr("title"));
                    $("#SUPPLIER2").val($("#choseInsList2 option:selected").attr("title"));
                    show_hide_editTable2();
                }
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    //初始化表标题
    function spf_initColumns(param){
        var header = "<tr id='header'>";
        var header2 = "";
        columns = 0;
        $(proColumnsList).each(function(index, row){
            if(columns == 0){
                header = header+"<th width='50' style='text-align:center;'>"+row.ITEM_NAME+"</th>";
            }else{
                header = header+"<th class='headerTh'>"+row.ITEM_NAME+"</th>";
            }
            columns++;
        });
        header2 = header;
        header = header+"<th class='headerTh'><spring:message code="productStorage.realStorage"/></th>";
        header = header+"<th class='headerTh' width='30'></th>";
        header = header + "</tr>";
        if(param == 1){
            $("#myEditableTable").append(header);
            spf_initTableTwo1();
        }
        
        header2 = header2+"<th class='headerTh'><spring:message code="productStorage.shouldBePutInStorage"/></th>";
        header2 = header2+"<th class='headerTh'><spring:message code="productStorage.realStorage"/></th>";
        header2 = header2+"<th class='headerTh'><spring:message code="productStorage.hasStorage"/></th>";
        header2 = header2+"<th class='headerTh' width='30'></th>";
        if(param == 2){
            $("#myEditableTable2").append(header2);
            spf_initTableTwo2();
        }
        
    }
    
    //初始化无采购单两行
    function spf_initTableTwo1(){
        //初始化两行
        for(var j=0;j<2;j++){
            no++;
            var tr = "<tr>";
            for(var i=0;i<columns;i++){
                //第一列显示行号
                if(i==0){
                    tr=tr+"<td id='"+no+"'>"+no+"</td>";
                //第二列显示ID，并且有隐藏输入框存取NO值
                }else if(i==1){
                    tr=tr+"<td class='productId'><input type='text' class='tableInput' "+
                    " name='PRODUCT_ID"+no+"' id='PRODUCT_ID"+no+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)' onblur='spf_fill_pro(this.id)'/>"+
                    "<input type='hidden' id='PRODUCT_NO"+no+"' name='PRODUCT_NO"+no+"'/></td>";
                //第三列显示货物品名
                }else if(i==2){
                    tr=tr+"<td class='productName'><input type='text' class='nameInput' "+
                    " name='PRODUCT_NAME"+no+"' id='PRODUCT_NAME"+no+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)'/></td>";
                //这几列显示各仓库入库量
                }else if(i==6){
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                }else if(i>=8&&i<columns){
                    tr=tr+"<td><input type='text' class='countInput' onkeyup='sumSta("+no+")'/></td>";
                }else{
                    tr=tr+"<td><input type='text' class='tableInput' disabled='disabled'/></td>";
                }
            }
            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled' style='background-color:white;color:black;'/></td>";
            tr=tr+"<td><img class='removeTr' src='/resources/images/delete.gif'/></td>";
            tr=tr+"</tr>";
            $("#myEditableTable").append(tr);
        }
    }
    //初始化有采购单两行
    function spf_initTableTwo2(){
        //初始化两行
        for(var j=0;j<2;j++){
            no2++;
            var tr = "<tr>";
            for(var i=0;i<columns;i++){
                //第一列显示行号
                if(i==0){
                    tr=tr+"<td id='"+no2+"'>"+no2+"</td>";
                //第二列显示ID，并且有隐藏输入框存取NO值
                }else if(i==1){
                    tr=tr+"<td class='productId'><input type='text' class='tableInput' "+
                    " name='PRODUCT_ID2"+no2+"' id='PRODUCT_ID2"+no2+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)' onblur='spf_fill_pro(this.id)'/>"+
                    "<input type='hidden' id='PRODUCT_NO2"+no2+"' name='PRODUCT_NO2"+no2+"'/></td>";
                //第三列显示货物品名
                }else if(i==2){
                    tr=tr+"<td class='productName'><input type='text' class='nameInput' "+
                    " name='PRODUCT_NAME2"+no2+"' id='PRODUCT_NAME2"+no2+"' onclick='getProductSymple(this.id)' onkeyup='getProductSymple(this.id)'/></td>";
                //这几列显示各仓库入库量
                }else if(i==6){
                    tr=tr+"<td><input type='text' class='tableInput'/></td>";
                }else if(i>=8&&i<columns){
                    tr=tr+"<td><input type='text' class='countInput' onkeyup='sumSta2("+no2+")'/></td>";
                }else{
                    tr=tr+"<td><input type='text' class='tableInput' disabled='disabled'/></td>";
                }
            }
            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled' style='background-color:white;color:black;'/></td>";
            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled' style='background-color:white;color:black;'/></td>";
            tr=tr+"<td><input type='text' class='tableInput' disabled='disabled' style='background-color:white;color:black;'/></td>";
            tr=tr+"<td><img class='removeTr' src='/resources/images/delete.gif'/></td>";
            tr=tr+"</tr>";
            $("#myEditableTable2").append(tr);
        }
    }
    
    //填充商品信息
    function spf_fill_pro(id){
        if($("#"+id).val()!=""){
            var display = $("#YESDiv").css("display");  //判断是有采购单还是无采购单界面
            var flag = false;
            var $proItem = $(".proItemDiv");
            for(var i=0;i<$proItem.length && !flag;i++){
                if($("#"+id).val()==$($proItem[i]).attr("value")){
                    flag = true;
                }
            }
            if(flag){
                var supplier_no = "";
                var pid = "";
                if(display != "none"){
                    supplier_no = $("#SUPPLIER2").val();
                    pid = $("#PURCHASE_ORDER_ID").val();
                }
                $.ajax({
                    type:'post',
                    cache : false,
                    contentType : 'application/json',
                    url : '/productStorage/proStorageManage/getProductByOrder?PRODUCT_ID='+$("#"+id).val()+"&SUPPLIER_NO="+supplier_no+"&PURCHASE_ORDER_ID="+pid,
                    dataType : 'json',
                    success : function(data) {
                        $.each(
                            data.product,
                            function(i, item) {
                                if(i==0){
                                    var $td = $("#"+id).parent().siblings();
                                    $("#"+id).siblings().val(item.PRODUCT_NO);
                                    $($td[1]).children("input").val(item.PRODUCT_NAME);
                                    $($td[2]).children("input").val(item.SPECIFICATION);
                                    $($td[3]).children("input").val(item.PRODUCT_CATEGORY_NAME);
                                    $($td[4]).children("input").val(item.UNIT_CODE);
                                    $($td[4]).attr("value",item.UNIT_CODE_ID);
                                    $($td[5]).children("input").val(item.UNIT_PRICE);
                                    $($td[6]).children("input").val(item.UNIT_PRICE);
                                    if(display != "none"){
                                        $($td[columns-1]).children("input").val(item.QUANTITY);
                                        $($td[columns+1]).children("input").val(item.INQUANTITY);
                                    }
                                }else{
                                    return;
                                }
                            }
                        );
                    },
                    error : function() {
                        $.ligerDialog.error('Send Error');
                    }
                });
            }
        }else{
            var $td = $("#"+id).parent().siblings();
            $("#"+id).siblings().val("");
            $($td[1]).children("input").val("");
            $($td[2]).children("input").val("");
            $($td[3]).children("input").val("");
            $($td[4]).children("input").val("");
            $($td[4]).attr("value","");
            $($td[5]).children("input").val("");
            if(display != "none"){
                $($td[columns-1]).children("input").val("");
                $($td[columns+1]).children("input").val("");
            }
        }
    }
    //清空表单
    function initTable(param){
        if(param == 1){
            no = 0;
            $("#myEditableTable").html("");
            spf_initColumns(1);
        }else{
            no2 = 0;
            $("#myEditableTable2").html("");
            spf_initColumns(2);
        }
    }
    
    function spf_clear(param){
        $.ligerDialog.confirm('<spring:message code="productStorage.thisOperationWillClearAll"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    initTable(param);
                }
            }
        );
    }
    
    //计算无采购单实入库
    function sumSta(num){
        var sum = 0;
        var $input = $("#myEditableTable tr:eq("+num+") input[class='countInput']");
        for(var i=0;i<$input.length;i++){
            if($input[i].value!=""){
                if(isNaN($input[i].value)||$input[i].value<0){
                    $($input[i]).css("color","red");
                }else{
                    $($input[i]).css("color","black");
                    sum += parseFloat($input[i].value);
                }
            }
        }
        $("#myEditableTable tr:eq("+num+") td:eq("+(columns)+") input").val(sum);
    }
    //计算有采购单实入库
    function sumSta2(num){
        var sum = 0;
        var $input = $("#myEditableTable2 tr:eq("+num+") input[class='countInput']");
        for(var i=0;i<$input.length;i++){
            if($input[i].value!=""){
                if(isNaN($input[i].value)){
                    $($input[i]).css("color","red");
                }else{
                    $($input[i]).css("color","black");
                    sum += parseFloat($input[i].value);
                }
            }
        }
        $("#myEditableTable2 tr:eq("+num+") td:eq("+(columns+1)+") input").val(sum);
    }
    //动态查询商品数据库
    function getProductSymple(id){
        var inputClass = $("#"+id).attr("class");
        var firstParam = "";
        if(inputClass == "nameInput"){
            firstParam = 'PRODUCT_NAME_LIKE='+$('#'+id).val();
        }else{
            firstParam = 'PRODUCT_ID_LIKE='+$('#'+id).val();
        }
        
        $("#showProductDiv").html();
        //此处需判断是哪个节目，有采购单无需传供货商和采购单
        var supplier_no;
        var purchase_order_id;
        if($("#YESDiv").css("display")!="none"){
            supplier_no = $("#SUPPLIER2").val();
            purchase_order_id = $("#PURCHASE_ORDER_ID").val();
        }else{
            supplier_no = "";
            purchase_order_id = "";
        }
        if(true){
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/proStorageManage/getProductSymple?'+firstParam+"&SUPPLIER_NO="+supplier_no
                        +"&PURCHASE_ORDER_ID="+purchase_order_id,
                dataType : 'json',
                success : function(data) {
                    var temp = "<table width='100%'>";
                    if(inputClass == "nameInput"){
                        $.each(
                            data.productList,
                            function(i, item) {
                                temp = temp+"<tr><td title='"+id+"' "+
                                " class='proItemDiv' value='"+item.PRODUCT_ID+"'>"+item.PRODUCT_NAME+"~"+item.PRODUCT_ID+"</td></tr>";
                            }
                        );
                    }else{
                        $.each(
                            data.productList,
                            function(i, item) {
                                temp = temp+"<tr><td title='"+id+"' "+
                                " class='proItemDiv' value='"+item.PRODUCT_ID+"'>"+item.PRODUCT_ID+"~"+item.PRODUCT_NAME+"</td></tr>";
                            }
                        );
                    }
                    
                    temp = temp +"</table>";
                    $("#showProductDiv").html(temp);
                    $("#showProductDiv").css({
                                                "left":$("#"+id).offset().left+"px",
                                                "top":$("#"+id).offset().top+$("#"+id).height()+"px"});
                    $("#showProductDiv").show();
                },
                error : function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }
    }

    //获取正在处理中的入库单
    function getInstorageList(){
        $("#choseInsList").html("");
        $("#choseInsList2").html("");
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/getInstorageList',
            dataType : 'json',
            success : function(data) {
                var temp = '<option value="">--<spring:message code="prostor.ProcessingStorlists"/>--</option>';
                $("#choseInsList").append(temp);
                $("#choseInsList2").append(temp);
                $.each(
                    data.inStorageList,
                    function(i, item) {
                        temp = "<option in_date='"+item.IN_DATE+"' title='"+item.SUPPLIER_NO+"' value='"+item.INSTORAGE_ID+"' poid='"+item.PURCHASE_ORDER_ID+"'>"+item.INSTORAGE_ID+"</option>";
                        if(item.PURCHASE_ORDER_ID == "null"){
                            $("#choseInsList").append(temp);
                        }else{
                            $("#choseInsList2").append(temp);
                        }
                        temp = "";
                    }
                );
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    //选中未处理的入库单后
    /* function spf_choseInList(type){
        var myDate = new Date();
        var year = myDate.getFullYear();
        var month = myDate.getMonth();
        month = month+1;
        var day = myDate.getDate();
        
        var hour = myDate.getHours();
        var minute = myDate.getMinutes();
        var second = myDate.getSeconds();
        
        var dateString = year+"-"+month+"-"+day+" "+hour+":"+minute+":"+second;
        if(type == 1){

            $("#INSTORAGE_ID").val($("#choseInsList").val());
            $("#SUPPLIER").val($("#choseInsList option:selected").attr("title"));
            
            if($("#choseInsList").val()==""){
                $("#IN_DATE").val(dateString)
                $("#SUPPLIER").attr("disabled","");
            }else{
                $("#IN_DATE").val($("#choseInsList option:selected").attr("in_date"))
                $("#SUPPLIER").attr("disabled","disabled");
            }
        }else{
            $("#INSTORAGE_ID2").val($("#choseInsList2").val());
            
            
            $("#PURCHASE_ORDER_ID").val($("#choseInsList2 option:selected").attr("poid"));
            spf_clearWaitingInStorage();
            
            if($("#choseInsList2").val()==""){
                $("#IN_DATE2").val(dateString);
                $("#SUPPLIER2").attr("disabled","");
                $("#SUPPLIER2").html('<option value=""><spring:message code="hrms.selection"/></option>');
                show_hide_editTable2();
            }else{
                $("#IN_DATE2").val($("#choseInsList2 option:selected").attr("in_date"));
                spf_getWaitingInStorage($("#choseInsList2 option:selected").attr("poid"));
                initSuppliers2($("#PURCHASE_ORDER_ID").val());
                $("#SUPPLIER2").attr("disabled","disabled");
                $("#SUPPLIER2").val($("#choseInsList2 option:selected").attr("title"));
                //$("#myEditableTable2").parent("div").show(500);
            }
            
            hide_down(0);
            spf_showOrHideOrder($("#PURCHASE_ORDER_ID").val());
            $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
            //show_hide_editTable2();
            show_hide_purchaseLabel();
            initTable(2);
        }
    } */
    
    function spf_clickChoseInList(type){
        var button = [];
        if(type == 2){
            button.push({ text: '<spring:message code="okay"/>', onclick: spf_initSelectInStor });
            button.push({ text: '<spring:message code="clear"/>', onclick: spf_selectClear });
            button.push({ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel });
        }else{
            button.push({ text: '<spring:message code="okay"/>', onclick: spf_initSelectInStorPurchase });
            button.push({ text: '<spring:message code="clear"/>', onclick: spf_selectClearPurchase });
            button.push({ text: '<spring:message code="cancel"/>', onclick: spf_selectCancelPurchase });
        }
        $.ligerDialog.open({ 
            title: '<spring:message code="productStorage.processingReceipt"/>',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/productStorage/proStorageManage/viewInStoring?IS_PURCHASE='+type, 
            buttons: button
        });
    }
    function spf_initSelectInStor(item, dialog){
        var fn = dialog.frame.spf_selectInStor || dialog.frame.window.spf_selectInStor; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#INSTORAGE_ID").val(data.INSTORAGE_ID);
        $("#SUPPLIER").val(data.SUPPLIER_NO);
        
        $("#IN_DATE").val(data.IN_DATE);
        $("#SUPPLIER").attr("disabled","disabled");

        spf_showInstorProDetail(data.INSTORAGE_ID);
        dialog.close();
        
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#INSTORAGE_ID").val("");
        $("#SUPPLIER").val("");

        $("#IN_DATE").val(spf_getNowTime())
        $("#SUPPLIER").attr("disabled","");
        
        $("#showInstorDetail1 table").html("");
        dialog.close();
    }
    
    
    
    function spf_initSelectInStorPurchase(item, dialog){
        var fn = dialog.frame.spf_selectInStor || dialog.frame.window.spf_selectInStor; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#INSTORAGE_ID2").val(data.INSTORAGE_ID);
        
        
        $("#PURCHASE_ORDER_ID").val(data.PURCHASE_ORDER_ID);
        spf_clearWaitingInStorage();
        

            $("#IN_DATE2").val(data.IN_DATE);
            spf_getWaitingInStorage(data.PURCHASE_ORDER_ID);
            initSuppliers2(data.PURCHASE_ORDER_ID);

            $("#SUPPLIER2").val(data.SUPPLIER_NO);
            $("#SUPPLIER2").attr("disabled","disabled");
            //$("#myEditableTable2").parent("div").show(500);

        
        hide_down(0);
        spf_showOrHideOrder($("#PURCHASE_ORDER_ID").val());
        $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
        show_hide_editTable2();
        show_hide_purchaseLabel();
        initTable(2);

        spf_showInstorProDetail2(data.INSTORAGE_ID);
        dialog.close();
    }
    function spf_selectCancelPurchase(item, dialog){
        dialog.close();
    }
    function spf_selectClearPurchase(item, dialog){
        $("#INSTORAGE_ID2").val("");
        
        
        $("#PURCHASE_ORDER_ID").val("");
        spf_clearWaitingInStorage();
        
            $("#IN_DATE2").val(spf_getNowTime());
            $("#SUPPLIER2").attr("disabled","");
            $("#SUPPLIER2").html('<option value=""><spring:message code="hrms.selection"/></option>');
            show_hide_editTable2();
        
        hide_down(0);
        spf_showOrHideOrder($("#PURCHASE_ORDER_ID").val());
        $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
        //show_hide_editTable2();
        show_hide_purchaseLabel();
        initTable(2);
        $("#showInstorDetail2 table").html("");
        dialog.close();
    }
    
    
    
    //获取当前时间
    function spf_getNowTime(){
        var myDate = new Date();
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
    
    //具体实现无采购单输入框清空
    function supplier_clear(){
        $("#INSTORAGE_ID").val("");
        $("#SUPPLIER").val("");
        $("#SUPPLIER").attr("disabled","");
        $("#IN_DATE").val("");
    }
    //保存入库
    function f_save(status){
        var display = $("#YESDiv").css("display");  //判断是有采购单还是无采购单界面
        var $tr;                                    //所有行集合
        var pid = "";                               //货品ID前缀
        var spid = "";                              //供货商ID
        var in_date = "";                           //入库时间
        var stoid = "";                             //入库流水号，可为空
        var flag = true;
        var flag2 = true;
        var sum = 0;
        if(display == "none"){
            if($("#SUPPLIER").val() == ""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectSuppliers"/>') ;
                return ;
            }
            if($("#IN_DATE").val() == ""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectTheStorageDate"/>') ;
                return ;
            }
            $tr = $("#myEditableTable tr");
            pid = "#PRODUCT_NO";
            spid = "#SUPPLIER";
            in_date = "#IN_DATE";
            stoid = "#INSTORAGE_ID";
        }else{
            if($("#SUPPLIER2").val() == ""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectSuppliers"/>') ;
                return ;
            }
            if($("#IN_DATE2").val() == ""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseSelectTheStorageDate"/>') ;
                return ;
            }
            $tr = $("#myEditableTable2 tr");
            pid = "#PRODUCT_NO2";
            spid = "#SUPPLIER2";
            in_date = "#IN_DATE2";
            stoid = "#INSTORAGE_ID2";
        }
        
        //获取仓库数目
        var length = proColumnsList.length;
        var l = length-7;

        var purchase = "";
        $.ligerDialog.confirm('<spring:message code="productStorage.areYouSureYouWantToPutInStorage"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    var conti = true;
                    var jsonData = '[' ; 
                    for(var i=1;i<$tr.length && conti;i++){
                        //判断货品ID是否为空
                        if($(pid+""+i).val()!=""){
                            if (jsonData.length > 1){
                                jsonData += ',{' ;
                            }else{
                                jsonData += '{' ;
                            }
                                
                            jsonData += ' "PRODUCT_NO": "' + $(pid+""+i).val() + '"';
                            for(var c=0;c<l && conti;c++){
                                if(isNaN($($tr[i]).children("td:eq("+(c+7)+")").children("input").val()) || $($tr[i]).children("td:eq("+(c+7)+")").children("input").val()<0){
                                    flag = false;
                                    conti = false;
                                }else{
                                    jsonData += ',"'+proColumnsList[c+7].COLUMN_NAME+'": "' + $($tr[i]).children("td:eq("+(c+7)+")").children("input").val() + '"';
                                }
                            }
                            jsonData += ',"QUANTITY_UNIT_CODE": "' + $($tr[i]).children("td:eq(5)").attr("value") + '"';
                            jsonData += ',"UNIT_PRICE": "' + $($tr[i]).children("td:eq(6)").children("input").val() + '"';
                            jsonData += '}';
                            
                            if(display != "none" && $($tr[i]).children("td:eq("+(length+1)+")").children("input").val()
                                    >($($tr[i]).children("td:eq("+(length)+")").children("input").val()-$($tr[i]).children("td:eq("+(length+2)+")").children("input").val())){
                                conti = false;
                                flag2 = false;
                            }
                        }
                        if(display == "none"){
                            if($($tr[i]).children("td:eq("+(length)+")").children("input").val()!=""){
                                sum += parseInt($($tr[i]).children("td:eq("+(length)+")").children("input").val());
                            }
                        }else{
                            if($($tr[i]).children("td:eq("+(length)+")").children("input").val()!=""){
                                sum += parseInt($($tr[i]).children("td:eq("+(length+1)+")").children("input").val());
                            }
                        }
                    }
                    jsonData += ']' ;
                    if(display == "none"){
                        if(jsonData.length == 2&&$("#INSTORAGE_ID").val()==""){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                            return ;
                        }
                        purchase = "";
                    }else{
                        if(jsonData.length == 2&&$("#INSTORAGE_ID2").val()==""){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                            return ;
                        }
                        purchase = $("#PURCHASE_ORDER_ID").val();
                    }
                    if(!flag){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterTheCorrectNumberOfStorage"/>') ;
                        return ;
                    }
                    if(!flag2){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.theNumberOf"/>') ;
                        return ;
                    }
                    //alert(sum);
                    if(sum<=0||isNaN(sum)){
                        if(display == "none" && $("#INSTORAGE_ID").val()==""){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterTheCorrectNumberOfStorage"/>') ;
                            return ;
                        }else if(display != "none" && $("#INSTORAGE_ID2").val()==""){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="productStorage.pleaseEnterTheCorrectNumberOfStorage"/>') ;
                            return ;
                        }
                    }
                    $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                    $.post("/productStorage/proStorageManage/productInStore", 
                        [
                            { name: 'jsonData', value: jsonData },
                            { name: 'SUPPLIER_NO', value: $(spid).val()},
                            { name: 'STATUS', value: status},
                            { name: 'IN_DATE', value: $(in_date).val()},
                            { name: 'INSTORAGE_ID', value: $(stoid).val()},
                            { name: 'PURCHASE_ORDER_ID', value: purchase}
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    getInstorageList(); //加载数据 
                                    $("#INSTORAGE_ID2").val("");
                                    $("#SUPPLIER2").attr("disabled","");
                                    if(display == "none"){
                                        supplier_clear();
                                        initTable(1);
                                        $("#showInstorDetail1 table").html("");
                                    }else{
                                        initTable(2);
                                        spf_getWaitingInStorage($("#PURCHASE_ORDER_ID").val());
                                        $("#showInstorDetail2 table").html("");
                                        //initSuppliers2($("#PURCHASE_ORDER_ID").val());
                                    }
                                    $grid.loadData(true);
                                    hide_down(0);
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
    //初始化采购单列表
    function f_initGrid() {
        $grid = $("#showPurchaseOrder").ligerGrid({
            columns : [ 
                        {display : '',name : 'PURCHASE_ORDER_NO',width : '',hide:true,frozen:true},
                        {display : '<spring:message code="hrms.serialNumber"/>',name : 'PURCHASE_ORDER_ID',width : '15%',frozen:true},
                        {display : '<spring:message code="hrms.purchaser"/>',name : 'ENAME',width : '20%',frozen:true},
                        {display : '<spring:message code="hrms.purchaseDate"/>',name : 'PURCHASE_DATE',width : '20%',frozen:true},
                        {display : '',name : 'IN_COUNT',width : '0',hide:1,frozen:true},
                        {display : '<spring:message code="hrms.detailedInformation"/>',name : 'TRANSPORT_MODE',width : '10%',frozen:true,
                            render : function(item) {
                                return "<a href='javascript:spf_showPurchaseOrderDetail("+item.PURCHASE_ORDER_NO+")' style='color:green;text-decoration:none;'><spring:message code='hrms.clickToView'/></a>";
                            }   
                        }
                ],
            usePager : true,
            rownumbers : true,
            url : "/productStorage/proStorageManage/getPurchaseOrderList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99%',
            height:'300',
            onDblClickRow:spf_chosePurchaseList,
            rowAttrRender: function (rowdata){
                if (rowdata.IN_COUNT > 0){
                    //alert(rowdata.IN_COUNT);
                    return "style='color:#e67f06;'";
                }else{
                    return "style='color:black;'";
                }
            }
        });
    }
    //搜索条件
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    //双击采购单后事件
    function spf_chosePurchaseList(){
        var row = $grid.getSelectedRow();
        $("#PURCHASE_ORDER_ID").val(row.PURCHASE_ORDER_ID);
        //$("#IN_DATE2").val(${IN_DATE});
        initSuppliers2(row.PURCHASE_ORDER_ID);
        spf_showOrHideOrder();
        show_hide_purchaseLabel();
        spf_getWaitingInStorage(row.PURCHASE_ORDER_ID);
    }
    //点击采购单后，查询出该采购单待入库情况
    function spf_getWaitingInStorage(pid){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/getWaitingInStorage?pid='+pid,
            dataType : 'json',
            success : function(data) {
                $("#waitingTable").html("");
                if(data.sum>0){
                    $("#sumWaiting").html("<label style='color:red;'>"+data.sum+"</label>");
                }else{
                    $("#sumWaiting").html("<label style='color:green;'>"+data.sum+"</label>");
                }
                
                var temp = '<tr height="25"><td align="left" width="60"><spring:message code="prostor.purchaseOrderId"/>:</td><td colspan="3">&nbsp;'+$("#PURCHASE_ORDER_ID").val()+'</td></tr>';
                $("#waitingTable").append(temp);

                $.each(
                    data.supplierList,
                    function(i, sup) {
                        temp = '<tr style="border-top:1px solid #a3c0e8;" height="30"><td align="left"><spring:message code="hrms.supplier"/>:</td><td colspan="3">&nbsp;'+sup.SUPPLIER_NAME+'</td></tr>';
                        $("#waitingTable").append(temp);
                        $.each(
                            data.productList,
                            function(i, pro) {
                                if(pro.SUPPLIER_NO == sup.SUPPLIER_NO){
                                    temp = '<tr>'+
                                                '<td></td>'+
                                                '<td width="100">'+pro.PRODUCT_ID+'</td>'+
                                                '<td width="140">'+pro.PRODUCT_NAME+'</td>'+
                                                '<td>'+pro.QUANTITY+pro.CODE_NAME+'</td>'+
                                            '</tr>';
                                    
                                    $("#waitingTable").append(temp);
                                }
                            }
                        );
                        temp = '<tr height="15"><td colspan="4"></td></tr>';
                        $("#waitingTable").append(temp);
                    }
                ); 
            },
            error : function() {
                $.ligerDialog.error('Send Error2');
            }
        });
    }
    //清空未入库数据
    function spf_clearWaitingInStorage(){
        $("#sumWaiting").html("<label style='color:green;'>0</label>");
        $("#waitingTable").html("");
    }
    //判断显示或隐藏采购单列表-选择采购单后输入DIV
    function spf_showOrHideOrder(){
        $("#showPurchaseOrder").hide();
        $("#showTable2Div").show(500);
    }
    //点击返回至采购单
    function spf_backToPurchase(){
        hide_down(0);
        spf_clearWaitingInStorage();
        $("#showTable2Div").hide();
        $("#choseInsList2").val("");
        $("#showPurchaseOrder").show(500);
        $("#showInstorDetail2 table").html("");
        spf_clear_inStorage2();
    }
    function spf_clear_inStorage2(){
        $("#INSTORAGE_ID2").val("");
        $("#IN_DATE2").val("${IN_DATE}");
        $("#PURCHASE_ORDER_ID").val("");
        $("#SUPPLIER2").val("");
        $("#SUPPLIER2").attr("disabled","");
        initTable(2);
        $("#SUPPLIER2").next("label").show();
        $("#myEditableTable2").parent("div").hide();
    }
    //更换供货商
    function spf_changeSupplier(){
        //更换供货商判断条件为，采购单编号必须有
        if($("#PURCHASE_ORDER_ID").val()!=""){
            show_hide_purchaseLabel();
            if($("#myEditableTable2").parent("div").css("display")!="none"){
                //获取各输入框值，如果没有输入值，则不执行
                var $in = $("#myEditableTable2 input");
                var temp = "";
                for(var i = 0;i<$in.length;i++){
                    if($($in[i]).val()!=""){
                        temp = "notNull";
                        break;
                    }
                }
                if(temp != ""){
                    $.ligerDialog.confirm('<spring:message code="productStorage.thisOperationWill"/>?',
                            '<spring:message code="hrms.warning"/>', 
                        function (yes){
                            if(yes){
                                //初始化商品输入表
                                initTable(2);
                                //判断显示或隐藏商品输入表
                                show_hide_editTable2();
                                $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
                            }else{
                                $("#SUPPLIER2").val($("#SUPPLIER_NO2_2").val());
                            }
                        }
                    );
                }else{
                    initTable(2);
                    show_hide_editTable2();
                    $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
                }
            }else{
                show_hide_editTable2();
                $("#SUPPLIER_NO2_2").val($("#SUPPLIER2").val());
            }
        }else{
            //显示或隐藏采购单编号后面的提示
            show_hide_purchaseLabel();
        }
    }
    //判断显示或隐藏采购单号后显示内容
    function show_hide_purchaseLabel(){
        if($("#PURCHASE_ORDER_ID").val()!=""){
            $("#PURCHASE_ORDER_ID").next("label").hide();
        }else{
            $("#PURCHASE_ORDER_ID").next("label").show();
        }
    }
    //判断显示或隐藏有采购单商品输入表
    function show_hide_editTable2(){
        if($("#PURCHASE_ORDER_ID").val()!="" && $("#SUPPLIER2").val()!=""){
            $("#SUPPLIER2").next("label").hide();
            $("#myEditableTable2").parent("div").show(500);
        }else{
            $("#SUPPLIER2").next("label").show();
            $("#myEditableTable2").parent("div").hide(500);
        }
    }
    
    function show_down(time){
        $("#rightP").css("display","none");
        $("#rightP").next("div").css("display","");
        $("#purDetail").slideDown(time);
    }
    function hide_down(time){
        $("#downP").css("display","none");
        $("#downP").prev("div").css("display","");
        $("#purDetail").slideUp(time);
    }
    
    var tab = parent.tab;
    function spf_viewInStorHistory(){
        if (tab.isTabItemExist('prosto0107')) {
            tab.removeTabItem('prosto0107');
        }
        tab.addTabItem({
            tabid:'prosto0107',
            text:'<spring:message code="productStorage.storageRecords"/>',
            url: '/productStorage/proStorageManage/viewInStorHistory'
        });
    }
    
    //查看采购单详情
    function spf_showPurchaseOrderDetail(no) {
        $dialog = $.ligerDialog.open({
            isDrag : true,
            title : '<spring:message code="productStorage.purchaseOrderDetails"/>',
            width : 850,
            height : 450,
            left : 120,
            top : 20,
            showMax : true,
            showMin : true,
            isResize : true,
            url : '/productStorage/proBusinessManage/showPurchaseOrderDetail?PURCHASE_ORDER_NO=' + no
        });
    }
    
    function spf_showInstorProDetail(id){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/showInStorDetail?INSTORAGE_ID='+id,
            dataType : 'json',
            success : function(data) {
                var temp = '<tr height="30"><td colspan="6" align="left">&nbsp;&nbsp;<spring:message code="prostor.inStorage"/>('+id+')<spring:message code="productStorage.informationAlreadyInStorage"/></td></tr>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp + '<tr>'+
                        '<td>&nbsp;&nbsp;'+item.PRODUCT_ID+'</td>'+
                        '<td>'+item.PRODUCT_NAME+'</td>'+
                        '<td>'+item.SPECIFICATION+'</td>'+
                        '<td>'+item.QUANTITY+'</td>'+
                        '<td>'+item.UNIT_NAME+'</td>'+
                        '<td>'+item.STORAGE_NAME+'</td>'+
                        '</tr>';
                    }
                );
                $("#showInstorDetail1 table").html(temp);
            },
            error : function() {
                $.ligerDialog.error('Send Error2');
            }
        });
    }
    
    function spf_showInstorProDetail2(id){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/showInStorDetail?INSTORAGE_ID='+id,
            dataType : 'json',
            success : function(data) {
                var temp = '<tr height="30"><td colspan="6" align="left">&nbsp;&nbsp;<spring:message code="prostor.inStorage"/>('+id+')<spring:message code="productStorage.informationAlreadyInStorage"/></td></tr>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp + '<tr>'+
                        '<td>&nbsp;&nbsp;'+item.PRODUCT_ID+'</td>'+
                        '<td>'+item.PRODUCT_NAME+'</td>'+
                        '<td>'+item.SPECIFICATION+'</td>'+
                        '<td>'+item.QUANTITY+'</td>'+
                        '<td>'+item.UNIT_NAME+'</td>'+
                        '<td>'+item.STORAGE_NAME+'</td>'+
                        '</tr>';
                    }
                );
                $("#showInstorDetail2 table").html(temp);
            },
            error : function() {
                $.ligerDialog.error('Send Error2');
            }
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
    width: 100%;
    margin: 0;
    padding: 0;
}

#NODiv{
    margin-top:5px;
}

#myEditableTable,#myEditableTable2{
    margin-top:10px;
    width:100%;
    font-size:12px;
    border:1px solid #a3c0e8;
    border-collapse:0px;
}

.headerTh{
    text-align:center;
    line-height:23px;
    height:23px;
    border:1px solid #a3c0e8;
}

#myEditableTable td,#myEditableTable2 td{
    text-align:center;
    line-height:25px;
    height:25px;
    border:1px solid #a3c0e8;
}

#header{
    background-image:url('/resources/images/myimage/tableHeader.gif');
}

.tableInput,.nameInput{
    width:100%;
    height:23px;
    text-align:center;
    border:0px;
    background-color:white;
    color:black;
}
.countInput{
    width:100%;
    height:23px;
    text-align:center;
    border:0px;
}

#myEditableTable select{
    width:100%;
    height:23px;
    text-align:center;
    border:0px;
}
#showProductDiv{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
#showProductType,#showProductUnit{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
.proItemDiv,.proItemType,.proItemUnit{
    width:100%;
    height:22px;
    font-size:15px;
    line-height: 22px;
    cursor:pointer;
}
.proItemDiv:hover{
    background-color:#dcf8a8;
}
.proItemType:hover{
    background-color:#dcf8a8;
}
.proItemUnit:hover{
    background-color:#dcf8a8;
}
.removeTr{
    width:15px;
    height:15px;
    cursor:pointer;
}
#showInstorDetail1 table,#showInstorDetail2 table{
    border:1px solid #c5c5c5;
    margin-top:20px;
}
</style>
</head>
<body style="padding: 2px">
    <table width="99%" align="center" cellpadding="1" cellspacing="1"
        style="height: 25px; font-size: 12px;">
        <tr>
            <td width="40" align="left"><img
                src="/resources/images/title/top_1.gif" /></td>
            <td width="25%" align="left" style="font-weight: bold;"><spring:message code="prostor.productStorage"/></td>
            <td align="right">
                <a class="l-button"
                            style="width: 80px; height: 20px;"
                            onclick="spf_viewInStorHistory()"><spring:message code="prostor.viewStorageRecords"/></a>
            </td>
        </tr>
    </table>
    <table width="99%" align="center" cellpadding="0"
        cellspacing="0">
        <tr height="50">
            <td class="l-table-edit-c" width="100%" align="left">
                <input type="radio" name="inType" class="typeClass" value="NO" checked="checked" /><spring:message code="prostor.noPurchase"/>
                <input type="radio" name="inType" class="typeClass" value="YES" style="margin-left:25px;"/><spring:message code="prostor.havePurchase"/>
            </td>
        </tr>
    </table>
    <div id="layout1">

        <div id = "YESDiv">
            <table width="99.6%" align="center" cellpadding="0"
                cellspacing="0">
                <tr height="40">
                    <td class="l-table-edit-c">
                        <input type="text" name="keyWord" id="keyWord" style="float:left; width:300px;height:25px;"/>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: left; margin-left: 10px;"
                            onclick="spf_search()"><spring:message code="search"/></a>
                    </td>
                    <td align="right" style="font-size:12px;">
                        <%-- <spring:message code="prostor.inStorage"/>&nbsp;
                        <select id="choseInsList2" name="choseInsList2" onchange="spf_choseInList(2)"> --%>
                        </select>
                        <a class="l-button"
                            style="width: 90px; height: 20px; float: right;"
                            onclick="spf_clickChoseInList(1)"><spring:message code="productStorage.processingReceipt"/></a>
                    </td>
                </tr>
            </table>
            
            <div id="showPurchaseOrder" style="width:99%;margin:0 auto;margin-top:10px;"></div>
            
            <div id="showTable2Div" style="width:99%;margin:0 auto;display:none;">
                <table width="100%" style="font-size:12px;margin-top:12px;margin-bottom:12px;border:1px solid #a3c0e8;">
                    <tr height="30">
                        <td align="left" width="100">
                            &nbsp;<spring:message code="prostor.inStorageId"/>&nbsp;</td>
                        <td align="left" width="40%">
                            <input id="INSTORAGE_ID2" name="INSTORAGE_ID2" type="text" disabled="disabled"
                                style="width:150px;height:22px;background-color:white;border:1px solid #a3c0e8;color:black;"/></td>
                        <td align="left" width="100">
                            &nbsp;<spring:message code="prostor.purchaseOrderId"/>&nbsp;</td>
                        <td align="left">
                            <input type="text" disabled="disabled" id="PURCHASE_ORDER_ID" name="PURCHASE_ORDER_ID"
                                style="width:150px;height:22px;background-color:white;border:1px solid #a3c0e8;color:black;"/>
                            <label style="color:red;display:none;">&nbsp;*<spring:message code="productStorage.pleaseSelectThePurchaseOrderNumber"/></label></td>
                    </tr>
                    <tr height="30">
                        <td align="left">
                            &nbsp;<spring:message code="hrms.supplier"/>&nbsp;</td>
                        <td align="left">
                            <input type="hidden" id="SUPPLIER_NO2_2" value=""/>
                            <select id="SUPPLIER2" style="width:150px;height:22px;color:black;" onchange="spf_changeSupplier()">
                                <option value=""><spring:message code="hrms.selection"/></option>
                            </select>
                            <label style="color:red">&nbsp;*<spring:message code="productStorage.pleaseSelectSuppliers"/></label></td>
                        <td align="left">
                            &nbsp;<spring:message code="hrms.date"/>&nbsp;</td>
                        <td align="left">
                            <input type="text" name="IN_DATE2" id="IN_DATE2" style="width:150px;height:22px;"
                                value="${IN_DATE }"
                                onclick="WdatePicker({lang:<spring:message
                                code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                readonly="readonly"/></td>
                    </tr>
                </table>
                <table width="100%" align="center">
                    <tr>
                        <td>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right;"
                                onclick="spf_backToPurchase()"><spring:message code="prostor.back"/></a>
                        </td>
                    </tr>
                </table>
                <div style="display:none;">
                    <table width="99%" id="myEditableTable2"></table>
                    <table width="100%" align="center">
                        <tr>
                            <td>
                                <a class="l-button"
                                    style="width: 79px; height: 20px; float: left; margin-left: 10px;"
                                    onclick="f_save(2)"><spring:message code="prostor.saveTemporary"/></a>
                            </td>
                            <td height="30">
                                <a class="l-button"
                                    style="width: 79px; height: 20px; float: right;"
                                    onclick="f_save(1)"><spring:message code="hrms.save"/></a>
                                <a class="l-button"
                                    style="width: 79px; height: 20px; float: right; margin-right: 10px;"
                                    onclick="spf_clear(2)"><spring:message code="productStorage.empty"/></a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="height:14px;font-size:12px;line-height:14px;float:left;">
                    <spring:message code="productStorage.thePurchaseOrderHas"/>&nbsp;<span id="sumWaiting">0</span>&nbsp;<spring:message code="productStorage.commoditiesUnvaulted"/>&nbsp;
                </div>
                
                <div style="width:16px;height:14px;float:left;">
                    <div style="width:8px;height:14px;background-image:url('/resources/images/myimage/left.gif');cursor:pointer;" id="rightP" 
                        onclick="show_down(500)"></div>
                    <div style="width:16px;height:8px;background-image:url('/resources/images/myimage/down.gif');margin-top:4px;cursor:pointer;display:none;" id="downP" 
                        onclick="hide_down(500)"></div>
                </div>
                <br/>
                <div style="clear:both;width:400px;border:1px solid #7f9db9;display:none;" id="purDetail">
                    <table width="98%" style="font-size:12px;margin:0 auto;" id="waitingTable">
                    </table>
                </div>
                <div id="showInstorDetail2" style="width:480px;margin-right:0px;">
                    <table style="width:100%;font-size:12px;">
                </table>
            </div>
            </div>
        </div>

        <!-- 
            !--以下部分是无采购单界面代码
            !--以下部分是无采购单界面代码
            !--以下部分是无采购单界面代码
            !--以下部分是无采购单界面代码
        -->
        <!--  -->
        <div id="NODiv" style="width:99%;margin:0 auto;">
            <table width="100%" style="font-size:12px;margin-top:12px;">
                <tr>
                    <td align="left">
                        <spring:message code="prostor.inStorageId"/>&nbsp;
                        <input id="INSTORAGE_ID" name="INSTORAGE_ID" type="text" disabled="disabled"
                            style="width:150px;height:22px;background-color:white;border:1px solid #a3c0e8;color:black;"/>
                        <label style="margin-left:25px;"><spring:message code="hrms.supplier"/></label>&nbsp;
                        <select id="SUPPLIER" style="width:150px;height:22px;color:black;">
                            <option value=""><spring:message code="hrms.selection"/></option>
                        </select>
                        <label style="margin-left:25px;"><spring:message code="hrms.date"/></label>&nbsp;
                        <input type="text" name="IN_DATE" id="IN_DATE" style="width:150px;height:22px;"
                            value="${IN_DATE }"
                            onclick="WdatePicker({lang:<spring:message
                            code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                            readonly="readonly"/>
                    </td>
                    <td align="right">
                        <a class="l-button"
                            style="width: 90px; height: 20px; float: right;"
                            onclick="spf_clickChoseInList(2)"><spring:message code="prostor.ProcessingStorlists"/></a>
                    </td>
                </tr>
            </table>
            
            <table id="myEditableTable">
                
            </table>
            
            <table width="100%" align="center">
                <tr>
                    <td>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: left;"
                            onclick="f_save(2)"><spring:message code="prostor.saveTemporary"/></a>
                    </td>
                    <td height="30">
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right;"
                            onclick="f_save(1)"><spring:message code="hrms.save"/></a>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-right: 10px;"
                            onclick="spf_clear(1)"><spring:message code="cancel"/></a>
                    </td>
                </tr>
            </table>
            
            <div id="showInstorDetail1" style="width:480px;margin-right:0px;">
                <table style="width:100%;font-size:12px;">
                </table>
            </div>
            
        </div>
    </div>
    <div id="showProductDiv"></div>
    <div id="showProductType" title=""></div>
    <div id="showProductUnit" title=""></div>
    <%-- <div style="display: none">
        <SipingSoft:selectProductType name="productType" limit="all"/>
        <SipingSoft:selectProductUnit name="productUnit" limit="all"/>
    </div> --%>
</body>
</html>
