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
            $.post("/hrm/empinfo/addDocInfo", 
                    [	   
                      	{ name: 'OBTAINED_DATE', value: $("#OBTAINED_DATE").val()},  
                      	{ name: 'EMPID', value: $("#EMPID").val()},  
                      	{ name: 'START_DATE', value: $("#START_DATE").val()},
                      	{ name: 'END_DATE', value: $("#END_DATE").val()},
                      	{ name: 'DOC_TYPE_CODE', value: $("#DOC_TYPE_CODE").val()},
                      	{ name: 'DOC_ID', value: $("#DOC_ID").val()},
                      	{ name: 'SIGN_DEPT', value: $("#SIGN_DEPT").val()},  
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
		var DOC_TYPE_CODE = $("#DOC_TYPE_CODE").val(); 
		var OBTAINED_DATE = $("#OBTAINED_DATE").val(); 
		var START_DATE = $("#START_DATE").val(); 
		var END_DATE = $("#END_DATE").val(); 
		var DOC_ID = $("#DOC_ID").val(); 
		var SIGN_DEPT = $("#SIGN_DEPT").val(); 
   		 
        if (OBTAINED_DATE == null || OBTAINED_DATE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.evidenceDate"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }   
        if (START_DATE == null || START_DATE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }    
        if (END_DATE == null || END_DATE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if (DOC_TYPE_CODE == null || DOC_TYPE_CODE == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.documentType"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if (DOC_ID == null || DOC_ID == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.documentID"/>'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if (SIGN_DEPT == null || SIGN_DEPT == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.signDept"/>'+". " + '<spring:message code="input.required"/>') ; 
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
					                <td  class="l-table-edit-t"><spring:message code="hrms.evidenceDate"/></td>
					                <td class="l-table-edit-c" colspan="2">   
					                	<input type="text" name="OBTAINED_DATE" id="OBTAINED_DATE" 
						                	 value="${EduInfo.OBTAINED_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td> 
					            </tr> 
					            <tr>
					                <td width="160px;" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
					                <td width="60px;" class="l-table-edit-c" colspan="2">  
					                	<input type="hidden" name="EMPID" id="EMPID" value="${paramMap.EMPID }"/> 
					                	<input type="text" name="START_DATE" id="START_DATE" 
						                	 value="${EduInfo.START_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td>  
					             </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
					                <td class="l-table-edit-c" colspan="2">   
					                	<input type="text" name="END_DATE" id="END_DATE" 
						                	 value="${EduInfo.END_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 validate="{required:true}" readonly="readonly"/> 
					                </td> 
					            </tr>  
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.documentType"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <SipingSoft:selectSyCode parentCode="DocTypeCode" name="DOC_TYPE_CODE" limit="all" selected="${EduInfo.EDU_HIS_CODE }"/> 
					                </td>
					            </tr>
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.documentID"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="DOC_ID" id="DOC_ID" value="${EduInfo.DOC_ID }" 
					                    	ltype='text' validate="{required:true}"/>   
					                </td>
					            </tr> 
					             <tr>   
					                <td  class="l-table-edit-t"><spring:message code="hrms.signDept"/></td>
					                <td class="l-table-edit-c" colspan="2">
					                    <input type="text" name="SIGN_DEPT" id="SIGN_DEPT" value="${EduInfo.SIGN_DEPT }" 
					                    	ltype='text' validate="{required:true}"/>   
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
	               			<a class="l-button" style="width:79px; height:20px; float: left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>  
						</td>
		           </tr>  
	       		</table> 
	         </form>
	  </div>
</body>
</html>
