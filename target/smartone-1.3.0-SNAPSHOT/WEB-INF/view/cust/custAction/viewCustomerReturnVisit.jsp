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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript"> 
    var $grid = null ; 
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm)
        {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm)
        {
            return input.val();
        },
        setValue: function (input, value, editParm)
        {
            input.val(value);
        },
        resize: function (input, width, height, editParm)
        {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
         f_initGrid(); 
    });
 
    function f_initGrid()
    {
        $grid = $("#customerInfo").ligerGrid({
            //checkbox: true, 
            columns: [   
                        { display: '', name: 'CUST_ID', width: 10,hide: 1},
                        { display: '<spring:message code="hrms.BusinessPersonnel"/>', name: 'EMP_NAME', width: 100},
                        { display: '<spring:message code="hrms.time"/>', name: 'CUST_ACTION_TIME', width: 100},
                        { display: '<spring:message code="cust.mode"/>', name: 'CUST_ACTION_WAY', width: 100},
                        { display: '<spring:message code="hrms.customerName"/>', name: 'CUST_NAME', width: 100},
                        { display: '<spring:message code="cust.purchaseIntent"/>', name: 'PURCHASE_TEND', width: 100},
                        { display: '<spring:message code="htms.trackingState"/>', name: 'CUST_ACTION_STATE', width: 100},
                        { display: '<spring:message code="cust.activities"/>', name: 'CUST_ACTION_CONTENT', width: 440, editor:{type:'textarea', height: 100}},
                        { display: '<spring:message code="cust.eventsList"/>',  width: 90,
                            render: function (item)  
                            { 
                               return '<div style="cursor: pointer;" onClick="spf_showDetail(\''+item.CUST_ID+'\')"><spring:message code="hrms.clickHereToView"/></div>';
                            }
                        }
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/cust/custAction/getCustomerActionList',
            parms: [    
                    { name: 'qryType', value: 'simple'} ,
                    { name: 'ACTION_TYPE_CODE', value: 'ActionType002'}
                   ],
            width: '99.6%', height: '100%'/* ,
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
                spf_showDetail(rowdata.CUST_ID);
            } */
        });
    }
    var tab = parent.tab;
    function spf_viewCustomer(CUST_ID){
        if(tab.isTabItemExist('cust0102')){
            tab.removeTabItem('cust0102');
        }
        tab.addTabItem({ tabid : 'cust0102',text: '<spring:message code="hrms.viewCustomer"/>', url: '/cust/custInfo/viewCustomerDetail?CUST_ID='+CUST_ID });
    }
    function spf_showDetail(CUST_ID){
        if(tab.isTabItemExist('cust0501')){
            tab.removeTabItem('cust0501');
        }
        tab.addTabItem({ tabid : 'cust0501',text: '<spring:message code="cust.eventsList"/>', url: '/cust/custAction/viewCustomerAction?MENU_CODE=cust0501&ACTION_TYPE_CODE=ActionType002&CUST_ID='+CUST_ID });
    }
    function spf_search()
    {
        $grid.setOptions({ parms: [ 
                                    { name: 'qryType', value: 'simple'} ,
                                    { name: 'ACTION_TYPE_CODE', value: 'ActionType002'},
                                    { name: 'keyWord', value: $("#keyWord").attr('value')},
                                    { name: 'CUST_ID', value: '${paramMap.CUST_ID}'},
                                    { name: 'CUST_TYPE_CODE', value: $("#CUST_TYPE_CODE").attr('value')},
                                    { name: 'EMPID', value: $("#EMPID").val()},
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                                    { name: 'CUST_ACTION_WAY_CODE', value: $("#CUST_ACTION_WAY_CODE").attr('value')},
                                    { name: 'CUST_ACTION_STATE_CODE', value: $("#CUST_ACTION_STATE_CODE").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
    function spf_afterRemove(){
        $dialog.close();
        $grid.loadData(true); //加载数据
    }  

    function searchEmp(){
        $.ligerDialog.open({
            title: '<spring:message code="employee.information"/>', 
            name:'waselector'+Math.random(),
            width: 800,
            height: 400,
            url: '/utility/empInfo/viewCustSearchEmployeeB',
            buttons: [
                    { text: '<spring:message code="okay"/>', onclick: spf_selectWAOK },
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectWACancel },
                    { text: '<spring:message code="clear"/>', onclick: spf_selectWAClear }
                    ]
            });
        return false;
    }

    function spf_selectWAOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#EMP_NAME").val(data.CHINESENAME);
        $("#EMPID").val(data.EMPID);
        dialog.close();
    }
    function spf_selectWACancel(item, dialog){
        dialog.close();
    }
    function spf_selectWAClear(item, dialog){
        $("#EMP_NAME").val("");
        $("#EMPID").val("");
        dialog.close();
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
                <table width="99.6%" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message
                                code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord"
                            type="text" id="keyWord" size="30" /></td>
                        <c:if test="${isSupervisor}">
                            <td width="15%" class="l-table-edit-t"><spring:message code="cust.clerk"/></td>
                            <td width="35%" class="l-table-edit-c">
                                <input 
                                type="text" id="EMP_NAME" size="30" onclick = "searchEmp()"/>
                                <input 
                                type="hidden" id="EMPID" size="30"/></td>
                        </c:if>
                        <c:if test="${!isSupervisor}">
                            <td width="15%" class="l-table-edit-t"><spring:message code="hrms.theStaff"/></td>
                            <td width="35%" class="l-table-edit-c"><input name="EMP_ID"
                                type="text" id="EMP_ID" size="30" readonly="readonly" value="${admin.adminID}"/></td>
                        </c:if>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.customerType"/></td>
                        <td width="35%" class="l-table-edit-c">   
                            <SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" onChange="spf_search();" limit="all"/>
                        </td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityPatterns"/></td>
                        <td width="35%" class="l-table-edit-c">
                            <SipingSoft:selectSyCode parentCode="CustActionWayCode" name="CUST_ACTION_WAY_CODE" onChange="spf_search();" limit="all"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.actiontyDate"/></td>
                        <td class="l-table-edit-c"><input type="text" name="S_DATE"
                            id="S_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /></td>
                        <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityStatus"/></td>
                        <td width="35%" class="l-table-edit-c">
                            <SipingSoft:selectSyCode parentCode="CustActionStateCode" name="CUST_ACTION_STATE_CODE" onChange="spf_search();" limit="all"/>
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id='customerInfo'></div>
        </div>
    </div>
</body>
</html>
