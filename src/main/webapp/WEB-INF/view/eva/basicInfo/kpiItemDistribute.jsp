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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"  type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
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
        spf_initGrid_kpiItem();
    });
    /*
    *弹出框收缩js
    */ 
    $(function (){
        $("#POSTNAME").ligerComboBox({
            onBeforeOpen: spf_selectPost, valueFieldID: 'POST_ID',width:150
        });
    });
    function spf_selectPost(){
        $.ligerDialog.open({ 
            title: '<spring:message code="eva.positionInformation"/>',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/utility/postInfo/searchPost', 
            buttons: [
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
        $("#POST_ID").val(data.POST_ID);
        $("#POSTNAME").val(data.POST_NAME+'['+data.POST_ID+']');
        $("#POSITION_NAME").html(data.POSITION_NAME);
        $("#POST_GROUP_NAME").html(data.POST_GROUP_NAME);
        spf_initGrid_kpiItem();
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#POSTNAME").html("");
        $("#POST_ID").val("");
        $("#POST_GROUP_NAME").html("");
        $("#POSTITION_NAME").html("");
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
                { display: '<spring:message code="eva.calculation"/>', name: 'EVA_KPI_NAME', width:120},
                { display: '<spring:message code="eva.definition"/>', name: 'KPI_DEFINE', width: 200,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.calculation1"/>', name: 'CAL_DES', width: 200,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.appraisalStandards"/>', name: 'KPI_STANDARD',width:100},
                { display: '<spring:message code="hrms.productCategory"/>', name: 'EVA_TYPE_NAME',width:120},
                { display: '<spring:message code="eva.theMinimumsScore"/>', name: 'MIN_SCORE',width:80},
                { display: '<spring:message code="eva.theMaximumScore"/>', name: 'MAX_SCORE',width:80}
            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/eva/kpi/getKpiItemByMonth',
            parms: [
                { name: 'POST_ID',value: $("#POST_ID").val()},
                { name: 'PA_MONTH',value: paMonth},
                { name: 'EMPID',value: ""}
            ],
            width: '99%', height: '99.8%',pageSize:20,
        });
    }

    function spf_addKpiItem(){
        var postId = $("#POST_ID").val();
        if(postId == ""){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.pleaseSelectJobs"/>') ; 
             return ; 
        }
        var paMonth = $("#year").val() + $("#month").val();
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="eva.calculation"/>',
            width: 1000, height: 500, 
            url: '/eva/basicInfo/viewUnuseKpiItem?paMonth='+paMonth+'&postId='+postId
        });
    }

    function spf_deleteKpiItem(){
        var rows = $grid_d.getCheckedRows(); 
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    var paMonth = $("#year").val() + $("#month").val();
                    var jsonData = '[' ; 
                    $(rows).each(function (index, row){
                         if (jsonData.length > 1){
                            jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         }  
                         jsonData += ' "EVA_KPI_ID": "' + this.EVA_KPI_ID + '",';
                         jsonData += ' "POST_ID": "' + $("#POST_ID").val() + '",';
                         jsonData += ' "PA_MONTH": "' + paMonth + '"';
                         jsonData += '}' ;  
                    }); 
                    jsonData += ']' ;  
                    if(jsonData.length == 2){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                        return ;
                    } 
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/eva/kpi/deleteDistriKpiItemInfo", 
                        [   
                            { name: 'jsonData', value: jsonData }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid_d.loadData(true); //加载数据 
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
    }

    function d_ChildWindowClose(){
        $grid_d.loadData(true);
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
        <div position="center" id=' ' title=' '>
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="eva.positionInformation"/></td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr height="30">
                    <td width="10%" class="l-table-edit-t" ><spring:message code="hrms.post"/></td>
                    <td width="20%" class="l-table-edit-c" >
                        <input type="text" name="POSTNAME" id="POSTNAME" value=""/>
                        <input type="hidden" name="POST_ID" id="POST_ID" value="${basicInfo.EMPID }"/>
                    </td>
                    <td width="10%" class="l-table-edit-t" ><spring:message code="hrms.position"/></td>
                    <td width="20%" class="l-table-edit-c" >
                        <label id="POSITION_NAME"></label></td>
                    <td width="10%" class="l-table-edit-t" ><spring:message code="hrms.postGroup"/></td>
                    <td width="20%" class="l-table-edit-c" >
                        <label id="POST_GROUP_NAME"></label></td>
                </tr>
            </table>
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="eva.calculation"/></td>
                    <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" align="center" cellpadding="0" cellspacing="0"
                class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="eva.assessmentMonth"/></td>
                    <td width="20%" class="l-table-edit-c"><SipingSoft:date
                            yearName="year" monthName="month"
                            onChange="spf_initGrid_kpiItem();" /></td>
                    <td width="60%" align="right" height="30px">
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_deleteKpiItem()"><spring:message code="hrms.delete"/></a> 
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_addKpiItem()"><spring:message code="eva.add"/></a></td>
                </tr>
            </table>
            <br/>
            <div position="center" id='kpiItemInfo'
                title='<spring:message code="eva.calculation"/>'></div>
        </div>
    </div>
</body>
</html>