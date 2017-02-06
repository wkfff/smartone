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
	     
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
<script type="text/javascript">
 	   
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
	  <div id = 'layout1'> 
		        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		            <tr>
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.empid"/></td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.EMPID }
		                	<input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }"/>
		                	<input type="hidden" name="HEALTH_NO" id="HEALTH_NO" value="${healthInfo.HEALTH_NO }"/>
		                </td> 
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.CHINESENAME }</td> 
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.birthDate"/></td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.BIRTHDAY }</td>  
		             </tr>
		             <tr>
		                <td width="10%" class="l-table-edit-t">名族</td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.NATION_NAME }</td> 
		                <td width="10%" class="l-table-edit-t">婚姻状态</td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.BIRTHDAY }</td>  
		                <td width="10%" class="l-table-edit-t">户口地址</td>
		                <td width="20%" class="l-table-edit-c"> ${basicInfo.CHINESENAME }</td>  
		             </tr>
		              <tr> 
		                <td width="10%" class="l-table-edit-t">省份证号码</td>
		                <td width="20%" class="l-table-edit-c" colspan="5"> ${basicInfo.IDCARD_NO }</td>  
		             </tr> 
		        </table> 
		        <br>
		         <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		             <tr>   
		                <td width="10%" class="l-table-edit-t">身高(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.HEIGHT }</td>
		                <td width="10%" class="l-table-edit-t">体重(kg)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.WEIGHT }</td> 
		                <td width="10%" class="l-table-edit-t">鞋码(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.SHOE_SIZE }</td> 
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">袖长(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.SLEEVE_LENGTH }</td>
		                <td width="10%" class="l-table-edit-t">衣长(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.COAT_LENGTH }</td> 
		                <td width="10%" class="l-table-edit-t" rowspan="2">肩宽(cm)</td>
		                <td width="20%" class="l-table-edit-c" rowspan="2">
		                ${healthInfo.SHOULDER_BREADTH }</td>
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">裙长(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.SKIRT_LENGTH }</td> 
		                <td width="10%" class="l-table-edit-t">裤长(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.TROUSERS_LENGTH }</td> 
		            </tr>
		             <tr>   
		                <td width="10%" class="l-table-edit-t">腰围(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.WAIST }</td> 
		                <td width="10%" class="l-table-edit-t">臀围(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.HIP }</td> 
		                <td width="10%" class="l-table-edit-t">胸围(cm)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.BUST }</td>
		            </tr> 
		         </table> 
		        <br>
		         <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		           		<tr>    
		                <td width="108px" class="l-table-edit-t">既往病史</td>
		                <td width="80px" class="l-table-edit-c" colspan="5"> 
							${healthInfo.PMH }</td>   
		             </tr>
		        </table> 
		        <br>
		        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		          <tr>   
		                <td width="10%" class="l-table-edit-t">裸眼视力(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_EYE_UCVA }</td>
		                <td width="10%" class="l-table-edit-t">裸眼视力(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_EYE_UCVA }</td> 
		                <td width="10%" class="l-table-edit-t">眼疾(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_EYE_DISEASE }</td> 
		            </tr>  
		             <tr>   
		                <td width="10%" class="l-table-edit-t">矫正视力(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_EYE_CVA }</td>
		                <td width="10%" class="l-table-edit-t">矫正视力(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_EYE_CVA }</td> 
		                <td width="10%" class="l-table-edit-t">眼疾(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_EYE_DISEASE }</td> 
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">色觉</td>
		                <td width="20%" class="l-table-edit-c" colspan="5"> 
		                ${healthInfo.COLOR_VISION_NAME }</td> 
		            </tr> 
		        </table>
		        <br>
		        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		          <tr>   
		                <td width="10%" class="l-table-edit-t">听力(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_EAR_AUDIBILITY }</td> 
		                <td width="10%" class="l-table-edit-t">耳疾(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_EAR_DISEASE }</td> 
		                <td width="10%" class="l-table-edit-t">鼻(左)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.L_NOSE }</td>
		            </tr>  
		             <tr>   
		                <td width="10%" class="l-table-edit-t">听力(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_EAR_AUDIBILITY }</td> 
		                <td width="10%" class="l-table-edit-t">耳疾(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_EAR_DISEASE }</td> 
		                <td width="10%" class="l-table-edit-t">鼻(右)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.R_NOSE }</td>
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">嗅觉</td>
		                <td width="20%" class="l-table-edit-c" colspan="5">
		                ${healthInfo.OLFACTORY_NAME }</td> 
		            </tr>  
		        </table> 
		        <br>
		        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		          <tr>   
		                <td width="10%" class="l-table-edit-t">呼吸(次/分)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.BREATH }</td> 
		                <td width="10%" class="l-table-edit-t">脉搏(次/分)</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.SPHYGMUS }</td>  
		                <td width="10%" class="l-table-edit-t">发育及营养</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.GROWTH_AND_NUTRITION }</td>  
		            </tr>  
		             <tr>   
		                <td width="10%" class="l-table-edit-t">收缩压</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.BLOOD_PRESSURE_MAX }</td> 
		                <td width="10%" class="l-table-edit-t">舒张压</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.BLOOD_PRESSURE_MIX }</td>  
		                <td width="10%" class="l-table-edit-t">腹部检查</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.ABDOMINAL_CHECK }</td> 
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">血糖</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.BLOOD_SUGAR }</td> 
		                <td width="10%" class="l-table-edit-t">肺</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.HBSAG }</td>  
		                <td width="10%" class="l-table-edit-t">皮肤</td>
		                <td width="20%" class="l-table-edit-c">
		                ${healthInfo.HBS }</td>   
		            </tr>  
		             <tr>   
		                <td width="10%" class="l-table-edit-t">肝</td>
		                <td width="20%" class="l-table-edit-c">
		                	${healthInfo.OT }
		                </td> 
		                <td width="10%" class="l-table-edit-t">脾</td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.PT }
		                </td>  
		                <td width="10%" class="l-table-edit-t">大便培养</td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.HBE }
		                </td>  
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">血常规</td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.CBC }
		                </td> 
		                <td width="10%" class="l-table-edit-t">ABO血型</td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.BLOOD_TYPE_NAME } 
		                </td>  
		                <td width="10%" class="l-table-edit-t">RH血型</td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.RH_NAME }
		                </td>  
		            </tr> 
		             <tr>   
		                <td width="10%" class="l-table-edit-t">胸透</td>
		                <td width="20%" class="l-table-edit-c" colspan="5">${healthInfo.HBEAG }
		                </td>  
		            </tr>  
		        </table>   
		        <br>
		        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		            <tr>   
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.examinationDate"/></td>
		                <td width="20%" class="l-table-edit-c">
	            			${healthInfo.PHYSICAL_DATE }
		                </td>
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.physicalExamination"/></td>
		                <td width="20%" class="l-table-edit-c"> ${healthInfo.CHECK_YN_NAME }
		                </td>
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.examinationResult"/></td>
		                <td width="20%" class="l-table-edit-c">${healthInfo.CHECK_RESULT_NAME }
		                </td> 
		            </tr>   
		            <tr>
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.description"/></td>
		                <td class="l-table-edit-c" colspan="5"> 
		                	<textarea cols="100" rows="4" name="DESCRIPTION" id="DESCRIPTION" style="width:600px" readonly="readonly">${healthInfo.DESCRIPTION }</textarea>
		                </td> 
		            </tr>
		            <tr>
		                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
		                <td class="l-table-edit-c" colspan="5"> 
		                	<textarea cols="100" rows="4" name="REMARK" id="REMARK" style="width:600px" readonly="readonly">${healthInfo.REMARK }</textarea>
		                </td> 
		            </tr>
		            <tr>
		                <td class="l-table-edit-cc" colspan="6" height="30px">  
							<a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>  
		                </td>
		            </tr>
		        </table>  
	  </div>
</body>
</html>
