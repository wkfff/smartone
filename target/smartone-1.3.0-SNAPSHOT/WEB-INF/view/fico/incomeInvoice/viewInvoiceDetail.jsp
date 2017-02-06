<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!BOMTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<script src="/resources/js/function.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
    <%@ include file="/resources/js/pcc.jsp"%> 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
 	var $dialog = null;
 	var $positiongrid=null;
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
//初始化数据 
	$(function ()
	    {
	        //布局
	         $("#layout1").ligerLayout({  
	    	         allowLeftResize: false,      //是否允许 左边可以调整大小
	    	         allowRightResize: false,     //是否允许 右边可以调整大小
	    	         allowTopResize: false,      //是否允许 头部可以调整大小
	    	         allowBottomResize: false     //是否允许 底部可以调整大小
	          }
	         );
             spf_position_initGrid();
     });

   
/**************************************************** */

    function spf_position_initGrid()
    {
    	$positiongrid = $("#positionItemInfo").ligerGrid({
    		columns: [
    					{ display: '编号', name: 'POSITION_NO', width: 60},
						{ display: '单据号', name: 'INVOICE_NO', width: 60},
						{ display: '数量', name: 'AMOUNT', width: 90},
						{ display: '净值', name: 'PER_NET', width: 90},
						{ display: '增值税', name: 'VAT', width: 90},
						{ display: '净合计', name: 'NET_TOTAL', width: 120},
						{ display: '合计', name: 'TOTAL', width: 120},
						{ display: '备注', name: 'S_TEXT', width: 120},
						{ display: '创建日期', name: 'CREATE_DATE', width: 120}	
		            ],
            enabledEdit: false,rownumbers:true,resizable:false,
            fixedCellHeight:true,
            url: '/fico/incomeInvoice/getPositionList?INVOICE_NO=${invoiceDetail.INVOICE_NO}',
            usePager:false,
            parms: [
                   ],
            width: '99.6%', height: '100%'
        });
    }
    
    var tab = parent.tab;
      
    function spf_search()
    {
    	$positiongrid.setOptions({ parms: [
    	                           	{ name: 'BOM_ID', value: $("#BOM_ID").val()},
									{ name: 'CHANGE_NO', value: $("#CHANGE_NO").attr('value')},
									{ name: 'QUERY_DATE', value: $("#QUERY_DATE").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
    	$positiongrid.loadData(true); //加载数据
    }
</script>
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" style="width:99.6%;margin:0; padding:0;">
	<input hidden="hidden" type="text" name="BOM_ID" id="BOM_ID" value="${invoiceDetail.BOM_ID}" size="30"/>  
	<table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
		<tr>
			<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
			<td width="25%" align="left" style="font-weight: bold;">
				基本信息
			</td>
			<td width="5%" align="right">&nbsp;</td>
			<td align="right" height="30px;">
				<SipingSoft:button/>
			</td>
		</tr>
		</tr>
	</table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr> 
           <td width="20%" class="l-table-edit-t">单据编号</td>
           <td width="30%" class="l-table-edit-c">
               ${invoiceDetail.INVOICE_NO}
     	   </td>
    	   <td width="20%" class="l-table-edit-t">账户</td>
       	   <td width="30%" class="l-table-edit-c">
     	    	${invoiceDetail.ACCOUNT_ID} 
    	   </td>
      </tr>
      <tr>
     	   <td width="20%" class="l-table-edit-t">应付账款</td>
       	   <td width="30%" class="l-table-edit-c">
       	       ${invoiceDetail.PAYABLE_AMOUNT}
       	   </td>
     	   <td width="20%" class="l-table-edit-t">开单日期</td>
       	   <td width="30%" class="l-table-edit-c">
               ${invoiceDetail.INVOICE_DATE}
     	   </td>
       </tr>
      <tr>
      <tr>
     	   <td width="20%" class="l-table-edit-t">截止日期</td>
       	   <td width="30%" class="l-table-edit-c">
       	       ${invoiceDetail.DUE_DATE}
       	   </td>
     	   <td width="20%" class="l-table-edit-t">支付日期</td>
       	   <td width="30%" class="l-table-edit-c">
               ${invoiceDetail.PAYMENT_DATE}
     	   </td>
       </tr>
      <tr>
     	   <td width="20%" class="l-table-edit-t">单据类型</td>
       	   <td width="30%" class="l-table-edit-c">
       	       ${invoiceDetail.PAYMENT_TYPE_NAME}
       	   </td>
     	   <td width="20%" class="l-table-edit-t">单据状态</td>
       	   <td width="30%" class="l-table-edit-c">
               ${invoiceDetail.STATUS_NAME}
     	   </td>
       </tr>
       <tr>
           <td width="20%" class="l-table-edit-t">客户</td>
           <td width="30%" class="l-table-edit-c">
              ${invoiceDetail.CUSTOMER_NAME}
     	   </td>
     	   <td width="20%" class="l-table-edit-t">项目</td>
           <td width="30%" class="l-table-edit-c">
              ${invoiceDetail.PROJECT_NAME}
     	   </td>
       </tr>
       <tr>
            <td width="20%" class="l-table-edit-t">单据主题</td>
        	<td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3">  
               <textarea rows="2" cols="90" id="SUBJECT" name="SUBJECT">${invoiceDetail.SUBJECT}</textarea>
     	   </td>
       </tr>
       <tr>
            <td width="20%" class="l-table-edit-t">单据描述</td>
        	<td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3">  
               <textarea rows="2" cols="90" id="COMMENTS" name="COMMENTS">${invoiceDetail.COMMENTS}</textarea>
     	   </td>
       </tr>
    </table>

    <!-- 文件列表 -->
	<table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
		<tr>
			<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
			<td width="25%" align="left" style="font-weight: bold;">
				支付清单
			</td>
			<td width="5%" align="right">&nbsp;</td>
			<td align="right" height="30px">
			</td>
		</tr>
	</table>
    <div id="positionItemInfo">
</div>
</body>
</html>
