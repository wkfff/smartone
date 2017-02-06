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
	var flag = true;
	var initString = "";
	function f_save(){
		if($("#CATEGORY_ID").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请填写类别编号') ;
			return ;
		}
		if($("#CATEGORY_NAME").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请填写类别名称') ;
			return ;
		}

		if(flag){
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			var options = {
				url:'/system/basicMaintenance/addCategoryInfo',
				type:'POST',
				success: function (result){
						$.ligerDialog.closeWaitting();
						if (result == "Y"){
							$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
								parent.f_ChildWindowClose() ;
							});
						}else{
							$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
						}
					}
				};
			var define = ""+$("#REMARK").val();

			$("#REMARK").text(define.replace(/\n/g,""));

			$('#form1').ajaxSubmit(options);
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', 'Send Error');
		}
	}
</script>
	<style type="text/css"> 
		body{ padding:5px; margin:0; padding-bottom:15px;}
		#layout1{  width:99%;margin:0; padding:0;}
	</style>
</head>
<body style="padding:0px" > 
		<div id = 'layout1'>
			<form name="form1" method="post" action="" id="form1">
				<input name="PARENT_ID" type="hidden" id="PARENT_ID" value="${paraMap.PARENT_ID}"/>
				<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="40%" class="l-table-edit-t">父类名称</td>
						<td width="60%" class="l-table-edit-c">
							${paraMap.PARENT_NAME }
						</td>
					</tr>
					<tr>
						<td width="40%" class="l-table-edit-t">类别编号</td>
						<td width="60%" class="l-table-edit-c">
							<input type="text" name="CATEGORY_ID" id="CATEGORY_ID" value=""/>
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-t">类别名称</td>
						<td class="l-table-edit-c"> 
							<input type="text" name="CATEGORY_NAME" id="CATEGORY_NAME" value=""/>
						</td> 
					</tr>
                    <tr>
                        <td class="l-table-edit-t">编号前缀</td>
                        <td class="l-table-edit-c"> 
                            <input type="text" name="PRE_CODE" id="PRE_CODE" value=""/>
                        </td> 
                    </tr>
					<tr>
						<td class="l-table-edit-t">类别描述</td>
						<td class="l-table-edit-c"> 
							<textarea cols="100" rows="4" name="REMARK" id="REMARK" style="width:99%" ></textarea>
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-cc" colspan="4" height="30px">
							<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>
						</td>
					</tr>
				</table>
			</form>
	  </div>
</body>
</html>
