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
	var $evTypeItemSelectList;
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

		$evTypeItemSelectList = getEvTypeItemSelectList();
		spf_initGrid();

	});

	function getEvTypeItemSelectList() {
		//请求服务器
		var evTypeItemSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getEvTypeItemSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				evTypeItemSelectList = list;
			}
		});

		return evTypeItemSelectList;
	}
	function spf_initGrid() {
		$grid = $("#info")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.type"/>'
												+ ' '
												+ '<spring:message code="name"/>',
										name : 'EV_TYPE_NAME',
										width : 90
									},
									{
										display : '<spring:message code="hrms.item"/>'
												+ ' '
												+ '<spring:message code="name"/>',
										name : 'EV_ITEM_ID',
										width : 130,
										align : 'center',
										editor : {
											type : 'select',
											data : $evTypeItemSelectList,
											dataValueField : 'EV_ITEM_ID',
											dataDisplayField : 'EV_ITEM_NAME',
											displayColumnName : 'EV_ITEM_NAME',
											valueColumnName : 'EV_ITEM_ID'
										},
										render : function(item) {
											for ( var i = 0; i < $evTypeItemSelectList.length; i++) {
												if ($evTypeItemSelectList[i]['EV_ITEM_ID'] == item.EV_ITEM_ID) {
													return $evTypeItemSelectList[i]['EV_ITEM_NAME'];

												}
											}
											return item.EV_ITEM_NAME;
										}
									},
									{
										display : '<spring:message code="hrms.percentage"/>',
										name : 'EV_PERCENTAGE',
										type : 'float',
										width : 90,
										editor : {
											type : 'float'
										}
									},
									{
										display : '<spring:message code="hrms.description"/>',
										name : 'DESCRIPTION',
										width : 120,
										editor : {
											type : 'textarea',
											height : 100
										}
									},
									{
										display : '<spring:message code="hrms.remarks"/>',
										name : 'REMARK',
										align : 'left',
										width : 120,
										editor : {
											type : 'textarea',
											height : 100
										}
									} ],
							enabledEdit : true,
							usePager : false,
							rownumbers : true,
							url : '/eva/basicInfo/getEvaPeriodTypeItemInfo?EV_PERIOD_ID=${paraMap.EV_PERIOD_ID}&EV_TYPE_ID=${paraMap.EV_TYPE_ID}',
							width : '99.6%',
							height : '100%'
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
							index = Number(index) + Number(1);
							if (this.EV_ITEM_ID == null
									|| this.EV_ITEM_ID == 'undefined') {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.item"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return;
							}
							if (this.EV_PERCENTAGE == null) {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.percentage"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return false;
							} else {
								if (jsonData.length > 1) {
									jsonData += ',{';
								} else {
									jsonData += '{';
								}
								jsonData += ' "__status": "' + this.__status
										+ '", ';
								jsonData += ' "EV_PERIOD_ID": "${paraMap.EV_PERIOD_ID}", ';
								jsonData += ' "EV_TYPE_ID": "${paraMap.EV_TYPE_ID}", ';
								jsonData += ' "EV_ITEM_ID": "'
										+ this.EV_ITEM_ID + '", ';
								jsonData += ' "EV_PERCENTAGE": "'
										+ this.EV_PERCENTAGE + '", ';
								jsonData += ' "EV_ITEM_ORDER": "' + index
										+ '", ';
								jsonData += ' "DESCRIPTION": "'
										+ MyCheckNull(this.DESCRIPTION) + '",';
								jsonData += ' "REMARK": "'
										+ MyCheckNull(this.REMARK) + '"';
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
		$.post("/eva/basicInfo/saveAndUpdateEvaPeriodTypeItemInfo", [ {
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
				name : 'keyWord',
				value : $("#keyWord").attr('value')
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
						EV_PERIOD_ID : this.EV_PERIOD_ID,
						EV_TYPE_ID : this.EV_TYPE_ID,
						EV_TYPE_NAME : this.EV_TYPE_NAME,
						EV_ITEM_ID : this.EV_ITEM_ID,
						EV_PERCENTAGE : this.EV_PERCENTAGE,
						DESCRIPTION : this.DESCRIPTION,
						REMARK : this.REMARK
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
												'/eva/basicInfo/deleteEvaPeriodTypeItemInfo',
												[ {
													name : 'EV_PERIOD_ID',
													value : row.EV_PERIOD_ID
												}, {
													name : 'EV_TYPE_ID',
													value : row.EV_TYPE_ID
												}, {
													name : 'EV_ITEM_ID',
													value : row.EV_ITEM_ID
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
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><a class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_save()"><spring:message code="hrms.save" /></a> <a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_add()"><spring:message code="hrms.add" /></a> <a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_delete()"><spring:message code="hrms.delete" /></a></td>
				</tr>
			</table>
		</div>
		<div position="center" id="info"></div>
	</div>
</body>
</html>
