<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
    <meta http-equiv="X-UA-Compatible" content="IE=edge" >
   
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
    
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
        
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
    
    <script type="text/javascript">
        
    function f_save(){
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        var options = {
            url:'/system/basicMaintenance/addCompanyInfo',
            type:'POST',
            success: function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                            parent.f_ChildWindowClose();
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.sameDataAlreadyExists"/>');
                    }
                }
            };
        $('#form1').ajaxSubmit(options);
    }
</script>
    
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:0px" > 
      <div id = 'layout1'>
             <form name="form1" method="post" action="" id="form1">
                        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                            <tr>
                                <td class="l-table-edit-t"><!-- 主键--><spring:message code="hrms.primaryKey"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_ID" type="text" id="CPNY_ID" value="wooribank" 
                                    ltype="text" validate="{required:true}" maxlength="20"/>
                                </td> 
                                <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                                <td class="l-table-edit-c"> 
                                    <SipingSoft:selectStatus name="ACTIVITY" selected="1"/> 
                                </td>
                             </tr>
                             <tr>
                                <td class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_NAME" type="text" id="CPNY_NAME" value="" 
                                    ltype="text" validate="{required:true}" />
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_EN_NAME" type="text" id="CPNY_EN_NAME" value="" 
                                    ltype="text"  validate="{required:true}" />
                                </td>
                            </tr> 
                            <tr>   
                                <td class="l-table-edit-t"><spring:message code="hrms.location"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_LOCATION" type="text" id="CPNY_LOCATION" value="" 
                                    ltype="text"  />
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.address"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_ADDR" type="text" id="CPNY_ADDR" value="" 
                                    ltype="text"  />
                                </td>
                            </tr> 
                            <tr>   
                                <td class="l-table-edit-t"><spring:message code="hrms.postalcode"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_IDCARD_POSTALCODE" type="text" id="CPNY_IDCARD_POSTALCODE" value=""
                                    ltype="text"  />
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.website"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_WEB_ADDR" type="text" id="CPNY_WEB_ADDR" value="" 
                                    ltype="text"  />
                                </td>
                            </tr> 
                            <tr>   
                                <td class="l-table-edit-t"><spring:message code="hrms.fax"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_FAX_NO" type="text" id="CPNY_FAX_NO" value="" 
                                    ltype="text"  />
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.telephone"/></td>
                                <td class="l-table-edit-c">
                                    <input name="CPNY_TEL_NO" type="text" id="CPNY_TEL_NO" value="" 
                                    ltype="text"  />
                                </td>
                            </tr>  
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="hrms.intro"/></td>
                                <td class="l-table-edit-c" colspan="3"> 
                                <textarea cols="100" rows="4" name="CPNY_INTRO" id="CPNY_INTRO" style="width:400px" ></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="hrms.history"/></td>
                                <td class="l-table-edit-c" colspan="3"> 
                                <textarea cols="100" rows="4" name="CPNY_HISTORY" id="CPNY_HISTORY" style="width:400px" ></textarea>
                                </td> 
                            </tr>
                            <tr>
                                <td class="l-table-edit-cc" colspan="4" height="30px;">  
                                    <a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>   
                                </td>
                            </tr>
                        </table>
             </form>
      </div>
</body>
</html>