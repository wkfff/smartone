<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog = null;
    //初始化数据
    $(function() {
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        spf_refreshProcessButton();
    });

    function spf_refreshProcessButton(){
        if($("#MODEL_ID").val() == null || $("#MODEL_ID").val() == ''){
            $("#processOperate").attr("onClick","spf_addModel()");
            $("#processOperate").html("添加审批");
            $("#processEdit").hide();
        } else {
            $("#processOperate").attr("onClick","spf_deleteModel()");
            $("#processOperate").html("取消审批");
            $("#processEdit").show();
        }
    }

    function spf_save() {
        if ($('#PROCESS_ITEM_NO').val() == null || $('#PROCESS_ITEM_NO').val() == '') {
            return;
        }
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var $itemJson ={};

            $itemJson.no = $("#PROCESS_ITEM_NO").val()
            $itemJson.type = {};
            $itemJson.type.no = $('#OBJECT_TYPE_NO').val();
            $itemJson.state = {};
            $itemJson.state.no = $("#STATUS_NO").val();
            $itemJson.nextState = {};
            $itemJson.nextState.no = $("#SUC_STATUS_NO").val();
            $itemJson.preState1 = {};
            $itemJson.preState1.no = $("#PRE_STATUS_NO1").val();
            $itemJson.preState2 = {};
            $itemJson.preState2.no = $("#PRE_STATUS_NO2").val();
            $itemJson.preState3 = {};
            $itemJson.preState3.no = $("#PRE_STATUS_NO3").val();
            $itemJson.stateType = $("#STATUS_TYPE_CODE").val();
            $itemJson.processModel = {};
            $itemJson.processModel.id = $("#MODEL_ID").val();

            $.post("/process/objectType/transferProcessItem", [{
                name : 'jsonData',
                value : JSON.stringify($itemJson)}],
                function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == 0) {
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            parent.$statusgrid.loadData(true);
                            parent.$dialog.close();
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                    }
            });
        }
    }

    function spf_checkData() {
        if ($("#PROCESS_ITEM_NO").val() == null || $("#PROCESS_ITEM_NO").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '状态名称' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        return true;
    }

    function spf_deleteModel(){
        var isDeleted = true;
        if($("#MODEL_ID").val()!=null && $("#MODEL_ID").val() != ''){
            console.log($("#MODEL_ID").val());
            $.ajax({
                type: 'POST',
                async: false,
                url: '/process/objectType/deleteModel',
                data: 'modelId='+$("#MODEL_ID").val(),
                success: function(result){
                    $("#MODEL_ID").val("");
                    isDeleted = (result.code == 0);
                }
            });
        }
        spf_refreshProcessButton();
        return isDeleted;
    }

    function spf_addModel() {
        if ($("#MODEL_ID").val() == null || $("#MODEL_ID").val() == '') {
            $.post("/process/objectType/createNewModel", [ {
                name : 'key',
                value : Math.random()
            } ], function(result) {
                if (result.code == 0) {
                    $("#MODEL_ID").val(result.message);
                    spf_refreshProcessButton();
                    window.open("/activiti/service/editor?id=" + result.message, 'height=280,width=400,top=100,left=100,location=no,toolbar=no');
                } else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                }
            });
        }
    }

    function spf_editModel() {
        if ($("#MODEL_ID").val() != null && $("#MODEL_ID").val() != '') {
            window.open("/activiti/service/editor?id=" + $("#MODEL_ID").val(), 'height=280,width=400,top=100,left=100,location=no,toolbar=no');
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
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <input type="hidden" name="PROCESS_ITEM_NO" id="PROCESS_ITEM_NO" value="${processItem.no}" />
        <input type="hidden" name="OBJECT_TYPE_NO" id="OBJECT_TYPE_NO" value="${paramMap.typeNo}" />
        <input type="hidden" name="MODEL_ID" id="MODEL_ID" value="${processItem.processModel.id}" />
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;">基本信息</td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><a class="l-button" id="processOperate" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_addModel()"></a>
                <a class="l-button" id="processEdit" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_editModel()">编辑流程</a></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="15%" class="l-table-edit-t">状态<font color="red">*</font></td>
                <td width="35%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="STATUS_NO" selected="${processItem.state.no}" /></td>
                <td width="15%" class="l-table-edit-t">状态类型</td>
                <td width="35%" class="l-table-edit-c"><Static:stateType name="STATUS_TYPE_CODE" selected="${processItem.stateType.id}" /></td>
            </tr>
            <tr>
                <td width="15%" class="l-table-edit-t">成功状态</td>
                <td width="35%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="SUC_STATUS_NO" objectTypeNo="${paramMap.typeNo}" selected="${processItem.nextState.no}" limit="all" /></td>
                <td width="10%" class="l-table-edit-t">是否可用</td>
                <td width="20%" class="l-table-edit-c"><Static:isActive name="ACTIVITY" selected="true" /></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t">返回状态1</td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="PRE_STATUS_NO1" objectTypeNo="${paramMap.typeNo}" selected="${processItem.preState1.no}" limit="all" /></td>
                <td width="10%" class="l-table-edit-t">返回状态2</td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="PRE_STATUS_NO2" objectTypeNo="${paramMap.typeNo}" selected="${processItem.preState2.no}" limit="all" /></td>
                <td width="10%" class="l-table-edit-t">返回状态3</td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="PRE_STATUS_NO3" objectTypeNo="${paramMap.typeNo}" selected="${processItem.preState3.no}" limit="all" /></td>
            </tr>
        </table>
    </div>
</body>
</html>
