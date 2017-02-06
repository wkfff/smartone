<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script type="text/javascript">
	var $grid = null;
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
			allowLeftResize: false,
			//是否允许 左边可以调整大小
			allowRightResize: false,
			//是否允许 右边可以调整大小
			allowTopResize: false,
			//是否允许 头部可以调整大小
			allowBottomResize: false //是否允许 底部可以调整大小
		});
		f_initGrid();
	});
	function f_initGrid() {
		$grid = $("#empInfo").ligerGrid({
			checkbox: false,
			columns: [{
				display: '<spring:message code="hrms.wageMonth"/>',
				name: 'MONTH_STR',
				width: 120
			},
			{
				display: '<spring:message code="pa.ThePerformanceOfLock"/>',
				name: 'INS_LOCK_FLAG',
				width: 120,
				render: function(row, index) {
					if (row.INS_LOCK_FLAG == 0) {
						return '<img style="cursor: pointer;" src="/resources/images/lock_open.gif" onclick="f_save(1,\'INS_LOCK_FLAG\')" >';
					} else {
						return '<img style="cursor: pointer;" src="/resources/images/lock.gif" onclick="f_save(0,\'INS_LOCK_FLAG\')" >';
					}
				}
			},
			{
				display: '<spring:message code="hrms.attendanceLock"/>',
				name: 'MONTHLY_LOCK_FLAG',
				width: 120,
				render: function(row, index) {
					if (row.MONTHLY_LOCK_FLAG == 0) {
						return '<img style="cursor: pointer;" src="/resources/images/lock_open.gif" onclick="f_save(1,\'MONTHLY_LOCK_FLAG\')" >';
					} else {
						return '<img style="cursor: pointer;" src="/resources/images/lock.gif" onclick="f_save(0,\'MONTHLY_LOCK_FLAG\')" >';
					}
				}
			},
			{
				display: '<spring:message code="hrms.wageLock"/>',
				name: 'PA_LOCK_FLAG',
				width: 120,
				render: function(row, index) {
					if (row.PA_LOCK_FLAG == 0) {
						return '<img style="cursor: pointer;" src="/resources/images/lock_open.gif" onclick="f_save(1,\'PA_LOCK_FLAG\')" >';
					} else {
						return '<img style="cursor: pointer;" src="/resources/images/lock.gif" onclick="f_save(0,\'PA_LOCK_FLAG\')" >';
					}
				}
			},
			{
				display: '<spring:message code="hrms.remarks"/>',
				name: 'REMARK',
				align: 'left',
				width: 280,
				editor: {
					type: 'textarea',
					height: 100
				},
				onChanged: function(row, index) {
					spf_save();
				}
			}],
			enabledEdit: true,
			usePager: false,
			rownumbers: true,
			url: '/pa/salary/getPaProgressInfo',
			parms: [{
				name: 'PA_MONTH',
				value: $("#year").attr('value') + $("#month").attr('value')
			}],
			width: '99%',
			height: '99%'
		});
	}
	function spf_search() {
		$grid.setOptions({
			parms: [{
				name: 'PA_MONTH',
				value: $("#year").attr('value') + $("#month").attr('value')
			}],
			newPage: 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_save() {
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		var rows = $grid.getSelectedRow();

		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/pa/salary/updatePaProgressInfo", [{
			name: 'MONTH_STR',
			value: paMonth
		},
		{
			name: 'REMARK',
			value: MyCheckNull(rows.REMARK)
		}],
		function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',
				function() {
					$grid.loadData(true); //加载数据 
				});
			} else {
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		});
	}
	function f_save(index, flag) {
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/pa/salary/updatePaProgressInfo", [{
			name: 'MONTH_STR',
			value: paMonth
		},
		{
			name: flag,
			value: index
		}],
		function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',
				function() {
					$grid.loadData(true); //加载数据
				});
			} else {
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		});
	}
</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t">
							<spring:message code="hrms.wageMonth" /></td>
						<td width="23%" class="l-table-edit-c">
							<SipingSoft:date yearName="year" yearSelected="${year}" monthName="month" monthSelected="${month}" onChange="spf_search();spf_lockFlag();" />
						</td>
						<td width="23%" class="l-table-edit-cc">
							<img style="cursor: pointer;" src="/resources/images/lock_open.gif"
								title='<spring:message code="hrms.unlocked"/>'>
								&nbsp;&nbsp;<spring:message code="hrms.unlocked" />&nbsp;&nbsp; <img
								style="cursor: pointer;" src="/resources/images/lock.gif"
								title='<spring:message code="hrms.locked"/>'> &nbsp;&nbsp;
								<spring:message code="hrms.locked" />
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
			</div>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
