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
	 var $dialog ;
	 var family_grid ;
	 var others_grid ;
	 var $Flag = "F";
	 var $relationalTypeSelectList ;
	 var $otherRelationlTypeSelectList ;
	 var $eduHisSelectList ;
	 var $yesOrNoSelectList ;
	 $.ligerDefaults.Grid.editors['textarea'] = {
				create: function (container, editParm)
				{
					var input = $("<textarea class='l-textarea' />");
					container.append(input);
					return input;
				},
				getValue: function (input, editParm)
				{
					return input.val();
				},
				setValue: function (input, value, editParm)
				{
					input.val(value);
				},
				resize: function (input, width, height, editParm)
				{
					var column = editParm.column;
					if (column.editor.width) input.width(column.editor.width);
					else input.width(width);
					if (column.editor.height) input.height(column.editor.height);
					else input.height(height);
				}
			};
	 // 初始调用
	 $(function ()
	 {
		 //布局
		  $("#layout1").ligerLayout({
				 allowLeftResize: false,	  //是否允许 左边可以调整大小
				 allowRightResize: false,	  //是否允许 右边可以调整大小
				 allowTopResize: false,		 //是否允许 头部可以调整大小
				 allowBottomResize: false	  //是否允许 底部可以调整大小
		   }
		  );
		  $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid)
			  {
				if(tabid=="tabitem1"){
					//异动信息
					$Flag = "F";
				}
				if(tabid=="tabitem2"){
					//派遣信息
					spf_dispatchInfo_initGrid();
					$Flag = "O";
				}
				if(tabid=="tabitem3"){
					//兼任信息
					spf_pluralismInfo_initGrid();
					$Flag = "O";
				}
				if(tabid=="tabitem4"){
					//奖励信息
					spf_rewardInfo_initGrid();
					$Flag = "O";
				}
				if(tabid=="tabitem5"){
					//惩戒信息
					spf_punishmentInfo_initGrid();
					$Flag = "O";
				}
				if(tabid=="tabitem6"){
					//离职信息
					spf_leftInfo_initGrid();
					$Flag = "O";
				}
			  }
			  });

		  $relationalTypeSelectList = getRelationalTypeSelectList() ;
		  $otherRelationlTypeSelectList = getOtherRelationlTypeSelectList() ;
		  $eduHisSelectList = getEduHisTypeSelectList() ;
		  $yesOrNoSelectList = getYesOrNoSelectList() ;

		  spf_ccommInfo_initGrid();
	 });
	 function getRelationalTypeSelectList(){
		//请求服务器
		var relationalTypeSelectList ;
		 $.ajax({
			 type: 'post',
			 url: '/utility/otherInfo/getRelationalTypeSelectList',
			 dataType: 'json',
			 async: false,
			 success: function (list)
			 {
				 relationalTypeSelectList = list ;
			 }
		 });
		 return relationalTypeSelectList ;
	 }

	 function getOtherRelationlTypeSelectList(){
		//请求服务器
		var otherRelationlTypeSelectList ;
		$.ajax({
			 type: 'post',
			 url: '/utility/otherInfo/getOtherRelationlTypeSelectList',
			 dataType: 'json',
			 async: false,
			 success: function (list)
			 {
				 otherRelationlTypeSelectList = list ;
			 }
		});
		return otherRelationlTypeSelectList ;
	 }
	 function getEduHisTypeSelectList(){
		//请求服务器
		var eduHisSelectList ;
		  $.ajax({
			  type: 'post',
			  url: '/utility/otherInfo/getEduHisTypeSelectList',
			  dataType: 'json',
			  async: false,
			  success: function (list)
			  {
				  eduHisSelectList = list ;
			  }
		  });
		  return eduHisSelectList ;
	  }
	function getYesOrNoSelectList(){
		//请求服务器
		var yesOrNoSelectList ;
		   $.ajax({
			   type: 'post',
			   url: '/utility/otherInfo/getYesOrNoSelectList',
			   dataType: 'json',
			   async: false,
			   success: function (list)
			   {
				   yesOrNoSelectList = list ;
			   }
		   });
		   return yesOrNoSelectList ;
	   }
	 function spf_ccommInfo_initGrid()
	 {
		$family_grid = $("#ccommInfo").ligerGrid({
			checkbox: false,
			 columns: [
				{ display: '<spring:message code="hrms.ccommType"/>', name: 'TRANS_NAME', align: 'center', width: 120 },
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
				{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
				{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 120 },
				{ display: '<spring:message code="hrms.effectDate"/>', name: 'START_DATE', width: 120 },
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 500,editor: { type: 'textarea', height: 100 }}
			],
			 enabledEdit: true,usePager: false,rownumbers:true,
			 url: "/hrm/empinfo/getExpInsideInfo",
			 parms: [
					{ name: 'EXECUTED',value: '1'},
					{ name: 'EMPID',value: '${basicInfo.EMPID }'}
				 ],
			 pageSize: 5,
			 pageSizeOptions: [5,4,3,2,1],
			 heightDiff : 0,
			 width: '99.6%', height: '100%'
		 });
	 }
	 //限额休假
	 function spf_dispatchInfo_initGrid()
	 {
		$family_grid = $("#dispatchInfo").ligerGrid({
			checkbox: false,
			columns: [
				{ display: '<spring:message code="hrms.dispatchType"/>', name: 'DIS_TYPE_NAME', width: 120},
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
				{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
				{ display: '<spring:message code="hrms.dispatchOffice"/>', name: 'DIS_TARGET', width: 120 },
				{ display: '<spring:message code="hrms.workingDescription"/>', name: 'CONTENTS', width: 120,  editor: { type: 'textarea', height: 100 } },
				{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120 },
				{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120 },
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 160 ,editor: { type: 'textarea', height: 100 }}
			],
			enabledEdit: true,usePager: false,rownumbers:true,
			url: "/hrm/empinfo/getDispatchInfoList",
			parms: [
					{ name: 'EXECUTED',value: '1'},
					{ name: 'EMPID',value: '${basicInfo.EMPID }'}
				 ],
			pageSize: 5,
			pageSizeOptions: [5,4,3,2,1],
			heightDiff : 0,
			width: '99.6%', height: '100%'
		 });
	 }
	 //限额休假
	 function spf_pluralismInfo_initGrid()
	 {
		$others_grid = $("#pluralismInfo").ligerGrid({
			checkbox: false,
			columns: [
					{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
					{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
					{ display: '<spring:message code="hrms.reason"/>', name: 'REASON', width: 120, editor: { type: 'textarea', height: 100 } },
					{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120},
					{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120},
					{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 160, editor: { type: 'textarea', height: 100 }}
					],
			enabledEdit: true,usePager: false,rownumbers:true,
			url: "/hrm/empinfo/getPluralityInfoList",
			parms: [
					{ name: 'EXECUTED',value: '1'},
					{ name: 'EMPID',value: '${basicInfo.EMPID }'}
				],
			pageSize: 5,
			pageSizeOptions: [5,4,3,2,1],
			heightDiff : 0,
			width: '99.6%', height: '100%'
		 });
	 }
	 //限额休假
	 function spf_rewardInfo_initGrid()
	 {
		$family_grid = $("#rewardInfo").ligerGrid({
			checkbox: false,
			 columns: [
				{ display: '<spring:message code="hrms.awardType"/>', name: 'REWARD_TYPE_NAME', width: 120 },
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
				{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
				{ display: '<spring:message code="hrms.rewardReason"/>', name: 'REWARD_REASON', width: 120,editor: { type: 'textarea', height: 100 } },
				{ display: '<spring:message code="hrms.rewardAmount"/>', name: 'REWARD_AMOUNT', width: 120},
				{ display: '<spring:message code="hrms.rewardDate"/>', name: 'REWARD_DATE', align: 'center', width: 120 },
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 160,editor: { type: 'textarea', height: 100 } }
		   ],
			 enabledEdit: true,usePager: false,rownumbers:true,
			 url: "/hrm/empinfo/getRewardInfoList",
			 parms: [
					{ name: 'EXECUTED',value: '1'},
					{ name: 'TRANS_CODE',value: 'TransCode_180'},
					{ name: 'EMPID',value: '${basicInfo.EMPID }'}
				 ],
			 pageSize: 5,
			 pageSizeOptions: [5,4,3,2,1],
			 heightDiff : 0,
			 width: '99.6%', height: '100%'
		 });
	 }
	 //限额休假
	 function spf_punishmentInfo_initGrid()
	 {
		$others_grid = $("#punishmentInfo").ligerGrid({
			checkbox: false,
			columns: [
						{ display: '<spring:message code="hrms.punishmentType"/>', name: 'PUN_TYPE_NAME', width: 120 },
						{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
						{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
						{ display: '<spring:message code="hrms.punishmentReason"/>', name: 'PUN_REASON', width: 120,editor: { type: 'textarea', height: 100 }},
						{ display: '<spring:message code="hrms.punishmentAmount"/>', name: 'PUN_AMOUNT', align: 'center', width: 120},
						{ display: '<spring:message code="hrms.correctionsDate"/>', name: 'PUNISHED_DATE',width: 120},
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 160,editor: { type: 'textarea', height: 100 } }
					],
			 enabledEdit: true,usePager: false,rownumbers:true,
			 url: "/hrm/empinfo/getPunishmentInfoList",
			 parms: [
						{ name: 'EXECUTED',value: '1'},
						{ name: 'TRANS_CODE',value: 'TransCode_190'},
						{ name: 'EMPID',value: '${basicInfo.EMPID }'}
					],
			 pageSize: 5,
			 pageSizeOptions: [5,4,3,2,1],
			 heightDiff : 0,
			 width: '99.6%', height: '100%'
		 });
	 }
	 //离职
	 function spf_leftInfo_initGrid()
	 {
		$others_grid = $("#leftInfo").ligerGrid({
			checkbox: false,
			columns: [
						{ display: '<spring:message code="hrms.leftType"/>', name: 'RESIGN_TYPE_NAME', width: 120 },
						{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 },
						{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 },
						{ display: '<spring:message code="hrms.leftReason"/>', name: 'RESIGN_REASON', width: 300,  editor: { type: 'textarea', height: 100 }},
						{ display: '<spring:message code="hrms.leftDate"/>', name: 'RESIGN_DATE', align: 'center', width: 120 },
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 160,editor: { type: 'textarea', height: 100 }}
					],
			enabledEdit: true,usePager: false,rownumbers:true,
			url: "/hrm/empinfo/getResignInfoList",
			parms: [
				{ name: 'EXECUTED',value: '1'},
				{ name: 'EMPID',value: '${basicInfo.EMPID }'}
				],
			pageSize: 5,
			pageSizeOptions: [5,4,3,2,1],
			heightDiff : 0,
			width: '99.6%', height: '100%'
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
				<table width="99.5%" cellpadding="1" cellspacing="1"
					style="height: 25px; font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img
							src="/resources/images/title/top_1.gif" /></td>
						<td width="25%" align="left" style="font-weight: bold;"><spring:message
								code="hrms.growingUpExperience" /></td>
						<td width="5%" align="right">&nbsp;</td>
						<td align="right">&nbsp;&nbsp;</td>
					</tr>
				</table>
				<table width="100%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td class="l-table-edit-c" colspan="4">
							<div id="navtab1"
								style="width: 100%; overflow: hidden; border: 1px solid #A3C0E8;">
								<div title='<spring:message code="hrms.ccommInfo"/>'>
									<div id="ccommInfo"></div>
								</div>
								<div title='<spring:message code="dispatch"/>'>
									<div id="dispatchInfo"></div>
								</div>
								<div title='<spring:message code="hrms.pluralismInfo"/>'>
									<div id="pluralismInfo"></div>
								</div>
								<div title='<spring:message code="hrms.reward"/>'>
									<div id="rewardInfo"></div>
								</div>
								<div title='<spring:message code="hrms.punishment"/>'>
									<div id="punishmentInfo"></div>
								</div>
								<div title='<spring:message code="hrms.leftInfo"/>'>
									<div id="leftInfo"></div>
								</div>
							</div>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
