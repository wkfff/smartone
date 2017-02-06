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
    <script src="/resources/js/json2.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>  
<script type="text/javascript">
     var $dialog ;
     var family_grid ;
     var others_grid ; 
     var $Flag = "F";
     var $relationalTypeSelectList ; 
     var $otherRelationlTypeSelectList ; 
     var $eduHisSelectList ; 
     var $yesOrNoSelectList ; 
   
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

          $relationalTypeSelectList = getRelationalTypeSelectList() ;
          $otherRelationlTypeSelectList = getOtherRelationlTypeSelectList() ;
          $eduHisSelectList = getEduHisTypeSelectList() ;
          $yesOrNoSelectList = getYesOrNoSelectList() ;
           
          spf_family_initGrid();
     });
     function getRelationalTypeSelectList(){
     	//请求服务器
     	var relationalTypeSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getRelationalTypeSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
            	 relationalTypeSelectList = list ;
             }
         });   
         return relationalTypeSelectList ;
     }
     
     function getOtherRelationlTypeSelectList(){
     	//请求服务器
     	var otherRelationlTypeSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getOtherRelationlTypeSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
            	 otherRelationlTypeSelectList = list ; 
             }
         });

         return otherRelationlTypeSelectList ;
     } 
     function getEduHisTypeSelectList(){
      	//请求服务器
      	var eduHisSelectList ;
          $.ajax({
              type: 'post',
              url: '/utility/otherInfo/getEduHisTypeSelectList', 
              dataType: 'json',
              async: false,
              success: function (list)
              {  
            	  eduHisSelectList = list ; 
              }
          });

          return eduHisSelectList ;
      } 
     function getYesOrNoSelectList(){
       	//请求服务器
       	var yesOrNoSelectList ;
           $.ajax({
               type: 'post',
               url: '/utility/otherInfo/getYesOrNoSelectList', 
               dataType: 'json',
               async: false,
               success: function (list)
               {  
            	   yesOrNoSelectList = list ; 
               }
           });

           return yesOrNoSelectList ;
       } 
   //限额休假
     function spf_family_initGrid()
     {
     	$family_grid = $("#familyInfo").ligerGrid({
     		checkbox: false,
     		 columns: [
     	        { display: '', name: 'FAMILY_NO',width: 10,hide:1},  
                { display: '<spring:message code="hrms.relationship"/>', name: 'FAM_TYPE_CODE', width: 130,align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $relationalTypeSelectList, dataValueField: 'FAM_TYPE_CODE',dataDisplayField: 'FAM_TYPE_NAME', 
                    	displayColumnName: 'FAM_TYPE_NAME', valueColumnName: 'FAM_TYPE_CODE'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $relationalTypeSelectList.length; i++)
                        {
                            if ($relationalTypeSelectList[i]['FAM_TYPE_CODE'] == item.FAM_TYPE_CODE)
                                return $relationalTypeSelectList[i]['FAM_TYPE_NAME']
                        }
                        return item.FAM_TYPE_NAME;
                    }
		        },  
                { display: '<spring:message code="hrms.name"/>', name: 'FAM_NAME',width: 90,editor:{type : 'text'}},
                { display: '<spring:message code="hrms.IDnumber"/>', name: 'FAM_IDCARD',width: 140,editor:{type : 'text'}},  
                { display: '<spring:message code="hrms.eduHis"/>', name: 'EDU_HIS_CODE',width: 130, align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $eduHisSelectList, dataValueField: 'EDU_HIS_CODE',dataDisplayField: 'EDU_HIS_NAME', 
                    	displayColumnName: 'EDU_HIS_NAME', valueColumnName: 'EDU_HIS_CODE'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $eduHisSelectList.length; i++)
                        {
                            if ($eduHisSelectList[i]['EDU_HIS_CODE'] == item.EDU_HIS_CODE)
                                return $eduHisSelectList[i]['EDU_HIS_NAME']
                        }
                        return item.EDU_HIS_NAME;
                    }
		        },  
                { display: '<spring:message code="hrms.phone"/>', name: 'FAM_PHONE',width: 130,editor:{type : 'text'}}, 
                { display: '<spring:message code="hrms.workUnit"/>', name: 'FAM_COMPANY_NAME',width: 130,editor:{type : 'text'}}, 
                { display: '<spring:message code="hrms.position"/>', name: 'FAM_POSITION',editor:{type : 'text'}}, 
                { display: '<spring:message code="hrms.livingTogether"/>', name: 'YN_ID',width: 130, align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $yesOrNoSelectList, dataValueField: 'YN_ID',dataDisplayField: 'YN_NAME', 
                    	displayColumnName: 'YN_NAME', valueColumnName: 'YN_ID'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $yesOrNoSelectList.length; i++)
                        {
                            if ($yesOrNoSelectList[i]['YN_ID'] == item.YN_ID)
                                return $yesOrNoSelectList[i]['YN_NAME']
                        }
                        return item.YN_NAME;
                    }
		        } ,
		        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', type: 'textarea',width: 120,
		        	editor:{type : 'text'}
	            } 
           ],  
             enabledEdit: true,usePager: false,rownumbers:true,
             url: "/hrm/empinfo/getFamilyInfoList?EMPID=${basicInfo.EMPID }&FAM_TYPE_CODE=RelationalTypeCode", 
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
     	     	      { display: '', name: 'FAMILY_NO',width: 10,hide:1},
     	     	      { display: '<spring:message code="hrms.relationship"/>', name: 'FAM_TYPE_CODE',width: 130, align: 'center',isSort: false,
     	                    editor: { 
     	                    	type: 'select', data: $otherRelationlTypeSelectList, dataValueField: 'FAM_TYPE_CODE',dataDisplayField: 'FAM_TYPE_NAME', 
     	                    	displayColumnName: 'FAM_TYPE_NAME', valueColumnName: 'FAM_TYPE_CODE'
     	                    }, render: function (item)
     	                    {
     	                        for (var i = 0; i < $otherRelationlTypeSelectList.length; i++)
     	                        {
     	                            if ($otherRelationlTypeSelectList[i]['FAM_TYPE_CODE'] == item.FAM_TYPE_CODE)
     	                                return $otherRelationlTypeSelectList[i]['FAM_TYPE_NAME']
     	                        }
     	                        return item.FAM_TYPE_NAME;
     	                    }
     			        },  
     	                { display: '<spring:message code="hrms.name"/>', name: 'FAM_NAME',editor:{type : 'text'}},
     	                { display: '<spring:message code="hrms.phone"/>', name: 'FAM_PHONE',editor:{type : 'text'}}, 
     			        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', type: 'textarea',width: 120,
     	                	editor:{type : 'text'}
     		            }  
     	           ],  
     	     enabledEdit: true,usePager: false,rownumbers:true,
             url: "/hrm/empinfo/getEmergencyContactInfoList?EMPID=${basicInfo.EMPID }&FAM_TYPE_CODE=OtherRelation", 
             pageSize: 5,	    
             pageSizeOptions: [5,4,3,2,1], 
	         heightDiff : 0, 
	         width: '99.5%', height: '99%'
         });
     }

     function spf_add()
     {
    	if($Flag == "F"){
         	$family_grid.addRow();
    	}
    	if($Flag == "O"){
         	$others_grid.addRow();
    	}
     }
     function spf_delete()
     {     
    	 var FAMILY_NO = "";
     	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
         {
         	if(yes){
 		     	 var rows = null; 
 		     	if($Flag == "F"){ 
 		         	rows = $family_grid.getSelectedRow(); 
 		    	}
 		    	if($Flag == "O"){
 		         	rows = $others_grid.getSelectedRow();  
 		    	}
 		         if (!rows || rows.length == 0) { 
 		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
 		        	 return ; 
 		        }
 		         if (rows.length > 1){
 		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
 		         }
 		         if(rows.FAMILY_NO == 'undefined'){
 		        	FAMILY_NO = "";
 		         }else{
 		        	FAMILY_NO = rows.FAMILY_NO;
 		         }
 		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
 		        $.post("/hrm/empinfo/deleteFamilyInfo", 
 		                [	
 		                 	{ name: 'FAMILY_NO', value: FAMILY_NO },
 		                 	{ name: 'EMPID', value: "${basicInfo.EMPID}"}
 		                ]
 		        , function (result)
 		        {
 		        	$.ligerDialog.closeWaitting();
 		            if (result == "Y")
 		            { 
 		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
 		                {
 		                	$family_grid.loadData(true); //加载数据  
 		                	$others_grid.loadData(true); //加载数据  
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
 	 function spf_save() { 
 		       var data = null; 
 		       var strURL = null; 
	 		   if($Flag == "F"){ 
	 			    data = $family_grid.getData(); 
	 			    strURL = "/hrm/empinfo/saveAndUpdateFamilyInfo";
		    	}
		    	if($Flag == "O"){
		    		data = $others_grid.getData();  
	 			    strURL = "/hrm/empinfo/saveAndUpdateEmergencyContactInfo";
		    	} 
	 		     
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post(strURL, 
                     [	 
                   		{ name: 'jsonData', value: JSON2.stringify(data)},
		                { name: 'EMPID', value: "${basicInfo.EMPID}"}
                      ]
             , function (result)
             {
             	$.ligerDialog.closeWaitting();
                 if (result == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
 		                	$family_grid.loadData(true); //加载数据  
 		                	$others_grid.loadData(true); //加载数据 
                     });
                 }
                 else
                 {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                 }
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
							<spring:message code="hrms.socialRelations"/>
						</td>	
						<td width="5%" align="right">&nbsp;</td>
						<td align="right"> 
	                    		<SipingSoft:button/>     
						</td>										    
					</tr> 
				</table>  
		        
		       <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8"> 
		          	<tr>  
		          	   <td class="l-table-edit-c" colspan="4"> 
		          	   		<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; "> 
							<div title='<spring:message code="hrms.familyMember"/>'>
								<div id="familyInfo"></div>
							</div>
							<div title='<spring:message code="hrms.emergencyContact"/>'> 
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
