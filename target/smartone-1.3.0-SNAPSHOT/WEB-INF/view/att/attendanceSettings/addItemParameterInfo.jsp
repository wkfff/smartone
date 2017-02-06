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
          url:'/att/attendanceSettings/addItemParameterInfo',
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
	  <div id = 'layout1'>
		     <form name="form1" method="post" action="" id="form1">
			      <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
    <tr>
	    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.attItemName"/></td>
	    <td width="35%" class="l-table-edit-c">
	    	${itemInfo.ITEM_NAME }
			<input name="AR_ITEM_NO" type="hidden" value="${itemInfo.ITEM_NO}"/>
	    </td> 
	    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.workingShift.group"/></td>
	    <td width="35%" class="l-table-edit-c">
	    	<SipingSoft:select name="AR_GROUP_NO" dataListName="arDynamicGroupInfo" selected="constant"/>
	    </td> 
	  </tr>
	  <tr>
	  	<td class="l-table-edit-t"><spring:message code="hrms.unit"/></td>
	    <td class="l-table-edit-c"> 
			<SipingSoft:selectSyCode parentCode="ItemUnit" name="UNIT"/>
		</td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.minimumUnit"/></td>
	    <td class="l-table-edit-c">
	    	<input name="UNIT_VALUE" type="text" id="UNIT_VALUE" value="" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}">
	    </td> 
	  </tr>
	  <tr>
	  	<td class="l-table-edit-t"><spring:message code="hrms.minimum"/></td>
	    <td class="l-table-edit-c">
	    	<input name="MIN_VALUE" type="text" id="MIN_VALUE" value="" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}">
	    </td>
	    <td class="l-table-edit-t"><spring:message code="hrms.maximum"/></td>
	    <td class="l-table-edit-c">
	    	<input name="MAX_VALUE" type="text" id="MAX_VALUE" value="" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}">
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.dependenceItem"/></td>
	    <td class="l-table-edit-c">
	    	<input type="text" name="DEPEND_ITEM" id="DEPEND_ITEM" value=""/>
	    </td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.replacementItem"/></td>
	    <td class="l-table-edit-c">
	    	<input type="text" name="REPLACE_ITEM" id="REPLACE_ITEM" value=""/>
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.dateType"/></td>
	    <td class="l-table-edit-c">
	    	<input type="checkbox" name="DATE_TYPE" value="1"><spring:message code="weekday"/>
	        <input type="checkbox" name="DATE_TYPE" value="2"><spring:message code="weekend"/>
	        <input type="checkbox" name="DATE_TYPE" value="3"><spring:message code="holiday"/>
	    </td>  
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.referenceTimecard"/></td>
	    <td class="l-table-edit-c">
	    	<select name="CARD_FLAG" id="CARD_FLAG">
		      <option value="1"><spring:message code="yes"/></option>
		      <option value="0"><spring:message code="no"/></option>
		    </select>
	    </td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.timecardStartTag"/></td>
	    <td class="l-table-edit-c">
	    	<select name="CARD_FROM_FLAG" id="CARD_FROM_FLAG">
		      <option value="1"><spring:message code="yes"/></option>
		      <option value="0"><spring:message code="no"/></option>
		    </select>
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.timecardStartExcursion"/></td>
	    <td class="l-table-edit-c">
	    	<input name="CARD_FROM_OFFSET" type="text" id="CARD_FROM_OFFSET" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}" value="">
	    </td> 
		<td class="l-table-edit-t"><spring:message code="hrms.timecardStartExcursionDirection"/></td>
	    <td class="l-table-edit-c">
	    	 <select name="CARD_FROM_RELATION" id="CARD_FROM_RELATION">
		      <option value="＞"><spring:message code="greaterThan"/></option>
		      <option value="＜"><spring:message code="lessThan"/></option>
		      <option value="＝"><spring:message code="equality"/></option>
		    </select>
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.timecardEndTag"/></td>
	    <td class="l-table-edit-c">
	    	<select name="CARD_TO_FLAG" id="CARD_TO_FLAG">
		      <option value="1"><spring:message code="yes"/></option>
		      <option value="0"><spring:message code="no"/></option>
		    </select>
	    </td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.timecardEndExcursion"/></td>
	    <td class="l-table-edit-c">
	    	<input name="CARD_TO_OFFSET" type="text" id="CARD_TO_OFFSET" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}" value="">
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.timecardEndExcursionDirection"/></td>
	    <td class="l-table-edit-c">
	    	 <select name="CARD_TO_RELATION" id="CARD_TO_RELATION">
		      <option value="＞"><spring:message code="greaterThan"/></option>
		      <option value="＜"><spring:message code="lessThan"/></option>
		      <option value="＝"><spring:message code="equality"/></option>
		    </select>
	    </td> 
	 	<td class="l-table-edit-t"><spring:message code="hrms.referenceApplication"/></td>
	    <td class="l-table-edit-c">
	    	<select name="APPLY_FLAG" id="APPLY_FLAG">
		      <option value="1"><spring:message code="yes"/></option>
		      <option value="0"><spring:message code="no"/></option>
		    </select>
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.appType"/></td>
	    <td class="l-table-edit-c"> 
	    	<SipingSoft:select name="APPLY_TYPE" dataListName="arAppTypeInfo" limit="all"/>
	    </td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.fulltimeApplicationHours"/></td>
	    <td class="l-table-edit-c">
	    	<input name="APPLY_FULLDAY_VALUE" type="text" id="APPLY_FULLDAY_VALUE" value="" 
	    	ltype='spinner' ligerui="{type:'int'}" validate="{required:true}">
	    </td> 
	  </tr>
	  <tr>
	    <td class="l-table-edit-t"><spring:message code="hrms.priorityOfApplicationAndTimecard"/></td>
	    <td class="l-table-edit-c">
	    	<select name="APPLY_CARD_PRIORITY" id="APPLY_CARD_PRIORITY">
		      <option value="0"><spring:message code="timecard"/></option>
		      <option value="1"><spring:message code="application"/></option>
			  <option value="2"><spring:message code="intersection"/></option>
	        </select>
	    </td> 
	    <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
	    <td class="l-table-edit-c">
		    <select name="ACTIVITY" id="ACTIVITY">
		      <option value="1"><spring:message code="yes"/></option>
		      <option value="0"><spring:message code="no"/></option>
		    </select>
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
