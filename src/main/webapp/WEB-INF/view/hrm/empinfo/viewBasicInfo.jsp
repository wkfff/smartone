<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
	function searchEmp() {
		$dialog = $.ligerDialog.open({
			isDrag : true,
			title : '<spring:message code="employee.information"/>',
			width : 800,
			height : 400,
			left : 160,
			top : 90,
			showMax : true,
			showMin : true,
			isResize : true,
			url : '/utility/empInfo/viewHrSearchEmployee'
		});
	}
	function spf_initSelectEmpInfo(data) {
		$("#EMPID").attr("value", data.EMPID);
		var url = (location.href).split("?");
		var _url = url[1].split("&");
		location.href = url[0] + "?" + _url[0] + "&EMPID=" + data.EMPID;

//		$dialog.close();
	}
	function spf_uploadPhoto() {
		var empID = $("#EMPID").val();
		$dialog = $.ligerDialog.open({
			isDrag : false,
			title : '上传头像',
			width : 420,
			height : 220,
			url : '/upload/fileUpload/uploadPhoto?EMPID=' + empID
		});
	}
	function spf_photo_ChildWindowClose() {
		$("#headImage").attr("src","/resources/picture/employee/${basicInfo.EMPID }.jpg?" + Math.random());
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
			<table width="99.6%" cellpadding="1" cellspacing="1"
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
					<td width="10%" class="l-table-edit-cc" rowspan="6" style="cursor: pointer;">
						<img src="/resources/picture/employee/${basicInfo.EMPID }.jpg" id="headImage"
							onerror="this.src='/resources/photo/none.gif'"
							onClick="spf_uploadPhoto()" width="100" />
					</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.empid" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						<input type="text" name="EMPID" id="EMPID"
							value="${basicInfo.EMPID }" onclick="searchEmp();" /></td>
					<td  class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.name" /></td>
					<td  class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.CHINESENAME }</td>
				</tr>
				<tr height="30px;">
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.postGrade" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.POST_GRADE_NAME }</td>
					<%-- <td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.position" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.POSITION_NAME }</td> --%>
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.post" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.POST_NAME }</td>
				</tr>
				<tr height="30px;">
					<td  class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.dept" /></td>
					<td  class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.DEPTNAME }</td>
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.EmpStatus" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.STATUS_NAME}</td>
					
				</tr>
				<tr height="30px;">
					<%-- <td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.postGroup" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.POST_GROUP_NAME }</td> --%>
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.hireDate" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.JOIN_DATE }</td>
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.endProbationDate" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">
						${basicInfo.END_PROBATION_DATE}</td>
				</tr>
				<tr height="30px;">
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.leftDate" /></td>
					<td class="l-table-edit-c" nowrap="nowrap" colspan="3">
						${basicInfo.LEFT_DATE }</td>
				</tr>
				<%-- <tr height="25%">
					<td class="l-table-edit-t" nowrap="nowrap"><spring:message
							code="hrms.positionalTitle" /></td>
					<td class="l-table-edit-c" nowrap="nowrap">${basicInfo.POSITITLE }</td>
					
					
				</tr> --%>
			</table>
		</div>
	</div>
</body>
</html>
