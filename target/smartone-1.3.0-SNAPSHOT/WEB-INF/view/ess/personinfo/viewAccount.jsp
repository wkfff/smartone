<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
<script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $dialog;
	var $grid;
	var $relationalTypeSelectList;
	var $otherRelationlTypeSelectList;
	var $eduHisSelectList;
	var $yesOrNoSelectList;

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

		$relationalTypeSelectList = getRelationalTypeSelectList();
		$otherRelationlTypeSelectList = getOtherRelationlTypeSelectList();
		$eduHisSelectList = getEduHisTypeSelectList();
		$yesOrNoSelectList = getYesOrNoSelectList();

		spf_family_initGrid();
	});
	function getRelationalTypeSelectList() {
		//请求服务器
		var relationalTypeSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getRelationalTypeSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				relationalTypeSelectList = list;
			}
		});
		return relationalTypeSelectList;
	}

	function getOtherRelationlTypeSelectList() {
		//请求服务器
		var otherRelationlTypeSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getOtherRelationlTypeSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				otherRelationlTypeSelectList = list;
			}
		});

		return otherRelationlTypeSelectList;
	}
	function getEduHisTypeSelectList() {
		//请求服务器
		var eduHisSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getEduHisTypeSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				eduHisSelectList = list;
			}
		});

		return eduHisSelectList;
	}
	function getYesOrNoSelectList() {
		//请求服务器
		var yesOrNoSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getYesOrNoSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				yesOrNoSelectList = list;
			}
		});

		return yesOrNoSelectList;
	}
	//账户列表
	function spf_family_initGrid() {
		$grid = $("#accountInfo").ligerGrid({
			checkbox : false,
			columns : [ {
				display : '',
				name : '',
				width : 10,
				hide : 1
			}, {
				display : '<spring:message code="hrms.wageMark"/>',
				name : 'CALC_FLAG_NAME',
				width : 120,
			}, {
				display : '<spring:message code="hrms.bank"/>',
				name : 'BANK_NAME',
				width : 180,
				editor : {
					type : 'text'
				}
			}, {
				display : '<spring:message code="hrms.accountNumber"/>',
				name : 'CARD_NO',
				width : 180,
				editor : {
					type : 'text'
				}
			}, {
				display : '<spring:message code="hrms.remarks"/>',
				name : 'REMARK',
				width : 380,
				editor : {
					type : 'text'
				}
			} ],
			enabledEdit : false,
			usePager : false,
			rownumbers : true,
			url : "/hrm/empinfo/getPaEmpInfoList?EMPID=${basicInfo.EMPID }",
			pageSize : 5,
			pageSizeOptions : [ 5, 4, 3, 2, 1 ],
			heightDiff : 0,
			width : '99.6%',
			height : '100%'
		});
	}
</script>
</head>
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
<body style="padding: 2px">
	<div id="layout1">
		<div align="left" position="center" id='' title=' '>
			<div align="left">
				<%@include file="viewBasicInfo.jsp"%>
				<br>
				<table width="99.6%" cellpadding="1" cellspacing="1"
					style="height: 25px; font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img
							src="/resources/images/title/top_1.gif" /></td>
						<td width="25%" align="left" style="font-weight: bold;"><spring:message
								code="hrms.account" /></td>
						<td width="5%" align="right">&nbsp;</td>
						<td align="right">&nbsp;</td>
					</tr>
				</table>

			</div>
			<div id="accountInfo"></div>
		</div>
	</div>
</body>
</html>
