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
function spf_save(){
        if(spf_checkData()){        
              $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        
              var options = {                           
                  url:'/pa/salary/updatePaFormulaInfo',
                  type:'POST',                          
                  success: function (result){
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
    } 
    function spf_checkData()
    {    
        var formular = $("#FORMULAR").val(); 
         
        if (formular == null || formular == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="formula"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }     
        return true; 
    }

    function spf_fd()
    {    
        var formular = $("#FORMULAR").val(); 
         
        if (formular == null || formular == "") { 
            $("#DESCRIPTION").val("");
        }   
    } 
    
    function spf_tool()
    {    
        $dialog = $.ligerWindow.show({isDrag: true,
            title: '<spring:message code="tool"/>',
                width: 950 , 
                height: 400 , 
                left:180,top:60,
                url: '/pa/salary/viewPaFormularTool?PA_MONTH=${paFormulaInfo.PA_MONTH }'
            }); 
    } 
</script>
    
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:0px" > 
      <div id='layout1' style="position: inherit;margin:0px auto; ">
             <form name="form1" method="post" action="" id="form1">
                <table width="99%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="10%" align="center"><spring:message code="hrms.attItemName"/>:</td>
                        <td width="20%" align="left">
                            ${paItemInfo.ITEM_NAME}
                        </td>   
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"> 
                            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_tool()"><spring:message code="tool"/></a>
                            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>  
                        </td>                                           
                    </tr> 
                </table>    
                <table width="99%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                   <tr>
                       <td width="15%" class="l-table-edit-t"><spring:message code="condition"/></td>
                       <td width="84%" class="l-table-edit-c">
                            <textarea rows="8" cols="100" id="CONDITION" name="CONDITION">${paFormulaInfo.CONDITION }</textarea>
                       </td>
                   </tr> 
                   <tr>
                       <td width="15%" class="l-table-edit-t"><spring:message code="formula"/></td>
                       <td width="84%" class="l-table-edit-c">
                            <textarea rows="8" cols="100" id="FORMULAR" name="FORMULAR" onkeyup="spf_fd();">${paFormulaInfo.FORMULAR }</textarea>
                       </td>
                   </tr>  
                   <tr>
                       <td width="15%" class="l-table-edit-t"><spring:message code="hrms.description"/></td>
                       <td width="84%" class="l-table-edit-c">
                            <textarea rows="3" cols="100" id="DESCRIPTION" name="DESCRIPTION">${paFormulaInfo.DESCRIPTION }</textarea>
                            <input type="hidden" id="FORMULAR_NO" name="FORMULAR_NO" value="${paFormulaInfo.FORMULAR_NO }"> 
                       </td>
                   </tr>    
               </table>
             </form>
      </div>
</body>
</html>
