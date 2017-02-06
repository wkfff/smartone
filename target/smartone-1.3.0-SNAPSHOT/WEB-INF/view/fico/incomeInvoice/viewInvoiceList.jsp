<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!BOMTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $grid = null ; 
    var $returnTypeSelectList ;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm)
        {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm)
        {
            return input.val();
        },
        setValue: function (input, value, editParm)
        {
            input.val(value);
        },
        resize: function (input, width, height, editParm)
        {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    $(function ()
    {
    	//布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    });
    
    function f_initGrid()
    {
    	$grid = $("#invoiceInfo").ligerGrid({
    		columns: [
			            { display: '款项收入编号', name: 'INVOICE_NO', width: 90, frozen:true },
			            { display: '主题', name: 'SUBJECT', width: 90, frozen:true},
						{ display: '账号', name: 'ACCOUNT_ID', width: 90},
						{ display: '应收账款', name: 'PAYABLE_AMOUNT', width: 90},
						{ display: '已收账款', name: 'PAID_AMOUNT', width: 90},
						{ display: '类型', name: 'PAYMENT_TYPE_NAME', width: 90},
						{ display: '状态', name: 'BOM_STATUS', width:90},
						{ display: '开票日期', name: 'INVOICE_DATE', width: 90},
						{ display: '截止日期', name: 'DUE_DATE', width: 90},
						{ display: '支付日期', name: 'PAYMENT_DATE', width: 90},
						{ display: '客户', name: 'CUSTOMER_NAME', width:90},
			            { display: '详细信息',  width: 120,
			            	render: function (item)  
		                    { 
		                       return '<div style="cursor: pointer;" onClick="spf_viewInvoiceDetail(\''+item.INVOICE_NO+'\')">点此查看</div>';
		                    }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/fico/incomeInvoice/getInvoiceList',
            parms: [
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
            	spf_viewInvoiceDetail(rowdata.INVOICE_NO);
            }
        });
    }
    var tab = parent.tab;
    function spf_viewInvoiceDetail(INVOICE_NO){
    	if(tab.isTabItemExist('fico0202')){
    		tab.removeTabItem('fico0202');
    	}
        tab.addTabItem({ tabid : 'fico0202',text: '收入信息', url: '/fico/incomeInvoice/viewInvoiceDetail?MENU_CODE=fico0202&INVOICE_NO='+INVOICE_NO });
    }
    function spf_delete()
    {   
    	var	row = $grid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
		$dialog = $.ligerDialog.open({isDrag: false, 
     	    title:'删除记录', 
     		width: 420, 
     		height: 220, 
     		url: '/fico/incomeInvoice/removeInvoice?INVOICE_NO='+row.INVOICE_NO
    	});
    }
    
    function spf_add(){
    	if(tab.isTabItemExist('fico0203')){
    		tab.removeTabItem('fico0203');
    	}
        tab.addTabItem({ tabid : 'fico0203',text: '添加收入', url: '/fico/incomeInvoice/addInvoice?MENU_CODE=fico0203' });
    }
    
    function spf_update(){
    	var	row = $grid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
    	 if(tab.isTabItemExist('fico0204')){
	    		tab.removeTabItem('fico0204');
	    	}
	    tab.addTabItem({ tabid : 'fico0204',text: '编辑收入', url: '/fico/incomeInvoice/updateInvoice?MENU_CODE=fico0204&INVOICE_NO='+row.INVOICE_NO });
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
									{ name: 'keyWord', value: $("#keyWord").attr('value')},
									{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
									{ name: 'E_DATE', value: $("#E_DATE").attr('value')},  
									{ name: 'STATUS_ID', value: $("#STATUS_ID").attr('value')},
									{ name: 'PAYMENT_TYPE', value: $("#PAYMENT_TYPE").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
	function spf_afterRemove(){
		$dialog.close();
		$grid.loadData(true); //加载数据
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
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
						<td class="l-table-edit-t">开票日期</td>
						<td class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="15%" class="l-table-edit-t">支付类型</td>
						<td width="35%" class="l-table-edit-c">
							<SipingSoft:selectSyCode name="TYPE_ID" parentCode="PaymentTypeCode" onChange="spf_search()" limit="all"/>
						</td>
		 				<td width="15%" class="l-table-edit-t">状态</td>
						<td width="35%" class="l-table-edit-c">
							<SipingSoft:selectSyCode name="STATUS_ID" parentCode="invoiceStatusCode" onChange="spf_search()" limit="all"/>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='invoiceInfo'></div>
		</div>
	</div>
</body>
</html>
