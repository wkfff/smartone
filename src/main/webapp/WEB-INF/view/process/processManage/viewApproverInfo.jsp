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
		         allowTopResize: false,      //是否允许 头部可以调整大小
		         allowBottomResize: false     //是否允许 底部可以调整大小
          }
         ); 
         spf_initGrid();  
    });
   
    function spf_initGrid()
    {
    	$grid = $("#affirmorInfo").ligerGrid({
    	 checkbox: false,   
            columns: [ 
            { display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',hide:1,width: 10},
            { display: '状态', name: 'STATUS_NAME',width: 100},
            { display: '审核结果', name: 'AFFIRM_FLAG',width: 100, 
            	render: function (item)
                { 
                	if( item.AFFIRM_FLAG == 0){   //待审批 
    	        		return '<span style="font-weight:bold;color:purple">待确认</span>';
        	   		} else if( item.AFFIRM_FLAG == 1){
        	    		return '<span style="font-weight:bold;color:green">已通过</span>';
        	    	} else if( item.AFFIRM_FLAG == 2){
        	    		return '<span style="font-weight:bold;color:red">已否决</span>';
        	    	}
            	} 
            },
            { display: '<spring:message code="hrms.name"/>', name: 'AFFIRMOR_NAME',width: 100},
            { display: '公司邮件', name: 'C_EMAIL',width: 200},
            { display: '办公电话', name: 'OFFICE_PHONE',width: 200}
            
            ],
            usePager: false, rownumbers:true, 
            url: '/process/processManage/getAffirmorResultList?OBJECT_ID=${paramMap.OBJECT_ID}',
			parms: [
	        	],
            width: '98%', height: '89%'
        });
    } 
</script>  
<style type="text/css"> 
   body{ padding:5px; margin:0; padding-bottom:15px;}
   #layout1{  width:99%;margin:0; padding:0;  }
</style>
</head>
<body style="padding:0px" > 
	<div id="layout1" >  
     <div position="center" id='' title=' ' >
	  	<div id="affirmorInfo" ></div>
	  </div> 
	  </div> 
</body>
</html>
