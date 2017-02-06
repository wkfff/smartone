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
     function fn_user(){
         if (tab.isTabItemExist('sy0120')) {
             tab.removeTabItem('sy0120');
         }
         tab.addTabItem({
             tabid:'sy0120',
             text:'<spring:message code="hrms.viewUser"/>',
             url: '/system/rightsManagement/viewLoginUser?MENU_CODE=sy0120'
         });
     }

     function fn_role(){
         if (tab.isTabItemExist('sy0110')) {
             tab.removeTabItem('sy0110');
         }
         tab.addTabItem({
             tabid:'sy0110',
             text:'<spring:message code="hrms.role"/>',
             url: '/system/rightsManagement/viewRolesGroup?MENU_CODE=sy0110'
         });
     }

     function fn_com(){
         if (tab.isTabItemExist('sy0440')) {
             tab.removeTabItem('sy0440');
         }
         tab.addTabItem({
             tabid:'sy0440',
             text:'<spring:message code="hrms.company"/>',
             url: '/system/basicMaintenance/viewCompanyManage?MENU_CODE=sy0440'
         });
     }

     function fn_screen(){
         if (tab.isTabItemExist('sy0410')) {
             tab.removeTabItem('sy0410');
         }
         tab.addTabItem({
             tabid:'sy0410',
             text:'屏幕管理',
             url: '/system/basicMaintenance/viewMenuManage?MENU_CODE=sy0410'
         });
     }

     function fn_codeManage(){
         if (tab.isTabItemExist('sy0420')) {
             tab.removeTabItem('sy0420');
         }
         tab.addTabItem({
             tabid:'sy0420',
             text:'<spring:message code="sys.codeManagement"/>',
             url: '/system/basicMaintenance/viewCodeManage?MENU_CODE=sy0420'
         });
     }

     function fn_licence(){
         if (tab.isTabItemExist('sy0460')) {
             tab.removeTabItem('sy0460');
         }
         tab.addTabItem({
             tabid:'sy0460',
             text:'产品密钥',
             url: '/license/viewLicenseManage?MENU_CODE=sy0460'
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
        width: 99.8%;
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

    #tableList{
        width: 100%;
    }

    #trClass td{
        text-align: center;
        width: 33%;
    }

    img{
        cursor: pointer;
    }
</style>
<body style="padding: 2px">
    <div id="layout1">
        <div style="text-align: right;" >
            <a id="changePsw" class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;
                 background-image: url('/resources/images/button/button.gif');" onclick="changePsw()">修改密码</a>
        </div>
        <div class="title"><spring:message code="sys.systemSettings"/></div>
        <table id="tableList">
            <tr height="60px;"></tr>
            <tr id="trClass">
                <td><img src="/resources/images/title/role.jpg" alt="<spring:message code='sys.roleManagement'/>" onclick="fn_role()"/></td>
                <td><img src="/resources/images/title/user.jpg" alt="<spring:message code='sys.userManagement'/>" onclick="fn_user()"/></td>
                <td><img src="/resources/images/title/com.png" alt="<spring:message code='sys.companyInfo'/>" onclick="fn_com()"/></td>
            </tr>
            <tr id="trClass">
                <td><spring:message code="sys.roleManagement"/></td>
                <td><spring:message code="sys.userManagement"/></td>
                <td><spring:message code="sys.companyInfo"/></td>
            </tr>
            <tr height="60px;"></tr>
            <tr id="trClass">
                <td><img src="/resources/images/title/sort.jpg" alt="屏幕管理" onclick="fn_screen()"/></td>
                <td><img src="/resources/images/title/codeMgt.png" alt="<spring:message code="sys.codeManagement"/>" onclick="fn_codeManage()"/></td>
                <td><img src="/resources/images/title/licence-icon.png" alt="产品密钥" onclick="fn_licence()"/></td>
            </tr>
            <tr id="trClass">
                <td>屏幕管理</td>
                <td><spring:message code="sys.codeManagement"/></td>
                <td>产品密钥</td>
            </tr>
        </table>
    </div>
</body>
</html>