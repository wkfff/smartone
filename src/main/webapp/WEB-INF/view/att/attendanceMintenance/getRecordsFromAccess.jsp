<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" CONTENT="no-cache">
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Expires" CONTENT="0">
<!--CSS-->
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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	function spf_empInfoTemplateDownload(){
		location.href = "/att/attendanceMintenance/downloadRecordsInfoTemplate";
	}
	function spf_empInfoTemplateUpload(){
		$dialogUpload = $.ligerDialog.open({
			isDrag:false,
			title:'<spring:message code="hrms.uploadFile"/>',
			width:350,
			height:260,
			url:'/att/attendanceMintenance/uploadAttMacRecords'
		});}
</script>
<style type="text/css">
body {
	padding:10px;
	margin:0;
	padding-bottom:15px;
}
#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<table style="height: 100%;background-image: url(/resources/images/background.jpg)"
	 width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit" border="0xp" bordercolor="#A3C0E8">
		<tr style="height: 20%">
			<td>
				<div style="height: 9px"></div>
				<div style="padding-left: 30%;">
				<img style="cursor: pointer;" src="/resources/images/excel.png" alt="<spring:message code="hrms.clicHhereToDownloadTheTemplate"/>" onclick="spf_empInfoTemplateDownload();" >
				</div></td>
			<td>
				<div style="padding-right: 50%;">
				<img style="cursor: pointer;" src="/resources/images/upload.png" alt="<spring:message code="hrms.clickUploadFile"/>" onclick="spf_empInfoTemplateUpload();" >
				</div></td>	
		</tr>
		<tr style="height: 10%">
			<td><a 
				style="cursor: pointer;padding-left: 37%;"
				onclick="spf_empInfoTemplateDownload()"><big><spring:message code="hrms.toDownloadTheTemplate"/></big></a></td>
			<td><a 
				style="cursor: pointer;padding-left: 7%;"
				onclick="spf_empInfoTemplateUpload()"><big><spring:message code="hrms.selectionOfPunchRecordFile"/></big></a></td>
		</tr>
		<tr style="min-height: 335px; height: 335px;"></tr>
	</table>
</body>
</html>
