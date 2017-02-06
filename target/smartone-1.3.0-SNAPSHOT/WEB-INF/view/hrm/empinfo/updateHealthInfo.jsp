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
<script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>  
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script> 
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    function spf_save(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.post("/hrm/empinfo/updateHealthInfo", 
                    [	    
                      	{ name: 'EMPID', value: $("#EMPID").val()},  
                      	{ name: 'HEALTH_NO', value: $("#HEALTH_NO").val()}, 
                      	{ name: 'HEIGHT', value: $("#HEIGHT").val()},
                      	{ name: 'WEIGHT', value: $("#WEIGHT").val()},
                      	{ name: 'SHOE_SIZE', value: $("#SHOE_SIZE").val()}, 
                      	{ name: 'SLEEVE_LENGTH', value: $("#SLEEVE_LENGTH").val()},  
                      	{ name: 'COAT_LENGTH', value: $("#COAT_LENGTH").val()},   
                      	{ name: 'SHOULDER_BREADTH', value: $("#SHOULDER_BREADTH").val()},   
                      	{ name: 'SKIRT_LENGTH', value: $("#SKIRT_LENGTH").val()} ,   
                      	{ name: 'TROUSERS_LENGTH', value: $("#TROUSERS_LENGTH").val()} ,   
                      	{ name: 'WAIST', value: $("#WAIST").val()} ,   
                      	{ name: 'HIP', value: $("#HIP").val()} ,   
                      	{ name: 'BUST', value: $("#BUST").val()} ,   
                      	{ name: 'PMH', value: $("#PMH").val()} ,   
                      	{ name: 'L_EYE_UCVA', value: $("#L_EYE_UCVA").val()} ,   
                      	{ name: 'R_EYE_UCVA', value: $("#R_EYE_UCVA").val()} ,   
                      	{ name: 'L_EYE_DISEASE', value: $("#L_EYE_DISEASE").val()} ,   
                      	{ name: 'L_EYE_CVA', value: $("#L_EYE_CVA").val()} ,   
                      	{ name: 'R_EYE_CVA', value: $("#R_EYE_CVA").val()} ,   
                      	{ name: 'R_EYE_DISEASE', value: $("#R_EYE_DISEASE").val()} ,   
                      	{ name: 'COLOR_VISION_CODE', value: $("#COLOR_VISION_CODE").val()} ,   
                      	{ name: 'L_EAR_AUDIBILITY', value: $("#L_EAR_AUDIBILITY").val()} ,   
                      	{ name: 'L_EAR_DISEASE', value: $("#L_EAR_DISEASE").val()} ,   
                      	{ name: 'L_NOSE', value: $("#L_NOSE").val()} ,   
                      	{ name: 'R_EAR_AUDIBILITY', value: $("#R_EAR_AUDIBILITY").val()} ,   
                      	{ name: 'R_EAR_DISEASE', value: $("#R_EAR_DISEASE").val()} ,   
                      	{ name: 'R_NOSE', value: $("#R_NOSE").val()} ,   
                      	{ name: 'OLFACTORY_CODE', value: $("#OLFACTORY_CODE").val()} ,   
                      	{ name: 'BREATH', value: $("#BREATH").val()} ,   
                      	{ name: 'SPHYGMUS', value: $("#SPHYGMUS").val()} ,   
                      	{ name: 'GROWTH_AND_NUTRITION', value: $("#GROWTH_AND_NUTRITION").val()} ,   
                      	{ name: 'BLOOD_PRESSURE_MAX', value: $("#BLOOD_PRESSURE_MAX").val()} ,   
                      	{ name: 'BLOOD_PRESSURE_MIX', value: $("#BLOOD_PRESSURE_MIX").val()} ,   
                      	{ name: 'ABDOMINAL_CHECK', value: $("#ABDOMINAL_CHECK").val()} ,   
                      	{ name: 'BLOOD_SUGAR', value: $("#BLOOD_SUGAR").val()} ,   
                      	{ name: 'HBSAG', value: $("#HBSAG").val()} ,   
                      	{ name: 'HBS', value: $("#HBS").val()} ,   
                      	{ name: 'OT', value: $("#OT").val()} ,   
                      	{ name: 'PT', value: $("#PT").val()} ,   
                      	{ name: 'HBE', value: $("#HBE").val()} ,   
                      	{ name: 'CBC', value: $("#CBC").val()} ,   
                      	{ name: 'BLOOD_TYPE_CODE', value: $("#BLOOD_TYPE_CODE").val()} ,   
                      	{ name: 'RH', value: $("#RH").val()} ,   
                      	{ name: 'HBEAG', value: $("#HBEAG").val()} ,   
                      	{ name: 'PHYSICAL_DATE', value: $("#PHYSICAL_DATE").val()} ,   
                      	{ name: 'CHECK_YN_CODE', value: $("#CHECK_YN_CODE").val()} ,   
                      	{ name: 'CHECK_RESULT_CODE', value: $("#CHECK_RESULT_CODE").val()} ,   
                      	{ name: 'DESCRIPTION', value: $("#DESCRIPTION").val()} ,   
                      	{ name: 'REMARK', value: $("#DESCRIPTION").val()}
                     ]
                , function (result)
                {
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
                }); 
        }
    } 
    function spf_checkData()
    {
    	var PHYSICAL_DATE = $("#PHYSICAL_DATE").val(); 
    	var CHECK_YN_CODE = $("#CHECK_YN_CODE").val(); 
    	var CHECK_RESULT_CODE = $("#CHECK_RESULT_CODE").val(); 
    	var DESCRIPTION = $("#DESCRIPTION").val();    
    	
        if (PHYSICAL_DATE == null || PHYSICAL_DATE == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.examinationDate"/>'+". " + '<spring:message code="input.required"/>') ; 
           	 return false; 
        }    
        if (CHECK_YN_CODE == null || CHECK_YN_CODE == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.physicalExamination"/>'+". " + '<spring:message code="input.required"/>') ; 
           	 return false; 
        }  
        if (CHECK_RESULT_CODE == null || CHECK_RESULT_CODE == "") { 
           	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.examinationResult"/>'+". " + '<spring:message code="input.required"/>') ; 
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
<body style="padding:2px" > 
	  <div id = 'layout1'>
		     <form name="form1" method="post" action="" id="form1">
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td align="center" valign="middle"> 
					        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					            <tr>
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.empid"/></td>
					                <td width="20%" class="l-table-edit-c"> ${basicInfo.EMPID }
					                	<input type="hidden" name="EMPID" id="EMPID" value="${basicInfo.EMPID }"/>
					                	<input type="hidden" name="HEALTH_NO" id="HEALTH_NO" value="${healthInfo.NO }"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
					                <td width="20%" class="l-table-edit-c"> ${basicInfo.CHINESENAME }</td> 
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.birthDate"/></td>
					                <td width="20%" class="l-table-edit-c"> ${basicInfo.BIRTHDAY }</td>  
					             </tr>
					        </table> 
					        <br>
					         <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					             <tr>   
					                <td width="10%" class="l-table-edit-t">身高(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HEIGHT" id="HEIGHT" value="${healthInfo.HEIGHT }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					                <td width="10%" class="l-table-edit-t">体重(kg)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="WEIGHT" id="WEIGHT" value="${healthInfo.WEIGHT }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">鞋码(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="SHOE_SIZE" id="SHOE_SIZE" value="${healthInfo.SHOE_SIZE }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">袖长(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="SLEEVE_LENGTH" id="SLEEVE_LENGTH" value="${healthInfo.SLEEVE_LENGTH }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					                <td width="10%" class="l-table-edit-t">衣长(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="COAT_LENGTH" id="COAT_LENGTH" value="${healthInfo.COAT_LENGTH }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t" rowspan="2">肩宽(cm)</td>
					                <td width="20%" class="l-table-edit-c" rowspan="2">
					                	<input type="text" name="SHOULDER_BREADTH" id="SHOULDER_BREADTH" value="${healthInfo.SHOULDER_BREADTH }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">裙长(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="SKIRT_LENGTH" id="SKIRT_LENGTH" value="${healthInfo.SKIRT_LENGTH }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">裤长(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="TROUSERS_LENGTH" id="TROUSERS_LENGTH" value="${healthInfo.TROUSERS_LENGTH }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					            </tr>
					             <tr>   
					                <td width="10%" class="l-table-edit-t">腰围(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="WAIST" id="WAIST" value="${healthInfo.WAIST }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">臀围(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HIP" id="HIP" value="${healthInfo.HIP }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">胸围(cm)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="BUST" id="BUST" value="${healthInfo.BUST }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					            </tr> 
					          <tr>   
					                <td width="10%" class="l-table-edit-t">裸眼视力(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_EYE_UCVA" id="L_EYE_UCVA" value="${healthInfo.L_EYE_UCVA }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					                <td width="10%" class="l-table-edit-t">裸眼视力(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_EYE_UCVA" id="R_EYE_UCVA" value="${healthInfo.R_EYE_UCVA }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">眼疾(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_EYE_DISEASE" id="L_EYE_DISEASE" value="${healthInfo.L_EYE_DISEASE }" />
					                </td> 
					            </tr>  
					             <tr>   
					                <td width="10%" class="l-table-edit-t">矫正视力(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_EYE_CVA" id="L_EYE_CVA" value="${healthInfo.L_EYE_CVA }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td>
					                <td width="10%" class="l-table-edit-t">矫正视力(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_EYE_CVA" id="R_EYE_CVA" value="${healthInfo.R_EYE_CVA }" ltype='spinner' ligerui="{type:'float'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">眼疾(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_EYE_DISEASE" id="R_EYE_DISEASE" value="${healthInfo.R_EYE_DISEASE }" />
					                </td> 
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">色觉</td>
					                <td width="20%" class="l-table-edit-c" colspan="5"> 
					                	<SipingSoft:selectSyCode parentCode="ColorVisionCode" name="COLOR_VISION_CODE" selected="${healthInfo.COLOR_VISION_CODE }"/>
					                </td> 
					            </tr> 
					        </table>
					        <br>
					        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					          <tr>   
					                <td width="10%" class="l-table-edit-t">听力(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_EAR_AUDIBILITY" id="L_EAR_AUDIBILITY" value="${healthInfo.L_EAR_AUDIBILITY }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">耳疾(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_EAR_DISEASE" id="L_EAR_DISEASE" value="${healthInfo.L_EAR_DISEASE }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">鼻(左)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="L_NOSE" id="L_NOSE" value="${healthInfo.L_NOSE }" />
					                </td>
					            </tr>  
					             <tr>   
					                <td width="10%" class="l-table-edit-t">听力(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_EAR_AUDIBILITY" id="R_EAR_AUDIBILITY" value="${healthInfo.R_EAR_AUDIBILITY }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">耳疾(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_EAR_DISEASE" id="R_EAR_DISEASE" value="${healthInfo.R_EAR_DISEASE }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">鼻(右)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="R_NOSE" id="R_NOSE" value="${healthInfo.R_NOSE }" />
					                </td>
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">嗅觉</td>
					                <td width="20%" class="l-table-edit-c" colspan="5">
					                    <SipingSoft:selectSyCode parentCode="OlfactoryCode" name="OLFACTORY_CODE" selected="${healthInfo.OLFACTORY_CODE }"/> 
					                </td> 
					            </tr>  
					        </table> 
					        <br>
					        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					          <tr>   
					                <td width="10%" class="l-table-edit-t">呼吸(次/分)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="BREATH" id="BREATH" value="${healthInfo.BREATH }" ltype='spinner' ligerui="{type:'int'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">脉搏(次/分)</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="SPHYGMUS" id="SPHYGMUS" value="${healthInfo.SPHYGMUS }" ltype='spinner' ligerui="{type:'int'}"/>
					                </td>  
					                <td width="10%" class="l-table-edit-t">发育及营养</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="GROWTH_AND_NUTRITION" id="GROWTH_AND_NUTRITION" value="${healthInfo.GROWTH_AND_NUTRITION }" />
					                </td>  
					            </tr>  
					             <tr>   
					                <td width="10%" class="l-table-edit-t">收缩压</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="BLOOD_PRESSURE_MAX" id="BLOOD_PRESSURE_MAX" value="${healthInfo.BLOOD_PRESSURE_MAX }" ltype='spinner' ligerui="{type:'int'}"/>
					                </td> 
					                <td width="10%" class="l-table-edit-t">舒张压</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="BLOOD_PRESSURE_MIX" id="BLOOD_PRESSURE_MIX" value="${healthInfo.BLOOD_PRESSURE_MIX }" ltype='spinner' ligerui="{type:'int'}"/>
					                </td>  
					                <td width="10%" class="l-table-edit-t">腹部检查</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="ABDOMINAL_CHECK" id="ABDOMINAL_CHECK" value="${healthInfo.ABDOMINAL_CHECK }" />
					                </td> 
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">血糖</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="BLOOD_SUGAR" id="BLOOD_SUGAR" value="${healthInfo.BLOOD_SUGAR }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">肺</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HBSAG" id="HBSAG" value="${healthInfo.HBSAG }" />
					                </td>  
					                <td width="10%" class="l-table-edit-t">皮肤</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HBS" id="HBS" value="${healthInfo.HBS }" />
					                </td>   
					            </tr>  
					             <tr>   
					                <td width="10%" class="l-table-edit-t">肝</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="OT" id="OT" value="${healthInfo.OT }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">脾</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="PT" id="PT" value="${healthInfo.PT }" />
					                </td>  
					                <td width="10%" class="l-table-edit-t">大便培养</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HBE" id="HBE" value="${healthInfo.HBE }" />
					                </td>  
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">血常规</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="CBC" id="CBC" value="${healthInfo.CBC }" />
					                </td> 
					                <td width="10%" class="l-table-edit-t">ABO血型</td>
					                <td width="20%" class="l-table-edit-c">
										<SipingSoft:selectSyCode parentCode="BloodTypeCode" name="BLOOD_TYPE_CODE" selected="${healthInfo.BLOOD_TYPE_CODE }"/> 
					                </td>  
					                <td width="10%" class="l-table-edit-t">RH血型</td>
					                <td width="20%" class="l-table-edit-c">
										<SipingSoft:selectSyCode parentCode="RHTypeCode" name="RH" selected="${healthInfo.RH_CODE }"/>  
					                </td>  
					            </tr> 
					             <tr>   
					                <td width="10%" class="l-table-edit-t">胸透</td>
					                <td width="20%" class="l-table-edit-c">
					                	<input type="text" name="HBEAG" id="HBEAG" value="${healthInfo.HBEAG }" />
					                </td>  
					            </tr>  
					        </table>   
					        <br>
					        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					            <tr>   
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.examinationDate"/></td>
					                <td width="20%" class="l-table-edit-c">
				            			<input type="text" name="PHYSICAL_DATE" id="PHYSICAL_DATE" 
						                	 value="${healthInfo.PHYSICAL_DATE }" 
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"  
						                	 readonly="readonly"/> 
					                </td>
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.physicalExamination"/></td>
					                <td width="20%" class="l-table-edit-c"> 
										<SipingSoft:selectSyCode parentCode="CheckWhether" name="CHECK_YN_CODE" selected="${healthInfo.CHECK_YN_CODE }"/>
					                </td>
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.examinationResult"/></td>
					                <td width="20%" class="l-table-edit-c">
										<SipingSoft:selectSyCode parentCode="CheckResult" name="CHECK_RESULT_CODE" selected="${healthInfo.CHECK_RESULT_CODE }"/>
					                </td> 
					            </tr>   
					            <tr>
					                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.description"/></td>
					                <td class="l-table-edit-c" colspan="5"> 
					                	<textarea cols="100" rows="4" name="DESCRIPTION" id="DESCRIPTION" style="width:400px" >${healthInfo.DESCRIPTION }</textarea>
					                </td> 
					            </tr>
					        </table> 
		        		</td>
			      	</tr>
			    </table> 
		       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
		           <tr>
		                <td align="left">  
	               			<a class="l-button" style="width:79px; height:20px; float: left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>  
						</td>
		           </tr>  
	       		</table> 
	         </form>
	  </div>
</body>
</html>
