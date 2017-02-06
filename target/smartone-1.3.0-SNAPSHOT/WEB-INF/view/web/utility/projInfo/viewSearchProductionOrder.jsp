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

<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid ;
	// 初始调用
	$(function (){
		//布局
		$("#layout1").ligerLayout({
			topHeight: 60, 
			allowLeftResize: false,      //是否允许 左边可以调整大小
			allowRightResize: false,     //是否允许 右边可以调整大小
			allowTopResize: false,      //是否允许 头部可以调整大小
			allowBottomResize: false     //是否允许 底部可以调整大小
		});
		f_initGrid();
		spf_getProjectInfo();
	});
	function f_initGrid(){
		$grid =$("#productionOrder").ligerGrid({
			columns: [
				{name : 'PRO_NO',width : 0,hide:1},
				{ display: '物料编码', name: 'PROD_ID',width:160 },
				{ display: '图纸号', name: 'DRAWING_NO' ,width:160},
				{ display: '重量', name: 'WEIGHT',width:120},
				{ display: '<spring:message code="hrms.projectQuantity"/>', name: 'QUANTITY',width:120}
			], 
			usePager: true,rownumbers: true,
			url: "/utility/projInfo/getProductionOrderList", pageSize: 9, pageSizeOptions:[9,15, 20, 30, 40, 50],
			width: '99.6%', height: '100%'
		});
	}
	function spf_search(){
		$grid.setOptions({
			parms: [
				{ name: 'keyWord', value: $("#keyWord").attr('value')},
				{ name: 'PRO_NO', value: $("#PRO_NO").attr('value')}
			],
			newPage: 1
		});
		$grid.loadData(true);
	}
	function send(){
		var data = $grid.getSelectedRow();
		parent.spf_initSelectEmpInfo(data);
	}
	function spf_selectEmpInfo(){
		return $grid.getSelectedRow();
	}
	
	 //取项目数据 
	function spf_getProjectInfo(){
		 //&callback=?"注意这个是为了解决跨域访问的问题    
		$.post('/utility/otherInfo/getProjectSelectList',{},
			function(result){
				spf_setProjectInfo(result); 
			}
		);
	}
	//设置生产订单下拉列表
	function spf_setProjectInfo(result){ 
		clearSel(document.getElementById("PRO_NO")); //清空
		var PRO_NO = document.getElementById("PRO_NO"); 
		var jsonList = eval("(" + result + ")");
		var option = new Option('<spring:message code="hrms.selection"/>',"");
		PRO_NO.options.add(option); 
		for(var i=0;i<jsonList.length;i++){ 
			var value = "0";var text = "0";  
			for(var key in jsonList[i]){  
					if(key == "ID") 
						value = jsonList[i][key];  
					if(key == "Name") 
					text = jsonList[i][key];  
			}  
			option = new Option(text,value);
			PRO_NO.options.add(option); 
		}
	}
	// 清空下拉列表
	function clearSel(oSelect){ 
		while(oSelect.childNodes.length>0){
		 	oSelect.removeChild(oSelect.childNodes[0]);
		} 
	}
</script>
<style type="text/css">
	body {
		padding: 5px;
		margin: 0;
		padding-bottom: 15px;
	}
	
	#layout1 {
		width: 99.6%;
		margin: 0;
		padding: 0;
	}
</style>
</head>
<body style="padding: 0px">
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
								<td class="l-table-edit-t" width="15%"><spring:message
										code="keyWord" /></td>
								<td class="l-table-edit-c" width="35%"><input type="text"
									name="keyWord" id="keyWord" /></td>
								<td class="l-table-edit-t" width="15%">项目名称</td>
								<td class="l-table-edit-c" width="35%">
									<select name="PRO_NO" id="PRO_NO" onChange="spf_search();"></select></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="left" height="30px"><a class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_search()"><spring:message code="search" /></a></td>
				</tr>
			</table>
		</div>
		<div position="center" id='productionOrder'></div>
	</div>
</body>
</html>
