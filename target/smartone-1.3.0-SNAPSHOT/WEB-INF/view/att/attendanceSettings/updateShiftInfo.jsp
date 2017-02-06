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
	     
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	
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
    	$grid = $("#shiftParameterInfo").ligerGrid({
            columns: [
            { display: '<spring:message code="hrms.attItemName"/>', name: 'PK_NO',hide:1},
            { display: '<spring:message code="hrms.attItemName"/>', name: 'SHIFT_NO',hide:1},
            { display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME',width:120},
            { display: '<spring:message code="hrms.startDate"/>', name: 'BEGIN_DAY_OFFSET_NAME',width:120},
            { display: '<spring:message code="hrms.startedTime"/>', name: 'FROM_TIME',width:120},
            { display: '<spring:message code="hrms.endDate"/>', name: 'END_DAY_OFFSET_NAME',width:120},
            { display: '<spring:message code="hrms.endTime"/>', name: 'TO_TIME',width:120}
            ],
            enabledEdit: false, usePager: false,rownumbers: true,
            url: '/att/attendanceSettings/getShiftParameterInfo?SHIFT_NO=${shiftInfo.SHIFT_NO}',  
            width: '100%', height: '100%',
            heightDiff : 0
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
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/att/attendanceSettings/deleteShiftParameterInfo", 
		                [	
		                 	{ name: 'PK_NO', value: rows.PK_NO },
		                 	{ name: 'SHIFT_NO', value: rows.SHIFT_NO }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',function ()
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
    		width: 800, 
    		height: 350, 
    		url: '/att/attendanceSettings/updateShiftParameterInfo?PK_NO='+rows.PK_NO+'&SHIFT_NO='+rows.SHIFT_NO
       	  });
    } 

    function spf_add()
    {  
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.add"/>', 
    		width: 800, 
    		height: 350, 
    		url: '/att/attendanceSettings/addShiftParameterInfo?SHIFT_NO=${shiftInfo.SHIFT_NO}'
       	  });
    } 
    function f_ChildWindowClose (){ 
    	$grid.loadData(true); //加载数据 
    	$dialog.close() ;
    }
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:0px" >  
      <div id="layout1" >
	     <div align="left" position="center" id='' title='<spring:message code="hrms.workingShift.information"/>' >
		  <div align="left"> 
			       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
			           <tr>
			                <td align="left"> 
			            		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_add()"><spring:message code="hrms.add"/></a>   
			               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_update()"><spring:message code="hrms.update"/></a>   
	               		        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_delete()"><spring:message code="hrms.delete"/></a> 
							</td>
			           </tr>  
		       		</table>   
            	<div id=shiftParameterInfo ></div>
        	</div> 
       </div>
       </div>
</body>
</html>
