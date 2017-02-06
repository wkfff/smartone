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
			            { display: '', name: 'APPLY_NO', width: 10,hide: 1},
			            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90,
							render: function (item)
		                    {    
								var attDate = "'"+item.AR_DATE_STR+"'";
								var empID = "'"+item.EMPID+"'";
		        	        	return '<a onclick="spf_reviewLeave(' + attDate + ',' + empID + ');" style="cursor: pointer;color: purple;">'+ item.EMPID +'</a>';		            	     
		                    } 
						},
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},  
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},  
			            { display: '<spring:message code="hrms.attendanceDate"/>', name: 'ATT_DATE', width: 100,
							render: function (item)
		                    {    
								var attDate = "'"+item.ATT_DATE+"'";
								var empID = "'"+item.EMPID+"'";
		        	        	return '<a onclick="spf_reviewShift(' + attDate + ',' + empID + ');" style="cursor: pointer;color: purple;">'+ item.ATT_DATE +'</a>';		            	     
		                    } 
						},
						{ display: '<spring:message code="hrms.inOrOutMarking"/>', name: 'CARD_DOOR_TYPE_NAME', width: 100},  
						{ display: '<spring:message code="hrms.time"/>', name: 'R_TIME', width: 120},     
			            { display: '<spring:message code="hrms.reason"/>', name: 'CARD_REASON_NAME', width: 90},  
			             
			            { display: '<spring:message code="hrms.remarks"/>', name: 'CARD_REMARK', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 120},  
			            { display: '<spring:message code="hrms.confirmationActive"/>', name: 'CON_STATUS', width: 120,
			            	render: function (item)
		                    { 
		                        if(item.CON_STATUS_ID == 0 && item.APP_STATUS_ID == 1){  
			        	        	return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="spf_reject(2,4);" >' + '&nbsp;&nbsp;&nbsp;&nbsp;' + '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="spf_approve(1,4)" >';
			            	    } else{
			            	    	return item.CON_STATUS;
			            	    }
		                    } 
			            },   
			            { display: '<spring:message code="hrms.confirmationRemarks"/>', name: 'CON_REMARK', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.cancelRemarks"/>', name: 'CANCEL_REMARK', align: 'left', width: 120,
			            	editor: { type: 'textarea', height: 100 }
			            }
			            
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ess/viewApp/getCardtimeInfo',
            parms: [	
                   	{ name: 'ACTIVITY',value: $("#ACTIVITY").attr('value')},
                	{ name: 'qryType', value: $("#qryType").attr('value')} 
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
           	 	spf_showDetailData(rowdata.APPLY_NO);
            }
        });
    }
    function spf_showDetailData(applyNo)
    {    
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.approvalActive"/>', 
    		width: 700, 
    		height: 320, 
  		    url: '/ess/viewApp/viewApproverInfo?PAGE=B&FLAG=0&APPLY_TYPE=CardtimeApply&APPLY_NO='+applyNo
       	  });
    }
    function spf_reviewLeave(attDate,empID)
    {   
     	$dialog = $.ligerDialog.open({isDrag: false, 
     		title:'<spring:message code="hrms.leaveDetail"/>', 
     		width: 1000, 
     		height: 200, 
     		url: '/ess/infoApp/viewEmpLeaveInfo?LEAVE_FROM_TIME=' + attDate +'&EMPID='+empID
        });
    	  
    }
    function spf_reviewShift(attDate,empID)
    {   
     	$dialog = $.ligerDialog.open({isDrag: false, 
     		title:'<spring:message code="hrms.workingShift.information"/>', 
     		width: 800, 
     		height: 200, 
     		url: '/ess/infoApp/searchEmpShift?OT_DATE=' + attDate +'&EMPID='+empID
        });
    	  
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
		                        	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
		                        	{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
		                        	{ name: 'E_DATE', value: $("#E_DATE").attr('value')},  
		                        	{ name: 'CARD_REASON_CODE', value: $("#CARD_REASON_CODE").attr('value')}, 
		                        	{ name: 'qryType', value: $("#qryType").attr('value')}, 
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
		   	           if(this.APP_STATUS_ID == '0' ){ 
	 			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.waitingApproval"/>') ; 
	 			       		 return false;  
	 		           }
	   		    	   if(this.APP_STATUS_ID == null || this.CON_STATUS_ID == null || this.APP_STATUS_ID == '2' || this.CON_STATUS_ID == '1' || this.CON_STATUS_ID == '2'|| this.CON_STATUS_ID == '3'){ 
	   			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotRepeat"/>') ; 
	   			       		 return false;  
	   		           }else{ 
	   		        	    
	   			    	   if(this.CON_REMARK == null || this.CON_REMARK == '' || this.CON_REMARK == 'undefined' ){ 
	   		    	       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.confirmationRemarks"/>'  +". " + '<spring:message code="input.required"/>') ; 
	   		    	       		 return false;  
	   			           }else{
	   				   		     if (jsonData.length > 1){
	   					             	jsonData += ',{' ;
	   				             }
	   				             else{
	   				             	jsonData += '{' ;
	   				             } 
	   				             jsonData += ' "APPLY_NO": "' + this.APPLY_NO + '", ' ; 
	   				             jsonData += ' "ACTIVITY": "' + flag + '", ' ; 
	   				             jsonData += ' "APPLY_TYPE": "CardtimeApply", ' ; 
	   				             jsonData += ' "CON_REMARK": "' + this.CON_REMARK + '"' ; 
	   				             jsonData += '}' ;
	   			           }
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
	   	                     	{ name: 'appType', value: 'CardtimeInfo' }
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
	   				             jsonData += ' "APPLY_NO": "' + this.APPLY_NO + '", ' ; 
	   				             jsonData += ' "ACTIVITY": "' + flag + '", ' ; 
	   				             jsonData += ' "APPLY_TYPE": "CardtimeApply", ' ; 
	   				             jsonData += ' "CON_REMARK": ""' ; 
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
	   	                     	{ name: 'appType', value: 'CardtimeInfo' }
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
			             jsonData += ' "APPLY_NO": "' + this.APPLY_NO + '", ' ;  
			             jsonData += ' "EMPID": "' + this.EMPID + '", ' ;  
			             jsonData += ' "APPLY_TYPE": "CardtimeApply" ' ;  
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
   	                     	{ name: 'appType', value: 'CardtimeInfo' }
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
								name="DEPTID" limit="ar" /></td>
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message
								code="hrms.attendanceDate" /></td>
						<td class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
						<td class="l-table-edit-t"><spring:message
								code="hrms.approvalActive" /></td>
						<td class="l-table-edit-c"><SipingSoft:selectAppStatus
								name="qryType" limit="all" selected="1" onChange="spf_search();" />
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message code="hrms.reason" /></td>
						<td class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="cardtimeReason" name="CARD_REASON_CODE"
								onChange="spf_search();" limit="all" /></td>
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
