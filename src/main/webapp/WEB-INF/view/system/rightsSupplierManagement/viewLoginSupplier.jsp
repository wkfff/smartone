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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid ;
    var $dialog ;
    // 初始调用
    $(function ()
    {
    	//布局
        $("#layout1").ligerLayout({
	        topHeight:55,
	        allowLeftResize: false,      //是否允许 左边可以调整大小
	        allowRightResize: false,     //是否允许 右边可以调整大小
	        allowTopResize: false,      //是否允许 头部可以调整大小
	        allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
        $("*[name='ACTIVITY']").css("width","200px").css("height","20px").css("line_height","20px").css("border","1px solid #c1dcfa").css("font-size","12px");
       
    });

    function f_initGrid()
    {
		$grid = $("#loginSupplierInfo").ligerGrid({
			checkbox: false,
			columns: [
						{ display: '账号ID', name: 'ADMINID',hide:1},
						
						{ display:'供应商ID',name:'CPNY_ID',hide:1},
						{ display: '供应商名称', name: 'SUPPLIER_NAME', align: 'center',width:'20%'},
						{ display: '英文名称', name: 'SUPPLIER_EN_NAME', align: 'center',width:'10%'},
						{ display: '联系人', name: 'SUPPLIER_CONTACTS', align: 'center',width:'10%'},
						{ display: '账号', name: 'USERNAME', align: 'center',width:'10%'},
						{ display: '角色', name: 'SCREEN_NAME', align: 'center',width:'20%'},
						{ display: '状态',  name: 'ACTIVITY', align: 'center',width: '10%',render:function(result){
							if(result.ACTIVITY==1)
								{
									return  '可用';
								}else
									{
										return '不可用';
									}
						}}
						],
		            usePager: true, 
		            rownumbers: true,
		            root: 'loginSupplierInfo',
		            record: 'loginSupplierInfoCnt',
		            pageSize:20,
		            url: '/system/rightsSupplierManagement/getLoginSupplierInfo',
		            width: '99.6%', height: '100%',
		            heightDiff : 0 
		        });
		
    }
    
    function spf_search()
    {
    	$grid.setOptions({ parms: [
    	                       	{ name: 'SUPPLIER_NAME', value: $("#KEYWORD").val()},
    	                       	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()}
    	                          ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    
    function spf_delete()
    {	var row = $grid.getSelectedRow(); 
    	if (!row || row.length == 0) {
   			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
   			return ;
    	}
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
			if(yes){
				$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
				$.post('/system/rightsSupplierManagement/deleteLoginSupplier',{"CPNY_ID":row.CPNY_ID}, function(result){
					$.ligerDialog.closeWaitting();
					if (result == "Y")
  		            {
  		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
  		                {
  		                	$grid.loadData(true);
  		                });
  		            }else{
  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
  		            }
				});
			}
		});
	}
    
    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    	$dialog.close() ;
    }
    
    function spf_update()
    { 
    	var rows = $grid.getSelectedRow(); 
    	if(!rows || rows.length == 0) { 
    		$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
    		return ; 
    	}
        if (rows.length > 1){
        	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
        }
    	$dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.update"/>', 
    		width: 700, height:250, 
    		top:"20%",
    		url: '/system/rightsSupplierManagement/updateLoginSupplierView?ACTIVITY=1&CPNY_ID=' + rows.CPNY_ID +'&ADMINID='+ rows.ADMINID
        });
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
	
	.search{
	
	width: 200px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #c1dcfa;
	font-size: 12px;
	margin-left: 3px;
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
								<td class="l-table-edit-t"><spring:message code="keyWord" /></td>
								<td class="l-table-edit-keyword">
									<input name="KEYWORD"  type="text" id="KEYWORD"  class="search"/></td>
									
									<td class="l-table-edit-t"><spring:message code="hrms.active" /></td>
								<td class="l-table-edit-c">
									<SipingSoft:selectStatus  name="ACTIVITY" limit="all" onChange="spf_search()"/></td>
									</tr>
							
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="left" height="25px"><SipingSoft:button /></td>
				</tr>
			</table>
		</div>
		<div position="center" id='loginSupplierInfo'></div>
	</div>
</body>
</html>
