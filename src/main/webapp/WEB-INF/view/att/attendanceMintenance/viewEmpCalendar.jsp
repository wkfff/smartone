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
	var $grid ;
	var $dialog ;
	// 初始调用
	$(function (){
		//布局
		$("#layout1").ligerLayout({
			topHeight: 463,
			allowLeftResize: false,//是否允许 左边可以调整大小
			allowRightResize: false,//是否允许 右边可以调整大小
			allowTopResize: false,//是否允许 头部可以调整大小
			allowBottomResize: false//是否允许 底部可以调整大小
		});
		$("#empName").ligerComboBox({
			onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
		}); 
	});
	function spf_selectEmp(){
		$.ligerDialog.open({ 
			title: '<spring:message code="employee.information"/>', 
			name:'winselector'+Math.random(),
			width: 800, 
			height: 400, 
			url: '/utility/empInfo/viewHrSearchEmployeeB', 
			buttons: [
					{ text: '<spring:message code="okay"/>', onclick: spf_selectOK },
					{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
					{ text: '<spring:message code="clear"/>', onclick: spf_selectClear }
			]
		});
		return false;
	}
	function spf_selectOK(item, dialog){
		var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
		var data = fn(); 
		if (!data){
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return;
		}
		$("#empName").val(data.EMPID+","+data.CHINESENAME);
		$("#EMPID").val(data.EMPID);  
		spf_search();
		dialog.close();
	}
	function spf_selectCancel(item, dialog){
		dialog.close();
	}
	function spf_selectClear(item, dialog){
		$("#empName").val("");
		$("#EMPID").val(""); 
		dialog.close();
	}
	function spf_initSelectEmpInfo(data){ 
			$("#empName").attr("value", data.CHINESENAME) ;
			$("#EMPID").attr("value", data.EMPID) ;    
			$("#deptName").html(data.DEPTNAME) ; 
			$dialog.close() ;
	}
	function initEmpId(data){
		$dialog.close() ;
		var url=( location.href).split("?");
		location.href=url[0]+"?empid="+data.EMPID+"&name="+data.CHINESENAME+"&deptname="+data.DEPTNAME;
	}
	function spf_save(){
			var year = $("#year").val() ;
			var month = $("#month").val() ;
			var empID = $("#EMPID").val() ;
			var jsonData = '[' ;
			$(":checkbox").each(function (){
				if(this.checked){ 
					if (jsonData.length > 1){
					jsonData += ',{'
					}else{
						jsonData += '{'
					}
					jsonData += ' "DDATE_STR": "'+ this.value + '",' ;
					jsonData += ' "EMPID": "'+$("#EMPID").val()+'",' ;
					jsonData += ' "SHIFT_NO": "' + $("#SHIFT_NO_"+this.value).val() + '" ' ;
					jsonData += '}' ;
				}
			});
			jsonData += ']' ;
			if (jsonData.length == 2){
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}

			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/att/attendanceMintenance/updateEmpCalendarInfo", 
				[
					{ name: 'jsonData', value: jsonData }
				]
			, function (result){
				if (result == "Y"){
					$.ligerDialog.closeWaitting();
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						location.href= "/att/attendanceMintenance/viewEmpCalendar?MENU_CODE=ar0101&year="+year+"&month="+month+"&EMPID="+empID; 
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}

	function spf_search(){
		var year = $("#year").val() ;
		var month = $("#month").val() ;
		var empID = $("#EMPID").val() ;

		location.href = '/att/attendanceMintenance/viewEmpCalendar?MENU_CODE=ar0101&year=' + year + "&month=" + month+"&EMPID="+empID;
	}
	function gotob(){
		var year = $("#year").val() ;
		var month = $("#month").val() ;
		var empID = $("#EMPID").val() ;
		var myDate=new Date();
		myDate.setFullYear(year, month, 1);
		month = myDate.getMonth() ;
		if(month==1||month == 0){
			year=Number(year)-Number(1);
			month=12;
		}else if(month>1&&month<=12){
			month=Number(month)-1;
		}
		month = month < 10 ? "0" + month : "" + month ;
		location.href = '/att/attendanceMintenance/viewEmpCalendar?MENU_CODE=ar0101&year=' + year + "&month=" + month+"&EMPID="+empID;
	}

	function gotoa(){
		var year = $("#year").val() ;
		var month = $("#month").val() ;
		var empID = $("#EMPID").val() ;
		var myDate=new Date();
		myDate.setFullYear(year, month, 1);
		month = myDate.getMonth() ;
		if(month == 12||month == 0){
			year = Number(year) + Number(1);
			month = 1;
		}else if(month >= 1 && month < 12){
			month = Number(month) + Number(1) ;
		}
		month = month < 10 ? "0" + month : "" + month ;
		location.href = '/att/attendanceMintenance/viewEmpCalendar?MENU_CODE=ar0101&year=' + year + "&month=" + month+"&EMPID="+empID;
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
						<table width="99.6%" align="center" cellpadding="0"
							cellspacing="0" class="l-table-edit_01" border="1xp"
							bordercolor="#A3C0E8">
							<tr>
								<td class="l-table-edit-t"><input id="empName"
									name="empName" type="text"  value="${basicInfo.CHINESENAME}" />
									<input type="hidden" id="EMPID" name="EMPID" value="${basicInfo.EMPID}" /></td>
								<td class="l-table-edit-t" nowrap="nowrap" colspan="2">
									<div id="deptName">${basicInfo.DEPTNAME}</div>
								</td>
								<td class="l-table-edit-t" colspan="2"><img alt=""
									src="/resources/images/icon-prev.gif"
									onclick="javascript:gotob();" style="cursor: pointer;">
									&nbsp;&nbsp;&nbsp; <SipingSoft:date yearName="year"
										yearSelected="${param.year}" monthName="month"
										monthSelected="${param.month}" onChange="spf_search();" />
									&nbsp;&nbsp;&nbsp; <img alt=""
									src="/resources/images/icon-next.gif"
									onclick="javascript:gotoa();" style="cursor: pointer;"></td>
								<td class="l-table-edit-tr" colspan="2"><SipingSoft:button /></td>
							</tr>
							<tr>
								<td height="25" width="14%" align="center"><font
									color="red" style="font-size: 12px;"><spring:message
											code="calendar.sunday" /></font></td>
								<td height="25" width="14%" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.monday" /></td>
								<td height="22" width="14%" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.tuesday" /></td>
								<td height="25" width="14%" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.wednesday" /></td>
								<td height="25" width="14%" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.thursday" /></td>
								<td height="25" width="14%" align="center"
									style="font-size: 12px;"><spring:message
										code="calendar.friday" /></td>
								<td height="25" width="14%" align="center"
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
