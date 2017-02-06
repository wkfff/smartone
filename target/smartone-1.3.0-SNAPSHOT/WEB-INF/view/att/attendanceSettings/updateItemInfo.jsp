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

    function f_save(){ 

   	    $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');

        var options = {	                        
            url:'/att/attendanceSettings/updateItemInfo',
            type:'POST',	                        
            success: function (result)
        	{
        	$.ligerDialog.closeWaitting();
	            if (result == "Y")
	            {
	                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	                {
	                	parent.f_ChildWindowClose() ;
	                });
	            }
	            else
	            {
	                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	            }
	        }              
        }; 
        $('#form1').ajaxSubmit(options); 
    }
     
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }  
    </style>
</head>
<body style="padding:0px" > 
	  <div id = 'layout1'>
		     <form name="form1" method="post" action="" id="form1">
				       <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				            <tr>
				                <td width="15%" class="l-table-edit-t"><!-- 主键--><spring:message code="hrms.attItemCode"/></td>
				                <td width="35%" class="l-table-edit-c" colspan="3">
				                	${itemInfo.ITEM_ID}
				                	<input name="ITEM_ID" type="hidden" id="ITEM_ID" value="${itemInfo.ITEM_ID}"/>
				                </td>  
				             </tr>
				             <tr>   
				                <td width="15%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
				                <td width="35%" class="l-table-edit-c">
				                	<input name="ITEM_NAME" type="text" id="ITEM_NAME" value="${itemInfo.ITEM_NAME }" 
				                	ltype="text" validate="{required:true}" />
				                </td>
				                <td width="15%" class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
				                <td width="35%" class="l-table-edit-c">
				                	<input name="ITEM_EN_NAME" type="text" id="ITEM_EN_NAME" value="${itemInfo.ITEM_EN_NAME }" 
				                	ltype="text"  validate="{required:true}" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
				                </td>
				            </tr>  
				             <tr>   
				                <td class="l-table-edit-t"><spring:message code="hrms.attItemShortName"/></td>
				                <td class="l-table-edit-c">
				                	<input name="SHORT_NAME" type="text" id="SHORT_NAME" value="${itemInfo.SHORT_NAME }" 
				                	ltype="text" validate="{required:true}" onkeyup="value=value.replace(/[^\w\.\/]/ig,'')"/>
				                </td>
				                <td class="l-table-edit-t"><spring:message code="hrms.attItemGroup"/></td>
				                <td class="l-table-edit-c">
				                	<SipingSoft:selectSyCode parentCode="ATTItemGroup" name="ITEM_GROUP_CODE" selected="${itemInfo.ITEM_GROUP_CODE }"/> 
				                </td>
				            </tr>  
				             <tr>   
				                <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
				                <td class="l-table-edit-c" colspan="3"> 
									<SipingSoft:selectStatus name="ACTIVITY" selected="${itemInfo.ACTIVITY }"/>
				                </td>
				            </tr>  
				            <tr>
				                <td class="l-table-edit-t"><spring:message code="hrms.description"/></td>
				                <td class="l-table-edit-c" colspan="3"> 
				                	<textarea cols="100" rows="4" name="DESCRIPTION" id="DESCRIPTION" style="width:400px" >${itemInfo.DESCRIPTION }</textarea>
				                </td> 
				            </tr>
				            <tr>
				                <td class="l-table-edit-cc" colspan="4" height="30px;">  
									<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>  
				                </td>
				            </tr>
				        </table> 
	         </form>
	  </div>
</body>
</html>
