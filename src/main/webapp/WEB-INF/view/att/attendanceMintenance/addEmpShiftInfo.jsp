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
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
	<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
	<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>  
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $dialog ;
	var se_grid ;
	var shift_grid ;
	var shifted_grid ; 
	var $tree ; 
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
                    $("#TYPE_CODE").attr("value", "EMP") ; 
              	} 
              	if(tabid=="tabitem2"){
              		//已经分组人员  
              		spf_delete();
              		spf_shift_initGrid("#shiftInfo_I");
              		spf_shifted_initGrid("#shiftedInfo_I");
                    $("#TYPE_CODE").attr("value", "EMPLOYEE") ;
              	} 
              	if(tabid=="tabitem3"){
              		//未分组人员 
              		spf_delete();
              		spf_shift_initGrid("#shiftInfo_D");
              		spf_shifted_initGrid("#shiftedInfo_D");
                    $("#TYPE_CODE").attr("value", "DEPARTMENT") ;
              	} 
              	//if(tabid=="tabitem4"){
              		//未分组人员 
              		//spf_shift_initGrid("#shiftInfo_S");
              		//spf_shifted_initGrid("#shiftedInfo_S");
                    //$("#TYPE_CODE").attr("value", "SHIFTS") ;
              	//}  
              	if(tabid=="tabitem4"){
              		//未分组人员 
              		spf_delete();
              		spf_shift_initGrid("#shiftInfo_G");
              		spf_shifted_initGrid("#shiftedInfo_G");
                    $("#TYPE_CODE").attr("value", "GROUP") ;
              	}   
              } 
              }); 
          spf_shiftEmp_initGrid();
     });
   //限额休假
     function spf_shiftEmp_initGrid()
     {
     	$se_grid = $("#shiftEmpInfo").ligerGrid({
     		checkbox: false,
             columns: [
                     	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
     		            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 160}, 
     		            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 220},
     		            { display: '<spring:message code="hrms.hireDate"/>', name: 'JOIN_DATE', width: 120},
     		            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 120}
             ],
             usePager: true,
             url: '/att/attendanceMintenance/getSchedulingEmpInfo', 
             width: '99.6%',height:'100%',
             onDblClickRow: function(rowdata, rowindex, rowDomElement){
            	 spf_showDetailData(rowdata.EMPID);
             }
         });
     }
   //限额休假
     function spf_shift_initGrid(id)
     {
     	$shift_grid = $(id).ligerGrid({
     		checkbox: false,
             columns: [
                     	{ display: '<spring:message code="hrms.workingShift.code"/>', name: 'SHIFT_NO',width:120,frozen:true},
     		            { display: '<spring:message code="hrms.workingShift.name"/>', name: 'SHIFT_NAME',width:180,frozen:true},
     		            { display: '<spring:message code="hrms.add"/>', name: '', width: 60,frozen:true, render: function (row, index)
     		                {     
		        	        	return '<img src="/resources/images/add.gif" style="cursor: pointer;" onclick="spf_add('+row.SHIFT_NO+')" >';
     		            	}
     		        	}
             ],
             usePager: false,rownumbers:true,
             url: '/att/attendanceSettings/getShiftInfoList'
         });
     }
   //限额休假
     function spf_shifted_initGrid(id)
     {
     	$shifted_grid = $(id).ligerGrid({
     		checkbox: false,
             columns: [
                    	{ display: '', name: 'PK_NO',width:10,frozen:true,hide:1},
                     	{ display: '<spring:message code="hrms.workingShift.code"/>', name: 'SHIFT_NO',width:120,frozen:true},
     		            { display: '<spring:message code="hrms.workingShift.name"/>', name: 'SHIFT_NAME',width:180,frozen:true},
     		            { display: '<spring:message code="hrms.delete"/>', name: '', width: 60,frozen:true, render: function (row, index)
     		                { 
     		            		return '<img src="/resources/images/delete.gif" style="cursor: pointer;" onclick="spf_del('+row.PK_NO+')" >';
     		            	}
     		        	},
     		            { display: '<spring:message code="up"/>', name: '', width: 60,frozen:true, render: function (row, index)
    		                {
        		            		return '<img src="/resources/images/up.gif" style="cursor: pointer;" onclick="spf_up('+row.PK_NO+','+row.ORDERNO+')" >';   	            		
    		            	}
    		        	},
     		            { display: '<spring:message code="down"/>', name: '', width: 60,frozen:true, render: function (row, index)
	   		                { 
    	   		            		return '<img src="/resources/images/down.gif" style="cursor: pointer;" onclick="spf_down('+row.PK_NO+','+row.ORDERNO+')" >';
	   		            	}
   		        	   }
             ],
             usePager: false,rownumbers:true,
             url: '/att/attendanceMintenance/getShiftedInfoList',
             parms: [	
					{ name: 'FROM_DATE', value: $("#FROM_DATE").val()},
                  	{ name: 'TO_DATE', value: $("#TO_DATE").val()},  
                  	{ name: 'ID', value: $("#ID").val()}
                     ]
         });
     }
     function spf_search()
     {  
     	$se_grid.setOptions({ parms: [	
     								{ name: 'sDate', value: $("#sDate").val()},
     	                        	{ name: 'eDate', value: $("#eDate").val()},  
     	                        	{ name: 'keyWord', value: $("#keyWord").val()},   
     	                        	{ name: 'DEPTID', value: $("#DEPTID").val()}
     	                           ],
     	                   newPage: 1
     	                 });  //设置数据参数
         $se_grid.loadData(true); //加载数据 
     }
   //限额休假
     function spf_showDetailData(empID)
     { 
     	$dialog = $.ligerDialog.open({isDrag: false, 
     		title:'<spring:message code="hrms.detail"/>', 
     		width: 800, 
     		height: 400, 
     		url: '/att/attendanceMintenance/viewEmpShiftDetailInfo?EMPID=' + empID
        	  });
     }
     function showGroupEmpInfo(type){ 
    	 $dialog = $.ligerDialog.open({isDrag: false,
     		 title:'<spring:message code="employee.information"/>',
        		 width: 800, height: 400, 
        		 url: '/att/attendanceMintenance/viewGroupEmpInfo?GROUP_NO='+$("#GROUP_NO").val()
        	  }); 
     }
     function searchEmp(type){ 
         if(type == "DEPARTMENT"){
         	 $dialog = $.ligerDialog.open({isDrag: false,
         		     title:'<spring:message code="employee.information"/>',
            		 width: 800, height: 400, 
            		 url: '/utility/empInfo/viewAttSearchEmployee?DEPTID='+$("#DEPTID_D").val()
            	  }); 
         }else{
         	 $dialog = $.ligerDialog.open({isDrag: false,
         		     title:'<spring:message code="employee.information"/>',
            		 width: 800, height: 400, 
            		 url: '/utility/empInfo/viewHrSearchEmployee'
            	  }); 
         }
     }

 	function spf_initSelectEmpInfo(data){ 
 		if($("#TYPE_CODE").val() == "EMPLOYEE"){
 	         $("#empID").attr("value", data.EMPID+","+data.CHINESENAME) ;
 	         $("#EMPID").attr("value", data.EMPID) ;  
 		}if($("#TYPE_CODE").val() == "EMP"){
 	         $("#key").attr("value", data.EMPID+","+data.CHINESENAME) ;
 	         $("#keyWord").attr("value", data.EMPID) ;
 		}
         $dialog.close() ;
     }
 	
 	 function spf_save() { 
	 		    var rows = $shifted_grid.getData(); 
	 		    if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
	 		   var shiftNo = '' ;
	 		   $(rows).each(function(index, row){
	 	           
	 		             shiftNo += this.SHIFT_NO + ','; 
	 	        });
 		      
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post("/att/attendanceMintenance/addEmpShift", 
                     [	
                      	{ name: 'SHIFT_NO', value: shiftNo},
    					{ name: 'FROM_DATE', value: $("#FROM_DATE").val()},
                      	{ name: 'TO_DATE', value: $("#TO_DATE").val()},  
                      	{ name: 'ID', value: $("#EMPID").val()},  
                      	{ name: 'TYPE', value: $("#TYPE_CODE").val()}
                      ]
             , function (result)
             {
             	$.ligerDialog.closeWaitting();
                 if (result == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                     	$se_grid.loadData(true);
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
	       $.post("/att/attendanceMintenance/deleteShiftedInfo" 
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               	$shifted_grid.loadData(true); //加载数据
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	           }
	       });  
	}  
 	function spf_add(shiftNo)
	{ 
 	   if(spf_checkData($("#TYPE_CODE").val())){ 
			 
	       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/att/attendanceMintenance/addShiftedInfo", 
	               [	
	                	{ name: 'SHIFT_NO', value: shiftNo },
	                	{ name: 'FROM_DATE', value: $("#FROM_DATE").val() },
	                	{ name: 'TO_DATE', value: $("#TO_DATE").val() },
	                	{ name: 'ID', value: $("#EMPID").val() }
	               ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               	$shifted_grid.loadData(true); //加载数据
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	           }
	       }); 
 	   }
	}
   
	function spf_del(pkNo)
	{   
	       $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
	       $.post("/att/attendanceMintenance/deleteShiftedInfo", 
	               [	
	                	{ name: 'PK_NO', value: pkNo }
	               ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               	$shifted_grid.loadData(true); //加载数据
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	           }
	       });  
	} 
   
	function spf_up(pkNo,no)
	{
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/att/attendanceMintenance/upShiftedInfo", 
	               [	
                	{ name: 'PK_NO', value: pkNo },
                	{ name: 'ORDERNO', value: no }
	               ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               	$shifted_grid.loadData(true); //加载数据
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	           }
	       }); 	 
	} 
   
	function spf_down(pkNo,no)
	{
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/att/attendanceMintenance/downShiftedInfo", 
	               [	
                	{ name: 'PK_NO', value: pkNo },
                	{ name: 'ORDERNO', value: no }
	               ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               	$shifted_grid.loadData(true); //加载数据
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	           }
	       }); 	 
	}
	function spf_checkData(type)
    {    
		var fromDate = "";
		var toDate = "";
		var empID = "";
   		if(type == "EMPLOYEE"){ 
   			fromDate = $("#FROM_DATE_I").val();
   			toDate = $("#TO_DATE_I").val();
   			empID = $("#EMPID").val(); 
   	        if (fromDate == null || fromDate == "") { 
	   	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
	   	       	 return false; 
   	        }else{
                $("#FROM_DATE").attr("value",fromDate) ; 
   	        }  
   	        if (toDate == null || toDate == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
      	       	 return false; 
      	    }else{
                $("#TO_DATE").attr("value",toDate) ;
   	        }  
   	        if (empID == null || empID == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.empid"/>') ; 
      	       	 return false; 
      	    } else{
                $("#EMPID").attr("value",empID) ;
   	        } 
   		}
   		if(type == "DEPARTMENT"){ 
   			fromDate = $("#FROM_DATE_D").val();
   			toDate = $("#TO_DATE_D").val();
   			empID = $("#DEPTID_D").val();
   	        if (fromDate == null || fromDate == "") { 
	   	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
	   	       	 return false; 
   	        }else{
                $("#FROM_DATE").attr("value",fromDate) ;
   	        }  
   	        if (toDate == null || toDate == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
      	       	 return false; 
      	    }else{
                $("#TO_DATE").attr("value",toDate) ;
   	        }  
   	        if (empID == null || empID == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dept"/>') ; 
      	       	 return false; 
      	    } else{
                $("#EMPID").attr("value",empID) ;
   	        } 
   		}
   		if(type == "GROUP"){ 
   			fromDate = $("#FROM_DATE_G").val();
   			toDate = $("#TO_DATE_G").val();
   			empID = $("#GROUP_NO").val();
   	        if (fromDate == null || fromDate == "") { 
	   	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
	   	       	 return false; 
   	        }else{
                $("#FROM_DATE").attr("value",fromDate) ;
   	        }  
   	        if (toDate == null || toDate == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
      	       	 return false; 
      	    }else{
                $("#TO_DATE").attr("value",toDate) ;
   	        }  
   	        if (empID == null || empID == "") { 
      	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dept"/>') ; 
      	       	 return false; 
      	    } else{
                $("#EMPID").attr("value",empID) ;
   	        } 
   		}
   		return true;
        
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
		     <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
		                <tr> 
			                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
			                <td width="30%" class="l-table-edit-c">
			                <input type="hidden" name="TYPE_CODE" id="TYPE_CODE" value="EMPLOYEE"/>
			                <input type="hidden" name="FROM_DATE" id="FROM_DATE" value=""/>
			                <input type="hidden" name="TO_DATE" id="TO_DATE" value=""/>
			                <input type="hidden" name="ID" id="ID" value=""/> 
			                 
			           			<input type="text" name="sDate" id="sDate" 
				                	 value="" size="30"
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 validate="{required:true}" readonly="readonly"/>  
			                </td>
			               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
			           	   <td class="l-table-edit-c">
				       	   		<input type="text" name="key" id="key" size="30" onclick="searchEmp('EMP')"/>
				       	   		<input type="hidden" name="keyWord" id="keyWord"/> 
				       	   </td>
		                </tr>
		                <tr>
			                <td class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
			                <td class="l-table-edit-c">
			           			<input type="text" name="eDate" id="eDate" 
				                	 value="" size="30"
				                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
				                	 validate="{required:true}" readonly="readonly"/>   
			                </td>  
			               <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
			           	   <td class="l-table-edit-c">
								<SipingSoft:deptTree name="DEPTID" limit="ar"/> 
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
		       <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8"> 
		          	<tr>  
		          	   <td class="l-table-edit-c" colspan="4"> 
		          	   		<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; "> 
							<div title='<spring:message code="hrms.workingShift.information"/>'>
								<div id="shiftEmpInfo"></div>
							</div>
							<div title='<spring:message code="hrms.individualScheduling"/>'> 
								<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="FROM_DATE_I" id="FROM_DATE_I" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}" readonly="readonly"/>  
						                </td> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="TO_DATE_I" id="TO_DATE_I" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}"  readonly="readonly"/>   
						                </td> 
					                </tr>
					                <tr>   
						               <td class="l-table-edit-t">
						               		<spring:message code="hrms.empid"/>
						               </td>
						           	   <td class="l-table-edit-c" colspan="3"> 
							       	   		<input type="text" name="empID" id="empID" size="30" 
							       	   		onclick="searchEmp('EMPLOYEE')"/>
							       	   		<input type="hidden" name="EMPID" id="EMPID"/> 
							       	   </td> 
						           </tr> 
						       </table> 
         				 		<br>
					           <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.workingShift.information"/></td>
						           	   <td width="45%" class="l-table-edit-c">   
      										<div position="top" id='shiftInfo_I' ></div> 
							       	   </td>  
							           <td width="45%" class="l-table-edit-c"> 
									        <div position="top" id='shiftedInfo_I'></div> 
							       	   </td> 
						           </tr>   
						       </table> 
						       <table cellpadding="0" cellspacing="0" class="l-table-edit" >  
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						       </table>  
							</div> 
							<div title='<spring:message code="hrms.deptScheduling"/>'> 
								<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="FROM_DATE_D" id="FROM_DATE_D" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}" readonly="readonly"/>  
						                </td> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="TO_DATE_D" id="TO_DATE_D" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}" readonly="readonly"/>   
						                </td> 
					                </tr>
					                <tr>   
						               <td class="l-table-edit-t">
						               		<spring:message code="hrms.dept"/>
						               </td>
						           	   <td class="l-table-edit-c" colspan="2">  
											<SipingSoft:deptTree name="DEPTID_D" limit="hr"/> 
									        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<span onClick="searchEmp('DEPARTMENT');" style="cursor: pointer;font-weight:bold;"> <!--  班次-->
											<spring:message code="employee.information"/>
											</span>
							       	   </td> 
						           </tr> 
						       </table> 
         				 		<br>
					           <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.workingShift.information"/></td>
						           	   <td width="45%" class="l-table-edit-c">   
      										<div position="top" id='shiftInfo_D' ></div> 
							       	   </td>  
							           <td width="45%" class="l-table-edit-c"> 
									        <div position="top" id='shiftedInfo_D'></div> 
							       	   </td> 
						           </tr>   
						       </table> 
						       <table cellpadding="0" cellspacing="0" class="l-table-edit" >  
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						       </table>  
							</div>  
							<div title='<spring:message code="hrms.attGroupScheduling"/>'> 
								<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="FROM_DATE_G" id="FROM_DATE_G" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}" readonly="readonly"/>  
						                </td> 
						                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.endDate"/></td>
						                <td width="40%" class="l-table-edit-c">
						           			<input type="text" name="TO_DATE_G" id="TO_DATE_G" 
							                	 value="" size="30"
							                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
							                	 validate="{required:true}" readonly="readonly"/>   
						                </td> 
					                </tr>
					                <tr>   
						               <td class="l-table-edit-t">
						               		<spring:message code="hrms.workingShift.group"/>
						               </td>
						           	   <td class="l-table-edit-c" colspan="3"> 
							       	   		<SipingSoft:select name="GROUP_NO" dataListName="dynamicGroupList"/>
							       	   		 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
											<span onClick="showGroupEmpInfo('DSHIFTS');" style="cursor: pointer;font-weight:bold;"> <!--  班次-->
											<spring:message code="employee.information"/>
											</span>
							       	   </td> 
						           </tr> 
						       </table> 
         				 		<br>
					           <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
					               <tr> 
						               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.workingShift.information"/></td>
						           	   <td width="45%" class="l-table-edit-c">   
      										<div position="top" id='shiftInfo_G' ></div> 
							       	   </td>  
							           <td width="45%" class="l-table-edit-c"> 
									        <div position="top" id='shiftedInfo_G'></div> 
							       	   </td> 
						           </tr>   
						       </table> 
						       <table cellpadding="0" cellspacing="0" class="l-table-edit" >  
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						           <tr><td colspan="4">&nbsp;&nbsp;</td></tr> 
						       </table>  
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
