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
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
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
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
        
         spf_initGrid();
    });

    function spf_initGrid()
    {
        $grid = $("#companyInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '<spring:message code="hrms.chineseName"/>', name: 'CPNY_NAME', align: 'center',width: '15%'},
                { display: '<spring:message code="hrms.englishName"/>', name: 'CPNY_EN_NAME', align: 'center' , width: '15%'},
                { display: '<spring:message code="hrms.address"/>', name: 'CPNY_ADDR', align: 'center' , width: '15%'},
                { display: '<spring:message code="hrms.website"/>', name: 'CPNY_WEB_ADDR', align: 'center', width: '15%'},
                { display: '<spring:message code="hrms.telephone"/>', name: 'CPNY_TEL_NO', align: 'center', width: '15%'},
                { display: '<spring:message code="hrms.fax"/>', name: 'CPNY_FAX_NO', align: 'center', width: '15%'},
                { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY',align: 'center', width: '5%'}
            ],
            usePager: true, rownumbers: true,dataAction: 'server', root: 'companyInfoList', record: 'companyInfoListCnt',
            url: '/system/basicMaintenance/getCompanyInfo',
            width: '99.6%', height: '100%', 
            heightDiff : 0
        });
    }
   
    function spf_update(){
        var rows = $grid.getSelectedRow();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        if (rows.length > 1){
            alert('<spring:message code="hrms.onlyOneRow"/>');
            return;
        }
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.update"/>', 
            width: 900, height: 400, url: '/system/basicMaintenance/updateCompanyInfo?CPNY_ID=' + rows.CPNY_ID
        });
    }
    
    function spf_delete()
    {
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){
                var rows = $grid.getCheckedRows();
                if (!rows || rows.length == 0) { 
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                    return ; 
                }
                if (rows.length > 1){
                    alert('<spring:message code="hrms.onlyOneRow"/>'); return;
                }
                var row = rows[0] ;
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post("/system/basicMaintenance/deleteCompanyInfo", 
                    [   
                        { name: 'CPNY_ID', value: row.CPNY_ID }
                    ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y")
                    {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            $grid.loadData(true); //加载数据
                        });
                    }
                    else
                    {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
    }
    
    function spf_add(){
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
            width: 900, height: 400, url: '/system/basicMaintenance/addCompanyInfo'
        });
    }

    function f_ChildWindowClose(){
        $grid.loadData(true);
        $dialog.close();
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
        <div position="center" id='' title=' '>
            <div position="top">
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='companyInfo'></div>
        </div>
    </div>
</body>
</html>