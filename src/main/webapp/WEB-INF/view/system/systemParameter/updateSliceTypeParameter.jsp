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
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid = null;
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
		f_initGrid();
	});

	function f_initGrid() {
		$grid = $("#sliceTypeDetail").ligerGrid(
			{
				checkbox : false,
				columns : [
				{ display: '', 
				    name: 'DETAIL_NO',
				    width: '0%',
				    hide:true,
				    type: 'int'
				   },
					{ display: '起始厚度:(mm)', 
					    name: 'MIN_THICKNESS',
					    width: '20%',
					    type: 'int',
					    editor : {
								type : 'text'
							}
					   },
					   { display: '结束厚度:(mm)', 
					     name: 'MAX_THICKNESS',
					     width: '20%',
					     type: 'int',
					     editor : {
								type : 'text'
							}
					   },
						{
							display : '单价:(元/米)',
							name : 'UNIT_PRICE',
							width : '20%',
							type : 'float',
							editor : {
								type : 'text'
							}
						},
						{
							display : '<spring:message code="hrms.remarks"/>',
							name : 'REMARKS',
							align : 'left',
							width : '35%',
							editor : {
								type : 'textarea',
								height : 100
							}
						} 
				],
				enabledEdit : true,
				usePager : true,
				rownumbers : true,
				pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
				isScroll : false,
				showToggleColBtn : false,
				width : '99.6%',
				height:'99.6%',
				url : '/system/systemParameter/getSliceTypeDetail?PARAMETER_NO='+"${paraMap.PARAMETER_NO}",
				showTitle : false
			});
	}
	
	function spf_add() {
		$grid.addRow();
	}
	
	function spf_save() {
		var row = $grid.getSelectedRow();
		//alert(row.MIN_THICKNESS);
		var data = $grid.getData();
		var jsonData = JSON2.stringify(data);
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return false;
		}
		
		if (row.MIN_THICKNESS == null|| row.MIN_THICKNESS == ''|| row.MIN_THICKNESS == 'undefined') {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','起始厚度'
					+ ". "+ '<spring:message code="input.required"/>');
				return false;
		}
		if (row.MAX_THICKNESS == null || row.MAX_THICKNESS == ''|| row.MAX_THICKNESS == 'undefined') {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','结束厚度'
					+ ". "+ '<spring:message code="input.required"/>');
			return false;
		}
		if (row.UNIT_PRICE == null || row.UNIT_PRICE == ''|| row.UNIT_PRICE == 'undefined') {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','单价'
				+ ". "+ '<spring:message code="input.required"/>');
			return false;
		} 
		
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/system/systemParameter/saveAndUpdateSliceTypeDetail",
			[ {name : 'jsonData',value : jsonData},
			  {name : 'PARAMETER_NO',value : "${paraMap.PARAMETER_NO}"}
			],
			function(result) {
				$.ligerDialog.closeWaitting();
					if (result == "Y") {
						$.ligerDialog.success(
								'<spring:message code="hrms.saveSuccess"/>',
								'<spring:message code="hrms.warning"/>',
								function() {
									$grid.loadData(true); //加载数据 
								});
					} else {
						$.ligerMessageBox.error(
								'<spring:message code="hrms.warning"/>', result);
					}
				}
			);
	}
	function spf_checkData() {
		var rows = $grid.getCheckedRows();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return false;
		}
		return true;
	}
	function spf_delete() {
		var rows = $grid.getSelectedRow();
		//alert(rows.DETAIL_NO);
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>',
		function(yes) {
			if (yes) {
				$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
				$.post('/system/systemParameter/deleteSliceTypeDetail',
				[ {
					name : 'DETAIL_NO',
					value : rows.DETAIL_NO
				}],
				function(result) {
					$.ligerDialog.closeWaitting();
					if (result == "Y") {
						$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>',
							function() {
								$grid.loadData(true); //加载数据  
							});
					} else {
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>',result);
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
			<table width="99.5%" cellpadding="1" cellspacing="1"
				style="font-size: 12px;">
				<tr>
					<td align="right" height="30px;">
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_add()"><spring:message code="hrms.add" /></a>
						<a	class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_save()"><spring:message code="hrms.save" /></a>
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_delete()"><spring:message code="hrms.delete" /></a>
					</td>
				</tr>
			</table>
		</div>
		<div position="center" id='sliceTypeDetail'></div>
	</div>
</body>
</html>
