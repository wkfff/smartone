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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">

	var $grid ;
	var $dialog ;
	// 初始调用
	$(function (){
		//布局
		$("#layout1").ligerLayout({
			allowLeftResize: false,//是否允许 左边可以调整大小
			allowRightResize: false,//是否允许 右边可以调整大小
			allowTopResize: false,//是否允许 头部可以调整大小
			allowBottomResize: false//是否允许 底部可以调整大小
		});
		f_initGrid();
	});
	function f_initGrid()
	{
		$grid = $("#attMItemInfo").ligerGrid({
			checkbox: false,
			columns: [
			{ display: '', name: 'ITEM_NO',width: 10,hide:1}, 
			{ display: '<spring:message code="hrms.chineseName"/>', name: 'ITEM_NAME',align: 'left'},
			{ display: '<spring:message code="hrms.englishName"/>', name: 'ITEM_EN_NAME',align: 'left'},
            { display: '<spring:message code="hrms.unit"/>', name: 'UNIT_NAME', width: 120},
            { display: '<spring:message code="hrms.minimumUnit"/>', name: 'MIN_UNIT', width: 120},
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS', width: 120},
            { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width: 120},
             
            { display: '<spring:message code="hrms.sortOrder"/>', name: 'CALCU_ORDER', width: 100, render: function (row, index)
                {
	        	 if(index == '0'){
	        			return '<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';            		
		          }if(row.MAX_INDEX == index+1){
	        			return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">';            		
		          }else{	
		        	  return '<img src="/resources/images/up.gif" onclick="spf_updateOrder(' + index + ', -1)" style="cursor:hand">&nbsp;&nbsp;&nbsp;&nbsp;' + '&nbsp;&nbsp;<img src="/resources/images/down.gif" onclick="spf_updateOrder(' + index + ', 1)" style="cursor:hand">';            		
	              }
               	}
        	}
            ],
            usePager: false,rownumbers:true,
            url: '/att/attendanceSettings/getAttMItemInfo',
            width: '99.6%', height: '100%',
            heightDiff : 0
        });
    }
    
    function spf_updateOrder(indexs,flag)
    {  //上移
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
        		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
        		             jsonData += ' "CALCU_ORDER": "' + index + '"' ;      
        		             jsonData += '}' ;   
    		             }if(index == indexs + flag){
        		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
        		             jsonData += ' "CALCU_ORDER": "' + (index + 1)+ '"' ;      
        		             jsonData += '}' ;   
    		             }if( index == indexs){
        		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
        		             jsonData += ' "CALCU_ORDER": "' + (index - 1) + '"' ;      
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
       		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
       		             jsonData += ' "CALCU_ORDER": "' + index + '"' ;      
       		             jsonData += '}' ;   
   		             }if(index == indexs + flag){
       		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
       		             jsonData += ' "CALCU_ORDER": "' + (index - 1)+ '"' ;      
       		             jsonData += '}' ;   
   		             }if( index == indexs){
       		             jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '",' ; 
       		             jsonData += ' "CALCU_ORDER": "' + (index + 1) + '"' ;      
       		             jsonData += '}' ;   
   		             }
   	        }); 
    	}
	       
    	jsonData += ']' ; 
   	    //alert(jsonData);
    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/att/attendanceSettings/updateAttMItemInfoCalOrder", 
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
	               		$grid.loadData(true); //加载数据 
	               });
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
	           }
	       });
    } 
      
    function spf_search()
    {   
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'keyWord', value: $("#keyWord").val()},
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()},
    	                        	{ name: 'CPNY_ID', value: $("#CPNY_ID").val()}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
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
		        $.post("/att/attendanceSettings/deleteAttMItemInfo", 
		                [	
		                 	{ name: 'ITEM_NO', value: rows.ITEM_NO }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function ()
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

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    	$dialog.close() ;
    }

    function spf_add()
    {
    	$dialog = $.ligerDialog.open({isDrag: false, 
   		    title:'<spring:message code="hrms.add"/>', 
    		width: 800, 
    		height: 400, 
    		url: '/att/attendanceSettings/addAttMItemInfo'
        	  });
    }

    function spf_update()
    {
   	    var rows = $grid.getSelectedRow(); 

        if (!rows || rows.length == 0) { 
	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	    	 return ; 
	    }
        if (rows.length > 1){
        	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
        } 

    	$dialog = $.ligerDialog.open({isDrag: false, 
   		    title:'<spring:message code="hrms.update"/>', 
    		width: 800, 
    		height: 400, 
    		url: '/att/attendanceSettings/updateAttMItemInfo?ITEM_NO=' + rows.ITEM_NO
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
	           	   <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
	               <td class="l-table-edit-c">
	               		<input type="text" name="keyWord" id="keyWord" /></td> 
	           	   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
	               <td class="l-table-edit-c">
	               	    <SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search();"/> </td> 
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
		<div position="center" id='attMItemInfo'></div>
	</div>	
</div>
</body>
</html>
