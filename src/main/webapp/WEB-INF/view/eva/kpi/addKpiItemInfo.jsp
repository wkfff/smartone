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
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>

<script type="text/javascript">
	var flag = true;
	var initString = "";
	function f_save(){
		if($("#EVA_KPI_NAME").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.pleaseFill"/>') ;
			return ;
		}
		if($("#KPI_STANDARD").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.PleaseStandards"/>') ;
			return ;
		}
		if($("#KPI_DEFINE").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.PleaseIndicators"/>') ;
			return ;
		}
		if($("#CAL_DES").val() == ""){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.PleaseCalculation"/>') ;
			return ;
		}
		if(flag){
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			var options = {
				url:'/eva/kpi/addKpiItemInfo',
				type:'POST',
				success: function (result){
						$.ligerDialog.closeWaitting();
						if (result == "Y"){
							$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
								spf_clear();
								parent.f_ChildWindowClose() ;
							});
						}else{
							$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
						}
					}
				};
			var define = ""+$("#KPI_DEFINE").val();
			var des = ""+$("#CAL_DES").val();
			$("#KPI_DEFINE").text(define.replace(/\n/g,""));
			$("#CAL_DES").text(des.replace(/\n/g,""));
			$('#form1').ajaxSubmit(options);
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.theExists"/>');
		}
	}
	//用于查询该指标名是否存在
	function checkKpiName(){
		//initString用于保存指标输入框值，如果值不改变，则无需失去焦点时查询数据库核对，减少消耗。
		var kpiName = $("#EVA_KPI_NAME").val();
		if(kpiName!="" && kpiName!=initString){
			$.ajax({
				type : 'post',
				url : '/eva/kpi/getKpiItemCount?isExistKpiName='+kpiName,
				dataType : 'json',
				async : false,
				success : function(result) {
					if(result == "Y"){
						$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.theExists"/>');
						flag = false;
					}else{
						flag = true;
					}
				},
				error : function(){
					$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', 'Send Errow') ;
					flag = false;
				}
			});
		}
		initString = $("#EVA_KPI_NAME").val();
	}
	
	function spf_clear(){
		$("#form1 input[id!='EVA_TYPE_ID']").val("");
		$("#form1 textarea").val("");
		initString = "";
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
				<input name="EVA_TYPE_ID" type="hidden" id="EVA_TYPE_ID" value="${paraMap.EVA_TYPE_ID}"/>
				<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message code="eva.assessmentCategory"/></td>
						<td width="35%" class="l-table-edit-c">
							<input type="text" name="EVA_KPI_NAME" id="EVA_KPI_NAME" value="" onblur="checkKpiName()"
							ltype="text"/>
						</td>
						<td width="15%" class="l-table-edit-t"><spring:message code="eva.appraisalStandards"/></td>
						<td width="35%" class="l-table-edit-c">
							<input type="text" name="KPI_STANDARD" id="KPI_STANDARD" value="" 
							ltype="text"/>
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message code="eva.definition"/></td>
						<td class="l-table-edit-c" colspan="3"> 
							<textarea cols="100" rows="4" name="KPI_DEFINE" id="KPI_DEFINE" style="width:99%" ></textarea>
						</td> 
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message code="eva.calculation1"/></td>
						<td class="l-table-edit-c" colspan="3"> 
							<textarea cols="100" rows="4" name="CAL_DES" id="CAL_DES" style="width:99%" ></textarea>
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
