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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始调用
    // 记录列数
    var columns = 0;
    // 记录行号
    var no = 0;
    //采购单表格的列名
    var purchaseOrderColumnsList = [{"COLUMN_NAME":"NO","ITEM_NAME":"行号","ORDER_NO":0},
                                    {"COLUMN_NAME":"PRODUCT_ID","ITEM_NAME":"货品编号","ORDER_NO":1},
                                    {"COLUMN_NAME":"PRODUCT_NAME","ITEM_NAME":"品名规格</br>(公司)","ORDER_NO":2},
                                    {"COLUMN_NAME":"UNIT_CODE_ID","ITEM_NAME":"单位</br>(公司)","ORDER_NO":3},
                                    {"COLUMN_NAME":"SUPPLIER_NAME","ITEM_NAME":"供货商","ORDER_NO":4},
                                    {"COLUMN_NAME":"SUPPLIER_PRODUCT_NAME","ITEM_NAME":"品名规格</br>（供货商）","ORDER_NO":5},
                                    {"COLUMN_NAME":"UNIT_PRICE","ITEM_NAME":"单价</br>（供货商）","ORDER_NO":6},
                                    {"COLUMN_NAME":"QUANTITY","ITEM_NAME":"数量","ORDER_NO":7},
                                    {"COLUMN_NAME":"SUM_MONEY","ITEM_NAME":"金额","ORDER_NO":8},
                                    {"COLUMN_NAME":"EXPECTED_ARRIVAL_DATE","ITEM_NAME":"期望到货日期","ORDER_NO":9},
                                    {"COLUMN_NAME":"REMARKS","ITEM_NAME":"备注","ORDER_NO":10},
                                    {"COLUMN_NAME":"LINE_OPERATION","ITEM_NAME":"行操作","ORDER_NO":11}]; 
    $(function() {
        //获取列
        spf_initColumns(purchaseOrderColumnsList);
        
        //点击其他地方，则商品列表清空隐藏
        $(document).click(function(e){
            var element = e.target;
            $("#showProductByIdDiv").html();
            $("#showProductByIdDiv").hide();
            
            $("#showProductByNameDiv").html();
            $("#showProductByNameDiv").hide();
            
            $("#showSupplierDiv").html();
            $("#showSupplierDiv").hide();
            
            $("#showSupplierProductDiv").html();
            $("#showSupplierProductDiv").hide();
            //总金额
            setPayableAmount(no);
        });
        
        //换选中色加添加行事件
        $("#myEditableTable tr").live("click",function(){
            //将兄弟行全部置为白色
            $(this).siblings().children("td").children("input,select").css("background-color","white").end().siblings().css("background-color","white");
            //将自个弄成选中青色
            $(this).children("td").children("input,select").css("background-color","#dcf8a8").end().css("background-color","#dcf8a8");
            //如果选择的是最后一行，那么添加新一行
            if($(this).children("td:eq(0)").text()==no){
                no++;
                if(no<101){
                    var tr = "<tr>";
                    for(var i=0;i<columns;i++){
                        if(i==0){
                            tr=tr+"<td id='NO"+no+"'>"+no+"</td>";
                        }else if(i==1){
                            tr=tr+"<td width='100'><input type='text' class='tableInput' "+
                                    " name='productId"+no+"' id='productId"+no+"' onkeyup='getProductById(this.id)'/> <input type='hidden' class='tableInput' "+
                                    " name='productNo"+no+"' id='productNo"+no+"'/></td>";
                        }else if(i==2){
                            tr=tr+"<td width='80'><input type='text' class='tableInput' "+" name='productNameSpecification"+no+"' id='productNameSpecification"+no+
                            "' onkeyup='getProductByName(this.id)'/> <input type='hidden' class='tableInput' "+" name='productName"+no+
                            "' id='productName"+no+"'/> <input type='hidden' class='tableInput' "+" name='specification"+no+
                            "' id='specification"+no+"'/></td>";
                        }else if(i==3){
                            tr=tr+"<td width='45'><input type='text' class='tableInput' "+" name='proUnit"+no+"' id='proUnit"+no+"' readonly='readonly'/></td>";
                        }else if(i==4){
                            tr=tr+"<td class='supplier' id='supplier"+no+"' value='' onClick='getSupplier(this.id)' width='160'> <input type='hidden' class='tableInput' "+" name='supplierNo"+no+
                            "' id='supplierNo"+no+"'/> <input type='text' class='tableInput' "+" name='supplierName"+no+"' id='supplierName"+no+"' readonly='readonly'/></td>";
                        }else if(i==5){
                            tr=tr+"<td width='80'  id='getSupplierProduct"+no+"' onClick='getSupplierProduct(this.id)'><input type='text' class='tableInput' "+" name='supplierProduct"+no+"' id='supplierProduct"+no+
                            "' readonly='readonly'/> <input type='hidden' class='tableInput' "+" name='supplierProductName"+no+"' id='supplierProductName"+no
                            +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductSpecification"+no+"' id='supplierProductSpecification"+no
                            +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductId"+no+"' id='supplierProductId"+no
                            +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductNo"+no+"' id='supplierProductNo"+no+"'/></td>";
                        }else if(i==6){
                            tr=tr+"<td width='70'><input type='text' class='tableInput' "+" name='supplierUnitPrice"+no+"' id='supplierUnitPrice"+no+
                            "' readonly='readonly' /></td>";
                        }else if(i==7){
                            tr=tr+"<td width='60'><input type='text' class='tableInput' "+" name='quantity"+no+"' id='quantity"+no+"' onkeyup='setSumMoneyByQuantity(this.id)'/></td>";
                        }else if(i==8){
                            tr=tr+"<td width='80'><input type='text' class='tableInput' name='sumMoney"+no+"' id='sumMoney"+no+"' readonly='readonly'/></td>";
                        }else if(i==9){
                            tr=tr+"<td width='70'><input type='text' class='tableInput' name='expectedArriavlDate"+no+"' id='expectedArriavlDate"+no+"' /></td>";
                        }else if(i==10){
                            tr=tr+"<td ><input type='text' class='tableInput' name='remarks"+no+"' id='remarks"+no+"' /></td>";
                        }else if(i==11){
                            tr=tr+"<td onClick='delRow(this)'><img src='/resources/js/ligerUI/skins/icons/0.gif' /></td>";
                        }
                    }
                    tr=tr+"</tr>";
                    $("#myEditableTable").append(tr);
                }
            }
        });
        
        //依据货品编号搜索后选择模糊查询下拉框商品后
        $(".proItemIdDiv").live("click",function(){
            var inputId = $(this).attr("title");
            var comment = $(this).attr("comment");
            var colmns = comment.split("~");

            $("#"+inputId).val(colmns[0]);//货品编号
            $("#"+inputId).siblings("input:eq(0)").val(colmns[4]);  //货品No
            
            var $td = $("#"+inputId).parent().siblings();
            
            $($td[1]).children("input:eq(0)").val(colmns[1]+"("+colmns[2]+")");  //设置品名规格
            $($td[1]).children("input:eq(1)").val(colmns[1]); //设置品名以便后面获取该值进行模糊查询 
            $($td[1]).children("input:eq(2)").val(colmns[2]);  //设置规格以便后面获取该值进行模糊查询 
            $($td[2]).children("input:eq(0)").val(colmns[3]);
            
            //清空该行其他单元格中的值
            for (var i = 4; i < $td.length; i++) {
                $($td[i]).children("input").val('');
            }
        });
        
        //依据品名搜索后选择模糊查询下拉框商品后
        $(".proItemNameDiv").live("click",function(){
            var inputId = $(this).attr("title");
            var comment = $(this).attr("comment");
            var colmns = comment.split("~");

            $("#"+inputId).val(colmns[1]+"("+colmns[2]+")");
            //货品编号、单位
            var $td = $("#"+inputId).parent().siblings();
            
            $($td[1]).children("input:eq(0)").val(colmns[0]); //货品编号
            $($td[1]).children("input:eq(1)").val(colmns[4]); //货品No
            $($td[2]).children("input").val(colmns[3]);  //单位
            //品名、规格
            $("#"+inputId).siblings("input:eq(0)").val(colmns[1]);  //品名
            $("#"+inputId).siblings("input:eq(1)").val(colmns[2]);  //规格    
            
            //清空该行其他单元格中的值
            for (var i = 4; i < $td.length; i++) {
                $($td[i]).children("input").val('');
            }
        });
        
        //选择供货商
        $(".supplierItemDiv").live("click",function(){
            var inputId = $(this).attr("title");
            var inputs = inputId.split("~");
            
            var comment = $(this).attr("comment");
            var colmns = comment.split("~");

            $("#"+inputs[0]).val(colmns[0]);
            $("#"+inputs[1]).val(colmns[1]);
        });
        
        //选择供货商旗下的商品
        $(".supplierProductItemDiv").live("click",function(){
            var inputId = $(this).attr("title");
            var inputs = inputId.split("~");

            var comment = $(this).attr("comment");
            var colmns = comment.split("~");

            for (var i = 0; i <= 5;i++) {
                $("#"+inputs[i]).val(colmns[i]);
            }
            
            //解决供货商改变后，单价改变，金额不变的问题
            var unitPrice = colmns[4];
            var quantity = $("#"+inputs[6]).val();

            if (quantity != '') {
                $("#"+inputs[7]).val(CurrencyFormatted(unitPrice*quantity));
            }
        });

        //总金额
        setPayableAmount(no);
    });
    //采购人选择 
    $(function (){
        $("#EMPID_NAME").ligerComboBox({
            onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
        });
    });
    function spf_selectEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                    ]
        });
        return false;
    }
    function spf_selectOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        
        $("#EMPID_NAME").val(data.CHINESENAME);
        $("#EMPID").val(data.EMPID);  
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#EMPID_NAME").val("");
        $("#EMPID").val(""); 
        dialog.close();
    }
    //计算应付金额
    function setPayableAmount(NO){
        //alert(1);
        var payableAmount = 0;
        for (var i = 1; i <= NO; i++) {
            var sumMoneyId = 'sumMoney'+i;
            var sumMoney = $("#"+sumMoneyId).val();
            
            if (sumMoney == '' || sumMoney=='undefined' || sumMoney== null) {
                sumMoney = 0;
            }
            payableAmount = payableAmount + parseFloat(sumMoney);
        }
        $("#PAYABLE_AMOUNT").val(CurrencyFormatted(payableAmount));
    }
    //初始化表标题
    function spf_initColumns(paColumns){
        var header = "<tr id='header'>";
        columns = 0;
        $(paColumns).each(function(index, row){
            if(columns == 0){
                header = header+"<th width='25' style='text-align:center;'>"+row.ITEM_NAME+"</th>";
            }else if(columns == 4){
                header = header+"<th width='45' class='headerTh'>"+row.ITEM_NAME+"</th>";
            }else if(columns == 6){
                header = header+"<th width='100' class='headerTh'>"+row.ITEM_NAME+"</th>";
            }else if(columns == 7){
                header = header+"<th width='70' class='headerTh'>"+row.ITEM_NAME+"</th>";
            }else {
                header = header+"<th class='headerTh'>"+row.ITEM_NAME+"</th>";
            }
            columns++;
        });
        
        $("#myEditableTable").append(header);
        
        spf_initTable();
    }
    
    function spf_initTable(){
        //初始化两行
        for(var j=0;j<2;j++){
            no++;
            var tr = "<tr>";
            for(var i=0;i<columns;i++){
                if(i==0){
                    tr=tr+"<td id='NO"+no+"'>"+no+"</td>";
                }else if(i==1){
                    tr=tr+"<td width='100'><input type='text' class='tableInput' "+
                            " name='productId"+no+"' id='productId"+no+"' onkeyup='getProductById(this.id)'/> <input type='hidden' class='tableInput' "+
                            " name='productNo"+no+"' id='productNo"+no+"'/></td>";
                }else if(i==2){
                    tr=tr+"<td width='80'><input type='text' class='tableInput' "+" name='productNameSpecification"+no+"' id='productNameSpecification"+no+
                    "' onkeyup='getProductByName(this.id)'/> <input type='hidden' class='tableInput' "+" name='productName"+no+
                    "' id='productName"+no+"'/> <input type='hidden' class='tableInput' "+" name='specification"+no+
                    "' id='specification"+no+"'/></td>";
                }else if(i==3){
                    tr=tr+"<td width='45'><input type='text' class='tableInput' "+" name='proUnit"+no+"' id='proUnit"+no+"' readOnly/></td>";
                }else if(i==4){
                    tr=tr+"<td class='supplier' id='supplier"+no+"' value='' onClick='getSupplier(this.id)' width='160'> <input type='hidden' class='tableInput' "+" name='supplierNo"+no+
                    "' id='supplierNo"+no+"'/> <input type='text' class='tableInput' "+" name='supplierName"+no+"' id='supplierName"+no+"' readonly='readonly'/></td>";
                }else if(i==5){
                    tr=tr+"<td width='80' id='getSupplierProduct"+no+"' onClick='getSupplierProduct(this.id)'><input type='text' class='tableInput' "+" name='supplierProduct"+no+"' id='supplierProduct"+no+
                    "' readonly='readonly'/> <input type='hidden' class='tableInput' "+" name='supplierProductName"+no+"' id='supplierProductName"+no
                    +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductSpecification"+no+"' id='supplierProductSpecification"+no
                    +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductId"+no+"' id='supplierProductId"+no
                    +"'/> <input type='hidden' class='tableInput' "+" name='supplierProductNo"+no+"' id='supplierProductNo"+no+"'/></td>";
                }else if(i==6){
                    tr=tr+"<td width='70'><input type='text' class='tableInput' "+" name='supplierUnitPrice"+no+"' id='supplierUnitPrice"+no+
                    "' readonly='readonly' /></td>";
                }else if(i==7){
                    tr=tr+"<td width='60'><input type='text' class='tableInput' "+" name='quantity"+no+"' id='quantity"+no+"' onkeyup='setSumMoneyByQuantity(this.id)'/></td>";
                }else if(i==8){
                    tr=tr+"<td width='80'><input type='text' class='tableInput' name='sumMoney"+no+"' id='sumMoney"+no+"' readonly='readonly'/></td>";
                }else if(i==9){
                    tr=tr+"<td width='70'><input type='text' class='tableInput' name='expectedArriavlDate"+no+"' id='expectedArriavlDate"+no+"' /></td>";
                }else if(i==10){
                    tr=tr+"<td ><input type='text' class='tableInput' name='remarks"+no+"' id='remarks"+no+"' /></td>";
                }else if(i==11){
                    tr=tr+"<td onClick='delRow(this)'><img src='/resources/js/ligerUI/skins/icons/0.gif' /></td>";
                }
            }
            tr=tr+"</tr>";
            $("#myEditableTable").append(tr);
        }
    }

    //得到行对象
    function getRowObj(obj){
        var i = 0;
        while(obj.tagName.toLowerCase() != "tr"){
            obj = obj.parentNode;
            if(obj.tagName.toLowerCase() == "table"){
                return null;
            }
        }
        return obj;
    }
    //根据得到的行对象得到所在的行数
    function getRowNo(obj){
        var trObj = getRowObj(obj);
        var trArr = trObj.parentNode.children;
        for(var trNo= 0; trNo < trArr.length; trNo++){
            if(trObj == trObj.parentNode.children[trNo]){
                return trNo;
            }
        }
    }
    //删除行
    function delRow(obj){
        var tr = this.getRowObj(obj);
        var trArrLength = tr.parentNode.children.length; //获得table一共多少行
        var rowNo = getRowNo(tr);
        if(tr != null){
            //当行数为table的前一二行时，只清空内容；其他行时，删除行
            if (rowNo == 1){
                clearInput(1);
            }else if (rowNo == 2){
                clearInput(2);
            }else{
                tr.parentNode.removeChild(tr); //删除当前行
                no--;                          //自动增加行的值减一
                for(var trNo = rowNo + 1; trNo < trArrLength; trNo++){
                    changeNo(trNo);
                }
            }
        }else{
            throw new Error("the given object is not contained by the table");
        }
    }
    function changeNo(no){
        $("#NO"+no).text(no-1); //将大于当前行中的行号减一
        document.getElementById("NO"+no).id = "NO" + (no-1);  //将行的第一个单元格id中的数值减一
        document.getElementById("productId"+no).name = "productId" + (no-1);
        document.getElementById("productId"+no).id = "productId" + (no-1);
        document.getElementById("productNo"+no).name = "productNo" + (no-1);
        document.getElementById("productNo"+no).id = "productNo" + (no-1);
        document.getElementById("productNameSpecification"+no).name = "productNameSpecification" + (no-1);
        document.getElementById("productNameSpecification"+no).id = "productNameSpecification" + (no-1);
        document.getElementById("productName"+no).name = "productName" + (no-1);
        document.getElementById("productName"+no).id = "productName" + (no-1);
        document.getElementById("specification"+no).name = "specification" + (no-1);
        document.getElementById("specification"+no).id = "specification" + (no-1);
        document.getElementById("proUnit"+no).name = "proUnit" + (no-1);
        document.getElementById("proUnit"+no).id = "proUnit" + (no-1);
        document.getElementById("supplier"+no).id = "supplier" + (no-1);
        document.getElementById("supplierNo"+no).name = "supplierNo" + (no-1);
        document.getElementById("supplierNo"+no).id = "supplierNo" + (no-1);
        document.getElementById("supplierName"+no).name = "supplierName" + (no-1);
        document.getElementById("supplierName"+no).id = "supplierName" + (no-1);
        document.getElementById("getSupplierProduct"+no).id = "getSupplierProduct" + (no-1);
        document.getElementById("supplierProduct"+no).name = "supplierProduct" + (no-1);
        document.getElementById("supplierProduct"+no).id = "supplierProduct" + (no-1);
        document.getElementById("supplierProductName"+no).name = "supplierProductName" + (no-1);
        document.getElementById("supplierProductName"+no).id = "supplierProductName" + (no-1);
        document.getElementById("supplierProductSpecification"+no).name = "supplierProductSpecification" + (no-1);
        document.getElementById("supplierProductSpecification"+no).id = "supplierProductSpecification" + (no-1);
        document.getElementById("supplierProductId"+no).name = "supplierProductId" + (no-1);
        document.getElementById("supplierProductId"+no).id = "supplierProductId" + (no-1);
        document.getElementById("supplierProductNo"+no).name = "supplierProductNo" + (no-1);
        document.getElementById("supplierProductNo"+no).id = "supplierProductNo" + (no-1);
        document.getElementById("supplierUnitPrice"+no).name = "supplierUnitPrice" + (no-1);
        document.getElementById("supplierUnitPrice"+no).id = "supplierUnitPrice" + (no-1);
        document.getElementById("quantity"+no).name = "quantity" + (no-1);
        document.getElementById("quantity"+no).id = "quantity" + (no-1);
        document.getElementById("sumMoney"+no).name = "sumMoney" + (no-1);
        document.getElementById("sumMoney"+no).id = "sumMoney" + (no-1);
        document.getElementById("expectedArriavlDate"+no).name = "expectedArriavlDate" + (no-1);
        document.getElementById("expectedArriavlDate"+no).id = "expectedArriavlDate" + (no-1);
        document.getElementById("remarks"+no).name = "remarks" + (no-1);
        document.getElementById("remarks"+no).id = "remarks" + (no-1);
    }
    function clearInput(no){
        $("#productId"+no).val("");
        $("#productNo"+no).val("");
        $("#productNameSpecification"+no).val("");
        $("#productName"+no).val("");
        $("#specification"+no).val("");
        $("#proUnit"+no).val("");
        $("#supplier"+no).val("");
        $("#supplierNo"+no).val("");
        $("#supplierName"+no).val("");
        $("#supplierProduct"+no).val("");
        $("#supplierProductName"+no).val("");
        $("#supplierProductSpecification"+no).val("");
        $("#supplierProductId"+no).val("");
        $("#supplierProductNo"+no).val("");
        $("#supplierUnitPrice"+no).val("");
        $("#quantity"+no).val("");
        $("#sumMoney"+no).val("");
        $("#expectedArriavlDate"+no).val("");
        $("#remarks"+no).val("");
    }
    //初始化表单
    function initTable(){
        no = 0;
        columns = 0;
        $("#myEditableTable").html("");
        spf_initColumns(proColumnsList);
    }
    //清空所有数据
    function spf_clear(){
        $.ligerDialog.confirm('该操作将会清空所有数据，确定吗？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                initTable();
            }
        );
    }
    //依据货品编号模糊查询自家公司的商品信息
    function getProductById(id) {
        $("#showProductByIdDiv").html();
        if($("#"+id).val()!=""){
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/proStorageManage/getProductSymple?PRODUCT_ID_LIKE='+$("#"+id).val(),
                dataType : 'json',
                success : function(data) {
                    var temp = "<table width='100%'>";
                    $.each(
                        data.productList,
                        function(i, item) {
                            temp = temp+"<tr><td title='"+id+"' "+
                            "comment='"+item.PRODUCT_ID+"~"+
                                        item.PRODUCT_NAME+"~"+
                                        MyCheckNull(item.SPECIFICATION)+"~"+
                                        item.CODE_NAME+"~"+
                                        item.PRODUCT_NO+"'"+
                            " class='proItemIdDiv'>"+item.PRODUCT_ID+"-"+item.PRODUCT_NAME+"("+MyCheckNull(item.SPECIFICATION)+")"+"</td></tr>";
                        }
                    );
                    temp = temp +"</table>";
                    $("#showProductByIdDiv").html(temp);
                    $("#showProductByIdDiv").css({
                                                "left":$("#"+id).offset().left+"px",
                                                "top":$("#"+id).offset().top+$("#"+id).height()+"px"});
                    $("#showProductByIdDiv").show();
                },
                error : function() {
                    $.ligerDialog.error('获取数据出错');
                }
            });
        }
    }
    
    //依据品名模糊查询自家公司的商品信息
    function getProductByName(id) {
        $("#showProductByNameDiv").html();
        if($("#"+id).val()!=""){
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/proStorageManage/getProductSymple?PRODUCT_NAME_LIKE='+$("#"+id).val(),
                dataType : 'json',
                success : function(data) {
                    var temp = "<table width='100%'>";
                    $.each(
                        data.productList,
                        function(i, item) {
                            temp = temp+"<tr><td title='"+id+"' "+
                            "comment='"+item.PRODUCT_ID+"~"+
                                        item.PRODUCT_NAME+"~"+
                                        MyCheckNull(item.SPECIFICATION)+"~"+
                                        item.CODE_NAME+"~"+
                                        item.PRODUCT_NO+"'"+
                            " class='proItemNameDiv'>"+item.PRODUCT_ID+"-"+item.PRODUCT_NAME+"("+MyCheckNull(item.SPECIFICATION)+")"+"</td></tr>";
                        }
                    );
                    temp = temp +"</table>";
                    $("#showProductByNameDiv").html(temp);
                    $("#showProductByNameDiv").css({
                                                "left":$("#"+id).offset().left+"px",
                                                "top":$("#"+id).offset().top+$("#"+id).height()+"px"});
                    $("#showProductByNameDiv").show();
                },
                error : function() {
                    $.ligerDialog.error('获取数据出错');
                }
            });
        }
    }
    
    //依据品名规格模糊搜索包含该商品的供货商 
    function getSupplier(id) {
        var no = id.substring(8);
        var productNameId = 'productName'+no;
        var specificationId = 'specification'+no;
        var supplierId = 'supplierNo'+no;
        var supplierNameId = 'supplierName'+no;
        
        var productName = $("#"+productNameId).val();
        var specification = $("#"+specificationId).val();
        
        $("#showSupplierDiv").html();
        
        if(productName != ""){
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/proBusinessManage/getSupplier?PRODUCT_NAME='+encodeURI(productName)+'&SPECIFICATION='+encodeURI(specification),
                dataType : 'json',
                success : function(data) {
                    var temp = "<table width='100%'>";
                    $.each(
                        data.supplier,
                        function(i, item) { 
                            temp = temp+"<tr><td title='"+supplierId+"~"+supplierNameId+"' "+
                            "comment='"+item.SUPPLIER_NO+"~"+
                                        item.SUPPLIER_NAME+"'"+
                            " class='supplierItemDiv'>"+item.SUPPLIER_NAME+"(单价："+item.UNIT_PRICE+")"+"</td></tr>";
                        }
                    );
                    temp = temp +"</table>";
                    $("#showSupplierDiv").html(temp);
                    $("#showSupplierDiv").css({
                                                "left":$("#"+supplierNameId).offset().left+"px",
                                                "top":$("#"+supplierNameId).offset().top+$("#"+supplierNameId).height()+"px"});
                    $("#showSupplierDiv").show();
                },
                error : function() {
                    $.ligerDialog.error('获取数据出错');
                }
            });
        }   
    }
    //依据品名、规格、供货商no获取该供货商下商品
    function getSupplierProduct(id) {
        var no = id.substring(18);
        var productNameId = 'productName'+no; //自家货物品名对应input的id
        var specificationId = 'specification'+no;
        var supplierId = 'supplierNo'+no;  //供货商input对应的id
        var supplierProduct = 'supplierProduct'+no;
        var supplierProductName = 'supplierProductName'+no;
        var supplierProductSpecification = 'supplierProductSpecification'+no;
        var supplierProductId = 'supplierProductId'+no;
        var supplierProductNo = 'supplierProductNo'+no;
        var supplierUnitPrice = 'supplierUnitPrice'+no;
        var quantityId = 'quantity'+no;  //数量input对应的id
        var sumMoneyId = 'sumMoney'+no;
        
        var productName = $("#"+productNameId).val();
        var specification = $("#"+specificationId).val();
        var supplierNo = $("#"+supplierId).val();       
        
        $("#showSupplierProductDiv").html();
        
        if(productName != "" && supplierNo != ""){
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/proBusinessManage/getSupplierProduct?PRODUCT_NAME='+encodeURI(productName)
                        +'&SPECIFICATION='+encodeURI(specification)+'&SUPPLIER_NO='+encodeURI(supplierNo),
                dataType : 'json',
                success : function(data) {
                    var temp = "<table width='100%'>";
                    $.each(
                        data.supplierProduct,
                        function(i, item) { 
                            temp = temp+"<tr><td title='"+supplierProduct+"~"+
                                                        supplierProductName+"~"+
                                                        MyCheckNull(supplierProductSpecification)+"~"+
                                                        supplierProductId+"~"+
                                                        supplierUnitPrice+"~"+
                                                        supplierProductNo+"~"+
                                                        quantityId+"~"+
                                                        sumMoneyId+"' "+    
                            "comment='"+item.PRODUCT_NAME+"("+MyCheckNull(item.SPECIFICATION)+")"+"~"+
                                        item.PRODUCT_NAME+"~"+
                                        MyCheckNull(item.SPECIFICATION)+"~"+
                                        MyCheckNull(item.PRODUCT_ID)+"~"+
                                        item.UNIT_PRICE+"~"+
                                        item.PRODUCT_NO+"'"+
                            " class='supplierProductItemDiv'>"+MyCheckNull(item.PRODUCT_ID)+"-"+item.PRODUCT_NAME+"("+MyCheckNull(item.SPECIFICATION)+")"+"</td></tr>";
                        }
                    );
                    temp = temp +"</table>";
                    
                    $("#showSupplierProductDiv").html(temp);
                    $("#showSupplierProductDiv").css({
                                                "left":$("#"+supplierProduct).offset().left+"px",
                                                "top":$("#"+supplierProduct).offset().top+$("#"+supplierProduct).height()+"px"});
                    $("#showSupplierProductDiv").show();
                },
                error : function() {
                    $.ligerDialog.error('获取数据出错');
                }
            });
        }
    }
    //onkeyup事件，依据填写数量后得出金额
    function setSumMoneyByQuantity(id){
        var no = id.substring(8);
        var quantityId = 'quantity'+no;
        var supplierUnitPriceId = 'supplierUnitPrice'+no;
        var sumMoneyId = 'sumMoney'+no;
        
        var quantity = $("#"+quantityId).val();
        var supplierUnitPrice = $("#"+supplierUnitPriceId).val();
        
        if(quantity != ""){
            $("#"+sumMoneyId).val(CurrencyFormatted(supplierUnitPrice*quantity));
        }
    }
    /**
     *  解决小数相乘后，小数点后位数过多的问题(保留两位小数)
    *   Usage:  CurrencyFormatted(12345.678);
    *   result: 12345.68
    **/
    function CurrencyFormatted(amount) {
        var i = parseFloat(amount);
        if(isNaN(i)) { i = 0.00; }
        var minus = '';
        if(i < 0) { minus = '-'; }
        i = Math.abs(i);
        i = parseInt((i + .005) * 100);
        i = i / 100;
        s = new String(i);
        if(s.indexOf('.') < 0) { s += '.00'; }
        if(s.indexOf('.') == (s.length - 2)) { s += '0'; }
        s = minus + s;
        return s;
    }
    
    function spf_save() {
        $.ligerDialog.confirm('你确定要保存吗？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    var jsonData = '[' ; 
                    if (checkData(no)) {
                        for(var i=1;i<=no;i++){
                            productNo = getValue("productNo",i);
                            supplierNo = getValue("supplierNo",i);
                            supplierProductNo = getValue("supplierProductNo",i);
                            supplierUnitPrice = getValue("supplierUnitPrice",i);
                            quantity = getValue("quantity",i);
                            sumMoney = getValue("sumMoney",i);
                            expectedArriavlDate = getValue("expectedArriavlDate",i);
                            remarks = getValue("remarks",i);
                            productId = getValue("productId",i);
                            productName = getValue("productName",i);
                            specification = getValue("specification",i);
                            productCAS = getValue("productCAS",i);
                            proUnit = getValue("proUnit",i);
                            supplierName = getValue("supplierName",i);
                            supplierProductId = getValue("supplierProductId",i);
                            supplierProductName = getValue("supplierProductName",i);
                            supplierProductSpecification = getValue("supplierProductSpecification",i);
                            supplierUnitPrice = getValue("supplierUnitPrice",i);
                            sumMoney = getValue("sumMoney",i);
                            if ((productId == '' || productId == null || productId == 'undefined') && (supplierNo == '' || supplierNo == null  || productId == 'undefined')){
                                continue;//表示该行无数据,无需放入jsonData
                            } else {
                                if (jsonData.length > 1){
                                    jsonData += ',{' ;
                                }else{
                                    jsonData += '{' ;
                                }
                                jsonData += ' "PRODUCT_NO": "' + productNo + '",';
                                jsonData += ' "SUPPLIER_NO": "' + supplierNo + '",';
                                jsonData += ' "SUPPLIER_PRODUCT_NO": "' + supplierProductNo + '",';
                                jsonData += ' "UNIT_PRICE": "' + supplierUnitPrice + '",';
                                jsonData += ' "QUANTITY": "' + quantity + '",';
                                jsonData += ' "SUM_MONEY": "' + sumMoney + '",';
                                jsonData += ' "EXPECTED_ARRIVAL_DATE": "' + MyCheckNull(expectedArriavlDate) + '",';
                                jsonData += ' "REMARKS": "' + MyCheckNull(remarks) + '",';
                                jsonData += ' "PRODUCT_ID": "' + productId + '",';
                                jsonData += ' "PRODUCT_NAME": "' + productName + '",';
                                jsonData += ' "PRODUCT_SPECIFICATION": "' + specification + '",';
                                jsonData += ' "PRODUCT_CAS": "' + productCAS + '",';
                                jsonData += ' "PRODUCT_UNIT": "' + proUnit + '",';
                                jsonData += ' "SUPPLIER_NAME": "' + supplierName + '",';
                                jsonData += ' "SUPPLIER_PRODUCT_ID": "' + supplierProductId + '",';
                                jsonData += ' "SUPPLIER_PRODUCT_NAME": "' + supplierProductName + '",';
                                jsonData += ' "SUPPLIER_PRODUCT_SPECIFICATION": "' + supplierProductSpecification + '",';
                                jsonData += ' "SUM_MONEY_ADD": "' + sumMoney + '",';
                                jsonData += ' "SUPPLIER_UNIT_PRICE": "' + supplierUnitPrice + '"}';
                            }
                        }
                        jsonData += ']' ;
                        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                        $.post("/productStorage/proBusinessManage/addPurchaseOrder", 
                            [
                                { name: 'jsonData', value: jsonData },
                                { name: 'EMPID', value: $("#EMPID").val()},
                                { name: 'EMP_NAME', value: $("#EMPID_NAME").val()},
                                { name: 'PURCHASE_DATE', value: $("#PURCHASE_DATE").val()},
                                { name: 'PAYABLE_AMOUNT', value: $("#PAYABLE_AMOUNT").val()},
                                { name: 'PAYMENT_MODE', value: $("#PAYMENT_MODE").val()},
                                { name: 'REMARKS', value: MyCheckNull($("#REMARKS").val())},
                                { name: 'TRANSPORT_MODE', value: $("#TRANSPORT_MODE").val()}
                            ], function (result){
                                $.ligerDialog.closeWaitting();
                                if (result == "Y"){
                                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){     
                                        location.href="/productStorage/proBusinessManage/viewProductPurchase?MENU_CODE=prosto0201";
                                    });
                                }else if(result == "N"){
                                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '数据保存出错，请联系技术支持人员！');
                                }
                            }
                        );
                    }
                    
                }
            }
        );
    }
    
    //保存前，必填数据验证
    function checkData(no){
        var nullColumns = 0;//空白行数

        for (var i = 1; i <= no;i++) {
            productId = getValue("productId",i);
            productNameSpecification = getValue("productNameSpecification",i);
            supplierNo = getValue("supplierNo",i);
            supplierProduct = getValue("supplierProduct",i);
            quantity = getValue("quantity",i);
        
            if ((productId == '' || productId == null || productId == 'undefined') && (supplierNo == '' || supplierNo == null  || productId == 'undefined')){
                nullColumns++;
                continue;//表示该行无数据,无需检查
            } else {
                if (productId == '' || productId == null) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请输入商品编号（公司）') ;
                    return ;
                }else if (productNameSpecification == '' || productNameSpecification == null) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请输入商品品名规格（公司）') ;
                    return ;
                }else if (supplierNo == '' || supplierNo == null) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请选择供货商') ;
                    return ;
                }else if (supplierProduct == '' || supplierProduct == null) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请选择品名规格（供货商）') ;
                    return ;
                }else if (quantity == '' || quantity == null) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请输入数量') ;
                    return ;
                }else if (isNaN(quantity)) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'列，请按照正确的格式输入数量') ;
                    return ;
                }
            }
        }
        
        if (nullColumns < no) {
            //检查表单中数据是否填写完整
            if ($("#EMPID").val() == '' || $("#EMPID").val() == null) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择采购人') ;
                return ;
            }else if ($("#PURCHASE_DATE").val() == '' || $("#PURCHASE_DATE").val() == null) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择采购日期') ;
                return ;
            }else if ($("#PAYMENT_MODE").val() == '' || $("#PAYMENT_MODE").val() == null) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择付款方式') ;
                return ;
            }
            return true;
        }else {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请填写数据后再保存') ;
            return ;
        }
    }
    //拼接字符串与no，获得表格中对应id的value
    function getValue(string,no){
        return $("#"+string+no).val();
    }
    function spf_cancel() {
        location.href="/productStorage/proBusinessManage/viewProductPurchase?MENU_CODE=prosto0201";
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

#myEditableTable{
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

#myEditableTable td{
    text-align:center;
    line-height:23px;
    height:23px;
    border:1px solid #a3c0e8;
}

#header{
    background-image:url('/resources/images/myimage/tableHeader.gif');
}

.tableInput{
    width:100%;
    height:23px;
    text-align:center;
    border:0px;
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
#showProductByIdDiv{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
.proItemIdDiv{
    width:100%;
    height:22px;
    font-size:15px;
    line-height: 22px;
    cursor:pointer;
}
.proItemIdDiv:hover{
    background-color:#dcf8a8;
}
#showProductByNameDiv{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
.proItemNameDiv{
    width:100%;
    height:22px;
    font-size:15px;
    line-height: 22px;
    cursor:pointer;
}
.proItemNameDiv:hover{
    background-color:#dcf8a8;
}
#showSupplierDiv{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
.supplierItemDiv{
    width:100%;
    height:22px;
    font-size:9px;
    line-height: 22px;
    cursor:pointer;
}
.supplierItemDiv:hover{
    background-color:#dcf8a8;
}
#showSupplierProductDiv{
    position: absolute;
    display: none;
    background-color:white;
    border:1px solid #a3c0e8;
}
.supplierProductItemDiv{
    width:100%;
    height:22px;
    font-size:9px;
    line-height: 22px;
    cursor:pointer;
}
.supplierProductItemDiv:hover{
    background-color:#dcf8a8;
}
.inputClass{
    width:200px;
    height:23px;
    border:1px solid #A3C0E8;
}
.tableLabel{
    height:25px;
    line-height:25px;
    color:#014d7e;
    font-family:"宋体";
    text-align:center;
    background-color:#c1dbfa;
    font-size:12px;
}

</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <div>
                <table id="myEditableTable">
                    
                </table>
            </div>
            <br/><br/>
            <div>
                <div style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.purchaser"/>
                            <font color="red">*</font>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" name="EMPID_NAME" id="EMPID_NAME" type="text" value="${basicInfo.CHINESENAME}" class="inputClass" style="height:20px;"/>
                            <input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID}" />
                        </td>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.purchaseDate"/>
                            <font color="red">*</font>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="PURCHASE_DATE" id="PURCHASE_DATE" class="inputClass" value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                                validate="{required:true}" />
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.payableAmount"/>
                            <font color="red">*</font>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="PAYABLE_AMOUNT" id="PAYABLE_AMOUNT" readonly="readonly" style="background-color:#E0E0E0;"
                                class="inputClass"/>
                        </td>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.paymentMode"/>
                            <font color="red">*</font>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <SipingSoft:selectSyCode parentCode="PaymentMode" name="PAYMENT_MODE"
                            limit="all"/>
                        </td>
                    </tr>
                    <tr>
                        <td width="15%">
                            <div class="tableLabel">
                            <spring:message code="hrms.transportMode"/>
                            </div>
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            <input width="120" type="text" name="TRANSPORT_MODE" id="TRANSPORT_MODE" class="inputClass">
                        </td>
                        <td class="tableLabel"><spring:message code="hrms.remarks"/></td>
                        <td class="l-table-edit-c"><textarea class="inputClass" style="width: 390px;" id="REMARKS"
                                name="REMARKS"></textarea></td>
                    </tr>
                </table>
                </div>
                <table width="99.6%" align="center" cellpadding="0" class="l-table-edit" cellspacing="0">
                    <tr align="center">
                        <td height="30px">
                            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_cancel()">清空</a>
                            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_save()">保存</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div id="showProductByIdDiv"></div>
    <div id="showProductByNameDiv"></div>
    <div id="showSupplierDiv"></div>
    <div id="showSupplierProductDiv"></div>
</body>
</html>