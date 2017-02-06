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
    <script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>  
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
var $dg_grid ;  
var $emp_grid ;  
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
             	spf_dg_initGrid();
         	} 
         	if(tabid=="tabitem2"){
         		//未分组人员
			   spf_emp_initGrid();
         	}  
         } 
         });
     spf_dg_initGrid();

});

//限额休假
function spf_dg_initGrid()
{
	$dg_grid = $("#dgEmpInfo").ligerGrid({
		checkbox: true,
        columns: [
                	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
		            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 160}, 
		            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 220},
		            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 120}
        ],
        usePager: true,
        url: '/att/attendanceSettings/getDynamicGroupEmpInfo', 
		parms: [{ name: 'GROUP_NO', value: $("#GROUP_NO").attr('value')},
		        { name: 'keyWord', value: $("#keyWord").attr('value')},
            	{ name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},  
        		{ name: 'DEPTID', value: $("#DEPTID").attr('value')}
        	],
        width: '99%',height:'98%'
    });
}
//休假明细
function spf_emp_initGrid()
{
	$emp_grid = $("#empInfo").ligerGrid({
		checkbox: true,
        columns: [
              	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
	            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 160}, 
	            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 220},
	            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 120}
        ],
        usePager: true,
        url: '/att/attendanceSettings/getNonDynamicGroupEmpInfo', 
		parms: [{ name: 'GROUP_NO', value: $("#GROUP_NO").attr('value')},
		        { name: 'keyWord', value: $("#keyWord").attr('value')},
            	{ name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},  
        		{ name: 'DEPTID', value: $("#DEPTID").attr('value')}
        	],
        width: '99%',height:'98%'
    });
}

function spf_search()
{  
	$emp_grid.setOptions({ parms: [	
								{ name: 'GROUP_NO', value: $("#GROUP_NO").attr('value')},
	                        	{ name: 'keyWord', value: $("#keyWord").val()},   
	                        	{ name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},  
	                        	{ name: 'DEPTID', value: $("#DEPTID").val()}
	                           ],
	                   newPage: 1
	                 });  //设置数据参数
    $emp_grid.loadData(true); //加载数据
	$dg_grid.setOptions({ parms: [	
									{ name: 'GROUP_NO', value: $("#GROUP_NO").attr('value')},
		                        	{ name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},   
		                        	{ name: 'keyWord', value: $("#keyWord").val()},   
		                        	{ name: 'DEPTID', value: $("#DEPTID").val()}
		                           ],
		                   newPage: 1
		                 });  //设置数据参数
    $dg_grid.loadData(true); //加载数据
}

function spf_delete()
{   
	var jsonData = '[' ;
	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
    {
        if(yes){
          
	    	 var rows = $dg_grid.getCheckedRows(); 
	
	         if (!rows || rows.length == 0) { 
	        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	        	 return ; 
	        }
	        $(rows).each(function ()
	                 {
	 		        	if (jsonData.length > 1){
	 		             	jsonData += ',{'
	 		             }
	 		             else{
	 		             	jsonData += '{'
	 		             }
	                      jsonData += ' "GROUP_NO": "' + $("#GROUP_NO").val() + '", ' ;
	                         jsonData += ' "EMPID": "' + this.EMPID + '" ' ;
	                         jsonData += '}' ;
	                      
	                 }); 
	 		jsonData += ']' ;
	        
	        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
	        $.post("/att/attendanceSettings/deleteDynamicGroupEmpInfo", 
	                [	
	                 	{ name: 'jsonData', value: jsonData }
	                ]
	        , function (result)
	        {
	        	$.ligerDialog.closeWaitting();
	            if (result == "Y")
	            {
	                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	                {
	                	$dg_grid.loadData(true); //加载数据
	               		parent.f_ChildWindowClose();
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

function spf_save()
{   
	var jsonData = '[' ;
	var rows = $emp_grid.getCheckedRows(); 
	
    if (!rows || rows.length == 0) { 
   	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
   	 return ; 
   }
   $(rows).each(function ()
            {
	        	if (jsonData.length > 1){
	             	jsonData += ',{'
	             }
	             else{
	             	jsonData += '{'
	             }
                 jsonData += ' "GROUP_NO": "' + $("#GROUP_NO").val() + '", ' ;
                    jsonData += ' "EMPID": "' + this.EMPID + '" ' ;
                    jsonData += '}' ;
                 
            }); 
	jsonData += ']' ;
   
   $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
   $.post("/att/attendanceSettings/addDynamicGroupEmpInfo", 
           [	
            	{ name: 'jsonData', value: jsonData }
           ]
   , function (result)
   {
   	$.ligerDialog.closeWaitting();
       if (result == "Y")
       {
           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
           {
              	$emp_grid.loadData(true); //加载数据
           		$dg_grid.loadData(true); //加载数据
           		parent.f_ChildWindowClose();
           });
       }
       else
       {
           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
       }
   });
}
 	
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  } 
    </style>
</head>
<body style="padding:0px" > 
<div id = 'layout1'  >  
	  <div align="left">
      	 <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr> 
	               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
	           	   <td class="l-table-edit-c">
		       	   		<input type="text" name="keyWord" id="keyWord" />
       					<input type="hidden" id="jsonData" name="jsonData" value=""/>
		       	   		<input type="hidden" name="GROUP_NO" id="GROUP_NO" value="${DynamicGroup.GROUP_NO }"/>
		       	   </td>  
	                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
	                <td class="l-table-edit-c">
	                	<SipingSoft:deptTree name="DEPTID" limit="hr" onChange="spf_search();"/>
	                </td>  
	                <td class="l-table-edit-t"><spring:message code="hrms.EmpStatus"/></td>
	                <td class="l-table-edit-c">
	                	<SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE" limit="all" onChange="spf_search();"/>
	                </td> 
                </tr> 
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	              <td align="left" height="30px">
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>     
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>  
	               </td>
	           </tr> 
	       </table> 
	 <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8"> 
          <tr>  
          	   <td class="l-table-edit-c" colspan="4"> 
          	   		<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; "> 
					<div title='<spring:message code="hrms.groupMember"/>'>
						<div id="dgEmpInfo"></div>
					</div>
					<div title='<spring:message code="employee.information"/>'>
						<div id="empInfo"></div>
					</div>
				</div>
       	   		</td> 
              </tr> 
     </table>   
 </div> 
 </div> 
</body>
</html>
