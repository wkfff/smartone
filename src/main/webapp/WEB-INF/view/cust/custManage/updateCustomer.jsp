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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/dateString.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
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
//初始化方法体====================================
    function initAreaSelectCss() {
        $("#CONTACT_TYPE").css({
            border : "1px solid #c1dcfa",width:"200"
        });
        $(":text").css({
            border : "1px solid #c1dcfa",
            width : "200"
        });
        $("[name='ADDRESS'],[name='OFFICE_ADDRESS'],[name='CONTACT_ADDRESS']").width("250");
        $("[name='CUST_LEVEL_CODE'],[name='CUST_SALES_MODE_CODE'],[name='purchase'],[name='actionType'],[name='actionState'], [name='actionWayCode'],[name='contact'],[name='CUST_TYPE_CODE'],[name='CUST_STATUS_CODE']").css({
            border : "1px solid #c1dcfa",width:"200"
        });
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

//customer的相关方法=========================================================================
   function spf_save() {
        if (spf_checkCustomerData()) {
            //customer json data
            var customer = {
                customerId : $("#CUST_ID").val(),
                customerName : $("#CUST_NAME").val(),
                owner : {
                    empId : $("#OWNER_ID").val()
                },
                telePhone : $("#TELEPHONE").val(),
                registerAddress : {
                    province : {
                        codeNo : $("[name='PROVINCE']").val()
                    },
                    city : {
                        codeNo : $("[name='CITY']").val()
                    },
                    area : {
                        codeNo : $("[name='AREA']").val()
                    },
                    address : $("[name='ADDRESS']").val()
                },
                officeAddress : {
                    province : {
                        codeNo : $("[name='OFFICE_PROVINCE']").val()
                    },
                    city : {
                        codeNo : $("[name='OFFICE_CITY']").val()
                    },
                    area : {
                        codeNo : $("[name='OFFICE_AREA']").val()
                    },
                    address : $("[name='OFFICE_ADDRESS']").val()
                },
                credit : {
                    amount : $("#CREDIT_AMOUNT").val()
                },
                bankName : $("#BANK").val(),
                bankCode : $("#BANK_ACCOUNT").val(),
                taxPayerCode : $("#TAXPAYER_IDCODE").val(),
                customerStatus : {
                    codeNo : $("[name='CUST_STATUS_CODE']").val()
                },
                customerType : {
                    codeNo : $("[name='CUST_TYPE_CODE']").val()
                },
                custSalesMode : {
                    codeNo : $("[name='CUST_SALES_MODE_CODE']").val()
                },
                customerLevel : {
                    codeNo : $("[name='CUST_LEVEL_CODE']").val()
                }
            };
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.ajax({
                url : '/cust/custManage/updateCustomer',
                type : 'POST',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(customer),
                success : function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == "0") {
                        parent.f_initGrid();
                        $.ligerDialog.success(
                                '<spring:message code="hrms.saveSuccess"/>',
                                '<spring:message code="hrms.warning"/>');
                    } else {
                        $.ligerMessageBox.error(
                                '<spring:message code="hrms.warning"/>',
                                result.message);
                    }
                }
            });
        }
    }
   //校验customer数据
   function spf_checkCustomerData() {
       var telereg = /^[0-9]{1,}$/;
       var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
       var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
       if ($("#CUST_NAME").val() == null || $("#CUST_NAME").val() == "") {
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                   '<spring:message code="hrms.customerName"/>' + ". " + '<spring:message code="input.required"/>');
           return false;
       }
       if ($("#CUST_TYPE_CODE").val() == null
               || $("#CUST_TYPE_CODE").val() == "") {
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                   '<spring:message code="hrms.customerType"/>' + ". " + '<spring:message code="input.required"/>');
           return false;
       }
       if ($("#CUST_STATUS_CODE").val() == null
               || $("#CUST_STATUS_CODE").val() == "") {
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                   '<spring:message code="hrms.customerStatus"/>' + ". " + '<spring:message code="input.required"/>');
           return false;
       }
       return true;
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
                                    },
                                    {
                                        display : '<spring:message code="hrms.operation"/>',
                                        width : '9%',
                                        render : function(item) {
                                            var contactstr = [
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
                                                    item.contactType.codeName ];
                                            return '<a onclick="updateContact(\''
                                                    + contactstr
                                                    + '\')" class="operator"><spring:message code="hrms.update"/></a>&nbsp;&nbsp;<a  onclick="deleteContact(\''
                                                    + item.contactId
                                                    + '\')" class="operator"><spring:message code="cust.delete1"/></a>';
                                        }
                                    } ],
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
 
    //保存和更新contact方法
    function f_saveOrUpdateContact() {
        if ($("#CUST_ID").val() == '')
            return;
        if (spf_checkContact()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            //contact json data
            var contact = {
                contactId : $("#CONTACT_ID").val(),
                contactName : $("#CONTACT_NAME").val(),
                contactType : {
                    codeNo : $("#CONTACT_TYPE").val(),
                    codeName : $("#CONTACT_TYPE").val()
                },
                customer : {
                    customerId : $("#CUST_ID").val()
                },
                mobilePhone : $("#CONTACT_MOBILE1").val(),
                telePhone : $("#CONTACT_TELEPHONE").val(),
                email : $("#CONTACT_EMAIL").val(),
                fax : $("#CONTACT_FAX").val(),
                address : {
                    province : {
                        codeNo : $("[name='CONTACT_PROVINCE']").val()
                    },
                    city : {
                        codeNo : $("[name='CONTACT_CITY']").val()
                    },
                    area : {
                        codeNo : $("[name='CONTACT_AREA']").val()
                    },
                    address : $("#CONTACT_ADDRESS").val()
                }
            };
            $.ajax({
                url : "/cust/custManager/addOrUpdateCustContact",
                type : 'POST',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(contact),
                success : function(result) {
                    hide_editContact();
                    $.ligerDialog.closeWaitting();
                    if (result.code == "0") {
                        $.ligerDialog.success(
                                '<spring:message code="hrms.saveSuccess"/>',
                                '<spring:message code="hrms.warning"/>',
                                function() {
                                    f_contact();
                                });
                    } else {
                        $.ligerMessageBox.error(
                                '<spring:message code="hrms.warning"/>',
                                result.message);
                    }
                }
            });
        }
    }
    //显示contact编辑框
    function show_editContact() {
        $("#CONTACT_ID").val("");
        $("#CONTACT_NAME").val("");
        $("#CONTACT_MOBILE1").val("");
        $("#CONTACT_TELEPHONE").val("");
        $("#CONTACT_EMAIL").val("");
        $("#CONTACT_FAX").val("");
        hide_editReceiver();
        hide_editCustomerAction();
        $("#editContact").show(500);
    }
    //隐藏contact编辑框
    function hide_editContact() {
        $("#editContact").hide(500);
    }
    //修改回显数据
    function updateContact(contactstr) {
        var contacts = contactstr.split(',');
        $("#CONTACT_ID").val(contacts[0]);
        $("#CONTACT_NAME").val(contacts[1]);
        $("#CONTACT_MOBILE1").val(contacts[2]);
        $("#CONTACT_TELEPHONE").val(contacts[3]);
        $("#CONTACT_EMAIL").val(contacts[4]);
        $("#CONTACT_FAX").val(contacts[9]);
        $("#CONTACT_ADDRESS").val(contacts[8]);
        $("#CONTACT_TYPE").val(contacts[10]);
        initializeArea('CONTACT_PROVINCE', contacts[5], 'CONTACT_CITY',
                contacts[6], 'CONTACT_AREA', contacts[7]);
        $("#editContact").show(500);
    }
    //删除contatct
    function deleteContact(contactId) {
        $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>?', function(yes) {
            if (yes) {
                $.post("/cust/custManager/deleteContact", {
                    "contactId" : contactId
                }, function(result) {
                    if (result.code == "0") {
                        $.ligerDialog.success(
                                '<spring:message code="hrms.saveSuccess"/>',
                                '<spring:message code="hrms.deleteSuccess"/>!', function() {
                                    f_contact();
                                });
                    }
                });
            } else {
                return;
            }

        });
    }
    //校验contact提交数据
    function spf_checkContact() {
        var telereg = /^[0-9]{1,}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        if ($("#CONTACT_NAME").val() == null || $("#CONTACT_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '<spring:message code="cust.contactName"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#CONTACT_MOBILE1").val() != null
                && $("#CONTACT_MOBILE1").val() != "") {
            if (!mobreg.test($("#CONTACT_MOBILE1").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                        '<spring:message code="hrms.phoneNumber"/>' + '<spring:message code="hrms.malformed"/>');
                return false;
            }
        }
        if ($("#CONTACT_EMAIL").val() != null
                && $("#CONTACT_EMAIL").val() != "") {
            if (!mailreg.test($("#CONTACT_EMAIL").val())) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                        '<spring:message code="cust.email"/>' + '<spring:message code="hrms.malformed"/>');
                return false;
            }
        }
        return true;
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
                                    },
                                    {
                                        display : '<spring:message code="hrms.operation"/>',
                                        width : '9%',
                                        render : function(item) {
                                            var receiverstr = [
                                                    item.receiverId,
                                                    item.receiverName,
                                                    item.mobilePhone,
                                                    item.telePhone,
                                                    item.email,
                                                    item.address.province.codeNo,
                                                    item.address.city.codeNo,
                                                    item.address.area.codeNo,
                                                    item.address.address ];
                                            return '<a onclick="updateReceiver(\''
                                                    + receiverstr
                                                    + '\')" class="operator"><spring:message code="hrms.update"/></a>&nbsp;&nbsp;<a  onclick="deleteReceiver(\''
                                                    + item.receiverId
                                                    + '\')" class="operator"><spring:message code="cust.delete1"/></a>';
                                        }
                                    } ],
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
        //保存或者更新收货人
        function f_saveOrUpdateReceiver() {
            if ($("#CUST_ID").val() == '')
                return;
            if (spf_checkReceiver()) {
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                //contact json data
                var receiver = {
                    receiverId : $("#RECEIVER_ID").val(),
                    receiverName : $("#RECEIVER_NAME").val(),
                    customer : {
                        customerId : $("#CUST_ID").val()
                    },
                    mobilePhone : $("#RECEIVER_MOBILE1").val(),
                    telePhone : $("#RECEIVER_TELEPHONE").val(),
                    email : $("#RECEIVER_EMAIL").val(),
                    address : {
                        province : {
                            codeNo : $("[name='RECEIVER_PROVINCE']").val()
                        },
                        city : {
                            codeNo : $("[name='RECEIVER_CITY']").val()
                        },
                        area : {
                            codeNo : $("[name='RECEIVER_AREA']").val()
                        },
                        address : $("#RECEIVER_ADDRESS").val()
                    }
                };
                $.ajax({
                    url : "/cust/custManager/addOrUpdateReceiver",
                    type : 'POST',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(receiver),
                    success : function(result) {
                        hide_editReceiver();
                        $.ligerDialog.closeWaitting();
                        if (result.code == "0") {
                            $.ligerDialog.success(
                                    '<spring:message code="hrms.saveSuccess"/>',
                                    '<spring:message code="hrms.warning"/>',
                                    function() {
                                        f_receiver();
                                    });
                        } else {
                            $.ligerMessageBox.error(
                                    '<spring:message code="hrms.warning"/>',
                                    result.message);
                        }
                    }
                });
            }
        }
        //显示编辑收货人
        function show_editReceiver() {
            $("#RECEIVER_ID").val("");
            $("#RECEIVER_NAME").val("");
            $("#RECEIVER_MOBILE1").val("");
            $("#RECEIVER_TELEPHONE").val("");
            $("#RECEIVER_EMAIL").val("");
            hide_editContact();
            hide_editCustomerAction();
            $("#editReceiver").show(500);
        }
        //隐藏收货人编辑框
        function hide_editReceiver() {
            $("#editReceiver").hide(500);
        }
        //回显收货人
        function updateReceiver(receiverstr) {
            var receiver = receiverstr.split(',');
            $("#RECEIVER_ID").val(receiver[0]);
            $("#RECEIVER_NAME").val(receiver[1]);
            $("#RECEIVER_MOBILE1").val(receiver[2]);
            $("#RECEIVER_TELEPHONE").val(receiver[3]);
            $("#RECEIVER_EMAIL").val(receiver[4]);
            $("#RECEIVER_ADDRESS").val(receiver[8]);
            initializeArea('RECEIVER_PROVINCE', receiver[5], 'RECEIVER_CITY',
                    receiver[6], 'RECEIVER_AREA', receiver[7]);
            $("#editReceiver").show(500);
        }
        //删除收货人
        function deleteReceiver(receiverId) {
            $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>?', function(yes) {
                if (yes) {
                    $.post("/cust/custManager/deleteReceiver", {
                        "receiverId" : receiverId
                    }, function(result) {
                        if (result.code == "0") {
                            $.ligerDialog.success(
                                    '<spring:message code="hrms.saveSuccess"/>',
                                    '<spring:message code="hrms.deleteSuccess"/>!', function() {
                                        f_receiver();
                                    });
                        }
                    });
                } else {
                    return;
                }

            });
        }
        //校验收货人
        function spf_checkReceiver() {
            var telereg = /^[0-9]{1,}$/;
            var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
            var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
            if ($("#RECEIVER_NAME").val() == null
                    || $("#RECEIVER_NAME").val() == "") {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                        '<spring:message code="cust.receiverName"/>' + ". " + '<spring:message code="input.required"/>');
                return false;
            }
            if ($("#RECEIVER_MOBILE1").val() != null
                    && $("#RECEIVER_MOBILE1").val() != "") {
                if (!mobreg.test($("#RECEIVER_MOBILE1").val())) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                            '<spring:message code="hrms.phoneNumber"/>' + '<spring:message code="hrms.malformed"/>');
                    return false;
                }
            }
            if ($("#RECEIVER_EMAIL").val() != null
                    && $("#RECEIVER_EMAIL").val() != "") {
                if (!mailreg.test($("#RECEIVER_EMAIL").val())) {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                            '<spring:message code="cust.email"/>' + '<spring:message code="hrms.malformed"/>');
                    return false;
                }
            }
            return true;
        }
//====================================客户活动=======================================
    function f_action()
    {
        if ($("#CUST_ID").val() == null || $("#CUST_ID").val() == '')
            return;
        var CUST_ID=$("#CUST_ID").val();
        $actiongrid = $("#actionList")
                .ligerGrid(
                        {
                        	onBeforeEdit:function(e){
                                $.ligerui.win.masking=true;
                                },
                            columns : [
                                    {
                                        display : '活动时间',
                                        name : 'actionTime',render:function(item){
                                            return  +new Date(item.actionTime).getFullYear()+'-'+ (new Date(item.actionTime).getMonth()+1)+'-'+
                                            new Date(item.actionTime).getDate();
                                        },
                                        width : '8%'
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
                                        width : '10%'
                                    },
                                    {
                                        display : '购买意向',
                                        name : 'purchase.codeName',
                                        width : '8%'
                                    },
                                    {
                                        display : '活动记录',
                                        name : 'actionContent',
                                        width : 150,
                                        editor: { type: 'textarea', height: 100 }
                                    },
                                    
                                    { display: '<spring:message code="hrms.active"/>', name: 'actionState.codeName', width: '10%' },
                                    {
                                        display : '<spring:message code="hrms.operation"/>',
                                        width : '9%',
                                        render : function(item) {
                                            var actionTime=new Date(item.actionTime).getFullYear()+'-'+ (new Date(item.actionTime).getMonth()+1)+'-'+
                                            new Date(item.actionTime).getDate()
                                               var actionstr = [
                                                    item.custActionNo,
                                                    actionTime,
                                                    item.actionType.codeId,
                                                    item.actionWayCode.codeId,
                                                    item.contact,
                                                    item.purchase.codeId,
                                                    item.actionContent,
                                                    item.actionState.codeId ];  
                                            return '<a onclick="updateAction(\''
                                                    +actionstr 
                                                    + '\')" class="operator"><spring:message code="hrms.update"/></a>&nbsp;&nbsp;<a  onclick="deleteAction(\''
                                                    + item.custActionNo
                                                    + '\')" class="operator"><spring:message code="cust.delete1"/></a>';
                                        }
                                    } ],
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
                        });
    }
    //保存和更新客户活动
    function f_saveOrUpdateAction() {
        if ($("#CUST_ID").val() == '')
            return;
        if (spf_checkAction()) {// 这里需要检测action中的值
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            //contact json data
            var action = {
                custActionNo : $("#custActionNo").val(),
                createDate : $("#createDate").val(),
                actionType : { codeNo : $("#actionType").val()},
                actionWayCode : { codeNo : $("#actionWayCode").val()},
                actionState : {codeNo:$("#actionState").val()},
                purchase : { codeNo : $("#purchase").val()},
                custId : $("#CUST_ID").val(),
                actionTime : $("#actionTime").val(),
                contact : $("#contact").val(),
                mobilePhone : $("#mobilePhone").val(),
                actionContent : $("#actionContent").val()
            };
            $.ajax({
                url : "/cust/custAction/addOrUpdateCustAction",
                type : 'POST',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(action),
                success : function(result) {
                    hide_editCustomerAction();
                    $.ligerDialog.closeWaitting();
                    if (result== "Y") {
                        $.ligerDialog.success(  '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',function(){
                        	$actiongrid.reload(); 
                        });
                    } else {
                        $.ligerMessageBox.error(
                                '客户活动保存失败',
                                "客户活动");
                    } 
                }
            });
        }
    }
    //隐藏客户活动编辑框
    function hide_editCustomerAction() {
        $("#editCustomerAction").hide(500);
    }
    //显示客户活动编辑框
    function show_editCustomerAction() {
    	var myDate = new Date();
        myDate = myDate.valueOf();
        $("#actionTime").val(dateString(myDate));
        $("#custActionNo").val("");
        $("#purchase").val("");
        $("#actionWayCode").val("");
        $("#actionContent").val("");
        $("#CONTACT_EMAIL").val("");
        var contact=$contactsgrid.getData();
        //初始化联系人
         $("#contact").empty();
        $(contact).each(function(index,item){
            $("#contact").append("<option>"+item.contactName+"</option>");
        });
        if($("#contact").val()==null||$("#contact").val()=="")
        {
            $("#contactTip").css("display","inline-block");
            $("#save").hide();
        }else
        {
            $("#contactTip").css("display","none");
            $("#save").show();  
        }
        hide_editReceiver();
        hide_editContact();
        $("#editCustomerAction").show(500);
    }
    //回显客户活动
    function updateAction(actionstr) {
        var action = actionstr.split(',');
        if(action[7]=='CustActionState005'){
            $.ligerDialog.warn("该活动已完成不能修改!");
            return;
        }
        $("#custActionNo").val(action[0]);
        $("#actionTime").val(action[1]);
        $("#actionType").val(action[2]);
        $("#actionWayCode").val(action[3]);
        $("#purchase").val(action[5]);
        $("#actionContent").val(action[6]);
        $("#actionState").val(action[7]);
        var contact=$contactsgrid.getData();
        //初始化联系人
         $("#contact").empty();
        $(contact).each(function(index,item){
            $("#contact").append("<option>"+item.contactName+"</option>");
        });
        $("#contact").val(action[4]);
        $("#editCustomerAction").show(500);
    }
    //删除客户活动
    function deleteAction(custActionNo) {
         $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>?', function(yes) {
            if (yes) {
                $.post("/cust/custAction/deleteAction", {
                    "custActionNo" : custActionNo
                }, function(result) {
                    if (result == "Y") {
                        $.ligerDialog.success( '<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.deleteSuccess"/>!',function(){
                            f_action(); 
                        });
                    }
                    else{
                        $.ligerMessageBox.error(
                                 '<spring:message code="hrms.warning"/>',
                                 "数据有误，删除失败");
                    }
                });
            } else {
                return; 
            }

        }); 
    }

    //校验客户活动
   function spf_checkAction() {
       if ($("#actionTime").val() == null
               || $("#actionTime").val() == "") {
           $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                   '活动时间' + ". " + '<spring:message code="input.required"/>');
           return false;
       }
        if ($("#purchase").val() == null
                || $("#purchase").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '购买意向' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#contact").val() == null
                || $("#contact").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '联系人' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#actionWayCode").val() == null
                || $("#actionWayCode").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '活动方式' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#actionState").val() == null
                || $("#actionState").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '活动状态' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#actionContent").val() == null
                || $("#actionContent").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '内容记录' + ". " + '<spring:message code="input.required"/>');
            return false;
        }

        return true;
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
                <td width="78%" align="left" style="font-weight: bold;"><spring:message code="cust.personalCorporateCustomerInformation"/></td>
                <td  style="padding-left: 50px;"><a class="l-button" style="width: 79px; height: 20px; " onclick="spf_save()"><spring:message code="hrms.save"/></a></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="CUST_NAME" id="CUST_NAME" value="${customerDetail.customerName}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerType"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerTypeCode" name="CUST_TYPE_CODE" selected="${customerDetail.customerType.codeNo}" /></td>
            </tr>
            <tr>
                <c:if test="${isSupervisor}">
                    <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerManager"/></td>
                    <td width="20%" class="l-table-edit-c"><input type="text" name="OWNER" id="OWNER" onclick="searchEmp()" value="${customerDetail.owner.empName}" size="30" /> <input
                        type="hidden" name="OWNER_ID" id="OWNER_ID" onclick="searchEmp()" value="${customerDetail.owner.empId}" size="30" /></td>
                </c:if>
                <c:if test="${!isSupervisor}">
                    <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerManager"/></td>
                    <td width="20%" class="l-table-edit-c"><input type="text" name="OWNER" id="OWNER" readonly="readonly" value="${admin.chineseName}${customerDetail.owner.empName}" size="30" />
                        <input type="hidden" name="OWNER_ID" id="OWNER_ID" readonly="readonly" value="${admin.adminID}${customerDetail.owner.empId}" size="30" /></td>
                </c:if>
                <td class="l-table-edit-t"><spring:message code="cust.lineOfCredit"/></td>
                <td class="l-table-edit-c"><input type="text" name="CREDIT_AMOUNT" id="CREDIT_AMOUNT" value="${customerDetail.credit.amount}" size="30" /></td>
            </tr>
            <tr>
                <td width="180px" class="l-table-edit-t"><spring:message code="hrms.custSalesMode"/></td>
                <td width="500px;" class="l-table-edit-c"><SipingSoft:selectSalesMode name="CUST_SALES_MODE_CODE" limit="all" selected="${customerDetail.custSalesMode.codeNo}" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerStatus"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerStatusCode" name="CUST_STATUS_CODE" selected="${customerDetail.customerStatus.codeNo}" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customerRating"/><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustomerLevelCode" name="CUST_LEVEL_CODE" selected="${customerDetail.customerLevel.codeNo}" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="mobile.companyTelephone"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="TELEPHONE" id="TELEPHONE" value="${customerDetail.telePhone}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.bankOfDeposit"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="BANK" id="BANK" value="${customerDetail.bankName}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.bankAccount"/></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="BANK_ACCOUNT" id="BANK_ACCOUNT" value="${customerDetail.bankCode}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="cust.theTaxpayerIdentificationNumber"/></td>
                <td width="20%" class="l-table-edit-c" colspan="3"><input type="text" name="TAXPAYER_IDCODE" id="TAXPAYER_IDCODE" value="${customerDetail.taxPayerCode}" size="30" /></td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="mobile.registeredAddress"/></td>
                <td colspan="3">
                    <div style="font-size: 12px;">
                        <SipingSoft:area provinceID="PROVINCE" cityID="CITY" countyID="AREA" provinceSelected="${customerDetail.registerAddress.province.codeNo}"
                            citySelected="${customerDetail.registerAddress.city.codeNo}" countySelected="${customerDetail.registerAddress.area.codeNo}" />
                        <input type="text" name="ADDRESS" value="${customerDetail.registerAddress.address}" />
                    </div>
                </td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="cust.officeAddress"/></td>
                <td colspan="3">
                    <div style="font-size: 12px;">
                        <SipingSoft:area provinceID="OFFICE_PROVINCE" cityID="OFFICE_CITY" countyID="OFFICE_AREA" provinceSelected="${customerDetail.officeAddress.province.codeNo}"
                            citySelected="${customerDetail.officeAddress.city.codeNo}" countySelected="${customerDetail.officeAddress.area.codeNo}" />
                        <input type="text" name="OFFICE_ADDRESS" id="OFFICE_ADDRESS" value="${customerDetail.officeAddress.address}" />
                    </div>
                </td>
            </tr>
        </table>

           <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 30px; font-size: 12px;padding-bottom:5px;">
            <tr>
                <td width="3%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
               <%--  <td width="5%" align="left" style="font-weight: bold;"><spring:message code="cust.relatedInformation"/></td> --%>
                <td align="left" ><a class="l-button" style="width: 65px; height: 20px; float: left; margin-left: 5px; "
                    onclick="show_editContact()"><spring:message code="cust.addContacts"/></a></td>
                <td align="left" ><a class="l-button" style="width: 65px; height: 20px; float: left; margin-left: 5px; "
                    onclick="show_editReceiver()"><spring:message code="mobile.addReceiver"/></a></td>
                <td align="left" ><a class="l-button" style="width: 65px; height: 20px; float: left; margin-left: 5px; "
                onclick="show_editCustomerAction()">添加活动</a></td>
                 <td width="85%" align="center"></td>
                
            </tr>
            
        </table>
        <div id="editContact" style="border: solid 1px #c1dcfa; display: none;">
            <input type="hidden" id="CONTACT_ID" name="CONTACT_ID">
            <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="cust.editContact"/>
                        </td>   
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;">
                        </td>
                    </tr> 
            </table>
            <table width="900" height="auto" cellpadding="1" cellspacing="1" style="font-size: 12px;">
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
                    <td width="20%" class="l-table-edit-c"><input type="text" id="CONTACT_NAME" name="CONTACT_NAME" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.type"/></td>
                    <td width="20%" class="l-table-edit-c"><select id="CONTACT_TYPE" name="CONTACT_TYPE">
                            <option><spring:message code="cust.keyContact"/></option>
                            <option><spring:message code="cust.theNonKeyContacts"/></option>
                    </select></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.fixedTelephone"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_TELEPHONE" name="CONTACT_TELEPHONE" /></td>
                    <td width="10%" class="l-table-edit-t"><spring:message code="hrms.phoneNumber"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_MOBILE1" name="CONTACT_MOBILE1" /></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="cust.email"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="CONTACT_EMAIL" name="CONTACT_EMAIL" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.fax"/></td>
                    <td class="l-table-edit-c" width="20%" colspan="3"><input type="text" id="CONTACT_FAX" name="CONTACT_FAX" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="cust.address"/></td>
                    <td colspan="3">
                        <div style="font-size: 12px;">
                            <SipingSoft:area provinceID="CONTACT_PROVINCE" cityID="CONTACT_CITY" countyID="CONTACT_AREA" provinceSelected="" citySelected="" countySelected="" />
                            <input type="text" id="CONTACT_ADDRESS" />
                        </div>
                    </td>
                </tr>
            </table>
            <table width="99%" align="center">
                <tr>
                    <td height="30"><a class="l-button" style="width: 79px; height: 20px; float: right; "
                        onclick="f_saveOrUpdateContact()"><spring:message code="hrms.save"/></a> <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-right: 10px; " onclick="hide_editContact()"><spring:message code="cancel"/></a></td>
                </tr>
            </table>
        </div>
        <div id="editReceiver" style="border: solid 1px #c1dcfa; display: none;">
            <input type="hidden" name="RECEIVER_ID" id="RECEIVER_ID" />
                <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="cust.editingConsignee"/>
                        </td>   
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;">
                        </td>
                    </tr> 
                </table>
            <table width="900" height="auto" cellpadding="1" cellspacing="1" style="font-size: 12px;">
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.name"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_NAME" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="cust.email"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_EMAIL" /></td>
                </tr>
                <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.phoneNumber"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_MOBILE1" /></td>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.fixedTelephone"/></td>
                    <td class="l-table-edit-c" width="20%"><input type="text" id="RECEIVER_TELEPHONE" /></td>
                </tr>
                <tr>
                    <td class="l-table-edit-t"><spring:message code="hrms.deliveryAddress"/></td>
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
                    <td height="30"><a class="l-button" style="width: 79px; height: 20px; float: right; "
                        onclick="f_saveOrUpdateReceiver()"><spring:message code="hrms.save"/></a> <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-right: 10px; " onclick="hide_editReceiver()">取消<spring:message code=""/></a></td>
                </tr>
            </table>
        </div>
<!-- ===================================客户活动=========================================================== -->
        <div id="editCustomerAction" style="border: solid 1px #c1dcfa; display: none;">
                <input type="hidden" id="custActionNo" name="custActionNo">
                <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="hrms.activityInformation"/>
                        </td>   
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right" height="30px;">
                        </td>
                    </tr> 
                </table>
                   <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                  <tr> 
                  
                     <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityTime"/><font color="red">*</font></td>
                       <td width="20%" class="l-table-edit-c">    
                            <input type="text" name="CUST_ACTION_TIME"
                            id="actionTime" value=""  size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" />
                       </td>
                       <td width="15%" class="l-table-edit-t"><spring:message code="hrms.intentionToBuyRating"/><font color="red">*</font></td>
                       <td width="20%" class="l-table-edit-c" colspan="3">   
                                <SipingSoft:selectSyCode parentCode="PurchaseTendCode" name="purchase" limit="all" />
                  </tr>
                  <tr>
                    <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityType"/><font color="red">*</font></td>
                       <td width="20%" class="l-table-edit-c">    
                                <SipingSoft:selectSyCode parentCode="ActionTypeCode" name="actionType" onChange="spf_changeType();" />
                       </td>
                       <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityPatterns"/><font color="red">*</font></td>
                       <td width="20%" class="l-table-edit-c">   
                                <SipingSoft:selectSyCode parentCode="CustActionWayCode" name="actionWayCode" limit="all" />
                       </td>
                  </tr>
                  <tr>
                       <td width="15%" class="l-table-edit-t"><spring:message code="hrms.contact"/><font color="red">*</font></td>
                       <td width="20%" class="l-table-edit-c">   
                               <!-- <input type="text" name="CONTACT" id="CONTACT" size="18"/> -->
                                 <select id="contact" name="contact" >
                                </select><span id="contactTip" style="display: none"><font color="red">&nbsp;*&nbsp;没有联系人,请先添加联系人</font></span>
                       </td>
                       <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityStatus"/><font color="red">*</font></td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustActionStateCode" name="actionState" onChange="spf_search();" limit="all" /></td>
                       
                  </tr>
                  <tr> 
                   <td width="15%" class="l-table-edit-t"><spring:message code="hrms.contentRecord"/><font color="red">*</font></td>
                   <td width="50%" class="l-table-edit-c"  colspan="3">   
                            <textarea rows="4" cols="100" id="actionContent" name="CUST_ACTION_CONTENT"></textarea>
                   </td>
                 </tr>
                  </table>
                 <table width="99%" align="center">
                <tr>
                    <td height="30"><a class="l-button" id="save" style="width: 79px; height: 20px; float: right; "
                        onclick="f_saveOrUpdateAction()"><spring:message code="hrms.save"/></a> <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-right: 10px; " onclick="hide_editCustomerAction()">取消<spring:message code=""/></a></td>
                </tr>
            </table>
        </div>
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