<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%--<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%> --%>

<%@ include file="/resources/js/pcc.jsp"%>
<style type="text/css">
#changePassword {
	margin-top: 20px;
	margin-top: 10%;
}


#changePassword #top {
	text-align: left;
	background-image: url("/resources/picture/top.jpg");
	color: #FFFFFF;
	background-repeat: no-repeat;
	font-size: 14px;
}
#changePassword .title {
	text-align: center;
	background-image: url("/resources/picture/leftborder.jpg");
	background-repeat: repeat-y;
	color: #333333;
	font-size: 12px;
	padding-left: 10px;
	width: 100px;
}

#changePassword .content {
	background-image: url("/resources/picture/rightborder.jpg");
	background-repeat: repeat-y;
	background-position: right; color : #333333;
	font-size: 12px;
	padding-left: 10px;
	color: #333333;
}

#changePassword .content input {
	border: solid 1px #c1dcfa;
	line-height: 20px;
	height: 20px;
	width: 180px;
}

#changePassword #button {
	background-image: url("/resources/picture/leftborder.jpg");
	background-repeat: repeat-y;
}

#changePassword #button1 {
	background-image: url("/resources/picture/rightborder.jpg");
	background-repeat: repeat-y;
	background-position: right;
	text-align: center;
	font-size: 12px;
}

#changePassword #button1 input {
	width: 60px;
	height: 25px;
	border: solid 1px #c1dcfa;
	
	
}

#changePassword #buttom {
	text-align: left;
	background-image: url("/resources/picture/bottom.jpg");
	color: #FFFFFF;
	background-repeat: no-repeat;
	font-size: 14px;
	padding-left: 20px;
	font-size: 12px;
}

</style>
<script type="text/javascript">

	function check()
	{
		if($("*[name='OLDPASSWORD']").val()=="")
			{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
			'旧密码不能为空');
			return false;
			}
		if($("*[name='NEWPASSWORD']").val().length<6)
			{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','输入的密码不得少于6位');
			return false;
			}
		if($("*[name='NEWPASSWORD']").val()=="")
		{
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
		'新密码不能为空');
		return false;
		}
		
		if($("*[name='ENTERNEWPASSWORD']").val()=="")
		{
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
		'密码确认不能为空');
		return false;
		}
		if($("*[name='NEWPASSWORD']").val()!=$("*[name='ENTERNEWPASSWORD']").val())
			{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
			'输入的密码不一致');
			return false;
			}
		return true;
	}
	
	function clear_input(){
		$("*[name='OLDPASSWORD']").val("");
		$("*[name='ENTERNEWPASSWORD']").val("");
		$("*[name='NEWPASSWORD']").val("");
	}
	function spf_update() {
		
		if(!check())
			{
				return;
			}
		
		var param={USERNAME:$("*[name='USERNAME']").val(),OLDPASSWORD:$("*[name='OLDPASSWORD']").val(),ENTERNEWPASSWORD:$("*[name='ENTERNEWPASSWORD']").val()};
		$.post("/cust/supplierAccoutManager/getSupplierByPassword",param,function(result){
			
			if(result==1)
			{
				$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
				$.post("/cust/supplierAccoutManager/updateSupplierPassword",param,function(result){
					if(result=="Y")
						{
						 $.ligerDialog.closeWaitting();
						 $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
						 clear_input();
						 return;
						}
					else
						{
						 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', "wrong");
						 return;
						}
				});
			}
			else
				{
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', "对不起，您输入旧密码有误");
				return;
				}
			
		});
	}
</script>
</head>
<body>

	<form action="" method="post" id="form">
		<table id="changePassword" width="350px" height="250px"
			cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" id="top">&nbsp;&nbsp;&gt;&gt;密码修改</td>
			</tr>
			
			<tr>
				<td class="title">账户名</td>
				<td class="content"><input type="text" name="USERNAME"
					value="${map.admin.username}" readonly="readonly" /></input></td>
			</tr>

			<tr>
				<td class="title">旧密码</td>
				<td class="content"><input type="password" name="OLDPASSWORD" /></td>
			</tr>

			<tr>
				<td class="title">新密码</td>
				<td class="content"><input type="password" name="NEWPASSWORD" /></td>
			</tr>

			<tr>
				<td class="title">密码确认</td>
				<td class="content"><input type="password" name="ENTERNEWPASSWORD" /></td>

			</tr>

			<tr>
				<td id="button"></td>
				<td id="button1"><input type="reset" value="重置" />&nbsp;&nbsp;&nbsp;&nbsp;<input
					type="button" onclick="spf_update()" value="提交" /></td>
			</tr>
			<tr>
				<td colspan="2" id="buttom">温馨提示：请牢记您修改后的密码</td>
			</tr>
		</table>
	</form>

</body>
</html>