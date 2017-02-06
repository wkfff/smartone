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
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
 	// 初始调用
    $(function() { 
    	//布局
        $("#layout1").ligerLayout({
        		topHeight: 110,
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            });
    	
    });
    function f_save(){ 
          $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
          var options = {	                        
              url:'/system/rightsSupplierAdminManagement/updateLoginSupplierAdminInfo',
              type:'POST',	                        
              success:function (result){
        	  $.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		                {
		                	parent.f_ChildWindowClose() ;
		                });
		            }
		            else
		            {
		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		            }
		        }
           }; 
        $('#form1').ajaxSubmit(options); 
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
		<div style="border: 1px solid #A3C0E8;">
			<div align="left" >
				<form name="form1" method="post" action="" id="form1">
					<input type="hidden" name="SupplierAdmin_ID" value="${loginSupplierAdminInfo.USERNAME}"/>
					<table width="99.6%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8" style="margin-top: 10px;margin-left: auto;margin-right: auto;">
						<tr>
							<td class="l-table-edit-t"><spring:message
									code="username" /></td> 
							<td class="l-table-edit-c">${loginSupplierAdminInfo.USERNAME}</td>
								<input id="ADMINNO" name="ADMINNO" type="hidden" value="${loginSupplierAdminInfo.ADMINNO}"/>
							<td class="l-table-edit-t"><spring:message
									code="hrms.active" /></td>
							<td class="l-table-edit-c"><SipingSoft:selectStatus
									name="ACTIVITY" selected="${loginSupplierAdminInfo.STATUS_ID}" /></td>
							<td class="l-table-edit-t"><spring:message
									code="hrms.company" /></td>
							<td class="l-table-edit-c">${loginSupplierAdminInfo.SUPPLIER_NAME}</td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message code="hrms.role" /></td>
							<td class="l-table-edit-c" colspan="5" height="80" id='checkBoxTd'>
								<c:forEach
									items="${loginSupplierAdminInfoRolesGroupList}" var="rolesGroup">
									<input type="checkbox" name="SCREEN_GRANT_ID"
										value="${rolesGroup.SCREEN_GRANT_ID}"
										<c:if test="${ rolesGroup.CHECKED == 1}">checked=true</c:if> />${rolesGroup.SCREEN_GRANT_NAME}&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="l-table-edit" width="99.6%">
						<tr>
							<td  height="50px" ><a class="l-button"
								style="width: 79px; height: 20px; margin-left:80%; "
								onclick="f_save()"><spring:message code="hrms.save" /></a> 
								</td>
						</tr>
					</table>
				</form>
			</div>
			
		</div>
	</div>
</body>
</html>
