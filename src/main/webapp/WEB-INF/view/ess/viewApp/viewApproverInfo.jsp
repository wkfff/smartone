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
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    
    var $grid ;
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
        spf_initGrid();
    });
    
    function spf_initGrid()
    {
    	$grid = $("#affirmorInfo").ligerGrid({
    	 checkbox: false,   
            columns: [ 
            { display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',hide:1,width: 10},
            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120},
            { display: '<spring:message code="hrms.approvalLevel"/>', name: 'AFFIRM_LEVEL', width: 120},
            { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 120,
            	render: function (item)
                { 
                    if(item.APP_STATUS_ID == 0 && item.AFFIRM_FLAG == 1 && ${paraMap.FLAG} == 1 && item.PAGE_FALGE == 'A'){  
        	        	return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="spf_reject(2,4);" >' + '&nbsp;&nbsp;&nbsp;&nbsp;' + '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="spf_approve(1,4)" >';
            	    } else{
            	    	return item.APP_STATUS;
            	    }
                } 
            },
            
            { display: '<spring:message code="hrms.approvalRemarks"/>', name: 'APP_REMARK', align: 'left', width: 250,
            	editor: { type: 'textarea', height: 100 }
            }
            ],
            usePager: false, rownumbers:true, enabledEdit: true,
            url: '/ess/viewApp/getAffirmorList?applyType=${paraMap.APPLY_TYPE}&applyNo=${paraMap.APPLY_NO}&page=${paraMap.PAGE}',
			 
            width: '99%', height: '99%'
        });
    }

    function spf_reject(flag,tag){ 
    	spf_approve(flag,tag);
    }
    function spf_approve(flag,tag)
    {     
    	 
        $.ligerDialog.confirm('<spring:message code="hrms.whetherRemark"/>','<spring:message code="hrms.warning"/>', function (yes)
   	    {
   		   if(yes){

	   	        var	rows = $grid.getSelectedRow(); 
	
	   	   	    var jsonData = '' ;
	   	        if (!rows || rows.length == 0) { 
	   	       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   	       		 return ; 
	   	        } 
   	    	    jsonData = '[' ;
	   			$(rows).each(function (index, row)
	   	             {  
	   		    	   if(this.APP_STATUS_ID == null || this.APP_STATUS_ID == '1' || this.APP_STATUS_ID == '2' || this.APP_STATUS_ID == '3'){ 
	   			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotRepeat"/>') ; 
	   			       		 return ;  
	   		           }else{ 
	   		        	    
	   			    	   if(this.APP_REMARK == null || this.APP_REMARK == '' || this.APP_REMARK == 'undefined' ){ 
	   		    	       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.approvalRemarks"/>'  +". " + '<spring:message code="input.required"/>') ; 
	   		    	       		 return ;  
	   			           }else{
	   				   		     if (jsonData.length > 1){
	   					             	jsonData += ',{' ;
	   				             }
	   				             else{
	   				             	jsonData += '{' ;
	   				             } 
	   				             jsonData += ' "ESS_AFFIRM_NO": "' + this.ESS_AFFIRM_NO + '", ' ; 
	   				             jsonData += ' "APPLY_NO": "${paraMap.APPLY_NO}", ' ; 
	   				             jsonData += ' "APPLY_TYPE": "${paraMap.APPLY_TYPE}", ' ; 
	   				             jsonData += ' "AFFIRM_FLAG": "' + flag + '", ' ; 
	   				             jsonData += ' "APP_REMARK": "' + this.APP_REMARK + '"' ; 
	   				             jsonData += '}' ;
	   			           }
	   		           } 
	   	        });  
	   	    	jsonData += ']' ;
	   	    	  
	   	    	if(jsonData.length == 2 || jsonData.length == 0){ 
	   	            return ;
	   	        }else{ 
	   	            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	   	            $.post("/ess/affirmApp/affirmApp", 
	   	                    [	
	   	                     	{ name: 'jsonData', value: jsonData },
	   	                     	{ name: 'appType', value: 'OtInfo' }
	   	                    ]
	   	            , function (result)
	   	            {
	   	            	$.ligerDialog.closeWaitting();
	   	                if (result == "Y")
	   	                {
	   	                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	   	                    {
	   	                       	$grid.loadData(true); //加载数据  
				               	parent.f_ChildWindowClose() ;//加载数据  
	   	                    });
	   	                }
	   	                else
	   	                {
	   	                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	   	                }
	   	            });
	   	        }
   		   }else{

	   	        var	rows = $grid.getSelectedRow(); 
	
	   	   	    var jsonData = '' ;
	   	        if (!rows || rows.length == 0) { 
	   	       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   	       		 return ; 
	   	        } 
   			    jsonData = '[' ;
	   			$(rows).each(function (index, row)
	   	             { 
	   		    	   if(this.CON_STATUS_ID == null || this.CON_STATUS_ID == '1' || this.CON_STATUS_ID == '2' || this.CON_STATUS_ID == '3'){ 
	   			       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotRepeat"/>') ; 
	   			       		 return ;  
	   		           }else{    
	   				   		     if (jsonData.length > 1){
	   					             	jsonData += ',{' ;
	   				             }
	   				             else{
	   				             	jsonData += '{' ;
	   				             } 
	   				             jsonData += ' "ESS_AFFIRM_NO": "' + this.ESS_AFFIRM_NO + '", ' ; 
	   				             jsonData += ' "APPLY_NO": "${paraMap.APPLY_NO}", ' ; 
	   				             jsonData += ' "APPLY_TYPE": "${paraMap.APPLY_TYPE}", ' ; 
	   				             jsonData += ' "AFFIRM_FLAG": "' + flag + '", ' ; 
	   				             jsonData += ' "APP_REMARK": ""' ; 
	   				             jsonData += '}' ; 
	   		           } 
	   	        }); 
	   	    	jsonData += ']' ;
  	    	    
	   	    	if(jsonData.length == 2 || jsonData.length == 0){ 
	   	            return ;
	   	        }else{ 
	   	            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	   	            $.post("/ess/affirmApp/affirmApp", 
	   	                    [	
	   	                     	{ name: 'jsonData', value: jsonData },
	   	                     	{ name: 'appType', value: 'OtInfo' }
	   	                    ]
	   	            , function (result)
	   	            {
	   	            	$.ligerDialog.closeWaitting();
	   	                if (result == "Y")
	   	                {
	   	                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	   	                    {
	   	                       	$grid.loadData(true); //加载数据  
				               	parent.f_ChildWindowClose() ;//加载数据  
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
	</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
	<div id="layout1" id='' title=' '>
		<div position="center" id='' title=' ' style="border: 0px;">

			<!-- <br/>
		 <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
			<tr>
				<td width="30%" align="left">
					&nbsp;
				</td>
				<td width="15%" align="left">
					<img src="/resources/images/workflow/group.png"/>
				</td>
				<td width="15%" align="left">
					<img src="/resources/images/workflow/arrow_right.png"/>
				</td>
				<td width="15%" align="left">
					<img src="/resources/images/workflow/group.png"/>
				</td>
				<td width="25%" align="left">
					&nbsp;
				</td>	 									    
			</tr> 
		</table> 
		<br/> -->
			<div id="affirmorInfo"></div>
		</div>
	</div>
</body>
</html>
