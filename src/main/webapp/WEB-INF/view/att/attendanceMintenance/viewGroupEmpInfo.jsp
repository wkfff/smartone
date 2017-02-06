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
            allowTopResize: false       //是否允许 头部可以调整大小
        });
        
         f_initGrid();
    });

    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: false,
            columns: [
                      	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID'},
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME'}, 
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME'},
			            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME'}
            ],
            usePager: true, enabledEdit: false,
            url: '/att/attendanceSettings/getDynamicGroupEmpInfo?GROUP_NO=${paraMap.GROUP_NO}',
            width: '99.6%', height: '100%'
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
	     <div align="left" position="center" id='' title=' ' >
		  <div align="left"> 
	  </div>
      			<div position="center" id='empInfo'></div> 
        	</div> 
       </div>
</body>
</html>
