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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $affirmor_grid ;
    var $detail_grid ;
    var $Flag = "detail";
    var $expDetailTypeSelectList ;
    // 费用项目列表
    $(function (){
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,      //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        $expDetailTypeSelectList = getExpDetailTypeSelectList();
        spf_detail_initGrid();
        $("#EMP_NAME").ligerComboBox({
            onBeforeOpen: spf_selectEmp, valueFieldID: 'MANID',width:150
        });
        $("#PROJECT").ligerComboBox({
            onBeforeOpen: spf_selectPro, valueFieldID: 'PROJECT_ID',width:150
        });
    });
    // 搜索员工弹窗
    function spf_selectEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>',
            name:'empselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/empInfo/viewHrSearchEmployeeB',
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
            ]
        });
        return false;
    }
    // 搜索项目弹窗
    function spf_selectPro(){
        $.ligerDialog.open({
            title: '<span>项目信息</span>',
            name:'empselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/otherInfo/viewProSearch?EMPID='+$('#EMPID').val(),
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK_pro },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_pro },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear_pro }
            ]
        });
        return false;
    }

    function spf_selectOK_pro(item, dialog){
        var fn = dialog.frame.spf_selectRroInfo || dialog.frame.window.spf_selectRroInfo;
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#PROJECT").val(data.PRO_NAME);
        $("#PROJECT_ID").val(data.PRO_NO);
        dialog.close();
    }
    function spf_selectCancel_pro(item, dialog){
        dialog.close();
    }
    function spf_selectClear_pro(item, dialog){
        $("#PROJECT").val('');
        $("#PROJECT_ID").val('');
        dialog.close();
    }

    function spf_selectOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#EMP_NAME").val(data.CHINESENAME);
        $("#MANID").val(data.EMPID);
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#EMP_NAME").val('');
        dialog.close();
    }

    function getExpDetailTypeSelectList(){
        var expTypeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getExpDetailTypeSelectList',
            dataType: 'json',
            async: false,
            success: function (list){
                expTypeSelectList = list;
            }
        });
        return expTypeSelectList ;
    }

    function spf_affirmor_initGrid(){
        $affirmor_grid = $("#affirmorInfo").ligerGrid({
         checkbox: false,
            columns: [
            { display: '<spring:message code="hrms.empid"/>', name: 'AFFIRMOR_ID',hide:1},
            { display: '<spring:message code="hrms.name"/>', name: 'AFFIRMOR_NAME'},
            { display: '<spring:message code="hrms.approvalLevel"/>', name: 'AFFIRM_LEVEL'}
            ],
            usePager: false, rownumbers:true,
            url: '/ess/infoApp/getAffirmorList?appType=BTApply',
            parms: [{ name: 'EMPID', value: $("#EMPID").attr('value')},
                    { name: 'EXP_TYPE_CODE', value: $("#EXP_TYPE_CODE").attr('value')}
                ],
            width: '98%', height: '99%'
        });
    }
    function spf_detail_initGrid()
    {
        $detail_grid = $("#detailInfo").ligerGrid({
         checkbox: false,
            columns: [
            {display: '<spring:message code="hrms.expType"/>', name: 'EXP_TYPE_CODE', align: 'center', width: 130,isSort: false,
                editor: {
                    type: 'select', data: $expDetailTypeSelectList, dataValueField: 'EXP_TYPE_CODE',dataDisplayField: 'EXP_TYPE_NAME',
                    displayColumnName: 'EXP_TYPE_NAME', valueColumnName: 'EXP_TYPE_CODE'
                }, render: function (item) {
                    for (var i = 0; i < $expDetailTypeSelectList.length; i++)
                    {
                        if ($expDetailTypeSelectList[i]['EXP_TYPE_CODE'] == item.EXP_TYPE_CODE)
                            return $expDetailTypeSelectList[i]['EXP_TYPE_NAME'];
                    }
                    return item.EXP_TYPE_NAME;
                }
            }]
        });
    }

    function spf_application(){
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
            $.post("/ess/infoApp/addExpApp",
                    [
                        { name: 'EMPID', value: $("#EMPID").val() },
                        { name: 'EXP_TYPE_CODE', value: $("#EXP_TYPE_CODE").val() },
                        { name: 'EXP_REMARK', value: $("#EXP_REMARK").val() },
                        { name: 'appType', value: 'ExpApply'},
                        { name: 'moneyamount', value: $("#MONEYAMOUNT").val() },
                        { name: 'START_DATE', value: $("#START_DATE").val() },
                        { name: 'PROJECT_ID', value: $("#PROJECT_ID").val() },
                        { name: 'MANID', value: $("#MANID").val() }
                    ],
            function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.applySuccess.waitingApproval"/>',
                        '<spring:message code="hrms.warning"/>', function (){
                        //  $detail_grid.loadData(true); //加载数据
                            $("#MONEYAMOUNT").val('');
                            $("#EXP_REMARK").val('');
                        });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_checkData(){
        var expTypeCode = $("#EXP_TYPE_CODE").val();
        var moneyamount = $("#MONEYAMOUNT").val();
        var EMP_NAME = $("#EMP_NAME").val();
        var PROJECT = $("#PROJECT").val();
        var START_DATE = $("#START_DATE").val();
        if (expTypeCode == null || expTypeCode == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.expType"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (moneyamount == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.amountOfMoney"/>'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (isNaN(moneyamount)) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.amountOfMoney"/>'+". " + '<spring:message code="input.number"/>') ;
            return false;
        }
        if (moneyamount<0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.amountOfMoney"/>'+". " + '<spring:message code="productStorage.pleaseEnterAPositiveNumber"/>') ;
            return false;
        }
        if (EMP_NAME == null || EMP_NAME == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '负责人'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        if (START_DATE == null || START_DATE == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '开报销时间'+". " + '<spring:message code="input.required"/>') ;
            return false;
        }
        return true;
    }
    function f_ChildWindowClose (){
        $affirmor_grid.loadData(true); 
    }

    function spf_getBTDuration(){
         var empID = $("#EMPID").val();
         $.post('/utility/otherInfo/getBTDurationInfo',{"EMPID": empID},function(result){
             spf_setBTDuration(result);
        });
    }

    function spf_setBTDuration(result){
        var index = "0";
        clearSel(document.getElementById("BT_NO")); //清空城市
        var BT_NO = document.getElementById("BT_NO");
        var jsonList = eval("(" + result + ")");
        var option = new Option('<spring:message code="hrms.selection"/>',"");
        BT_NO.options.add(option);
        for(var i=0;i<jsonList.length;i++){
            var value = "0";var text = "0";
            for(var key in jsonList[i]){
                    if(key == "ID")
                        value = jsonList[i][key];
                    if(key == "Name")
                        text = jsonList[i][key];
            }
            option = new Option(text,value);
            BT_NO.options.add(option);
            }
    }

    function clearSel(oSelect){
        while(oSelect.childNodes.length>0){
            oSelect.removeChild(oSelect.childNodes[0]);
        }
    }

    // function spf_checkDiv() {
    //     var expTypeCode = $("#EXP_TYPE_CODE").val();
    //     if(expTypeCode == "ExpTypeCode002" ){
    //         document.getElementById("BT_NO").disabled = true;
    //     }else{
    //         document.getElementById("BT_NO").disabled = false;
    //     }
    // }

    function spf_add() {
        if($Flag == "detail"){
            $detail_grid.addRow();
        }
    }

    function spf_delete() {
        if($Flag == "detail"){
            $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
            {
                if(yes){
                    var rows = $detail_grid.getSelectedRow();
                    if (!rows || rows.length == 0) {
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                        return ;
                    }
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post('/ess/viewApp/delExpDetailInfo',
                        [
                                { name: 'EMPID', value: $("#EMPID").attr('value')},
                                { name: 'BT_NO', value: $("#BT_NO").attr('value')},
                                { name: 'EXP_TYPE_CODE',value: rows.EXP_TYPE_CODE},
                                { name: 'EXP_FROM_TIME',value: MyToDate(rows.EXP_FROM_TIME)},
                                { name: 'EXP_TO_TIME',value: MyToDate(rows.EXP_TO_TIME)}
                        ]
                    , function (result) {
                        $.ligerDialog.closeWaitting();
                        if (result == "Y") {
                            $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                            {
                                $detail_grid.loadData(true); //加载数据
                            });
                        } else {
                            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                        }
                    });
                }
            });
        }
    }
</script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
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
                            <span>报销申请</span>
                        </td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;"><a class="l-button"
                            style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; "
                            onclick="spf_application()"><spring:message
                                    code="hrms.application" /></a></td>
                    </tr>
                </table>
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" align="center" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t" width="15%">
                                <span>负责人</span>
                                <font color="red">*</font>
                            </td>
                            <td class="l-table-edit-c" width="35%"><input type="text" name="EMP_NAME" id="EMP_NAME" value="" validate="{required:true}" />
                            <input type="hidden" name="MANID" id="MANID" value="" />
                            </td>    
                            <td width="15%" class="l-table-edit-t">
                                <span>报销人</span>
                                <font color="red">*</font>
                            </td>
                            <td class="l-table-edit-c" width="35%"><input type="text" name="EMP_NAME" id="EMP_NAME" value="${basicInfo.CHINESENAME}" validate="{required:true}" readonly="true" /> <input type="hidden" name="EMPID"
                                id="EMPID" value="${basicInfo.EMPID}" /></td>   
                        </tr>
                        <tr>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.expType" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><SipingSoft:selectSyCode
                                    parentCode="ExpTypeCode" name="EXP_TYPE_CODE"
                                    onChange="spf_detail_initGrid();" limit="all" />
                            </td>
                            <td class="l-table-edit-t" width="15%">
                                <span>项目</span>
                                <font color="red">*</font>
                            </td>
                            <td class="l-table-edit-c" width="35%"><input type="text" name="PROJECT" id="PROJECT" value="" validate="{required:true}" /> <input type="hidden" name="PROJECT_ID"
                                id="PROJECT_ID" value="" /></td>    
                        </tr>
                        <tr>
                            <td class="l-table-edit-t" width="15%">
                                <span>报销日期</span>
                                <font color="red">*</font>
                            </td>
                            <td class="l-table-edit-c"><input type="text" name="START_DATE" id="START_DATE"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})" validate="{required:true}" value=''/></td>
                            <td class="l-table-edit-t"><spring:message
                                    code="hrms.amountOfMoney" /><font color="red">*</font></td>
                            <td class="l-table-edit-c"><input type="text"
                                name="MONEYAMOUNT" id="MONEYAMOUNT" /></td>   
                        </tr>
                        <tr>
                            <td width="15%" class="l-table-edit-t">
                                <span>备注</span>
                            </td>
                            <td width="85%" class="l-table-edit-c" colspan="3"><textarea
                                    rows="" cols="" style="height: 100px; width: 600px"
                                    id="EXP_REMARK" name="EXP_REMARK"></textarea></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>
</body>
</html>