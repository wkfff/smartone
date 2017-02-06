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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
        
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    var $activitySelectList ; 
    var $companySelectList ; 
    var $orderSelectList ; 
    var $depthSelectList ; 
    var $builSelectList ; 
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({ leftWidth: 180});

         $tree = $("#parentTree").ligerTree(
	          { 
		          checkbox: false,
	              onSelect: onSelect
	          }
          );

        $activitySelectList = getActivitySelectList() ;
        $companySelectList = getCompanySelectList() ;
        $orderSelectList = getOrderSelectList() ;
        $depthSelectList = getDepthSelectList() ;
        $builSelectList = getBuilSelectList() ;
        spf_initGrid();

    });
 
    function getBuilSelectList(){
    	//请求服务器
    	var builSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getYesOrNoSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	builSelectList = list ;
            }
        });

        return builSelectList ;
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
     
    function getOrderSelectList(){
    	//请求服务器
    	var orderSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getOrderSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		orderSelectList = list ; 
            }
        });

        return orderSelectList ;
    } 
    
    function getDepthSelectList(){
    	//请求服务器
    	var depthSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getDepthSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		depthSelectList = list ; 
            }
        });

        return depthSelectList ;
    } 


    function onSelect(note)
    {       
 		 $.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	             	
	       	url:'/system/basicMaintenance/getMenuListByParentMenuCode?parentCode=' + note.data.url,            	
	       	dataType:'json',
	       	success:function(response){ 
	        		var jsonObj = {};
	               jsonObj.Rows = response ;
	     		   $grid.setOptions({ data : jsonObj }); //设置数据参数
	               $grid.loadData(true); //加载数据
	       	}          	
      	}); 
    }

    function spf_initGrid()
    {
    	$grid = $("#menuList").ligerGrid({
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'MENU_NO', width: 90, type: 'int' },
            { display: '<spring:message code="hrms.basicCode"/>', name: 'MENU_CODE', align: 'left',editor: { type: 'text' }},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'MENU_INTRO', align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.englishName"/>', name: 'MENU_EN_INTRO', align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.url"/>', name: 'MENU_URL', align: 'left', editor: { type: 'text' }},
           	{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left', editor: { type: 'text' }},
           	{ display: '<spring:message code="hrms.sortOrder"/>', name: 'ORDERNO', width: 70,align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $orderSelectList, dataValueField: 'ORDERNO',dataDisplayField: 'ORDERNO_NAME', 
                    	displayColumnName: 'ORDERNO_NAME', valueColumnName: 'ORDERNO'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $orderSelectList.length; i++)
                        {
                            if ($orderSelectList[i]['ORDERNO'] == item.ORDERNO)
                                return $orderSelectList[i]['ORDERNO_NAME']
                        }
                        return item.ORDERNO_NAME;
                    }
		        },  
	        { display: '<spring:message code="hrms.level"/>', name: 'DEPTH',width: 70,align: 'center',isSort: false,
                   editor: { 
                   	type: 'select', data: $depthSelectList, dataValueField: 'DEPTH',dataDisplayField: 'DEPTH_NAME', 
                   	displayColumnName: 'DEPTH_NAME', valueColumnName: 'DEPTH'
                   }, render: function (item)
                   {
                       for (var i = 0; i < $depthSelectList.length; i++)
                       {
                           if ($depthSelectList[i]['DEPTH'] == item.DEPTH)
                               return $depthSelectList[i]['DEPTH_NAME']
                       }
                       return item.DEPTH_NAME;
                   }
	        },
	        { display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',isSort: false,
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
	        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_ID', align: 'center',isSort: false,
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
	        },
		        { display: '<spring:message code="hrms.build"/>', name: 'YN_ID', width: 70,align: 'center',isSort: false,
	                   editor: { 
	                   	type: 'select', data: $builSelectList, dataValueField: 'YN_ID',dataDisplayField: 'YN_NAME',
	                   	displayColumnName: 'YN_NAME', valueColumnName: 'YN_ID'
	                   }, render: function (item)
	                   {
	                       for (var i = 0; i < $builSelectList.length; i++)
	                       {
	                           if ($builSelectList[i]['YN_ID'] == item.YN_ID)
	                               return $builSelectList[i]['YN_NAME']
	                       }
	                       return item.YN_NAME;
	                   }
		        }
            ],
            enabledEdit: true, usePager: true,rownumbers: true,
            width: '99.6%', height: '100%',
            heightDiff : 1
        });
    }  
    function spf_save()
    {
    	var note = $tree.getSelected(); 
    	if (note == null){ return ;}
         
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/basicMaintenance/saveAndUpdateMenuInfo", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)},
                 	{ name: 'parentCode', value: note.data.url}
                 ]
        , function (result)
        {
       
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$grid.loadData(true);
                	onSelect(note) ;
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
    	var note = $tree.getSelected(); 
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
		     	 var rows = null;
		         rows=$grid.getSelectedRow();  
		         if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
		         if (rows.length > 1){
		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		         }
  
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/basicMaintenance/deleteMenuInfo", 
		                [	
		                 	{ name: 'MENU_NO', value: rows.MENU_NO },
		                 	{ name: 'MENU_CODE', value: rows.MENU_CODE }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            { 
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		                {
		                	$grid.loadData(true); //加载数据 
		                	onSelect(note) ;
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
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" >
            <div align="left" position="left" id="parentCode" class="l-scroll" style="height:95%;overflow:auto;" title='<spring:message code="hrms.basicCode"/>'>
	           <c:set var="parentSize" value="${fn:length(parentMenuList)}" />
	            <!--不带复选框-->
			    <ul id="parentTree">
			    	<c:forEach items="${parentMenuList}" var="parentCode" varStatus="i">
			    		<c:if test="${i.index == 0}" >
			    			<li url="${parentCode.MENU_CODE}" isexpand="false">
					            <span >${parentCode.MENU_INTRO}</span>
					            <ul>
			    		</c:if>
			    		
			    		<c:if test="${i.index != 0 && parentCode.DEPTH == 0}" >
					            </ul>
					        </li> 
			    			<li url="${parentCode.MENU_CODE}" isexpand="false">
					            <span >${parentCode.MENU_INTRO}</span>
					            <ul>
			    		</c:if>
			    		<c:if test="${parentCode.DEPTH != 0}" >
			    			<li url="${parentCode.MENU_CODE}" ><span >${parentCode.MENU_INTRO}</span></li>
			    		</c:if>
			    	</c:forEach>
						    </ul>
						 </li>
			    </ul>
            
            </div>
            <div align="left" position="center" id='codeInfo' title='<spring:message code="hrms.detailCode"/>' >
          
            
            <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
	           <tr>
	                <td align="left">
	                <SipingSoft:button/>    
				</td>
	           </tr>  
	       </table>
            	<div id="menuList" ></div>
        	</div> 
    </div>
</body>
</html>
