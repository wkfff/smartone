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
             $.post("/fico/invoice/transferInvoice", 
                     [	{ name: 'type', value: 'add'},
                        { name: 'ACCOUNT_ID', value: $("#ACCOUNT_ID").val()},
                        { name: 'CUSTOMER_ID', value: $("#CUSTOMER_ID").val()},
                        { name: 'PROJECT_ID', value: $("#PROJECT_ID").val()},
                        { name: 'PAYABLE_AMOUNT', value: $("#PAYABLE_AMOUNT").val()},
                        { name: 'SUBJECT', value: $("#SUBJECT").val()},
                        { name: 'DUE_DATE', value: $("#DUE_DATE").val()},
                        { name: 'PAYMENT_DATE', value: $("#PAYMENT_DATE").val()},
                        { name: 'TYPE_ID', value: $("#TYPE_ID").val()},
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
        if ($("#TYPE_ID").val() == null || $("#TYPE_ID").val() == "") {  
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
        if(tab.isTabItemExist('fico0103')){
	    		tab.removeTabItem('fico0103');
	    }
	    if(tab.isTabItemExist('fico0104')){
	    		tab.removeTabItem('fico0104');
	    }
	    tab.addTabItem({ tabid : 'fico0104',text: '编辑单据', url: '/fico/invoice/updateInvoice?MENU_CODE=fico0104&INVOICE_NO='+INVOICE_NO });
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
    
    /*** Select Project ***/
    function spf_selectProjectID(){
    	$('#PROJECT_ID').val('');
    	var $title;
    	var $url;
    	var $name;
    	$title = "选择项目";
    	$name = "projselector"+Math.random();
    	$url = "/utility/projInfo/viewProjectList";
    	
        $projchoosedialog = $.ligerDialog.open({ 
        	title: $title, 
        	name: $name,
        	width: 800, 
        	height: 400, 
        	url: $url, 
        	buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectProjectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectProjectCancel }
        	]
        });   
    }
    function spf_selectProjectOK(item, dialog)
    {
    	var fn=null;
    	fn = dialog.frame.spf_selectProject || dialog.frame.window.spf_selectProject; 
    	var data = fn();
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        }
    	$('#PROJECT_ID').val(data.PRO_NO);
    	$('#PROJECT_NAME').val(data.PRO_NAME_NAME);
        dialog.close();
    }
    function spf_selectProjectCancel(item, dialog)
    {
    	$('#PROJECT_ID').val('');
        dialog.close();
    }
    /** Select Project Finish **/
    
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
    
    