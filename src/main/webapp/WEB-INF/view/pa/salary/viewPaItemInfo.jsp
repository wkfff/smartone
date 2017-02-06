<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
<meta http-equiv="X-UA-Compatible" content="IE=edge" >   
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />   
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">   
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script> 
<script type="text/javascript">
	var $grid_d;
	var $grid_i;
	var $dtSelectList;
	var $activitySelectList;
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
		$dtSelectList = getDataTypeSelectList();
		$activitySelectList = getActivitySelectList();
		spf_calculationItemInfo();
	});
	function getDataTypeSelectList() {
		//请求服务器
		var dtSelectList;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getDataTypeSelectList?PARENT_CODE=DataType&DEPTH=2',
			dataType: 'json',
			async: false,
			success: function(list) {
				dtSelectList = list;
			}
		});
		return dtSelectList;
	}
	function getActivitySelectList() {
		//请求服务器
		var activitySelectList;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getActivitySelectList',
			dataType: 'json',
			async: false,
			success: function(list) {
				activitySelectList = list;
			}
		});
		return activitySelectList;
	}
	function spf_calculationItemInfo() {
		$grid = $("#calculationItemInfo").ligerGrid({
			checkbox: false,
			columns: [{
				display: '',
				name: 'ITEM_NO',
				width: 10,
				hide: 1
			},
			{
				display: '<spring:message code="hrms.chineseName"/>',
				name: 'ITEM_NAME',
				width: 120,
				align: 'left',
				editor: {
					type: 'text'
				}
			},
			{
				display: '<spring:message code="hrms.englishName"/>',
				name: 'ITEM_EN_NAME',
				width: 120,
				align: 'left',
				editor: {
					type: 'text'
				}
			},
			{
				display: '<spring:message code="hrms.dataType"/>',
				name: 'DATA_TYPE_CODE',
				width: 130,
				align: 'center',
				isSort: false,
				editor: {
					type: 'select',
					data: $dtSelectList,
					dataValueField: 'DATA_TYPE_CODE',
					dataDisplayField: 'DATA_TYPE_NAME',
					displayColumnName: 'DATA_TYPE_NAME',
					valueColumnName: 'DATA_TYPE_CODE'
				},
				render: function(item) {
					for (var i = 0; i < $dtSelectList.length; i++) {
						if ($dtSelectList[i]['DATA_TYPE_CODE'] == item.DATA_TYPE_CODE) return $dtSelectList[i]['DATA_TYPE_NAME']
					}
					return item.DATA_TYPE_NAME;
				}
			},
			{
				display: '<spring:message code="hrms.sortOrder"/>',
				name: 'CALCU_ORDER',
				width: 100,
				render: function(row, index) {
					if (index == '0') {
						return '<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';
					}
					if (row.MAX_INDEX == index + 1) {
						return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">';
					} else {
						return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;' + '&nbsp;&nbsp;<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';
					}
				}
			},
			{
				display: '<spring:message code="hrms.precision"/>',
				name: 'PRECISION',
				type: 'int',
				width: 90,
				editor: {
					type: 'int'
				}
			},
			{
				display: '<spring:message code="hrms.carryBit"/>',
				name: 'CARRY_BIT',
				type: 'long',
				width: 90,
				editor: {
					type: 'float'
				}
			},
			{
				display: '<spring:message code="hrms.active"/>',
				name: 'STATUS_ID',
				align: 'center',
				width: 130,
				isSort: false,
				editor: {
					type: 'select',
					data: $activitySelectList,
					dataValueField: 'STATUS_ID',
					dataDisplayField: 'STATUS',
					displayColumnName: 'STATUS',
					valueColumnName: 'STATUS_ID'
				},
				render: function(item) {
					for (var i = 0; i < $activitySelectList.length; i++) {
						if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID) return $activitySelectList[i]['STATUS']
					}
					return item.STATUS;
				}
			},
			{
				display: '<spring:message code="hrms.description"/>',
				name: 'DESCRIPTION',
				align: 'left',
				width: 220,
				editor: {
					type: 'textarea',
					height: 200
				}
			}
			],
			enabledEdit: true,
			usePager: false,
			rownumbers: true,
			url: '/pa/salary/getPaItemInfo',
			width: '99%',
			height: '99%'
		});
	}
	function spf_search() {
		$grid.setOptions({
			parms: [{
				name: 'keyWord',
				value: $("#keyWord").attr('value')
			}],
			newPage: 1
		}); //设置数据参数 
		$grid.loadData(true); //加载数据
	}
	function spf_updateOrder(indexs, flag) { //上移
		rows = $grid.getData();
		var jsonData = '[';
		if (flag == '-1') {
			$(rows).each(function(index, row) {
				if (jsonData.length > 1) {
					jsonData += ',{';
				} else {
					jsonData += '{';
				}
				if (index != indexs + flag && index != indexs) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + index + '"';
					jsonData += '}';
				}
				if (index == indexs + flag) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + (index + 1) + '"';
					jsonData += '}';
				}
				if (index == indexs) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + (index - 1) + '"';
					jsonData += '}';
				}
			});
		} else {
			//下移
			$(rows).each(function(index, row) {
				if (jsonData.length > 1) {
					jsonData += ',{';
				} else {
					jsonData += '{';
				}
				if (index != indexs + flag && index != indexs) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + index + '"';
					jsonData += '}';
				}
				if (index == indexs + flag) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + (index - 1) + '"';
					jsonData += '}';
				}
				if (index == indexs) {
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",';
					jsonData += ' "CALCU_ORDER": "' + (index + 1) + '"';
					jsonData += '}';
				}
			});
		}
		jsonData += ']';
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/pa/salary/updatePaItemInfoCalOrder", [{
			name: 'jsonData',
			value: jsonData
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
	function spf_add() {
		$grid.addRow();
	}
	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据 
	}
	function spf_save() {
		var jsonData = '[';
		var rows = $grid.getData();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$(rows).each(function(index, row) {
			if (this.ITEM_NAME == null || this.ITEM_NAME == '' || this.ITEM_NAME == 'undefined') {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chineseName"/>' + ". " + '<spring:message code="input.required"/>');
				return false;
			}
			if (this.DATA_TYPE_CODE == null || this.DATA_TYPE_CODE == '' || this.DATA_TYPE_CODE == 'undefined') {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataType"/>' + ". " + '<spring:message code="input.required"/>');
				return false;
			}
			if (this.PRECISION == null) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.precision"/>' + ". " + '<spring:message code="input.required"/>');
				return false;
			}
			if (this.CARRY_BIT == null) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.carryBit"/>' + ". " + '<spring:message code="input.required"/>');
				return false;
			}
			if (this.STATUS_ID == null || this.STATUS_ID == '' || this.STATUS_ID == 'undefined') {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.active"/>' + ". " + '<spring:message code="input.required"/>');
				return false;
			}
			if (jsonData.length > 1) {
				jsonData += ',{';
			} else {
				jsonData += '{';
			}
			jsonData += ' "__status": "' + this.__status + '", ';
			jsonData += ' "ITEM_NO": "' + MyCheckNull(this.ITEM_NO) + '", ';
			jsonData += ' "ITEM_NAME": "' + this.ITEM_NAME + '", ';
			jsonData += ' "ITEM_EN_NAME": "' + MyCheckNull(this.ITEM_EN_NAME) + '", ';
			jsonData += ' "DATATYPE": "' + this.DATA_TYPE_CODE + '", ';
			jsonData += ' "CALCU_ORDER": "' + index + '", ';
			jsonData += ' "PRECISION": "' + this.PRECISION + '", ';
			jsonData += ' "CARRY_BIT": "' + this.CARRY_BIT + '", ';
			jsonData += ' "STATUS_ID": "' + this.STATUS_ID + '",';
			jsonData += ' "DESCRIPTION": "' + MyCheckNull(this.DESCRIPTION) + '"';
			jsonData += '}';
		});
		jsonData += ']';
		if (jsonData.length == 2) {
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post("/pa/salary/saveAndUpdatePaItemInfo", [{
			name: 'jsonData',
			value: jsonData
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
	function spf_delete() {
		var row = $grid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.post("/pa/salary/deletePaItemInfo", [{
			name: 'ITEM_NO',
			value: MyCheckNull(row.ITEM_NO)
		},
		{
			name: 'ITEM_ID',
			value: MyCheckNull(row.ITEM_ID)
		}],
		function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',
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
		<div position="center" id=''>
			<div position="top">
				<table width="99%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t">
							<spring:message code="keyWord" /></td>
						<td width="23%" class="l-table-edit-c">
							<input name="keyWord" type="text" id="keyWord" size="30" /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
			</div>
			<div position="center" id='calculationItemInfo'></div>
		</div>
	</div>
</body>
</html>
