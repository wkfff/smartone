<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
   <meta http-equiv="X-UA-Compatible" content="IE=edge" >
   
    <!-- CSS -->
   <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
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
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        
         f_initGrid();
    });

    function f_initGrid()
    {
    	$grid = $("#cycleInfo").ligerGrid({
    		checkbox: false,
            columns: [
            { display: '<spring:message code="hrms.sequence"/>', name: 'STAT_NO' },
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION'},
            { display: '<spring:message code="hrms.startDate"/>', name: 'VALID_DATE_FROM'},
            { display: '<spring:message code="hrms.endDate"/>', name: 'VALID_DATE_TO'},
            { display: '<spring:message code="hrms.start.day"/>', name: 'START_DATE'},
            { display: '<spring:message code="hrms.end.day"/>', name: 'END_DATE'},
            { display: '<spring:message code="hrms.property"/>', name: 'CYCLE_TYPE_NAME'},
            { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width: 120},
            { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY', width: 120, render: function (row, index)
                {
            		return '<img src="/resources/images/a_' + row.ACTIVITY + '.gif">';
            	}
        	}
            ],
            usePager: true,rownumbers: true,
            url: '/att/attendanceSettings/getCycleInfoList',
            width: '99.6%', height: '100%',
            heightDiff : 0
        });
    }

    function spf_delete()
    {
  		
    }

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    	$dialog.close() ;
    }

    function spf_add()
    {
    	$dialog = $.ligerDialog.open({isDrag: false, 
   		    title:'<spring:message code="hrms.add"/>', 
    		width: 1100, 
    		height: 400, 
    		url: '/att/attendanceSettings/addCycleInfo'
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
    		width: 1100, 
    		height: 400, 
    		url: '/att/attendanceSettings/updateCycleInfo?STAT_NO=' + rows.STAT_NO
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
		        $.post("/att/attendanceSettings/deleteCycleInfo", 
		                [	
		                 	{ name: 'STAT_NO', value: rows.STAT_NO }
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
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
	                    <SipingSoft:button/>     
					</td>
	           </tr>  
       		</table> 
	  </div>
      <div position="center" id='cycleInfo'></div>
</div>
       </div>
</body>
</html>
