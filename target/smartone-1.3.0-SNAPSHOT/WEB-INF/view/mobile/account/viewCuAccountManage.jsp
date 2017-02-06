<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Account Manage</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css">

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    //修改密码，绑定屏幕触控事件
    $("#updatePassword").live("tap",function() {
        updatePassword(); 
    });
    function updatePassword(){
        location.href="/mobile/account/viewUpdatePassword";
    }
    //修改企业信息，绑定屏幕触控事件
    $("#updateCompanyInfo").live("tap",function() {
        updateCompanyInfo();
    });
    function updateCompanyInfo(){
        location.href="/mobile/account/viewUpdateCuCompanyInfo";
    }
    //修改收货人信息
    $("#updateReceiver").live("tap",function() {
        var receiverId = $(this).attr("recId");
        updateReceiver(receiverId);
    });
    function updateReceiver(id){
        location.href="/mobile/account/viewUpdateReceiverInfo?RECEIVER_ID="+id;
    }
    //添加收货人信息
    $("#addReceiver").live("tap",function() {
        addReceiverInfo();
    });
    //添加收货人信息
    $("#addReceiverInfo").live("tap",function() {
        addReceiverInfo();
    });
    function addReceiverInfo(){
        location.href="/mobile/account/viewAddReceiverInfo";
    }
    //删除收货人
    $("#deleteReceiver").live("tap",function(){
        var receiverId = $(this).attr("recId");
        var height = $(this).offset().top;

        if(confirm("<spring:message code='mobile.confirmDelete'/>")){
            $.post("/mobile/account/deleteReceiver", 
                [   
                    { name: 'RECEIVER_ID', value: receiverId}
                ]
                , function (result){
                    if (result == "DELETE_SUCCESS"){
                        showTips("<spring:message code='mobile.deleteSuccess'/>",height-20,1);
                        location.href = "/mobile/account/accountManage";
                    }else{
                        showTips("<spring:message code='mobile.deleteFail'/>",height-20,1);
                        location.href = "/mobile/account/accountManage";
                    }
                }
            );
        }
    });
</script>
<style>
    div{
        font-family:"微软雅黑";
        font-size:1em;
    }
    div[data-role="page"]{
        height:100%;
    }
    table{
        width : 100%;
        background-color : #ffffff;
        border:1px solid #cccccc;
        margin-top : 2px;
        border-collapse: collapse;
    }
    table thead td{
        border-bottom:1px solid #cccccc;
    }
    .ui-content{
        padding : 2px;
    }
</style>
</head>
<body>
    <div data-role="page" data-theme="b" >
        <div data-role="header" data-theme="b">
           <h1>个人中心</h1>
        </div>
        <div data-role="content" style="background-color:#eeeeee;">
            <div style="clear:both;" align="center">
                <img class="homePage" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
                <img id="loginOut" src="/resources/images/myimage/exit.png" style="width:35px;height:35px;margin-left:80px;"/>
            </div>
            <table id="accountInformation">
                <thead>
                    <tr>
                        <td style="width:38%;padding:6px;">修改密码</td>
                        <td align="right">
                            <img id="updatePassword" src="/resources/images/myimage/update.png" style="width:18px;height:18px;margin-right:10px;"/>
                       </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.userName'/>
                        </td>
                        <td>
                            ${CUSTOMER.USERNAME }
                            <input id="CUST_ID" type="hidden" value="${CUSTOMER.CUST_ID }"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <table id="companyInformation">
                <thead>
                    <tr>
                        <td style="width:38%;padding:6px;"><spring:message code='mobile.enterpriseInformation'/></td>
                        <td align="right">
                            <img id="updateCompanyInfo" src="/resources/images/myimage/update.png" style="width:18px;height:18px;margin-right:10px;"/>
                        </td>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.companyName'/>
                        </td>
                        <td>
                            ${CUSTOMER.CUST_NAME }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.companyTelephone'/>
                        </td>
                        <td>
                            ${CUSTOMER.TELEPHONE }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='hrms.e-mail'/>
                        </td>
                        <td>
                            ${CUSTOMER.EMAIL }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.registeredAddress'/>
                        </td>
                        <td>
                            ${CUSTOMER.REG_ADDRESS }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.officeAddress'/>
                        </td>
                        <td>
                            ${CUSTOMER.OFF_ADDRESS }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.bankName'/>
                        </td>
                        <td>
                            ${CUSTOMER.BANK }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.bankAccount'/>
                        </td>
                        <td>
                            ${CUSTOMER.BANK_ACOUNT }
                        </td>
                    </tr>
                    <tr>
                        <td style="width:38%;padding-left:6px;color: blue;">
                            <spring:message code='mobile.NPWP'/>
                        </td>
                        <td>
                            ${CUSTOMER.TEXPAYER_IDCODE }
                        </td>
                    </tr>
                </tbody>
            </table>
            <c:if test="${RECEIVERCNT==0 }">
                <table>
                        <thead>
                            <tr>
                                <td style="width:38%;padding:6px;"><spring:message code='mobile.consigneeInformation'/></td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style="width:38%;padding-left:6px;color: blue;">
                                    <spring:message code='mobile.addConsigneeTip'/>
                                    <a href="javascript:addReceiverInfo()"><spring:message code='mobile.clickHereToAdd'/></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
            </c:if>
            <c:if test="${RECEIVERCNT>0 }">
                <c:forEach items="${RECEIVERLIST}" var="receiver" varStatus="i">
                    <table>
                        <thead>
                            <tr>
                                <td style="width:38%;padding:6px;"><spring:message code='mobile.consigneeInformation'/>${i.index+1 }</td>
                                <td align="right">
                                    <img id="updateReceiver" recId="${receiver.RECERIVER_ID }" 
                                    src="/resources/images/myimage/update.png" style="width:18px;height:18px;margin-right:10px;"/>
                                    <img id="deleteReceiver" recId="${receiver.RECERIVER_ID }" 
                                        src="/resources/images/myimage/delete.png" style="width:18px;height:18px;margin-right:10px;"/>
                                 </td>
                            </tr>
                        </thead>
                        <tbody>
                            <tr >
                                <td style="width:38%;padding-left:6px;color: blue;"><spring:message code='hrms.deliveryAddress'/></td>
                                <td>${receiver.RECEIVER_ADDRESS }</td>
                            </tr>
                            <tr>
                                <td style="width:38%;padding-left:6px;color: blue;"><spring:message code='hrms.consignee'/></td>
                                <td>${receiver.RECEIVER_NAME }</td>
                            </tr>
                            <tr>
                                <td style="width:38%;padding-left:6px;color: blue;"><spring:message code='hrms.phoneNumber'/></td>
                                <td>${receiver.RECEIVER_MOBILE }</td>
                            </tr>
                            <tr>
                                <td style="width:38%;padding-left:6px;color: blue;"><spring:message code='hrms.fixedTelephone'/></td>
                                <td>${receiver.RECEIVER_TELEPHONE }</td>
                            </tr>
                            <tr>
                                <td style="width:38%;padding-left:6px;color: blue;"><spring:message code='hrms.e-mail'/></td>
                                <td>${receiver.RECEIVER_EMAIL }</td>
                            </tr>
                        </tbody>
                    </table>
                    <c:if test="${RECEIVERCNT == i.index + 1 }">
                        <table>
                            <thead>
                                <tr height="35">
                                    <td style="width:20px;" >
                                        <img id="addReceiver" src="/resources/images/myimage/add.png" style="width:18px;height:18px;"/>
                                    </td>
                                    <td>
                                        <a id="addReceiverInfo" style="color:#fa7902;font-weight: normal;">添加收货人</a>
                                    </td>
                                </tr>
                            </thead>
                        </table>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
</body>
</html>