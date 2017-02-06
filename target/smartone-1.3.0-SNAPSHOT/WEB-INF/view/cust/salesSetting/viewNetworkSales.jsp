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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $salarygrid = null ; 
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
        $("#actionlayout").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
        f_initGrid(); 
    });
 
    function f_initGrid()
    {
    	
    	$salarygrid = $("#networkSalesInfo").ligerGrid({
    		//checkbox: true,   	
     		onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
                },
    		columns: [
			            { display: '', name: 'NETWORK_SALES_SALARY_ID', width: 0,hide: 1},
			            { display: '提成比例', name: 'PERCENTAGE', width: 90,editor: { type: 'text' }},
			            { display: '开始时间', name: 'BEGIN_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
			            { display: '结束时间', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }}
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/sales/salesSetting/getNetworkSalesList',
            parms: [
                   ],
            width: '99.6%', height: '100%'
            });
    }
    
	function spf_save()
    {
    	 var jsonData = '[' ; 
    	 var flag = 0;
    	 var rows = $salarygrid.getData(); 
    	 
    	 //alert(JSON2.stringify(rows));
       $(rows).each(function (index, row)
             {
	    	   if(this.__status != null && (this.__status == 'add'||this.__status == 'update')){
	    		   
	    		   if(this.PERCENTAGE == null || this.PERCENTAGE == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '提成比例'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
	    		   if(isNaN(this.PERCENTAGE)){
	    			   $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '提成比例应为数字') ; 
	    		       	 flag =1;
	    		       	 return ;
	    		   }
	    		   if(this.BEGIN_DATE == null || this.BEGIN_DATE == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '开始时间'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
					if (jsonData.length > 1){
						jsonData += ',{' ;
					}
					else{
						jsonData += '{' ;
					}
					jsonData += ' "__status": "' + this.__status + '", ' ;
					jsonData += ' "NETWORK_SALES_SALARY_ID": "' + this.NETWORK_SALES_SALARY_ID + '", ' ;
					jsonData += ' "BEGIN_DATE": "' + MyToDate(this.BEGIN_DATE) + '", ' ;
					jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
					jsonData += ' "PERCENTAGE": "' + this.PERCENTAGE + '" ' ;
					jsonData += '}' ; 
	    	}
					
        });
		jsonData += ']' ;
    	 if(flag==1)
			return;
	       $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
	       $.post("/sales/salesSetting/transferNetworkSales", 
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
	                    $salarygrid.loadData(true); //加载数据  
	               });
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	               $salarygrid.loadData(true); //加载数据  
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

#actionlayout {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="actionlayout">
		<div position="center" id='' title=' '>
			<div position="top">
			<input type="hidden" name = "ADMIN_ID" id = "ADMIN_ID" value = "${admin.adminID}">
			<input type="hidden" name = "ADMIN_NAME" id = "ADMIN_NAME" value = "${admin.chineseName}">
				
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='networkSalesInfo'></div>
		</div>
	</div>
</body>
</html>
