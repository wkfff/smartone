<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    var isNotNull = true;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        var dataColumnsList = ${dataColumnsList};
        var colums = [];
        $(dataColumnsList).each(function(index, row) {
            colums.push({
                display : row.TITLE_NAME,
                name : row.TITLE_CODE,
                width : 120
            });
        });
        f_initGrid(colums);
    });

    function f_initGrid(colums) {
        $grid = $("#contractInfo").ligerGrid({
            columns : colums,
            enabledEdit : false,
            usePager : true,
            rownumbers : true,
            url : '/hrm/infoStatistical/getTmpInfoList',
            width : '99.6%',
            height : '95%',
            heightDiff : 0
        });
    }


    function checkNull(row){
        if(row.EMPID==null||row.CHINESENAME==null||row.IDCARD_NO==null
                ||row.JOIN_DATE==null||row.STATUS_CODE==null||row.DEPTID==null
                ||row.EMP_TYPE_CODE==null||row.POST_ID==null){
            return true;
        }
        return false;
    }

    function checkNotNull(){
        if(!isNotNull){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '带*的为必填信息，必须输入！');
            return false;
        }
        return true;
    }

    function spf_saveEmpTmpInfo() {
        for(var i=0;i<$grid.rows.length;i++){
            var row = $grid.rows[i];
            if(row.FLAG=='新增'){
                if(checkNull(row)){
                    isNotNull = false;
                }
            }
        }
        if(checkNotNull()){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url : '/hrm/infoStatistical/saveEmpTmpInfo',
                type : 'POST',
                success : function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            parent.spf_afterSaveSuccess();
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.failedToUploadReason"/>' + result);
                    }
                }
            };
            $('#form1').ajaxSubmit(options);
        }
    }
    function spf_cancelEmpTmpInfo() {
        parent.spf_closePreviewWindows();
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
        <div align="justify" id='contractInfo'></div>
        <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit" border="0xp" bordercolor="#A3C0E8">
            <tr>
                <td height="5px"></td>
            </tr>
            <tr>
                <td>
                    <div align="center">
                        <a class="l-button" style="width: 79px; height: 20px; " onclick="spf_saveEmpTmpInfo()"><spring:message
                                code="hrms.saveChanges" /></a>
                    </div>
                </td>
                <!-- margin-left:10px; float: left; -->
                <td>
                    <div align="center">
                        <a class="l-button" style="width: 79px; height: 20px; " onclick="spf_cancelEmpTmpInfo()"><spring:message
                                code="hrms.discardChanges" /></a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>
