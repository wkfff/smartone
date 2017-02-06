<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    var $custActionStateSelectList ;
    var customerInfoTab;
    var $contactsgrid;
    var $receivergrid;
    var $actiongrid;
    var tab = parent.tab;
    $(function() {
        initAreaSelectCss();
        initCustomerInfoTab();
        $custActionStateSelectList = getCustActionStateSelectList();
    });
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
//初始化方法体====================================
    function initAreaSelectCss() {
        $("[name='CUST_TYPE_CODE']").css({
            border : "1px solid #c1dcfa"
        });
        $("[name='CUST_STATUS_CODE']").css({
            border : "1px solid #c1dcfa"
        });
        $("[name='CUST_LEVEL_CODE']").css({
            border : "1px solid #c1dcfa"
        });
        $("[name='CUST_SALES_MODE_CODE']").css({
            border : "1px solid #c1dcfa"
        });
        $("#CONTACT_TYPE").css({
            border : "1px solid #c1dcfa"
        });
        $(":text").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("[name='ADDRESS']").width("250");
        $("[name='OFFICE_ADDRESS']").width("250");
        $("[name='CONTACT_ADDRESS']").width("250");
    }

    function initCustomerInfoTab() {
        f_contact();
        customerInfoTab = $("#customerInfoTab").ligerTab({
            onAfterSelectTabItem : function(tabid) {
                if (tabid == "receiver") {
                    f_receiver();
                }
                if (tabid == "contact") {
                    f_contact();
                }
                if(tabid=="action")
                    f_action();
            }
        });
    }


//==============================contact的相关方法====================================
    //初始化表格方法
    function f_contact() {
        if ($("#CUST_ID").val() == null || $("#CUST_ID").val() == '')
            return;
        $contactsgrid = $("#contactList")
                .ligerGrid(
                        {
                            columns : [
                                    {
                                        display : '<spring:message code="cust.contactsType"/>',
                                        name : 'contactType.codeName',
                                        width : '10%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.name"/>',
                                        name : 'contactName',
                                        width : '10%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.phone1"/>',
                                        name : 'mobilePhone',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.fixedTelephone"/>',
                                        name : 'telePhone',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="cust.email"/>',
                                        name : 'email',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="cust.address"/>',
                                        name : 'address.wholeAddress',
                                        width : '30%'
                                    }],
                            enabledEdit : false,
                            usePager : true,
                            rownumbers : true,
                            isScroll : true,
                            url : "/cust/custManager/getContactList?CUST_ID="
                                    + $("#CUST_ID").val(),
                            pageSize : 10,
                            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
                            width : '99.8%',
                            frozenRownumbers :false,
                            height : '100%',
                        });
    }
 


//===============================receiver收货人的相关方法====================================
        //初始化收货人表格
        function f_receiver() {
        if ($("#CUST_ID").val() == null || $("#CUST_ID").val() == '')
            return;
        $receivergrid = $("#receiverList")
                .ligerGrid(
                        {
                            columns : [
                                    {
                                        display : '<spring:message code="cust.receiverName"/>',
                                        name : 'receiverName',
                                        width : '10%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.phone1"/>',
                                        name : 'mobilePhone',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.fixedTelephone"/>',
                                        name : 'telePhone',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="cust.email"/>',
                                        name : 'email',
                                        width : '13%'
                                    },
                                    {
                                        display : '<spring:message code="hrms.deliveryAddress"/>',
                                        name : 'address.wholeAddress',
                                        width : '35%'
                                    }],
                            enabledEdit : false,
                            usePager : true,
                            rownumbers : true,
                            isScroll : true,
                            url : "/cust/custManager/getReceiverList?CUST_ID="
                                    + $("#CUST_ID").val(),
                            pageSize : 10,
                            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
                            width : '99.8%',
                            height : '100%',
                            frozenRownumbers :false,
                            enabledSort : true
                        });
    }

//====================================客户活动=======================================
    //初始化客户活动表格
    function f_action()
    {
        if ($("#CUST_ID").val() == null || $("#CUST_ID").val() == '')
            return;
        var CUST_ID=$("#CUST_ID").val();
        $actiongrid = $("#actionList")
                .ligerGrid(
                        {
                            columns : [
                                    {
                                        display : '活动时间',
                                        name : 'actionTime',render:function(item){
                                            return  +new Date(item.actionTime).getFullYear()+'-'+ (new Date(item.actionTime).getMonth()+1)+'-'+
                                            new Date(item.actionTime).getDate();
                                        },
                                        width : '10%'
                                    },
                                    {
                                        display : '业务人员',
                                        name : 'empId',
                                        width : '8%'
                                    },
                                    {
                                        display : '活动类型',
                                        name : 'actionType.codeName',
                                        width : '8%'
                                    },
                                    {
                                        display : '活动方式',
                                        name : 'actionWayCode.codeName',
                                        width : '8%'
                                    },
                                    {
                                        display : '联系人',
                                        name : 'contact',
                                        width : '8%'
                                    },
                                    {
                                        display : '联系方式',
                                        name : 'mobilePhone',
                                        width : '8%'
                                    },
                                    {
                                        display : '购买意向',
                                        name : 'purchase.codeName',
                                        width : '8%'
                                    },
                                    {
                                        display : '活动记录',
                                        name : 'actionContent',
                                        width : '31%',
                                        editor: { type: 'textarea', height: 100 }
                                    },
                                    
                                    { display: '<spring:message code="hrms.active"/>', name: 'actionState.codeId', width: '10%',
                                        editor: { 
                                            type: 'select', data: $custActionStateSelectList, dataValueField: 'ID',dataDisplayField: 'NAME',
                                            displayColumnName: 'NAME', valueColumnName: 'ID'
                                        }, render: function (item)
                                        {
                                            for (var i = 0; i < $custActionStateSelectList.length; i++)
                                            {
                                                //alert($custActionStateSelectList[i]);
                                                //alert(item.CUST_ACTION_STATE_CODE);
                                                if ($custActionStateSelectList[i]['ID'] == item.actionState.codeId) {
                                                    
                                                    return $custActionStateSelectList[i]['NAME'];
                                                    
                                                }
                                            }
                                            return item.actionState.codeName;
                                        }
                                    }],
                            enabledEdit : true,
                            usePager : true,
                            rownumbers : true,
                            isScroll : true,
                            url : "/cust/custAction/getActionByCustId?CUST_ID="+CUST_ID,
                            pageSize : 10,
                            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
                            isScroll :true,
                            frozenRownumbers :false,
                            width : '99.8%',
                            height : '100%',
                            enabledSort : true
                        });
    }
 
//一些公共的方法=======================
    function add() {
        spf_refresh();
    }

    function spf_refresh() {
        var type = '${type}';
        if (type == 'add') {
            location.href = "/cust/custManage/addCustomer?MENU_CODE=cust0103";
        } else if (type == 'update') {
            var CUST_ID = '${customerDetail.customerId}';
            location.href = "/cust/custManage/updateCustomer?MENU_CODE=cust0104&CUST_ID="
                    + CUST_ID;
        }
    }

    function searchEmp() {
        $dialog = $.ligerDialog.open({
            isDrag : false,
            title : '<spring:message code="employee.information"/>',
            width : 800,
            height : 400,
            url : '/utility/empInfo/viewCustSearchEmployee'
        });
    }
    function getCustActionStateSelectList(){

        //请求服务器 
        var custActionStateSelectList ;
          $.ajax({
              type: 'post',
              url: '/utility/otherInfo/getCustActionStateList', 
              dataType: 'json',
              async: false,
              success: function (list)
              {  
                  custActionStateSelectList = list ; 
              }
          });
          return custActionStateSelectList;
      }
    function spf_initSelectEmpInfo(data) {
        $("#OWNER_ID").attr("value", data.EMPID);
        $("#OWNER").attr("value", data.CHINESENAME);
        $dialog.close();
        spf_search();
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
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <input type="hidden" id="type" name="type" value='${type}' /> <input type="hidden" name="CUST_ID" id="CUST_ID" value="${customerDetail.customerId}" /> <input type="hidden" id="MESSAGE" />
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 30px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="95%" align="left" style="font-weight: bold;"><spring:message code="cust.personalCorporateCustomerInformation"/></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.customerName}</font></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerType"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.customerType.codeName}</font></td>
            </tr>
            <tr>
                    <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerManager"/></td>
                    <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.owner.empName}</font></td>
               
                <td class="l-table-edit-t"><spring:message code="cust.lineOfCredit"/></td>
                <td class="l-table-edit-c"><font color="#000">${customerDetail.credit.amount}</font></td>
            </tr>
            <tr>
                <td width="180px" class="l-table-edit-t"><spring:message code="hrms.custSalesMode"/></td>
                <td width="500px;" class="l-table-edit-c"><font color="#000">${customerDetail.custSalesMode.codeName}</font></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerStatus"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.customerStatus.codeName}</font></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerRating"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.customerLevel.codeName}</font></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="mobile.companyTelephone"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.telePhone}</font></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.bankOfDeposit"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.bankName}</font></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.bankAccount"/></td>
                <td width="20%" class="l-table-edit-c"><font color="#000">${customerDetail.bankCode}</font></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.theTaxpayerIdentificationNumber"/></td>
                <td width="20%" class="l-table-edit-c" colspan="3"><font color="#000">${customerDetail.taxPayerCode}</font></td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="mobile.registeredAddress"/></td>
                <td colspan="3">
                    <div style="font-size: 12px;">${customerDetail.registerAddress.province.codeName}${customerDetail.registerAddress.city.codeName}${customerDetail.registerAddress.area.codeName}${customerDetail.registerAddress.address}
                    </div>
                </td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="cust.officeAddress"/></td>
                <td colspan="3">
                    <div style="font-size: 12px;">${customerDetail.officeAddress.province.codeName}${customerDetail.officeAddress.city.codeName}${customerDetail.officeAddress.area.codeName}${customerDetail.officeAddress.address}
                    </div>
                </td>
            </tr>
        </table>

           <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 30px; font-size: 12px;padding-bottom:5px;">
            <tr>
                <td width="10%" align="center" style="font-weight: bold;letter-spacing:2px;" ><img src="/resources/images/title/top_1.gif" />&nbsp;&nbsp;相关信息</td>
                <td width="90%">
            </tr>
            
        </table>
        <div align="left" style="heigth: 30%">
            <div id="customerInfoTab" style="text-align: center;">
                <div title='<spring:message code="hrms.contact"/>' tabid="contact">
                    <div id="contactList"></div>
                </div>
                <div title='<spring:message code="cust.receiver"/>' tabid="receiver">
                    <div id="receiverList"></div>
                </div>
                <div title='客户活动' tabid="action">
                    <div id="actionList"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>