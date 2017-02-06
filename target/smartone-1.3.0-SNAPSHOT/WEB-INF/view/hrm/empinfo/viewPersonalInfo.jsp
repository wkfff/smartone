<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid;
	var $dialog;
	// 初始调用函数
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
	});

	function spf_update() {
		$dialog = $.ligerDialog.open({
			isDrag: true,
			title : '<spring:message code="hrms.update"/>',
			width: 900 ,
			height: 450,
			left:120,
			top:60,
			showMax : true,
			showMin : true,
			isResize : true,
			url : '/ess/personinfo/updateEmpInfo?EMPID=${basicInfo.EMPID }'
		});
	}

	function f_ChildWindowClose() {
		var url = (location.href).split("?");
		var _url = url[1].split("&");
		location.href = url[0] + "?" + _url[0] + "&EMPID=${personalInfo.EMPID}";
	}
</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1" id='' title=''>
		<div position="center" id='' title=' ' style="border: 0px;">
			<%@include file="viewBasicInfo.jsp"%>
			<br>
			<table width="99.6%" cellpadding="1" cellspacing="1"
				style="height: 25px; font-size: 12px;">
				<tr height="30px;">
					<td width="5%" align="center"><img
						src="/resources/images/title/top_1.gif" /></td>
					<td width="25%" align="left" style="font-weight: bold;"><spring:message
							code="hrms.personalInfo" /></td>
					<td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
					<td width="65%" align="right"><SipingSoft:button /></td>
				</tr>
			</table>
			<table width="99.2%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message
							code="hrms.sex"/></td>
					<td  class="l-table-edit-c">${personalInfo.GENDER_NAME }</td>
					<td  class="l-table-edit-t"><spring:message
							code="hrms.nation"/></td>
					<td  class="l-table-edit-c">${personalInfo.NATION_NAME }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message code="hrms.birthDate"/></td>
					<td  class="l-table-edit-c">${personalInfo.BIRTHDAY }</td>
					<td  class="l-table-edit-t"><spring:message
							code="hrms.politicalLandscape"/></td>
					<td  class="l-table-edit-c">${personalInfo.POLITY_NAME }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message
							code="hrms.godCardNumber"/></td>
					<td  class="l-table-edit-c">${personalInfo.IDCARD_NO }</td>
					<td  class="l-table-edit-t"><spring:message
							code="hrms.maritalStatus"/></td>
					<td  class="l-table-edit-c">${personalInfo.MARITAL_STATUS_NAME }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message
							code="hrms.eduHis"/></td>
					<td  class="l-table-edit-c">${personalInfo.EDU_HIS_NAME }</td>
					<td  class="l-table-edit-t"><spring:message
							code="hrms.major"/></td>
					<td  class="l-table-edit-c">${personalInfo.MAJOR_NAME }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message code="hrms.mobileTelephone" /></td>
					<td  class="l-table-edit-c">${personalInfo.CELLPHONE }</td>
					<td  class="l-table-edit-t"><spring:message code="hrms.fixedTelephone" /></td>
					<td  class="l-table-edit-c">${personalInfo.HOME_PHONE }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message code="hrms.e-mail" /></td>
					<td  class="l-table-edit-c">${personalInfo.P_EMAIL}</td>
					<td  class="l-table-edit-t"><spring:message code="hrms.socialSecurityNumber" /></td>
					<td  class="l-table-edit-c">${personalInfo.SSN }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t"><spring:message code="hrms.fundNumber" /></td>
					<td  class="l-table-edit-c">${personalInfo.HAFN }</td>
					<td  class="l-table-edit-t"><spring:message code="hrms.mailingAddress" /></td>
					<td  class="l-table-edit-c" >
						${basicInfo.HOME_PROVINCE_NAME }${basicInfo.HOME_CITY_NAME }
						${basicInfo.HOME_AREA_NAME }${personalInfo.HOME_ADDRESS }
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
