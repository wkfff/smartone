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
	var $grid_i;
	var $grid_f;
	var $dialog;
	var itemNo = "";
	var lockFlag = "0";
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create: function(container, editParm) {
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue: function(input, editParm) {
			return input.val();
		},
		setValue: function(input, value, editParm) {
			input.val(value);
		},
		resize: function(input, width, height, editParm) {
			var column = editParm.column;
			if (column.editor.width) input.width(column.editor.width);
			else input.width(width);
			if (column.editor.height) input.height(column.editor.height);
			else input.height(height);
		}
	};
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			leftWidth: 180,allowLeftResize:false,
			height: '99.6%'
		});
		spf_calcItemInfo();
		setTimeout('spf_lockFlag()', 2000);
	});
	function spf_lockFlag() {
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		$.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=PA_LOCK_FLAG&PA_MONTH=' + paMonth,
		function(back) {
			lockFlag = back;
		});
	}
	function spf_calcItemInfo() {
		$grid_i = $("#calcItemInfo").ligerGrid({
			checkbox: false,
			columns: [
				{display: '',name: 'ITEM_NO',width: 10,hide: 1},
				{display: '<spring:message code="hrms.attItemName"/>',name: 'ITEM_NAME',align: 'center',width: 120}
			],
			enabledEdit: true,
			usePager: false,
			rownumbers: true,
			url: '/pa/salary/getPaItemInfo?ACTIVITY=1',
			width: '99%',
			height: '99%',
			onSelectRow: function(rowdata, rowindex, rowDomElement) {
				itemNo = rowdata.ITEM_NO;
				spf_initGrid();
			}
		});
	}
	function spf_initGrid() {
		$grid_f = $("#empInfo").ligerGrid({
			checkbox: false,
			columns: [
				{display: '',name: 'FORMULAR_NO',width: 10,hide: 1},
				{display: '',name: 'ITEM_NO',width: 10,hide: 1},
				{display: '<spring:message code="condition"/>',name: 'CONDITION',align: 'left',width: 220,
					editor: {type: 'textarea',height: 100}
				},
				{display: '<spring:message code="formula"/>',name: 'FORMULAR',align: 'left',width: 320,
					editor: {type: 'textarea',height: 100}
				},
				{display: '<spring:message code="hrms.description"/>',name: 'DESCRIPTION',align: 'left',width: 180,
					editor: {type: 'textarea',height: 100}
				}
			],
			enabledEdit: true,
			usePager: false,
			rownumbers: true,
			url: '/pa/salary/getPaFormulaCnInfo?ITEM_NO=' + itemNo ,
			width: '99%',
			height: '99%'
		});
	}
	function spf_search() {
		$grid_i.setOptions({
			newPage: 1
		}); //设置数据参数 
		$grid_i.loadData(true); //加载数据
		$grid_f.setOptions({
			newPage: 1
		}); //设置数据参数 
		$grid_f.loadData(true); //加载数据
	}
	function spf_add() {
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		if (!itemNo || itemNo == "") {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>' + '<spring:message code="hrms.calculationItem"/>');
			return;
		}
		if (lockFlag == '0') {
			$dialog = $.ligerWindow.show({
				isDrag: true,
				title: '<spring:message code="hrms.add"/>' + '<spring:message code="formula"/>',
				width: 950,
				height: 500,
				left: 120,
				top: 60,
				url: '/pa/salary/addPaFormulaInfo?ITEM_NO=' + itemNo
			});
		} else {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotAdd"/>');
			return;
		}
	}
	function f_ChildWindowClose() {
		$grid_f.loadData(true); //加载数据 
		$dialog.close();
	}

	function spf_delete() {
		var row = $grid_f.getSelectedRow();
		if (lockFlag == '0') {
			if (!row || row.length == 0) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
				return;
			}
			$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
			$.post("/pa/salary/deletePaFormulaInfo", [{
				name: 'FORMULAR_NO',
				value: row.FORMULAR_NO
			}],
			function(result) {
				$.ligerDialog.closeWaitting();
				if (result == "Y") {
					$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',
					function() {
						$grid_f.loadData(true); //加载数据 
					});
				} else {
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		} else {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotdelete"/>');
			return;
		}
	}
	function spf_update() {
		var rows = $grid_f.getSelectedRow();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		if (lockFlag == '0') {
			$dialog = $.ligerWindow.show({
				isDrag: false,
				showMax: true,
				showMin: true,
				title: '<spring:message code="hrms.update"/>'+'<spring:message code="formula"/>',
				width: 800,
				height: 400,
				url: '/pa/salary/updatePaFormulaInfo?FORMULAR_NO=' + rows.FORMULAR_NO + '&ITEM_NO=' + rows.ITEM_NO
			});
		} else {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotUpdate"/>');
			return;
		}
	}
</script>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
	<div position="top">
		<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
			<tr>
				<td align="left"><SipingSoft:button /></td>
			</tr>
		</table>
	</div>
	<div id="layout1">
		<div position="left" id="calcItemInfo" class="l-scroll"
			title='<spring:message code="hrms.calculationItem"/>'></div>
		<div position="center" id='empInfo'
			title='<spring:message code="formula"/>'></div>
	</div>
</body>
</html>
