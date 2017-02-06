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
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
        
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script type="text/javascript">
		var $grid ;
	    var $dialog ;
	    // 初始调用
	    $(function ()
	   {
	    	//布局
	        $("#layout1").ligerLayout({
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,       //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
	        }); 
	         f_initGrid();
	    });
	    function f_initGrid()
	    {
	    	$grid = $("#healthInfo").ligerGrid({
	    		checkbox: false,
	            columns: [
		                	{ display: '', name: 'HEALTH_NO',width:10,hide:1},
		                	{ display: '<spring:message code="hrms.examinationDate"/>', name: 'PHYSICAL_DATE',width:180},
		                	{ display: '<spring:message code="hrms.physicalExamination"/>', name: 'CHECK_YN_NAME',width:180},
		                	{ display: '<spring:message code="hrms.examinationResult"/>', name: 'CHECK_RESULT_NAME',width:180},
		                	{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',width:180},
		                	{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK'}
	            ], 
	            usePager: false,rownumbers:true,
                url: "/hrm/empinfo/getHealthInfoList?EMPID=${basicInfo.EMPID }", 
                pageSize: 5,	    
                pageSizeOptions: [5,4,3,2,1], 
	            heightDiff : 0, 
	            width: '99.5%', height: '99%',
	            onDblClickRow: function(rowdata, rowindex, rowDomElement){
	            	 spf_showDetailData(rowdata.HEALTH_NO);
	             }
	        });
	    }

	     function spf_showDetailData(no)
	     { 
	     	$dialog = $.ligerDialog.open({isDrag: false,  showMax:true,showMin:true,
	     		title:'<spring:message code="hrms.detail"/>', 
	     		width: 1100, 
	     		height: 400, 
	     		url: '/hrm/empinfo/viewHealthDetailInfo?HEALTH_NO=' + no
	        	  });
	     }
	    function f_ChildWindowClose (){
	    	$grid.loadData(true); //加载数据
	    	$dialog.close() ;
	    }
	    function spf_add()
	    {
	    	$dialog = $.ligerDialog.open({isDrag: false, showMax:true,showMin:true,
	   		    title:'<spring:message code="hrms.add"/>', 
	    		width: 1100, height: 400, 
	    		url: '/hrm/empinfo/addHealthInfo'
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
	    		width: 1100, height: 400, 
	    		url: '/hrm/empinfo/updateHealthInfo?HEALTH_NO=' + rows.HEALTH_NO
	       	  });
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
			        $.post("/hrm/empinfo/deleteHealthInfo", 
			                [	
			                 	{ name: 'HEALTH_NO', value: rows.HEALTH_NO }
			                ]
			        , function (result)
			        {
			        	$.ligerDialog.closeWaitting();
			            if (result == "Y")
			            {
			                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
		</script>
<style type="text/css"> 
      body{ padding:5px; margin:0; padding-bottom:15px;}
      #layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding:2px" >
<div id="layout1" > 
     <div position="center" id='' title=' ' >
	 <div position="top">   
				<%@include file="viewBasicInfo.jsp"%>
				<br>
				<table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
						<td width="25%" align="left" style="font-weight: bold;">
							<spring:message code="hrms.healthInfo"/>
						</td>	
						<td width="5%" align="right">&nbsp;</td>
						<td align="right"> 
	                    		<SipingSoft:button/>    
						</td>										    
					</tr> 
				</table>  
	</div>
				
      			<div position="left" id='healthInfo'></div> 
	</div>
   </div> 
</body>
</html>
