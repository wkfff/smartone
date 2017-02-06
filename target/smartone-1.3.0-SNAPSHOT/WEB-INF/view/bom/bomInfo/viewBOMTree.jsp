<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
 
   <meta http-equiv="X-UA-Compatible" content="IE=edge" >
   
    
    <!-- CSS -->
	<style type="text/css">
	.OrgBox{
		font-size:12px;
		padding:5px 5px 5px 5px;
		clear:left;
		float:left;
		text-align:center;
		position:absolute;
		background-image:url(http://www.on-cn.cn/tempimg/org.jpg);
		width:70px;
		height:106px;
	}
	.OrgBox img{
		width:60px;
		height:70px;
	}
	.OrgBox div{
		color:#FFA500;
		font-weight:800;
	}
	</style>    
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }  
        .l-page-top{ height:80px; background:#f8f8f8; margin-bottom:3px;}
        h4{ margin:20px;}
    </style>	
    	
	<!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    
     <!-- JS -->
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/json2.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>    
    <script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    var $menu ;
    var $node ;
    // 初始调用
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({ leftWidth: 180});

 		$tree = $("#bomTree").ligerTree(
		    	{ 
		    		method:'post',
	    	    	url: '/bom/bomInfo/getBOMTreeList?BOM_ID=${paramMap.BOM_ID}&QUERY_DATE=${paramMap.QUERY_DATE}&CHANGE_NO=${paramMap.CHANGE_NO}', 
	    	    	checkbox: false,
	    	    	idFieldName: 'MAT_V_ID', 
	    	    	parentIDFieldName: 'PARENT_ID', 
	    	    	parentIcon: 'bom',
	    	    	childIcon: 'mat',
	    	    	textFieldName: 'MAT_V_ID',
	    	    	topParentIDValue: null,
	    	    	//isexpandFieldName: 'ISEXPAND',
	    	    	nodeWidth:150,
			        checkbox: false,
		            onSelect: onSelect,
		            //onContextmenu: onContextmenu
	        	 }
	    );   

    });

    
    
    var tab = parent.tab;
    
    function onContextmenu(node,event)
    {
		$node = node;
		document.getElementById("salesInfoFrame").src = '/sales/salesPersonnel/viewSalesDetail?EMPID=' + $node.data.EMPID;		
    	if($menu!=null)
    		$menu.hide();	
    	<c:if test="${LoginType==0}"> 
	    	$menu=$.ligerMenu(
	    			{ 
			    		top: event.clientY, 
			    		left: event.clientX, 
			    		width: 120,
			    		items:
			    		[
						{ text: '<spring:message code="hrms.delete"/>', click: onclickRemove},
						{ text: '<spring:message code="hrms.update"/>', click: onclickUpdate}	,	    		 
						{ text: '<spring:message code="bom.increaseSubordinatePartners"/>', click: onclickAdd},
						{ text: '<spring:message code="bom.increasePeerPartners"/>', click: onclickAddSame}				
			    		]
	    			});
	    	$menu.show();	   		
		</c:if>
    }
    
    function onclickAddSame()
    {
		var parent_id = $node.data.EMP_PARENT_ID;
		tab.addTabItem({ tabid : 'sales0201',text: '<spring:message code="bom.addBusinessPartner"/>', url: '/sales/bpManage/addBP?MENU_CODE=sales0201&EMP_PARENT_ID=' + parent_id});
    }
   
    function onclickAdd()
    {
    	var parent_id = $node.data.EMPID;
		tab.addTabItem({ tabid : 'sales0201',text: '<spring:message code="bom.addBusinessPartner"/>', url: '/sales/bpManage/addBP?MENU_CODE=sales0201&EMP_PARENT_ID=' + parent_id});
    }
    
    function onclickRemove()
    {
    	$.ligerDialog.confirm('<spring:message code="bom.areYouSureDeletePartner"/>'+$node.data.EMPID,'<spring:message code="hrms.warning"/>', function (yes)
    	   	    {
    				if(yes)
    					{
	    					$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	    			        $.post("/bp/bpManage/removeBP", 
	    			                [	
	    			                   { name: 'EMPID', value: $node.data.EMPID}
	    			                 ]
	    			        , function (result)
	    			        {
	    			        	$.ligerDialog.closeWaitting();
	    			            if (result == "Y")
	    			            {
	    			                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	    			                {
	    			                	$tree.loadData();
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
    
    function onSelect(node)
    {         
    	document.getElementById("bomItemFrame").src = '/mat/matInfo/viewMaterialDetail?MAT_ID=' + node.data.MAT_V_ID;
    }

    </script>
</head>

<body style="padding:0px"> 
      <div id="layout1" >
            <div position="left" id="shiftList" class="l-scroll" style="height:95%;overflow:auto;" title="<spring:message code="bom.bomLevel"/>">
	           <!--不带复选框-->
			    <ul id="bomTree"></ul>
            </div>
            
            
            <div position="center" class="l-tab-content" id='shiftParameterInfo' title="<spring:message code="hrms.materialInformation"/>" >
	            <div id="bomItem" style="width:100%;height:100%;color:#000000;">
	            <iframe id="bomItemFrame" frameborder="no"   border="no" style="width:100%;height:100%;color:#000000;" >
	            </iframe>
	            </div>
        	</div> 
       </div>
</body>

</html>
