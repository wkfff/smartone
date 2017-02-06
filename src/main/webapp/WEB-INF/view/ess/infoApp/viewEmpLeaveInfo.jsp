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


<script type="text/javascript">
	var $grid;
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({

			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
		spf_initGrid();

	});

	//休假明细
	function spf_initGrid() {
		$grid = $("#ldInfo")
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
										name : 'CHINESENAME'
									},
									{
										display : '<spring:message code="hrms.dept"/>',
										name : 'DEPTNAME'
									},
									{
										display : '<spring:message code="hrms.leaveType"/>',
										name : 'LEAVE_TYPE_NAME'
									},
									{
										display : '<spring:message code="hrms.startedTime"/>',
										name : 'LEAVE_FROM_TIME'
									},
									{
										display : '<spring:message code="hrms.endTime"/>',
										name : 'LEAVE_TO_TIME'
									},
									{
										display : '<spring:message code="hrms.confirmationActive"/>',
										name : 'CON_STATUS',
										width : 120
									},
									{
										display : '<spring:message code="hrms.confirmationRemarks"/>',
										name : 'CON_REMARK',
										align : 'left',
										width : 140,
										editor : {
											type : 'textarea',
											height : 100
										}
									} ],
							usePager : false,
							rownumbers : true,
							url : '/ess/viewApp/getEmpLeaveDetailInfo?EMPID=${paramMap.EMPID}&LEAVE_FROM_TIME=${paramMap.LEAVE_FROM_TIME}',
							width : '99%',
							height : '98%'
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
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div id="ldInfo"></div>
		</div>
	</div>
</body>
</html>
