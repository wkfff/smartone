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
<script src="/resources/js/My97DatePicker/WdatePicker.js"  type="text/javascript"></script>
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

    $().ready(function(){
        
         $("*[name='ACTIVITY']").css({border:"1px solid #c1dcfa"});
        $("*[name='ACTIVITY']").width(200);
        
        //对单位下拉列表框的格式化
        $("*[name='UNIT_CODE_ID']").css({border:"1px solid #c1dcfa"});
        $("*[name='UNIT_CODE_ID']").width(200); 
        
        $("*[name='STATUS']").css({border:"1px solid #c1dcfa"});
        $("*[name='STATUS']").width(200); 
        f_initGrid1();
        $("#showSuppolierProduct").hide();
        select_supplier();
    });
    
    function f_initGrid1()
    {
        $grid=$("#shopList").ligerGrid({
            columns : [
                      {display : '商品编码',name : 'PRODUCT_ID',width : '10%'} ,
                      {display : '商品名称',name : 'PRODUCT_NAME',width : '20%'},
                      {display : '供货商',name : 'SUPPLIER_NAME',width : '20%'},
                      {display : '规格',name : 'SPECIFICATION',width : '10%'},
                      {display : '单价(元)',name : 'UNIT_PRICE',width : '10%'},
                      {display : '单位',name : 'UNIT_CODE',width : '10%'},
                      {display : '商品类型',name : 'CATEGORY_NAME',width : '10%'},
                      {display : '状态',name : 'ACTIVITY',width : '10%',render:function(item){
                          if(item.ACTIVITY==0){
                                return '不可用'
                              }else{
                                return '可用';
                              }
                      }},
                      {display : '创建者',name : 'CREATED_USERNAME',width : '10%'},
                      {display : '更新者',name : 'UPDATED_USERNAME',width : '10%'}
                      ],
            enabledEdit: false,
            usePager: true,
            rownumbers: true,
            isScroll: true,
            url : "/cust/supperlierProductManager/getSupplierProductList",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.8%',
            height: '100%'
        });
    }
    
    function spf_add()
    {
        $("#PRODUCT_ID").attr("disabled","");
        $("#showSuppolierProduct input").val("");
        $("*[name='ACTIVITY']").val(1);
        $("*[name='UNIT_CODE_ID']").val("");
        $("#showSuppolierProduct").show(500);
    }
    
    function showSuppolierProduct(){
        var row=$grid.getSelectedRow() ;
        if(!row||row.length==0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $("#PRODUCT_ID").attr("disabled","disabled");
        $("#showSuppolierProduct").show(500);
        $("#PRODUCT_NO").val(row.PRODUCT_NO);
        $("#SUPPLIER").val(row.SUPPLIER_NO);
        $("#PRODUCT_ID").val(row.PRODUCT_ID);
        $("#PRODUCT_NAME").val(row.PRODUCT_NAME);
        $("#ACTIVITY").val(row.ACTIVITY);
        $("#PRODUCT_CATEGORY_ID").val(row.PRODUCT_CATEGORY_ID);
        $("#PRODUCT_CATEGORY_IDtree").val(row.CATEGORY_NAME);
        $("#SPECIFICATION").val(row.SPECIFICATION);
        $("#UNIT_PRICE").val(row.UNIT_PRICE);
        $("#UNIT_CODE_ID").val(row.UNIT_CODE_ID);
    }
    
    function spf_update(){
        showSuppolierProduct();
    }

    function spf_checkData()  //Reserved
    {
        if ($("#SUPPLIER").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','请选择供货商！');
            return false;
       }
        if ($("#PRODUCT_ID").val() == null || $("#PRODUCT_ID").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '商品编号不能为空'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#PRODUCT_NAME").val() == null || $("#PRODUCT_NAME").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '货品名称不能为空'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#PRODUCT_CATEGORY_ID").val() == null || $("#PRODUCT_CATEGORY_ID").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '货品类别不能为空'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }

        if($("#UNIT_PRICE").val()==null||$("#UNIT_PRICE").val()==""||isNaN($("#UNIT_PRICE").val())||$("#UNIT_PRICE").val()<0){
            $.ligerMessageBox.warn( '<spring:message code="hrms.warning"/>','请输入一个正确的货品单价')
            return false;
        }

        if($("#UNIT_CODE_ID").val()==null||$("#UNIT_CODE_ID").val()=="")
        {
            $.ligerMessageBox.warn( '<spring:message code="hrms.warning"/>','请选择货品单位'+". " + '<spring:message code="input.required"/>')
            return false;
        }  
            
        return true;
    }

    function spf_save()
    {
        if(!spf_checkData())
            {
                return;
            }
        if(true){
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        var options={
                url:'/cust/supperlierProductManager/addOrUpdateSupplierProduct',
                type:'POST',
                success:function(result)
                {
                    $.ligerDialog.closeWaitting();
                    if(result=="Y")
                        {
                            $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                            spf_add();
                            $("#showSuppolierProduct").hide(500);
                            $grid.loadData(true);
                        }
                    else
                        {
                            $.ligerDialog.error('该商品编号已经存在');
                        }
                },
                error:function()
                {
                    alert("wrong");
                }
        };
        $('#form1').ajaxSubmit(options);
        }else
            {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
            }
    }
    function spf_clear()
    {
        $("#showSuppolierProduct").hide(500);
    }
    
    function spf_search() {
       
         $grid.setOptions({
                parms : [
                            {name:'keyWord',value : $("#keyWord").val()},
                            {name:'STATUS',value : $("*[name='STATUS']").val()}
                        ],
                newPage:1
            }); 
            $grid.loadData(true);
        }
    
    function spf_delete()
    {
            var rows=$grid.getSelectedRows();
            if(!rows||rows.length==0)
                {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
                return;
                }
            $.ligerDialog.confirm('你确定要删除数据吗?','<spring:message code="hrms.warning"/>',function(yes)
                {
                if(yes)
                {
                    var jsonData='[';
                    $(rows).each(function(index,row){
                        if(jsonData.length>1)
                            {
                                jsonData+=',{';
                            }
                        else
                            {
                                jsonData+='{';
                            }
                        jsonData+='"PRODUCT_NO":"'+this.PRODUCT_NO+'",';
                        jsonData+='"SUPPLIER":"'+this.SUPPLIER_NO+'"';
                        jsonData+='}';
                    });
                    jsonData+=']';
                    if(jsonData.length==2)//表示选择的是空行
                    {
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.editData"/>');
                            return;
                    }
                    //就弹出等待框
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/cust/supperlierProductManager/deleteSupplierProduct",{jsonData:jsonData},function(result){
                        $.ligerDialog.closeWaitting();
                        if(result=="Y")
                            {
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>',function(){
                                    $grid.loadData(true);
                                })
                            }
                        else
                            {
                                $.ligerMessageBox.error('<spring:message code='hrms.warning'/>',result);
                            }
                    });
                }
            });
   }

    function select_supplier(){
        $.ajax({
            type:'post',
            cache : false,
            async : false,
            contentType : 'application/json',
            url : '/productStorage/proStorageManage/getSupplierList',
            dataType : 'json',
            success : function(data) {
                var temp = '<option value=""><spring:message code="hrms.selection"/></option>';
                $.each(
                    data.Rows,
                    function(i, item) {
                        temp = temp + "<option value='"+item.SUPPLIER_NO+"'>"+item.SUPPLIER_NAME+"</option>";
                    }
                );
                $("#SUPPLIER").html(temp);
            },
            error : function() {
                $.ligerDialog.error('还没有添加供货商！');
            }
        });
    }
</script>
<style type="text/css">
table .text
{
    padding: 3px 0px 3px 3px;
    
}
#main table tr #keyWord
{
border:1px solid #c1dcfa;
width:180px;
line-height: 20px;
height: 20px;
}
#add
{
    margin-left: 10px;
    text-align: left;
    line-height:30px;
    height:30px;
    font-weight: bold;
}
#showSuppolierProduct table .content
{
    padding: 3px 0px 3px 3px;
    
}
#showSuppolierProduct table .title
{
    text-align:center;
    font-size:12px;
    height:20px;
    line-height:20px;
    padding-left: 5px;
    background-color: #c1dcfa;
    color: #12436b;
    font-family: serif;
    
}
#showSuppolierProduct table .input
{
    width: 200px;
    height: 20px;
    line-height:20px;
    border: 1px solid #c1dcfa;
    font-size:12px;
    
} 
#showSuppolierProduct{
display: block;

}
#showSuppolierProduct   form table{
border: 1px solid #c1dcfa;

}
</style>
</head>
<body>
    <div id="main">
        <div>
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" border="1px"  bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t" width="15%">
                        <spring:message code="keyWord"/>
                    </td>
                    <td class="l-table-edit-c" width="35%">
                        <input type="text" name="keyWord" id="keyWord" title="可输入商品、供货商名称关键字进行搜索"/>
                    </td>
                    <td class="l-table-edit-t" width="15%">状态</td>
                    <td class="l-table-edit-c" width="35%">
                        <SipingSoft:selectStatus name="STATUS" limit="all" onChange="spf_search()"/>
                    </td>
                </tr>
            </table>
            <!-- 这是对数据的增删查改 -->
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button/>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 这个是添加商品的详细信息表 -->
        <div id="showSuppolierProduct">
            <div id="add"><img src="/resources/images/title/top_1.gif" />&nbsp;&nbsp;&nbsp;&nbsp;供货商添加商品</div>
            <form action=""  name="form1" method="post" id="form1">
                <input type="hidden" name="PRODUCT_NO" id="PRODUCT_NO" />
                <table width="99%" align="center" cellpadding="1" cellspacing="1" bordercolor="#A3C0E8" >
                    <tr>
                        <td class="title" width="15%">供货商<font color="red">*</font></td>
                        <td class="content" width="25%">
                            <select id="SUPPLIER" name="SUPPLIER" style="width:200px;height:20px;font-size: 10px;">
                                <option value=""><spring:message code="hrms.selection"/></option>
                            </select>
                        </td>
                        <td class="title" width="15%">商品编号<font color="red">*</font></td>
                        <td class="content" width="25%">
                            <input type="text" name="PRODUCT_ID" id="PRODUCT_ID" class="input"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title" width="15%">名称<font color="red">*</font></td>
                        <td class="content" width="25%">
                            <input type="text" name="PRODUCT_NAME" id="PRODUCT_NAME" class="input"/>
                        </td>
                    <td class="title" width="15%">状态</td>
                        <td class="content" width="25%">
                            <SipingSoft:selectStatus name="ACTIVITY" selected="1"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title" width="15%">类别<font color="red">*</font></td>
                        <td class="content" width="25%">
                            <SipingSoft:categoryTree name="PRODUCT_CATEGORY_ID"/>
                             <!-- <input type="text" name="PRODUCT_CATEGORY_ID" id="PRODUCT_CATEGORY_ID" class="input"/> -->
                        </td>
                        <td class="title" width="15%">规格</td>
                        <td class="content" width="25%">
                        <input type="text" name=SPECIFICATION id="SPECIFICATION" class="input"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="title" width="15%">单价<font color="red">*</font></td>
                        <td class="content" width="25%">
                            <input type="text" name="UNIT_PRICE" id="UNIT_PRICE" class="input"/> 
                        </td>
                        <td class="title" width="15%">单位</td>
                        <td class="content" width="25%">
                        <SipingSoft:selectProductUnit name="UNIT_CODE_ID"/>
                        </td>
                    </tr>
                </table>
            </form>
            <p style="padding:5px 0 5px 82%">
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: left; margin-right: 10px; "
                                onclick="spf_clear()">取消</a>
                                 <a class="l-button"
                                style="width: 79px; height: 20px; margin-right: 10px; "
                                onclick="spf_save()">保存</a>
           </p>
        </div>
        <div id="shopList"></div>
    </div>
</body>
</html>