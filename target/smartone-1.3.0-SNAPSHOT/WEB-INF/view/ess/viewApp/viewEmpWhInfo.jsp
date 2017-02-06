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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $spf_workingHours_initGrid;
	var $dialog;
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create : function(container, editParm) {
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue : function(input, editParm) {
			return input.val();
		},
		setValue : function(input, value, editParm) {
			input.val(value);
		},
		resize : function(input, width, height, editParm) {
			var column = editParm.column;
			if (column.editor.width)
				input.width(column.editor.width);
			else
				input.width(width);
			if (column.editor.height)
				input.height(column.editor.height);
			else
				input.height(height);
		}
	};
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			topHeight : 30,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
		spf_workingHours_initGrid();
	});
	var navtab = null;
	$(function() {
		$("#navtab1").ligerTab({
			onAfterSelectTabItem : function(tabid) {
				var empID = $("#EMPID").val();
				if (tabid == "tabitem1") {
					//报工详细
					spf_workingHours_initGrid();
				}
				if (tabid == "tabitem2") {
					//休假明细
					spf_ld_initGrid();
				}
			}
		});
	});
	//报工详细
	function spf_workingHours_initGrid() {
		$workingHours_grid = $("#workingHoursInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.empid"/>',
										name : 'EMPID',
										width : 80,
										totalSummary : {
											type : 'count'
										},
										frozen : true
									},
									{
										display : '<spring:message code="hrms.name"/>',
										name : 'CHINESENAME',
										width : 90,
										frozen : true
									},
									{
										display : '<spring:message code="hrms.dept"/>',
										name : 'DEPTNAME',
										width : 100,
										frozen : true
									},
									{
										display : '<spring:message code="hrms.date"/>',
										name : 'START_DATE',
										width : 100,
										type : 'date',
										format : 'yyyy-MM-dd',
										editor : {
											type : 'date'
										},
										frozen : true
									},
									{
										display : '<spring:message code="hrms.type"/>',
										name : 'TYPE_NAME',
										align : 'center',
										width : 90
									},
									{
										display : '<spring:message code="hrms.attItemName"/>',
										name : 'PRO_NAME',
										align : 'center',
										width : 90
									},
									{
										display : '<spring:message code="hrms.workingDescription"/>',
										name : 'WORK_CONTENT',
										width : 150,
										editor : {
											type : 'textarea',
											height : 100
										}
									},
									{
										display : '<spring:message code="hrms.workingHours"/>',
										name : 'WORK_HOUR',
										width : 100,
										align : 'right',
										editor : {
											type : 'float'
										},
										totalSummary : {
											type : 'sum'
										}
									},
									{
										display : '<spring:message code="hrms.remarks"/>',
										name : 'REMARK',
										width : 120,
										editor : {
											type : 'textarea',
											height : 100
										}
									} ],
							enabledEdit : true,
							usePager : false,
							rownumbers : true,
							url : "/ess/viewApp/getWorkingHoursInfo?ACTIVITY=4&EMPID=${paraMap.EMPID}&S_DATE=${paraMap.S_DATE}&E_DATE=${paraMap.E_DATE}",
							width : '99.6%',
							height : '99%'
						});
	}
	//休假明细
	function spf_ld_initGrid() {
		var sDate = '${paraMap.S_DATE}' + " 00:00:00";
		var eDate = '${paraMap.E_DATE}' + " 23:59:59";
		$grid = $("#ldInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.empid"/>',
										name : 'EMPID',
										width : 90
									},
									{
										display : '<spring:message code="hrms.name"/>',
										name : 'CHINESENAME'
									},
									{
										display : '<spring:message code="hrms.dept"/>',
										name : 'DEPTNAME'
									},
									{
										display : '<spring:message code="hrms.leaveType"/>',
										name : 'LEAVE_TYPE_NAME'
									},
									{
										display : '<spring:message code="hrms.startedTime"/>',
										name : 'LEAVE_FROM_TIME',
										width : 120
									},
									{
										display : '<spring:message code="hrms.endTime"/>',
										name : 'LEAVE_TO_TIME',
										width : 120
									},
									{
										display : '<spring:message code="hrms.leaveLength"/>',
										name : 'LEAVE_LENGTH'
									} ],
							usePager : true,
							url : '/ess/viewApp/getEmpLeaveDetailInfo?C_FLAG=${paraMap.C_FLAG}&EMPID=${paraMap.EMPID}&S_DATE='
									+ sDate + '&E_DATE=' + eDate,
							width : '99.6%',
							height : '99%'
						});
	}
	function spf_save() {
		var jsonData = '[';
		var rows = $workingHours_grid.getData();

		$(rows)
				.each(
						function(index, row) {
							if (this.__status != null
									&& this.__status == 'update') {
								if (this.WORK_CONTENT == null
										|| this.WORK_CONTENT == ''
										|| this.WORK_CONTENT == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.workingDescription"/>'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return false;
								}
								if (this.WORK_HOUR == null
										|| this.WORK_HOUR == ''
										|| this.WORK_HOUR == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.workingHours"/>'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return false;
								} else {
									if (jsonData.length > 1) {
										jsonData += ',{';
									} else {
										jsonData += '{';
									}
									jsonData += ' "WH_NO": "' + this.NO + '", ';
									jsonData += ' "EMPID": "' + this.EMPID
											+ '", ';
									jsonData += ' "PRO_NO": "' + this.PRO_ID
											+ '", ';
									jsonData += ' "WORK_CONTENT": "'
											+ MyCheckNull(this.WORK_CONTENT)
											+ '", ';
									jsonData += ' "WORK_HOUR": "'
											+ this.WORK_HOUR + '",';
									jsonData += ' "ACTIVITY": "0",';
									jsonData += ' "START_DATE": "'
											+ MyToDate(this.START_DATE) + '",';
									jsonData += ' "REMARK": "'
											+ MyCheckNull(this.REMARK) + '"';
									jsonData += '}';
								}
							}
						});

		jsonData += ']';

		if (jsonData.length == 2) {
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/ess/infoApp/updateWorkingHoursInfo", [ {
			name : 'jsonData',
			value : jsonData
		} ], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success(
						'<spring:message code="hrms.saveSuccess"/>',
						'<spring:message code="hrms.warning"/>', function() {
							$workingHours_grid.loadData(true); //加载数据  
							parent.f_ChildWindowClose();//加载数据  
						});
			} else {
				$.ligerMessageBox.error(
						'<spring:message code="hrms.warning"/>', result);
			}
		});
	}
	function spf_delete() {
		$.ligerDialog
				.confirm(
						'<spring:message code="hrms.whetherDelete"/>',
						'<spring:message code="hrms.warning"/>',
						function(yes) {
							if (yes) {
								var rows = $workingHours_grid.getSelectedRow();

								if (!rows || rows.length == 0) {
									$.ligerMessageBox
											.error(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.chooseLine"/>');
									return;
								}
								if (rows.length > 1) {
									alert('<spring:message code="hrms.onlyOneRow"/>');
									return;
								}

								$.ligerDialog
										.waitting('<spring:message code="hrms.deleting"/>');
								$
										.post(
												"/ess/viewApp/delWorkingHoursInfo",
												[ {
													name : 'NO',
													value : rows.NO
												}, {
													name : 'ACTIVITY',
													value : '0'
												}

												],
												function(result) {
													$.ligerDialog
															.closeWaitting();
													if (result == "Y") {
														$.ligerDialog
																.success(
																		'<spring:message code="hrms.deleteSuccess"/>',
																		'<spring:message code="hrms.warning"/>',
																		function() {
																			$workingHours_grid
																					.loadData(true); //加载数据  
																			parent
																					.f_ChildWindowClose();//加载数据  
																		});
													} else {
														$.ligerMessageBox
																.error(
																		'<spring:message code="hrms.warning"/>',
																		result);
													}
												});
							}
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
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><a class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_save()"><spring:message code="hrms.save" /></a> <a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_delete()"><spring:message code="hrms.delete" /></a></td>
				</tr>
			</table>
		</div>
		<div position="center">
			<div id="navtab1"
				style="width: 100%; overflow: hidden; border: 0px solid #A3C0E8;">
				<div title='<spring:message code="hrms.workingHoursInfo"/>'>
					<div id="workingHoursInfo"></div>
				</div>
				<div title='<spring:message code="hrms.leaveDetail"/>'>
					<div id="ldInfo"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
