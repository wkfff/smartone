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
    <script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>  
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script> 
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">

function spf_save(){
    if(spf_checkData()){	    
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/empinfo/addWorkExperienceInfo", 
                [	    
                  	{ name: 'EMPID', value: $("#EMPID").val()},  
                  	{ name: 'START_DATE', value: $("#START_DATE").val()},
                  	{ name: 'END_DATE', value: $("#END_DATE").val()},
                  	{ name: 'CPNY_NAME', value: $("#CPNY_NAME").val()}, 
                  	{ name: 'DEPT_NAME', value: $("#DEPT_NAME").val()},  
                  	{ name: 'POSITION', value: $("#POSITION").val()},   
                  	{ name: 'WORK_CONTENT', value: $("#WORK_CONTENT").val()},   
                  	{ name: 'LEAVE_REASON', value: $("#LEAVE_REASON").val()} 
                 ]
            , function (result)
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
            }); 
    }
} 
function spf_checkData()
{     
	var START_DATE = $("#START_DATE").val(); 
	var END_DATE = $("#END_DATE").val(); 
	var CPNY_NAME = $("#CPNY_NAME").val(); 
	var DEPT_NAME = $("#DEPT_NAME").val();   
	var POSITION = $("#POSITION").val();    
	var WORK_CONTENT = $("#WORK_CONTENT").val(); 
	var LEAVE_REASON = $("#LEAVE_REASON").val(); 
	
    if (START_DATE == null || START_DATE == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }    
    if (END_DATE == null || END_DATE == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }  
    if (CPNY_NAME == null || CPNY_NAME == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workUnit"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }   
    if (DEPT_NAME == null || DEPT_NAME == "") { 
     	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workDept"/>'+". " + '<spring:message code="input.required"/>') ; 
     	 return false; 
    }  
    if (POSITION == null || POSITION == "") { 
       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.position"/>'+". " + '<spring:message code="input.required"/>') ; 
       	 return false; 
    }  
    if (WORK_CONTENT == null || WORK_CONTENT == "") { 
      	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingDescription"/>'+". " + '<spring:message code="input.required"/>') ; 
      	 return false; 
    }  
    if (LEAVE_REASON == null || LEAVE_REASON == "") { 
     	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.leaveSubject"/>'+". " + '<spring:message code="input.required"/>') ; 
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
<body style="padding:2px" > 
	  <div id = 'layout1'>
		     <form name="form1" method="post" action="" id="form1">
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td align="center" valign="middle"> 
					        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					            <tr>
					                <td width="160px;" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
					                <td width="60px;" class="l-table-edit-c" colspan="2">  
					                	<input type="hidden" name="EMPID" id="EMPID" value="${paramMap.EMPID }"/>
					                	<input type="text" name="START_DATE" id="START_DATE" 
						                	 value="" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td>  
					             </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
					                <td class="l-table-edit-c" colspan="2">   
					                	<input type="text" name="END_DATE" id="END_DATE" 
						                	 value="" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td> 
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.workUnit"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="CPNY_NAME" id="CPNY_NAME" value="" 
					                    	ltype='text' validate="{required:true}"/>   
					                </td>
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.workDept"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="DEPT_NAME" id="DEPT_NAME" value="" 
					                    	ltype='text' validate="{required:true}"/>   
					                </td>
					            </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.position"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="POSITION" id="POSITION" value="" 
					                    	ltype='text' validate="{required:true}"/>   
					                </td>
					            </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.workingDescription"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="WORK_CONTENT" name="WORK_CONTENT" validate="{required:true}"></textarea>  
					                </td>
					            </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.leaveSubject"/></td>
					                <td class="l-table-edit-c" colspan="2">  
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="LEAVE_REASON" name="LEAVE_REASON" validate="{required:true}"></textarea> 
					                </td>
					            </tr>   
					        </table>
		        		</td>
			      	</tr>
			    </table> 
		       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
		           <tr>
		                <td align="left">  
	               			<a class="l-button" style="width:79px; height:20px; float: left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>  
						</td>
		           </tr>  
	       		</table>  
	         </form>
	  </div>
</body>
</html>
