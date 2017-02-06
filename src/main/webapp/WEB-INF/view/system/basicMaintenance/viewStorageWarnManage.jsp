<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    var $grid;
    $.ligerDefaults.Grid.editors['textarea'] = {
        create : function(container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue : function(input, editParm) {
            return input.val();
        },
        setValue : function(input, value, editParm) {
            input.val(value);
        },
        resize : function(input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width)
                input.width(column.editor.width);
            else
                input.width(width);
            if (column.editor.height)
                input.height(column.editor.height);
            else
                input.height(height);
        }
    };
    // 初始调用
    $(function() {
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#hrSearchEmp").ligerGrid({
            columns : [ 
                        {display : '',name : 'WARNING_NO',width : '80',hide:true,frozen:true},
                        {display : '<spring:message code="prostor.warningTargetID"/>',name : 'TARGET_ID',width : '160',frozen:true},
                        {display : '<spring:message code="prostor.warningTargetName"/>',name : 'TARGET_NAME',width : '200',frozen:true},
                        {display : '<spring:message code="prostor.warningTargetTypeID"/>',name : 'MESSAGE_TYPE_ID',width : '200',frozen:true,hide:1},
                        {display : '<spring:message code="prostor.warningTargetType"/>',name : 'MESSAGE_TYPE_NAME',width : '200',frozen:true}
                ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            url : "/system/basicMaintenance/getStorageWarnList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%'
        });
    }
    
    function spf_choseEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="hrms.empInfo"/>',
            name:'winselector'+Math.random(),
            width: 800,
            height: 450,
            url: '/utility/empInfo/viewHrSearchEmployeeB',
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_addStorageWarnEmp },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel }
                    ]
        });
    }
    function spf_choseDept(){
        $.ligerDialog.open({ 
            title: '<spring:message code="hrms.dept.information"/>',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/utility/deptInfo/selectDepartment', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_addStorageWarnDept },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel }
                    ]
        });
    }
    function spf_choseRole(){
        $.ligerDialog.open({ 
            title: '<spring:message code="prostor.theRoleOfInformation"/>',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/utility/roleInfo/searchRole', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_addStorageWarnRole },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel }
                    ]
        });
    }

    function spf_addStorageWarnEmp(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        $.post("/system/basicMaintenance/addStorageWarnTarget", 
            [   
                { name: 'TARGET_ID', value: data.EMPID },
                { name: 'MESSAGE_TYPE_ID', value: 'EMPID' }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        $grid.loadData(true); //加载数据 
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
        
        dialog.close();
    }
    function spf_addStorageWarnDept(item, dialog){
        var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
        var data = fn(); 
        $.post("/system/basicMaintenance/addStorageWarnTarget", 
            [   
                { name: 'TARGET_ID', value: data.DEPTID },
                { name: 'MESSAGE_TYPE_ID', value: 'DEPTID' }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        $grid.loadData(true); //加载数据 
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
        
        dialog.close();
    }
    
    function spf_addStorageWarnRole(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        $.post("/system/basicMaintenance/addStorageWarnTarget", 
            [   
                { name: 'TARGET_ID', value: data.SCREEN_GRANT_ID },
                { name: 'MESSAGE_TYPE_ID', value: 'SCREEN_GRANT_ID' }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        $grid.loadData(true); //加载数据 
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
        
        dialog.close();
    }
    
    
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    
    function spf_delete(){
        var row = $grid.getSelectedRow(); 
        if (!row) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/system/basicMaintenance/deleteStorageWarnTarget", 
                        [   
                            { name: 'WARNING_NO', value: row.WARNING_NO }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid.loadData(true); //加载数据 
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
#showProductDetailDiv{
    display:none;
}
#hrSearchEmp{
    margin-top:5px;
}
select{
    width:120px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: left; "
                            onclick="spf_choseEmp()"><spring:message code="prostor.addingStaff"/></a>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                            onclick="spf_choseDept()"><spring:message code="prostor.addDepartments"/></a>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                            onclick="spf_choseRole()"><spring:message code="prostor.addRole"/></a>
                    </td>
                </tr>
            </table>
            
            
            <table width="99%" align="center">
                <tr>
                    <td height="30">
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; "
                            onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
                    </td>
                </tr>
            </table>
        </div>
            
    </div>
    <div id="hrSearchEmp"></div>
</body>
</html>