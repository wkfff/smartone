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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
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
 	/*
 	*职位信息弹出框 
 	*/
    $(function (){
		$("#POSTNAME").ligerComboBox({
			onBeforeOpen: spf_selectPost, valueFieldID: 'POST_ID',width:150
		});
	});
	function spf_selectPost(){
		$.ligerDialog.open({ 
			title: '职位信息',
			name:'winselector'+Math.random(),
			width: 800, 
			height: 450, 
			url: '/utility/postInfo/searchPost', 
			buttons: [
						{ text: '<spring:message code="okay"/>', onclick: spf_selectOK },
						{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
						{ text: '<spring:message code="clear"/>', onclick: spf_selectClear }
					]
		});
		return false;
	}
	function spf_selectOK(item, dialog){
		var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
		var data = fn(); 
		if (!data){
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return ;
		}
		$("#POST_ID").val(data.POST_ID);
		$("#POSTNAME").val(data.POST_NAME+'['+data.POST_ID+']');
		dialog.close();
	}
	function spf_selectCancel(item, dialog){
		dialog.close();
	}
	function spf_selectClear(item, dialog){
		$("#POST_ID").val("");
		$("#POSTNAME").val("");
		dialog.close();
	}
    function f_save(){
          $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
          var options = {
              url:'/hrm/org/addDeptQuotaInfo',
              type:'POST',
              success:function (result){
	              $.ligerDialog.closeWaitting();
	              if (result == "Y"){
	                 $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>',
	                	function (){
	                		parent.f_ChildWindowClose();
	              		});
		           }else{
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
			<div align="left">
				<form name="form1" method="post" action="" id="form1">
					<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td class="l-table-edit-t" width="30%"><spring:message code="hrms.post" /></td>
							<td class="l-table-edit-c" width="70%">
								<input type="text" name="POSTNAME" id="POSTNAME" value=""/>
								<input type="hidden" name="POST_ID" id="POST_ID" />
								<input name="DEPTID" type="hidden" id="DEPTID" value="${param.DEPTID }" />
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message code="hrms.quotaNumber" /></td>
							<td class="l-table-edit-c">
								<input id="QUOTA_NUMBER" name="QUOTA_NUMBER" type="text"/></td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message code="hrms.description" /></td>
							<td class="l-table-edit-c">
								<textarea rows="3" cols="50" id="DESCRIPTION" name="DESCRIPTION" ></textarea>
							</td>
						</tr>
					</table>
				</form>
				<table cellpadding="0" cellspacing="0" class="l-table-edit">
					<tr>
						<td colspan="10" height="30px"><a class="l-button"
							style="width: 79px; height: 20px; float: left; margin-left: 1px; "
							onclick="f_save()"><spring:message code="hrms.save" /></a></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
