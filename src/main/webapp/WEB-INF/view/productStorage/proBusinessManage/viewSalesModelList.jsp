<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage=""%>
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
    });

    function f_initGrid() {
        $grid = $("#hrSearchEmp").ligerGrid({
            columns : [ 
                        {display : '',name : 'SALES_MODE_NO',width : '80',hide:true,frozen:true},
                        {display : '',name : 'SALES_MODE_ID',width : '100',frozen:true,hide:1},
                        {display : '<spring:message code="hrms.salesMode"/>',name : 'SALES_MODE_NAME',width : '160',frozen:true},
                        {display : '<spring:message code="hrms.description"/>',name : 'REMARK',width : '200',frozen:true,editor: { type: 'textarea', height: 100 }},
                        {display : '<spring:message code="hrms.active"/>',name : 'STATUS',width : '100',frozen:true,
                            render : function(item) {
                                if(item.STATUS == 0){
                                    return '<p style="color: red;"><spring:message code="hrms.disable"/></p>';
                                }else{
                                    return '<p style="color: green;"><spring:message code="hrms.enable"/></p>';
                                }
                            }
                        }
                ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            url : "/productStorage/proBusinessManage/getSalesModelList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            onDblClickRow:showSalesModelDetail
        });
    }
    
    function showSalesModelDetail(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        spf_add();
        $("#SALES_MODE_NO").val(row.SALES_MODE_NO);
        $("#SALES_MODE_NAME").val(row.SALES_MODE_NAME);
        $("#REMARK").val(row.REMARK);
        $("#STATUS_IN").val(row.STATUS);
    }
    
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()},
                        {name:'STATUS',value : $("#STATUS").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }

    function spf_add(){
        $("#showProductDetailDiv input,select").val("");
        $("#showProductDetailDiv").show(500);
    }
    
    function spf_clear(){
        $("#showProductDetailDiv input,select").val("");
        $("#showProductDetailDiv").hide(500);
    }

    function f_saveOrUpdate(){
        if($("#SALES_MODE_NAME").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.salsModel.cannotbe.empty"/>') ;
            return ;
        }
        if($("#STATUS_IN").val() == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selectState"/>') ;
            return ;
        }
        if(true){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url:'/productStorage/proBusinessManage/addOrUpdateSalesModel',
                type:'POST',
                success: function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                        spf_clear();
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
        }else{
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', 'Send Error');
        }
    }
    
    function spf_update(){
        showSalesModelDetail();
    }

    function spf_delete(){
        var rows = $grid.getSelectedRows(); 
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>',
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
                         jsonData += ' "SALES_MODE_NO": "' + this.SALES_MODE_NO + '",';
                         jsonData += ' "SALES_MODE_ID": "' + this.SALES_MODE_ID + '"';
                         jsonData += '}' ;
                    }); 
                    jsonData += ']' ;  
                    if(jsonData.length == 2){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                        return ;
                    } 
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/productStorage/proBusinessManage/deleteSalesModel", 
                        [   
                            { name: 'jsonData', value: jsonData }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid.loadData(true); //加载数据 
                                    $("#showProductDetailDiv input,select").val("");
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
#hrSearchEmp{
    margin-top:5px;
}
select{
    width:120px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <table width="99.6%" align="center" cellpadding="0"
                cellspacing="0" class="l-table-edit_01" border="1xp"
                bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t" width="15%">
                        <spring:message code="keyWord"/></td>
                    <td class="l-table-edit-c" width="35%">
                        <input type="text" name="keyWord" id="keyWord" style="width:120px;"/></td>
                    <td class="l-table-edit-t" width="15%">
                        <spring:message code="hrms.active"/></td>
                    <td class="l-table-edit-c" width="35%">
                        <SipingSoft:selectStatus name="STATUS" limit="all" onChange="spf_search()"/></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                    </td>
                </tr>
            </table>
            
            <div id = "showProductDetailDiv">
                <form name="form1" method="post" action="" id="form1">
                    <input type="hidden" id="SALES_MODE_NO" name="SALES_MODE_NO"/>
                    <table width="99%" align="center" cellpadding="0"
                        cellspacing="0" class="l-table-edit_01" border="1xp"
                        bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.salesMode"/></td>
                            <td class="l-table-edit-c" width="20%">
                                <input type="text" name="SALES_MODE_NAME" id="SALES_MODE_NAME" style="width:120px;"/></td>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.active"/></td>
                            <td class="l-table-edit-c" width="20%">
                                <SipingSoft:selectStatus name="STATUS_IN" limit="all"/> </td>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.description"/></td>
                            <td class="l-table-edit-c" width="30%">
                                <input type="text" name="REMARK" id="REMARK" style="width:200px;"/></td>
                        </tr>
                    </table>
                </form>
                <table width="99%" align="center">
                    <tr>
                        <td height="30">
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right;"
                                onclick="f_saveOrUpdate()"><spring:message code="hrms.save"/></a>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right; margin-right: 10px;"
                                onclick="spf_clear()"><spring:message code="cancel"/></a>
                        </td>
                    </tr>
                </table>
            </div>
            
        </div>
        <div id="hrSearchEmp"></div>
    </div>
</body>
</html>
