<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>SipingSoft ERP</title>
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script language="JavaScript"> 
if (window != top){
    top.location.href = '/';
}
</script>
<script type="text/javascript">
    var flag = 0;
    $(document).ready(function() {
        $('#btn').click(function() {
            spf_doReCheckBox();
            check();
            if (flag == 1) {
                $("#Tip").text("Loading......");
                var options = {
                    url : '/login/in',
                    type : 'POST',
                    success : function(result) {
                        if (result == "1") {
                            location.href = "/login/home";
                        } else if (result == "2") {
                            location.href = "/login/supHome";
                        } else {
                            $('#Tip').html(result);
                        }
                    }
                };
                $('#loginForm').ajaxSubmit(options);
                return true;
            }
        });
        $("#getYear").html(new Date().getFullYear());
    });

    function spf_forgetPassword() {
        var username = $("#username").val();
        if (username == null || username == "") {
            $.ligerDialog.warn('请先输入用户名','<spring:message code="hrms.warning"/>');
            return;
        }
        $dialog = $.ligerDialog.open({
            isDrag : true,
            showMax : false,
            showMin : false,
            title : '找回密码',
            width : 500,
            height : 300,
            url : '/ess/password/forgetPassword?username=' + username
        });
    }

    function check() {
        var username = $("#username").val();
        if (username == "") {
            $("#Tip").text(
                    '<spring:message code="username"/>' + ' . '
                            + '<spring:message code="input.required"/>');
            flag = 0;
            return;
        }
        if (username != "") {
            $("#Tip").text('');
        }
        var password = $("#password").val();
        if (password == "") {
            $("#Tip").text(
                    '<spring:message code="password"/>' + ' . '
                            + '<spring:message code="input.required"/>');
            flag = 0;
            return;
        }
        if (password != "") {
            $("#Tip").text('');
        }
        var loginType = $("#loginType").val();
        if (loginType == "") {
            $("#Tip").text(
                    '<spring:message code="loginType"/>' + ' . '
                            + '<spring:message code="input.required"/>');
            flag = 0;
            return;
        }
        if (loginType != "") {
            $("#Tip").text('');
        }
        if (username != "" && password != "" && loginType != "") {
            flag = 1;
            return;
        }
    }
    //设置cookies函数
    function spf_doReCheckBox() {
        var checkb = document.getElementById("reBox");
        if (checkb.checked) {
            $.cookie('sperp.username', $("#username").val(), {expires : 5});
            $.cookie('sperp.password', $("#password").val(), {expires : 5});
            $.cookie('sperp.rememberMe', true, {expires : 5});
        } else {
            $.cookie('sperp.username', "");
            $.cookie('sperp.password', "");
            $.cookie('sperp.rememberMe', false, {expires : 5});
        }
    }
    //取cookies函数
    function spf_getCookie() {
        $("#username").val($.cookie('sperp.username'));
        $("#password").val($.cookie('sperp.password'));
        if($.cookie('sperp.rememberMe') == 'true'){
            document.getElementById("reBox").checked = true;
        }
    }
    
    function s_goSiping(){
        window.open("http://www.sipingsoft.com");
    }
</script>
<style type="text/css">
html,body {
    margin: 0px;
    background-color:#e5eff6;
    width: 100%;
    font-size: 12px;
}
#logo{
    width:100%;
    height:60px;
    background-color:#4790bc;
    border-bottom:5px solid #085583;
}
#divBody{
    width:100%;
    height:600px;
    background-image:url("/resources/images/home/divBody_back.gif");
    border-top:1px solid white;
    border-bottom:3px solid #8ecbe8;
}
#homeLeft,#homeRight{
    width:49.8%;
    height:100%;
    float:left;
}
.loginLabel{
    font-family:'宋体';
    font-size:13px;
    color:#0b568f;
}
#footer{
    width:100%;
    height:60px;
    background-color:#e5eff6;
}

.login_bg {
    /* background: url(/resources/images/login/login_bg_2.jpg) no-repeat left top; */
    text-align: left;
}

.login_bg span {
    display: block;
    padding-left: 10px;
    background: url(/resources/images/login/arrow.jpg) no-repeat left 50%;
}

.login_bg td {
    padding-top: 2px;
    padding-bottom: 2px;
}

.login_bg label {
    color: #5D3024;
}

.input_login {
    border: 1px solid #B4B4B4;
    height: 23px;
    line-height:23px;
    width: 200px;
    background-color: #ddedfc;
    padding-left: 20px;
}

#username {
    background-image: url("/resources/images/login/user_bg.gif");
    background-repeat: no-repeat;
}

#password {
    background-image: url("/resources/images/login/pass_bg.gif");
    background-repeat: no-repeat;
}

form {
    margin: 0px;
    padding: 0px;
}

#btn {
    width: 69px;
    height: 25px;
    border:1px solid #d0a572;
    background-image:url("/resources/images/home/login_button.gif");
    line-height:25px;
    font-size:13px;
    font-family:"宋体";
    color:#0b568f;
    cursor: pointer;
}
</style>
</head>
<body onload="spf_getCookie()">
<div id="logo">
    <div style="width:20%;height:60px;float:right;">
        <img src="/resources/images/home/logoCloud.gif" style="width:120px;height:60px;margin-right:0px;float:right;"/>
    </div>
    <div style="width:80%;height:60px;float:right;">
       <img src="/resources/images/home/logo_title.png" style="width:450px;height:60px;margin-left:10px;float:left;"/>
    </div>
</div>
<div id="divBody">
    <div id="homeLeft">
        <img src="/resources/images/home/homeLeft_back.png" style="width:400px;height:300px;background-color:gray;float:right;margin-right:90px;margin-top:120px;"/>
    </div>
    <div style="float:left;width:1px;height:100%;">
        <img src="/resources/images/home/center_div_line.png"/>
    </div>
    <div id="homeRight">
        <div style="width:400px;height:300px;float:left;margin-left:90px;margin-top:80px;">
            <table width="200px;" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td width="15px"></td>
                    <td width="30px;" valign="bottom"><img src="/resources/images/home/login_head.png" style="width: 30px;height: 35px;"/> </td>
                    <td valign="bottom">
                        <label style="font-size:20px;font-family:'微软雅黑';color:#0b568f;font-weight:bold;">
                            <spring:message code="home.userLogin" />
                        </label>
                    </td>
                </tr>
                <tr style="height:5px;">
                    <td colspan="3" valign="bottom">
                        <img src="/resources/images/home/login_div_line.png"/>
                    </td>
                </tr>
            </table>
            <form id="loginForm" onkeydown="if(event.keyCode==13) $('#btn').click();">
                <table style="width:230px;margin-top:20px;margin-left:50px;">
                    <tr style="height:25px;">
                        <td><label class="loginLabel"><spring:message code="home.enterUserName" />:</label></td>
                    </tr>
                    <tr style="height:40px;">
                        <td width="230" valign="top"><input type="text" class="input_login" name="username" id="username" onkeyup="check()" /></td>
                    </tr>
                    <tr style="height:25px;">
                        <td><label class="loginLabel"><spring:message code="home.enterPassword" />:</label></td>
                    </tr>
                    <tr style="height:40px;">
                        <td width="230" valign="top"><input type="password" class="input_login" name="password" id="password" onkeyup="check()" /></td>
                    </tr>
                    <tr>
                        <td align="center" height="30" valign="top"><input type="checkbox" name="checkbox" value="checkbox" id='reBox' onClick="spf_doReCheckBox();" /> <label
                            style="font-size: 12px; cursor: pointer;"><spring:message code="rememberMe" /></label> &#12288; <label style="font-size: 12px; cursor: pointer;"
                            onclick="spf_forgetPassword();"><spring:message code="forgotPassword" /></label></td>
                    </tr>
                    <tr>
                        <td>
                            <div class="mouse" id="btn" style="cursor: pointer;">
                                <label style="margin-left:25px;cursor:pointer;">
                                    <spring:message code="mobile.login" />
                                </label>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center"><span id="Tip" style="color: red; font-size: 12px;">${msg}</span></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</div>
<div id="footer" style="text-align:center;line-height:25px;font-size:12px;color:#0b568f;text-decoration:none;margin-top:5px;">版权所有 © 
    <a href="javascript:s_goSiping()" style="font-size:12px;color:#0b568f;text-decoration:none;margin-top:5px;">成都四平软件有限公司 </a>2008-<label id="getYear"></label>
</div>
<img src="/resources/images/home/siping_logo.png" style="position: absolute;top:75px;left:15px;"/>
</body>
</html>