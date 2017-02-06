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
<script type="text/javascript">
	var $tree_1 = null;
	var $tree_2 = null;
	var $tree_3 = null;
	var $tree_4 = null;
	var lockFlag = "0";
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
		spf_inputItemTree();
		spf_itemTree();
		spf_hrTree();
		spf_attTree();
		spf_lockFlag();
	});
	
	function spf_lockFlag() {
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		$.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=PA_LOCK_FLAG&PA_MONTH=' + paMonth,
		function(back) {
			lockFlag = back;
		});
	}

	function spf_insExcel() {
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		var jsonData_code = '';
		var notes1 = $tree_1.getChecked();
		var notes2 = $tree_2.getChecked();
		var notes3 = $tree_3.getChecked();
		var notes4 = $tree_4.getChecked();

		if ((!notes1 || notes1.length == 0) && (!notes2 || notes2.length == 0) && (!notes3 || notes3.length == 0) && (!notes4 || notes4.length == 0) && (!notes5 || notes5.length == 0) && (!notes6 || notes6.length == 0)) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		for (var i = 0; i < notes3.length; i++) {
			jsonData_code += notes3[i].data.ITEM_ID + ',';
		}
		for (var i = 0; i < notes1.length; i++) {

			jsonData_code += notes1[i].data.ITEM_ID + ',';
		}
		for (var i = 0; i < notes2.length; i++) {

			jsonData_code += notes2[i].data.ITEM_ID + ',';
		}
		for (var i = 0; i < notes4.length; i++) {

			jsonData_code += notes4[i].data.ITEM_ID + ',';
		}

		if (jsonData_code.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
			return;
		}
		//alert(jsonData_code);
		location.href = '/report/pa/salary/viewPaResultReport?PA_MONTH=' + paMonth + '&DEPTID='+$("#DEPTID").val()+'&jsonData_code=' + jsonData_code;
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
	}
	function spf_inputItemTree() {
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		$.ajax({
			type: 'post',
			cache: false,
			contentType: 'application/json',
			url: '/pa/salary/getPaInputItemInfo?PA_MONTH=' + paMonth,
			dataType: 'json',
			success: function(response) {
				$tree_1 = $("#inputItemTree").ligerTree({
					checkbox: true,
					treeLine: true,
					parentIcon: null,
					childIcon: null,
					data: response.Rows,
					idFieldName: 'ITEM_ID',
					textFieldName: 'ITEM_NAME'
				});
			}
		});
	}
	function spf_itemTree() {
		$.ajax({
			type: 'post',
			cache: false,
			contentType: 'application/json',
			url: '/pa/salary/getPaItemInfo',
			dataType: 'json',
			success: function(response) {
				$tree_2 = $("#itemTree").ligerTree({
					checkbox: true,
					treeLine: true,
					parentIcon: null,
					childIcon: null,
					data: response.Rows,
					idFieldName: 'ITEM_ID',
					textFieldName: 'ITEM_NAME'
				});
			}
		});
	}
	function spf_hrTree() {
		$.ajax({
			type: 'post',
			cache: false,
			contentType: 'application/json',
			url: '/utility/otherInfo/getToolItemSelectList?TABLE_NAME=PA_HR_V',
			dataType: 'json',
			success: function(response) {
				$tree_3 = $("#hrTree").ligerTree({
					checkbox: true,
					treeLine: true,
					parentIcon: null,
					childIcon: null,
					data: response.Rows,
					idFieldName: 'ITEM_ID',
					textFieldName: 'ITEM_NAME'
				});
			}
		});
	}
	function spf_attTree() {
		$.ajax({
			type: 'post',
			cache: false,
			contentType: 'application/json',
			url: '/att/attendanceSettings/getAttMItemInfo?ACTIVITY=1',
			dataType: 'json',
			success: function(response) {
				$tree_4 = $("#attTree").ligerTree({
					checkbox: true,
					treeLine: true,
					parentIcon: null,
					childIcon: null,
					data: response.Rows,
					idFieldName: 'ITEM_ID_F',
					textFieldName: 'ITEM_NAME_F'
				});
			}
		});
	}

	function spf_unCheckAll(tree, flag) {
		if (tree == '$tree_1') {
			var notes1 = $tree_1.getData();
			for (var i = 0; i < notes1.length; i++) {
				var parm = function() {
					if (flag == '1') {
						return notes1[i].ITEM_ID;
					} else {
						return false;
					}
				};
				$tree_1.selectNode(parm);
			}
		}
		if (tree == '$tree_2') {
			var notes2 = $tree_2.getData();
			for (var i = 0; i < notes2.length; i++) {
				var parm = function() {
					if (flag == '1') {
						return notes2[i].ITEM_ID;
					} else {
						return false;
					}
				};
				$tree_2.selectNode(parm);
			}
		}
		if (tree == '$tree_3') {
			var notes3 = $tree_3.getData();
			for (var i = 0; i < notes3.length; i++) {
				var parm = function() {
					if (flag == '1') {
						return notes3[i].ITEM_ID;
					} else {
						return false;
					}
				};
				$tree_3.selectNode(parm);
			}
		}
		if (tree == '$tree_4') {
			var notes4 = $tree_4.getData();
			for (var i = 0; i < notes4.length; i++) {
				var parm = function() {
					if (flag == '1') {
						return notes4[i].ITEM_ID;
					} else {
						return false;
					}
				};
				$tree_4.selectNode(parm);
			}
		}
	}
</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99%;margin:0; padding:0;  }  
	h4{ margin:20px;}
</style>
</head>
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99%" cellpadding="0" cellspacing="0" border="1xp"
					bordercolor="#A3C0E8">
					<tr>
						<td width="20%" class="l-table-edit-t">
							<spring:message code="hrms.wageMonth" /></td>
						<td width="30%" class="l-table-edit-c">
							<SipingSoft:date yearName="paYear" monthName="paMonth" /></td>
						<td class="l-table-edit-t" width="20%"><spring:message code="hrms.dept"/></td>
						<td class="l-table-edit-c" width="30%">
							<SipingSoft:deptTree name="DEPTID" limit="hr"/></td>
					</tr>
				</table>
				<table width="99%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
					<tr>
						<td align="left" height="30px;">
							<a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_insExcel()"><spring:message code="hrms.excelExport" /></a>
						</td>
					</tr>
				</table>
			</div>
			<div position="center">
				<table width="99%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="16%" class="l-table-edit-cc"><spring:message
								code="hrms.inputItem" />[&nbsp; <a
							onclick="spf_unCheckAll('$tree_1','1')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.selectAll" /></a> &nbsp;&nbsp; <a
							onclick="spf_unCheckAll('$tree_1','0')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.deselectAll" /></a>&nbsp;]</td>
						<td width="16%" class="l-table-edit-cc"><spring:message
								code="hrms.calculationItem" />[&nbsp; <a
							onclick="spf_unCheckAll('$tree_2','1')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.selectAll" /></a>&nbsp;&nbsp; <a
							onclick="spf_unCheckAll('$tree_2','0')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.deselectAll" /></a>&nbsp;]</td>
						<td width="16%" class="l-table-edit-cc"><spring:message
								code="hrms.personnelItem" />[&nbsp; <a
							onclick="spf_unCheckAll('$tree_3','1')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.selectAll" /></a>&nbsp;&nbsp; <a
							onclick="spf_unCheckAll('$tree_3','0')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.deselectAll" /></a>&nbsp;]</td>
						<td width="16%" class="l-table-edit-cc"><spring:message
								code="hrms.attendanceItem" />[&nbsp; <a
							onclick="spf_unCheckAll('$tree_4','1')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.selectAll" /></a>&nbsp;&nbsp; <a
							onclick="spf_unCheckAll('$tree_4','0')"
							style="cursor: hand; font-weight: bold; color: purple;"><spring:message
									code="hrms.deselectAll" /></a>&nbsp;]</td>
					</tr>
					<tr height="400px">
						<td width="16%" height="400px" class="l-table-edit-c">
							<div style="width: 99%; height: 400px; margin: 0px; float: left; border: 1px solid #A3C0E8; overflow: auto;">
								<ul id="inputItemTree">
								</ul>
							</div>
						</td>
						<td width="16%" class="l-table-edit-c">
							<div style="width: 98%; height: 400px; margin: 5px; float: left; border: 1px solid #A3C0E8; overflow: auto;">
								<ul id="itemTree">
								</ul>
							</div>
						</td>
						<td width="16%" class="l-table-edit-c">
							<div style="width: 99%; height: 400px; margin: 0px; float: left; border: 1px solid #A3C0E8; overflow: auto;">
								<ul id="hrTree">
								</ul>
							</div>
						</td>
						<td width="16%" class="l-table-edit-c">
							<div style="width: 99%; height: 400px; margin: 0px; float: left; border: 1px solid #A3C0E8; overflow: auto;">
								<ul id="attTree">
								</ul>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
