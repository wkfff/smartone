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
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>  
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript"> 
	var $quota_grid ;
	// 初始调用
	$(function ()
	{
		//布局
		$("#layout1").ligerLayout({
				allowLeftResize: false,		 //是否允许 左边可以调整大小
				allowRightResize: false,	 //是否允许 右边可以调整大小
				allowTopResize: false,		//是否允许 头部可以调整大小
				allowBottomResize: false	 //是否允许 底部可以调整大小
			}
		);
		spf_deptQuota_initGrid();
	});
	/*部门信息弹出框收缩js
	*/
	function spf_search(){
    	$quota_grid.setOptions({ 
    		parms: [
                  { name: 'DEPTID', value: $("#DEPTID").attr('value')}
			],
			newPage: 1
		}); //设置数据参数
		$quota_grid.loadData(true); //加载数据
	}
	//定编列表
	function spf_deptQuota_initGrid(){
		$quota_grid = $("#deptQuotaInfo").ligerGrid({
			checkbox: false,
			columns: [
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},
				{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120},
				{ display: '<spring:message code="hrms.quotaNumber"/>', name: 'QUOTA_NUMBER', width: 120},
				{ display: '<spring:message code="hrms.realNumber"/>', name: 'REAL_NUMBER', width: 120},
				{display: '<spring:message code="hrms.differenceOfPeople"/>', name: 'DIFFERENCE', width: 120,
					render: function(rowdata, index){
						rowdata.DIFFERCENCE = rowdata.REAL_NUMBER - rowdata.QUOTA_NUMBER;
						if (rowdata.DIFFERCENCE < 0) {
							return '<p style="color:red">'+rowdata.DIFFERCENCE+'</p>';
						} else {
							return '<p style="color:green">'+rowdata.DIFFERCENCE+'</p>';
						}
					}
				},
				{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 160, editor: { type: 'textarea', height: 100 }}
			],
			usePager: true, rownumbers:true,
			url: "/hrm/org/getDeptQuotaList",
			pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
			width: '99.8%', height: '100%'
		 });
	}
	function spf_insExcel() {
		var deptId = $("#DEPTID").val();
		location.href = '/report/hr/getDeptQuotaByExcel?DEPTID=' + deptId;
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
<body style="padding:2px" >
	<div id="layout1" > 
    	<div position="center" id='' title=' ' >
			<div position="top">  
				<table align="center" width="99.8%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td class="l-table-edit-t" width="20%"><spring:message
							code="hrms.dept" /></td>
						<td class="l-table-edit-c" width="80%">
							<SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
					<tr>
						<td align="left" height="30px;">
							<SipingSoft:button/>
							<a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_insExcel()"><spring:message code="hrms.excelExport" /></a>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='deptQuotaInfo'></div>
		</div>
	</div>
</body>
</html>