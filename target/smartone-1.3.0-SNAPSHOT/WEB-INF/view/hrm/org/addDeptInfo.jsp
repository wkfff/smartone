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
	<script type="text/javascript">
	/*
     *职员信息弹出框收缩js
    */
    $(function ()
            {  
                $("#MANAGER_EMP_NAME").ligerComboBox({
                    onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
                });
            });
            function spf_selectEmp()
            {
                $.ligerDialog.open({ 
                	title: '<spring:message code="employee.information"/>', 
                	name:'winselector'+Math.random(),
                	width: 800, 
                	height: 400, 
                	url: '/utility/empInfo/viewHrSearchEmployeeB', 
                	buttons: [
	                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK_EMP },
	                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_EMP },
	                    { text: '<spring:message code="clear"/>', onclick: spf_selectClear_EMP }
                	]
                });
                return false;
            }
            function spf_selectOK_EMP(item, dialog)
            {
    			var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
                var data = fn(); 
                if (!data)
                {
                	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
                }
                $("#MANAGER_EMP_NAME").val(data.EMPID+","+data.CHINESENAME);
                $("#EMPID").val(data.EMPID);
                dialog.close();
            }
            function spf_selectCancel_EMP(item, dialog)
            {
                dialog.close();
            }
            function spf_selectClear_EMP(item, dialog)
            {
            	$("#MANAGER_EMP_NAME").val("");
            	$("#EMPID").val("");
                dialog.close();
            }
        /*
         *部门信息弹出框收缩js
        */
        $(function ()
                {  
                    $("#PARENT_DEPT_NAME").ligerComboBox({
                        onBeforeOpen: spf_selectDepartment, valueFieldID: 'PARENTDEPTID',width:150
                    });
                });
		        function spf_selectDepartment() { 
		            $.ligerDialog.open(
		            	{ title: '<spring:message code="hrms.dept.information"/>', 
		            	  width: 800, 
		            	  height: 400, 
		            	  url: '/utility/deptInfo/selectDepartment', 
		            	  buttons: [
		    	                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK_DEPT },
		    	                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_DEPT },
		    	                    { text: '<spring:message code="clear"/>', onclick: spf_selectClear_DEPT }
		            	  ]
		            });
		            return false;
		        }
		        function spf_selectOK_DEPT(item, dialog)
		        {
		    		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
		            var data = fn(); 
		            if (!data)
		            {
		            	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			        	 return ; 
		            }   
	                $("#PARENT_DEPT_NAME").val(data.DEPTNAME.replace(/&nbsp;/g,""));
	                $("#PARENTDEPTID").val(data.DEPTID);
	                dialog.close(); 
		        } 
		        function spf_selectCancel_DEPT(item, dialog)
		        {
		            dialog.close();
		        } 
	            function spf_selectClear_DEPT(item, dialog)
	            {
	            	$("#PARENT_DEPT_NAME").val("");
	            	$("#PARENTDEPTID").val("");
	                dialog.close();
	            }

            /*
             *部门弹出框收缩js
            */	
		    function f_save(){    	
		    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		        var options = {
		            url:'/hrm/org/addDeptInfo',
		            type:'POST',
		            success: function (result){
		            		$.ligerDialog.closeWaitting();
		  		            if (result == "Y")
		  		            {
		  		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		  		                {
//		  		                	parent.f_ChildWindowClose() ;
		  		                	parent.spf_refresh();
		  		                });
		  		            }
		  		            else
		  		            {
		  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.sameDataAlreadyExists"/>');
		  		            }
		  		        }
		            }; 
		        $('#form1').ajaxSubmit(options);
		    }
		    function addDept(){
		    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		        var options = {	                        
		            url:'/hrm/org/addDeptInfo',
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
		  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.sameDataAlreadyExists"/>');
		  		            }
		  		        }              
		            }; 
		        $('#form1').ajaxSubmit(options);
		    }
</script> 
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>	
<style type="text/css"> 
   body{ padding:5px; margin:0; padding-bottom:15px;}
   #layout1{  width:99%;margin:0; padding:0;  }
</style>
</head>
<body style="padding: 0px">
	<div id='layout1'>
		<form name="form1" method="post" action="" id="form1">
			<table width="100%" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td class="l-table-edit-t" width="15%">
						<!-- 主键-->
						<spring:message code="hrms.basicCode" />
					</td>
					<td class="l-table-edit-c" colspan="3">
						<input type="text" name="DEPTID" id="DEPTID" value="" validate="{required:true}" />
					</td>
				</tr>
				<tr>
					<td class="l-table-edit-t" width="15%"><spring:message code="hrms.manager" /></td>
					<td class="l-table-edit-c" width="35%"><input type="text"
						id="MANAGER_EMP_NAME" name="MANAGER_EMP_NAME" value=""
						validate="{required:true}" /> <input type="hidden" id="EMPID"
						name="EMPID" value="" /></td>
					<td class="l-table-edit-t" width="15%"><spring:message
							code="hrms.dept.parent" /></td>
					<td class="l-table-edit-c" width="35%"><input type="text"
						id="PARENT_DEPT_NAME" name="PARENT_DEPT_NAME" value=""
						validate="{required:true}" /> <input type="hidden"
						id="PARENTDEPTID" name="PARENTDEPTID" value="" /></td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.chineseName" /></td>
					<td class="l-table-edit-c"><input name="DEPTNAME" type="text"
						id="DEPTNAME" value="" validate="{required:true}" /></td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.englishName" /></td>
					<td class="l-table-edit-c"><input name="DEPT_EN_NAME"
						type="text" id="DEPT_EN_NAME" value="" /></td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message code="hrms.startDate" /></td>
					<td class="l-table-edit-c"><input type="text"
						name="DATE_CREATED" id="DATE_CREATED" value=""
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>})"
						validate="{required:true}" readonly="readonly" /></td>
					<td class="l-table-edit-t"><spring:message code="hrms.endDate" /></td>
					<td class="l-table-edit-c"><input type="text"
						name="DATE_ENDED" id="DATE_ENDED" value=""
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>})"
						readonly="readonly" /></td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.description" /></td>
					<td class="l-table-edit-c" colspan="5"><textarea cols="100"
							rows="4" name="DESCRIPTION" id="DESCRIPTION" style="width: 400px"></textarea>
					</td>
				</tr>
				<tr>
					<td class="l-table-edit-submit-l" colspan="7" height="30px"><a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 1px; "
						onclick="f_save()"><spring:message code="hrms.save" /></a></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
