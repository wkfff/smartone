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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid ;
	var $dialog ;
	var lockFlag = "0" ;
	// 初始调用
	$(function (){ 
		//布局
		$("#layout1").ligerLayout({
			topHeight: 90,  
			allowLeftResize: false,//是否允许 左边可以调整大小
			allowRightResize: false,//是否允许 右边可以调整大小
			allowTopResize: false,//是否允许 头部可以调整大小
			allowBottomResize: false//是否允许 底部可以调整大小
		}
		);
		var attColumnsList = ${attColumnsList} ;
		var colums= [] ;
		$(attColumnsList).each(function(index, row){  
			if(row.ITEM_ID=="EMPID"||row.ITEM_ID=="CHINESENAME"||row.ITEM_ID=="DEPTNAME"){
				colums.push({ display: row.ITEM_NAME, name: row.ITEM_ID , width:100 ,frozen:true }) ;
			}else{
				colums.push({ display: row.ITEM_NAME, name: row.ITEM_ID , width:120 }) ;
			}
		}); 
		spf_initGrid(colums); 
	});
	function spf_initGrid(colums){
		var attMonth = $("#year").val() + $("#month").val();
		$grid = $("#attMonInfo").ligerGrid({ 
			columns: colums,
			usePager: true,enabledEdit: false, rownumbers:true,
			url: '/att/attendanceInfomation/getAttMonInfo?MENU_CODE=${paraMap.MENU_CODE}',
			parms: [
					{ name: 'ATT_MONTH', value: attMonth },
					{ name: 'empId', value: '${empId}'}],
			width: '99.6%', height: '100%'
		});
	}

	function spf_search(){
		var attMonth = $("#year").val() + $("#month").val();
		$grid.setOptions({ 
			parms: [	
				{ name: 'empId', value: '${empId}'},
				{ name: 'ATT_MONTH', value: attMonth }
			],
			newPage: 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_insExcel(){
		var attMonth = $("#year").val() + $("#month").val() ; 
		//alert(attMonth) ; 
		location.href='/report/att/month/viewAttInfoReport?MENU_CODE=${paraMap.MENU_CODE}&ATT_MONTH=' + attMonth;
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>'); 
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
								<td width="15%" class="l-table-edit-t"><spring:message
										code="hrms.attendanceMonth" /></td>
								<td width="85%" class="l-table-edit-c"><SipingSoft:date
										yearName="year" monthName="month"
										onChange="spf_search();spf_lockFlag();" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
		</div>
		<div position="center" id='attMonInfo'></div>
	</div>
</body>
</html>
