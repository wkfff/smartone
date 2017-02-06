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

<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $work_grid;
	var $item_grid;
	var $Flag = "";
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
			topHeight : 160,
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
				}
				if (tabid == "tabitem2") {
					//已经分组人员   
					spf_initItemInfoGrid();
				}
			}
		});
		spf_initWorkInfoGrid();
	});
	function spf_initWorkInfoGrid() {
		$work_grid = $("#workInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.workingDescription"/>',
										name : 'EV_WORK_CONTENT',
										width : 380,
										align : 'left',
										editor : {
											type : 'textarea',
											height : 80
										}
									}, {
										display : '完成度(自评)',
										name : 'EV_S_WORK',
										width : 380,
										align : 'left',
										editor : {
											type : 'textarea',
											height : 80
										}
									} ],
							enabledEdit : true,
							usePager : false,
							rownumbers : true,
							url : '/eva/empEvaInfo/getEvaEmpWorkInfo?EV_EMPID=${paraMap.EMPID}&TURN_TYPE_CODE=${paraMap.TURN_TYPE_CODE}',
							width : '99.6%',
							height : '99%'

						});
	}
	function spf_initItemInfoGrid() {
		$item_grid = $("#itemInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.item"/>',
										name : 'EV_ITEM',
										width : 280,
										align : 'left',
										editor : {
											type : 'textarea',
											height : 40
										}
									},
									{
										display : '<spring:message code="hrms.percentage"/>',
										name : 'EV_PERCENTAGE',
										type : 'float',
										width : 120,
										editor : {
											type : 'float'
										},
										totalSummary : {
											type : 'sum'
										}
									},
									{
										display : '<spring:message code="hrms.percentage"/>'
												+ '(自评)',
										name : 'EV_S_SCORE',
										type : 'float',
										width : 120,
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
							url : '/eva/empEvaInfo/getEvaEmpItemInfo?EV_EMPID=${paraMap.EMPID}&TURN_TYPE_CODE=${paraMap.TURN_TYPE_CODE}',
							width : '99.6%',
							height : '99%'

						});
	}
	function spf_save(flag, activity) {
		$Flag = flag;
		var jsonData = '[';
		var strURL = "";

		if ($Flag == 'W') {
			var rows = $work_grid.getData();
			if (!rows || rows.length == 0) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
						'<spring:message code="hrms.chooseLine"/>');
				return;
			}
			strURL = "/ess/infoView/updateEssEmpOngoingWorkInfo";
			$(rows)
					.each(
							function(index, row) {
								if (this.EV_S_WORK == null
										|| this.EV_S_WORK == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'完成度(自评)'
															+ ". "
															+ '<spring:message code="input.required"/>');
									return false;
								} else {
									if (jsonData.length > 1) {
										jsonData += ',{';
									} else {
										jsonData += '{';
									}
									jsonData += ' "__status": "'
											+ this.__status + '", ';
									jsonData += ' "NO": "'
											+ MyCheckNull(this.NO) + '", ';
									jsonData += ' "EV_S_WORK": "'
											+ this.EV_S_WORK + '"';
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
			strURL = "/ess/infoView/updateEssEmpOngoingItemInfo";
			$(rows)
					.each(
							function(index, row) {
								if (this.EV_S_SCORE == '0'
										|| this.EV_S_SCORE == null
										|| this.EV_S_SCORE == 'undefined') {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.percentage"/>'
															+ "(自评). "
															+ '<spring:message code="input.required"/>');
									return false;
								} else {
									if (jsonData.length > 1) {
										jsonData += ',{';
									} else {
										jsonData += '{';
									}
									jsonData += ' "__status": "'
											+ this.__status + '", ';
									jsonData += ' "NO": "'
											+ MyCheckNull(this.NO) + '", ';
									jsonData += ' "EV_S_SCORE": "'
											+ this.EV_S_SCORE + '"';
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
			name : 'ACTIVITY',
			value : activity
		}, {
			name : 'EMPID',
			value : '${paraMap.EMPID}'
		}, {
			name : 'TURN_TYPE_CODE',
			value : '${paraMap.TURN_TYPE_CODE}'
		} ], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success(
						'<spring:message code="hrms.submitSuccess"/>',
						'<spring:message code="hrms.warning"/>', function() {
							parent.f_ChildWindowClose();
						});
			} else {
				$.ligerMessageBox.error(
						'<spring:message code="hrms.warning"/>', result);
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
	<div id="layout1">
		<div position="top">
			<%@include file="viewBasicInfo.jsp"%>
		</div>
		<div position="center">
			<div id="navtab1"
				style="width: 99.6%; overflow: hidden; border: 0px solid #A3C0E8;">
				<div title='工作计划'>
					<c:if
						test="${paraMap.EV_S_WORK_FLAG == '0' || paraMap.EV_S_WORK_FLAG == '1'}">
						<table cellpadding="0" cellspacing="0" class="l-table-edit"
							height="30px;">
							<tr>
								<td align="left"><a class="l-button"
									style="width: 79px; height: 20px; float: left; margin-left: 10px; "
									onclick="spf_save('W',1)"><spring:message code="hrms.save" /></a>
									<a class="l-button"
									style="width: 79px; height: 20px; float: left; margin-left: 10px; "
									onclick="spf_save('W',2)"><spring:message code="submit" /></a>

								</td>
							</tr>
						</table>
					</c:if>
					<div id="workInfo"></div>
				</div>
				<div title='评价项目'>
					<c:if
						test="${paraMap.EV_S_ITEM_FLAG == '0' || paraMap.EV_S_ITEM_FLAG == '1'}">
						<table cellpadding="0" cellspacing="0" class="l-table-edit"
							height="30px;">
							<tr>
								<td align="left"><a class="l-button"
									style="width: 79px; height: 20px; float: left; margin-left: 10px; "
									onclick="spf_save('I',1)"><spring:message code="hrms.save" /></a>
									<a class="l-button"
									style="width: 79px; height: 20px; float: left; margin-left: 10px; "
									onclick="spf_save('I',2)"><spring:message code="submit" /></a>
								</td>
							</tr>
						</table>
					</c:if>
					<div id="itemInfo"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
