<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid ; 
	var $grid_item ; 
    var $evTypeProcessSelectList ;  
    var $evTypeOperationSelectList ;  
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
        	     topHeight:60,
        	     rightWidth:480, 
		         allowLeftResize: false,      //是否允许 左边可以调整大小
		         allowRightResize: false,     //是否允许 右边可以调整大小
		         allowTopResize: false,      //是否允许 头部可以调整大小
		         allowBottomResize: false     //是否允许 底部可以调整大小
          }
         );

         $evTypeProcessSelectList = getEvTypeProcessSelectList();
         $evTypeOperationSelectList = getEvTypeOperationSelectList();
         spf_initGrid();
         spf_searchItemInfo();
         spf_getEvaPeriodInfo();

    }); 
    function getEvTypeProcessSelectList(){
     	//请求服务器
     	var evTypeProcessSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getEvTypeProcessSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
            	 evTypeProcessSelectList = list ;
             }
         });

         return evTypeProcessSelectList ;
     } 
    function getEvTypeOperationSelectList(){
     	//请求服务器
     	var evTypeOperationSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getEvTypeOperationSelectList', 
             dataType: 'json',
             async: false,
             success: function (list)
             {  
            	 evTypeOperationSelectList = list ;
             }
         });

         return evTypeOperationSelectList ;
     }
    function spf_initGrid()
    {
    	$grid = $("#info").ligerGrid({
			    	 checkbox: false,   
			            columns: [   
			            { display: '<spring:message code="hrms.process"/>'+' '+'<spring:message code="name"/>', name: 'EV_PROCESS_ID', width: 130,align: 'center',
	                        editor: { 
	                        	type: 'select', data: $evTypeProcessSelectList, dataValueField: 'EV_PROCESS_ID',dataDisplayField: 'EV_PROCESS_NAME',
	                        	displayColumnName: 'EV_PROCESS_NAME', valueColumnName: 'EV_PROCESS_ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $evTypeProcessSelectList.length; i++)
	                            {
	                                if ($evTypeProcessSelectList[i]['EV_PROCESS_ID'] == item.EV_PROCESS_ID) { 
	                                    return $evTypeProcessSelectList[i]['EV_PROCESS_NAME'];
	                                	
	                                }
	                            }
	                            return item.EV_PROCESS_NAME;
	                        }
	        	        },
	        	        { display: '<spring:message code="hrms.process"/>'+' '+'<spring:message code="hrms.operation"/>', name: 'EV_OPERATE_ID', width: 130,align: 'center',
	                        editor: { 
	                        	type: 'select', data: $evTypeOperationSelectList, dataValueField: 'EV_OPERATE_ID',dataDisplayField: 'EV_OPERATE_NAME',
	                        	displayColumnName: 'EV_OPERATE_NAME', valueColumnName: 'EV_OPERATE_ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $evTypeOperationSelectList.length; i++)
	                            {
	                                if ($evTypeOperationSelectList[i]['EV_OPERATE_ID'] == item.EV_OPERATE_ID) { 
	                                    return $evTypeOperationSelectList[i]['EV_OPERATE_NAME'];
	                                	
	                                }
	                            }
	                            return item.EV_OPERATE_NAME;
	                        }
	        	        },
			            { display: '<spring:message code="hrms.startDate"/>', name: 'EV_PROCESS_SDATE', width: 90, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }}, 
						{ display: '<spring:message code="hrms.endDate"/>', name: 'EV_PROCESS_EDATE', width: 90, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},  

				        { display: '<spring:message code="hrms.sortOrder"/>', name: 'EV_PROCESS_ORDER', width: 80, render: function (row, index)
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
			        	{ display: '<spring:message code="hrms.percentage"/>', name: 'EV_PERCENTAGE', type: 'float',width: 70,editor: { type: 'float' }}
						/* 
						{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 100,
			            	editor: { type: 'textarea', height: 100 }
			            },
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 80,
			            	editor: { type: 'textarea', height: 100 }
			            } 
			            */
			            ],
			            enabledEdit: true,usePager: false, rownumbers:true, 
			            url: '/eva/basicInfo/getEvaTypeProcessInfo',
			            width: '99.6%', height: '100%',
			            onSelectRow: function(rowdata, rowindex, rowDomElement){
			            	spf_showEvaPeriodTypeItemInfo(MyCheckNull(rowdata.EV_PERIOD_ID),MyCheckNull(rowdata.EV_TYPE_ID));
				        }
        });
    }
  
    function spf_showEvaPeriodTypeItemInfo(evPeriodID,evTypeID)
    {
    	$grid_item = $("#itemInfo").ligerGrid({
			    	 checkbox: false,   
			            columns: [   
						{ display: '<spring:message code="hrms.item"/>'+' '+'<spring:message code="name"/>', name: 'EV_ITEM_NAME', width: 90},  
						{ display: '<spring:message code="hrms.percentage"/>', name: 'EV_PERCENTAGE',width: 90},
						{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 100,
			            	editor: { type: 'textarea', height: 100 }
			            },
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 80,
			            	editor: { type: 'textarea', height: 100 }
			            }
			            ],
			            enabledEdit: false,usePager: false, rownumbers:true, 
			            url: '/eva/basicInfo/getEvaPeriodTypeItemInfo?EV_PERIOD_ID='+evPeriodID+'&EV_TYPE_ID='+evTypeID, 
			            width: '99.6%', height: '100%'
        });
    }
    function spf_save()
    {   
    	 var jsonData = '[' ; 
    	 
    	 var rows = $grid.getData(); 
    	 
    	 var item_rows = $grid_item.getData(); 
    	   
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        } 
        if (!item_rows || item_rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.itemInfo"/>'+". " + '<spring:message code="input.required"/>') ; 
       		 return ; 
        }
       $(rows).each(function (index, row)
             {  
	    	     if(this.EV_PERCENTAGE == null){  
		       	 	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.percentage"/>'  +". " + '<spring:message code="input.required"/>') ; 
		       		 return false;  
	             }else{ 
				     if (jsonData.length > 1){
			             	jsonData += ',{' ;
			             }
			             else{
			             	jsonData += '{' ;
			             }  
			             jsonData += ' "__status": "' + this.__status + '", ' ;   
			             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '", ' ;  
			             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '", ' ;       
			             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '", ' ; 
			             jsonData += ' "EV_PERCENTAGE": "' + this.EV_PERCENTAGE + '", ' ; 
			             jsonData += ' "EV_OPERATE_ID": "' + this.EV_OPERATE_ID + '", ' ; 
			             jsonData += ' "EV_PROCESS_SDATE": "' + MyToDate(this.EV_PROCESS_SDATE) + '", ' ; 
			             jsonData += ' "EV_PROCESS_EDATE": "' + MyToDate(this.EV_PROCESS_EDATE) + '", ' ;  
			             jsonData += ' "EV_PROCESS_ORDER": "' + index + '", ' ;   
			             jsonData += ' "DESCRIPTION": "' + MyCheckNull(this.DESCRIPTION) + '",' ;
			             jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
			             jsonData += '}' ; 
				  }
        }); 
       
    	jsonData += ']' ;  
  	   
    	if(jsonData.length == 2){
	        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        } 
       $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
       $.post("/eva/basicInfo/saveAndUpdateEvaTypeProcessInfo", 
               [	
                	{ name: 'jsonData', value: jsonData }
               ]
       , function (result)
       {
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
               {
               		$grid.loadData(true);//加载数据 
               		spf_searchItemInfo(); //加载数据 
               });
           }
           else
           {
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
           }
       });
    }   
       
    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据 
    } 
    function spf_searchItemInfo()
    {   
    	spf_showEvaPeriodTypeItemInfo('1','2');
    }
    function spf_search()
    { 
       	$grid.setOptions({ parms: [	
    		                        	{ name: 'EV_PERIOD_ID', value: $("#EV_PERIOD_ID").attr('value')},
    		                        	{ name: 'EV_TYPE_ID', value: $("#EV_TYPE_ID").attr('value')},
    		                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}
        	                           ],
        	                   newPage: 1
        	                 }); //设置数据参数 
         $grid.loadData(true); //加载数据
         spf_searchItemInfo(); //加载数据 
    }
    function spf_add()
    { 
    	var rows = $grid.getData(); 
    	if (!rows || rows.length == 0) { 
    		$grid.addRow();
       }else{
       	$(rows).each(function (index, row){
      	    	   if(index == rows.length-1){  
	       	       	 $grid.addRow({ 
	    	       	EV_PERIOD_ID:  this.EV_PERIOD_ID,
	    	       	EV_TYPE_ID:  this.EV_TYPE_ID,
	    	       	EV_PROCESS_ID:  this.EV_PROCESS_ID,
	    	       	EV_PROCESS_SDATE:  this.EV_PROCESS_SDATE, 
	    	       	EV_PROCESS_EDATE:  this.EV_PROCESS_EDATE, 
	    	       	EV_PERCENTAGE:  this.EV_PERCENTAGE, 
	    	       	EV_OPERATE_ID:  this.EV_OPERATE_ID, 
	    	       	DESCRIPTION: this.DESCRIPTION,
	    	       	REMARK: this.REMARK
	       	        }); 
      	    	 }
          });
       }
    } 
    function spf_delete()
    {        
	   	 var row = $grid.getSelectedRow(); 
		 
	     if (!row || row.length == 0) { 
	    	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	    		 return ; 
	     }
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){ 
  
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post('/eva/basicInfo/deleteEvaTypeProcessInfo', 
		                [	
		                 	{ name: 'EV_PERIOD_ID', value: row.EV_PERIOD_ID },
		                 	{ name: 'EV_TYPE_ID', value: row.EV_TYPE_ID },
		                 	{ name: 'EV_PROCESS_ID', value: row.EV_PROCESS_ID }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            { 
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		                {
		                	    $grid.loadData(true);//加载数据 
		                        spf_searchItemInfo(); //加载数据 
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

    //取申请人对应出差申请
  	function spf_getEvaPeriodTypeInfo(){   
  		  var EV_PERIOD_ID = document.getElementById("EV_PERIOD_ID");
  		  if(EV_PERIOD_ID.options[EV_PERIOD_ID.selectedIndex].value == "") return;
  		  var evaPeriodID = EV_PERIOD_ID.options[EV_PERIOD_ID.selectedIndex].value;
  		  
  		 //&callback=?"注意这个是为了解决跨域访问的问题    
  		 $.post('/utility/otherInfo/getEvaPeriodTypeInfo',{"EV_PERIOD_ID": evaPeriodID},function(result){
  			 		spf_setEvaPeriodTypeInfo(result); 
  		 		}
  		 	);  
  	}
  	function spf_getEvaPeriodInfo(){  
  		 //&callback=?"注意这个是为了解决跨域访问的问题    
  		 $.post('/utility/otherInfo/getEvaPeriodInfo',{"EMPID": ''},function(result){
  			 spf_setEvaPeriodInfo(result);spf_setEvaPeriodTypeInfo(result); 
  		 		}
  		 	);  
  	}
  	//设置下拉列表
  	function spf_setEvaPeriodTypeInfo(result){ 
  		
  		clearSel(document.getElementById("EV_TYPE_ID")); //清空城市
  		var EV_TYPE_ID = document.getElementById("EV_TYPE_ID"); 
  		
  		var jsonList = eval("(" + result + ")");
  		
  	    var option = new Option('<spring:message code="hrms.selection"/>',"");
  	    EV_TYPE_ID.options.add(option); 
  		for(var i=0;i<jsonList.length;i++){ 
           　　	var value = "0";var text = "0";  
  		 　　　　for(var key in jsonList[i]){  
  			         　　	if(key == "ID") 
  			         　　		value = jsonList[i][key];  
  			         　　	if(key == "Name") 
  			  			    text = jsonList[i][key];  
  		         　　}  
  		 
  		    option = new Option(text,value);
  		    EV_TYPE_ID.options.add(option); 
  		  }   
  	}  
  	function spf_setEvaPeriodInfo(result){ 
  		var index = "0"; 
  		clearSel(document.getElementById("EV_PERIOD_ID")); //清空城市
  		var EV_PERIOD_ID = document.getElementById("EV_PERIOD_ID"); 
  		
  		var jsonList = eval("(" + result + ")");
  		
  	    var option = new Option('<spring:message code="hrms.selection"/>',"");
  	    EV_PERIOD_ID.options.add(option); 
  		for(var i=0;i<jsonList.length;i++){ 
           　　	var value = "0";var text = "0";  
  		 　　　　for(var key in jsonList[i]){  
  			         　　	if(key == "ID") 
  			         　　		value = jsonList[i][key];  
  			         　　	if(key == "Name") 
  			  			    text = jsonList[i][key];  
  		         　　}  
  		 
  		    option = new Option(text,value);
  		    EV_PERIOD_ID.options.add(option); 
  		  } 
  		spf_getEvaPeriodTypeInfo();
  	}  
  	// 清空下拉列表
  	function clearSel(oSelect){ 
  		while(oSelect.childNodes.length>0){
  		 	oSelect.removeChild(oSelect.childNodes[0]);
  		} 
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
        		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
        		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ORDER": "' + index + '"' ;      
        		             jsonData += '}' ;   
    		             }if(index == indexs + flag){
        		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
        		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ORDER": "' + (index + 1)+ '"' ;      
        		             jsonData += '}' ;   
    		             }if( index == indexs){
        		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
        		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
        		             jsonData += ' "EV_PROCESS_ORDER": "' + (index - 1) + '"' ;      
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
    		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
    		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
    		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
       		             jsonData += ' "EV_PROCESS_ORDER": "' + index + '"' ;      
       		             jsonData += '}' ;   
   		             }if(index == indexs + flag){
    		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
    		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
    		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
       		             jsonData += ' "EV_PROCESS_ORDER": "' + (index - 1)+ '"' ;      
       		             jsonData += '}' ;   
   		             }if( index == indexs){
    		             jsonData += ' "EV_PERIOD_ID": "' + this.EV_PERIOD_ID + '",' ; 
    		             jsonData += ' "EV_TYPE_ID": "' + this.EV_TYPE_ID + '",' ; 
    		             jsonData += ' "EV_PROCESS_ID": "' + this.EV_PROCESS_ID + '",' ; 
       		             jsonData += ' "EV_PROCESS_ORDER": "' + (index + 1) + '"' ;      
       		             jsonData += '}' ;   
   		             }
   	        }); 
    	}
	       
    	jsonData += ']' ; 
   	   
    	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	       $.post("/eva/basicInfo/updateEvaTypeProcessOrderInfo", 
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
	                    spf_searchItemInfo(); //加载数据 
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
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="top">
			<table width="100%" border="0">
				<tr>
					<td height="2"></td>
				</tr>
				<tr>
					<td align="center" valign="middle">
						<table width="99.6%" cellpadding="0" cellspacing="0"
							class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
							<tr>
								<td width="15%" class="l-table-edit-t"><spring:message
										code="hrms.duration" />&nbsp;<spring:message code="hrms.type" /></td>
								<td width="35%" class="l-table-edit-c"><select
									name="EV_PERIOD_ID" id="EV_PERIOD_ID"
									onchange="spf_getEvaPeriodTypeInfo();spf_search();"></select> <select
									name="EV_TYPE_ID" id="EV_TYPE_ID" onchange="spf_search();"></select>
								</td>
								<td width="15%" class="l-table-edit-t"><spring:message
										code="keyWord" /></td>
								<td width="35%" class="l-table-edit-c"><input
									name="keyWord" type="text" id="keyWord" size="30" /></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
		</div>
		<div position="center" id="info"
			title='<spring:message code="hrms.processInfo"/>'></div>
		<div position="right" id="itemInfo"
			title='<spring:message code="hrms.itemInfo"/>'></div>
	</div>
</body>
</html>
