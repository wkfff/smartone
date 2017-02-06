var $grid ;
var $dialog ; 

function spf_fpCheck(){
    if(spf_fpCheckData()){ 
       $.ligerDialog.waitting('检查中......');
       $.post("/ess/password/forgetPassword", 
               [	
                	{ name: 'USERNAME', value: $("#USERNAME").val() },
                	{ name: 'EMAIL', value: $("#EMAIL").val() }
               ] 
       , function (result)
       {
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('邮件已经成功发送，请注意查收','提示信息', function ()
               {   
		           parent.f_ChildWindowClose() ;
               });
           }
           else
           {
               $.ligerMessageBox.error('提示信息', result);
           }
       });  
    }
} 
function spf_fpCheckData()
{    
	var username = $("#USERNAME").val(); 
	var email = $("#EMAIL").val();   
	 
    if (username == null || username == "" || username == "请输入账户") { 
    	$.ligerMessageBox.warn('提示信息', '请输入账户信息') ; 
       	 return false; 
    } 
    if (email == null || email == "" || email == "请输入注册邮箱") {  
    	$.ligerMessageBox.warn('提示信息', '请输入有效的E-mail地址') ;
      	 return false; 
   }  
     
    return true; 
}

function spf_iniValue(id)
{   
	var username = $("#USERNAME").val(); 
	var email = $("#EMAIL").val(); 

    if (username == "请输入账户"&&id == "USERNAME") { 
    	$("#USERNAME").attr("value", "") ; 
    	return;
    } 
    if (email == "请输入注册邮箱"&&id == "EMAIL") {  
       	 $("#EMAIL").attr("value", "") ; 
         return; 
    }   
}
function spf_iniUsernameValue()
{   
	var username = $("#USERNAME").val(); 
 
    if (username == null||username == "") { 
    	$("#USERNAME").attr("value", "请输入账户") ; 
         return; 
    }  
}
function spf_iniEmailValue()
{   
	var email = $("#EMAIL").val(); 
 
    if (email == null||email == "") { 
    	$("#EMAIL").attr("value", "请输入注册邮箱") ; 
         return; 
    }  
}
function spf_checkemail()
{
    var email = $("#EMAIL").val();
    
    var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
    if(email.value!=""&&email.value!="请输入注册邮箱")
    {
        if(!myreg.test(email))
        {
        	$.ligerMessageBox.warn('提示信息', '请输入有效的E-mail地址') ;
        	$("#EMAIL").attr("value", "请输入注册邮箱") ; 
	       	return false;  
        } 
    }else{
    	$.ligerMessageBox.warn('提示信息', '请输入有效的E-mail地址') ;
    	$("#EMAIL").attr("value", "请输入注册邮箱") ; 
       	return false; 
    }
}

function spf_save(){
    if(spf_checkData()){ 
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/ess/password/updatePassword", 
               [	
                	{ name: 'ADMINID', value: $("#ADMINID").val() },
                	{ name: 'PASSWORD', value: $("#PASSWORD").val() },
                	{ name: 'NEW_PASSWORD', value: $("#NEW_PASSWORD").val() },
                	{ name: 'C_PASSWORD', value: $("#C_PASSWORD").val() }
               ] 
       , function (result)
       {
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="newPassword.okay.loginAgain"/>','<spring:message code="hrms.warning"/>', function ()
               {  
            	   location.href= "/login/out"; 
		           parent.f_ChildWindowClose() ;
               });
           }
           else
           {
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
           }
       });  
    }
} 
function spf_checkData()
{    
	var password = $("#PASSWORD").val(); 
	var newPassword = $("#NEW_PASSWORD").val(); 
	var cPassword = $("#C_PASSWORD").val(); 
	var oldPassword = $("#oldPassword").val(); 
		 
    if (password == null || password == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="current.password"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    } 
    if (password != oldPassword ) {  
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="current.password.error"/>') ; 
         $("#PASSWORD").attr("value", "") ; 
         return false; 
    } 
    if (newPassword == null || newPassword == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="new.password"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    } 
    if (cPassword == null || cPassword == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="confirmation.password"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }  
    if (newPassword != null && newPassword != ""
    		&& cPassword != null && cPassword != ""
    		&& newPassword != cPassword) { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="newPassword.confirmationPassword"/>') ; 
         $("#NEW_PASSWORD").attr("value", "") ; 
         $("#C_PASSWORD").attr("value", "") ; 
       	 return false; 
    } 

    if (newPassword != null || newPassword != "") { 
        if (newPassword.length < 6) { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="password6"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }
    } 
    return true; 
}    