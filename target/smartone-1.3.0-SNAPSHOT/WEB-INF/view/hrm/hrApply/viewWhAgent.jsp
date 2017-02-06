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
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js"
    type="text/javascript"></script>

<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDrag.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>

<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $sliceTypeSelectList ;
    $(function ()
            {
                //布局
                $("#layout1").ligerLayout({
                    topHeight: 220,
                    allowLeftResize: false,      //是否允许 左边可以调整大小
                    allowRightResize: false,     //是否允许 右边可以调整大小
                    allowTopResize: false,       //是否允许 头部可以调整大小
                    allowBottomResize: false     //是否允许 底部可以调整大小
                });
                //电焊和装配、下料工人不同报工申请方式
                $(".typeClass").click(function(){
                    var dname = $("input:checked").val()+"Div";
                    $("#"+dname).siblings().hide();
                    $("#"+dname).show(100);
                });
                $("#YESDiv").hide();
                spf_getSliceType();
                $sliceTypeSelectList = getSliceTypeSelectList();
        }
    );
    //获取切割方式数据，以list返回
    function getSliceTypeSelectList(){
        //请求服务器
        var sliceTypeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getSliceTypeSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
                sliceTypeSelectList = list ; 
            }
        });

        return sliceTypeSelectList ;
    } 
    //取出切割方式名称
    function spf_setSliceTypeName(parameterNo){ 
        var jsonList = $sliceTypeSelectList;
        for(var i=0;i<jsonList.length;i++){ 
            if(jsonList[i]['PARAMETER_NO'] == parameterNo) {
                return jsonList[i]['SLICE_TYPE_NAME'];
            };
        }
    }
    //取切割方式数据
    function spf_getSliceType(){
         //&callback=?"注意这个是为了解决跨域访问的问题    
        $.post('/utility/otherInfo/getSliceType',{},
            function(result){
                spf_setSliceType(result); 
            }
        );
    }
    //设置切割方式下拉列表
    function spf_setSliceType(result){ 
        clearSel(document.getElementById("PARAMETER_NO")); //清空城市
        var PARAMETER_NO = document.getElementById("PARAMETER_NO"); 
        var jsonList = eval("(" + result + ")");
        var option = new Option('<spring:message code="hrms.selection"/>',"");
        PARAMETER_NO.options.add(option); 
        for(var i=0;i<jsonList.length;i++){ 
            var value = "0";var text = "0";  
            for(var key in jsonList[i]){  
                    if(key == "ID") 
                        value = jsonList[i][key];  
                    if(key == "Name") 
                    text = jsonList[i][key];  
            }  
            option = new Option(text,value);
            PARAMETER_NO.options.add(option); 
        }
    }
    // 清空下拉列表
    function clearSel(oSelect){ 
        while(oSelect.childNodes.length>0){
            oSelect.removeChild(oSelect.childNodes[0]);
        } 
    }
    //设置电焊、装配报工申请员工选择页面
    $(function (){
        $("#EMPID_NAME_NO").ligerComboBox({
            onBeforeOpen: spf_selectEmp_no, valueFieldID: 'EMPID_NO',width:150
        });
    });
    function spf_selectEmp_no(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectEmpOK_no },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectEmpCancel_no },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectEmpClear_no }
                    ]
        });
        return false;
    }
    function spf_selectEmpOK_no(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#EMPID_NAME_NO").val(data.EMPID+","+data.CHINESENAME);
        $("#EMPID_NO").val(data.EMPID);  
        dialog.close();
    }
    function spf_selectEmpCancel_no(item, dialog){
        dialog.close();
    }
    function spf_selectEmpClear_no(item, dialog){
        $("#EMPID_NAME_NO").val("");
        $("#EMPID_NO").val(""); 
        dialog.close();
    }
    //设置下料工人报工申请员工选择页面
    $(function (){
        $("#EMPID_NAME_YES").ligerComboBox({
            onBeforeOpen: spf_selectEmp_yes, valueFieldID: 'EMPID_YES',width:150
        });
    });
    function spf_selectEmp_yes(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectEmpOK_yes },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectEmpCancel_yes },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectEmpClear_yes}
                    ]
        });
        return false;
    }
    function spf_selectEmpOK_yes(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#EMPID_NAME_YES").val(data.EMPID+","+data.CHINESENAME);
        $("#EMPID_YES").val(data.EMPID);  
        dialog.close();
    }
    function spf_selectEmpCancel_yes(item, dialog){
        dialog.close();
    }
    function spf_selectEmpClear_yes(item, dialog){
        $("#EMPID_NAME_YES").val("");
        $("#EMPID_YES").val(""); 
        dialog.close();
    }
     /*
    *项目弹出框收缩js(电焊、装配工人采用)
    */ 
    $(function (){ 
        $("#PROD_ID_NO").ligerComboBox({
            onBeforeOpen: spf_selectPro_no, valueFieldID: 'PROD_NO_NO',width:150
        });
    });
    function spf_selectPro_no(){
        $.ligerDialog.open({ 
            title: '<spring:message code="hrms.productionOrderInformation"/>', 
            name:'empselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/projInfo/viewSearchProductionOrder', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK_no },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_no },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear_no }
            ]
        });
        return false;
    }
    function spf_selectOK_no(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#PROD_ID_NO").val(data.PROD_ID);
        $("#PROD_NO_NO").val(data.PROD_NO);
        dialog.close();
    }
    function spf_selectCancel_no(item, dialog){
        dialog.close();
    }
    function spf_selectClear_no(item, dialog){
        $("#PROD_ID_NO").val('');
        $("#PROD_NO_NO").val('');
        dialog.close();
    }
     /*
    *项目弹出框收缩js(下料工人)
    */ 
    $(function (){ 
        $("#PROD_ID_YES").ligerComboBox({
            onBeforeOpen: spf_selectPro_yes, valueFieldID: 'PROD_NO_YES',width:150
        });
    });
    function spf_selectPro_yes(){
        $.ligerDialog.open({ 
            title: '<spring:message code="hrms.productionOrderInformation"/>', 
            name:'empselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/projInfo/viewSearchProductionOrder', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK_yes },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_yes },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear_yes }
            ]
        });
        return false;
    }
    function spf_selectOK_yes(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#PROD_ID_YES").val(data.PROD_ID);
        $("#PROD_NO_YES").val(data.PROD_NO);
        dialog.close();
    }
    function spf_selectCancel_yes(item, dialog){
        dialog.close();
    }
    function spf_selectClear_yes(item, dialog){
        $("#PROD_ID_YES").val('');
        $("#PROD_NO_YES").val('');
        dialog.close();
    }
    /*电焊、装配工人提交申请*/
    function spf_application_no()
    {
    $.ligerDialog.confirm('<spring:message code="hrms.submitReportToWork"/>','<spring:message code="hrms.warning"/>', 
        function (yes){
        if(yes){
            if(spf_checkData_no()){                   
                 $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                 $.post("/ess/infoApp/transferWorkingHoursInfo", 
                         [  
                            { name: 'type', value: 'add'},
                            { name: 'EMPID', value: $("#EMPID_NO").val()},
                            { name: 'PROD_NO', value: $("#PROD_NO_NO").val()},
                            { name: 'PROJ_PROS_TYPE_CODE', value: $("#PROJ_PROS_TYPE_CODE_NO").val()},
                        { name: 'START_DATE', value: $("#START_DATE_NO").val()},
                        { name: 'QUANTITY', value: $("#QUANTITY_NO").val()},
                            { name: 'WORK_CONTENT', value: $("#WORK_CONTENT_NO").val()},
                            { name: 'REMARK', value: $("#REMARK_NO").val()}
                          ]
                 , function (result)
                 {
                    $.ligerDialog.closeWaitting();
                     if (result == "Y")
                     {
                    	 $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            spf_selectEmpClear_no();
                        });
                     }
                     else
                     {
                         $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.saveNewspaperWorkersFailedReason"/>'+result);
                     }
                 });
            }
        }});
    }
    
    function spf_checkData_no()
    {     
        if ($("#PROD_NO_NO").val() == null || $("#PROD_NO_NO").val() == ""||$("#PROD_NO_NO").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.productionOrder"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#EMPID_NO").val() == null || $("#EMPID_NO").val() == ""||$("#EMPID_NO").val() == "0") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.numberOfEmployees"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       } 
        if ($("#PROJ_PROS_TYPE_CODE_NO").val() == null || $("#PROJ_PROS_TYPE_CODE_NO").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.process"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#START_DATE_NO").val() == null || $("#START_DATE_NO").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workersReportedDate"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#QUANTITY_NO").val() == null || $("#QUANTITY_NO").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workOrderAmount"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#WORK_CONTENT_NO").val() == null || $("#WORK_CONTENT_NO").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingDescription"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#REMARK_NO").val() == null) {  
            $("#REMARK_NO").val()=='';
        }
        return true;
    } 
    /*下料工人提交申请*/
    function spf_application_yes(){
        var sliceTypeName = spf_setSliceTypeName($("#PARAMETER_NO").val());
  
        var workContent = "<spring:message code="hrms.cuttingWay"/>"+sliceTypeName+"。<spring:message code="hrms.length"/>"+
            $("#LENGTH_YES").val()+"。<spring:message code="hrms.thickness"/>"+$("#THICKNESS_YES").val()+"。<spring:message code="hrms.otherContent"/>"+$("#WORK_CONTENT_YES").val();
        $.ligerDialog.confirm('<spring:message code="hrms.submitReportToWork"/>','<spring:message code="hrms.warning"/>', 
            function (yes){
            if(yes){
                if(spf_checkData_yes()){                  
                     $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                     $.post("/ess/infoApp/transferWorkingHoursInfoOther", 
                             [  
                                { name: 'type', value: 'add'},
                                { name: 'EMPID', value: $("#EMPID_YES").val()},
                                { name: 'PROD_NO', value: $("#PROD_NO_YES").val()},
                                { name: 'PROJ_PROS_TYPE_CODE', value: $("#PROJ_PROS_TYPE_CODE_YES").val()},
                                { name: 'START_DATE', value: $("#START_DATE_YES").val()},
                                { name: 'LENGTH', value: $("#LENGTH_YES").val()},
                                { name: 'THICKNESS', value: $("#THICKNESS_YES").val()},
                                { name: 'PARAMETER_NO', value: $("#PARAMETER_NO").val()},
                                { name: 'WORK_CONTENT', value: workContent},
                                { name: 'REMARK', value: $("#REMARK_YES").val()}
                              ]
                     , function (result)
                     {
                        $.ligerDialog.closeWaitting();
                         if (result == "Y")
                         {
                             $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                             {
                                 spf_selectEmpClear_yes();
                             });
                         }
                         else
                         {
                             $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.saveNewspaperWorkersFailedReason"/>'+result);
                         }
                     });
                }
            }});
    }
    
    function spf_checkData_yes()
    {     
        if ($("#PROD_NO_YES").val() == null || $("#PROD_NO_YES").val() == ""||$("#PROD_NO_YES").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.productionOrder"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#EMPID_YES").val() == null || $("#EMPID_YES").val() == ""||$("#EMPID_YES").val() == "0") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.numberOfEmployees"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       } 
        if ($("#PROJ_PROS_TYPE_CODE_YES").val() == null || $("#PROJ_PROS_TYPE_CODE_YES").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.process"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#START_DATE_YES").val() == null || $("#START_DATE_YES").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workersReportedDate"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#PARAMETER_NO").val() == null || $("#PARAMETER_NO").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cuttingWay"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#LENGTH_YES").val() == null || $("#LENGTH_YES").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.length"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#THICKNESS_YES").val() == null || $("#THICKNESS_YES").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.thickness"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#REMARK_YES").val() == null) {  
            $("#REMARK_YES").val()=='';
        }
        return true;
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
    <table width="99%" align="center" cellpadding="0"
        cellspacing="0">
        <tr height="50">
            <td class="l-table-edit-c" width="100%" align="left">
                <input type="radio" name="inType" id="NO" class="typeClass" value="NO" checked="checked"/>
                <label for="NO" style="font-family:verdana;color:red;font-size:150%;height: 50px"><spring:message code="hrms.weldingAssembly"/></label>
                <input type="radio" name="inType" id="YES" class="typeClass" value="YES" style="margin-left:25px;"/>
                <label for="YES" style="font-family:verdana;color:red;font-size:150%;height: 50px"><spring:message code="hrms.blanking"/></label>
            </td>
        </tr>
    </table>
    <div id="layout1">
        <!-- 电焊、装配工人报工申请 -->
        <div id='NODiv'>
                <table width="99.5%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.weldingAssemblyReportingJobApplication"/></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;">
                            <a class="l-button" style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; 
                                " onclick="spf_application_no()">
                                <spring:message code="hrms.application" /></a>
                        </td>
                    </tr>
                </table>
                
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message
                                code="hrms.EmpSearch" />
                        </td>
                        <td width="35%" class="l-table-edit-c" nowrap="nowrap">
                            <input type="text" name="EMPID_NAME_NO" id="EMPID_NAME_NO"/>
                            <input type="hidden" name="EMPID_NO" id="EMPID_NO"/>
                        </td>
                        <td class="l-table-edit-t" width="15%"><spring:message
                                code="hrms.applicant" />
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            ${basicInfo.CHINESENAME}</td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.workersReportedDate"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%"><input type="text"
                            name="START_DATE_NO" id="START_DATE_NO"
                            value="${paraMap.START_DATE}"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                            validate="{required:true}" /></td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.productionOrder"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%">
                            <!--<select name="PROD_NO" id="PROD_NO"></select>  -->
                                <input type="text"
                                    name="PROD_ID_NO" id="PROD_ID_NO" value=""
                                    validate="{required:true}" /> 
                                <input type="hidden"
                                    name="PROD_NO_NO" id="PROD_NO_NO" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.process"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%">
                            <SipingSoft:selectSyCode parentCode="ProjectProsTypeCode" name="PROJ_PROS_TYPE_CODE_NO" limit="all" />
                        </td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.workOrderAmount"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%"><input type="number"
                            name="QUANTITY_NO" id="QUANTITY_NO" value="0"
                            size="30" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.workContent"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="width: 500px; height: 50px" id="WORK_CONTENT_NO"
                                name="WORK_CONTENT_NO">${paraMap.WORK_CONTENT}</textarea></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="width: 500px; height: 50px" id="REMARK_NO"
                                name="REMARK_NO">${paraMap.REMARK}</textarea></td>
                    </tr>
                </table>
        </div>
        
        <!-- 下料工人报工申请 -->
        <div id='YESDiv'>
                <table width="99.5%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.blankingReportingJobApplication"/></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;">
                            <a class="l-button" style="width: 79px; height: 20px; font-weight: bold; float: right; margin-left: 10px; 
                                " onclick="spf_application_yes()">
                                <spring:message code="hrms.application" /></a>
                        </td>
                    </tr>
                </table>
                
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message
                                code="hrms.EmpSearch" />
                        </td>
                        <td width="35%" class="l-table-edit-c" nowrap="nowrap">
                            <input type="text" name="EMPID_NAME_YES" id="EMPID_NAME_YES"/>
                            <input type="hidden" name="EMPID_YES" id="EMPID_YES"/>
                        </td>
                        <td class="l-table-edit-t" width="15%"><spring:message
                                code="hrms.applicant" />
                        </td>
                        <td class="l-table-edit-c" width="35%">
                            ${basicInfo.CHINESENAME}</td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.workersReportedDate"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%"><input type="text"
                            name="START_DATE_YES" id="START_DATE_YES"
                            value="${paraMap.START_DATE}"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                            validate="{required:true}" /></td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.productionOrder"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%">
                            <!--<select name="PROD_NO" id="PROD_NO"></select>  -->
                                <input type="text"
                                    name="PROD_ID_YES" id="PROD_ID_YES" value=""
                                    validate="{required:true}" /> 
                                <input type="hidden"
                                    name="PROD_NO_YES" id="PROD_NO_YES" value="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.process"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%">
                            <SipingSoft:selectSyCode parentCode="ProjectProsTypeCode" name="PROJ_PROS_TYPE_CODE_YES" limit="all" />
                        </td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.cuttingWay1"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%">
                            <select name="PARAMETER_NO" id="PARAMETER_NO"></select>
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.thickness1"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%"><input type="text"
                            name="THICKNESS_YES" id="THICKNESS_YES" value="0"
                            size="30" /><spring:message code="hrms.unitMM"/></td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.length1"/><font color="red">*</font></td>
                        <td class="l-table-edit-c" width="30%"><input type="text"
                            name="LENGTH_YES" id="LENGTH_YES" value="0"
                            size="30" /><spring:message code="hrms.unitM"/></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.workingDescription"/></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="width: 500px; height: 50px" id="WORK_CONTENT_YES"
                                name="WORK_CONTENT_YES">${paraMap.WORK_CONTENT}</textarea></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
                        <td class="l-table-edit-c" colspan="3"><textarea rows=""
                                cols="" style="width: 500px; height: 50px" id="REMARK_YES"
                                name="REMARK_YES">${paraMap.REMARK}</textarea></td>
                    </tr>
                </table>
        </div>
    </div>
</body>
</html>