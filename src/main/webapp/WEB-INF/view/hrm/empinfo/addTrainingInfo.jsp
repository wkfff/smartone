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
            $.post("/hrm/empinfo/addTrainingInfo", 
                    [	    
                      	{ name: 'EMPID', value: $("#EMPID").val()}, 
                      	{ name: 'COURSE_NAME', value: $("#COURSE_NAME").val()},
                      	{ name: 'START_DATE', value: $("#START_DATE").val()},
                      	{ name: 'CLASS_HOUR', value: $("#CLASS_HOUR").val()},
                      	{ name: 'TEACHER', value: $("#TEACHER").val()},
                      	{ name: 'TEACHING_METHODS', value: $("#TEACHING_METHODS").val()},
                      	{ name: 'EVALUATION_METHODS', value: $("#EVALUATION_METHODS").val()},
                      	{ name: 'MARK', value: $("#MARK").val()},
                      	{ name: 'COURSE_CONTENT', value: $("#COURSE_CONTENT").val()},
                      	{ name: 'REMARK', value: $("#REMARK").val()}
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
    	var COURSE_NAME = $("#COURSE_NAME").val(); 
    	var CLASS_HOUR = $("#CLASS_HOUR").val();  
    	
        if (START_DATE == null || START_DATE == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.trainingDate"/>'+". " + '<spring:message code="input.required"/>') ; 
           	 return false; 
        }    
        if (COURSE_NAME == null || COURSE_NAME == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.courseName"/>'+". " + '<spring:message code="input.required"/>') ; 
           	 return false; 
        }  
        if (CLASS_HOUR == null || CLASS_HOUR == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.classHour"/>'+". " + '<spring:message code="input.required"/>') ; 
           	 return false; 
        }  
        if (isNaN(CLASS_HOUR)) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.classHour"/>'+". " + '<spring:message code="input.number"/>') ; 
            return false; 
        }
        if (CLASS_HOUR<=0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.classHour"/>'+". " + '<spring:message code="productStorage.pleaseEnterAPositiveNumber"/>') ; 
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
					                <td  class="l-table-edit-t"><spring:message code="hrms.courseName"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="COURSE_NAME" id="COURSE_NAME" validate="{required:true}" /> 
					                </td>
					            </tr>  
					            <tr>
					                <td width="160px;" class="l-table-edit-t"><spring:message code="hrms.trainingDate"/></td>
					                <td width="60px;" class="l-table-edit-c" colspan="2">  
					                	<input type="hidden" name="EMPID" id="EMPID" value="${paramMap.EMPID }"/>
					                	<input type="text" name="START_DATE" id="START_DATE" 
						                	 value="" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td>  
					             </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.classHour"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="CLASS_HOUR" id="CLASS_HOUR" validate="{required:true}" /> 
					                </td>
					             </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.teacher"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="TEACHER" id="TEACHER" validate="{required:true}" /> 
					                </td>
					            </tr>
					            <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.teachingMethods"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="TEACHING_METHODS" id="TEACHING_METHODS" validate="{required:true}" /> 
					                </td>
					            </tr> 
					            <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.evaluationMethods"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="EVALUATION_METHODS" id="EVALUATION_METHODS" validate="{required:true}" /> 
					                </td>
					            </tr> 
					            <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.fraction"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<input type="text" name="MARK" id="MARK" validate="{required:true}" /> 
					                </td>
					            </tr>  
					            <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.courseContent"/></td>
					                <td class="l-table-edit-c" colspan="2">  
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="COURSE_CONTENT" name="COURSE_CONTENT" validate="{required:true}"></textarea> 
					                </td>
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
					                <td class="l-table-edit-c" colspan="2">  
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="REMARK" name="REMARK" validate="{required:true}"></textarea> 
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
