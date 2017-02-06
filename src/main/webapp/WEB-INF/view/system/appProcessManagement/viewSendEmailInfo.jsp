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
    <script src="/resources/js/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script> 
    
      
    <script type="text/javascript">
    
    var $grid ;
    var $dialog ;
    
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm)
        {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm)
        {
            return input.val();
        },
        setValue: function (input, value, editParm)
        {
            input.val(value);
        },
        resize: function (input, width, height, editParm)
        {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    
    // 初始调用
    $(function ()
    {
    	//布局
        $("#layout1").ligerLayout({
    	        topHeight:30,
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
        
         f_initGrid();
 
    });

    function f_initGrid()
    {
    	$grid = $("#sendEmailInfo").ligerGrid({
    		checkbox: false,
            columns: [
            { display: '', name: 'LIST_ID',width:90, hide:1},
            { display: '申请类型', name: 'APPLY_TYPE',width:90, align: 'left'},
            { display: '通知方式', name: 'ADDRESS_TYPE',width:90, align: 'left'},
            { display: '发送目标', name: 'ADDRESS',width:320, align: 'left', editor:{type:'textarea'}}
            ],
            usePager: true, enabledEdit: true,
            url: '/system/appProcessManagement/getSendEmailInfo',
            width: '99.6%', height: '100%'
        });
    }

    function spf_save()
    { 
    	var rows = $grid.getSelectedRow(); 

        if (!rows || rows.length == 0) { 
       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
    	 return ; 
    	}
        if (rows.length > 1){
        	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
        } 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/appProcessManagement/updateSendEmailInfo", 
                [	
                 	{ name: 'LIST_ID', value: rows.LIST_ID },
                 	{ name: 'ADDRESS', value: rows.ADDRESS },
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
   

    function spf_delete(DEPTID,AFFIRM_TYPE_ID)
    {  
    	$dialog = $.ligerDialog.open({isDrag: false,  title:'<spring:message code="hrms.delete"/>', 
    		width: $("#layout1").width()-40, height: $("#layout1").height()-40, url: '/system/appProcessManagement/deleteAppProcessDInfo?AFFIRM_OBJECT='+DEPTID+'&AFFIRM_TYPE_ID='+AFFIRM_TYPE_ID+'&DEPTID='+DEPTID
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
		  <div position="top">
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" style="height: 100%"> 
	           <tr>
	              <td align="left" height="30px">
	               		<SipingSoft:button />
	               </td>
	           </tr>
	       </table>
	  </div>
      <div position="center" id='sendEmailInfo'></div>
     </div>     
</body>
</html>
