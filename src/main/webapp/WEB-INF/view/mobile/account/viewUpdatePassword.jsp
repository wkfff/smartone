<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Employee Account Manage</title>
<meta name="viewport" content="width=device-width,height=device-height, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<!-- <link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    //提交按钮，绑定屏幕触控事件
    $("#submit").live("tap",function() {
        spf_submit(); //提交相关登陆信息，进行验证
    });
    function spf_submit() {
        if (checkOldPassword()&checkNewPassword()&checkPasswordMatch()) {
            $.post('/mobile/account/updatePassword', {
                OLD_PASSWORD : $("#OLD_PASSWORD").val(),
                NEW_PASSWORD : $("#NEW_PASSWORD").val()
            }, function(result) {
                if ("WRONG_OLD_PASSWORD" == result) {
                    showTips( "<spring:message code='mobile.oldPasswordError'/>", 150, 2);
                    $("#OLD_PASSWORD").val("");
                }else if ("UPDATE_PASSWORD_SUCCESS" == result) {
                    showTips( "密码修改成功，正在跳转登陆页面......", 150, 4);
                    setTimeout(function(){
                        $.cookie('sperp.username', "");
                        $.cookie('sperp.password', "");
                        location.href = "/login/out";
                    }, 3000);
                }else {
                    showTips( "<spring:message code='mobile.updatePasswordFail'/>", 150, 2);
                }
            });
        }
    }
    //检查两次输入的新password是否一致
    function checkPasswordMatch(){
        var newPassword = $("#NEW_PASSWORD").val();
        var confirmPassword = $("#CONFIRM_PASSWORD").val();
        
        if (confirmPassword == "") {
            $("#showMatchTips").attr("style", "display:block");
            $("#showMatchTips").text("<spring:message code='mobile.inputConfrimPassword'/>");
            return false;
        }else if (newPassword == confirmPassword) {
            $("#showMatchTips").attr("style", "display:none");
            return true;
        }else {
            $("#showMatchTips").attr("style", "display:block");
            $("#showMatchTips").text("<spring:message code='mobile.passwordNotMatch'/>");
            return false;
        }
    }
    //检查当前密码非空
    function checkOldPassword(){
        var password = $("#OLD_PASSWORD").val();
        if (password == "") {
            $("#showOldPawTips").attr("style", "display:block");
            $("#showOldPawTips").text("<spring:message code='mobile.inputOldPassword'/>");
            return;
        }else {
            $("#showOldPawTips").attr("style", "display:none");
            return true;
        }
    }
    //检查重置密码非空
    function checkNewPassword(){
        var password = $("#NEW_PASSWORD").val();
        if (password == "") {
            $("#showNewPawTips").attr("style", "display:block");
            $("#showNewPawTips").text("<spring:message code='mobile.inputNewPassword'/>");
            return;
        }else {
            $("#showNewPawTips").attr("style", "display:none");
            return true;
        }
    }
</script>
<style>    
    div{
        font-family:"微软雅黑";
        font-size:1em;
    }
    div[data-role="content"]{
        height:100%;
    }
    .tips{
        display: none;
        color:red;
    }
    .ui-content{
        height : 100%;
    }
    .ui-input-text {
        background-color: #fff;
    }
    #submit{
        background-color: purple;
    }
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <div data-role="content">
            <table style="width:100%;">
                <tr>
                    <td>
                        <spring:message code='current.password'/>
                    </td>
                    <td>
                        <input id="OLD_PASSWORD" type="password" onblur="checkOldPassword()"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <span class="tips" id="showOldPawTips"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <spring:message code='new.password'/>
                    </td>
                    <td>
                        <input id="NEW_PASSWORD" type="password" onblur="checkNewPassword()"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <span class="tips" id="showNewPawTips"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <spring:message code='confirmation.password'/>
                    </td>
                    <td>
                        <input id="CONFIRM_PASSWORD" type="password" onblur="checkPasswordMatch()"/>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <span class="tips" id="showMatchTips"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="button" value="<spring:message code='submit'/>" id="submit" />
                    </td>
                </tr>
            </table>
            <c:if test="${sessionScope.LoginUser.accountType == 'EM' }">
              <table style="width: 100%;">
                  <tr style="height: 20px;"></tr>
                  <tr>
                      <td style="text-align: right;color: blue;">
                          <a id="loginOut">退出系统&gt;</a>
                      </td>
                 </tr>
             </table>
           </c:if>
           <c:if test="${sessionScope.LoginUser.accountType == 'CU' }">
              <div>
                <img id="backToAccountManage" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
              </div>
           </c:if>
        </div>
        <div style="height: 60px;"></div>
        <div style="position: fixed;bottom: 0;width: 100%;"><%@ include file="/WEB-INF/view/mobile/footer.jsp"%></div>
    </div>
</body>
</html>