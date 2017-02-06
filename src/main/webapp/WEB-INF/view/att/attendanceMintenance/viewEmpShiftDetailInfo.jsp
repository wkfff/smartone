<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> 
<title></title> 
 	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
 	
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
     
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
	<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
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
	        f_initGrid();
	    });
function f_initGrid(){
	$grid =$("#empInfo").ligerGrid({						               
	           columns: [
	           	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:120 },
	           	{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:120},
				{ display: '<spring:message code="hrms.workingShift.date"/>', name: 'AR_DATE_STR',width:150},
	           	{ display: '<spring:message code="hrms.workingShift"/>', name: 'SHIFT_NAME',width:220}
	           ], 
	           usePager: true,
	           url: "/att/attendanceMintenance/getEmpShiftDetailInfo?EMPID=${paraMap.EMPID}", 
	           pageSize: 9, pageSizeOptions:[9,15, 20, 30, 40, 50],                    
	           width: '99.6%', height: '100%'		
	       });	 
}
function spf_search(){
	$grid.setOptions({parms: [
								{ name: 'sDate', value: $("#sDate").val()},
 	                        	{ name: 'eDate', value: $("#eDate").val()} 
   	            ],
   	    newPage: 1
   	 });
	$grid.loadData(true);
} 

</script>
<style type="text/css"> 
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{  width:99.8%;margin:0; padding:0;  }  
</style>
</head>	
<body style="padding:2px" > 
	<div id="layout1" > 
     <div style="border:1px solid #A3C0E8;" >
	  <div align="left">
	  	 <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr> 
	               <td class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
	           	   <td class="l-table-edit-c">
		       	   		<input type="text" name="sDate" id="sDate" 
				                	 value="" size="30"
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 readonly="readonly"/>  
		       	   </td>
	                <td class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
	                <td class="l-table-edit-c" colspan="3">
	                	<input type="text" name="eDate" id="eDate" 
				                	 value="" size="30"
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 readonly="readonly"/>  
	                </td> 
                </tr> 
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	              <td align="left" height="30px">
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>   
	               </td>
	           </tr> 
	       </table>
	  </div>
      <div id='empInfo' ></div>
     </div>  
     </div>  
</body>
</html>
