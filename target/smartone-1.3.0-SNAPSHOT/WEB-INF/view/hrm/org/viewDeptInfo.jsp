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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $emp_grid ;
    var $quota_grid ;
    // 初始调用
    $(function (){
        //布局
        $("#layout1").ligerLayout({
                topHeight: 230, 
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
            }
        );
        $("#navtab1").ligerTab({
            onAfterSelectTabItem: function (tabid){
                if(tabid=="tabitem1"){
                    $Flag = "E";
                    spf_employee_initGrid();
                }
                if(tabid=="tabitem2"){
                    $Flag = "P";
                    spf_deptQuota_initGrid();
                }
            }
        });
        spf_employee_initGrid();
    });
    function spf_selectEmp(){
        $.ligerDialog.open({ 
            title: '<spring:message code="employee.information"/>', 
            name:'winselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/empInfo/viewHrSearchEmployeeB', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK_EMP },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_EMP },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear_EMP }
            ]
        });
        return false;
    }
    function spf_selectOK_EMP(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $("#MANAGER_EMP_NAME").val(data.EMPID+","+data.CHINESENAME);
        $("#EMPID").val(data.EMPID);
        $("#EMP_DEPT_ID").val(data.DEPTID);
        dialog.close();
    }
    function spf_selectCancel_EMP(item, dialog){
        dialog.close();
    }
    function spf_selectClear_EMP(item, dialog){
        $("#MANAGER_EMP_NAME").val("");
        $("#EMPID").val("");
        $("#EMP_DEPT_ID").val("");
        dialog.close();
    }
    /*部门信息弹出框收缩js
    */
    $(function (){  
        $("#PARENT_DEPT_NAME").ligerComboBox({
            onBeforeOpen: spf_selectDepartment, valueFieldID: 'PARENTDEPTID',width:150
        });
    });
    function spf_selectDepartment() { 
        $.ligerDialog.open(
            { title: '<spring:message code="hrms.dept.information"/>', 
            width: 800, 
            height: 400, 
            url: '/utility/deptInfo/selectDepartment', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectOK_DEPT },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_DEPT },
                { text: '<spring:message code="clear"/>', onclick: spf_selectClear_DEPT }
            ]
        });
        return false;
    }
    function spf_selectOK_DEPT(item, dialog){
        var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#PARENT_DEPT_NAME").val(data.DEPTNAME.replace(/&nbsp;/g,""));
        $("#PARENTDEPTID").val(data.DEPTID);
        dialog.close(); 
    }
    function spf_selectCancel_DEPT(item, dialog){
        dialog.close();
    }
    function spf_selectClear_DEPT(item, dialog){
        $("#PARENT_DEPT_NAME").val("");
        $("#PARENTDEPTID").val("");
        dialog.close();
    }
    function getDeptSelectList(){
        //请求服务器
        var deptSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getDeptSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
                deptSelectList = list ; 
            }
        });
        return deptSelectList ;
    }
    //员工列表
    function spf_employee_initGrid(){
        $emp_grid =$("#employeeInfo").ligerGrid({
                checkbox: false,
                columns: [
                    { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:120 },
                    { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:120},
                    { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:120},
                    { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',align: 'center', width: 130,isSort: false},
                    { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:90},  
                    { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width:120}
                ],
                enabledEdit: true,usePager: true,dataAction: 'server', root: 'empInfoList', record: 'empInfoListCnt',rownumbers:true,
                url: "/utility/empInfo/getEmpInfoList?DEPTID=${deptInfoMap.DEPTID }", 
                pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
                width: '99.8%', height: '100%',
                heightDiff : 0
        });
    }
    //定编列表
    function spf_deptQuota_initGrid(){
        $quota_grid = $("#deptQuotaInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120},
                { display: '<spring:message code="hrms.quotaNumber"/>', name: 'QUOTA_NUMBER', width: 120},
                { display: '<spring:message code="hrms.realNumber"/>', name: 'REAL_NUMBER', width: 120},
                {display: '<spring:message code="hrms.differenceOfPeople"/>', name: 'DIFFERENCE', width: 120,render: function(rowdata, index){
                        rowdata.DIFFERCENCE = rowdata.REAL_NUMBER - rowdata.QUOTA_NUMBER;
                        if (rowdata.DIFFERCENCE < 0) {
                            return '<p style="color:red">'+rowdata.DIFFERCENCE+'</p>';
                        } else {
                            return '<p style="color:green">'+rowdata.DIFFERCENCE+'</p>';
                        }
                    }
                },
                { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 160, editor: { type: 'textarea', height: 100 }}
            ],
            usePager: true,dataAction: 'server',rownumbers:true,
            url: "/hrm/org/getDeptQuotaList?DEPTID=${deptInfoMap.DEPTID }",
            pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
            width: '99.8%', height: '100%'
         });
    }
    function f_save(){
        if($('#EMP_DEPT_ID').val()==$('#DEPTID').val()||$('#EMP_DEPT_ID').val()==""){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var options = {
                url:'/hrm/org/updateDeptInfo',
                type:'POST',
                success: function (result){
                        $.ligerDialog.closeWaitting();
                        if (result == "Y"){
                            $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                parent.f_ChildWindowClose() ;
                            });
                        }else{
                            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                        }
                    }
                }; 
            $('#form1').ajaxSubmit(options);
        }else{
            $.ligerDialog.confirm('该部门负责人并不属于该部门，是否继续？','<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                    var options = {                         
                        url:'/hrm/org/updateDeptInfo',
                        type:'POST',                            
                        success: function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    parent.f_ChildWindowClose() ;
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.sameDataAlreadyExists"/>');
                            }
                        }
                    }; 
                    $('#form1').ajaxSubmit(options);
                }
            });
        }
    }
    var tab = parent.tab;
    function spf_update(){ 
        if(tab.isTabItemExist('hr0601')){
            tab.removeTabItem('hr0601');
        }
        tab.addTabItem({ tabid : 'hr0601',text: '组织维护', url: '/hrm/org/updateDeptInfo?MENU_CODE=hr0601&DEPTNO='+$("#DEPTNO").val() });
    }
    function spf_add(){
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
            width: $("#layout1").width()-60, height: $("#layout1").height()-60, url: '/hrm/org/addDeptInfo'
        });
    }
    function spf_refresh(){
        parent.spf_refresh();
    }
    function f_ChildWindowClose (){ 
        $grid.loadData(true); //加载数据
        $dialog.close() ;
    }
    function spf_delete(){
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                var rows = $emp_grid.getData();
                if (rows.length != 0){
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','员工列表不为空，部门无法删除') ; 
                    return ;
                }
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post("/hrm/org/deleteDeptInfo", 
                    [
                        { name: 'DEPTNO', value: $("#DEPTNO").val() },
                        { name: 'DEPTID', value: $("#DEPTID").val() }
                    ], 
                function (result){
                    $.ligerDialog.closeWaitting();
                        if (result == "Y"){
                            $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                            spf_refresh();
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
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
<body style="padding: 2px">
    <div id='layout1'>
        <table width="99.6%" cellpadding="1" cellspacing="1"
            style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center">&nbsp;</td>
                <td width="25%" align="left" style="font-weight: bold;">&nbsp;</td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;">
                    <SipingSoft:button/>
                </td>
            </tr>
        </table>
        <table align="center" width="99.8%" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td class="l-table-edit-t" width="15">
                    <spring:message code="hrms.basicCode" />
                    <input name="DEPTID" type="hidden" id="DEPTID" value="${deptInfoMap.DEPTID }" />
                    <input name="DEPTNO" type="hidden" id="DEPTNO" value="${deptInfoMap.DEPTNO }" />
                </td>
                <td class="l-table-edit-c" colspan="3">${deptInfoMap.DEPTID }</td>
            </tr>
            <tr>
                <td class="l-table-edit-t" width="15%"><spring:message
                        code="hrms.manager" /></td>
                <td class="l-table-edit-c"width="35%">${deptInfoMap.MANAGER_EMP_NAME }</td>
                <td class="l-table-edit-t" width="15%"><spring:message
                        code="hrms.dept.parent" /></td>
                <td class="l-table-edit-c" width="35%">${deptInfoMap.PARENT_DEPT_NAME }</td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message
                        code="hrms.chineseName" /></td>
                <td class="l-table-edit-c">${deptInfoMap.DEPTNAME }</td>
                <td class="l-table-edit-t"><spring:message
                        code="hrms.englishName" /></td>
                <td class="l-table-edit-c">${deptInfoMap.DEPT_EN_NAME }</td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message
                        code="hrms.startDate" /></td>
                <td class="l-table-edit-c">${deptInfoMap.DATE_CREATED }</td>
                <td class="l-table-edit-t"><spring:message
                        code="hrms.endDate" /></td>
                <td class="l-table-edit-c">${deptInfoMap.DATE_ENDED }</td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message
                        code="hrms.description" /></td>
                <td class="l-table-edit-c" colspan="3"><textarea rows="4" name="DESCRIPTION" 
                    id="DESCRIPTION" style="width:400;">${deptInfoMap.DESCRIPTION }</textarea></td>
            </tr>
        </table>
        <br>
        <div id="navtab1" style="width: 100%; overflow: hidden; border:1px solid #A3C0E8;">
            <div title='<spring:message code="hrms.empInfo"/>'>
                <div id="employeeInfo"></div>
            </div>
            <div title='<spring:message code="hrms.quotaInfo"/>'>
                <div id="deptQuotaInfo"></div>
            </div>
        </div>
    </div>
</body>
</html>