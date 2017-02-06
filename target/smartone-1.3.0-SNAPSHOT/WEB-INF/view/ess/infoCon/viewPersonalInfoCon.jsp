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

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

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
			            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},  
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},  
			            { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_NAME', width: 90}, 
			            { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90}, 
			            { display: '<spring:message code="hrms.applicationContent"/>', name: 'START_DATE', width: 120,
			            	render: function (item)
		                    { 
		                        return '<a style="cursor: pointer;color: purple;"><spring:message code="hrms.details"/></a>';
		                    } 
			            },  
			            { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 120},  
			            { display: '<spring:message code="hrms.confirmationActive"/>', name: 'CON_STATUS', width: 120,
			            	render: function (item)
		                    { 
		                        if(item.CON_STATUS_ID == 0){  
			        	        	return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="spf_reject(2,4);" >' + '&nbsp;&nbsp;&nbsp;&nbsp;' + '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="spf_approve(1,4)" >';
			            	    } else{
			            	    	return item.CON_STATUS;
			            	    }
		                    } 
			            },   
			            { display: '<spring:message code="hrms.confirmationRemarks"/>', name: 'REMARK', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.cancelRemarks"/>', name: 'CANCEL_REMARK', align: 'left', width: 120,
			            	editor: { type: 'textarea', height: 100 }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers: true,
            url: '/ess/viewApp/getPersonalInfoList',
            parms: [	
                   	{ name: 'ACTIVITY',value: $("#ACTIVITY").attr('value')}
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
           	 	spf_showDetailData(rowdata.EMPID);
            }
        });
    }
    function spf_showDetailData(empID)
    {  
		  $dialog = $.ligerWindow.show({isDrag: true,
			    title: '<spring:message code="hrms.details"/>',
	      	 	width: 800 , 
	      	 	height: 400 , 
	      	 	left:120,top:80,
	  		    url: '/ess/viewApp/viewPersonalInfo?EMPID='+empID
	      }); 
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
		                        	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
		                        	{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
		                        	{ name: 'E_DATE', value: $("#E_DATE").attr('value')}, 
		                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    
    function spf_reject(flag,tag){ 
    	spf_approve(flag,tag);
    }
    function spf_approve(flag,tag)
    {     
    	 
        var	rows = $grid.getCheckedRows(); 

   	    var jsonData = '' ;
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        } 
        $.ligerDialog.confirm('<spring:message code="hrms.whetherRemark"/>','<spring:message code="hrms.warning"/>', function (yes)
   	    {
   		   if(yes){
   	    	    jsonData = '[' ;
	   			$(rows).each(function (index, row)
	   	             {  
	   		    	   if(this.CON_STATUS_ID == null || this.CON_STATUS_ID == '1' || this.CON_STATUS_ID == '2' || this.CON_STATUS_ID == '3'){ 
	   			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotRepeat"/>') ; 
	   			       		 return false;  
	   		           }else{ 
	   		        	    
	   			    	   if(this.REMARK == null || this.REMARK == '' || this.REMARK == 'undefined' ){ 
	   		    	       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.confirmationRemarks"/>'  +". " + '<spring:message code="input.required"/>') ; 
	   		    	       		 return false;  
	   			           }else{
	   				   		     if (jsonData.length > 1){
	   					             	jsonData += ',{' ;
	   				             }
	   				             else{
	   				             	jsonData += '{' ;
	   				             } 
	   				             jsonData += ' "EMPID": "' + this.EMPID + '", ' ; 
	   				             jsonData += ' "ACTIVITY": "' + flag + '", ' ; 
	   				             jsonData += ' "REMARK": "' + this.REMARK + '"' ; 
	   				             jsonData += '}' ;
	   			           }
	   		           } 
	   	        });  
	   	    	jsonData += ']' ;
   	    	    
	   	     	var jsonList = eval("(" + jsonData + ")");
	   	    	  
	   	    	if(jsonData.length == 2 || jsonData.length == 0){ 
	   	            return ;
	   	        }if(jsonList.length == rows.length){ 
	   	            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	   	            $.post("/ess/infoCon/confirmApp", 
	   	                    [	
	   	                     	{ name: 'jsonData', value: jsonData },
	   	                     	{ name: 'appType', value: 'perInfo' }
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
   		   }else{
  	    	    jsonData = '[' ;
	   			$(rows).each(function (index, row)
	   	             { 
	   		    	   if(this.CON_STATUS_ID == null || this.CON_STATUS_ID == '1' || this.CON_STATUS_ID == '2' || this.CON_STATUS_ID == '3'){ 
	   			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotRepeat"/>') ; 
	   			       		 return false;  
	   		           }else{    
	   				   		     if (jsonData.length > 1){
	   					             	jsonData += ',{' ;
	   				             }
	   				             else{
	   				             	jsonData += '{' ;
	   				             } 
	   				             jsonData += ' "EMPID": "' + this.EMPID + '", ' ; 
	   				             jsonData += ' "ACTIVITY": "' + flag + '", ' ; 
	   				             jsonData += ' "REMARK": ""' ; 
	   				             jsonData += '}' ; 
	   		           } 
	   	        }); 
	   	    	jsonData += ']' ;
   	    	    
	   	     	var jsonList = eval("(" + jsonData + ")");
  	    	    
	   	    	if(jsonData.length == 2 || jsonData.length == 0){ 
	   	            return ;
	   	        }
	   	    	if(jsonList.length == rows.length){ 
	   	            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	   	            $.post("/ess/infoCon/confirmApp", 
	   	                    [	
	   	                     	{ name: 'jsonData', value: jsonData },
	   	                     	{ name: 'appType', value: 'perInfo' }
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
   		   }
   	    });  
    }
    function spf_delete()
    {          

         var	rows = $grid.getCheckedRows(); 
    	 
         if (!rows || rows.length == 0) { 
        	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	 return ; 
        } 
        jsonData = '[' ;
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
	   			$(rows).each(function (index, row)
	   	             {  
			   		     if (jsonData.length > 1){
				             	jsonData += ',{' ;
			             }
			             else{
			             	jsonData += '{' ;
			             } 
			             jsonData += ' "EMPID": "' + this.EMPID + '"' ;  
			             jsonData += '}' ;  
	   	        }); 
	   	    	jsonData += ']' ;

		         if (jsonData.length == 2) { 
		        	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        } 
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post('/ess/infoCon/delApp', 
		                [	
		                 	{ name: 'jsonData', value: jsonData },
   	                     	{ name: 'appType', value: 'perInfo' }
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
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.dept" /></td>
						<td width="35%" class="l-table-edit-c"><SipingSoft:deptTree
								name="DEPTID" limit="hr" /></td>
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message
								code="hrms.applicationDate" /></td>
						<td class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
						<td class="l-table-edit-t"><spring:message
								code="hrms.confirmationActive" /></td>
						<td class="l-table-edit-c"><SipingSoft:selectConStatus
								name="ACTIVITY" limit="all" selected="0"
								onChange="spf_search();" remove="4," /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <SipingSoft:buttonCon />
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
