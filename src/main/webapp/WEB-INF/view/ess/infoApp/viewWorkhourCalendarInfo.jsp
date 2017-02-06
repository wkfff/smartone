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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid;
	var $dialog;
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			topHeight : 32,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});

	});
	/*
	 *弹出框收缩js
	 */
	$(function() {
		$("#key").ligerComboBox({
			onBeforeOpen : spf_selectEmp,
			valueFieldID : 'EMPID',
			width : 150
		});
	});
	function spf_selectEmp() {
		$.ligerDialog.open({
			title : '<spring:message code="employee.information"/>',
			name : 'winselector',
			width : 800,
			height : 420,
			url : '/utility/empInfo/viewHrSearchEmployeeB',
			buttons : [ {
				text : '<spring:message code="okay"/>',
				onclick : spf_selectOK
			}, {
				text : '<spring:message code="cancel"/>',
				onclick : spf_selectCancel
			}, {
				text : '<spring:message code="clear"/>',
				onclick : spf_selectClear
			} ]
		});
		return false;
	}
	function spf_selectOK(item, dialog) {
		var fn = dialog.frame.spf_selectEmpInfo
				|| dialog.frame.window.spf_selectEmpInfo;
		var data = fn();
		if (!data) {
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$("#key").val(data.EMPID);
		$("#NAME").val(data.CHINESENAME);
		$("#chineseName").html(data.CHINESENAME);
		$("#EMPID").val(data.EMPID);
		spf_search();
		dialog.close();
	}
	function spf_selectCancel(item, dialog) {
		dialog.close();
	}
	function spf_selectClear(item, dialog) {
		$("#key").val("");
		$("#EMPID").val("");
		$("#NAME").val("");
		dialog.close();
	}

	/*
	 *弹出框收缩js
	 */
	function f_ChildWindowClose() {
		spf_search(); //加载数据
		$dialog.close();
	}

	function spf_search() {
		var year = $("#year").val();
		var month = $("#month").val();
		var empID = $("#EMPID").val();
		var name = $("#NAME").val();
		location.href = '/ess/infoApp/viewWorkhourCalendarInfo?MENU_CODE=ess0215&year='
				+ year
				+ "&month="
				+ month
				+ "&EMPID="
				+ empID
				+ "&NAME="
				+ name;
	}
	function gotob() {
		var year = $("#year").val();
		var month = $("#month").val();
		var empID = $("#EMPID").val();
		var name = $("#NAME").val();

		var myDate = new Date();
		myDate.setFullYear(year, month, 1);
		month = myDate.getMonth();

		if (month == 1 || month == 0) {
			year = Number(year) - Number(1);
			month = 12;
		} else if (month > 1 && month <= 12) {
			month = Number(month) - 1;
		}

		month = month < 10 ? "0" + month : "" + month;

		location.href = '/ess/infoApp/viewWorkhourCalendarInfo?MENU_CODE=ess0215&year='
				+ year
				+ "&month="
				+ month
				+ "&EMPID="
				+ empID
				+ "&NAME="
				+ name;
	}

	function gotoa() {
		var year = $("#year").val();
		var month = $("#month").val();
		var empID = $("#EMPID").val();
		var name = $("#NAME").val();

		var myDate = new Date();
		myDate.setFullYear(year, month, 1);
		month = myDate.getMonth();

		if (month == 12 || month == 0) {
			year = Number(year) + Number(1);
			month = 1;
		} else if (month >= 1 && month < 12) {
			month = Number(month) + Number(1);
		}

		month = month < 10 ? "0" + month : "" + month;

		location.href = '/ess/infoApp/viewWorkhourCalendarInfo?MENU_CODE=ess0215&year='
				+ year
				+ "&month="
				+ month
				+ "&EMPID="
				+ empID
				+ "&NAME="
				+ name;
	}
	function spf_showDetailData(empID, date) {
		var sDate = date;
		var eDate = date;
		$dialog = $.ligerWindow.show({
			isDrag : true,
			title : '<spring:message code="hrms.workingHoursInfo"/>',
			width : 750,
			height : 350,
			left : 260,
			top : 130,
			url : '/ess/viewApp/viewEmpWhInfo?C_FLAG=1&EMPID=' + empID
					+ '&S_DATE=' + sDate + '&E_DATE=' + eDate
		});
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
	<div id="layout1">
		<div position="top">
			<table width="100%" border="0">
				<tr>
					<td height="2"></td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" cellpadding="0" cellspacing="0"
							class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
							<tr>
								<td width="10%" class="l-table-edit-t"><spring:message
										code="keyWord" /></td>
								<td width="30%" class="l-table-edit-c"><input type="hidden"
									id="EMPID" name="EMPID" value="${paraMap.EMPID}"> <input
									type="text" name="key" id="key" size="30" onclick="searchEmp()"
									value="${paraMap.EMPID}" /></td>
								<td width="10%" class="l-table-edit-t"><spring:message
										code="hrms.name" /></td>
								<td width="30%" class="l-table-edit-c">
									<div id="chineseName"></div>${paraMap.NAME} <font style=""></font>
									<input type="hidden" id="NAME" name="NAME"
									value="${paraMap.NAME}">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div position="center">
			<table width="100%" border="0">
				<tr>
					<td height="2"></td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" align="center" cellpadding="0"
							cellspacing="0" class="l-table-edit_01" border="1xp"
							bordercolor="#A3C0E8">
							<tr>
								<td class="l-table-edit-t" colspan="7"><img alt=""
									src="/resources/images/icon-prev.gif"
									onclick="javascript:gotob();" style="cursor: pointer;">
									&nbsp;&nbsp;&nbsp; <SipingSoft:date yearName="year"
										yearSelected="${param.year}" monthName="month"
										monthSelected="${param.month}" onChange="spf_search();" />
									&nbsp;&nbsp;&nbsp; <img alt=""
									src="/resources/images/icon-next.gif"
									onclick="javascript:gotoa();" style="cursor: pointer;"></td>
							</tr>
							<tr>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><font color="red"><spring:message
											code="calendar.sunday" /></font></td>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.monday" /></td>
								<td height="22" width="100" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.tuesday" /></td>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.wednesday" /></td>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.thursday" /></td>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.friday" /></td>
								<td height="25" width="100" align="center"
									style="font-size: 12px;"><font color="red"><spring:message
											code="calendar.saturday" /></font></td>
							</tr>
							<tr>
								<td colspan="7"><br>${calendarHtml}</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
