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
				topHeight: 90, 
				allowLeftResize: false,		//是否允许 左边可以调整大小
				allowRightResize: false,	//是否允许 右边可以调整大小
				allowTopResize: false,		//是否允许 头部可以调整大小
				allowBottomResize: false	//是否允许 底部可以调整大小
			});
			f_initGrid();
		});
function f_initGrid(){
	$grid =$("#empInfo").ligerGrid({
		columns: [
					{ display: '', name: 'POST_NO',width:90,hide:true },
					{ display: '<spring:message code="hrms.basicCode"/>', name: 'POST_ID' ,width:90},
					{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:150},
					{ display: '<spring:message code="hrms.position"/>',name: 'POSITION_NAME', width:150 , align: 'center'},
					{ display: '<spring:message code="hrms.postGroup"/>', name: 'POST_GROUP_NAME',width:150,align: 'center'}
				], 
				usePager: true,rownumbers: true,
				parms: [	 
						{ name: 'EVA_KPI_ID',value: "${kpiItem.EVA_KPI_ID}"}
					],
				url: "/utility/postInfo/getPostInfoList", pageSize: 10, pageSizeOptions:[10,20, 30, 40, 50],
				width: '99.6%', height: '100%'		
		});
}
function spf_search(){
	$grid.setOptions({parms: [
			{ name: 'keyWord', value: $("#keyWord").val()},
			{ name: 'POSITION_ID', value: $("#POSITION_ID").val()},
			{ name: 'POST_GROUP_ID', value: $("#POST_GROUP_ID").val()},
			{ name: 'EVA_KPI_ID', value: "${kpiItem.EVA_KPI_ID}"}
		],
		newPage: 1
	});
	$grid.loadData(true);
}

function spf_selectEmpInfo()
{
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
			<tr><td height="2"></td></tr>
			<tr>
				<td align="center" valign="middle"> 
					<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr> 
							<td class="l-table-edit-t" width="20%"><spring:message code="keyWord"/></td>
							<td class="l-table-edit-c" width="30%">
								<input type="text" name="keyWord" id="keyWord" />
							</td>
	           	   			<td class="l-table-edit-t" width="20%">
	           	   				<spring:message code="hrms.position"/></td>
			           	   <td class="l-table-edit-c" width="30%">
				       	   		<SipingSoft:selectPosition name="POSITION_ID" limit="all" onChange="spf_search()"/>
				       	   </td>
				       	 </tr>
				       	 <tr>
							<td class="l-table-edit-t">职群</td>
							<td class="l-table-edit-c" colspan="3">
								<SipingSoft:selectPostGroup name="POST_GROUP_ID" limit="all" onChange="spf_search();"/>
							</td>
						</tr> 
					</table>
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="l-table-edit" > 
			<tr>
				<td align="left" height="30px">
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>   
				</td>
			</tr> 
		</table>
	</div>
	<div position="center" id='empInfo' ></div>
	</div>
</body>
</html>
