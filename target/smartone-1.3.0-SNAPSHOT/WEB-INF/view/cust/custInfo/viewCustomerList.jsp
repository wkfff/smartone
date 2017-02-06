<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String path = request.getContextPath();
String basePath = request.getScheme() + "://"
+ request.getServerName() + ":" + request.getServerPort()
+ path + "/";%>
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var win1;
    var $grid = null;
    var $dialog = null;
    var $returnTypeSelectList ;
    $(function () {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    function f_initGrid(){
        $grid = $("#customerInfo").ligerGrid({
            <c:if test="${isSupervisor}">
                checkbox: true,
            </c:if>
            columns: [
                { display: '<spring:message code="cust.customerID"/>', name: 'customerId', width: "7%"},
                { display: '<spring:message code="hrms.customerName"/>', name: 'customerName', width: "9%"},
                { display: '<spring:message code="hrms.customerManager"/>', name: 'owner.empName', width: "9%"},
                { display: '<spring:message code="hrms.customerType"/>', name: 'customerType.codeName', width: "9%"},
                { display: '<spring:message code="hrms.custSalesMode"/>', name: 'custSalesMode.codeName', width: "9%"},
                { display: '<spring:message code="hrms.customerStatus"/>', name: 'customerStatus.codeName', width: "9%"},
                { display: '<spring:message code="hrms.customerRating"/>', name: 'customerLevel.codeName', width:"9%"},
                { display: '<spring:message code="hrms.customerAddress"/>', name: 'registerAddress.wholeAddress', width: "20%"},
                { display: '<spring:message code="hrms.detailedInformation"/>',  width: "9%",
                    render: function (item)
                    {
                       return '<div style="cursor: pointer;" onClick="spf_detail(\''+item.customerId+'\')"><spring:message code="hrms.clickHereToView"/></div>';
                    }
                }],
            enabledEdit : false,
            usePager : true,
            rownumbers : true,
            isScroll :true,
            pageSize:20,
            pageSizeOptions:[10,20,30,40,50],
            url: '/cust/custInfo/getCustomerList',
            width: '99.6%',
            height: '100%',
           // frozenCheckbox :false,
            frozenRownumbers :false,
            enabledSort:true,
            onAfterShowData: function($grid){
                $(".l-scroll").css("overflow-x","hidden");
            }
        });
    }

    var tab = parent.tab;
    function spf_delete(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        $dialog = $.ligerDialog.open({
            isDrag: false, width: 420, height: 220,
            title:'<spring:message code="hrms.removeTheCustomer"/>',
            url: '/cust/custManage/removeCustomer?CUST_ID='+row.customerId
        });
    }

    function spf_add(){
        var basePath= '<%=basePath%>';
        var url='${pageContext.request.contextPath}/customerInfoFillWizard';
         if (win1)
             win1.show();
         else {
             $.ligerDialog.open({
                 title:'<spring:message code="hrms.addCustomer"/>',
                 url:url,
                 height: 480,width:720, showMax: true, showToggle: true,
                 showMin: true,
                 isResize: true,
                 slide: false
             });
         }
    }

    function spf_update(){
        var rows = $grid.getSelectedRows();
        var rowCount=0;
        $(rows).each(function(){
        	rowCount=rowCount+1;
        })
        if (rowCount == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        if ( rowCount >1) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '不能同时选择多行!') ;
             return ;
        }
        var row=$grid.getSelectedRow();
        $.ligerDialog.open({
            title:'<spring:message code="hrms.customerInformationModification"/>',
            height: 550,
            url:'/cust/custManage/updateCustomer?MENU_CODE=cust0104&CUST_ID='+row.customerId,
            width: 1100,
            showMax: true,
            showToggle: true,
            showMin: true,
            isResize: true,
            slide: true,
            modal :false
        });
    }

    function spf_detail(customerId){
        $.ligerDialog.open({
            title:'<spring:message code="hrms.customerDetails"/>',
            url:'/cust/custInfo/viewCustomerDetail?MENU_CODE=cust0104&CUST_ID='+customerId,
            height: 550, width: 1000, showMax: true, showToggle: true,
            showMin: true, isResize: true, slide: false
         });
    }

    function spf_search() {
        if($("#OWNER_NAME").val()=='')
            $("#OWNER_ID").val('');
        $grid.setOptions({
            parms: [
                { name: 'keyWord', value: $("#keyWord").attr('value')},
                { name: 'OWNER_ID', value: $("#OWNER_ID").attr('value')},
                { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                { name: 'CUST_TYPE_CODE', value: $("#CUST_TYPE_CODE").attr('value')},
                { name: 'CUST_LEVEL_CODE', value: $("#CUST_LEVEL_CODE").attr('value')}],
            newPage: 1
        });
        $grid.loadData(true);
    }

    function spf_afterRemove(){
        $dialog.close();
        $grid.loadData(true);
    }

    function searchEmp(){
        $dialog = $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>',
            name:'waselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/empInfo/viewCustSearchEmployeeB',
            buttons: [
                    { text: '<spring:message code="okay"/>', onclick: spf_selectOwnerOK },
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectOwnerCancel },
                    { text: '<spring:message code="clear"/>', onclick: spf_selectOwnerClear }
                    ]
            });
        return false;
    }

    function spf_selectOwnerOK(){
        var fn = $dialog.frame.spf_selectEmpInfo || $dialog.frame.window.spf_selectEmpInfo;
        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#OWNER_NAME").val(data.CHINESENAME);
        $("#OWNER_ID").val(data.EMPID);
        $dialog.close();
    }
    function spf_selectOwnerCancel(){
        $dialog.close();
    }
    function spf_selectOwnerClear(){
        $("#OWNER_NAME").val("");
        $("#OWNER_ID").val("");
        $dialog.close();
    }

    function spf_changeCustomerEMPID(){
        var rows = $grid.getSelectedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        $dialog = $.ligerDialog.open({
             isDrag: false, width: 800, height: 400,
             title:'<spring:message code="hrms.selectNewStaff"/>',
             url: '/utility/empInfo/viewCustSearchEmployeeB',
             buttons: [
                { text: '<spring:message code="okay"/>', onclick: btnChangeEMPID },
                { text: '<spring:message code="cancel"/>', onclick: btnCancel}
            ]
        });
    }

    function btnChangeEMPID(){
         var fn = $dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
         var NEW_EMP = fn();
         if (!NEW_EMP) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
         }
         var jsonData = '[' ;
         var rows = $grid.getSelectedRows();
         $(rows).each(function (index, row) {
            if (jsonData.length > 1){
                jsonData += ',{' ;
            }
            else{
                jsonData += '{' ;
            }
            jsonData += ' "NEW_OWNER_ID": "' + NEW_EMP.EMPID + '", ' ;
            jsonData += ' "CUST_ID": "' + this.customerId + '"' ;
            jsonData += '}' ;
        });
        jsonData += ']' ;
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/cust/custManage/changeCustomerEMPID",
            [{ name: 'jsonData', value: jsonData }],
            function (result) {
                $.ligerDialog.closeWaitting();
                if (result == "Y") {
                    $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>');
                }
                else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        $dialog.close();
        spf_search();
    }

    function btnCancel() {
        $dialog.close();
    }

    function spf_impExcelCust(){
        if (tab.isTabItemExist('cust0105')) {
            tab.removeTabItem('cust0105');
        }
        tab.addTabItem({
            tabid:'cust0105',
            text:'客户导入',
            url: '/cust/custManage/customerImport'
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

.operator {
    color: #663333;
    font-size: 12px;
    cursor: pointer;
    text-decoration: underline;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord" type="text" id="keyWord" size="30" /></td>
                        <c:if test="${isSupervisor}">
                            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerManager" /></td>
                            <td width="35%" class="l-table-edit-c">
                                <input name="OWNER_NAME" type="text" id="OWNER_NAME" size="30" onclick="searchEmp()" />
                                <input name="OWNER_ID" type="hidden" id="OWNER_ID" size="30" />
                            </td>
                        </c:if>
                        <c:if test="${!isSupervisor}">
                            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerManager" /></td>
                            <td width="35%" class="l-table-edit-c"><input name="OWNER_ID" type="text" id="OWNER_ID" size="30" readonly="readonly" value="${EMP_ID}" /></td>
                        </c:if>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerType" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" onChange="spf_search();" limit="all" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerRating" /></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerLevelCode" name="CUST_LEVEL_CODE" onChange="spf_search();" limit="all" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.createDate" /></td>
                        <td class="l-table-edit-c">
                            <input type="text" name="S_DATE" id="S_DATE" value="" size="25" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
                            ~
                            <input type="text" name="E_DATE" id="E_DATE" value="" size="25" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button />
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_impExcelCust()">
                            <spring:message code="hrms.excelImport"/>
                        </a>
                        <c:if test="${isSupervisor}">
                            <a class="l-button" style="width: 81px; height: 20px; float: left; margin-left: 10px; "
                                onclick="spf_changeCustomerEMPID()"><spring:message code='hrms.modifyCustomerManager' /></a>
                        </c:if></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='customerInfo'></div>
        </div>
    </div>
</body>
</html>
