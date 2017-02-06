<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Register</title>
<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<!-- <link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    var usernameFlag = false; //验证用户名是否存在的标志位,false表示该用户不存在
    var invitationFlag = 1; //验证邀请码状态，0表示不存在，1表示可用，2表示已使用
    //绑定屏幕触控事件
    $("#verifyCode").live("tap",function() {
        changeImgSrc(this); //验证码刷新 
    });
    function changeImgSrc(data){
        $(data).attr('src', '/mobile/login/verifyCode?' + Math.floor(Math.random()*100) );
    }
    //确认按钮绑定屏幕触控事件，用于注册确认
    $("#confirm").live("tap",function(){
        spf_confirm(); //注册信息验证及提交
    });
    function spf_confirm() {
        if (checkUserName()&&checkPassword()&&checkInvitation()&&checkVerifyCode()) {
            $.post('/mobile/login/insertRegisterInfo', {
                USERNAME : $("#J_UserNameTxt").val(),
                INPUT_PASSWORD : $("#J_PassWordTxt").val(),
                INPUT_VERIFY_CODE : $("#J_VerifyCode").val()
            }, function(result) {
                if (result == "WRONG_VERIFY_CODE") {
                    showTips( "<spring:message code='mobile.wrongVerifyCode'/>", 150, 1 );
                    $("#J_PassWordTxt").val("");
                    $("#J_VerifyCode").val("");
                    $("#J_Invitation").val("");
                    changeImgSrc("#verifyCode");
                }else if (result == "INSERT_SUCCESS") {
                    showTips("注册成功，正在跳转登录页面......", 150, 4);
                    setTimeout(function(){
                        location.href = "/mobile/login/index";
                    }, 4000);
                    /* $.post('/login/in', {
                        username : $("#J_UserNameTxt").val(),
                        password : $("#J_PassWordTxt").val()
                    }, function(result) {
                        if (result == "1") {
                            location.href = "/mobile/home";
                        } else {
                            showTips("<spring:message code='mobile.registerSuccessToLogin'/>", 150, 1 );
                            location.href = "/mobile/login/index";
                        }
                    }); */
                }else {
                    showTips("<spring:message code='mobile.registerFail'/>", 150, 1 );
                    $("#J_PassWordTxt").val("");
                    $("#J_VerifyCode").val("");
                    $("#J_Invitation").val("");
                    changeImgSrc("#verifyCode");
                }
            });
        }
    }
    //用户名非空验证，用户名重复验证
    function checkUserName() {
        var username = $("#J_UserNameTxt").val();
        if (username == "" || username == undefined) {
            $("#showUserTips").attr("style", "display:block");
            $("#showUserTips").text("<spring:message code='mobile.inputUserName'/>");
            return;
        }else {
            isExistsUsername(username);
            if (usernameFlag) {
                $("#showUserTips").attr("style", "display:block");
                $("#showUserTips").text("<spring:message code='mobile.existsUsername'/>");
                return;
            } else {
                $("#showUserTips").attr("style", "display:none");
                return true;
            }
        }
    }
    //验证用户名是否已存在
    function isExistsUsername(name) {
         $.ajax({  
                url : '/mobile/login/isExistsUsername',  
                async: false,
                data : [ {  
                    name : "USERNAME",  
                    value : name  
                } ],  
                type : 'post',    
                success : function(data) {  
                    if (data > 0) {
                        usernameFlag = true;
                    }else {
                        usernameFlag = false;
                    }
                }  
            });
    }
    //密码非空验证
    function checkPassword(){
        var invitation = $("#J_Invitation").val();
        var password = $("#J_PassWordTxt").val();
        if(invitation==password){
            $("#showInviTips").attr("style", "display:none");
            $("#showPawTips").attr("style", "display:none");
        }
        if (password == "" || password == undefined) {
            $("#showPawTips").attr("style", "display:block");
            $("#showPawTips").text("<spring:message code='mobile.inputPassword'/>");
            return ;
        }else {
            $("#showPawTips").attr("style", "display:none");
            return true;
        }
    } 
    //邀请码非空验证，邀请码是否存在与否验证
    function checkInvitation(){
        var invitation = $("#J_Invitation").val();
        var password = $("#J_PassWordTxt").val();
        if (invitation == "" || invitation == undefined) {
            $("#showInviTips").attr("style", "display:block");
            $("#showInviTips").text("请再次输入密码");
            return ;
        }else {
            if(invitation!=password){
                $("#showInviTips").attr("style", "display:block");
                $("#showInviTips").text("两次输入密码不一致");
                return ;
            }else{
                $("#showInviTips").attr("style", "display:none");
                return true;
            }
        }
    }
    //邀请码状态检查
    function checkInvitationId(id) {
        $.ajax({
            url : '/mobile/login/checkInvitationId',  
            async: false,
            data : [ {  
                name : "INVITATION_ID",  
                value : id  
            } ],  
            type : 'post',    
            success : function(data) {  
                if (data == "not_exists") {
                    invitationFlag = 0;
                }else if (data == "be_used"){
                    invitationFlag = 2;
                }else {
                    invitationFlag = 1;
                }
            }  
        }); 
    }
    //验证码非空验证
    function checkVerifyCode() {
        var verifyCode = $("#J_VerifyCode").val();
        if (verifyCode == "" || verifyCode == undefined) {
            $("#showVeriTips").attr("style", "display:block");
            $("#showVeriTips").text("<spring:message code='mobile.inputVerifyCode'/>");
            return ;
        }else {
            $("#showVeriTips").attr("style", "display:none");
            return true;
        }
    }
    function returnIndex() {
        location.href="/mobile/login/index";
    }
</script>
<style>
    div{
        font-family:"微软雅黑";
    }
    div[data-role="page"]{
        height:100%;
        background-color:#eeeeee;
    }
    #J_UserNameTxt {
      width:90%;
      background: url('/resources/images/login/user_bg1.png') no-repeat 5px 10px;
      padding: 3px 3px 3px 30px;
    }
    #J_PassWordTxt {
      width:90%;
      background: url('/resources/images/login/pass_bg1.png') no-repeat 1px 10px;
      padding: 3px 3px 3px 30px;
    }
    #J_Invitation{
      width:90%;
      background: url('/resources/images/login/pass_bg1.png') no-repeat 1px 10px;
      padding: 3px 3px 3px 30px;
    }
    #J_VerifyCode {
      width:80%;
      background: no-repeat 1px 1px;
      padding: 3px 3px 3px 30px;
    }
    .tips{
        display: none;
        color:red;
    }
    a:link,a:visited{
        text-decoration:none
    }
    input {
        height:35px;
    }
    .ui-input-text {
        background-color: #fff;
    }
    #confirm{
        background-color: purple;
    }
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1>用户注册</h1>
        </div>
        <div data-role="content">
            <table style="width:100%;">
                <tr>
                    <td colspan="2">
                        <input id="J_UserNameTxt" type="text" placeholder="<spring:message code='mobile.userName'/>" 
                            name="username" onblur="checkUserName()" />
                        <span class="tips" id="showUserTips"></span>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input id="J_PassWordTxt" type="password" placeholder="<spring:message code='mobile.password'/>" 
                            name="password" onblur="checkPassword()" />
                        <span class="tips" id="showPawTips"></span>
                    </td>
                 </tr>
                 <tr>
                    <td colspan="2">
                        <input id="J_Invitation" type="password" placeholder="确认密码" onblur="checkInvitation()" />
                        <span class="tips" id="showInviTips"></span>
                    </td>
                 </tr>
                 <tr>
                    <td width="50%">
                        <input id="J_VerifyCode" type="text" placeholder="<spring:message code='mobile.verifyCode'/>" 
                            name="verifyCode" onblur="checkVerifyCode()"/>
                    </td>
                    <td width="50%">
                        <img id="verifyCode" src="/mobile/login/verifyCode" />
                    </td>
                 </tr>
                 <tr>
                    <td><span class="tips" id="showVeriTips"></span></td>
                 </tr>
                 <tr>
                    <td align="left" width="50%">
                        <a id="back" style="color: b"><spring:message code='prostor.back'/>></a>
                    </td>
                    <td align="right" width="50%">
                        <input type="button" value="<spring:message code='confirm'/>" data-inline="true" id="confirm"/>
                    </td>
                 </tr>
            </table>
        </div>
    </div>
</body>
</html>