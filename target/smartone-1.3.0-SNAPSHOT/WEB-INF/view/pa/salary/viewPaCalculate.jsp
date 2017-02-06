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
	var lockFlag = "0";
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize: false,
			//是否允许 左边可以调整大小
			allowRightResize: false,
			//是否允许 右边可以调整大小
			allowTopResize: false,
			//是否允许 头部可以调整大小
			allowBottomResize: false //是否允许 底部可以调整大小
		});
		var paColumnsList = ${paColumnsList} ;
		var colums= [] ;
		$(paColumnsList).each(function(index, row){  
			if(row.COLUMN_NAME=="EMPID"||row.COLUMN_NAME=="CHINESENAME"||row.COLUMN_NAME=="DEPTNAME"||row.COLUMN_NAME=="POST_NAME" ){
				colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:90 ,frozen:true }) ;
			}else{
				colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:80,editor:{type : 'float'} }) ;
			}
		}); 
		spf_initGrid(colums); 
	
		spf_lockFlag();
	});
	
	function spf_lockFlag() {
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		$.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=PA_LOCK_FLAG&PA_MONTH=' + paMonth,
		function(back) {
			lockFlag = back;
		});
	}
	function spf_Calculate() {
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		spf_lockFlag();
		if (lockFlag == '0') {
			$.ligerDialog.confirm('<spring:message code="pa.whetherToStartTheCalculation"/>[' + paMonth + ']<spring:message code="pa.monthlySalary"/>?', '<spring:message code="hrms.warning"/>',
			function(yes) {
				if (yes) {
					$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
					$.ajax({
						type: 'post',
						cache: false,
						contentType: 'application/json',
						url: '/pa/salary/paCalculate?PA_MONTH=' + paMonth,
						dataType: 'json',
						success: function(result) {
							$.ligerDialog.closeWaitting();
							$.ligerDialog.warn(result, '<spring:message code="hrms.warning"/>');
							spf_search();
						}
					});
				}
			});
		} else {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotCalculate"/>');
			return;
		}
	}
	function spf_initGrid(colums){
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		$grid = $("#paMonthInfo").ligerGrid({ 
			columns: colums,
			url: '/pa/salary/getPaMonInfo',
			parms: [
				{ name: 'PA_MONTH', value: paMonth }
			],
			enabledEdit: true,usePager: true,rownumbers: true,
			width: '99.6%', height: '100%'
		});
	}
	function spf_search(){
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		$grid.setOptions({ parms: [
				{ name: 'PA_MONTH', value: paMonth },
				{ name: 'DEPTID', value: $("#deptID").val()}
			],
			newPage: 1
		}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	/**
	*提交改变数据
	*/
	function spf_save(){
		var paMonth = $("#paYear").val() + $("#paMonth").val();
		if(lockFlag == '0'){ 
			var rows = $grid.getData() ;
			var jsonData = [];
			$(rows).each(function(index, row){
				if(this.__status != null && this.__status == 'update'){
					jsonData.push(row);
				}
			});
			if(jsonData.length == 0){
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
				return ;}
				$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
				$.post('/pa/salary/updatePaMonthInfo?PA_MONTH='+paMonth , 
					[	
						{ name: 'jsonData', value: JSON.stringify(jsonData) },
					]
				,function (result){
					$.ligerDialog.closeWaitting();
					if (result == "Y"){ 
						$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
							$grid.loadData(true); //加载数据 
						});
					}else{
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
					}
				});
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotCalculate"/>');
			return;
		}
	}
</script>
<style type="text/css"> 
	body { padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99%;margin:0; padding:0;  }  
</style>
</head>
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="20%" class="l-table-edit-t">
							<spring:message code="hrms.wageMonth" /></td>
						<td width="30%" class="l-table-edit-c">
							<SipingSoft:date yearName="paYear" monthName="paMonth" onChange="spf_search();spf_lockFlag();"/></td>
						<td class="l-table-edit-t" width="20%"><spring:message code="hrms.dept"/></td>
						<td class="l-table-edit-c" width="30%">
							<SipingSoft:deptTree name="deptID" limit="hr"/></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
					<tr>
						<td align="left"><SipingSoft:button/>
							<a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; " onclick="spf_Calculate()"><spring:message code="settlement" /></a>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='paMonthInfo'></div>
		</div>
	</div>
</body>
</html>
