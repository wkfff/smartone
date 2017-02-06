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
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
       
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
    var $grid ;
 	// 初始调用
 	
    $(function() { 
    	//布局
        $("#layout1").ligerLayout({
        		topHeight: 80,
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
    	
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: true,
            columns: [
      			{ display: '<spring:message code="hrms.sequence"/>', name: 'AFFIRM_RELATION_NO',width:120},
				{ display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',width:120},
				{ display: '<spring:message code="hrms.chineseName"/>', name: 'CHINESENAME', align: 'center',width:120},
				{ display: '<spring:message code="hrms.englishName"/>', name: 'ENGLISHNAME', align: 'center',width:120},
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', align: 'center',width:120},  
				{ display: '<spring:message code="hrms.level"/>', name: 'AFFIRM_LEVEL', align: 'center',width:120}, 
				{ display: '<spring:message code="hrms.level"/>', name: 'AFFIRM_TYPE_ID', align: 'center',width:120,hide:1}, 
				{ display: '<spring:message code="hrms.approvalType"/>', name: 'AFFIRM_TYPE_NAME', align: 'center',width:120}
            ],
            usePager: false, dataAction: 'server', root: 'appProcessInfoList', 
            url: '/system/appProcessManagement/getAppProcessInfo?AFFIRM_OBJECT='+$("#AFFIRM_OBJECT").val()+'&AFFIRM_TYPE_ID='+$("#AFFIRM_TYPE_ID").val(),
            width: '99%', height: '90%'
        }); 
    });
 	
    function spf_delete()
    {
    	var jsonData = '[' ;
    	var rows = $grid.getCheckedRows();
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
		     	 var rows = $grid.getCheckedRows(); 
		           
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
			                        jsonData += ' "AFFIRM_RELATION_NO": "' + this.AFFIRM_RELATION_NO + '"';
			                         jsonData += '}' ;
	        	            });
			 		jsonData += ']' ;
		          
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/appProcessManagement/deleteAppProcessDInfo", 
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
		                	$grid.loadData(true); //加载数据
		                	parent.f_ChildWindowClose() ;
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
     <div style="border:1px solid #A3C0E8;" >
     <div>   
     <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			            <tr>  
			                <td class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
			                <td class="l-table-edit-c">
			                	<input id="jsonData" name="jsonData" type="hidden" value=""/>
			                	<input id="DEPTID" name="DEPTID" type="hidden" value="${appProcessDInfo.DEPTID }"/>
			                	<input id="AFFIRM_OBJECT" name="AFFIRM_OBJECT" type="hidden" value="${paramMap.AFFIRM_OBJECT }"/>
			                	<input id="AFFIRM_TYPE_ID" name="AFFIRM_TYPE_ID" type="hidden" value="${paramMap.AFFIRM_TYPE_ID }"/>
			                	${appProcessDInfo.DEPTNAME } 
			                </td> 
			                <td class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
			                <td class="l-table-edit-c">
			                	${appProcessDInfo.DEPT_EN_NAME } 
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.location"/></td>
			                <td class="l-table-edit-c">
			                	${appProcessDInfo.AREA } 
			                </td>
			            </tr>
			            <tr>
			                <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
			                <td class="l-table-edit-c">
			                	${appProcessDInfo.STATUS } 
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
			                <td class="l-table-edit-c">
			                	${appProcessDInfo.CPNY_NAME } 
			                </td>
			                <td class="l-table-edit-t"><spring:message code="hrms.setApprover"/></td>
			                <td class="l-table-edit-c">
			                	${appProcessDInfo.SET_APP_NAME } 
			                </td>
			            </tr>  
			         </table>
		        <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
		           <tr>
		               <td colspan="8" height="30px"> 
		               	    <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
		               </td>
		           </tr> 
		       </table>  
	  </div>
      <div id='empInfo'></div>
 </div>     	
</div>    
</body>
</html>
