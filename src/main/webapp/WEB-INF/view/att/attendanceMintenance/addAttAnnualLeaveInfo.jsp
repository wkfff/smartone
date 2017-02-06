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
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
 	// 初始调用
 	
    $(function() {
        
    });

    function f_save() {
        $("form .l-text,").ligerHideTip();

        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        
        var options = {	                        
            url:'/att/attendanceMintenance/addAttAnnualLeaveInfo',
            type:'POST',	                        
            success:function (result){
        			$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', function ()
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

    function searchEmp(){
        
    	 $dialog = $.ligerDialog.open({isDrag: false,
    		 title:'<spring:message code="employee.information"/>',
       		 width: 800, height: 400, 
       		 url: '/utility/empInfo/viewAttSearchEmployee'
       	  }); 
    }

	function spf_initSelectEmpInfo(data){
		$("#chineseName").html("") ;
		$("#englishName").html("") ;
		$("#deptName").html("") ;
        $("#chineseName").html(data.CHINESENAME) ;
        $("#englishName").html(data.ENGLISHNAME) ;
        $("#deptName").html(data.DEPTNAME) ;
        $("#EMPID").attr("value", data.EMPID) ;
        $dialog.close() ;
    }
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" > 
	  <div align="center">
	     <form name="form1" method="post" action="" id="form1">
	  	<table width="100%" border="0" >
	        <tr><td height="2"></td></tr>
            <tr>
                <td align="center" valign="middle"> 
				        <table width="99%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			            <tr>  
			                <td width="10%"  class="l-table-edit-t"><spring:message code="hrms.empid"/></td>
			                <td width="20%" class="l-table-edit-c" colspan="3">
			                	<input id="EMPID" name="EMPID" type="text" readonly="readonly" validate="{required:true}" onclick="searchEmp()"/>
				                <input id="jsonData" name="jsonData" type="hidden" value=""/>
			                </td>  
			            </tr>
			            <tr>  
			                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
			                <td width="20%" class="l-table-edit-c">
			                	<div id="chineseName"></div>
			                </td>
			                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
			                <td width="30%" class="l-table-edit-c">
			           			<input type="text" name="STRT_DATE" id="STRT_DATE" 
				                	 value="" 
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 validate="{required:true}" readonly="readonly"/>  
			                </td>
			            </tr>
			            <tr>
			                <td class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
			                <td class="l-table-edit-c">
			                	<div id="englishName"></div>
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
			                <td class="l-table-edit-c">
			           			<input type="text" name="END_DATE" id="END_DATE" 
				                	 value="" 
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 validate="{required:true}" readonly="readonly"/>   
			                </td> 
			            </tr>  
			            <tr>
			                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
			                <td class="l-table-edit-c">
			                	<div id="deptName"></div>
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.year"/></td>
			                <td class="l-table-edit-c">
			                	<SipingSoft:date yearName="VAC_ID" />
			                </td> 
			            </tr> 
			            <tr> 
			                <td class="l-table-edit-t"><spring:message code="hrms.leaveLength"/></td>
			                <td class="l-table-edit-c">
			                	<input name="TOT_VAC_CNT" type="text" id="TOT_VAC_CNT" value=""
				                	ltype='spinner' ligerui="{type:'float'}" validate="{required:true}" />
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.leaveType"/></td>
			                <td class="l-table-edit-c">
			                	<SipingSoft:selectSyCode parentCode="VacationType" name="VAC_TP"/>
			                </td>  
			            </tr>  
			            <tr>
			                <td class="l-table-edit-cc" colspan="4" height="30px;">  
								<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>
			                </td>
			            </tr>
			           </table> 
       			</td>
	      	</tr>
	    </table> 
         </form>
	   </div> 
	</div>  
</body>
</html>
