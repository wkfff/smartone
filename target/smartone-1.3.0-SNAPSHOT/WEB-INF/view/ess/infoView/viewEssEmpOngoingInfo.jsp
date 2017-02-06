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
			topHeight : 160,
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
										display : '工作计划自评状态',
										name : 'EV_S_WORK_FLAG_NAME',
										width : 120
									}, {
										display : '评价项目自评状态',
										name : 'EV_S_ITEM_FLAG_NAME',
										width : 120
									} ],
							enabledEdit : false,
							usePager : false,
							rownumbers : true,
							url : '/eva/empEvaInfo/getEvaEmpEveInfo?EMPID=${basicInfo.EMPID}',
							width : '99.6%',
							height : '100%',
							onDblClickRow : function(rowdata, rowindex,
									rowDomElement) {
								spf_showEvaEmpOngoingDetailInfo(
										rowdata.EV_EMPID,
										rowdata.TURN_TYPE_CODE,
										MyCheckNull(rowdata.END_PROBATION_DATE),
										rowdata.EV_S_WORK_FLAG,
										rowdata.EV_S_ITEM_FLAG);
							}
						});
	}

	function spf_showEvaEmpOngoingDetailInfo(empID, turnTypeCode, date, swFlag,
			siFlag) {
		$dialog = $.ligerDialog.open({
			isDrag : false,
			title : '<spring:message code="hrms.details"/>',
			width : 900,
			height : 560,
			left : 150,
			top : 30,
			url : '/ess/infoView/viewEssEmpOngoingDetailInfo?EMPID=' + empID
					+ '&TURN_TYPE_CODE=' + turnTypeCode
					+ '&END_PROBATION_DATE=' + date + '&EV_S_WORK_FLAG='
					+ swFlag + '&EV_S_ITEM_FLAG=' + siFlag
		});
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
			<%@include file="viewBasicInfo.jsp"%>
		</div>
		<div position="center" id='empInfo'></div>
	</div>
</body>
</html>
