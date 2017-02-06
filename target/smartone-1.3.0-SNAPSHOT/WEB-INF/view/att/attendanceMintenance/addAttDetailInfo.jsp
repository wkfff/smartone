<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >
	<!-- CSS -->
	<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
	<!-- JS -->
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>

<script type="text/javascript">

var $dialog ;
function searchEmp(){ 
	$dialog = $.ligerDialog.open({isDrag: false,
		title:'<spring:message code="employee.information"/>',
		width: 800, height: 400, 
		url: '/utility/empInfo/viewHrSearchEmployee'
	});
}

function spf_initSelectEmpInfo(data){ 
	$("#EMPID").attr("value", data.EMPID) ;
	$("#deptName").html(data.DEPTNAME) ;
	$("#chineseName").html(data.CHINESENAME) ;
	$("#englishName").html(data.ENGLISHNAME) ;
	$dialog.close() ;
}

	function f_save(){
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		var options = {
			url:'/att/attendanceMintenance/addAttDetailInfo',
			type:'POST',
			success: function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						parent.f_ChildWindowClose() ;
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
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99%;margin:0; padding:0;}
</style>
</head>
<body style="padding:0px" > 
	<div id = 'layout1'>
		<form name="form1" method="post" action="" id="form1">
			<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.empid"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<input type="text" name="EMPID" id="EMPID" value="" 
							ltype="text"  validate="{required:true}" onclick="searchEmp();"/>
					</td> 
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<div id="deptName"></div>
					</td>
				</tr>
				<tr>
					<td class="l-table-edit-t">  
						<spring:message code="hrms.attendanceItem"/></td>
					<td class="l-table-edit-c">
						<SipingSoft:select name="AR_ITEM_NO" dataListName="itemList"/>
					</td>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
					<td width="35%" class="l-table-edit-c">
						<div id="chineseName"></div>
					</td>
				</tr>
				<tr>
					<td class="l-table-edit-t">
						<spring:message code="hrms.attendanceDate"/></td>
					<td class="l-table-edit-c">
						<input type="text" name="AR_DATE_STR" id="AR_DATE_STR" 
								value="" size="30"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy/MM/dd'})"  
								ltype="text"  validate="{required:true}" readonly="readonly"/>  
					</td>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<div id="englishName"></div>
					</td>
				</tr>
				<tr>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.startedTime"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<input type="text" name="FROM_TIME" id="FROM_TIME" 
								value="" size="30"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"  
								ltype="text"  validate="{required:true}" readonly="readonly"/>  
					</td>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.endTime"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<input type="text" name="TO_TIME" id="TO_TIME" 
								value="" size="30"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"  
								ltype="text"  validate="{required:true}" readonly="readonly"/>  
					</td>
				</tr>
				<tr>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.quantity"/></td>
					<td width="35%" class="l-table-edit-c">  
						<input type="text" name="QUANTITY" id="QUANTITY" value=""
								ltype='spinner' ligerui="{type:'float'}" validate="{required:true}" />
					</td>
					<td width="15%" class="l-table-edit-t"><spring:message code="hrms.unit"/></td>
					<td width="35%" class="l-table-edit-c"> 
						<SipingSoft:selectSyCode parentCode="ItemUnit" name="UNIT" remove="DAY,"/>
					</td>
				</tr>
				<tr>
					<td class="l-table-edit-cc" colspan="4" height="30px">  
						<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>
					</td>
				</tr>
			</table> 
		</form>
	</div>
</body>
</html>
