<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
     // 初始调用
     $(function (){
         //布局
          $("#layout1").ligerLayout({
                 allowLeftResize: false,      //是否允许 左边可以调整大小
                 allowRightResize: false,     //是否允许 右边可以调整大小
                 allowTopResize: false,      //是否允许 头部可以调整大小
                 allowBottomResize: false     //是否允许 底部可以调整大小
          });
     });
     var tab = parent.tab;
     //员工索引tab
     function spf_employeeIndex() {
         if (tab.isTabItemExist('hr0115')) {
             tab.removeTabItem('hr0115');
         }
         tab.addTabItem({
             tabid:'hr0115',
             text:'员工索引',
             url: '/hrm/empinfo/viewPersonalIndex?MENU_CODE=hr0115'
         });
     }
     //职员入职tab
     function spf_addEmployee() {
         if (tab.isTabItemExist('hr0201')) {
             tab.removeTabItem('hr0201');
         }
         tab.addTabItem({
             tabid:'hr0201',
             text:'职员入职',
             url: '/hrm/transferOrder/viewHire?MENU_CODE=hr0201'
         });
     }
     //员工导入tab
     function spf_importEmployees() {
         if (tab.isTabItemExist('hr0403')) {
             tab.removeTabItem('hr0403');
         }
         tab.addTabItem({
             tabid:'hr0403',
             text:'员工导入',
             url: '/hrm/infoStatistical/empInfoImport?MENU_CODE=hr0403'
         });
     }
     //职位等级 tab
     function spf_jobLevel() {
         if (tab.isTabItemExist('hr0705')) {
             tab.removeTabItem('hr0705');
         }
         tab.addTabItem({
             tabid:'hr0705',
             text:'职位等级',
             url: '/hrm/position/viewPostLevelManage?MENU_CODE=hr0705'
         });
     }
     //职位tab
     function spf_post() {
         if (tab.isTabItemExist('hr0704')) {
             tab.removeTabItem('hr0704');
         }
         tab.addTabItem({
             tabid:'hr0704',
             text:'职位',
             url: '/hrm/position/viewPostManage?MENU_CODE=hr0704'
         });
     }
     //职员入职tab
     function spf_manageDepartment() {
         if (tab.isTabItemExist('hr0602')) {
             tab.removeTabItem('hr0602');
         }
         tab.addTabItem({
             tabid:'hr0602',
             text:'部门预览',
             url: '/hrm/org/viewOrgInfoTree?MENU_CODE=hr0602'
         });
     }

     function changePsw(){
         $dialog = $.ligerDialog.open({
             isDrag: true,
             showMax: true,
             showMin: false,
             title: '<spring:message code="change.password"/>',
             width: 450,
             height: 320,
             url: '/ess/password/changePassword?MENU_CODE=ess0401'
         });
     }
</script>
</head>
<style type="text/css">
    body {
        padding: 5px;
        margin: 0;
        background-color: #f2f9fa;
        padding-bottom: 15px;
    }

    #layout1 {
        width: 99.8%;
        margin: 0;
        padding: 0;
    }

    .title{
        font-size: 25px;
        color:#41c9f5;
        text-align: center;
    }
    table{
        width:80%;
        height:80%;
    }
    table td{
        align:center;
        text-align: center;
    }
    table td img{
        vertical-align:middle;
    }
</style>
<body style="padding: 2px">
    <div id="layout1">
        <div style="text-align: right;" >
            <a id="changePsw" class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;
                 " onclick="changePsw()">修改密码</a>
        </div>
        <div class="title"></div>
        <div align="center" valign="middle">
            <table>
                <tr>
                    <td>
                        <p><a href='javascript:spf_employeeIndex()'><img src="/resources/images/hr_main/search_employee.png"/></a></p>
                        <p><spring:message code='hrms.emplyeeIndex'/></p>
                    </td>
                    <td>
                        <p><a href='javascript:spf_addEmployee()'><img src="/resources/images/hr_main/add_employee.png"/></a></p>
                        <p><spring:message code='hrms.addEmployee'/></p>
                    </td>
                    <td>
                        <p><a href='javascript:spf_importEmployees()'><img src="/resources/images/hr_main/add_employees.png"/></a></p>
                        <p><spring:message code='hrms.importEmployees'/></p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p><a href='javascript:spf_jobLevel()'><img src="/resources/images/hr_main/post_level.png"/></a></p>
                        <p><spring:message code='hrms.jobLevel'/></p>
                    </td>
                    <td>
                        <p><a href='javascript:spf_post()'><img src="/resources/images/hr_main/post.png"/></a></p>
                        <p><spring:message code='hrms.post'/></p>
                    </td>
                    <td>
                        <p><a href='javascript:spf_manageDepartment()'><img src="/resources/images/hr_main/department_manage.png"/></a></p>
                        <p><spring:message code='hrms.manageDepartment'/></p>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>