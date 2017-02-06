<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
    <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
    <script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
    <script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $proList;
    //var product = eval(${jsonData});
    $(function(){
        /* var product = eval(${jsonData});
        $("#PRODUCT_ID_SHOW").text(product.PRODUCT_ID);
        $("#PRODUCT_NAME_SHOW").text(product.PRODUCT_NAME);
        if(product.SPECIFICATION != null && product.SPECIFICATION != "null"){
            $("#SPECIFICATION_SHOW").text(product.SPECIFICATION);
        }
        $("#STORAGE_NAME_SHOW").text(product.STORAGE_NAME);
        $("#LEFT_QUANTITY_SHOW").text(product.LEFT_QUANTITY);
        if(product.MIN_QUANTITY != null && product.MIN_QUANTITY != "null"){
            $("#MIN_QUANTITY_SHOW").text(product.MIN_QUANTITY);
        } */
        $("#PRODUCT_NO").val("${product.PRODUCT_NO}");
        $("#STORAGE_NO_FROM").val("${product.STORAGE_NO}");
        $("#UNIT_CODE_ID").val("${product.UNIT_CODE_ID}"); 
        spf_initStorage();
    });
    
    function spf_initStorage(){
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/storageManage/getStorageList',
            dataType : 'json',
            async: false,
            success : function(data) {
                var temp = '<option value="">请选择</option>';
                $.each(
                    data.Rows,
                    function(k, item) {
                        temp = temp + '<option value="'+item.STORAGENO+'">'+item.STORAGENAME+'</option>';
                    }
                );
                $("#STORAGE_NO_TO").html(temp);
            },
            error : function() {
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    function spf_changeTransfer(){
        if($("#transferType").val()!=""){
            $("#transferTypeTable").next("table").show();
        }else{
            $("#addrTable").hide();
            $("#quantityTable").hide();
            $("#addrTable input").val("");
            $("#quantityTable input,select").val("");
        }
    }
    
    function spf_changeStorage(){
        if($("#STORAGE_NO_TO").val()!=""){
            $("#quantityTable").next("table").show();
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/productStorage/productManage/getProStorDetailList?STORAGE_NO='+$("#STORAGE_NO_TO").val()+"&PRODUCT_NO=${product.PRODUCT_NO}",
                dataType : 'json',
                async: false,
                success : function(data) {
                    
                    if(data.Rows.length<=0){
                        $("#MIN_QUANTITY").val("");
                        $("#STOR_ADDR").val("");
                    }
                    $.each(
                        data.Rows,
                        function(k, item) {
                            $("#MIN_QUANTITY").val(item.MIN_QUANTITY);
                            $("#STOR_ADDR").val(item.STOR_ADDR);
                        }
                    );
                },
                error : function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }else{
            $("#addrTable").hide();
            $("#addrTable input").val("");
        }
    }
    
    function spf_save(){
        if($("#transferType").val()==""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择移动类型') ;
            return ;
        }
        if($("#STORAGE_NO_TO").val()==""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择目标仓库') ;
            return ;
        }
        if($("#MOVE_QUANTITY").val()=="" && $("#STOR_ADDR").val() == "" 
                && $("#MIN_QUANTITY").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请填写移动数量') ;
            return ;
        }
        if($("#MOVE_QUANTITY").val()!="" && isNaN($("#MOVE_QUANTITY").val())){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '转移数量请输入数字') ;
            return ;
        }
        if($("#MOVE_QUANTITY").val()!="" && parseFloat($("#MOVE_QUANTITY").val())<0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '移库数量请输入正数') ;
            return ;
        }
        if($("#MOVE_QUANTITY").val()!="" && parseFloat($("#MOVE_QUANTITY").val())>parseFloat("${product.LEFT_QUANTITY}")){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '转移数量不能大于库存现有数量') ;
            return ;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        var options = {
            url:'/productStorage/storageManage/moveProduct',
            type:'POST',
            success: function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
                parent.f_ChildWindowClose();
            },
            error:function(){
                alert("wrong");
            }
        };
        $('#form1').ajaxSubmit(options);
    }
</script>
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;}
        .divTitle{
            font-size:12px;
            line-height:23px;
            font-weight: bold;
            background-image:url('/resources/images/myimage/divTitle.gif');
            border:1px solid #A3C0E8;
        }
        .detailTd{
            font-size:14px;
            padding-left:10px;
        }
        .detailTd input,.detailTd select{
            width:150px;
            height:20px;
        }
        th{
            text-align:center;
            border:1px solid #A3C0E8;
        }
    </style>
</head>
<body style="padding:0px" > 
    <div id = 'layout1'>
        <div position="center" id="showProducts">
            <table width="99%" align="center" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="40" align="left"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td align="left" style="font-weight: bold;">货物信息</td>
                </tr>
            </table>
            <table width="99.6%" align="center" cellpadding="0"
                cellspacing="0" class="l-table-edit_01" border="1xp"
                bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t" width="12%">货品编码</td>
                    <td class="l-table-edit-c" width="21%" id="PRODUCT_ID_SHOW">
                        ${product.PRODUCT_ID }
                    </td>
                    <td class="l-table-edit-t" width="12%">货物品名</td>
                    <td class="l-table-edit-c" width="21%" id="PRODUCT_NAME_SHOW">
                        ${product.PRODUCT_NAME }
                    </td>
                    <td class="l-table-edit-t" width="12%">货品规格</td>
                    <td class="l-table-edit-c" width="21%" id="SPECIFICATION_SHOW">
                        ${product.SPECIFICATION }
                    </td>
                </tr>
                <tr>
                    <td class="l-table-edit-t" width="12%">出货仓库</td>
                    <td class="l-table-edit-c" width="21%" id="STORAGE_NAME_SHOW">
                        ${product.STORAGE_NAME }
                    </td>
                    <td class="l-table-edit-t" width="12%">库存数量</td>
                    <td class="l-table-edit-c" width="21%" id="LEFT_QUANTITY_SHOW">
                        ${product.LEFT_QUANTITY }
                    </td>
                    <td class="l-table-edit-t" width="12%">预警值</td>
                    <td class="l-table-edit-c" width="21%" id="MIN_QUANTITY_SHOW">
                        ${product.MIN_QUANTITY }
                    </td>
                </tr>
            </table>
            <table width="99%" align="center" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="40" align="left"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td align="left" style="font-weight: bold;">移库明细</td>
                </tr>
            </table>
            
            <div style="width:99%;margin:0 auto;">
                <div title='价格信息' class="divTitle" style="width:100%;">
                    <table width='100%' style="font-size:12px;line-height:23px;font-weight: bold;">
                        <tr height="100%">
                            <td align="left">&nbsp;&nbsp;价格信息</td>
                        </tr>
                    </table>
                </div>
                <div id="salesModelDiv" style="border:1px solid #A3C0E8;width:100%;border-top:0px;">
                    <form name="form1" method="post" action="" id="form1">
                        <input type="hidden" id="PRODUCT_NO" name="PRODUCT_NO"/>
                        <input type="hidden" id="STORAGE_NO_FROM" name="STORAGE_NO_FROM"/>
                        <input type="hidden" id="UNIT_CODE_ID" name="UNIT_CODE_ID"/>
                        <%-- <table width='100%' id="transferTypeTable">
                            <tr height="30">
                                <td class="detailTd">
                                    移动类型: <SipingSoft:selectTransferType name="transferType" limit="all"/>
                                </td>
                            </tr>
                        </table> --%>
                        <table width='100%' id="quantityTable">
                            <tr height="30">
                                <td class="detailTd">
                                    移库数量: <input type="text" id="MOVE_QUANTITY" name = "MOVE_QUANTITY"/></td>
                                <td class="detailTd">
                                    目标仓库: <select id="STORAGE_NO_TO" style="width:150px;" name="STORAGE_NO_TO" onchange="spf_changeStorage()"></select></td>
                            </tr>
                        </table>
                        
                        <table width='96%' align="center" style="margin-top:10px; display:none;font-size:12px;border:1px solid #A3C0E8;" id="addrTable">
                            <tr style="height:20px;background-image:url('/resources/images/myimage/divTitle.gif');border:1px solid #A3C0E8;">
                                <th>预警值</th><th>存放位置</th>
                            </tr>
                            <tr height="30">
                                <td class="detailTd" align="center" style="border:1px solid #A3C0E8;">
                                    <input type="text" id="MIN_QUANTITY" name = "MIN_QUANTITY"/></td>
                                <td class="detailTd" align="center" style="border:1px solid #A3C0E8;">
                                    <input type="text" id="STOR_ADDR" name = "STOR_ADDR"/></td>
                            </tr>
                        </table>
                        <br/>
                    </form>
                </div>
                <table width="100%" align="center">
                    <tr height="30">
                        <td align="right">
                            <a class="l-button" onclick="spf_save()">保存</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
