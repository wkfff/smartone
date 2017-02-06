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
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
    var $grid ; 
    var tab = parent.tab;
    // 初始调用
    $(function (){
        //布局
        $("#layout1").ligerLayout({
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
        });
        initSuppliers();
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
        $grid = $("#shiftGroupInfo").ligerGrid({
            columns: [
                        { display: '', name: 'INSTORAGE_NO',width:10, hide:1},
                        { display: '入库单流水号', name: 'INSTORAGE_ID',width:150, align: 'center'},
//                        { display: '采购单流水号', name: 'PURCHASE_ORDER_ID',width:150, align: 'center'},
                        { display: '供货商', name: 'SUPPLIER_NAME', align: 'center',width: 150},
                        { display: '', name: 'SUPPLIER_NO', align: 'center',hide:1},
                        { display: '入库时间', name: 'IN_DATE',width:200, align: 'center'},
                        { display: '操作人', name: 'ENAME', align: 'center',width: 120},
                        { display: '状态', name: 'STATUS', align: 'center',width: 120,render: 
                            function(item){
                                if(item.STATUS == 1){
                                    return "完成";
                                }else{
                                    return "未完成";
                                }
                            }
                        }
                    ],
            enabledEdit: true, usePager: true,
            url: '/productStorage/proStorageManage/getInStorHistory',
            parms : [
                     {name:'STATUS',value : 2},
                     {name:'IS_PURCHASE',value : '${paraMap.IS_PURCHASE}'}
            ],
            width: '99.6%', height: '100%',
            showTitle: false,width:'99.6%',
            detail: { onShowDetail: spf_showDetailData,height:'auto' }
        });
    }

    function spf_showDetailData(row, detailPanel,callback){ 
        var grid = document.createElement('div'); 
        $(detailPanel).append(grid);
        $(grid).css('margin',10).ligerGrid({
            columns:[
                        { display: '货品编号', name: 'PRODUCT_ID',width:100 },
                        { display: '货物品名', name: 'PRODUCT_NAME' ,width:100},
//                        {display : '货号',name : 'PRODUCT_NUM',width :120},
                        {display : '规格',name : 'SPECIFICATION',width :80},
                        {display : '单价',name : 'UNIT_PRICE',width :80},
                        { display: '入库数量', name: 'QUANTITY',width:80,totalSummary:{type: 'sum'}},
                        { display: '单位', name: 'UNIT_NAME',width:80},
                        { display: '仓库', name: 'STORAGE_NAME',width:100}
                    ],
            usePager: false,rownumbers: true,
            isScroll: false, showToggleColBtn: false, width: '95%',
            url: '/productStorage/proStorageManage/showInStorDetail', 
            parms: [{ name: 'INSTORAGE_ID', value: row.INSTORAGE_ID}],
            showTitle: false, columnWidth: 360, 
            onAfterShowData: callback,allowUnSelectRow:true
        });
    }

    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()},
                        {name:'FROM_DATE',value : $("#FROM_DATE").val()},
                        {name:'END_DATE',value : $("#END_DATE").val()},
                        {name:'SUPPLIER_NO',value : $("#SUPPLIER").val()},
                        {name:'STATUS',value : 2},
                        {name:'IS_PURCHASE',value : '${paraMap.IS_PURCHASE}'}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    
    function initSuppliers(){
        $.ajax({
            type:'post',
            cache : false,
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
                $.ligerDialog.error('Send Error');
            }
        });
    }
    
    function spf_selectInStor(){
        return $grid.getSelectedRow();
    }
    </script>
<style type="text/css"> 
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div align="left" position="center" id='' title=' '>
            <div align="left">
                <table width="100%" align="center" cellpadding="0"
                    cellspacing="0" class="l-table-edit_01" border="1xp"
                    bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="15%">
                            <spring:message code="keyWord"/></td>
                        <td class="l-table-edit-c" width="35%">
                            <input type="text" name="keyWord" id="keyWord" style="width:150px;"/></td>
                        <td class="l-table-edit-t" width="15%">供货商</td>
                        <td class="l-table-edit-c" width="35%">
                            <select id="SUPPLIER" style="width:150px;height:22px;color:black;">
                                <option value=""><spring:message code="hrms.selection"/></option>
                            </select></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t">入库时间</td>
                        <td class="l-table-edit-c" colspan="3">
                            <input type="text" name="FROM_DATE" id="FROM_DATE" style="width:150px;"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                                readonly="readonly" />~
                            <input type="text" name="END_DATE" id="END_DATE" style="width:150px;"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
                                readonly="readonly" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left">
                            <a class="l-button"
                                style="width: 79px; height: 20px;margin-left:10px;float:left;"
                                onclick="spf_search()">搜索</a>
                        </td>
                    </tr>
                </table>
                <div id="shiftGroupInfo"></div>
            </div>
        </div>
    </div>
</body>
</html>