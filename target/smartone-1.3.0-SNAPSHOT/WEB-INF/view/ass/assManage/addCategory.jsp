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
<script src="/resources/js/jquery/jquery.validate.min.js"  type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js"   type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $dialog;
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            topHeight : 100,
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
    });

    function f_save() {
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url : '/ass/assManage/addCategory',
                type : 'POST',
                success : function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>',
                            function() {
                                parent.spf_categorySuccess();
                            });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','<spring:message code="ass.createFailedBecause"/>：' + result);
                    }
                }
            };
            $('#form1').ajaxSubmit(options);
        }
    }
    function spf_checkData() {
        if ($("#CODE_NAME").val() == null || $("#CODE_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                '<spring:message code="AssetClasses"/>' + ". "+ '<spring:message code="input.required"/>');
            $("#CODE_NAME").focus()
            return false;
        }
        return true;
    }
    function spf_checkCategoryName(){
        var codeName = $("#CODE_NAME").val(); 
        $.post('/ass/assManage/checkCategoryName',{"CODE_NAME":codeName},function(back){  
            $('#TipName').html(back);
        });
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
<body>
    <div id="layout1">
        <div position="top">
            <div id="inputID">
            <form name="form1" id="form1" action="">
                <table width="99.6%" height="99.6%"align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="40%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.assetClasses"/><font
                            color="red">*</font></td>
                        <td width="50%" class="l-table-edit-c" nowrap="nowrap"><input
                            type="text" name="CODE_NAME" id="CODE_NAME" size="30"
                            onchange="spf_checkCategoryName();" /> <span id="TipName"
                            style="color: red; font-size: 12px;"></span></td>
                    </tr>
                    <tr>
                        <td width="40%" class="l-table-edit-t"><spring:message code="ass.engliseName"/></td>
                        <td width="50%" class="l-table-edit-c"><input type="text"
                            name="CODE_EN_NAME" id="CODE_EN_NAME" size="30" /></td>
                    </tr>
                    <tr>
                        <td height="30px;" colspan="2"><a class="l-button"
                            style="width: 79px; height: 20px; float: left; margin-left: 1px;"
                            onclick="f_save()"><spring:message code="hrms.save" /></a></td>
                    </tr>
                </table>
            </form>
            </div>
        </div>
    </div>
</body>
</html>
