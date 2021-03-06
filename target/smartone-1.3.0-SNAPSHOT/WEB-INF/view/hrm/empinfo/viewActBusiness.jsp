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
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
        
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
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
	    	$grid = $("#businessInfo").ligerGrid({
	    		checkbox: false,
	            columns: [
		                	{ display: '<spring:message code="hrms.times"/>', name: 'TRANS_NAME',hide:'1'},
		                	{ display: '<spring:message code="hrms.workingDescription"/>', name: 'BIZ_NAME'},
		                	{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE'},
		                	{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE'},
		                	{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK'}
	            ], 
	            usePager: true,rownumbers:true,
                url: "/hrm/empinfo/getBizInfoList?EMPID=${basicInfo.EMPID }",  
	            heightDiff : 0, 
	            width: '99.5%', height: '99%'
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
				<table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
						<td width="25%" align="left" style="font-weight: bold;">
							<spring:message code="hrms.workingDescription"/>
						</td>	
						<td width="65%" align="right">&nbsp;</td>
						<td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>										    
					</tr> 
				</table>  
	</div>
				
      			<div position="left" id='businessInfo'></div> 
	</div>
	</div> 
</body>
</html>
