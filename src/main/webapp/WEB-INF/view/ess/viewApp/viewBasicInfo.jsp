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
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	function searchEmp() {
		$dialog = $.ligerWindow.show({
			isDrag : false,
			title : '<spring:message code="employee.information"/>',
			width : 800,
			height : 400,
			left : 120,
			top : 90,
			url : '/utility/empInfo/viewHrSearchEmployee'
		});
	}
	function spf_initSelectEmpInfo(data) {
		$("#EMPID").attr("value", data.EMPID);
		var url = (location.href).split("?");
		location.href = url[0] + "?EMPID=" + data.EMPID;
		$dialog.close();
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
<body style="padding: 0px">
	<div id="layout1">
		<div align="center">
			<table width="99.5%" cellpadding="1" cellspacing="1"
				style="height: 25px; font-size: 12px;">
				<tr>
					<td width="5%" align="center"><img
						src="/resources/images/title/top_1.gif" /></td>
					<td width="25%" align="left" style="font-weight: bold;"><spring:message
							code="hrms.basicInfo" /></td>
					<td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
					<td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
				</tr>
			</table>
			<table width="99.5%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-c" rowspan="6"><img
						src="/resources/picture/employee/${basicInfo.EMPID }.jpg"
						onerror="this.src='/resources/photo/none.gif'" width="100"
						height="120" /></td>
				</tr>
				<tr>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.empid" /></td>
					<td width="20%" class="l-table-edit-c">${basicInfo.EMPID } <input
						type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }"
						onclick="searchEmp();" />
					</td>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.name" /></td>
					<td width="20%" class="l-table-edit-c">
						${basicInfo.CHINESENAME }</td>
					<td width="10%" class="l-table-edit-t"><spring:message
							code="hrms.dept" /></td>
					<td width="20%" class="l-table-edit-c">${basicInfo.DEPTNAME }
					</td>
				</tr>

				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.postGroup" /></td>
					<td class="l-table-edit-c">${basicInfo.POST_GROUP_NAME }</td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.postGrade" /></td>
					<td class="l-table-edit-c">${basicInfo.POST_GRADE_NAME }</td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.hireDate" /></td>
					<td class="l-table-edit-c">${basicInfo.JOIN_DATE }</td>
				</tr>

				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.position" /></td>
					<td class="l-table-edit-c">${basicInfo.POSITION_NAME }</td>
					<td class="l-table-edit-t"><spring:message code="hrms.post" /></td>
					<td class="l-table-edit-c">${basicInfo.POST_NAME }</td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.endProbationDate" /></td>
					<td class="l-table-edit-c">${basicInfo.END_PROBATION_DATE}</td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.EmpStatus" /></td>
					<td class="l-table-edit-c">${basicInfo.STATUS_NAME}</td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.empDivision" /></td>
					<td class="l-table-edit-c">${basicInfo.EMP_TYPE_NAME }</td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.leftDate" /></td>
					<td class="l-table-edit-c">${basicInfo.LEFT_DATE }</td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.workingDescription" /></td>
					<td class="l-table-edit-c" colspan="5">${basicInfo.BUSINESS }
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
