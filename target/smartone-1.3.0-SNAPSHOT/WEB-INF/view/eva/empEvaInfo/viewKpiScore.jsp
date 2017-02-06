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
<script src="/resources/js/ligerUI/js/core/base.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    var $dialog;
    var $grid_d ; 
    var $grid_i ; 
    var paramNo = "" ;
    var paMonth = "";
    var lockFlag = "0" ;
    var $dialogUpload;
    $.ligerDefaults.Grid.editors['textarea'] = {
            create: function (container, editParm){
                var input = $("<textarea class='l-textarea' />");
                container.append(input);
                return input;
            },
            getValue: function (input, editParm){
                return input.val();
            },
            setValue: function (input, value, editParm){
                input.val(value);
            },
            resize: function (input, width, height, editParm){
                var column = editParm.column;
                if (column.editor.width) input.width(column.editor.width);
                else input.width(width);
                if (column.editor.height) input.height(column.editor.height);
                else input.height(height);
            }
        };
    $(function (){
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        if($("#month").val()==1){
            //如果是1月份，则退年，月归12
            $("#year").val($("#year").val()-1);
            $("#month").val(12);
        }else{
            $("#month").val($("#month").val()-1);
        }
        spf_initGrid_kpiItem();
        spf_lockFlag();
    });
    /*
    *弹出框收缩js
    */ 
    $(function (){
        $("#EMPID_NAME").ligerComboBox({
            onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
        });
    });
    function spf_lockFlag() {
        var paMonth = $("#year").val() + $("#month").val();
        $.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=INS_LOCK_FLAG&PA_MONTH=' + paMonth,
        function(back) {
            lockFlag = back;
        });
    }
    function spf_selectEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB',
            buttons:[
                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                    { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                    ]
        });
        return false;
    }
    function spf_selectOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#EMPID").val(data.EMPID);
        $("#EMPID_NAME").val(data.CHINESENAME+'['+data.EMPID+']');
        $("#POSTNAME").html(data.POST_NAME);
        $("#DEPTNAME").html(data.DEPTNAME);
        spf_initGrid_kpiItem();
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#EMPID").val("");
        $("#EMPID_NAME").val("");
        $("#POSTNAME").html("");
        $("#DEPTNAME").html("");
        spf_initGrid_kpiItem();
        dialog.close();
    }
    function spf_initGrid_kpiItem(){
        var paMonth = $("#year").val() + $("#month").val();
        $grid_d = $("#kpiItemInfo").ligerGrid({
            checkbox: true,
            columns: [
                { display: '', name: 'EVA_KPI_NO', width: 10,hide: 1},
                { display: '<spring:message code="eva.indexID"/>', name: 'EVA_KPI_ID', width: 10,hide: 1},
                { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width:100,hide: 1 },
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width:100,frozen:true},
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width:100,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width:100,frozen:true},
                { display: '<spring:message code="eva.calculation"/>', name: 'EVA_KPI_NAME', width:160,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.definition"/>', name: 'KPI_DEFINE', width: 160,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.calculation1"/>', name: 'CAL_DES', width: 120,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.appraisalStandards"/>', name: 'KPI_STANDARD',width:80},
                { display: '<spring:message code="eva.theMinimumsScore"/>', name: 'MIN_SCORE',width:80},
                { display: '<spring:message code="eva.theMaximumScore"/>', name: 'MAX_SCORE',width:80},
                { display: '<spring:message code="eva.score"/>', name: 'SCORE',width:80,editor: { type: 'float'}},
                { display: '<spring:message code="eva.ratingsExplained"/>', name: 'DESCRIPTION',width:120,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.assessmentPeople"/>', name: 'VALIDATERNAME',width:80}
            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/eva/kpi/getKpiItemByMonth',
            parms: [
                { name: 'IS_SCORE',value: 'yes'},
                { name: 'PA_MONTH',value: paMonth},
                { name: 'validaterEmpId',value: '${validaterEmpId}'}
            ],
            width: '99%', 
            height: '99.8%',
            pageSize:20
        });
    }
    
    function spf_search() {
        var paMonth = $("#year").val() + $("#month").val();
        $grid_d.setOptions({
            parms : [
                        { name:'keyWord',value : $("#keyWord").val()}, 
                        { name:'DEPTID',value : $("#DEPTID").val()},
                        { name: 'IS_SCORE',value: 'yes'},
                        { name: 'PA_MONTH',value: paMonth},
                        { name: 'validaterEmpId',value: '${validaterEmpId}'}
                    ],
            newPage:1
        });
        $grid_d.loadData(true);
    }
    
    function spf_save(){
        var paMonth = $("#paYear").val() + $("#paMonth").val();
        spf_lockFlag();
        if (lockFlag == '0') {
            var rows = $grid_d.getCheckedRows(); 
            if (!rows || rows.length == 0) { 
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                 return ; 
            }
            var paMonth = $("#year").val() + $("#month").val();
            var jsonData = '[' ;
            var w = "";
            var flag = true;
            $(rows).each(function (index, row){
                if (jsonData.length > 1){
                    jsonData += ',{' ;
                }else{
                    jsonData += '{' ;
                }
                if (this.SCORE>this.MAX_SCORE) { 
                    w = '<spring:message code="eva.Ratinggreater"/>';
                    flag = false;
                    return ; 
                }
                if (this.SCORE<this.MIN_SCORE) { 
                    w = '<spring:message code="eva.ScoreLess"/>';
                    flag = false;
                    return ; 
                }
                var des = (""+this.DESCRIPTION).replace(/\n/g,"");
                if(des == null||des == "null"){
                    des = "";
                }
                jsonData += ' "EVA_KPI_ID": "' + this.EVA_KPI_ID + '",';
                jsonData += ' "EMPID": "' + this.EMPID + '",';
                jsonData += ' "PA_MONTH": "' + paMonth + '",';
                jsonData += ' "SCORE": "' + this.SCORE + '",';
                jsonData += ' "DESCRIPTION": "' + des + '",';
                jsonData += ' "VALIDATER_ID": "' + '${validaterEmpId}' + '"';
                jsonData += '}' ;   
            });
            if(!flag){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', w) ;
                return;
            }
            jsonData += ']' ;
            if(jsonData.length == 2){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.saving"/>') ;
                return ;
            } 
            $.ligerDialog.waitting('<spring:message code="hrms.editData"/>');
            $.post("/eva/kpi/addKpiScoreInfo", 
                [   
                    { name: 'jsonData', value: jsonData }
                ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="eva.ratingsSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        $grid_d.loadData(true); //加载数据 
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        } else {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.performanceLocked"/>');
            return;
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
<body style="padding: 0px">
    <div id="layout1">
        <div id=' ' title=' '>
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp"
                bordercolor="#A3C0E8" style="margin-top:3px;">
                <tr>
                    <td class="l-table-edit-t" width="15%">
                        <spring:message code="keyWord" /></td>
                    <td width="35%" class="l-table-edit-c" >
                        <input width="120" type="text" name="keyWord" id="keyWord" />
                    </td>
                    <td width="15%" class="l-table-edit-t" >
                        <spring:message code="hrms.dept" /></td>
                    <td width="35%" class="l-table-edit-c" >
                        <%-- <SipingSoft:selectDept name="DEPTID"/> --%>
                        <SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="eva.assessmentMonth"/></td>
                    <td class="l-table-edit-c" colspan="3"><SipingSoft:date
                            yearName="year" monthName="month"
                            onChange="spf_initGrid_kpiItem();spf_lockFlag();" /></td>
                </tr>
            </table>
            
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                    </td>
                </tr>
            </table>
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="eva.assessmentScoring"/></td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <div position="center" id='kpiItemInfo'
                title='<spring:message code="eva.calculation"/>'></div>
        </div>
    </div>
</body>
</html>