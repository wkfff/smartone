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
    var customerTab;
    var $contactsgrid;
    var $receivergrid;
    var tab = parent.tab;
    $(function() {
        initAreaSelectCss();
        initCustomerInfoTab();
    });

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
            }
        });
    }

    function f_contact() {
        if($("#CUST_ID").val() == null || $("#CUST_ID").val()=='')
            return;
        $contactsgrid = $("#contactList").ligerGrid({
                columns : [
                    { display : '联系人类型', name : 'contactType.codeName', width : '10%' },
                    { display : '姓名', name : 'contactName', width : '10%' },
                    { display : '手机', name : 'mobilePhone', width : '10%' },
                    { display : '固定电话', name : 'telePhone', width : '10%' },
                    { display : '联系地址', name : 'address.wholeAddress', width : '35%' },
                    {display : '操作',width : '9%',render:function(item) {
                        var contactstr=[
                                    item.contactId,
                                    item.contactName,
                                    item.mobilePhone,
                                    item.telePhone,
                                    item.email,
                                    item.address.province.codeNo,
                                    item.address.city.codeNo,
                                    item.address.area.codeNo,
                                    item.address.address,
                                    item.fax,
                                    item.contactType.codeName
                                ];
                        return '<a onclick="updateContact(\''+contactstr+'\')" class="operator">修改</a>&nbsp;&nbsp;<a  onclick="deleteContact(\''+item.contactId+'\')" class="operator">删除</a>';
                        }
                    }],
                enabledEdit : false,
                usePager : true,
                rownumbers : true,
                url : "/cust/custManager/getContactList?CUST_ID=" + $("#CUST_ID").val(),
                pageSize : 10,
                pageSizeOptions : [ 10, 20, 30, 40, 50 ],
                width : '99.8%',
                height : '100%',
                enabledSort : true
            });
    }

    function f_receiver() {
        if($("#CUST_ID").val() == null || $("#CUST_ID").val()=='')
            return;
        $receivergrid = $("#receiverList").ligerGrid({
            columns : [
                { display : '收货人姓名', name : 'receiverName', width : '10%' },
                { display : '手机', name : 'mobilePhone', width : '10%' },
                { display : '固定电话', name : 'telePhone', width : '10%' },
                { display : '邮箱', name : 'email', width : '10%' },
                { display : '收货地址', name : 'address.wholeAddress', width : '35%'},
                {display : '操作',width : '9%', render : function(item) {
                        var receiverstr=[
                            item.receiverId,
                            item.receiverName,
                            item.mobilePhone,
                            item.telePhone,
                            item.email,
                            item.address.province.codeNo,
                            item.address.city.codeNo,
                            item.address.area.codeNo,
                            item.address.address
                        ];
                        return '<a onclick="updateReceiver(\''+receiverstr+'\')" class="operator">修改</a>&nbsp;&nbsp;<a  onclick="deleteReceiver(\''+item.receiverId+'\')" class="operator">删除</a>';
                    }
                }],
            enabledEdit : false,
            usePager : true,
            rownumbers : true,
            isScroll : true,
            url : "/cust/custManager/getReceiverList?CUST_ID=" + $("#CUST_ID").val(),
            pageSize : 10,
            pageSizeOptions : [ 10, 20, 30, 40, 50 ],
            width : '99.8%',
            height : '100%',
            enabledSort : true
        });
    }

    function spf_update() {
        spf_save();
    }

    function f_saveOrUpdateReceiver() {
        if($("#CUST_ID").val()=='')
            return;
        if (spf_checkReceiver()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            //contact json data
            var receiver = {
                receiverId : $("#RECEIVER_ID").val(),
                receiverName : $("#RECEIVER_NAME").val(),
                customer : { customerId : $("#CUST_ID").val()},
                mobilePhone : $("#RECEIVER_MOBILE1").val(),
                telePhone : $("#RECEIVER_TELEPHONE").val(),
                email : $("#RECEIVER_EMAIL").val(),
                address : {
                    province : { codeNo : $("[name='RECEIVER_PROVINCE']").val() },
                    city : { codeNo : $("[name='RECEIVER_CITY']").val() },
                    area : { codeNo : $("[name='RECEIVER_AREA']").val() },
                    address : $("#RECEIVER_ADDRESS").val()
                }
            };
            $.ajax({url : "/cust/custManager/addOrUpdateReceiver",
                    type: 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(receiver),
                    success : function(result) {
                        hide_editReceiver();
                        $.ligerDialog.closeWaitting();
                        if (result.code == "0") {
                            $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',
                                    function() {
                                        f_receiver();
                                    });
                        } else {
                            $.ligerMessageBox.error( '<spring:message code="hrms.warning"/>', result.message);
                        }
                    }
            });
        }
    }

    function f_saveOrUpdateContact() {
        if($("#CUST_ID").val()=='')
            return;
        if (spf_checkContact()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            //contact json data
            var contact = {
                contactId : $("#CONTACT_ID").val(),
                contactName : $("#CONTACT_NAME").val(),
                contactType : {codeNo : $("#CONTACT_TYPE").val(),codeName :$("#CONTACT_TYPE").val()},
                customer : { customerId : $("#CUST_ID").val()},
                mobilePhone : $("#CONTACT_MOBILE1").val(),
                telePhone : $("#CONTACT_TELEPHONE").val(),
                email : $("#CONTACT_EMAIL").val(),
                address : {
                    province : { codeNo : $("[name='CONTACT_PROVINCE']").val() },
                    city : { codeNo : $("[name='CONTACT_CITY']").val() },
                    area : { codeNo : $("[name='CONTACT_AREA']").val() },
                    address : $("#CONTACT_ADDRESS").val()
                }
            };
            $.ajax({url : "/cust/custManager/addOrUpdateCustContact",
                    type: 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(contact),
                    success : function(result) {
                        hide_editContact();
                        $.ligerDialog.closeWaitting();
                        if (result.code == "0") {
                            $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',
                                    function() {
                                        f_contact();
                                    });
                        } else {
                            $.ligerMessageBox.error( '<spring:message code="hrms.warning"/>', result);
                        }
                    }
            });
        }
    }

    function spf_save() {
        if (spf_checkCustomerData()) {
            //customer json data
            var customer = {
                customerId : $("#CUST_ID").val(),
                customerName : $("#CUST_NAME").val(),
                owner : { empId : $("#OWNER_ID").val()},
                telePhone : $("#TELEPHONE").val(),
                registerAddress : {
                    province : { codeNo : $("[name='PROVINCE']").val() } ,
                    city : { codeNo : $("[name='CITY']").val() },
                    area : { codeNo : $("[name='AREA']").val() },
                    address : $("[name='ADDRESS']").val()
                },
                officeAddress : {
                    province : { codeNo : $("[name='OFFICE_PROVINCE']").val() },
                    city : { codeNo : $("[name='OFFICE_CITY']").val() },
                    area : { codeNo : $("[name='OFFICE_AREA']").val() },
                    address : $("[name='OFFICE_ADDRESS']").val()
                },
                credit : { amount : $("#CREDIT_AMOUNT").val() },
                bankName : $("#BANK").val(),
                bankCode : $("#BANK_ACCOUNT").val(),
                taxPayerCode : $("#TAXPAYER_IDCODE").val(),
                customerStatus : { codeNo : $("[name='CUST_STATUS_CODE']").val()},
                customerType : { codeNo : $("[name='CUST_TYPE_CODE']").val()},
                customerLevel : { codeNo : $("[name='CUST_LEVEL_CODE']").val()}
            };
            console.log(JSON.stringify(customer));
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            if($("#CUST_ID").val() == null || $("#CUST_ID").val() == ""){
                $.ajax({
                    url : '/cust/custManage/addCustomer',
                    type: 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(customer),
                    success : function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == "0") {
                        $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',
                                function() {
                                    $("#CUST_ID").val(result.message);
                                    initCustomerInfoTab();
                                });
                    } else {
                        $.ligerMessageBox.error( '<spring:message code="hrms.warning"/>', result.message);
                    }
                }});
            }else{
                $.ajax({
                    url : '/cust/custManage/updateCustomer',
                    type: 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(customer),
                    success : function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == "0") {
                        $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>');
                    } else {
                        $.ligerMessageBox.error( '<spring:message code="hrms.warning"/>', result.message);
                    }
                }});
            }
        }
    }

    function add() {
        spf_refresh();
    }

    function spf_refresh() {
        var type = '${type}';
        if (type == 'add') {
            location.href = "/cust/custManage/addCustomer?MENU_CODE=cust0103";
        } else if (type == 'update') {
            var CUST_ID = '${customerDetail.customerId}';
            location.href = "/cust/custManage/updateCustomer?MENU_CODE=cust0104&CUST_ID=" + CUST_ID;
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

    function spf_initSelectEmpInfo(data) {
        $("#OWNER_ID").attr("value", data.EMPID);
        $("#OWNER").attr("value", data.CHINESENAME);
        $dialog.close();
        spf_search();
    }

    function show_editContact() {
        $("#CONTACT_ID").val("");
        $("#CONTACT_NAME").val("");
        $("#CONTACT_MOBILE1").val("");
        $("#CONTACT_TELEPHONE").val("");
        $("#CONTACT_EMAIL").val("");
        $("#RECEIVER_ADDRESS").val("");
        $("#RECEIVER_EMAIL").val("");
        $("#RECEIVER_FAX").val("");
        $("#editContact").show(500);
    }

    function hide_editContact() {
        $("#editContact").hide(500);
    }

    function show_editReceiver() {
        $("#RECEIVER_ID").val("");
        $("#RECEIVER_NAME").val("");
        $("#RECEIVER_MOBILE1").val("");
        $("#RECEIVER_TELEPHONE").val("");
        $("#RECEIVER_EMAIL").val("");
        $("#RECEIVER_ADDRESS").val("");
        $("#editReceiver").show(500);
    }

    function hide_editReceiver() {
        $("#editReceiver").hide(500);
    }

    function updateReceiver(receiverstr) {
        var receiver = receiverstr.split(',');
        $("#RECEIVER_ID").val(receiver[0]);
        $("#RECEIVER_NAME").val(receiver[1]);
        $("#RECEIVER_MOBILE1").val(receiver[2]);
        $("#RECEIVER_TELEPHONE").val(receiver[3]);
        $("#RECEIVER_EMAIL").val(receiver[4]);
        $("#RECEIVER_PROVINCE").val(receiver[5]);
        $("#RECEIVER_CITY").val(receiver[6]);
        $("#RECEIVER_AREA").val(receiver[7]);
        $("#RECEIVER_ADDRESS").val(receiver[8]);
        $("#editReceiver").show(500);
    }

    function updateContact(contactstr) {
        var contacts = contactstr.split(',');
        $("#CONTACT_ID").val(contacts[0]);
        $("#CONTACT_NAME").val(contacts[1]);
        $("#CONTACT_MOBILE1").val(contacts[2]);
        $("#CONTACT_TELEPHONE").val(contacts[3]);
        $("#CONTACT_EMAIL").val(contacts[4]);
        $("#CONTACT_PROVINCE").val(contacts[5]);
        $("#CONTACT_CITY").val(contacts[6]);
        $("#CONTACT_AREA").val(contacts[7]);
        $("#CONTACT_ADDRESS").val(contacts[8]);
        $("#CONTACT_TYPE").val(contacts[9]);
        $("#editContact").show(500);
    }

    function deleteReceiver(receiverId) {
        $.ligerDialog.confirm('你确定要删除该数据吗?', function(yes) {
            if(yes)
            {
                $.post("/cust/custManager/deleteReceiver", {
                    "receiverId" : receiverId
                }, function(result) {
                    if (result.code == "0") {
                        $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '数据删除成功!' ,
                            function() {
                                f_receiver();
                            });
                    }
                });
            }
            else{
                return;
            }
        });
    }

    function deleteContact(contactId) {
        $.ligerDialog.confirm('你确定要删除该数据吗?', function(yes) {
            if(yes)
            {
                $.post("/cust/custManager/deleteContact", {
                    "contactId" : contactId
                }, function(result) {
                    if (result.code == "0") {
                        $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>', '数据删除成功!',
                            function() {
                                f_contact();
                            });
                    }
                });	
            }
            else
            {
                return;
            }
            
        });
    }

    function spf_checkCustomerData() {
        var telereg = /^[0-9]{1,}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        if ($("#CUST_NAME").val() == null || $("#CUST_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '客户名称' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#CUST_TYPE_CODE").val() == null || $("#CUST_TYPE_CODE").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '客户类型' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#CUST_STATUS_CODE").val() == null || $("#CUST_STATUS_CODE").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '客户状态' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#TELEPHONE").val() != null && $("#TELEPHONE").val() != "") {
            if (!telereg.test($("#TELEPHONE").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '公司电话' + '格式错误');
                return false;
            }
        }
        return true;
    }

    function spf_checkContact() {
        var telereg = /^[0-9]{1,}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        if ($("#CONTACT_NAME").val() == null || $("#CONTACT_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '联系人名称' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#CONTACT_MOBILE1").val() != null
                && $("#CONTACT_MOBILE1").val() != "") {
            if (!mobreg.test($("#CONTACT_MOBILE1").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '手机号码' + '格式错误');
                return false;
            }
        }
        if ($("#CONTACT_TELEPHONE").val() != null && $("#CONTACT_TELEPHONE").val() != "") {
            if (!telereg.test($("#CONTACT_TELEPHONE").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '固定电话' + '格式错误');
                return false;
            }
        }
        if ($("#CONTACT_EMAIL").val() != null && $("#CONTACT_EMAIL").val() != "") {
            if (!mailreg.test($("#CONTACT_EMAIL").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '邮箱' + '格式错误');
                return false;
            }
        }
        return true;
    }

    function spf_checkReceiver() {
        var telereg = /^[0-9]{1,}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        if ($("#RECEIVER_NAME").val() == null || $("#RECEIVER_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '收货人名称' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#RECEIVER_MOBILE1").val() != null && $("#RECEIVER_MOBILE1").val() != "") {
            if (!mobreg.test($("#RECEIVER_MOBILE1").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '手机号码' + '格式错误');
                return false;
            }
        }
        if ($("#RECEIVER_TELEPHONE").val() != null && $("#RECEIVER_TELEPHONE").val() != "") {
            if (!telereg.test($("#RECEIVER_TELEPHONE").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '固定电话' + '格式错误');
                return false;
            }
        }
        if ($("#RECEIVER_EMAIL").val() != null && $("#RECEIVER_EMAIL").val() != "") {
            if (!mailreg.test($("#RECEIVER_EMAIL").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '邮箱' + '格式错误');
                return false;
            }
        }
        return true;
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
        <input type="hidden" id="type" name="type" value='${type}' />
        <input type="hidden" name="CUST_ID" id="CUST_ID" value="" />
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 30px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="65%" align="left" style="font-weight: bold;">个人/企业客户信息</td>
                <td width="15%"  align="left"><a class="l-button" style="width:79px; height:20px; " onclick="spf_save()">保存</a></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t">中文名称<font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="CUST_NAME" id="CUST_NAME" value="" size="30" /></td>
                <td width="10%" class="l-table-edit-t">客户类型<font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" selected="" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t">客户状态<font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerStatusCode" name="CUST_STATUS_CODE" selected="" /></td>
                <td width="10%" class="l-table-edit-t">客户评级<font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerLevelCode" name="CUST_LEVEL_CODE" selected="" /></td>
            </tr>
            <tr>
                <c:if test="${isSupervisor}">
                    <td width="10%" class="l-table-edit-t">客户经理</td>
                    <td width="20%" class="l-table-edit-c">
                        <input type="text" name="OWNER" id="OWNER" onclick="searchEmp()" value="${admin.chineseName}" size="30" />
                        <input type="hidden" name="OWNER_ID" id="OWNER_ID" onclick="searchEmp()" value="${admin.adminID}" size="30" />
                    </td>
                </c:if>
                <c:if test="${!isSupervisor}">
                    <td width="10%" class="l-table-edit-t">客户经理</td>
                    <td width="20%" class="l-table-edit-c">
                        <input type="text" name="OWNER" id="OWNER" readonly="readonly" value="${admin.chineseName}" size="30" />
                        <input type="hidden" name="OWNER_ID" id="OWNER_ID" readonly="readonly" value="${admin.adminID}" size="30" />
                    </td>
                </c:if>
                <td class="l-table-edit-t">信用额度</td>
                <td class="l-table-edit-c"><input type="text" name="CREDIT_AMOUNT" id="CREDIT_AMOUNT" value="${customerDetail.credit.amount}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t">公司电话</td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="TELEPHONE" id="TELEPHONE" value="${customerDetail.telePhone}" size="30" /></td>
                <td width="10%" class="l-table-edit-t">纳税人识别码</td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="TAXPAYER_IDCODE" id="TAXPAYER_IDCODE" value="${customerDetail.taxPayerCode}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t">开户银行</td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="BANK" id="BANK" value="${customerDetail.bankName}" size="30" /></td>
                <td width="10%" class="l-table-edit-t">银行账户</td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="BANK_ACCOUNT" id="BANK_ACCOUNT" value="${customerDetail.bankCode}" size="30" /></td>
            </tr>
            <tr>
                <td class="l-table-edit-t">注册地址</td>
                <td colspan="3">
                    <div style="font-size: 12px;">
                        <SipingSoft:area provinceID="PROVINCE" cityID="CITY" countyID="AREA"
                            provinceSelected=""
                            citySelected=""
                            countySelected="" />
                        <input type="text" name="ADDRESS" value="${customerDetail.registerAddress.address}" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="l-table-edit-t">办公地址</td>
                <td colspan="3">
                    <div style="font-size: 12px;">
                        <SipingSoft:area provinceID="OFFICE_PROVINCE" cityID="OFFICE_CITY" countyID="OFFICE_AREA"
                            provinceSelected="${customerDetail.officeAddress.province.codeNo}"
                            citySelected="${customerDetail.officeAddress.city.codeNo}"
                            countySelected="${customerDetail.officeAddress.area.codeNo}" />
                        <input type="text" name="OFFICE_ADDRESS" id="OFFICE_ADDRESS" value="${customerDetail.officeAddress.address}" />
                    </div>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
            <tr>
                <td align="left"><a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                    onclick="show_editContact()">添加联系人</a></td>
                <td align="left"><a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                    onclick="show_editReceiver()">添加收货人</a></td>
            </tr>
        </table>
        <div id="editContact" style="border: solid 1px #c1dcfa; display: none;">
            <input type="hidden" id="CONTACT_ID" name="CONTACT_ID">
            <table width="900px" height="auto" cellpadding="1" cellspacing="1" style="font-size: 12px;">
                <tr>
                    <td width="5%" colspan="4"><img src="/resources/images/title/top_1.gif" />&nbsp;&nbsp;编辑联系人</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t">姓名</td>
                    <td width="20%" class="l-table-edit-c"><input type="text" id="CONTACT_NAME" name="CONTACT_NAME" /></td>
                    <td width="10%" class="l-table-edit-t">类型</td>
                    <td width="20%" class="l-table-edit-c">
                        <select id="CONTACT_TYPE" name="CONTACT_TYPE">
                            <option>关键联系人</option>
                            <option>非关键联系人</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t">固定电话</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_TELEPHONE" name="CONTACT_TELEPHONE" /></td>
                    <td width="10%" class="l-table-edit-t">手机号码</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_MOBILE1" name="CONTACT_MOBILE1" /></td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t">邮箱</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_EMAIL" name="CONTACT_EMAIL" /></td>
                    <td width="10%" class="l-table-edit-t">传真</td>
                    <td class="l-table-edit-c" width="20%" colspan="3"><input type="text" id="CONTACT_FAX" name="CONTACT_FAX" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t">办公地址</td>
                    <td colspan="3">
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="CONTACT_PROVINCE" cityID="CONTACT_CITY" countyID="CONTACT_AREA"
                                provinceSelected="" citySelected="" countySelected="" />
                            <input type="text" id="CONTACT_ADDRESS" />
                        </div>
                    </td>
                </tr>
            </table>
            <table width="99%" align="center">
                <tr>
                    <td height="30px">
                        <a class="l-button" style="width: 79px; height: 20px; float: right; " onclick="f_saveOrUpdateContact()">保存</a>
                        <a class="l-button" style="width: 79px; height: 20px; float: right; margin-right: 10px; " onclick="hide_editContact()">取消</a>
                    </td>
                </tr>
            </table>
        </div>
        <div id="editReceiver" style="border: solid 1px #c1dcfa; display: none;">
            <input type="hidden" name="RECEIVER_ID" id="RECEIVER_ID" />
            <table width="900" height="auto" cellpadding="1" cellspacing="1" style="font-size: 12px;">
                <tr>
                    <td width="5%" align="left" colspan="4"><img src="/resources/images/title/top_1.gif" />&nbsp;&nbsp;编辑收货人</td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t">姓名</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_NAME" /></td>
                    <td width="10%" class="l-table-edit-t">邮箱</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_EMAIL" /></td>
                </tr>
                <tr>
                    <td width="10%" class="l-table-edit-t">手机号码</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_MOBILE1" /></td>
                    <td width="10%" class="l-table-edit-t">固定电话</td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_TELEPHONE" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t">收货地址</td>
                    <td colspan="3">
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="RECEIVER_PROVINCE" cityID="RECEIVER_CITY" countyID="RECEIVER_AREA" provinceSelected="${personalInfo.RECEIVER_PROVINCE}"
                                citySelected="${personalInfo.RECEIVER_PROVINCE}" countySelected="${personalInfo.RECEIVER_PROVINCE}" />
                            <input type="text" id="RECEIVER_ADDRESS" />
                        </div>
                    </td>
                </tr>
            </table>
            <table width="99%" align="center">
                <tr>
                    <td height="30px"><a class="l-button" style="width: 79px; height: 20px; float: right; "
                        onclick="f_saveOrUpdateReceiver()">保存</a> <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-right: 10px; " onclick="hide_editReceiver()">取消</a></td>
                </tr>
            </table>
        </div>
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;">相关信息</td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"></td>
            </tr>
        </table>
        <div align="left" style="height: 30%">
            <div id="customerInfoTab" style="text-align: center;">
                <div title='联系人' tabid="contact">
                    <div id="contactList"></div>
                </div>
                <div title='收货人' tabid="receiver">
                    <div id="receiverList"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>