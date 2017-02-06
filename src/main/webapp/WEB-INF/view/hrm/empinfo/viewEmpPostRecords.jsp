<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
	var $grid;
	// 初始调用
	$(function() {
		f_initGrid();
	});

	function f_initGrid() {
		$grid = $("#hrSearchEmpPostRecords").ligerGrid({
			columns : [ 
						{display : '<spring:message code="hrms.empid"/>',name : 'EMPID',width : '120',frozen:true},
						{display : '<spring:message code="hrms.name"/>',name : 'CHINESENAME',width : '120',frozen:true},
						{display : '<spring:message code="hrms.EmpStatus"/>',name : 'CODE_NAME',width : '120',frozen:true},
						{display : '<spring:message code="hrms.dept"/>',name : 'DEPTNAME',width : '120'},
						{display : '<spring:message code="hrms.post"/>',name : 'POST_NAME',width : '120'},
						{display : '职位等级',name : 'POST_GRADE_NAME',width : '120'},
						{display : '开始时间',name : 'START_DATE',width : '90'},
						{display : '结束时间',name : 'TO_DATE' ,width : '120'}
				],
			usePager : true,
			rownumbers : true,
			url : "/hrm/empinfo/getEmpPostRecords",getEmpPorstRecords
			pageSize:10,
			pageSizeOptions:[10,20,30,40,50],
			width:'99.8%',
			height:'100%'
		});
	}
	function spf_search() {
		var PA_MONTH = $("#year").val()+$("#month").val();
		$grid.setOptions({
			parms : [
			         	/* {name:'keyWord',value : $("#keyWord").val()}, 
						{name:'DEPTID',value : $("#DEPTID").val()},
						{name: 'S_DATE', value: $("#S_DATE").attr('value')},
						{name: 'E_DATE', value: $("#E_DATE").attr('value')},
						{name:'EDU_HIS_CODE',value : $("#EDU_HIS_CODE").val()},
						{name:'EMP_TYPE_CODE',value : $("#EMP_TYPE_CODE").val()},
						{name:'POST_ID',value : $("#POST_ID").val()},
						{name:'STATUS_CODE',value:$("#STATUS_CODE").val()} */
						{name:'PA_MONTH',value : PA_MONTH}
					],
			newPage:1
		});
		$grid.loadData(true);
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
			<table width="99.6%" align="center" cellpadding="0"
				cellspacing="0" class="l-table-edit_01" border="1xp"
				bordercolor="#A3C0E8">
				<tr>
					<td class="l-table-edit-t" width="10%">
						<spring:message code="keyWord"/></td>
					<td class="l-table-edit-c" width="20%">
						<input width="120" type="text" name="keyWord" id="keyWord" /></td>
					<td class="l-table-edit-t" width="10%"><spring:message code="hrms.post" /></td>
					<td class="l-table-edit-c" width="20%"><SipingSoft:selectPost
						name="POST_ID" limit="all" onChange="spf_search()"/></td>
					<td class="l-table-edit-t" width="10%">
						<spring:message code="hrms.dept" /></td>
					<td class="l-table-edit-c" width="20%">
						<SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
				</tr>
				<tr>
					<td class="l-table-edit-t">
						<spring:message code="hrms.EmpStatus"/></td>
					<td class="l-table-edit-c">
						<SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE" limit="all" onChange="spf_search()"/></td>
					<td class="l-table-edit-t" width="10%"><spring:message code="hrms.eduHis"/></td>
					<td class="l-table-edit-c" width="20%">
						<SipingSoft:selectSyCode parentCode="EduHisCode" name="EDU_HIS_CODE" limit="all" onChange="spf_search()"/>	
					</td>
					<td class="l-table-edit-t" width="10%"><spring:message code="hrms.empDivision" /></td>
					<td class="l-table-edit-c" width="20%">
						<SipingSoft:selectSyCode parentCode="EmpDivision" name="EMP_TYPE_CODE" limit="all" onChange="spf_search()"/>
					</td>
				</tr>
				<tr>
					<tr>
					<td class="l-table-edit-t">任职月份</td>
					<td colspan="5" class="l-table-edit-c"><SipingSoft:date
						yearName="year" monthName="month"/></td>
				</tr>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="left" height="30px">
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-left: 10px; "
							onclick="spf_search()">搜索</a>
					</td>
				</tr>
			</table>
		</div>
		<div position="center" id="hrSearchEmpPostRecords"></div>
	</div>
</body>
</html>
