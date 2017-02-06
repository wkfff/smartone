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
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid;
	var $dialog;
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			topHeight : 160,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
	});
</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1" id='' title=' '>
		<div position="top" style="border: 0px;">
			<%@include file="viewBasicInfo.jsp"%>
			<br>
		</div>
		<div position="center" style="border: 0px;">
			<table width="99.5%" cellpadding="1" cellspacing="1"
				style="height: 25px; font-size: 12px;">
				<tr>
					<td width="5%" align="center"><img
						src="/resources/images/title/top_1.gif" /></td>
					<td width="25%" align="left" style="font-weight: bold;"><spring:message
							code="hrms.infoApplication" /></td>
					<td width="65%" align="right">&nbsp;</td>
					<td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table>
			<table width="99.2%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t">性别</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.GENDER_NAME }</td>
					<td width="10%" class="l-table-edit-t">名族</td>
					<td width="20%" class="l-table-edit-c">
						<div style="font: normal; color: purple;">${personalInfo.NATION_NAME
							}</div>
					</td>
					<td width="10%" class="l-table-edit-t">宗教</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.RELIGION_NAME }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">国籍</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.NATIONALITY_NAME }</td>
					<td width="10%" class="l-table-edit-t">籍贯</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.BORNPLACE_NAME }</td>
					<td width="10%" class="l-table-edit-t">政党面貌</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.POLITY_NAME }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">年龄</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.AGE }</td>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.birthDate" /></td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.BIRTHDAY }</td>
					<td width="10%" class="l-table-edit-t">工会会员</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.MEMBERSHIP_NAME }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">学历</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.EDU_HIS_NAME }</td>
					<td width="10%" class="l-table-edit-t">学位</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.DEGREE_NAME }</td>
					<td width="10%" class="l-table-edit-t">专业</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.MAJOR_NAME }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">身份证号码</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.IDCARD_NO }</td>
					<td width="10%" class="l-table-edit-t">婚姻状态</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.MARITAL_STATUS_NAME }</td>
					<td width="10%" class="l-table-edit-t">登记日期</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.WEDDING_DATE }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">户口类型</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.IDCARD_TYPE_NAME }</td>
					<td width="10%" class="l-table-edit-t">供应单位</td>
					<td width="20%" class="l-table-edit-c" colspan="3">
						${personalInfo.SUPPLIER_NAME }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">户口地址</td>
					<td width="80%" class="l-table-edit-c" colspan="5" nowrap="nowrap">
						${personalInfo.IDCARD_PROVINCE_NAME }
						${personalInfo.IDCARD_CITY_NAME } ${personalInfo.IDCARD_AREA_NAME
						} ${personalInfo.IDCARD_ADDRESS }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">当前住址</td>
					<td width="80%" class="l-table-edit-c" colspan="5" nowrap="nowrap">
						${personalInfo.HOME_PROVINCE_NAME } ${personalInfo.HOME_CITY_NAME
						} ${personalInfo.HOME_AREA_NAME } ${personalInfo.HOME_ADDRESS }</td>
				</tr>
			</table>
			<br>
			<table width="99.2%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.mobileTelephone" /></td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.CELLPHONE }</td>
					<td width="10%" class="l-table-edit-t">固定电话</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.HOME_PHONE }</td>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.workPhone" /></td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.OFFICE_PHONE }</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">传真号码</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.FAX }</td>
					<td width="10%" class="l-table-edit-t">个人邮箱</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.P_EMAIL
						}</td>
					<td width="10%" class="l-table-edit-t">公司邮箱</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.P_EMAIL
						}</td>
				</tr>
			</table>
			<br>
			<table width="99.2%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t">司外工龄</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.B_WORKAGE }</td>
					<td width="10%" class="l-table-edit-t">司内工龄</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.A_WORKAGE }</td>
					<td width="10%" class="l-table-edit-t">合计工龄</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.B_WORKAGE + personalInfo.A_WORKAGE}</td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t">工作班制</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.SHIFT_NAME }</td>
					<td width="10%" class="l-table-edit-t">档案状态</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.FILE_RELATION_NAME }</td>
					<td width="10%" class="l-table-edit-t">存档单位</td>
					<td width="20%" class="l-table-edit-c">
						${personalInfo.FILE_RELATION_ADDRESS }</td>
				</tr>
			</table>
			<br>
			<table width="99.2%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t">社会保险号码</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.SSN }</td>
					<td width="10%" class="l-table-edit-t">住房公积金号码</td>
					<td width="20%" class="l-table-edit-c">${personalInfo.HAFN }</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
