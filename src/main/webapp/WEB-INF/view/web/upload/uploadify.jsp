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
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
    <script type="text/javascript">
    var $dialog ;
    $(function ()
	  {
	  	   $("#showID").hide();
       	   $("#inputID").show();
	 	     //布局
	       $("#layout1").ligerLayout({   
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
	  		                	var showImage=
	  		                	"<table align=\"center\" cellpadding=\"0\" cellspacing=\"0\" class=\"l-table-edit_01\" border=\"1xp\" bordercolor=\"#A3C0E8\">"+
	  		                		"<tr><td width=\"100\" height=\"120\" class=\"l-table-edit-c\">"+
	  		                		" <img src=\"/resources/photo/${paraMap.EMPID}.jpg\"   width=\"100\" height=\"120\"/></td></tr>"+
	  		                	"</table>";	  		                		  		                		  		              	  		                	
		  		       	  	   //showImage里面的HTML是显示图片
	  		                	$("#inputID").hide();
		  		       	  	   	$("#showID").html(showImage);
		  		         	   	$("#showID").show("slow");
		  		         	 	$("#uploadSuccess").html('<spring:message code="hrms.saveSuccess"/>');
		  		         	   	$("#uploadSuccess").show();
	  		                
	  		            }
	  		            else
	  		            {
	  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', 'Error!');
		  		       	  	   $("#inputID").show();
		  		         	   $("#showID").hide();
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
        return true;
    }
    

    
</script>
	
	<style type="text/css"> 
        body{ padding:30px 45px; margin:0; padding-bottom:15px; }
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>	 
</head>
<body>  

	<p>
	<img id="image" alt="" src="">
	</p>				  
	<form name="form1" method="post" action="" id="form1"  enctype="multipart/form-data">

		<div id="inputID">
		<table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
          <tr>  
          	   <td width="10%" class="l-table-edit-c" rowspan="6">
			<input type="file" name="file" id="file" class="l-button"/>
	
			<input type="hidden" name="EMPID" id="EMPID" value="${paraMap.EMPID}" /> 
			<br>	
			<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>  
			</td>  
        </tr>
        
        </table>
		</div> 
		<div id="uploadSuccess"></div>
		<div id="showID"></div>
	</form>   



</body>
</html>
