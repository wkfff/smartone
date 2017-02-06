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
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.validate.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js"
    type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>

<script type="text/javascript">
        
    function f_save(){
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        var options = {                         
            url:'/system/basicMaintenance/updateCompanyInfo',
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
    <div id='layout1'>
        <form name="form1" method="post" action="" id="form1">
            <table width="99.6%" cellpadding="0" cellspacing="0"
                class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td class="l-table-edit-t">
                        <!-- 主键-->
                        <spring:message code="hrms.primaryKey" />
                    </td>
                    <td class="l-table-edit-c">${companyInfo.CPNY_ID } <input
                        name="CPNY_ID" type="hidden" id="CPNY_ID"
                        value="${companyInfo.CPNY_ID }" />
                    </td>
                    <td class="l-table-edit-t"><spring:message code="hrms.active" /></td>
                    <td class="l-table-edit-c"><SipingSoft:selectStatus
                            name="ACTIVITY" selected="${companyInfo.ACTIVITY }" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message
                            code="hrms.chineseName" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_NAME" type="text"
                        id="CPNY_NAME" value="${companyInfo.CPNY_NAME }" ltype="text"
                        validate="{required:true}" /></td>
                    <td class="l-table-edit-t"><spring:message
                            code="hrms.englishName" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_EN_NAME"
                        type="text" id="CPNY_EN_NAME" value="${companyInfo.CPNY_EN_NAME }"
                        ltype="text" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message
                            code="hrms.location" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_LOCATION"
                        type="text" id="CPNY_LOCATION"
                        value="${companyInfo.CPNY_LOCATION }" ltype="text" /></td>
                    <td class="l-table-edit-t"><spring:message code="hrms.address" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_ADDR" type="text"
                        id="CPNY_ADDR" value="${companyInfo.CPNY_ADDR }" ltype="text" />
                    </td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message
                            code="hrms.postalcode" /></td>
                    <td class="l-table-edit-c"><input
                        name="CPNY_IDCARD_POSTALCODE" type="text"
                        id="CPNY_IDCARD_POSTALCODE"
                        value="${companyInfo.CPNY_IDCARD_POSTALCODE }" ltype="text" /></td>
                    <td class="l-table-edit-t"><spring:message code="hrms.website" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_WEB_ADDR"
                        type="text" id="CPNY_WEB_ADDR"
                        value="${companyInfo.CPNY_WEB_ADDR }" ltype="text" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="hrms.fax" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_FAX_NO"
                        type="text" id="CPNY_FAX_NO" value="${companyInfo.CPNY_FAX_NO }"
                        ltype="text" /></td>
                    <td class="l-table-edit-t"><spring:message
                            code="hrms.telephone" /></td>
                    <td class="l-table-edit-c"><input name="CPNY_TEL_NO"
                        type="text" id="CPNY_TEL_NO" value="${companyInfo.CPNY_TEL_NO }"
                        ltype="text" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="hrms.intro" /></td>
                    <td class="l-table-edit-c" colspan="3"><textarea cols="100"
                            rows="4" name="CPNY_INTRO" id="CPNY_INTRO" style="width: 400px">${companyInfo.CPNY_INTRO }</textarea>
                    </td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="hrms.history" /></td>
                    <td class="l-table-edit-c" colspan="3"><textarea cols="100"
                            rows="4" name="CPNY_HISTORY" id="CPNY_HISTORY"
                            style="width: 400px">${companyInfo.CPNY_HISTORY }</textarea></td>
                </tr>
                <tr>
                    <td class="l-table-edit-cc" colspan="4" height="30px">
                        <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 1px; "
                            onclick="f_save()"><spring:message code="submit" /></a>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>