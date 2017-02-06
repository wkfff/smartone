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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $work_grid;
	var $item_grid;
	var $Flag = "W";
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

		$("#navtab1").ligerTab({
			onAfterSelectTabItem : function(tabid) {
				if (tabid == "tabitem1") {
					//已经分组人员  
					spf_initWorkInfoGrid();
					$Flag = "W";
				}
				if (tabid == "tabitem2") {
					//已经分组人员  
					spf_initItemInfoGrid();
					$Flag = "I";
				}
			}
		});
		spf_initWorkInfoGrid();
	});
	function spf_initWorkInfoGrid() {
		$work_grid = $("#workInfo").ligerGrid({
			checkbox : false,
			columns : [ {
				display : '<spring:message code="hrms.workingDescription"/>',
				name : 'EV_WORK_CONTENT',
				width : 560,
				align : 'left',
				editor : {
					type : 'textarea',
					height : 80
				}
			} ],
			enabledEdit : true,
			usePager : false,
			rownumbers : true,
			url : '/eva/empEvaInfo/getEvaEmpWorkInfo',
			width : '99.6%',
			height : '99%'

		});
	}
	function spf_initItemInfoGrid() {
		$item_grid = $("#itemInfo").ligerGrid({
			checkbox : false,
			columns : [ {
				display : '<spring:message code="hrms.item"/>',
				name : 'EV_ITEM',
				width : 280,
				align : 'left',
				editor : {
					type : 'textarea',
					height : 40
				}
			}, {
				display : '<spring:message code="hrms.percentage"/>',
				name : 'EV_PERCENTAGE',
				type : 'float',
				width : 90,
				editor : {
					type : 'float'
				},
				totalSummary : {
					type : 'sum'
				}
			} ],
			enabledEdit : true,
			usePager : false,
			rownumbers : true,
			url : '/eva/empEvaInfo/getEvaEmpItemInfo',
			width : '99.6%',
			height : '99%'

		});
	}
	function spf_save() {
		var jsonData = '[';
		var strURL = "";

		if ($Flag == 'W') {
			var rows = $work_grid.getData();
			if (!rows || rows.length == 0) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
						'<spring:message code="hrms.chooseLine"/>');
				return;
			}
			strURL = "/eva/empEvaInfo/saveAndUpdateEvaEmpWorkInfo";
			$(rows)
					.each(
							function(index, row) {
								if (this.EV_WORK_CONTENT == null
										|| this.EV_WORK_CONTENT == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.workingDescription"/>'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return;
								} else {
									if (jsonData.length > 1) {
										jsonData += ',{';
									} else {
										jsonData += '{';
									}
									jsonData += ' "__status": "'
											+ this.__status + '", ';
									jsonData += ' "ORDERNO": "' + index + '", ';
									jsonData += ' "NO": "'
											+ MyCheckNull(this.NO) + '", ';
									jsonData += ' "EV_EMPID": "${paraMap.EMPID }", ';
									jsonData += ' "TURN_TYPE_CODE": "${paraMap.TURN_TYPE_CODE }", ';
									jsonData += ' "EV_START_DATE": "", ';
									jsonData += ' "EV_END_DATE": "", ';
									jsonData += ' "EV_SCORE": "0", ';
									jsonData += ' "EV_WORK_CONTENT": "'
											+ this.EV_WORK_CONTENT + '"';
									jsonData += '}';
								}
							});
		}

		if ($Flag == 'I') {
			var rows = $item_grid.getData();
			if (!rows || rows.length == 0) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
						'<spring:message code="hrms.chooseLine"/>');
				return;
			}
			strURL = "/eva/empEvaInfo/saveAndUpdateEvaEmpItemInfo";
			$(rows)
					.each(
							function(index, row) {
								if (this.EV_ITEM == null
										|| this.EV_ITEM == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.item"/>'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return;
								}
								if (this.EV_PERCENTAGE == null
										|| this.EV_PERCENTAGE == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.percentage"/>'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return;
								} else {
									if (jsonData.length > 1) {
										jsonData += ',{';
									} else {
										jsonData += '{';
									}
									jsonData += ' "__status": "'
											+ this.__status + '", ';
									jsonData += ' "ORDERNO": "' + index + '", ';
									jsonData += ' "NO": "'
											+ MyCheckNull(this.NO) + '", ';
									jsonData += ' "EV_EMPID": "${paraMap.EMPID }", ';
									jsonData += ' "TURN_TYPE_CODE": "${paraMap.TURN_TYPE_CODE }", ';
									jsonData += ' "EV_PERCENTAGE": "'
											+ this.EV_PERCENTAGE + '", ';
									jsonData += ' "EV_ITEM": "' + this.EV_ITEM
											+ '"';
									jsonData += '}';
								}
							});
		}

		jsonData += ']';

		if (jsonData.length == 2) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.editData"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
		$.post(strURL, [ {
			name : 'jsonData',
			value : jsonData
		}, {
			name : 'EMPID',
			value : '${paraMap.EMPID }'
		}, {
			name : 'TURN_TYPE_CODE',
			value : '${paraMap.TURN_TYPE_CODE }'
		}, {
			name : 'END_PROBATION_DATE',
			value : '${paraMap.END_PROBATION_DATE }'
		} ], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success(
						'<spring:message code="hrms.submitSuccess"/>',
						'<spring:message code="hrms.warning"/>', function() {
							if ($Flag == 'W') {
								$work_grid.loadData(true);//加载数据  
							}
							if ($Flag == 'I') {
								$item_grid.loadData(true);//加载数据 
							}
						});
			} else {
				$.ligerMessageBox.error(
						'<spring:message code="hrms.warning"/>', result);
			}
		});
	}
	function spf_add() {
		if ($Flag == 'W') {
			$work_grid.addRow();
		}
		if ($Flag == 'I') {
			$item_grid.addRow();
		}
	}
	function spf_delete() {
		var row = "";
		var strURL = "";
		if ($Flag == 'W') {
			row = $work_grid.getSelectedRow();
			strURL = "/eva/empEvaInfo/deleteEvaEmpWorkInfo";
		}
		if ($Flag == 'I') {
			row = $item_grid.getSelectedRow();
			strURL = "/eva/empEvaInfo/deleteEvaEmpItemInfo";
		}
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog
				.confirm(
						'<spring:message code="hrms.whetherDelete"/>',
						'<spring:message code="hrms.warning"/>',
						function(yes) {
							if (yes) {

								$.ligerDialog
										.waitting('<spring:message code="hrms.deleting"/>');
								$
										.post(
												strURL,
												[ {
													name : 'NO',
													value : row.NO
												} ],
												function(result) {
													$.ligerDialog
															.closeWaitting();
													if (result == "Y") {
														$.ligerDialog
																.success(
																		'<spring:message code="hrms.deleteSuccess"/>',
																		'<spring:message code="hrms.warning"/>',
																		function() {
																			if ($Flag == 'W') {
																				$work_grid
																						.loadData(true);//加载数据  
																			}
																			if ($Flag == 'I') {
																				$item_grid
																						.loadData(true);//加载数据 
																			}
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
	font-size: 12px;
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
	<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
		class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		<tr>
			<td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.empid" /></td>
			<td width="20%" class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.EMPID }</td>
			<td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.name" /></td>
			<td width="20%" class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.CHINESENAME }</td>
			<td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.dept" /></td>
			<td width="20%" class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.DEPTNAME }</td>
		</tr>
		<tr>
			<td class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.EmpStatus" /></td>
			<td class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.STATUS_NAME}</td>
			<td class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.hireDate" /></td>
			<td class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.JOIN_DATE }</td>
			<td class="l-table-edit-t" nowrap="nowrap"><spring:message
					code="hrms.endProbationDate" /></td>
			<td class="l-table-edit-c" nowrap="nowrap">
				${basicInfo.END_PROBATION_DATE}</td>
		</tr>
	</table>
	<br>
	<div id="navtab1"
		style="width: 99.6%; overflow: hidden; border: 1px solid #A3C0E8;">
		<div title='工作计划'>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
			<div id="workInfo"></div>
		</div>
		<div title='评价项目'>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
			<div id="itemInfo"></div>
		</div>
	</div>
</body>
</html>
