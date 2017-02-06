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
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <%@ include file="/resources/js/pcc.jsp"%>
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
	var $grid ;
	var $dialog ;
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
//        getIdCardProvince('${personalInfo.IDCARD_PROVINCE}','${personalInfo.IDCARD_CITY}','${personalInfo.IDCARD_AREA}');
        //getHomeProvince('${personalInfo.HOME_PROVINCE}','${personalInfo.HOME_CITY}','${personalInfo.HOME_AREA}');
	});
 	// 初始调用 
    function spf_save() { 
    	if(spf_checkData()){ 
	 		      
             $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
             $.post("/hrm/empinfo/updateEmpInfo", 
                     [
    					{ name: 'EMPID', value: $("#EMPID").val()},
                      	{ name: 'GENDER_CODE', value: $("#GENDER_CODE").val()},
                      	{ name: 'NATION_CODE', value: $("#NATION_CODE").val()},
                      	{ name: 'NATIONALITY_CODE', value: $("#NATIONALITY_CODE").val()},
                      	{ name: 'BORNPLACE_CODE', value: $("#BORNPLACE_CODE").val()},
                      	{ name: 'POLITY_CODE', value: $("#POLITY_CODE").val()},
                      	{ name: 'BIRTHDAY', value: $("#BIRTHDAY").val()},
                      	{ name: 'EDU_HIS_CODE', value: $("#EDU_HIS_CODE").val()},
                      	{ name: 'DEGREE_CODE', value: $("#DEGREE_CODE").val()},
                      	{ name: 'MAJOR_CODE', value: $("#MAJOR_CODE").val()},
                      	{ name: 'IDCARD_NO', value: $("#IDCARD_NO").val()},
                      	{ name: 'MARITAL_STATUS_CODE', value: $("#MARITAL_STATUS_CODE").val()},
                      	{ name: 'HOME_PROVINCE', value: $("#HOME_PROVINCE").val()},
                      	{ name: 'HOME_CITY', value: $("#HOME_CITY").val()},
                      	{ name: 'HOME_AREA', value: $("#HOME_AREA").val()},
                      	{ name: 'HOME_ADDRESS', value: $("#HOME_ADDRESS").val()},
                      	{ name: 'IDCARD_POSTALCODE', value: $("#IDCARD_POSTALCODE").val()},
                      	{ name: 'CELLPHONE', value: $("#CELLPHONE").val()},
                      	{ name: 'HOME_PHONE', value: $("#HOME_PHONE").val()},
                      	{ name: 'OFFICE_PHONE', value: $("#OFFICE_PHONE").val()},
                      	{ name: 'FAX', value: $("#FAX").val()},
                      	{ name: 'P_EMAIL', value: $("#P_EMAIL").val()},
                      	{ name: 'C_EMAIL', value: $("#C_EMAIL").val()},
                      	{ name: 'WORKAGE', value: $("#WORKAGE").val()},
                      	{ name: 'SHIFT_CODE', value: $("#SHIFT_CODE").val()},
                      	{ name: 'FILE_RELATION_CODE', value: $("#FILE_RELATION_CODE").val()},
                      	{ name: 'FILE_RELATION_ADDRESS', value: $("#FILE_RELATION_ADDRESS").val()},
                      	{ name: 'SSN', value: $("#SSN").val()},
                      	{ name: 'HAFN', value: $("#HAFN").val()},
                      	{ name: 'SI_REMARK', value: $("#SI_REMARK").val()},
                      	{ name: 'FUND_REMARK', value: $("#FUND_REMARK").val()},
                      	{ name: 'ADDED_INFOR1', value: $("#ADDED_INFOR1").val()},
                      	{ name: 'ADDED_INFOR2', value: $("#ADDED_INFOR2").val()},
                      	{ name: 'PT_ID', value: $("#PT_ID").val()}
                      ],
             function (result){
             	$.ligerDialog.closeWaitting();
                 if (result == "Y"){
                     $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
			             parent.f_ChildWindowClose() ;
                     });
                 }else{
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
                 }
             });
    	}
     }
	function spf_checkData(){
		if ($("#IDCARD_NO").val() == null || $("#IDCARD_NO").val() == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.IDnumber"/>'+". " + '<spring:message code="input.required"/>') ; 
			return false; 
		}
		return true;
	} 
</script>
	
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div style="position: absolute;">
			<form name="form1" method="post" action="" id="form1">
				<table width="99.6%" cellpadding="1" cellspacing="1"
					style="height: 25px; font-size: 12px;">
					<tr>
						<td width="5%" align="center">&nbsp;</td>
						<td width="25%" align="left" style="font-weight: bold;">&nbsp;</td>
						<td width="5%" align="right">&nbsp;</td>
						<td align="right" height="30px;"><a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-left: 10px; "
							onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
					</tr>
				</table>
				<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">性别</td>
						<td width="20%" class="l-table-edit-c"><input type="hidden"
							id="EMPID" name="EMPID" value="${personalInfo.EMPID}"> <SipingSoft:selectSyCode
								parentCode="GenderCode" name="GENDER_CODE" limit="all"
								selected="${personalInfo.GENDER_CODE}" /></td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">民族</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="NationCode" name="NATION_CODE" limit="all"
								selected="${personalInfo.NATION_CODE}" /></td>
						<td width="10%" class="l-table-edit-t"><spring:message
								code="hrms.positionalTitle" /></td>
						<td width="20%" class="l-table-edit-c">
							<SipingSoft:selectSyCode parentCode="PosiTitleTypeCode" name="PT_ID" limit="all"
								selected="${personalInfo.POSITIONALTITLE}" />
						</td>
					</tr>
					<tr>
					<%-- 	<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">国籍</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="NationalityCode" name="NATIONALITY_CODE" limit="all"
								selected="${personalInfo.NATIONALITY_CODE}" /></td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">籍贯</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="BornPlaceCode" name="BORNPLACE_CODE" limit="all"
								selected="${personalInfo.BORNPLACE_CODE}" /></td> --%>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">政党面貌</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="PolityCode" name="POLITY_CODE" limit="all"
								selected="${personalInfo.POLITY_CODE}" /></td>
								
								<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.eduHis" /></td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="EduHisCode" name="EDU_HIS_CODE" limit="all"
								selected="${personalInfo.EDU_HIS_CODE}" /></td>
					<%-- 	<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.degree" /></td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="DegreeCode" name="DEGREE_CODE" limit="all"
								selected="${personalInfo.DEGREE_CODE}" /></td> --%>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.major" /></td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="SubjectCode" name="MAJOR_CODE" limit="all"
								selected="${personalInfo.MAJOR_CODE}" /></td>
					</tr>
					<!-- <tr>
						
					</tr> -->
					<tr>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.IDnumber" /><font
							color="red">*</font></td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="IDCARD_NO" id="IDCARD_NO" value="${personalInfo.IDCARD_NO}" />
						</td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">婚姻状态</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="MaritalStatusCode" name="MARITAL_STATUS_CODE"
								limit="all" selected="${personalInfo.MARITAL_STATUS_CODE}" /></td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.birthDate" /></td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="BIRTHDAY" id="BIRTHDAY" value="${personalInfo.BIRTHDAY}"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
							readonly="readonly" /></td>
					</tr>
				</table>
			</form>
			<br>
			<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t" nowrap="nowrap"
						nowrap="nowrap">通信地址</td>
					<td width="80%" class="l-table-edit-c" nowrap="nowrap">
                        <SipingSoft:area provinceID="HOME_PROVINCE" cityID="HOME_CITY" countyID="HOME_AREA"
                           provinceSelected="${personalInfo.HOME_PROVINCE}" citySelected="${personalInfo.HOME_CITY}" countySelected="${personalInfo.HOME_AREA}"/>
                        <input type="text" name="HOME_ADDRESS" size="40" id="HOME_ADDRESS" value="${personalInfo.HOME_ADDRESS}" /></td>
				</tr>
			</table>
			<br>
			<form name="form2" method="post" action="" id="form2">
				<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.mobileTelephone" /></td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="CELLPHONE" id="CELLPHONE" value="${personalInfo.CELLPHONE}" />
						</td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">固定电话</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="HOME_PHONE" id="HOME_PHONE"
							value="${personalInfo.HOME_PHONE}" /></td>
						<%-- <td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap"><spring:message code="hrms.workPhone" /></td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="OFFICE_PHONE" id="OFFICE_PHONE"
							value="${personalInfo.OFFICE_PHONE}" /></td> --%>
					</tr>
					<tr>
						<%-- <td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">传真号码</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="FAX" id="FAX" value="${personalInfo.FAX}" /></td> --%>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">电子邮箱</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="P_EMAIL" id="P_EMAIL" value="${personalInfo.P_EMAIL}" /></td>
						<%-- <td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">公司邮箱</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="C_EMAIL" id="C_EMAIL" value="${personalInfo.C_EMAIL}" /></td> --%>
					</tr>
				</table>
				<br>
				<%-- <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">工作班制</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="WorkShiftCode" name="SHIFT_CODE" limit="all"
								selected="${personalInfo.SHIFT_CODE}" /></td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">档案状态</td>
						<td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode
								parentCode="FileRelationCode" name="FILE_RELATION_CODE"
								limit="all" selected="${personalInfo.FILE_RELATION_CODE}" /></td>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">存档单位</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="FILE_RELATION_ADDRESS" id="FILE_RELATION_ADDRESS"
							value="${personalInfo.FILE_RELATION_ADDRESS}" /></td>
					</tr>
				</table> --%>
				<br>
				<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<%-- <tr>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">司外工龄(月)</td>
						<td class="l-table-edit-c" width="20%"><input type="text"
							name="WORKAGE" id="WORKAGE" value="${personalInfo.B_WORKAGE}"
							ltype='spinner' ligerui="{type:'int'}" /></td>
					</tr> --%>
					<tr>
						<%-- <td width="10%" class="l-table-edit-t">社保说明</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="SI_REMARK" id="SI_REMARK" value="${personalInfo.SI_REMARK}" />
						</td> --%>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">社保号码</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="SSN" id="SSN" value="${personalInfo.SSN}" /></td>
						<%-- <td width="10%" class="l-table-edit-t">补充字段1</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="ADDED_INFOR1" id="ADDED_INFOR1"
							value="${personalInfo.ADDED_INFOR1}" /></td> --%>
					</tr>
					<tr>
						<%-- <td width="10%" class="l-table-edit-t">公积金说明</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="FUND_REMARK" id="FUND_REMARK"
							value="${personalInfo.FUND_REMARK}" /></td> --%>
						<td width="10%" class="l-table-edit-t" nowrap="nowrap"
							nowrap="nowrap">公积金号码</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="HAFN" id="HAFN" value="${personalInfo.HAFN}" /></td>
						<%-- <td width="10%" class="l-table-edit-t">补充字段2</td>
						<td width="20%" class="l-table-edit-c"><input type="text"
							name="ADDED_INFOR2" id="ADDED_INFOR2"
							value="${personalInfo.ADDED_INFOR2}" /></td> --%>
					</tr>
				</table>
				<table width="99.6%" cellpadding="1" cellspacing="1"
					style="height: 25px; font-size: 12px;">
					<tr>
						<td width="99.6%" height="20px" align="left">&nbsp;&nbsp;&nbsp;</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
