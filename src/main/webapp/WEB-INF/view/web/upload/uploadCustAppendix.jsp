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
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.validate.min.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js"
	type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
	var $dialog;
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			topHeight : 180,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});

        $("#CUST_NAME").ligerComboBox({
            onBeforeOpen: spf_selectCust
        });
	});
	
/***********************************/
    function spf_selectCust()
    {
        $.ligerDialog.open({ 
        	title: '客户', 
        	name:'custselector',
        	width: 800, 
        	height: 400, 
        	url: '/utility/custInfo/viewCustomerList', 
        	buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectCustOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCustCancel },
                { text: '<spring:message code="clear"/>', onclick: spf_selectCustClear }
        	]
        });
        return false;
    }
    function spf_selectCustOK(item, dialog)
    {
		var fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer; 
        var data = fn(); 
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        }
        $("#CUST_ID").val(data.CUST_ID);
    	$("#CUST_NAME").val(data.CUST_NAME);
        dialog.close();
    }
    function spf_selectCustCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectCustClear(item, dialog)
    {
    	$("#CUST_ID").val("");
    	$("#CUST_NAME").val("");
        dialog.close();
    }
/***********************************/
	
	function f_save() {
		if (spf_checkData()) {
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');

			var options = {
				url : '/upload/fileUpload/uploadCustAppendix',
				type : 'POST',
				success : function(result) {
					$.ligerDialog.closeWaitting();
					if (result == "Y") {
						//TODO: change the viewBasicInfo.jsp page
						$.ligerDialog.success(
								'<spring:message code="hrms.saveSuccess"/>',
								'<spring:message code="hrms.warning"/>',
								function() {
									parent.spf_afterAddOrRemove();
									;
								});
					} else {
						$.ligerMessageBox.error(
								'<spring:message code="hrms.warning"/>',
								'上传失败，原因：' + result);
					}
				}
			};
			$('#custAppendixForm').ajaxSubmit(options);
		}
	}

	function spf_checkData() {
		if ($("#file").val() == null || $("#file").val() == "") {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.file"/>' + ". "
							+ '<spring:message code="input.required"/>');
			return false;
		}
		if ($("#CUST_ID").val() == null || $("#CUST_ID").val() == "") {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'产品编号' + ". " + '<spring:message code="input.required"/>');
			$("#CUST_ID").focus()
			return false;
		}

		/* 文件格式判断  （预留）
		var fileName = $("#file").val();
		var fileType = fileName.substring(fileName.lastIndexOf(".")+1).toLowerCase();       
		var uploadAllowedTypes  = "gif jpg jpeg png doc docx" ;
		if (uploadAllowedTypes.indexOf(fileType)<0 ){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '文件类型必须为 '+uploadAllowedTypes) ; 
		   	 return false;
		} */
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
<body>
	<div id="layout1" style="background-image: url(/resources/images/customer_handshake.jpg)">
		<div position="top">
			<form name="custAppendixForm" method="post" action="" id="custAppendixForm"
				enctype="multipart/form-data">
				<div id="inputID">
					<table width="100%" border="0">
						<tr>
							<td height="20"></td>
						</tr>
						<tr>
							<td valign="middle">
								<table width="99.6%" cellpadding="1" cellspacing="1"
									style="font-size: 12px;">
									<tr>
										<td height="30px;" width="15%" align="center">&nbsp;</td>
										<td height="30px;" width="85" align="left"><input type="file"
											name="file" id="file" height="60px;" style="width: 150px;" /></td> 
									</tr>
									<tr>
										<td height="30px;" align="center">客户名称</td>
										<td width="35%" align="left"  class="l-table-edit-c" style="white-space:nowrap;">
       	     								<input type="text" name="CUST_NAME" id="CUST_NAME" size="20" onClick="spf_selectCust()"/>
       	     								<input type="hidden" name="CUST_ID" id="CUST_ID" size="0"/>
       	     							</td>
									</tr>
									<tr >
										<td height="30px;" align="center">附件备注</td>
										<td height="30px;" align="left" >
										<input type="text" name="REMARK" id="REMARK"/></td>
									</tr>
									<tr>
										<td height="30px;" align="center">&nbsp;</td>
										<td height="30px;" align="left"><a class="l-button"
											style="width: 79px; height: 20px; float: left; margin-left: 1px; "
											onclick="f_save()"><spring:message code="hrms.save" /></a></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
