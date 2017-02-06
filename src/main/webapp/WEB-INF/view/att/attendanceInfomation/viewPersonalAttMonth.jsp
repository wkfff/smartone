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
	<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
	<script src="/resources/js/json2.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<script type="text/javascript">
	var $grid;
	var $dialog;
	var lockFlag = "0";
	// 初始调用
	$(function(){
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize: false,	//是否允许 左边可以调整大小
			allowRightResize: false,	//是否允许 右边可以调整大小
			allowTopResize: false,	//是否允许 头部可以调整大小
			allowBottomResize: false	//是否允许 底部可以调整大小
		});
		var attColumnsList = ${attColumnsList} ;
		var colums= [] ;
		$(attColumnsList).each(function(index, row){
			if(row.COLUMN_NAME=="DEPTNAME"||row.COLUMN_NAME=="CHINESENAME"||row.COLUMN_NAME=="EMPID"){
				colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:100 ,frozen:true }) ;
			}else if(row.COLUMN_NAME=="ATT_M_110"||row.COLUMN_NAME=="ATT_M_111"||row.COLUMN_NAME=="ATT_M_119"){
				colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:180 , editor:{type : 'float'} });
			}else{
				colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:120 , editor:{type : 'float'} });
		}});
		spf_initGrid(colums);
		setTimeout('spf_lockFlag()',2000);
	});
	function spf_lockFlag(){
		var attMonth = $("#year").val() + $("#month").val() ;  
		$.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=MONTHLY_LOCK_FLAG&ATT_MONTH='+attMonth,function(back){
				lockFlag = back;
			}
		);
	}
	function spf_initGrid(colums){
		var attMonth = $("#year").val() + $("#month").val() ;
		$grid = $("#attMonthInfo").ligerGrid({ 
			columns: colums,
			usePager: true,enabledEdit: false, rownumbers:true,
			url: '/att/attendanceMintenance/getAttMonthInfo',
			parms: [	 
				{ name: 'ATT_MONTH', value: attMonth },
				{ name: 'empId', value: '${empId}'}
			],
			width: '99.6%', height: '100%'
		});
	}
	function spf_search(){
		var attMonth = $("#year").val() + $("#month").val();
		$grid.setOptions({	parms: [
				{ name: 'empId', value: '${empId}'},
				{ name: 'ATT_MONTH', value: attMonth }],
		newPage: 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_insExcel(colums){
		var attMonth = $("#year").val() + $("#month").val() ; 
		location.href='/report/att/month/viewAttMonthReport?ATT_MONTH=' + attMonth+"&EMPID=${empId}";
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>'); 
	}
	</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{ width:99.8%;margin:0; padding:0;}
</style>
</head>
<body style="padding:2px" >
<div id="layout1" >
	<div align="left" position="center" id='' title=' '>
	<div align="left">
			<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="15%" class="l-table-edit-t">
						<spring:message code="hrms.attendanceMonth"/></td>
					<td width="85%" class="l-table-edit-c">
						<SipingSoft:date yearName="year" monthName="month" onChange="spf_search();spf_lockFlag();"/></td> 
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
				<tr>
					<td align="left"> 
						<SipingSoft:button />
						<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_insExcel()"><spring:message code="hrms.excelExport"/></a>  
					</td>
				</tr>
			</table>
		<div position="center" id='attMonthInfo'></div>
	</div>
</div>
</div>
</body>
</html>
