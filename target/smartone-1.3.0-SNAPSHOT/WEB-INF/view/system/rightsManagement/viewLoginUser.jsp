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
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid ;
    var $dialog ;
    // 初始调用
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({
            topHeight:90,
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,      //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    function f_initGrid()
    {
        $grid = $("#loginUserInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '编号', name: 'ADMINID',width:120},
                { display: '用户名', name: 'CHINESENAME', align: 'cenetr',width:200},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', align: 'cenetr',width:120},
                { display: '<spring:message code="username"/>', name: 'USERNAME', align: 'cenetr',width:120},
                { display: '<spring:message code="hrms.role"/>', width: 220, name: 'SCREEN_NAME', align: 'left'},
                { display: '类型', width: 90, name: 'TYPE_NAME', align: 'center'},
                { display: '<spring:message code="hrms.active"/>', name: 'STATUS', align: 'center',width:90},
                { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', align: 'center',width:200}
            ],
            usePager: true, rownumbers: true,dataAction: 'server', root: 'loginUserInfo', record: 'loginUserInfoCnt',
            pageSize:20,
            url: '/system/rightsManagement/getLoginUserInfo',
            width: '99.6%', height: '100%',
            heightDiff : 0
        });
    }
    
    function spf_search(){
        $grid.setOptions({ parms: [
              { name: 'KEYWORD', value: $("#KEYWORD").val()},
              { name: 'SCREEN_GRANT_ID', value: $("#SCREEN_GRANT_ID").val()},
              { name: 'CPNY_ID', value: $("#CPNY_ID").val()},
              { name: 'ACTIVITY', value: $("#ACTIVITY").val()},
              { name: 'ACCOUNT_TYPE', value: $("#LOGIN_TYPE").val()}
              ],
              newPage: 1
           }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    
    function spf_delete(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/system/rightsManagement/deleteLoginUser',{"ADMINNO":row.ADMINNO}, function(result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            $grid.loadData(true);
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
    }
    
    function f_ChildWindowClose (){
        $grid.loadData(true); //加载数据
        $dialog.close() ;
    }
    
    function spf_update(){
        var row = $grid.getSelectedRow();
        if(!row) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ; 
        }
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.update"/>',
            width: 900, height: 500,
            url: '/system/rightsManagement/updateLoginUserView?ACTIVITY=1&ADMINID=' 
                    + row.ADMINID +'&ADMINNO='+ row.ADMINNO+'&CPNY_ID='+ row.CPNY_ID+'&LOGIN_TYPE='+ row.ACCOUNT_TYPE
        });
    }
    function spf_add(){
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
            width: 450, height: 200,
            url: '/system/rightsManagement/addLoginUserView',
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
    <div id="layout1">
        <div position="top">
            <table width="100%" border="0">
                <tr>
                    <td height="2"></td>
                </tr>
                <tr>
                    <td align="center" valign="middle">
                        <table width="99.6%" cellpadding="0" cellspacing="0"
                            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="keyWord" /></td>
                                <td class="l-table-edit-c"><input name="EMPID" type="text" id="KEYWORD" 
                                    title="可输入编号、用户名、账号关键字进行搜索"/></td>
                                <td class="l-table-edit-t"><spring:message code="hrms.role" /></td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:select dataListName="rolesSelectList" name="SCREEN_GRANT_ID" 
                                        limit="all" onChange="spf_search()"/>
                                </td>
                                <td class="l-table-edit-t">类型</td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:selectSyCode parentCode="LoginTypeCode" name="LOGIN_TYPE" 
                                        limit="all" onChange="spf_search()"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="hrms.company" /></td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:selectCompany name="CPNY_ID" limit="all" onChange="spf_search()"/></td>
                                <td class="l-table-edit-t"><spring:message code="hrms.active" /></td>
                                <td class="l-table-edit-c" colspan="3">
                                    <SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search()"/></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="25px"><SipingSoft:button /></td>
                </tr>
            </table>
        </div>
        <div position="center" id='loginUserInfo'></div>
    </div>
</body>
</html>