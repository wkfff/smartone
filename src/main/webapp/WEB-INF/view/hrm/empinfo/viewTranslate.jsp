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
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
   
<script type="text/javascript">
     var $dialog ;
     var family_grid ;
     var others_grid ; 
     var $Flag = "F"; 
   
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
              		$Flag = "F";
              	} 
              	if(tabid=="tabitem2"){
              		//已经分组人员  
              		spf_others_initGrid();
              		$Flag = "O";
              	}   
              } 
              }); 
  
          spf_family_initGrid();
     });
      
   //限额休假
     function spf_family_initGrid()
     {
     	$family_grid = $("#familyInfo").ligerGrid({
     		checkbox: false,
     		 columns: [
	            { display: '<spring:message code="hrms.dispatchType"/>', name: 'DIS_TYPE_NAME', width: 80},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', minWidth: 80 },
                { display: '<spring:message code="hrms.position"/>', name: 'POSITION_NAME', minWidth: 80 }, 
                { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_NAME', minWidth: 80 },   
                { display: '<spring:message code="hrms.dispatchOffice"/>', name: 'CONTENTS', minWidth: 80 }, 
                { display: '<spring:message code="hrms.workingDescription"/>', name: 'DIS_TARGET', minWidth: 80 },
                { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', minWidth: 80 },
                { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', minWidth: 80 },
		        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',editor: { type: 'text' }}
           ],  
             enabledEdit: true,usePager: false,rownumbers:true,
             url: "/hrm/empinfo/getDispatchInfoList", 
             parms: [	
                 	{ name: 'ACTIVITY',value: '1'}, 
                 	{ name: 'EMPID',value: ${basicInfo.EMPID }}
                 ],
             pageSize: 5,	    
             pageSizeOptions: [5,4,3,2,1], 
	         heightDiff : 0, 
	         width: '99.5%', height: '99%'
         });
     }
   //限额休假
     function spf_others_initGrid()
     {
     	$others_grid = $("#othersInfo").ligerGrid({
     		checkbox: false,
     		columns: [ 
						{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', minWidth: 80 },
						{ display: '<spring:message code="hrms.position"/>', name: 'POSITION_NAME', minWidth: 80 }, 
						{ display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_NAME', minWidth: 80 },   
		                { display: '<spring:message code="hrms.workingDescription"/>', name: 'WORK_CONTENTS', width: 120 }, 
		                { display: '<spring:message code="hrms.reason"/>', name: 'REASON', width: 120 }, 
			            { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 90},   
			            { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 90},   
     			        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',editor: { type: 'text' }}
     	           ],  
     	     enabledEdit: true,usePager: false,rownumbers:true,
             url: "/hrm/empinfo/getPluralityInfoList", 
             parms: [	
                 	{ name: 'ACTIVITY',value: '1'}, 
                 	{ name: 'EMPID',value: ${basicInfo.EMPID }}
                 ],
             pageSize: 5,	    
             pageSizeOptions: [5,4,3,2,1], 
	         heightDiff : 0, 
	         width: '99.5%', height: '99%'
         });
     }
 
    </script>
</head>
<style type="text/css"> 
     body{ padding:5px; margin:0; padding-bottom:15px;}
     #layout1{  width:99.8%;margin:0; padding:0;  }  
</style>
<body style="padding:2px" >
<div id="layout1" >  
	     <div align="left" position="center" id='' title=' ' >
		  <div align="left">
		     <%@include file="viewBasicInfo.jsp"%>
				<br>
				<table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
						<td width="25%" align="left" style="font-weight: bold;">
							<spring:message code="hrms.dispatchAndPluralismInfo"/>
						</td>	
						<td width="5%" align="right">&nbsp;</td>
						<td align="right"> 
	            		 &nbsp;&nbsp;
						</td>										    
					</tr> 
				</table>  
		        
		       <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8"> 
		          	<tr>  
		          	   <td class="l-table-edit-c" colspan="4"> 
		          	   		<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; "> 
							<div title='<spring:message code="dispatch"/>'>
								<div id="familyInfo"></div>
							</div>
							<div title='<spring:message code="hrms.pluralismInfo"/>'> 
								<div id="othersInfo"></div>
							</div>  
						</div>
		       	   		</td> 
		              </tr> 
		     </table>   
		  </div>
	</div>
</div>
</body>
</html>
