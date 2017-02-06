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
	<script src="/resources/js/json2.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>   
	
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
         spf_initGrid();  
         
    });
   
    function spf_initGrid()
    {
    	$grid = $("#affirmorInfo").ligerGrid({
    	 checkbox: false,   
            columns: [ 
            { display: '<spring:message code="hrms.empid"/>', name: '',hide:1,width: 10},
            { display: '名称', name: 'OBJECT_NAME',width: 200},
            { display: '类型', name: 'AFFIRM_OBJECT',width: 200},
            { display: '状态代码', name: 'OBJECT_STATUS_ID',width: 50},
            { display: '', name: 'PRE_OBJECT_STATUS_ID',hide:1},
            { display: '跳转状态', name: '',width: 200, 
            	render: function(item) { 
                	return spf_parseRejectedStatus(item.rejectedStatus, spf_getRadioName(item) );
                }
            }
            ],
            usePager: false, rownumbers:true, 
            data: { Rows: ${paramMap.rejectedObjects} },
			parms: [
	        	],
            width: '98%', height: '89%'
        });
    }
    
    function spf_parseRejectedStatus(statuses, name){
    	var returnString = '<span>';
    	
    	for(var i=0; i<statuses.length; i+=1){    		
    		returnString +=  
	        '<input type="radio" onchange="spf_radioChanged()" name="'+name+'" value="'+statuses[i].STATUS_ID+'">'+statuses[i].STATUS_NAME+'</input>&nbsp;';	       
    	}
    	returnString = returnString + '</span>' ;
    	return returnString;
    }
    
    function spf_radioChanged() { 
        alert('changed');
    	var selectedRow = $grid.getSelectedRow(); 
        $grid.updateCell('OBJECT_STATUS_ID', $('input[name="'+spf_getRadioName(selectedRow)+'"]:checked').val(), selectedRow);
        $grid.updateCell('PRE_OBJECT_STATUS_ID', $('input[name="'+spf_getRadioName(selectedRow)+'"]:checked').val(), selectedRow);
    }
    
    function spf_getRadioName(item){
    	return item.AFFIRM_OBJECT+"_"+item.OBJECT_NAME
    }
    
    function spf_confirm(){
         
        var data = $grid.getData(); 
        
        for(var i=0; i<data.length; i++){
        	if(data[i].OBJECT_STATUS_ID == '' ||data[i].OBJECT_STATUS_ID == null){
        		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '第'+i+'行的跳转状态未指定') ;
        		return ;
        	}
        }
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/process/processManage/saveAndUpdateRejectStatus", 
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
                	parent.closeRejDialog();
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
	<div id="layout1" >  
     <div position="center" id='' title=' ' >
	  	<div id="affirmorInfo" ></div>
	  </div> 
	  </div> 
</body>
</html>
