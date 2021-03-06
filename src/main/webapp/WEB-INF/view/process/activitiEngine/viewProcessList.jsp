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
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $statusgrid = null;
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
		$("#statuslayout").ligerLayout({
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false //是否允许 底部可以调整大小
		});
		f_initGrid();
	});

	function f_initGrid() {
		$processgrid = $("#processDefinitionInfo").ligerGrid({
			//checkbox: true,
			onBeforeEdit : function(e) {
				$.ligerui.win.masking = true;
			},
			columns : [ {
				display : '<spring:message code="hrms.processName"/>',
				name : 'NAME',
				width : 160
			},{
				display : '<spring:message code="hrms.processKEY"/>',
				name : 'KEY',
				width : 160
			}, {
				display : '<spring:message code="hrms.processID"/>',
				name : 'ID',
				width : 160
			},  {
				display : '<spring:message code="hrms.version"/>',
				name : 'VERSION',
				width : 90
			}, {
				display : '<spring:message code="hrms.resources"/>',
				name : 'RESOURCE',
				width : 220,
				editor : {
					type : 'textarea',
					height : 100
				}
			}, {
				display : '<spring:message code="hrms.processDescripion"/>',
				name : 'DESCRIPTION',
				width : 220,
				editor : {
					type : 'textarea',
					height : 100
				}
			}, {
				display : '<spring:message code="hrms.deploymentID"/>',
				name : 'DEPLOYMENTID',
				width : 100
			} ],
			enabledEdit : true,
			usePager : true,
			rownumbers : true,
			pageSize : 20,
			url : '/process/activitiEngine/getProcessList',
			parms : [],
			width : '99.6%',
			height : '100%'
		});
	}

	var tab = parent.tab;
	//修改
	function spf_update() {
		var row = $processgrid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		if (tab.isTabItemExist('as0202')) {
			tab.removeTabItem('as0202');
		}
		tab.addTabItem({
			tabid : 'as0202',
			text : '<spring:message code="hrms.editModel"/>',
			url : '/process/activitiEngine/updateModel?MENU_CODE=as0202&PROCESSID=' + row.ID
		});
	}
	//搜索
	function spf_search() {
		$statusgrid.setOptions({
			parms : [ {
				name : 'keyWord',
				value : $("#keyWord").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数
		$statusgrid.loadData(true); //加载数据
	}
</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#statuslayout {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="statuslayout">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
						<td width="15%" class="l-table-edit-t"></td>
						<td width="35%" class="l-table-edit-c"></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
			</div>
			<div position="center" id="processDefinitionInfo"></div>
		</div>
	</div>
</body>
</html>
