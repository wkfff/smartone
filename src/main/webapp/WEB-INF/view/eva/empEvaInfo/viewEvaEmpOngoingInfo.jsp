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
		spf_initGrid();
	});

	function spf_initGrid() {
		$grid = $("#empInfo")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.empid"/>',
										name : 'EV_EMPID',
										width : 90
									},
									{
										display : '<spring:message code="hrms.ProposeEndDate"/>',
										name : 'END_PROBATION_DATE',
										width : 120
									},
									{
										display : '<spring:message code="hrms.offProbationType"/>',
										name : 'TURN_TYPE_NAME',
										width : 120
									}, {
										display : '',
										name : 'EV_S_WORK_FLAG',
										width : 90,
										hide : 1
									}, {
										display : '',
										name : 'EV_S_ITEM_FLAG',
										width : 90,
										hide : 1
									}, {
										display : '',
										name : 'EV_1_ITEM_FLAG',
										width : 90,
										hide : 1
									}, {
										display : '工作计划自评状态',
										name : 'EV_S_WORK_FLAG_NAME',
										width : 120
									}, {
										display : '评价项目自评状态',
										name : 'EV_S_ITEM_FLAG_NAME',
										width : 120
									}, {
										display : '评价项目一评状态',
										name : 'EV_1_ITEM_FLAG_NAME',
										width : 120
									} ],
							enabledEdit : false,
							usePager : false,
							rownumbers : true,
							url : '/eva/empEvaInfo/getEvaEmpEveInfo',
							width : '99.6%',
							height : '100%',
							onDblClickRow : function(rowdata, rowindex,
									rowDomElement) {
								spf_showEvaEmpOngoingDetailInfo(
										rowdata.EV_EMPID,
										rowdata.TURN_TYPE_CODE,
										rowdata.END_PROBATION_DATE,
										rowdata.EV_S_WORK_FLAG,
										rowdata.EV_S_ITEM_FLAG,
										rowdata.EV_1_ITEM_FLAG);
							}
						});
	}
	function spf_showEvaEmpOngoingDetailInfo(empID, turnTypeCode, date, swFlag,
			siFlag, iFlag) {
		if ((swFlag == '0' || siFlag == '0' || swFlag == '1' || siFlag == '1')
				&& iFlag == '0') {
			$.ligerDialog
					.confirm(
							'自评未完成,是否继续?',
							'<spring:message code="hrms.warning"/>',
							function(yes) {
								if (yes) {
									$dialog = $.ligerDialog
											.open({
												isDrag : false,
												title : '<spring:message code="hrms.details"/>',
												width : 900,
												height : 560,
												url : '/eva/empEvaInfo/viewEvaEmpOngoingDetailInfo?EMPID='
														+ empID
														+ '&TURN_TYPE_CODE='
														+ turnTypeCode
														+ '&END_PROBATION_DATE='
														+ date
														+ '&EV_1_ITEM_FLAG='
														+ iFlag
											});
								}
							});
		} else {
			$dialog = $.ligerDialog.open({
				isDrag : false,
				title : '<spring:message code="hrms.details"/>',
				width : 900,
				height : 560,
				url : '/eva/empEvaInfo/viewEvaEmpOngoingDetailInfo?EMPID='
						+ empID + '&TURN_TYPE_CODE=' + turnTypeCode
						+ '&END_PROBATION_DATE=' + date + '&EV_1_ITEM_FLAG='
						+ iFlag
			});
		}
	}
	function spf_search() {
		$grid.setOptions({
			parms : [ {
				name : 'TURN_TYPE_CODE',
				value : $("#TRANS_CODE").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据
		$dialog.close();
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
								<td width="10%" class="l-table-edit-t"><spring:message
										code="hrms.offProbationType" /></td>
								<td width="15%" class="l-table-edit-c"><SipingSoft:selectSyCode
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
