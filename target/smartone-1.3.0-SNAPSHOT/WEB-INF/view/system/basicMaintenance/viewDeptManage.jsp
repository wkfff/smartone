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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
	<script src="/resources/js/common.js" type="text/javascript"></script>
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
	            allowLeftResize: true,      //是否允许 左边可以调整大小
	            allowRightResize: true,     //是否允许 右边可以调整大小
	            allowTopResize: true,      //是否允许 头部可以调整大小
	            allowBottomResize: true     //是否允许 底部可以调整大小
            }
          );
        
         spf_initGrid();
    });

    function spf_initGrid()
    {
    	$grid = $("#deptInfo").ligerGrid({
    		checkbox: true,
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'DEPTNO', width: 90,align: 'center', type: 'int' },
            { display: '<spring:message code="hrms.basicCode"/>', name: 'DEPTID', align: 'left'},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'DEPTNAME', align: 'left'},
            { display: '<spring:message code="hrms.englishName"/>', name: 'DEPT_EN_NAME', align: 'left'},
            { display: '<spring:message code="hrms.location"/>', name: 'AREA', align: 'left'},
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left'},
            { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY',align: 'center'}
            ],
            usePager: true, rownumbers: true,dataAction: 'server', root: 'deptInfoList', record: 'deptInfoListCnt',
            url: '/system/basicMaintenance/getDeptInfoList',
            width: '99%', height: '99%', 
            heightDiff : 1
        });
    }
   
    function spf_update(){
        var CPNY_ID = "" ;
    	var rows = $grid.getCheckedRows();
    	
        if (!rows || rows.length == 0) { 
       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
    	 return ; 
    }
        if (rows.length > 1){
        	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
        }
        
        $(rows).each(function ()
        {
        	CPNY_ID = this.CPNY_ID ;
        });

    	$dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.update"/>', 
    		width: $("#layout1").width()-50, height: $("#layout1").height()-120, url: '/system/basicMaintenance/updateCompanyInfo?CPNY_ID=' + CPNY_ID
       	  });
    }
    
    function spf_delete()
    {
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
		     	 var rows = $grid.getCheckedRows();
		
		         if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
		         if (rows.length > 1){
		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		         }

		         var row = rows[0] ;
				
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/basicMaintenance/deleteCompanyInfo", 
		                [	
		                 	{ name: 'CPNY_ID', value: row.CPNY_ID },
		                 	{ name: 'CPNY_ID', value: row.CPNY_ID }
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
    
    function spf_add(){ 

    	$dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
    		 width: $("#layout1").width()-50, height: $("#layout1").height()-120, url: '/system/basicMaintenance/addCompanyInfo'
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
      <div position="center" id='deptInfo'></div>
	  </div>
 </div>          	
       
</body>
</html>
