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
	$grid =$("#roleInfo").ligerGrid({
		checkbox: false,
        columns: [
        { display: '<spring:message code="hrms.primaryKey"/>', name: 'SCREEN_GRANT_NO', width: 90, type: 'int' },
        { display: '<spring:message code="hrms.basicCode"/>', name: 'SCREEN_GRANT_ID'},
        { display: '<spring:message code="hrms.chineseName"/>', name: 'SCREEN_GRANT_NAME', align: 'left'},
        { display: '<spring:message code="hrms.englishName"/>', name: 'SCREEN_GRANT_EN_NAME', align: 'left'},
        { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 150, align: 'left'}, 
        { display: '<spring:message code="hrms.active"/>', name: 'STATUS', align: 'center',isSort: false},  
        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', align: 'center',isSort: false}
        ],
        usePager: true, rownumbers: true,dataAction: 'server', root: 'rolesGroupList', record: 'rolesGroupCnt',
        pageSize:10,
        url: '/system/rightsManagement/getRolesGroupList',
        parms: [
            	{ name: 'ACTIVITY', value: '1'}
               ],
        width: '99.6%', height: '100%'
		});
}
function spf_search()
{
	$grid.setOptions({ parms: [	
	                        	{ name: 'SCREEN_GRANT_NAME', value: $("#SCREEN_GRANT_NAME").attr('value')},
	                        	{ name: 'ACTIVITY', value: '1'}
	                           ],
	                   newPage: 1
	                 }); //设置数据参数
    $grid.loadData(true); //加载数据
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
	<div>
		<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td class="l-table-edit-t"><spring:message code="keyWord"/></td>
				<td class="l-table-edit-c">
					<input name="SCREEN_GRANT_NAME" type="text" id="SCREEN_GRANT_NAME" />
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
	<div id='roleInfo' ></div>
	</div>
</body>
</html>
