<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    
    // 初始调用
    $(function() {
        f_initGrid();
    });
    function f_initGrid() {
        $grid = $("#getAllInvitation").ligerGrid({
            columns : [ 
                        {display : '<spring:message code="mobile.invitation"/>',name : 'INVITATION_ID',width : '10%'},
                        {display : '<spring:message code="hrms.customerName"/>',name : 'CUST_NAME',width : '30%'},
                        {display : '<spring:message code="hrms.createDate"/>',name : 'CREATE_DATE',width : '10%',
                            type : 'date',format : 'yyyy-MM-dd'},
                        {display : '<spring:message code="mobile.bindStatus"/>',name : 'BIND_STATUS_NAME',width : '10%'},
                        {display : '<spring:message code="mobile.registerStatus"/>',name : 'USE_STATUS_NAME',width : '10%'},
                        {display : '<spring:message code="mobile.customerUseingInvitation"/>',name : 'REMARK',width : '30%'}
                ],
            usePager : true,
            rownumbers : true,
            url : "/mobile/invitationManage/getInvitationList",
            pageSize:15,
            pageSizeOptions:[15,20,30,40,50],
            width:'99.8%',
            height:'100%'
        });
    }
    //添加邀请码展开
    function spf_add(){
        $("#showAddInvitationDiv input[type!='radio']").val("");
        $("#showAddInvitationDiv").show(500);
    }
    //添加邀请码收缩
    function spf_clearAddInvitationDiv(){
        $("#showAddInvitationDiv").hide(500);
    }
    //生成邀请码
    function spf_generateInvitaation() {
        $.post("/mobile/invitationManage/generateInvitation", 
        function (result){
            $("#INVITATION").val(result);
            checkInvitationIsUsed(result);
         }
       );
    }
    //验证该邀请码是否被使用
    function checkInvitationIsUsed(data) {
        $.post("/mobile/invitationManage/getCntByCondition?INVITATION_ID="+data, 
        function (result){
            if (result == 0) {
                $("#CHECK_INVITATION").html("<spring:message code="mobile.youCanUse"/>");
            }else if (result > 0) {
                $("#CHECK_INVITATION").html("<spring:message code="mobile.invitationcode"/>!");
                $("#INVITATION").val();
            }
         }
       );
    }
    //采购人选择 
    $(function (){
        $("#CUSTOMER_NAME").ligerComboBox({
            onBeforeOpen: spf_selectCustomerNo, valueFieldID: 'CUST_ID',width:150
        });
    });
    //选择要绑定的客户
    function spf_selectCustomerNo(){
        $('#CUSTOMER_NO').val('');
          
        $.ligerDialog.open({
            title: '<spring:message code="mobile.selectCustomers"/>', 
            name:'winselector'+Math.random(),
            width: 900, 
            height: 500, 
            url: '/utility/custInfo/viewAllCustomerList', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectCustomerOK },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCustomerCancel }
                    ]
        });
        return false;   
    }
    function spf_selectCustomerOK(item, dialog){
            var fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer; 
            var data = fn();
            
            $('#CUSTOMER_NO').val(data.CUST_NO);
            $('#CUSTOMER_NAME').val(data.CUST_NAME);
            dialog.close();
    }
    
    function spf_selectCustomerCancel(item, dialog){
            $('#CUSTOMER_NO').val('');
            $('#CUSTOMER_NAME').val('');
            dialog.close();
    }
    //检查必填项是否填写完整
    function spf_checkData(){     
        if ($("#INVITATION").val() == null || $("#INVITATION").val() == "" || $("#INVITATION").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mobile.Pleasegenerate"/>！！！') ; 
             return false; 
        }
        
        return true;
    } 
    //添加邀请码到数据库
    function spf_addInvitation() {
        var invitation = MyCheckNull($("#INVITATION").val());
        
        if(spf_checkData()){ 
            $.ligerDialog.confirm('<spring:message code="mobile.areYouSureYou"/>？','<spring:message code="hrms.warning"/>', 
                    function (yes){
                        if(yes){          
                                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                                $.post("/mobile/invitationManage/addInvitation", 
                                    [   
                                        { name: 'INVITATION_ID', value: invitation},
                                        { name: 'CUST_NO', value: MyCheckNull($("#CUSTOMER_NO").val())},
                                        { name: 'REMARK', value: MyCheckNull($("#REMARK").val())}
                                    ]
                             , function (result){
                                $.ligerDialog.closeWaitting();
                                 if (result == "Y")
                                 {
                                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                                     {
                                        location.href = '/mobile/invitationManage/viewInvitationManage?MENU_CODE=mobile0201';
                                     });
                                 }
                                 else
                                 {
                                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="mobile.SavefailedReason"/>：'+result);
                                 }
                             }
                           );
                    }
                 }
                );
        }
    }
    //删除邀请码
    function spf_delete(){
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        if (row.BIND_STATUS == 'bind1') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="mobile.Boundinvitationcode"/>！！！') ; 
            return ;
        }

        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/mobile/invitationManage/deleteInvitation',
                        {"INVITATION_NO":row.INVITATION_NO}, 
                        function(result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y")
                            {
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                                {
                                    $grid.loadData(true);
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="mobile.DeletefailedReasons"/>'+result);
                            }
                        });
            }
        });
    }
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}, 
                        {name: 'S_DATE', value: $("#S_DATE").attr('value')},
                        {name: 'E_DATE', value: $("#E_DATE").attr('value')},
                        {name:'BIND_STATUS',value : $("#BIND_STATUS").val()},
                        {name:'USE_STATUS',value : $("#USE_STATUS").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
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
#showAddInvitationDiv{
    display:none;
}
#hrSearchEmp{
    margin-top:5px;
}
.inputClass{
    width:200px;
    height:23px;
    border:1px solid #A3C0E8;
}
.tableLabel{
    height:25px;
    line-height:25px;
    color:#014d7e;
    font-family:"宋体";
    text-align:center;
    background-color:#c1dbfa;
    font-size:12px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <div style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="keyWord"/></div></td>
                        <td class="l-table-edit-c" width="30%">
                            <input width="120" type="text" name="keyWord" id="keyWord" class="inputClass" onkeyup="spf_search()"/></td>
                        <td width="10%"><div class="tableLabel"><spring:message code="hrms.createDate"/></div></td>
                        <td class="l-table-edit-c" width="50%">
                            <input type="text" name="S_DATE" id="S_DATE" value="" size="25"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" /> ~ 
                            <input type="text" name="E_DATE" id="E_DATE" value="" size="25"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="mobile.bindStatus"/></div>
                        </td>
                        <td class="l-table-edit-c" width="30%">
                            <SipingSoft:selectSyCode parentCode="BIND_STATUS" name="BIND_STATUS"
                            limit="all" onChange="spf_search()"/>
                        </td>
                        <td width="10%"><div class="tableLabel"><spring:message code="mobile.registerStatus"/></div></td>
                        <td class="l-table-edit-c" width="50%">
                            <SipingSoft:selectSyCode parentCode="USE_STATUS" name="USE_STATUS"
                            limit="all" onChange="spf_search()"/>
                    </tr>
                </table>
            </div>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                    </td>
                </tr>
            </table>
            <div id = "showAddInvitationDiv" style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                        <td width="10%" align="center">
                            <a class="l-button"
                                style="width: 79px; height: 20px; align:center; "
                                onclick="spf_generateInvitaation()"><spring:message code="mobile.generateInvitation"/></a>
                        </td>
                        <td class="l-table-edit-c" width="30%">
                            <input width="120" type="text" name="INVITATION" id="INVITATION" class="inputClass" readOnly/>
                            <div id="CHECK_INVITATION"></div>
                        </td>   
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="mobile.bindCustomer"/></div>
                        </td>
                        <td class="l-table-edit-c" width="50%">
                            <input width="120" type="hidden" name="CUSTOMER_NO" id="CUSTOMER_NO" class="inputClass"/>
                            <input width="120" type="text" name="CUSTOMER_NAME" id="CUSTOMER_NAME" class="inputClass"/>
                        </td>
                    </tr>
                    <tr>    
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="mobile.customerUseingInvitation"/></div>
                        </td>
                        <td class="l-table-edit-c" width="30%">
                            <input width="150" type="text" name="REMARK" id="REMARK" class="inputClass" />
                        </td>
                    </tr>
                </table>
                <table width="99%" align="center">
                    <tr>
                        <td height="30">
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right;  "
                                onclick="spf_clearAddInvitationDiv()"><spring:message code="cancel"/></a>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right; margin-right: 10px; "
                                onclick="spf_addInvitation()"><spring:message code="hrms.save"/></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div id="getAllInvitation"></div>
    </div>
</body>
</html>
