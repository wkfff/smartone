<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
	<!-- CSS -->
	<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<!-- JS -->
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
	// 初始调用
	function f_save() {
		$("form .l-text,.l-textarea").ligerHideTip();
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		var options = {
			url: '/ar/attendanceMintenance/addArCardRecordInfo',
			type: 'POST',
			success: function(result) {
				$.ligerDialog.closeWaitting();
				if (result == "Y") {
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>',
					function() {
						parent.location.href = "/ar/attendanceMintenance/viewArCardRecord";
					});
				} else {
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			}
		};
		$('#form1').ajaxSubmit(options);
	}
	var $dialog;
	$(function() {

		$("#R_TIME").ligerDateEditor({
			showTime: true
		});
	});
	function searchEmp() {

		$dialog = $.ligerDialog.open({
			isDrag: false,
			width: $("#layout1").width() - 50,
			height: $("#layout1").height() + 250,
			url: '/ar/basic/viewArSearchEmployee?SELECT_TYPE=AR_SUPERVISOR'
		});
	}
	function initEmpId(data) {
		$("#name").html("");
		$("#deptName").html("");
		$("#name").html(data.CHINESENAME);
		$("#deptName").html(data.DEPTNAME);

		$("#empid").attr("value", data.EMPID);

		$dialog.close();
	}
</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99%;margin:0; padding:0;}
	.l-table-edit {}
	.l-table-edit-td{ padding:4px;}
	.l-button-submit,.l-button-test{width:80px; float:left; margin-left:10px; padding-bottom:2px;}
	.l-verify-tip{ left:230px; top:120px;
	h4{ margin:20px;}
</style>
</head>
<body style="padding: 0px">
	<div id='layout1'>
		<form name="form1" method="post" action="" id="form1">
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="right" class="l-table-edit-td">工号</td>
					<td align="left" class="l-table-edit-td"><input name="empid"
						type="text" id="empid" ltype="text" validate="{required:true}" />
					<div id="name"></div>
						<div id="deptName"></div></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right" class="l-table-edit-td">类型</td>
					<td align="left" class="l-table-edit-td"><SipingSoft:selectSyCode
							name="DoorType" parentCode="DoorType" /></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right" class="l-table-edit-td">日期</td>
					<td align="left" class="l-table-edit-td"><input name="R_TIME"
						type="text" id="R_TIME" validate="{required:true}" /></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="right" class="l-table-edit-td">备注</td>
					<td align="left" class="l-table-edit-td"><input name="remark"
						type="text" id="remark" ltype="text" /></td>
					<td align="left"></td>
				</tr>
				<tr>
					<td align="left" class="l-table-edit-td"></td>
					<td align="left" class="l-table-edit-td" height="30px"><a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 1px; "
						onclick="f_save()"><spring:message code="hrms.save" /></a></td>
					<td align="left"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>
