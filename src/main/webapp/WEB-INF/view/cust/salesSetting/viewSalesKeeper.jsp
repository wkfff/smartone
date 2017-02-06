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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
		
		var $grid ;
		var $dialog ;
		// 初始调用
		$(function ()
		{
			//布局
		    $("#layout1").ligerLayout({
		    	topHeight: 60,
		        allowLeftResize: false,      //是否允许 左边可以调整大小
		        allowRightResize: false,     //是否允许 右边可以调整大小
		        allowTopResize: false,       //是否允许 头部可以调整大小
		        allowBottomResize: false     //是否允许 底部可以调整大小
		    });
		    
		    f_initGrid();
		});
		
		function f_initGrid()
		{
			$grid = $("#salesKeeperInfo").ligerGrid({
				checkbox: false,
		        columns: [
		        { display: '<spring:message code="hrms.empid"/>', name: 'EMP_ID',width:90},
		        { display: '<spring:message code="hrms.name"/>', name: 'EMP_NAME',width:100},
		        { display: '<spring:message code="hrms.dept"/>', name: 'EMP_DEPT',width:140},
		        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'EMP_STATUS',width:90},
		        { display: '<spring:message code="hrms.company"/>', name: 'EMP_CPNY',width:160}
		        ],
		        usePager: true,rownumbers: true,
		        pageSize:20,
		        url: '/sales/salesSetting/getSalesKeeperList',
		        width: '99.6%', height: '100%',
		        onDblClickRow: function(rowdata, rowindex, rowDomElement){
		       	 	spf_showDetailData(rowdata.EMP_ID);
		        }
		    });
		}
		function spf_showDetailData(empID)
		{ 
		  	 $dialog = $.ligerDialog.open({isDrag: false,
			     title:'<spring:message code="employee.information"/>',
		   		 width: 800, height: 400, 
		   		 url: '/utility/empInfo/viewAttSearchEmployee?AR_ADMIN_ID='+empID
			    }); 
		}
		function spf_search()
		{           
			$grid.setOptions({ parms: [	
			                        	{ name: 'keyWord', value: $("#keyWord").val()},
			                        	{ name: 'DEPT_ID', value: $("#DEPT_ID").val()},
			                           ],
			                   newPage: 1
			                 }); //设置数据参数
		    $grid.loadData(true); //加载数据
		}
		
		function spf_delete()
		{
			$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
		    {
		        if(yes){
		          
			     	 var rows = $grid.getSelectedRow(); 
			
			         if (!rows || rows.length == 0) { 
			        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			        	 return ; 
			        }
			         if (rows.length > 1){
			         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			         } 
					
			        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
			        $.post("/sales/salesSetting/removeSalesKeeper", 
			                [	
			                 	{ name: 'EMP_ID', value: rows.EMP_ID },
			                ]
			        , function (result)
			        {
			        	$.ligerDialog.closeWaitting();
			            if (result == "Y")
			            {
			                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function ()
			                {
			                	$grid.loadData(true); //加载数据
			                });
			            }
			            else
			            {
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
		
		function spf_add()
		{
			$dialog = $.ligerDialog.open({isDrag: false, 
				 title:'<spring:message code="hrms.add"/>', 
		    	 width: 1000, 
		    	 height: 500, 
		    	 url: '/sales/salesSetting/addSalesKeeper'
		    	  }); 
		}
		
		function spf_update()
		{ 
			var rows = $grid.getSelectedRow(); 
		
		    if (!rows || rows.length == 0) { 
		       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		    	 return ; 
		    }
		    if (rows.length > 1){
		    	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		    } 
		    
			$dialog = $.ligerDialog.open({isDrag: false, 
		    	 title:'<spring:message code="hrms.update"/>', 
		    	 width: 1000, 
		    	 height: 500, 
		       	 url: '/sales/salesSetting/updateSalesKeeper?SUPERVISOR_ID=' + rows.EMP_ID
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
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
		                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
		                <td class="l-table-edit-c">
		                	<SipingSoft:deptTree name="DEPT_ID" limit="hr" onChange="spf_search();"/>
		                </td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='salesKeeperInfo'></div>
		</div>
	</div>
</body>
</html>
