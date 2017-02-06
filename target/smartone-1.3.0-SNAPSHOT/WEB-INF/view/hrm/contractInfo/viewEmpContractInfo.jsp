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
    	$grid = $("#contractInfo").ligerGrid({
    		columns: [
    		{ display: '', name: 'CONTRACT_NO', width: 10,hide:1},
            { display: '<spring:message code="hrms.times"/>', name: 'TOTAL_PERIOD', width: 60, type: 'int' },
            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90}, 
            { display: '<spring:message code="hrms.contractType"/>', name: 'CONTRACTTYPE'},
            { display: '<spring:message code="hrms.startDate"/>', name: 'CONTRACTSTARTDATE'},
            { display: '<spring:message code="hrms.endDate"/>', name: 'CONTRACTENDDATE'},
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',type:"string" , width: 200}
            ],
            enabledEdit: false,usePager: true,rownumbers:true,
            url: '/hrm/contractInfo/getContractInfoList?keyWord=${paraMap.keyWord}',
            width: '99.6%', height: '100%', 
            heightDiff : 0
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
      	<div position="center" id='contractInfo'></div> 
</div>
</body>
</html>
