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
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	       
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
 
	      
    <script type="text/javascript">
    var $dialog ;
    $(function ()
	  {
	 	     //布局
	       $("#layout1").ligerLayout({ 
	        	 topHeight:140,  
	  	         allowLeftResize: false,      //是否允许 左边可以调整大小
	  	         allowRightResize: false,     //是否允许 右边可以调整大小
	  	         allowTopResize: false,      //是否允许 头部可以调整大小
	  	         allowBottomResize: false     //是否允许 底部可以调整大小
	        }
	       );  
	  });
  	
    function f_save(){
    	if(spf_checkData())
    	{
	    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	    	
	        var options = {	                        
	            url:'/upload/fileUpload/uploadPhoto',
	            type:'POST',	                        
	            success: function (result){
	            		$.ligerDialog.closeWaitting();
	  		            if (result == "Y")
	  		            {
	  		            	$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	  		                        {
	  		    		               	parent.spf_photo_ChildWindowClose() ;
	  		                        });
	  		            }
	  		            else
	  		            {
	  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '上传失败，原因：'+result);
	  		            }
	  		        }              
	            }; 
	        $('#form1').ajaxSubmit(options);
    	}
    }
    
    function spf_checkData()
    {     
        if ($("#EMPID").val() == null || $("#EMPID").val() == "") {       	 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.empid"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 $("#EMPID").focus()
	       	 return false; 
        } 
        if ($("#file").val() == null || $("#file").val() == "") { 
 	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.file"/>'+". " + '<spring:message code="input.required"/>') ; 
 	       	 return false; 
 	    } 
        var fileName = $("#file").val();
        var fileType = fileName.substring(fileName.lastIndexOf(".")+1).toUpperCase();
        if (fileType!="JPG"){
        	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '文件类型必须为jpg') ; 
	       	 return false;
        }        	
        return true;
    }
    

    
</script> 
<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }  
</style>	 
</head>
<body>  
<div id="layout1"> 
     <div position="top"> 			  
	<form name="form1" method="post" action="" id="form1"  enctype="multipart/form-data"> 
		<div id="inputID">	
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td valign="middle"> 
							<table width="99.6%" cellpadding="1" cellspacing="1" style="height:30px;font-size: 12px;">
					          <tr>  
					          	<td height="30px;" align="left">
					          	&nbsp;
					          	</td> 
					          	<td height="30px;" align="left">
									<input type="file" name="file" id="file" height="60px;" style="width: 320px;"/> 
									<input type="hidden" name="EMPID" id="EMPID" value="${paraMap.EMPID}" /> 
							    </td> 
					        </tr>  
					        <tr>    
					          	<td height="30px;" align="left">
					          	&nbsp;
					          	</td> 
					          	<td height="30px;"> 
					          		<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>  
			  					</td>  
					        </tr>         
					        <tr>    
					          	<td height="30px;" align="left">
					          	&nbsp;
					          	</td> 
					          	<td height="30px;"> 
									 <div align="left" style="font-weight: bold;">
										<a style="color:#ff0000">提示：上传格式为jpg，文件大小不要超过10MB。</a>
						 			</div>  
						        </td>  
					        </tr>                     
					        </table>
		       			</td>
			      	</tr>
			    </table>
		</div>  
	</form>   
</div> 
</div> 
</body>
</html>
