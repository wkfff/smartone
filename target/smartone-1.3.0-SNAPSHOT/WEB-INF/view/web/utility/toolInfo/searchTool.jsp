<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> 
<title></title> 
 	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
	<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
		var $grid ;
		// 初始调用
		$(function (){
			//布局
			$("#layout1").ligerLayout({
                topHeight: 60, 
				allowLeftResize: false,		//是否允许 左边可以调整大小
				allowRightResize: false,	//是否允许 右边可以调整大小
				allowTopResize: false,		//是否允许 头部可以调整大小
				allowBottomResize: false	//是否允许 底部可以调整大小
			});
			f_initGrid();
		});
function f_initGrid(){
	$grid =$("#toolInfo").ligerGrid({
		columns: [
					{ display: '', name: 'ASSET_NO',width:1,hide:true },
					{ display: '资产名称', name: 'ASSET_NAME' ,width:320, align: 'center'},
					{ display: '资产种类', name: 'ASSET_TYPE',width:320, align: 'center'}
				],
				usePager: true,rownumbers: true,
				parms: [
	                   	{ name: 'ASSET_TYPE',value: $("#ASSET_TYPE").val()}
	                   ],
				url: "/utility/toolInfo/getToolInfoList", pageSize: 10, pageSizeOptions:[10,20, 30, 40, 50],
				width: '99.6%', height: '100%'
		});
}
function spf_search(){
	$grid.setOptions({parms: [
			{ name: 'keyWord', value: $("#keyWord").val()},
			{ name: 'ASSET_TYPE', value: $("#ASSET_TYPE").val()}
		],
		newPage: 1
	});
	$grid.loadData(true);
}
function spf_selectEmpInfo(){
	return $grid.getSelectedRow();
}
</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }  
</style>
</head>	
<body style="padding:2px" > 
	<div id="layout1" > 
	<div position="top">
		<table width="100%" border="0" >
			<tr>
				<td align="center" valign="middle"> 
					<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr> 
							<td class="l-table-edit-t" width="20%"><spring:message code="keyWord"/></td>
							<td class="l-table-edit-c" width="30%">
								<input type="text" name="keyWord" id="keyWord" />
							</td>
							<td width="20%" class="l-table-edit-t">资产类别</td>
							<td width="30%" class="l-table-edit-c" id="categorySelection">
								<SipingSoft:selectSyCode parentCode="AssetCategoryCode" name="ASSET_TYPE"
									 limit="all" onChange="spf_search();"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="l-table-edit" width="100%"> 
			<tr>
				<td align="left" height="30px">
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>
				</td>
			</tr>
		</table>
	</div>
	<br>
	<div position="center" id='toolInfo' ></div>
	</div>
</body>
</html>
