<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
    <script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	<script src="/resources/js/myhome.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script> 
	  
<script type="text/javascript">
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
          $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid)
              {  
              	if(tabid=="tabitem1"){ 
              		//已经分组人员    
              	} 
              	if(tabid=="tabitem2"){
              		//已经分组人员
              	}  
              	if(tabid=="tabitem3"){
              		//已经分组人员   
              	}   
              } 
              }); 
          //f_tip();
          initCustAction();
     }); 
     function f_tip() {
         $.ligerDialog.tip({  title: '提示信息',content:'您已经登录' });
     }
     function spf_firstLogin()
	    {    
	    	 $.post('/login/checkFirstLogin',{"ADMINID":''},function(back){  
		    	 if(back == 'Y'){
		    		 $dialog = $.ligerDialog.open({isDrag: true,showMax: false,showMin: false, 
						    title: '<spring:message code="change.password"/>',
				      	 	width: 450 , 
				      	 	height: 320 ,  
				  		    url: '/ess/password/changePassword?MENU_CODE=ess0401'
				      }); 
		    	 } 
			});
	    }

     //**************************************************************************

     
	  function spf_showPage(type)
	  {   
		  $dialog = $.ligerWindow.show({isDrag: true,
			    title: '<spring:message code="hrms.details"/>',
	      	 	width: 800 , 
	      	 	height: 360 , 
	      	 	left:120,top:80,
	  		    url: '/login/showWarningInfo?type='+type
	      }); 
	  } 
     //**************************************************************************
    </script>
</head>
<style type="text/css"> 
     body{ padding:5px; margin:0; padding-bottom:15px;}
     #layout1{  width:99.8%;margin:0; padding:0;  }  
</style>
<!-- <body style="padding:0px" onload="spf_firstLogin()"> -->
<body style="padding:2px">
<div id="layout1" >   
		  <div align="left">    
          	   	<div id="navtab1"> 
					<div title='个人视图'>
     					<%-- <%@include file="shortcut.jsp"%> --%> 
     					<%@include file="viewBasicInfo.jsp"%>
     					<%@include file="viewCustomerAction.jsp"%> 
					</div>
					<div title='单位视图'> 
					</div>   
				</div> 
		  </div> 
</div>
</body>
</html>
