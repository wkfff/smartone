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
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>   
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>   
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script> 
	      
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
function f_save(){ 
    if(spf_checkData()){ 
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/empinfo/addEduInfo", 
                [	   
	               	{ name: 'EMPID', value: $("#EMPID").val()},  
	              	{ name: 'START_DATE', value: $("#START_DATE").val()},
	              	{ name: 'END_DATE', value: $("#END_DATE").val()},
                  	{ name: 'INSTITUTION_NAME', value: $("#INSTITUTION_NAME").val()},  
                  	{ name: 'EDU_HIS_CODE', value: $("#EDU_HIS_CODE").val()},
                  	{ name: 'DEGREE_CODE', value: $("#DEGREE_CODE").val()},
                  	{ name: 'MAJOR_CODE', value: $("#MAJOR_CODE").val()},  
                  	{ name: 'ADDRESS', value: $("#ADDRESS").val()},  
                  	{ name: 'CONTENT', value: $("#CONTENT").val()},  
                  	{ name: 'REMARK', value: $("#REMARK").val()} 
                 ]
            , function (result)
            {
            	$.ligerDialog.closeWaitting();
                if (result == "Y")
                {
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
		               	parent.f_ChildWindowClose();
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
		var EDU_HIS_CODE = $("#EDU_HIS_CODE").val();
		var DEGREE_CODE = $("#DEGREE_CODE").val();
		var MAJOR_CODE = $("#MAJOR_CODE").val();
		var START_DATE = $("#START_DATE").val(); 
		var END_DATE = $("#END_DATE").val();  
		var INSTITUTION_NAME = $("#INSTITUTION_NAME").val(); 
		var ADDRESS = $("#ADDRESS").val(); 
		var CONTENT = $("#CONTENT").val(); 
		
        if (START_DATE == null || START_DATE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }    
        if (END_DATE == null || END_DATE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }   
        if (INSTITUTION_NAME == null || INSTITUTION_NAME == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.institutionName"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
       }  
        if (EDU_HIS_CODE == null || EDU_HIS_CODE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.eduHis"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if (DEGREE_CODE == null || DEGREE_CODE == "") { 
  	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.degree"/>'+". " + '<spring:message code="input.required"/>') ; 
  	       	 return false; 
  	    } 
        if (MAJOR_CODE == null || MAJOR_CODE == "") { 
  	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.major"/>'+". " + '<spring:message code="input.required"/>') ; 
  	       	 return false; 
  	    }  
        if (ADDRESS == null || ADDRESS == "") { 
 	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.address"/>'+". " + '<spring:message code="input.required"/>') ; 
 	       	 return false; 
 	    }    
        if (CONTENT == null || CONTENT == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.courseContent"/>'+". " + '<spring:message code="input.required"/>') ; 
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
						                	 value="${EduInfo.START_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	  readonly="readonly"/> 
					                </td>  
					             </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
					                <td class="l-table-edit-c" colspan="2">   
					                	<input type="text" name="END_DATE" id="END_DATE" 
						                	 value="${EduInfo.END_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	  readonly="readonly"/> 
					                </td> 
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.institutionName"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="INSTITUTION_NAME" id="INSTITUTION_NAME" value="${EduInfo.INSTITUTION_NAME }" 
					                    	ltype='text' />   
					                </td>
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.eduHis"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <SipingSoft:selectSyCode parentCode="EduHisCode" name="EDU_HIS_CODE" limit="all" selected="${EduInfo.EDU_HIS_CODE }"/> 
					                </td>
					            </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.degree"/></td>
					                <td class="l-table-edit-c" colspan="2">
					       	   		<SipingSoft:selectSyCode parentCode="DegreeCode" name="DEGREE_CODE" limit="all" selected="${EduInfo.DEGREE_CODE }"/>  
					                </td>
					            </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.major"/></td>
					                <td class="l-table-edit-c" colspan="2">
					       	   		<SipingSoft:selectSyCode parentCode="SubjectCode" name="MAJOR_CODE" limit="all" selected="${EduInfo.MAJOR_CODE }"/>  
					                </td>
					            </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.address"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="ADDRESS" id="ADDRESS" value="${EduInfo.ADDRESS }" 
					                    	/>   
					                </td>
					            </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.courseContent"/></td>
					                <td class="l-table-edit-c" colspan="2">
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="CONTENT" name="CONTENT" >${EduInfo.CONTENT }</textarea>  
					                </td>
					            </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
					                <td class="l-table-edit-c" colspan="2">  
							       	   	<textarea rows="3" cols="" style="width: 300px" 
							       	   			id="REMARK" name="REMARK">${EduInfo.REMARK }</textarea> 
					                </td>
					            </tr>   
					        </table>
		       			</td>
			      	</tr>
			    </table> 
		       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
		           <tr>
		                <td align="left">  
	               			<a class="l-button" style="width:79px; height:20px; float: left; margin-left:10px;" onclick="f_save();"><spring:message code="hrms.save"/></a>  
						</td>
		           </tr>  
	       		</table> 
	         </form>
	  </div>
</body>
</html>
