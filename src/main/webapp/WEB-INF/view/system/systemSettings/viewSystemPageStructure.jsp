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
    var $tree ; 
    var menuCode = "" ; 
    var $activitySelectList ; 
    var $companySelectList ; 
    var $menuModuleSelectList ; 
    var $dataTypeSelectList ; 
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({ leftWidth: 150});
	           
         spf_infoPage();
         spf_initGrid();

    });

    function onSelect(note)
    { 
    	menuCode = note.data.MENU_CODE;
 		 $.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/system/systemSettings/getPageStructureDetailInfo?MENU_CODE=' + menuCode,            	
	       	dataType:'json',
	       	success:function(response){ 
	        		var jsonObj = {};
	               jsonObj.Rows = response.Rows ;
	     		   $grid.setOptions({ data : jsonObj }); //设置数据参数
	               $grid.loadData(true); //加载数据
	       	}          	
      	});
    }
    
    function spf_initGrid()
    {
    	$grid = $("#pageStructureDetailInfo").ligerGrid({
    	checkbox: false,   
            columns: [
            { display: '<spring:message code="hrms.sequence"/>', name: 'RI_NO', width: 90},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'ITEM_NAME',width: 160},
            { display: '<spring:message code="hrms.englishName"/>', name: 'ITEM_EN_NAME',width: 160},  
            { display: '<spring:message code="hrms.dataBelong"/>', name: 'MENU_INTRO',width: 160}, 
            { display: '<spring:message code="hrms.sortOrder"/>', name: 'ORDERNO', width: 100, render: function (row, index)
                {
	        	 if(index == '0'){
	        			return '<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';            		
		          }if(row.MAX_INDEX == index+1){
	        			return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">';            		
		          }else{	
		        	  return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;' + '&nbsp;&nbsp;<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';            		
	              }
               	}
        	},
        	{ display: '<spring:message code="hrms.dataType"/>', name: 'DATA_TYPE' ,align: 'left',width:160}  
            ],
            enabledEdit: true,usePager: false,rownumbers: true, 
            width: '99.6%', height: '100%'
        });
    }
    function spf_updateOrder(indexs,flag)
    {  //上移
    	var note = $tree.getSelected();
    	rows = $grid.getData();
   	    var jsonData = '[' ; 
    	if(flag == '-1'){
    		$(rows).each(function (index, row)
    	             {  
    			     	 if (jsonData.length > 1){
    		             	jsonData += ',{' ;
    		             }
    		             else{
    		             	jsonData += '{' ;
    		             } 
    		             if(index != indexs + flag && index != indexs){
        		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
        		             jsonData += ' "ORDERNO": "' + index + '"' ;      
        		             jsonData += '}' ;   
    		             }if(index == indexs + flag){
        		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
        		             jsonData += ' "ORDERNO": "' + (index + 1)+ '"' ;      
        		             jsonData += '}' ;   
    		             }if( index == indexs){
        		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
        		             jsonData += ' "ORDERNO": "' + (index - 1) + '"' ;      
        		             jsonData += '}' ;   
    		             }
    	        }); 
    	}else{
    		//下移
    		$(rows).each(function (index, row)
   	             {  
   			     	 if (jsonData.length > 1){
   		             	jsonData += ',{' ;
   		             }
   		             else{
   		             	jsonData += '{' ;
   		             } 
   		             if(index != indexs + flag && index != indexs){
       		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
       		             jsonData += ' "ORDERNO": "' + index + '"' ;      
       		             jsonData += '}' ;   
   		             }if(index == indexs + flag){
       		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
       		             jsonData += ' "ORDERNO": "' + (index - 1)+ '"' ;      
       		             jsonData += '}' ;   
   		             }if( index == indexs){
       		             jsonData += ' "RI_NO": "' + this.RI_NO + '",' ; 
       		             jsonData += ' "ORDERNO": "' + (index + 1) + '"' ;      
       		             jsonData += '}' ;   
   		             }
   	        }); 
    	}
	       
    	jsonData += ']' ; 
   	     
    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/system/systemSettings/updatePageStructureDetailInfoOrder", 
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
	               		onSelect(note) ;   
	               });
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
	           }
	       });
    } 
    function f_ChildWindowClose (){

    	var note = $tree.getSelected();
    	onSelect(note) ;  
    } 
   
    function spf_delete()
    {      
    	var note = $tree.getSelected(); 
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
		        $.post("/system/systemSettings/deletePageStructureDetailInfo", 
		                [	
		                 	{ name: 'RI_NO', value: rows.RI_NO }
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
    	$dialog = $.ligerWindow.show({isDrag: true,
		    title: '<spring:message code="hrms.add"/>',
      	 	width: 900 , 
      	 	height: 450 , 
      	 	left:120,top:90,
  		    url: '/system/systemSettings/addPageStructureDetailInfo?MENU_CODE=' + menuCode
      	}); 
    }
      
    function spf_infoPage()
	{
		$.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/system/systemSettings/getPageStructure',            	
	       	dataType:'json',
	       	success:function(response){ 
	               $tree = $("#pageStructureTree").ligerTree(
		           	          { 
		           		          checkbox: false, 
    		                      treeLine: true,
    		                      parentIcon: null, 
    		                      childIcon: null,  
	    		                  nodeWidth: 160,
		           	              onSelect: onSelect,
		           	              data: response.Rows,
		           	           	  idFieldName: 'MENU_CODE', textFieldName: 'MENU_INTRO'
		           	          }
	                     );
	       	}          	
	  	}); 
	}  
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" >
            <div position="left" title='<spring:message code="hrms.pageStructure"/>'> 
			    <ul id="pageStructureTree"> </ul> 
            </div>
            
             <div position="center" title='<spring:message code="hrms.detail"/>' >
            	<div>
	            	<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
			           <tr>
			                <td align="left">
	                    		<SipingSoft:button/>   
							</td>
			           </tr>  
		       		</table> 
				</div>  
               <div id="pageStructureDetailInfo" ></div>
        	</div>
       </div>
</body>
</html>
