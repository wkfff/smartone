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
            topHeight: 60, 
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        
         f_initGrid();
    });

    function f_initGrid()
    {
    	$grid = $("#gridInfo").ligerGrid({
    		checkbox: false,
            columns: [
	            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
	            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME'},
	            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME'},
	            { display: '<spring:message code="hrms.year"/>', name: 'VAC_ID'},
	            { display: '<spring:message code="hrms.leaveType"/>', name: 'VAC_TP_NAME'},
	            { display: '<spring:message code="hrms.hireDate"/>', name: 'JOIN_DATE'},
	            { display: '<spring:message code="hrms.startDate"/>', name: 'STRT_DATE', editor: { type: 'date' }},
	            { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', editor: { type: 'date' }},
	            { display: '<spring:message code="hrms.leaveLength"/>', name: 'TOT_VAC_CNT', editor: { type: 'float' }},
	            { display: '<spring:message code="hrms.deductionHours"/>', name: 'DEL_VAC_CNT', editor: { type: 'float' }}
            ],
            usePager: true, enabledEdit: true,rownumbers:true,
            url: '/att/attendanceMintenance/getAttAnnualLeaveInfoList',
			parms: [{ name: 'VAC_ID', value: $("#VAC_ID").attr('value')}],
            width: '99.6%', height: '100%'
        });
    }

    function spf_search()
    {   
    	$grid.setOptions({  
        					parms: [	
    	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')},
                                    { name: 'DEPTID', value: $("#DEPTID").attr('value')},
                                    { name: 'VAC_TP', value: $("#VAC_TP").attr('value')},
    	                        	{ name: 'VAC_ID', value: $("#VAC_ID").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    
    function spf_save(){ 
        
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/att/attendanceMintenance/updateAttAnnualLeaveInfo", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)}
                 ]
        , function (result)
        {
       
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$grid.loadData(true);
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
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
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>') ; return ;
		         }
		         
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/att/attendanceMintenance/deleteAttAnnualLeaveInfo", 
		                [	
		                 	{ name: 'VACATION_NO', value: rows.VACATION_NO }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y"){
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function ()
		                {
		                	$grid.loadData(true); //加载数据
		                });
		            }
		            else{
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
    		width: 950, height: 500, 
    		url: '/att/attendanceMintenance/addAttAnnualLeaveInfo'
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
	<div position="top">
	  	<table width="100%" border="0" >
	        <tr><td height="2"></td></tr>
            <tr>
                <td align="center" valign="middle"> 
	       			<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
		                <tr>
			               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
			           	   <td class="l-table-edit-c">
				       	   		<input type="text" name="keyWord" id="keyWord" />
				       	   </td>
			               <td class="l-table-edit-t"><spring:message code="hrms.leaveType"/></td>
			           	   <td class="l-table-edit-c">
                				<SipingSoft:selectSyCode parentCode="VacationType" name="VAC_TP" limit="all" onChange="spf_search()"/>
				       	   </td> 
			               <td class="l-table-edit-t"><spring:message code="hrms.year"/></td>
			           	   <td class="l-table-edit-c">
								<SipingSoft:date yearName="VAC_ID" onChange="spf_search();"/>
				       	   </td> 
			               <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
			           	   <td class="l-table-edit-c">
								<SipingSoft:deptTree name="DEPTID" limit="ar"/> 
				       	   </td>
			           </tr> 
			       </table>
       			</td>
	      	</tr>
	    </table>
			       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px"> 
			           <tr>
			                <td align="left">
	                    		<SipingSoft:button/>  	 		  
							</td>
			           </tr>  
		       		</table>  
	  </div>
      			<div position="center" id='gridInfo'></div> 
        	</div>  
</body>
</html>
