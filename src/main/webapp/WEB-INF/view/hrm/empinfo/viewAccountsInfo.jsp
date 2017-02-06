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
     var $grid ; 
     var $bankSelectList ; 
     var $calcFlagSelectList ; 
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
          $bankSelectList = getBankSelectList() ;
          $calcFlagSelectList = getCalcFlagSelectList() ;
          spf_family_initGrid();
     }); 
     function getBankSelectList(){
     	//请求服务器
     	var bankSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getBankSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
             	bankSelectList = list ; 
             }
         });

         return bankSelectList ;
     } 
     function getCalcFlagSelectList(){
     	//请求服务器
     	var calcFlagSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getCalcFlagSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
             	calcFlagSelectList = list ; 
             }
         });
         return calcFlagSelectList ;
     } 
     //限额休假
     function spf_family_initGrid()
     {
     	$grid = $("#familyInfo").ligerGrid({
     		checkbox: false,
     		 columns: [
     	       { display: '', name: 'PA_NO',width: 10,hide:1},  
     	       { display: '<spring:message code="hrms.wageMark"/>', name: 'CALC_FLAG_ID', width: 130,align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $calcFlagSelectList, dataValueField: 'CALC_FLAG_ID',dataDisplayField: 'CALC_FLAG_NAME',
                    	displayColumnName: 'CALC_FLAG_NAME', valueColumnName: 'CALC_FLAG_ID'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $calcFlagSelectList.length; i++)
                        {
                            if ($calcFlagSelectList[i]['CALC_FLAG_ID'] == item.CALC_FLAG_ID)
                                return $calcFlagSelectList[i]['CALC_FLAG_NAME']
                        }
                        return item.CALC_FLAG_NAME;
                    }
    	        },
    	        { display: '<spring:message code="hrms.bank"/>', name: 'BANK_CODE', width: 130,align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $bankSelectList, dataValueField: 'BANK_CODE',dataDisplayField: 'BANK_NAME',
                    	displayColumnName: 'BANK_NAME', valueColumnName: 'BANK_CODE'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $bankSelectList.length; i++)
                        {
                            if ($bankSelectList[i]['BANK_CODE'] == item.BANK_CODE)
                                return $bankSelectList[i]['BANK_NAME']
                        }
                        return item.BANK_NAME;
                    }
    	        },
                { display: '<spring:message code="hrms.accountNumber"/>', name: 'CARD_NO',width: 180,editor:{type : 'text'}},  
                
		        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 380,editor: { type: 'text' }}
           ],  
             enabledEdit: true,usePager: false,rownumbers:true,
             url: "/hrm/empinfo/getPaEmpInfoList?EMPID=${basicInfo.EMPID }", 
             pageSize: 5,	    
             pageSizeOptions: [5,4,3,2,1], 
	         heightDiff : 0, 
	         width: '99.6%', height: '100%'
         });
     }
     
     function spf_add()
     {
      	$grid.addRow();
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
 		        $.post("/hrm/empinfo/deleteEmpPaInfo", 
 		                [	
 		                 	{ name: 'PA_NO', value: rows.PA_NO }
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
 	 function spf_save() { 
 		 
 		     var data = $grid.getData(); 
 		         
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post('/hrm/empinfo/saveAndUpdateEmpPaInfo', 
                     [	 
                   		{ name: 'jsonData', value: JSON2.stringify(data)},
		                { name: 'EMPID', value: ${basicInfo.EMPID} }
                      ]
             , function (result)
             {
             	$.ligerDialog.closeWaitting();
                 if (result == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
				<table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
						<td width="25%" align="left" style="font-weight: bold;">
							<spring:message code="hrms.account"/>
						</td>	
						<td width="5%" align="right">&nbsp;</td>
						<td align="right"> 
	                    		<SipingSoft:button/>    
						</td>										    
					</tr> 
				</table>  
		         
		  </div>
		  <div id="familyInfo"></div>
	</div>
</div>
</body>
</html>
