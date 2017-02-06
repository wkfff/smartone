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
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
function f_save() {

     $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
     var options = {	                        
       url:'/att/attendanceSettings/updateShiftParameterInfo',
       type:'POST',	                        
       success: function (result){
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
      <div id="layout1" > 
		  <div align="left"> 
		     <form name="form1" method="post" action="" id="form1">
					  <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				           <tr> 
				               <td width="15%" class="l-table-edit-t">
				               		<spring:message code="hrms.attItemName"/></td>
				                <td class="l-table-edit-c"> 
				                    <input type="hidden" name="PK_NO" id="PK_NO" value="${shiftParameterInfo.PK_NO }">
				                    <input type="hidden" name="SHIFT_NO" id="SHIFT_NO" value="${shiftParameterInfo.SHIFT_NO }">
				                    <SipingSoft:select name="AR_ITEM_NO" dataListName="itemInfoList" selected="${shiftParameterInfo.AR_ITEM_NO }"/>
				                </td> 
			                </tr>  
			                <tr> 
				               <td width="15%" class="l-table-edit-t">
				               		<spring:message code="hrms.startDate"/></td>
				                <td class="l-table-edit-c"> 
				                    <SipingSoft:selectSyCode parentCode="SpanDays" name="BEGIN_DAY_OFFSET_CODE" 
		       	   					selected="${shiftParameterInfo.BEGIN_DAY_OFFSET_CODE }" remove="2,"/>
				                </td> 
			                </tr> 
			                <tr> 
				               <td width="15%" class="l-table-edit-t">
				               		<spring:message code="hrms.startedTime"/></td>
				                <td class="l-table-edit-c"> 
				                    
			                	<input type="text" name="FROM_TIME" id="FROM_TIME" 
							                	 value="${shiftParameterInfo.FROM_TIME}" 
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'HH:mm'})"  
							                	 validate="{required:true}" readonly="readonly"/> 
				                </td> 
			                </tr> 
			                <tr> 
				               <td width="15%" class="l-table-edit-t">
				               		<spring:message code="hrms.endDate"/></td>
				                <td class="l-table-edit-c"> 
				                    <SipingSoft:selectSyCode parentCode="SpanDays" name="END_DAY_OFFSET_CODE" 
		       	   					selected="${shiftParameterInfo.END_DAY_OFFSET_CODE }" remove="2,"/>
				                </td> 
			                </tr> 
			                <tr> 
				               <td width="15%" class="l-table-edit-t">
				               		<spring:message code="hrms.endTime"/></td>
				                <td class="l-table-edit-c"> 
				                    <input type="text" name="TO_TIME" id="TO_TIME" 
							                	 value="${shiftParameterInfo.TO_TIME}" 
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'HH:mm'})"  
							                	 validate="{required:true}" readonly="readonly"/> 
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
       </div> 
</body>
</html>
