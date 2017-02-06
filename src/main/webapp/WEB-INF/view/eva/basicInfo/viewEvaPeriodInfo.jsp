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
	var $grid;
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
			topHeight : 60,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});

		spf_initGrid();

	});

	function spf_initGrid() {
		$grid = $("#info").ligerGrid({
			checkbox : false,
			columns : [ {
				display : '<spring:message code="hrms.year"/>',
				name : 'EV_YEAR',
				width : 120,
				type : 'date',
				format : 'yyyy',
				editor : {
					type : 'date'
				}
			}, {
				display : '<spring:message code="hrms.duration"/>',
				name : 'EV_PERIOD_ID',
				width : 120,
				type : 'date',
				format : 'yyyyMM',
				editor : {
					type : 'date'
				}
			}, {
				display : '<spring:message code="hrms.chineseName"/>',
				name : 'EV_PERIOD_NAME',
				width : 120,
				editor : {
					type : 'text'
				}
			}, {
				display : '<spring:message code="hrms.englishName"/>',
				name : 'EV_PERIOD_EN_NAME',
				width : 120,
				editor : {
					type : 'text'
				}
			}, {
				display : '<spring:message code="hrms.startDate"/>',
				name : 'EV_START_DATE',
				width : 120,
				type : 'date',
				format : 'yyyy-MM-dd',
				editor : {
					type : 'date'
				}
			}, {
				display : '<spring:message code="hrms.endDate"/>',
				name : 'EV_END_DATE',
				width : 120,
				type : 'date',
				format : 'yyyy-MM-dd',
				editor : {
					type : 'date'
				}
			},

			{
				display : '<spring:message code="hrms.description"/>',
				name : 'EV_DESCRIPTION',
				width : 180,
				editor : {
					type : 'textarea',
					height : 100
				}
			}, {
				display : '<spring:message code="hrms.remarks"/>',
				name : 'EV_REMARK',
				align : 'left',
				width : 180,
				editor : {
					type : 'textarea',
					height : 100
				}
			} ],
			enabledEdit : true,
			usePager : false,
			rownumbers : true,
			url : '/eva/basicInfo/getEvaPeriodInfo',
			parms : [ {
				name : 'EV_PERIOD_ID',
				value : $("#year").attr('value') + $("#month").attr('value')
			}, {
				name : 'EV_YEAR',
				value : $("#year").attr('value')
			}, {
				name : 'EV_MONTH',
				value : $("#month").attr('value')
			} ],
			width : '99.6%',
			height : '100%',
			onDblClickRow : function(rowdata, rowindex, rowDomElement) {
				spf_showEvaPeriodTypeInfo(MyCheckNull(rowdata.EV_PERIOD_ID));
			}
		});
	}

	function spf_showEvaPeriodTypeInfo(evPeriodID) {
		$dialog = $.ligerWindow.show({
			isDrag : true,
			title : '<spring:message code="hrms.typeInfo"/>',
			width : 800,
			height : 380,
			left : 150,
			top : 60,
			url : '/eva/basicInfo/viewEvaPeriodTypeInfo?EV_PERIOD_ID='
					+ evPeriodID
		});
	}
	function spf_save() {
		var jsonData = '[';

		var rows = $grid.getData();

		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$(rows)
				.each(
						function(index, row) {
							if (this.EV_YEAR == null
									|| this.EV_YEAR == 'undefined') {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.year"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return;
							}
							if (this.EV_PERIOD_ID == null
									|| this.EV_PERIOD_ID == 'undefined') {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.duration"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return;
							}
							if (this.EV_PERIOD_NAME == null
									|| this.EV_PERIOD_NAME == 'undefined') {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.chineseName"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return;
							} else {
								if (jsonData.length > 1) {
									jsonData += ',{';
								} else {
									jsonData += '{';
								}
								jsonData += ' "__status": "' + this.__status
										+ '", ';
								jsonData += ' "EV_PERIOD_NO": "'
										+ MyCheckNull(this.EV_PERIOD_NO)
										+ '", ';
								jsonData += ' "EV_YEAR": "'
										+ MyToYear(this.EV_YEAR) + '", ';
								jsonData += ' "EV_PERIOD_ID": "'
										+ MyToYearAndMonth(this.EV_PERIOD_ID)
										+ '", ';
								jsonData += ' "EV_PERIOD_NAME": "'
										+ this.EV_PERIOD_NAME + '", ';
								jsonData += ' "EV_PERIOD_EN_NAME": "'
										+ MyCheckNull(this.EV_PERIOD_EN_NAME)
										+ '", ';
								jsonData += ' "EV_START_DATE": "'
										+ MyToDate(this.EV_START_DATE) + '", ';
								jsonData += ' "EV_END_DATE": "'
										+ MyToDate(this.EV_END_DATE) + '", ';
								jsonData += ' "EV_DESCRIPTION": "'
										+ MyCheckNull(this.EV_DESCRIPTION)
										+ '",';
								jsonData += ' "EV_REMARK": "'
										+ MyCheckNull(this.EV_REMARK) + '"';
								jsonData += '}';
							}
						});

		jsonData += ']';

		if (jsonData.length == 2) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.editData"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
		$.post("/eva/basicInfo/saveAndUpdateEvaPeriodInfo", [ {
			name : 'jsonData',
			value : jsonData
		} ], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success(
						'<spring:message code="hrms.submitSuccess"/>',
						'<spring:message code="hrms.warning"/>', function() {
							$grid.loadData(true);//加载数据 
						});
			} else {
				$.ligerMessageBox.error(
						'<spring:message code="hrms.warning"/>', result);
			}
		});
	}

	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据 
	}

	function spf_search() {
		$grid.setOptions({
			parms : [ {
				name : 'EV_PERIOD_ID',
				value : $("#year").attr('value') + $("#month").attr('value')
			}, {
				name : 'EV_YEAR',
				value : $("#year").attr('value')
			}, {
				name : 'EV_MONTH',
				value : $("#month").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数 
		$grid.loadData(true); //加载数据
	}
	function spf_add() {
		var rows = $grid.getData();
		if (!rows || rows.length == 0) {
			$grid.addRow();
		} else {
			$(rows).each(function(index, row) {
				if (index == rows.length - 1) {
					$grid.addRow({
						EV_YEAR : this.EV_YEAR,
						EV_PERIOD_ID : this.EV_PERIOD_ID,
						EV_PERIOD_NAME : this.EV_PERIOD_NAME,
						EV_PERIOD_EN_NAME : this.EV_PERIOD_EN_NAME,
						EV_START_DATE : this.EV_START_DATE,
						EV_END_DATE : this.EV_END_DATE,
						EV_DESCRIPTION : this.EV_DESCRIPTION,
						EV_REMARK : this.EV_REMARK
					});
				}
			});
		}
	}
	function spf_delete() {
		var row = $grid.getSelectedRow();

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
												'/eva/basicInfo/deleteEvaPeriodInfo',
												[ {
													name : 'EV_PERIOD_NO',
													value : row.EV_PERIOD_NO
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
																			$grid
																					.loadData(true);//加载数据 
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
			<table width="100%" border="0">
				<tr>
					<td height="2"></td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" cellpadding="0" cellspacing="0"
							class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
							<tr>
								<td width="15%" class="l-table-edit-t"><spring:message
										code="keyWord" /></td>
								<td width="35%" class="l-table-edit-c"><input
									name="keyWord" type="text" id="keyWord" size="30" /></td>
								<td width="15%" class="l-table-edit-t"><spring:message
										code="hrms.duration" /></td>
								<td width="35%" class="l-table-edit-c"><SipingSoft:date
										yearName="year" yearSelected="" monthName="month"
										monthSelected="" limit="all" onChange="spf_search();" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
		</div>
		<div position="center" id="info"></div>
	</div>
</body>
</html>
