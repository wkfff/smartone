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
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTextBox.js"
	type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid = null;
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
		$grid = $("#empInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.empid"/>',
										name : 'EMPID',
										width : 90
									},
									{
										display : '<spring:message code="hrms.name"/>',
										name : 'CHINESENAME',
										width : 90
									},
									{
										display : '<spring:message code="hrms.dept"/>',
										name : 'DEPTNAME',
										width : 180
									},
									{
										display : '<spring:message code="hrms.postGroup"/>',
										name : 'POST_GROUP_NAME',
										width : 90
									},
									{
										display : '<spring:message code="hrms.postGrade"/>',
										name : 'POST_GRADE_NAME',
										width : 90
									},
									{
										display : '<spring:message code="hrms.post"/>',
										name : 'POST_NAME',
										width : 90
									},
									{
										display : '<spring:message code="hrms.ProposeEndDate"/>',
										name : 'END_PROBATION_DATE',
										width : 120
									},
									{
										display : '<spring:message code="hrms.EmpStatus"/>',
										name : 'STATUS_NAME',
										width : 120
									} ],
							enabledEdit : true,
							usePager : false,
							rownumbers : true,
							url : '/hrm/transferOrder/getEmpInfoList',
							parms : [ {
								name : 'OFF_PROBATION',
								value : 'YES'
							}, {
								name : 'TURN_TYPE_CODE',
								value : $("#TRANS_CODE").attr('value')
							} ],
							width : '99.6%',
							height : '100%',
							onDblClickRow : function(rowdata, rowindex,
									rowDomElement) {
								spf_showEvaEmpNormalDetailInfo(
										MyCheckNull(rowdata.EMPID),
										MyCheckNull(rowdata.END_PROBATION_DATE));
							}
						});
	}

	function spf_showEvaEmpNormalDetailInfo(empID, date) {
		var turnTypeCode = $("#TRANS_CODE").attr('value');
		$dialog = $.ligerWindow
				.show({
					isDrag : true,
					title : '<spring:message code="hrms.details"/>' + ' '
							+ '<spring:message code="hrms.setting"/>',
					width : 800,
					height : 480,
					left : 150,
					top : 60,
					url : '/eva/empEvaInfo/viewEvaEmpSettingDetailInfo?MENU_CODE=eva0501&EMPID='
							+ empID
							+ '&TURN_TYPE_CODE='
							+ turnTypeCode
							+ '&END_PROBATION_DATE=' + date
				});
	}
	function spf_search() {
		$grid.setOptions({
			parms : [ {
				name : 'OFF_PROBATION',
				value : 'YES'
			}, {
				name : 'TURN_TYPE_CODE',
				value : $("#TRANS_CODE").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
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
					<td height="2px"></td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" cellpadding="0" cellspacing="0"
							class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
							<tr>
								<td height="25px" class="l-table-edit-t"><spring:message
										code="hrms.offProbationType" /></td>
								<td class="l-table-edit-c"><SipingSoft:selectSyCode
										parentCode="TurnType" name="TRANS_CODE"
										selected="TurnType0010" onChange="spf_search();" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
		<div position="center" id='empInfo'></div>
	</div>
</body>
</html>
