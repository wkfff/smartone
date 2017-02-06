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
    	$grid = $("#itemInfo").ligerGrid({
    		checkbox: false,
            columns: [
			{ display: '', name: 'ITEM_ID', width: 10,hide: 1}, 
            { display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME', width: 140},
            { display: '<spring:message code="hrms.attItemShortName"/>', name: 'SHORT_NAME', width: 140},
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',align: 'left',width: 320},
            { display: '<spring:message code="hrms.attItemGroup"/>', name: 'ITEM_GROUP_NAME', width: 120},
            { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width: 120},
            { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY', width: 120, render: function (row, index)
                {
            		return '<img src="/resources/images/a_' + row.ACTIVITY + '.gif">';
            	}
        	}
            ],
            usePager: true,rownumbers: true,
            url: '/att/attendanceSettings/getItemInfo',
            width: '99.6%', height: '100%',
            heightDiff : 0
        });
    }

    function spf_search()
    {     
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'ITEM_NAME', value: $("#ITEM_NAME").val()},
    								{ name: 'ITEM_GROUP_CODE', value: $("#ITEM_GROUP_CODE").val()}
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
		        $.post("/att/attendanceSettings/deleteItemInfo", 
		                [	
		                 	{ name: 'ITEM_ID', value: rows.ITEM_ID }
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

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    	$dialog.close() ;
    }

    function spf_add()
    {
    	$dialog = $.ligerDialog.open({isDrag: false, 
   		    title:'<spring:message code="hrms.add"/>', 
    		width: 1100, height: 350, 
    		url: '/att/attendanceSettings/addItemInfo'
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
    		width: 1100, height: 350, 
    		url: '/att/attendanceSettings/updateItemInfo?ITEM_ID=' + rows.ITEM_ID
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
	   		<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr>
	               <td class="l-table-edit-t"><spring:message code="hrms.attItemName"/></td>
	           	   <td class="l-table-edit-c">
	           	   		<input type="text"  name="ITEM_NAME" id="ITEM_NAME" />
		       	   </td> 
	               <td class="l-table-edit-t"><spring:message code="hrms.attItemGroup"/></td>
	           	  <td class="l-table-edit-c">
                	    <SipingSoft:selectSyCode parentCode="ATTItemGroup" name="ITEM_GROUP_CODE" limit="all" onChange="spf_search();"/> 
                  </td>
	           </tr>  
	       </table>  
	       
	       
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
	                    <SipingSoft:button/>     
					</td>
	           </tr>  
       		</table> 
	  </div>
      <div position="center" id='itemInfo'></div>
     
	  </div>       	
</div>       
</body>
</html>
