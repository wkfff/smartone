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
        f_initGrid();
        $("*[name='STATUS']").width(180);
        $("*[name='STATUS']").css({border:"1px solid #c1dcfa"});
        $("*[name='CUST_TYPE_CODE']").css({border:"1px solid #c1dcfa"});
        $("*[name='CUST_TYPE_CODE']").width(180);
        $("*[name='STATUS_S']").css({border:"1px solid #c1dcfa"});
        $("*[name='STATUS_S']").width(180);
    });

    function f_initGrid() {
        $grid = $("#hrSearchEmp").ligerGrid({
            columns : [
                        {display : '<spring:message code="process.number"/>',name : 'SUPPLIER_ID',width : '10%'},
                        {display : '<spring:message code="cust.supplierName"/>',name : 'SUPPLIER_NAME',width : '10%'},
                        {display : '<spring:message code="cust.supplierAddress"/>',name : 'SUPPLIER_ADDRESS',width : '25%'},
                        {display : '<spring:message code="hrms.contact"/>',name : 'SUPPLIER_CONTACTS',width : '5%'},
                        {display : '<spring:message code="hrms.telephone"/>',name : 'SUPPLIER_PHONE1',width : '8%'},
                        {display : '<spring:message code="hrms.phone1"/>',name : 'SUPPLIER_PHONE2',width : '8%'},
                        {display : '<spring:message code="cust.email"/>',name : 'SUPPLIER_EMAIL',width : '10%'},
                        {display : '<spring:message code="hrms.type"/>',name : 'SUPPLIER_TYPE',width : '7%'},
                        {display : '<spring:message code="prostor.storage.remark"/>',name : 'SUPPLIER_DESCRIPTION',width : '15%'}
                ],
            enabledEdit : false,
            usePager : true,
            rownumbers : true,
            isScroll :true,
            url : "/cust/supperlierManager/getSupplierModelList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            enabledSort:true
        });
    }
    
    function showSalesModelDetail(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        spf_add();
        $("#SUPPLIER_ID").val(row.SUPPLIER_ID);
        $("#SUPPLIER_NO").val(row.SUPPLIER_NO);
        $("#SUPPLIER_NAME").val(row.SUPPLIER_NAME);
        $("#SUPPLIER_ADDRESS").val(row.SUPPLIER_ADDRESS);
        $("#SUPPLIER_TYPE").val(row.SUPPLIER_TYPE);
        $("#SUPPLIER_CONTACTS").val(row.SUPPLIER_CONTACTS);
        $("#SUPPLIER_FAX").val(row.SUPPLIER_FAX);
        $("#SUPPLIER_PHONE1").val(row.SUPPLIER_PHONE1);
        $("#SUPPLIER_PHONE2").val(row.SUPPLIER_PHONE2);
        $("#SUPPLIER_EMAIL").val(row.SUPPLIER_EMAIL);
        $("#SUPPLIER_EN_NAME").val(row.SUPPLIER_EN_NAME);
        $("#SUPPLIER_DESCRIPTION").val(row.SUPPLIER_DESCRIPTION);
        $("*[name='STATUS']").val(row.ACTIVITY);
        $("*[name='CUST_TYPE_CODE']").val(row.SUPPLIER_TYPE); 
    }
    
     function spf_checkData(){
            var telereg = /^1[3|4|5|8][0-9]\d{8}$/;
            var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
            if ($("#SUPPLIER_NAME").val() == "") {
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="cust.supplierName"/>'+". " + '<spring:message code="input.required"/>') ; 
                 return false;
            }
            if ($("#CUST_TYPE_CODE").val() == "") {
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="cust.supplierType"/>'+". " + '<spring:message code="input.required"/>') ; 
                 return false; 
            }
            if($("#SUPPLIER_CONTACTS").val()==""){
                 $.ligerMessageBox.warn( '<spring:message code="hrms.warning"/>','<spring:message code="hrms.contact"/>'+". " + '<spring:message code="input.required"/>')
                 return false;
            }
            if($("#SUPPLIER_PHONE2").val()==""){
                $.ligerMessageBox.warn( '<spring:message code="hrms.warning"/>','<spring:message code="hrms.phone"/>'+". " + '<spring:message code="input.required"/>')
                return false;
            }
            if ( $("#SUPPLIER_EMAIL").val() != "" && !mailreg.test($("#SUPPLIER_EMAIL").val())) {
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="cust.email"/>' + '<spring:message code="hrms.malformed"/>') ; 
                 return false;
            }
            if( $("#SUPPLIER_PHONE2").val() != ""&&!telereg.test($("#SUPPLIER_PHONE2").val())){
                 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.phone1"/>'+ '<spring:message code="hrms.malformed"/>') ; 
                 return false;
            }
            if($("#SUPPLIER_DESCRIPTION").val().length>500){
              $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="cust.descriptionCharactersLong"/>') ; 
              return false; 
            }
            return true;
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

    function spf_add(){
        $("#showProductDetailDiv input").val("");
        $("#SUPPLIER_DESCRIPTION").val("");
        $("*[name='STATUS']").val("");
        $("*[name='CUST_TYPE_CODE']").val("");
        $("*[name='STATUS']").val("");
        $("*[name='CUST_TYPE_CODE']").val("");
        $("#showProductDetailDiv").show(500);
    }
    function spf_clear(){
        $("#showProductDetailDiv input").val("");
        $("#showProductDetailDiv").hide(500);
    }
    
    function spf_account()
    {
        $("#account").show(500);
    }

    function spf_save(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url:'/cust/supperlierManager/addOrUpdateProduct',
                type:'POST',
                success: function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                        $grid.loadData(true);
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                },
                error:function(){
                    alert("wrong");
                }
            };
            $('#form1').ajaxSubmit(options);
        }
    }
    function spf_update(){
        showSalesModelDetail();
    }

    function spf_delete(){
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $.ligerDialog.confirm('你确定要删除该数据吗<spring:message code=""/>？','<spring:message code="hrms.warning"/>',
            function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/cust/supperlierManager/deleteSupplierModel", 
                        {SUPPLIER_NO:row.SUPPLIER_NO},
                        function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid.loadData(true); //加载数据 
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            });
    }

    var tab = parent.tab;
    function spf_impExcel(){
        if (tab.isTabItemExist('cust0706')) {
            tab.removeTabItem('cust0706');
        }
        tab.addTabItem({
            tabid:'cust0706',
            text:'供货商导入',
            url: '/cust/supperlierManager/supperliersImport?MENU_CODE=cust0706'
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

#showProductDetailDiv {
    display: none;
}

#hrSearchEmp {
    margin-top: 5px;
}

#add {
    margin-left: 10px;
    text-align: left;
    line-height: 20px;
    height: 20px;
    font-weight: bold;
}

table .text {
    padding: 3px 0px 3px 3px;
}

table .text1 {
    text-align: center;
    font-size: 12px;
    line-height: 2px;
    padding-left: 5px;
    background-color: #c1dcfa;
    color: #12436b;
    font-family: serif;
}

table .SUPPLIER_DESCRIPTION {
    border-color: #c1dcfa;
    border: 1px solid #c1dcfa;
    font-size: 12px;
}

table .SUPPLIER {
    width: 200px;
    height: 20px;
    line-height: 20px;
    border: 1px solid #c1dcfa;
    font-size: 12px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="0xp" bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t" width="15%"><spring:message code="keyWord" /></td>
                    <td class="l-table-edit-c" width="35%"><input type="text" name="keyWord" id="keyWord" class="SUPPLIER" title='<spring:message code="cust.enterSearch"/>'/></td>
                    <td></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_impExcel()">
                            <spring:message code="hrms.excelImport"/>
                        </a>
                    </td>
                </tr>
            </table>
            <div id="showProductDetailDiv">
                <div id="add">
                    <img src="/resources/images/title/top_1.gif" />&nbsp;&nbsp;&nbsp;&nbsp;<spring:message code="hrms.supplier"/><spring:message code="cust.infomation"/>
                </div>
                <form name="form1" method="post" action="" id="form1">
                    <input type="hidden" id="SUPPLIER_NO" name="SUPPLIER_NO" />
                    <table width="99%" align="center" cellpadding="1" cellspacing="1" class="l-table-edit_01" bordercolor="#A3C0E8">
                        <tr>
                            <td class="text1" width="15%"><spring:message code="cust.supplierName"/><font color="red">*</font></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_NAME" id="SUPPLIER_NAME" class="SUPPLIER" style="width: 180px;" /></td>
                            <td class="text1" width="15%"><spring:message code="hrms.type"/><font color="red">*</font></td>
                            <td class="text" width="25%"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" limit="all" /></td>
                        </tr>
                        <tr>
                            <td class="text1" width="15%"><spring:message code="hrms.contact"/><font color="red">*</font></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_CONTACTS" id="SUPPLIER_CONTACTS" class="SUPPLIER" style="width: 180px;" /></td>
                            <td class="text1" width="15%"><spring:message code="hrms.phone1"/><font color="red">*</font></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_PHONE2" id="SUPPLIER_PHONE2" class="SUPPLIER" style="width: 180px;" /></td>
                        </tr>
                        <tr>
                            <td class="text1" width="15%"><spring:message code="hrms.telephone"/></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_PHONE1" id="SUPPLIER_PHONE1" class="SUPPLIER" style="width: 180px;" /></td>
                            <td class="text1" width="15%"><spring:message code="cust.email"/></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_EMAIL" id="SUPPLIER_EMAIL" class="SUPPLIER" style="width: 180px;" /></td>
                        </tr>
                        <tr>
                            <td class="text1" width="15%"><spring:message code="hrms.address"/></td>
                            <td class="text" width="25%"><input type="text" name="SUPPLIER_ADDRESS" id="SUPPLIER_ADDRESS" class="SUPPLIER" style="width: 320px;" /></td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                            <td class="text1" width="15%"><spring:message code="prostor.storage.remark"/></td>
                            <td class="text" width="25%" colspan="3"><textarea rows="3" cols="55" name="SUPPLIER_DESCRIPTION" id="SUPPLIER_DESCRIPTION" class="SUPPLIER_DESCRIPTION"></textarea></td>
                        </tr>
                    </table>
                </form>
                <p style="padding: 5px 0 5px 82%">
                    <a class="l-button" style="width: 79px; height: 20px; float: left; margin-right: 10px;" onclick="spf_clear()"><spring:message code="cancel"/></a> <a
                        class="l-button" style="width: 79px; height: 20px; margin-right: 10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>
                </p>
            </div>
        </div>
        <div id="hrSearchEmp"></div>
    </div>
</body>
</html>