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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
	<script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
<script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    var $activitySelectList ; 
    var $companySelectList ; 
    var $menuModuleSelectList ; 
    var $dataTypeSelectList ; 
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({ 
    	     	 topHeight:60,
		         allowLeftResize: false,      //是否允许 左边可以调整大小
		         allowRightResize: false,     //是否允许 右边可以调整大小
		         allowTopResize: false,      //是否允许 头部可以调整大小
		         allowBottomResize: false     //是否允许 底部可以调整大小
          }
         );
         
         $activitySelectList = getActivitySelectList() ;
         $companySelectList = getCompanySelectList() ; 
         $menuModuleSelectList = getMenuModuleSelectList() ; 
         $dataTypeSelectList = getDataTypeSelectList() ;
         spf_initGrid();

    });
    function getDataTypeSelectList(){
    	//请求服务器
    	var dataTypeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getDataTypeSelectList?PARENT_CODE=DataType&DEPTH=2', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	dataTypeSelectList = list ;
            }
        });   
        return dataTypeSelectList ;
    }
    
    function getActivitySelectList(){
    	//请求服务器
    	var activitySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getActivitySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		activitySelectList = list ;
            }
        });   
        return activitySelectList ;
    }
    
    function getCompanySelectList(){
    	//请求服务器
    	var companySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getCompanySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		companySelectList = list ; 
            }
        });

        return companySelectList ;
    } 
     
    function getMenuModuleSelectList(){
    	//请求服务器
    	var menuModuleSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getMenuModuleSelectList?MENU_PARENT_CODE=HRMS&DEPTH=0', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	menuModuleSelectList = list ;
            }
        });   
        return menuModuleSelectList ;
    }
    
    function spf_initGrid()
    {
    	$grid = $("#moduleParameterInfo").ligerGrid({
    	 checkbox: false,   
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'PARAMETER_NO', width: 80},
            { display: '<spring:message code="hrms.basicCode"/>', name: 'PARAMETER_ID', width: 160, align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'DESC_ZH',width: 160,align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.englishName"/>', name: 'DESC_EN',width: 160,align: 'left', editor: { type: 'text' }},  
            { display: '<spring:message code="hrms.content"/>', name: 'CONTENT',width: 90,align: 'left', editor: { type: 'text' }}, 
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARKS',width: 110,align: 'left', editor: { type: 'text' }}, 
            { display: '<spring:message code="hrms.dataType"/>', name: 'DATA_TYPE_CODE',width: 120,
                editor: { 
                	type: 'select', data: $dataTypeSelectList, dataValueField: 'DATA_TYPE_CODE',dataDisplayField: 'DATA_TYPE_NAME', 
                	displayColumnName: 'DATA_TYPE_NAME', valueColumnName: 'DATA_TYPE_CODE'
                }, render: function (item)
                {
                    for (var i = 0; i < $dataTypeSelectList.length; i++)
                    {
                        if ($dataTypeSelectList[i]['DATA_TYPE_CODE'] == item.DATA_TYPE_CODE)
                            return $dataTypeSelectList[i]['DATA_TYPE_NAME']
                    }
                    return item.DATA_TYPE_NAME;
                }
	        }, 
        	{ display: '<spring:message code="hrms.module"/>', name: 'MENU_CODE', width: 100,
                editor: { 
                	type: 'select', data: $menuModuleSelectList, dataValueField: 'MENU_CODE',dataDisplayField: 'MENU_INTRO', 
                	displayColumnName: 'MENU_INTRO', valueColumnName: 'MENU_CODE'
                }, render: function (item)
                {
                    for (var i = 0; i < $menuModuleSelectList.length; i++)
                    {
                        if ($menuModuleSelectList[i]['MENU_CODE'] == item.MENU_CODE)
                            return $menuModuleSelectList[i]['MENU_INTRO']
                    }
                    return item.MENU_INTRO;
                }
	        }, 
        	{ display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', width: 100,
                editor: { 
                	type: 'select', data: $activitySelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
                	displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $activitySelectList.length; i++)
                    {
                        if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID)
                            return $activitySelectList[i]['STATUS']
                    }
                    return item.STATUS;
                }
	        },  
	        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_ID', width: 100,
                editor: { 
                	type: 'select', data: $companySelectList, dataValueField: 'CPNY_ID',dataDisplayField: 'CPNY_NAME',
                	displayColumnName: 'CPNY_NAME', valueColumnName: 'CPNY_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $companySelectList.length; i++)
                    {
                        if ($companySelectList[i]['CPNY_ID'] == item.CPNY_ID)
                            return $companySelectList[i]['CPNY_NAME']
                    }
                    return item.CPNY_NAME;
                }
	        }
            ],
            enabledEdit: true,usePager: true, rownumbers: true,dataAction: 'server', root: 'moduleParameterInfoList', record: 'moduleParameterInfoCnt',
            url: '/system/systemParameter/getModuleParameterInfo',
            width: '99.6%', height: '100%',
        });
    }
     
    function spf_save()
    {  
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/systemParameter/saveAndUpdateModuleParameterInfo", 
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
		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		         }
  
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/systemParameter/deleteModuleParameterInfo", 
		                [	
		                 	{ name: 'PARAMETER_NO', value: rows.PARAMETER_NO }
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
    
    function spf_add()
    {
    	$grid.addRow();
    }

    function spf_search()
    {  
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'keyWord', value: $("#keyWord").val()},  
    	                        	{ name: 'CPNY_ID', value: $("#CPNY_ID").val()},
    	                        	{ name: 'MENU_CODE', value: $("#MENU_CODE").val()},   
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
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
					               <td class="l-table-edit-t"><spring:message code="hrms.module"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectMenu name="MENU_CODE" limit="all" onChange="spf_search();"/>
						       	   </td>
					               <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectCompany name="CPNY_ID" limit="all" onChange="spf_search();"/>
						       	   </td>
						       	   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search();"/>
						       	   </td>  
					           </tr> 
					       </table>
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
               <div position="center" id="moduleParameterInfo" ></div>
</div>  
</body>
</html>
