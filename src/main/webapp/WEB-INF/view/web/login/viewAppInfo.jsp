<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<script type="text/javascript">
     var $dialog ;
     var $a_grid ;
     var $c_grid ;
     $(function (){
          $("#layout12").ligerLayout({
                 allowLeftResize: false,      //是否允许 左边可以调整大小
                 allowRightResize: false,     //是否允许 右边可以调整大小
                 allowTopResize: false,      //是否允许 头部可以调整大小
                 allowBottomResize: false     //是否允许 底部可以调整大小
          });
          $("#navtab12").ligerTab({ onAfterSelectTabItem: function (tabid)
              {
                if(${mapAppInfo.isApp == true && mapAppInfo.isConffirm == true}){
                    if(tabid=="tabitem1"){
                        spf_affirm_initGrid();
                    }
                    if(tabid=="tabitem2"){
                        spf_confirm_initGrid();
                    }
                    if(tabid=="tabitem3"){
                        spf_pre_initGrid();
                    }
                }
                if(${mapAppInfo.isApp == true}){
                    if(tabid=="tabitem1"){
                        spf_affirm_initGrid();
                    }
                    if(tabid=="tabitem2"){
                        spf_pre_initGrid();
                    }
                }
                if(${mapAppInfo.isConffirm == true}){
                    if(tabid=="tabitem1"){
                        spf_confirm_initGrid();
                    }
                    if(tabid=="tabitem2"){
                        spf_pre_initGrid();
                    }
                }
              }
            });
          if(${mapAppInfo.isApp == true }){
              setTimeout('spf_affirm_initGrid()',3000);
          }
          else if(${mapAppInfo.isConffirm == true }){
              setTimeout('spf_confirm_initGrid()',3000);
          }
          setTimeout('spf_pre_initGrid()',3000);
          f_initGrid();
     });
     function f_initGrid() {
        $taskgrid = $("#taskInfo").ligerGrid({
            onBeforeEdit : function(e) {
                $.ligerui.win.masking = true;
            },
            columns : [{
                display : '<spring:message code="hrms.taskName" />',
                name : 'NAME',
                width : '15%'
            }, {
                display : '<spring:message code="hrms.auditID" />',
                name : 'ASSIGNEE',
                width : '10%'
            }, {
                display : '<spring:message code="hrms.applicationContent" />',
                name : 'DESCRIPTION',
                width : '65%',
                editor : {
                    type : 'textarea',
                    height : 100
                }
            },{
                display : '<spring:message code="hrms.createTime" /> ',
                name : 'CREATE_TIME',
                width : '10%'
            } ],
            enabledEdit : false,
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewTaskDetail();
            },
            usePager : true,
            pageSize : 20,
            url : '/process/activitiEngine/getTaskList',
            parms : [],
            width : '99.6%',
            height : '100%'
        });
    }
     var tab = parent.tab;
     function spf_viewTaskDetail(){
        if(tab.isTabItemExist('as0301')){
            tab.removeTabItem('as0301');
        }
        tab.addTabItem({ tabid : 'as0301',text: '审核信息', url: '/process/activitiEngine/viewTaskList?MENU_CODE=as0301' });
     }
     function spf_affirm_initGrid(){
        $a_grid = $("#affirmInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.attendanceDate"/>', name: 'AR_DATE', width: 220,frozen:true},
                { display: '<spring:message code="hrms.application"/>', name: 'MENU_INTRO', width: 220,frozen:true},
                { display: '<spring:message code="hrms.quantity"/>', name: 'CNT', width: 220,frozen:true} ,
                { display: '<spring:message code="search"/>', name: 'CNTS', width: 90,frozen:true, render: function (row, index)
                    {
                        if(row.CNTS == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/search_grey.gif" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/search.gif" onclick="spf_showUrlPage('+row.MENU_NO+')" >';
                        }
                    }
                }
           ],
             enabledEdit: false,usePager: false,rownumbers:true,
             url: "/myhome/getAffirmInfo?EMPID=${basicInfo.EMPID }",
             pageSize: 5,
             pageSizeOptions: [5,4,3,2,1],
             width: '99.5%', height: '99.2%'
         });
     }
     function spf_confirm_initGrid() {
        $c_grid = $("#confirmInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.attendanceDate"/>', name: 'AR_DATE', width: 220,frozen:true},
                { display: '<spring:message code="hrms.application"/>', name: 'MENU_INTRO', width: 220,frozen:true},
                { display: '<spring:message code="hrms.quantity"/>', name: 'CNT', width: 220,frozen:true} ,
                { display: '<spring:message code="search"/>', name: 'CNTS', width: 90,frozen:true, render: function (row, index)
                    {
                        if(row.CNTS == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/search_grey.gif" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/search.gif" onclick="spf_showUrlPage('+row.MENU_NO+')" >';
                        }
                    }
                }
           ],
             enabledEdit: false,usePager: false,rownumbers:true,
             url: "/myhome/getConfirmInfo?EMPID=${basicInfo.EMPID }",
             pageSize: 5,
             pageSizeOptions: [5,4,3,2,1],
             width: '99.5%', height: '99.2%'
         });
     }
     function spf_pre_initGrid() {
        $c_grid = $("#preInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.attendanceDate"/>', name: 'AR_DATE', width: 220,frozen:true},
                { display: '<spring:message code="hrms.application"/>', name: 'MENU_INTRO', width: 220,frozen:true},
                { display: '<spring:message code="hrms.quantity"/>', name: 'CNT', width: 220,frozen:true} ,
                { display: '<spring:message code="search"/>', name: 'CNTS', width: 90,frozen:true, render: function (row, index)
                    {
                        if(row.CNTS == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/search_grey.gif" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/search.gif" onclick="spf_showUrlPage('+row.MENU_NO+')" >';
                        }
                    }
                }
           ],
             enabledEdit: false,usePager: false,rownumbers:true,
             url: "/myhome/getPerViewInfo?EMPID=${basicInfo.EMPID }",
             pageSize: 5,
             pageSizeOptions: [5,4,3,2,1],
             width: '99.5%', height: '99.2%'
         });
     }

        function spf_showUrlPage(no)
        {
            //goTab(menuCode,menuName,url);
             $.post('/system/basicMaintenance/getMenuInfo',{"MENU_NO":no},function(backs){
                  $.post('/login/getMenuLoad',{"tid":backs.split("-")[0]},function(back){
                        $dialog = $.ligerWindow.show({isDrag: true,
                            title: back,
                            width: 800 ,
                            height: 400 ,
                            left:120,top:80,
                            url: backs.split("-")[1]
                      });
                    }
                );
            }
        );
        }
        function spf_checkPurchaseOrder(serialNum){
            if (tab.isTabItemExist('prosto0207')) {
                tab.removeTabItem('prosto0207');
            }
            tab.addTabItem({
                tabid:'prosto0207',
                text:'采购单审核详情',
                url: '/productStorage/proBusinessManage/viewCheckPurchaseOrder?PURCHASE_ORDER_ID='+serialNum
            });
        }
        function spf_checkSalesOrder(serialNum){
            if (tab.isTabItemExist('prosto0208')) {
                tab.removeTabItem('prosto0208');
            }
            tab.addTabItem({
                tabid:'prosto0208',
                text:'销售单审核详情',
                url: '/productStorage/proBusinessManage/viewCheckSalesOrder?SALES_ORDER_ID='+serialNum
            });
        }
    </script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout12 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout12">
        <div align="center">
            <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message code="hrms.toBeDone" /></td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                    <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <div position="center" id='' title=' '>
                <div position="center" id="taskInfo"></div>
            </div>
        </div>
    </div>
</body>
</html>