<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!TYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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
    
    <!-- FICO JS -->
    <script type="text/javascript">
  //初始化数据 
	var $accochoosedialog;
	var $projchoosedialog;
	var $custchoosedialog;
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
	    });
	    
    var tab = parent.tab;
    
    function spf_save() {
    	if(spf_checkData()){
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post("/fico/incomeInvoice/transferInvoice", 
                     [	{ name: 'type', value: 'add'},
                        { name: 'ACCOUNT_ID', value: $("#ACCOUNT_ID").val()},
                        { name: 'CUSTOMER_ID', value: $("#CUSTOMER_ID").val()},
                        { name: 'REFERENCE', value: $("#REFERENCE").val()},
                        { name: 'PAYABLE_AMOUNT', value: $("#PAYABLE_AMOUNT").val()},
                        { name: 'SUBJECT', value: $("#SUBJECT").val()},
                        { name: 'DUE_DATE', value: $("#DUE_DATE").val()},
                        { name: 'PAYMENT_DATE', value: $("#PAYMENT_DATE").val()},
                        { name: 'PAYMENT_TYPE', value: $("#PAYMENT_TYPE").val()},
                      	{ name: 'STATUS_ID', value: $("#STATUS_ID").val()},
                      	{ name: 'COMMENTS', value: $("#COMMENTS").val()},
                      	{ name: 'INVOICE_DATE', value: $("#INVOICE_DATE").val()}
                      ]
             , function (result)
             {
             	$.ligerDialog.closeWaitting();
                 if (result.RESULT == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                     	spf_refresh(result.INVOICE_NO);
                     });
                 }
                 else
                 {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.REASON);
                 }
             });
    	}
     }
    function spf_checkData()  //Reserved
    {
        /* if ($("#ACCOUNT_ID").val() == null || $("#ACCOUNT_ID").val() == "") {  
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '账户编号'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }
        if ($("#PAYMENT_TYPE").val() == null || $("#PAYMENT_TYPE").val() == "") {  
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '类型'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }
        if ($("#STATUS_ID").val() == null || $("#STATUS_ID").val() == "") {  
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '状态'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
       } */
        return true;
    }
    
    function spf_refresh(INVOICE_NO){
        if(tab.isTabItemExist('fico0203')){
	    		tab.removeTabItem('fico0203');
	    }
	    if(tab.isTabItemExist('fico0204')){
	    		tab.removeTabItem('fico0204');
	    }
	    tab.addTabItem({ tabid : 'fico0204',text: '编辑单据', url: '/fico/incomeInvoice/updateInvoice?MENU_CODE=fico0204&INVOICE_NO='+INVOICE_NO });
    }
    
    /*** Select Account ***/
    function spf_selectAccountID(){
    	$('#ACCOUNT_ID').val('');
    	var $title;
    	var $url;
    	var $name;
    	$title = "选择账号";
    	$name = "accoselector"+Math.random();
    	$url = "/utility/fico/viewAccountList";
    	
        $accochoosedialog = $.ligerDialog.open({ 
        	title: $title, 
        	name: $name,
        	width: 800, 
        	height: 400, 
        	url: $url, 
        	buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectAccountOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectAccountCancel }
        	]
        });   
    }
    function spf_selectAccountOK(item, dialog)
    {
    	var fn=null;
    	fn = dialog.frame.spf_selectAccount || dialog.frame.window.spf_selectAccount; 
    	var data = fn();
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        }
    	$('#ACCOUNT_ID').val(data.ACCOUNT_NO);
    	$('#ACCOUNT_NAME').val(data.ACCOUNT_NAME);
        dialog.close();
    }
    function spf_selectAccountCancel(item, dialog)
    {
    	$('#ACCOUNT_ID').val('');
        dialog.close();
    }
    /** Select Account Finish **/
    
    /*** Select Customer ***/
    function spf_selectCustomerID(){
    	$('#CUSTOMER_ID').val('');
    	var $title;
    	var $url;
    	var $name;
    	$title = "选择客户";
    	$name = "custselector"+Math.random();
    	$url = "/utility/custInfo/viewCustomerList";
    	
        $custchoosedialog = $.ligerDialog.open({ 
        	title: $title, 
        	name: $name,
        	width: 800, 
        	height: 400, 
        	url: $url, 
        	buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectCustomerOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCustomerCancel }
        	]
        });   
    }
    function spf_selectCustomerOK(item, dialog)
    {
    	var fn=null;
    	fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer; 
    	var data = fn();
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        }
    	$('#CUSTOMER_ID').val(data.CUST_ID);
    	$('#CUSTOMER_NAME').val(data.CUST_NAME);
        dialog.close();
    }
    function spf_selectCustomerCancel(item, dialog)
    {
    	$('#CUSTOMER_ID').val('');
    	$('#CUSTOMER_NAME').val('');
        dialog.close();
    }
    /** Select Customer Finish **/
 </script>
    
    <%@ include file="/resources/js/pcc.jsp"%> 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" style="width:99.6%;margin:0; padding:0;">  
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
	</table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="20%" class="l-table-edit-t">主题<font color="red">*</font></td>
           <td width="30%" class="l-table-edit-c">
            	<input type="text" name="SUBJECT" id="SUBJECT" size="30"/>
           </td>
      	   <td width="20%" class="l-table-edit-t">账户<font color="red">*</font></td>
           <td width="30%" class="l-table-edit-c">
            	<input type="text" name="ACCOUNT_NAME" id="ACCOUNT_NAME" onClick="spf_selectAccountID();" size="30"/>
            	<input type="hidden" name="ACCOUNT_ID" id="ACCOUNT_ID" size="30"/>
           </td>    
      </tr>
      <tr> 
           <td width="20%" class="l-table-edit-t">支付类型<font color="red">*</font></td>
       	   <td width="30%" class="l-table-edit-c">
             <SipingSoft:selectSyCode parentCode="PaymentTypeCode" limit="all" name="PAYMENT_TYPE"/>
     	   </td>
     	   <td width="20%" class="l-table-edit-t">状态<font color="red">*</font></td>
       	   <td width="30%" class="l-table-edit-c">
             <SipingSoft:selectSyCode parentCode="InvoiceStatusCode" limit="all" name="STATUS_ID"/>
     	   </td>
     	   
      </tr>
      <tr>
           <td width="20%" class="l-table-edit-t">客户</td>
           <td width="30%" class="l-table-edit-c">   
              <input type="text" name="CUSTOMER_NAME" id="CUSTOMER_NAME" onClick="spf_selectCustomerID();" size="30"/>
              <input type="hidden" name="CUSTOMER_ID" id="CUSTOMER_ID" size="30"/>
     	   </td>
     	   <td width="20%" class="l-table-edit-t">参考</td>
           <td width="30%" class="l-table-edit-c">  
              <input type="text" name="REFERENCE" id="REFERENCE" size="30"/>
     	   </td>
       </tr>
       <tr>
     	   <td width="20%" class="l-table-edit-t">金额<font color="red">*</font></td>
           <td width="30%" class="l-table-edit-c" >   
              <input type="text" name="PAYABLE_AMOUNT" id="PAYABLE_AMOUNT" value="" size="30"/>
     	   </td>
     	          
     	   <td width="20%" class="l-table-edit-t">开票日期</td>
           <td width="30%" class="l-table-edit-c">
           <input type="text" name="INVOICE_DATE"
					id="INVOICE_DATE" value="" size="25"
					onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" />
           </td>
       </tr>    
       <tr>
           <td width="20%" class="l-table-edit-t">支付日期</td>
           <td width="30%" class="l-table-edit-c">
           <input type="text" name="PAYMENT_DATE"
					id="PAYMENT_DATE" value="" size="25"
					onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" />
           </td>
           <td width="20%" class="l-table-edit-t">截止日期</td>
           <td width="30%" class="l-table-edit-c">
           <input type="text" name="DUE_DATE"
					id="DUE_DATE" value="" size="25"
					onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
					readonly="readonly" />
           </td>
       </tr>
       <tr>
            <td width="20%" class="l-table-edit-t">描述</td>
            <td width="30%" class="l-table-edit-c" nowrap="nowrap" colspan="3" >  
                 <textarea rows="2" cols="90" id="COMMENTS" name="COMMENTS" ></textarea>
            </td>
       </tr>
    </table>

</div>
</body>
</html>
