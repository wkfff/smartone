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

<script src="/resources/js/function.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">  
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
        	topHeight:220,
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
    });
     
    function spf_save(){
    	if (spf_checkData()){
    		//alert($("#WEIGHT").val() * $("#UNIT_PRICE").val());
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/ess/infoApp/addProductionOrderInfo", 
			        [	
			           	{ name: 'PROD_ID', value: $("#PROD_ID").val() },
			            { name: 'DRAWING_NO', value: $("#DRAWING_NO").val() },
			            { name: 'WEIGHT', value: $("#WEIGHT").val() },
			            { name: 'UNIT_PRICE', value: $("#UNIT_PRICE").val() },
			            { name: 'PRO_NO', value: "${paraMap.PRO_NO}" },
			            { name: 'REMARK', value: $("#REMARK").val() },
			            { name: 'QUANTITY', value: $("#WEIGHT").val() * $("#UNIT_PRICE").val() }
			        ]
			       , function (result)
			       {
			       	$.ligerDialog.closeWaitting();
			           if (result == "Y")
			           {
			               $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
			               { 
			               		parent.f_ChildWindowClose() ; //加载数据 
			               });
			           }
			           else
			           {
			               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			           }
			       });
			
    	}
    }
 
    function spf_checkData()
    {    
		var prodId = $("#PROD_ID").val();   
		var drawingNo = $("#DRAWING_NO").val();  
		var weight = $("#WEIGHT").val();  
		var unitPrice = $("#UNIT_PRICE").val();

        if (prodId == null || prodId == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '生产订单号'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if (drawingNo == null || drawingNo == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '物料描述'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
       }  
        if (weight == null || weight == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '重量'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
       }  
        if (unitPrice == null || unitPrice == "") { 
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '单价'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
      }  
        return true; 
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
						<form name="form1" method="post" action="" id="form1">
							<table width="99.6%" cellpadding="1" cellspacing="1"
								style="height: 25px; font-size: 12px;">
								<tr>
									<td width="5%" align="center"><img
										src="/resources/images/title/top_1.gif" /></td>
									<td width="25%" align="left" style="font-weight: bold;">生产订单信息</td>
									<td width="5%" align="right">&nbsp;</td>
									<td align="right" height="30px;">
									 <a	class="l-button"
										style="width: 79px; height: 20px; float: right; margin-left: 10px; "
										onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
								</tr>
							</table>
							<table width="99.6%" cellpadding="0" cellspacing="0"
								class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
								<tr>
									<td width="10%" class="l-table-edit-t">物料编码<font color="red">*</font></td>
									<td width="30%" class="l-table-edit-c"><input
										name="PROD_ID" type="text" id="PROD_ID" size="30" /></td>
								</tr>
								<tr>
									<td width="10%" class="l-table-edit-t">物料描述<font color="red">*</font></td>
									<td width="30%" class="l-table-edit-c"><input
										name="DRAWING_NO" type="text" id="DRAWING_NO" size="30" /></td>
								</tr>
								<tr>
									<td width="10%" class="l-table-edit-t">重量<font color="red">*</font></td>
									<td width="30%" class="l-table-edit-c"><input
										name="WEIGHT" type="text" id="WEIGHT" size="30" /></td>
								</tr>
								<tr>
									<td width="10%" class="l-table-edit-t">单价<font color="red">*</font></td>
									<td width="30%" class="l-table-edit-c"><input
										name="UNIT_PRICE" type="text" id="UNIT_PRICE" size="30" /></td>
								</tr>
								<tr>
									<td width="10%" class="l-table-edit-t"><spring:message
											code="hrms.remarks" /></td>
									<td width="23%" class="l-table-edit-c" colspan="5"><textarea
											rows="" cols="" style="height: 50px; width: 300px"
											id="REMARK" name="REMARK"></textarea></td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
