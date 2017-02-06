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

	function spf_initGrid() {
		$grid = $("#previewTool")
				.ligerGrid(
						{
							checkbox : false,
							columns : [ {
								display : '物品名称',
								name : 'CODE_NAME',
								width : 110
							}, {
								display : '借出时间',
								name : 'BORROW_DATE',
								width : 220
							}, {
								display : '预计归还时间',
								name : 'RETURN_DATE',
								width : 220
							} ],
							usePager : false,
							rownumbers : true,
							dataAction : 'server',
							root : 'toolLoanList',
							url : '/ess/infoApp/getToolLoan?TOOL_TYPE_CODE=${paramMap.TOOL_TYPE_CODE}',
							width : '99%',
							height : '99%'
						});
	}
</script>
</head>
<body style="padding: 0px">
	<div id="previewTool"></div>
</body>
</html>
