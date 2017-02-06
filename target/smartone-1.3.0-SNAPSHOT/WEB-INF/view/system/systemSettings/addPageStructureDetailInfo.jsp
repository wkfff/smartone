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
         
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
	<script src="/resources/js/function.js" type="text/javascript"></script>
    <script type="text/javascript"> 
    var $grid = null ; 
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
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
         f_initGrid(); 
    });
 
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: true,
    		columns: [    
	    	           	{ display: '', name: 'TABLE_NAME',width:10,hide: 1}, 
	    	           	{ display: '<spring:message code="hrms.basicCode"/>', name: 'ITEM_ID',align: 'left',width:160},  
	      	           	{ display: '<spring:message code="hrms.chineseName"/>', name: 'ITEM_NAME',align: 'left',width:160 },
	    	           	{ display: '<spring:message code="hrms.englishName"/>', name: 'ITEM_EN_NAME' ,align: 'left',width:160}, 
	    	           	{ display: '<spring:message code="hrms.dataType"/>', name: 'DATA_TYPE' ,align: 'left',width:160} 
		            ],
            enabledEdit: false,usePager: true, rownumbers:true,
            url: '/system/systemSettings/getPageStructureDetailItemInfo?MENU_CODE=${paraMap.MENU_CODE}',
            parms: [	
    	            { name: 'keyWord', value: $("#keyWord").val()}
                   ],
            width: '99.6%', height: '100%'
        });
    }
     
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {   
    	 var jsonData = '[' ; 
    	 
    	 var rows = $grid.getCheckedRows(); 
    	 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
       $(rows).each(function (index, row)
             {
		     	 if (jsonData.length > 1){
	             	jsonData += ',{' ;
	             }
	             else{
	             	jsonData += '{' ;
	             }  
	             jsonData += ' "ITEM_ID": "' + this.ITEM_ID + '",' ;    
	             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ;    
	             jsonData += ' "TABLE_NAME": "' + this.TABLE_NAME + '"' ;       
	             jsonData += '}' ;  
        }); 
       
    	jsonData += ']' ;  
  	     
    	if(jsonData.length == 2){
	        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        } 
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/system/systemSettings/addPageStructureDetailInfo?MENU_CODE=${paraMap.MENU_CODE}", 
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
               		parent.f_ChildWindowClose() ; //加载数据 
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
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" > 
     <div position="center" id='' title=' ' >
	 <div position="top">  
	   		<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr> 
	               <td width="10%" class="l-table-edit-t">
	               		<spring:message code="keyWord"/></td>
	               <td width="23%" class="l-table-edit-c">
	               		<input name="keyWord" type="text" id="keyWord" size="30"/></td>
	           </tr>  
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
               			<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a> 
               			<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>  
					</td>
	           </tr>  
       		</table> 
	  </div> 
      	<div position="center" id='empInfo'></div>
  </div>
</div>
</body>
</html>
