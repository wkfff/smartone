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
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
var $grid;
var $grid_detail;
var tab = parent.tab;
$(function() {
    f_initGrid();
});
//扩展一个 多行文本框 的编辑器
$.ligerDefaults.Grid.editors['textarea'] = {
    create: function(container, editParm) {
        var input = $("<textarea class='l-textarea' />");
        container.append(input);
        return input;
    },
    getValue: function(input, editParm) {
        return input.val();
    },
    setValue: function(input, value, editParm) {
        input.val(value);
    },
    resize: function(input, width, height, editParm) {
        var column = editParm.column;
        if (column.editor.width) input.width(column.editor.width);
        else input.width(width);
        if (column.editor.height) input.height(column.editor.height);
        else input.height(height);
    }
};
function f_initGrid(){
    $grid = $("#outStorHistory").ligerGrid({
        columns : [
                    {display : '出库单号',name : 'OUTSTORAGE_ID',width :'150'},
                    {display : '销售单编号',name : 'SALES_ORDER_ID',width :'150'},
                    {display : '金额',name : 'MONEY',width : '100'},
                    {display : '折扣',name : 'DISCOUNT',width : '60'},
                    {display : '折后金额',name : 'DIS_MONEY',width : '100'},
                    {display : '客户名称',name : 'CUST_NAME',width : '150'},
                    {display : '出库时间',name : 'OUT_DATE',width : '150'},
                    {display : '出库员',name : 'OPERATOR',width : '90'},
                    {display : '备注',name : 'REMARKS',width : '250',editor:{type:'textarea',height:'60'}}
            ],
        usePager : true,
        rownumbers : false,
        enabledEdit: true,
        isScroll :true,
        url : "/productStorage/proStorageManage/viewOutStorHistoryList",
        width:'99.8%',
        height:'100%',
        detail : {
            onShowDetail:spf_showHistoryDetail,
            height : 'auto'
        }
    });
}
function spf_showHistoryDetail(row,detailPanel){
    var div = document.createElement('div');
    $(detailPanel).append(div);
    $grid_detail = $(div).css('margin', 10).ligerGrid({
        columns : [
                    {display : '存货编号',name : 'PRODUCT_ID',width :120},
                    {display : '存货名称',name : 'PRODUCT_NAME',width :120},
                    {display : '规格/质量',name : 'SPECIFICATION',width :80},
                    {display : '单位',name : 'UNIT_NAME',width :80},
                    {display : '单价',name : 'PRICE',width :80},
                    {display : '出库量',name : 'QUANTITY',width : 100},
                    {display : '金额',name : 'MONEY',width :120},
                    {display : '折扣',name : 'DISCOUNT',width :60},
                    {display : '折后金额',name : 'DIS_MONEY',width :120},
                    {display : '出库仓',name : 'STORAGE_NAME',width : 90},
                    {display : '货位',name : 'STOR_ADDR',width : 120},
                    {display : '客户订单行号',name : 'CUST_LINE_NUM',width : 120},
                    {display : '客户商品编码',name : 'CUST_PRO_ID',width : 120}
            ],
        usePager : true,
        rownumbers : true,
        isScroll :true,
        width : '95%',
        parms: [
                {name: 'OUTSTORAGE_ID', value: row.OUTSTORAGE_ID}
               ],
        url : "/productStorage/proStorageManage/viewOutStorHistoryDetail"
    });
}
function spf_search(){
    $grid.setOptions({
        parms : [
                    {name:'keyWord',value : $("#keyWord").val()},
                    {name:'FROM_DATE',value : $("#FROM_DATE").val()},
                    {name:'TO_DATE',value : $("#TO_DATE").val()}
                ],
        newPage:1
    });
    $grid.loadData(true);
}
function spf_clear(){
    $("#keyWord").val("");
    $("#FROM_DATE").val("");
    $("#TO_DATE").val("");
}
function spf_export(){
    var row = $grid.getSelectedRow();
    if (!row || row.length == 0) {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
        return;
    }
    location.href='/productStorage/proStorageManage/exportOutStorInfo?OUTSTORAGE_ID=' + row.OUTSTORAGE_ID+
                      '&SALES_ORDER_ID='+row.SALES_ORDER_ID+
                      '&CUST_NAME='+row.CUST_NAME+
                      '&OUT_DATE='+row.OUT_DATE+
                      '&REMARKS='+row.REMARKS+
                      '&DISCOUNT='+row.DISCOUNT+
                      '&OPERATOR='+row.OPERATOR;
}
//进入出库单打印界面
function spf_printPreview() {
    var row = $grid.getSelectedRow();
    if (!row || row.length == 0) {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
        return;
    } 
    var id = row.OUTSTORAGE_ID;
    
    if (tab.isTabItemExist('prosto0110')) {
        tab.removeTabItem('prosto0110');
    }
    tab.addTabItem({
        tabid:'prosto0110',
        text:'出库单打印预览',
        url: '/productStorage/proStorageManage/viewOutstorageOrderPreview?OUTSTORAGE_ID='+id
    });
}
</script>
<style type="text/css">
body{
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}
</style>
</head>
<body>
    <div style="width:99.8%">
        <table width="100%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" bordercolor="#A3C0E8">
            <tr>
                <td class="l-table-edit-t" width="15%"><spring:message code="keyWord"/></td>
                <td class="l-table-edit-c" width="35%"><input type="text" name="keyWord" id="keyWord" style="width:150px;" 
                    class="showTips" title="可输入出库流水号、销售单编号、客户名称、操作员姓名关键字进行搜索"/></td>
                <td class="l-table-edit-t">出库时间</td>
                <td class="l-table-edit-c">
                    <input type="text" name="FROM_DATE" id="FROM_DATE" style="width:150px;"
                        onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                        readonly="readonly" />~
                    <input type="text" name="TO_DATE" id="TO_DATE" style="width:150px;"
                        onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                        readonly="readonly" />
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
            <tr>
                <td>
                    <a class="l-button" style="width: 79px; height: 20px; float: right;" onclick="spf_search()">搜索</a>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td>
                    <a class="l-button" style="width: 79px; height: 20px; float: right;" onclick="spf_clear()">清空</a>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td>
                    <a class="l-button" style="width: 79px; height: 20px; float: right;" onclick="spf_export()">Excel导出</a>
                </td>
                <td>&nbsp;&nbsp;</td>
                <td>
                    <a class="l-button" style="width: 79px; height: 20px; float: right;" onclick="spf_printPreview()"><spring:message code="hrms.printPreview"/></a>
                </td>
            </tr>
        </table>
        <div id="outStorHistory"></div>
    </div>
</body>
</html>