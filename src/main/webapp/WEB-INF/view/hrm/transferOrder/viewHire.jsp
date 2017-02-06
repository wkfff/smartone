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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
//初始化数据 
    $(function ()
        {
            //布局
             $("#layout1").ligerLayout({  
                     allowLeftResize: false,      //是否允许 左边可以调整大小
                     allowRightResize: false,     //是否允许 右边可以调整大小
                     allowTopResize: false,      //是否允许 头部可以调整大小
                     allowBottomResize: false     //是否允许 底部可以调整大小
              }
             );
        });  
    // 初始调用 
    function spf_application() { 
        if(spf_checkData()){ 
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post("/hrm/transferOrder/saveTransferOrder", 
                     [
                        { name: 'TYPE', value: 'hire'},
                        { name: 'EMPID', value: $("#EMPID").val()},
                        { name: 'DEPTID', value: $("#DEPTID").val()},
                        { name: 'TRANS_CODE', value: '${TRANS_CODE}' },
                        { name: 'TRANS_NO', value: '${TRANS_NO}' },  
                        { name: 'CHINESENAME', value: $("#CHINESENAME").val()},  
                        { name: 'ENGLISHNAME', value: $("#ENGLISHNAME").val()},
                        { name: 'JOIN_DATE', value: $("#JOIN_DATE").val()},  
                        { name: 'HIRE_DATE', value: $("#JOIN_DATE").val()},  
                        { name: 'POST_ID', value: $("#POST_ID").val()},
                        /* { name: 'PT_ID', value: $("#PT_ID").val()}, */
                        { name: 'END_PROBATION_DATE', value: $("#END_PROBATION_DATE").val()},
                        { name: 'STATUS_CODE', value: $("#STATUS_CODE").val()},
                        { name: 'EMP_TYPE_CODE', value: $("#EMP_TYPE_CODE").val()},
                        { name: 'IDCARD_NO', value: $("#IDCARD_NO").val()},
                        { name: 'POST_LEVEL_ID', value: $("#POST_LEVEL").val()}
                      ],
             function (result){
                $.ligerDialog.closeWaitting();
                 if (result == "Y"){
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                         spf_refresh();
                     });
                 }else{
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                 }
             });
        }
     }
    function spf_checkData(){
        if ($("#EMPID").val() == null || $("#EMPID").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.empid"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        } 
        if ($("#DEPTID").val() == null || $("#DEPTID").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dept"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }  
        if ($("#CHINESENAME").val() == null || $("#CHINESENAME").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cName"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }  
        if ($("#JOIN_DATE").val() == null || $("#JOIN_DATE").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.hireDate"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        } 
        if ($("#POST_ID").val() == null || $("#POST_ID").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.post"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        } 
        if ($("#STATUS_CODE").val() == null || $("#STATUS_CODE").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.EmpStatus"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        } 
        if ($("#EMP_TYPE_CODE").val() == null || $("#EMP_TYPE_CODE").val() == "") { 
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.empDivision"/>'+". " + '<spring:message code="input.required"/>') ; 
           return false; 
        }
        if ($("#IDCARD_NO").val() == null || $("#IDCARD_NO").val() == "") { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.IDnumber"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        return true;
    } 
    function spf_checkEmpID()
    {    var empID = $("#EMPID").val(); 
        if(empID==""){
            $('#Tip').html('<font color="red">不可为空</font>');
            return;
        }
        $.post('/hrm/transferOrder/checkEmpID',
                 {"ADMINID":empID},
                 function(back){
             $('#Tip').html(back);
        });
    }
    function spf_refresh(){
        location.href="/hrm/transferOrder/viewHire?MENU_CODE=hr0201";
    }
    function spf_getPostLevel(){
        if ($("#POST_ID").val() != "") {
            $.ajax({
                type:'post',
                cache : false,
                contentType : 'application/json',
                url : '/hrm/position/getPostLevelDataInfo?POST_ID='+$("#POST_ID").val(),
                dataType : 'json',
                success : function(data) {
                    var temp = "<select name='POST_LEVEL' id='POST_LEVEL' style='width: 180px;height:20px;font-size: 15px;'>";
                    $.each(
                        data.Rows,
                        function(i, item) {
                            temp = temp+"<option value=\""+item.POST_GRADE_ID+"\">"+item.POST_GRADE_NAME+"</option>";
                        }
                    )
                    temp = temp+"</select>";
                    /* var levels = document.getElementById("POST_LEVEL");
                    alert(levels.innerHTML); */
                    $("#levelSpan").html(temp);
                },
                error : function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }
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
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="hrms.hire" /></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message
                                    code="hrms.application" /></a></td>
                    </tr>
                </table>
                <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="10%" class="l-table-edit-t"><spring:message code="hrms.empid" /><font color="red">*</font></td>
                        <td width="20%" class="l-table-edit-c"><input type="text"
                            name="EMPID" id="EMPID" maxlength="8" size="30" onkeyup="spf_checkEmpID();"
                            onafterpaste="this.value=this.value.replace(/\D/g,'')" />
                            <span id="Tip" style="color: red; font-size: 12px;"></span></td>
                        <td width="10%" class="l-table-edit-t"><spring:message code="hrms.dept" /><font color="red">*</font></td>
                        <td width="50%" class="l-table-edit-c"><SipingSoft:deptTree name="DEPTID" limit="all"/></td>
                    </tr>
                </table>
                <br>
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td width="10%" class="l-table-edit-t"><spring:message
                                    code="hrms.cName" /><font color="red">*</font></td>
                            <td width="20%" class="l-table-edit-c"><input type="text"
                                name="CHINESENAME" id="CHINESENAME" value=""
                                validate="{required:true}" /></td>
                            <td width="10%" class="l-table-edit-t"><spring:message
                                    code="hrms.eName" /></td>
                            <td width="20%" class="l-table-edit-c"><input type="text"
                                name="ENGLISHNAME" id="ENGLISHNAME" value=""
                                validate="{required:true}" /></td>
                            <td width="10%" class="l-table-edit-t"><spring:message code="hrms.IDnumber"/><font
                                color="red">*</font></td>
                            <td width="20%" class="l-table-edit-c"><input type="text"
                                name="IDCARD_NO" id="IDCARD_NO" value="" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message code="hrms.post" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectPost name="POST_ID" limit="all" onChange="spf_getPostLevel()"/></td>
                            <td class="l-table-edit-t"><spring:message code="hrms.jobLevel" /><font color="red">*</font></td>
                            <td class="l-table-edit-c">
                                <span id="levelSpan">
                                    <select name="POST_LEVEL" id="POST_LEVEL">
                                        <option value=""><spring:message code="hrms.selection" /></option>
                                    </select>
                                </span>
                            </td>
                            <%-- <td class="l-table-edit-t"><spring:message code="hrms.positionalTitle" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="PosiTitleTypeCode" name="PT_ID"
                                    selected="WorkingOtType01" limit="all" /></td> --%>
                            <td class="l-table-edit-t"><spring:message code="hrms.EmpStatus" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode
                                    parentCode="EmpStatus" name="STATUS_CODE" limit="all" /></td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.empDivision" /><font color="red">*</font></td>
                            <td class="l-table-edit-c" ><SipingSoft:selectSyCode
                                    parentCode="EmpDivision" name="EMP_TYPE_CODE" /></td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.hireDate" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="JOIN_DATE" id="JOIN_DATE" value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false})" />
                            </td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.endProbationDate" /><font color="red">*</font></td>
                            <td class="l-table-edit-c" colspan="3"><input type="text"
                                name="END_PROBATION_DATE" id="END_PROBATION_DATE"
                                value="${currentDate}"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false})" />
                            </td>
                        </tr>
                    </table>
                    </form>
            </div>
        </div>
    </div>
</body>
</html>