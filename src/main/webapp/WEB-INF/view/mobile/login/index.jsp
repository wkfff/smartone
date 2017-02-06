<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width, height=device-height, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<!-- <link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css"> -->
<link rel="stylesheet" href="/resources/css/jquery/jqm.structure.css" />
<link rel="stylesheet" href="/resources/css/jquery/you-jqm-themes.css" />

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.cookie.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    $(function(){
        if(${sessionScope.LoginUser!=null }){
            setTimeout(function(){
                location.href="/mobile/home";
            }, 3000);
        }
    });
    //登陆按钮，绑定屏幕触控事件
    $("#submit").live("tap",function() {
        spf_submit(); //提交相关登陆信息，进行验证
    });
    function spf_submit() {
        if (checkUserName() && checkPassword()) {
            save_cookie();
            $.post('/login/in', {
                username : $("#J_UserNameTxt").val(),
                password : $("#J_PassWordTxt").val()
            }, function(result) {
                if (result == "1") {
                    var targetUrl = '${sessionScope.targetUrl}';
                    if(targetUrl==''||targetUrl=='null'){
                        targetUrl = '/mobile/home';
                    }
                    location.href = targetUrl;
                } else {
                    showTips("<spring:message code='mobile.loginAgain'/>", 100, 3);
                }
            });
        }
    }
    //自动登录选中时，将用户名和密码放入Cookie中
    function save_cookie(){
        var checkb = document.getElementById("autoLogin");
        if (checkb.checked) {
            $.cookie('sperp.username', $("#J_UserNameTxt").val(), {expires : 5});
            $.cookie('sperp.password', $("#J_PassWordTxt").val(), {expires : 5});
            $.cookie('sperp.autoLogin', true, {expires : 5});
        } else {
            $.cookie('sperp.username', "",{path:"/"});
            $.cookie('sperp.password', "",{path:"/"});
            $.cookie('sperp.autoLogin',"",{path:"/"});
        }
    }
    //页面加载完后，将用户名和密码值从Cookie中取出放入对应input,并调用登录的方法，使其自动登录
    window.onload=function(){
        $("#J_UserNameTxt").val($.cookie('sperp.username'));
        $("#J_PassWordTxt").val($.cookie('sperp.password'));
        if($.cookie('sperp.autoLogin') == 'true'){
            //document.getElementById("autoLogin").checked = true;
            $('#autoLogin').prop('checked', true).checkboxradio('refresh');//jQuery mobile较为特殊，须采用该方法才能将checkbox设置为选中
        }else{
            $('#autoLogin').prop('checked', false).checkboxradio('refresh');
        }
        //alert($("#J_UserNameTxt").val());
        if($("#J_UserNameTxt").val() != "" && $("#J_PassWordTxt").val() != ""){
            spf_submit();
        }
    }
    //显示加载器
    function spf_showLoader() {
        //显示加载器.for jQuery Mobile 1.2.0  
        $.mobile.loading('show', {
            text : '正在登陆...', //加载器中显示的文字  
            textVisible : true, //是否显示文字  
            theme : 'a', //加载器主题样式a-e  
            textonly : false, //是否只显示文字  
            html : "" //要显示的html内容，如图片等  
        });
    }
    //隐藏加载器
    function spf_hideLoader() {
        //隐藏加载器  
        $.mobile.loading('hide');
    }
    //用户名非空验证 
    function checkUserName() {
        var username = $("#J_UserNameTxt").val();
        if (username.trim() == "") {
            $("#showUserTips").attr("style", "display:block");
            $("#showUserTips").text("<spring:message code='mobile.inputUserName'/>");
            return;
        }else if(username.trim()=="admin"||username.trim()=="hr_admin"){
            $("#showUserTips").attr("style", "display:block");
            $("#showUserTips").text("系统管理员暂无登录权限");
            return;
        }else {
            $("#showUserTips").attr("style", "display:none");
            return true;
        }
    }
    //密码非空验证
    function checkPassword(){
        var password = $("#J_PassWordTxt").val();
        if (password == "") {
            $("#showPawTips").attr("style", "display:block");
            $("#showPawTips").text("<spring:message code='mobile.inputPassword'/>");
            return;
        }else {
            $("#showPawTips").attr("style", "display:none");
            return true;
        }
    }
    //a标签存在问题（CSS文件没有加载成功）
    function toRegister(){
        location.href = "/mobile/login/register";
    }
    function toHome(){
        location.href = "/mobile/home";
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
    #submit{
        background-color: purple;
    }
    .login-stainfo{
        height: 40px;
        line-height: 40px;
        color: blue;
        font-size: 14px;
    }
</style>
</head>
<body>
    <div data-role="page" data-theme="b">
        <c:if test="${sessionScope.LoginUser==null }">
        <div data-role="content">
                <form id="J_Login" action="" method="post">
                    <fieldset>
                        <div>
                            <input id="J_UserNameTxt" type="text" placeholder="<spring:message code='mobile.userName'/>" 
                                name="username" onblur="checkUserName()" />
                        </div>
                        <span class="tips" id="showUserTips"></span>
                        <div style="height: 10px;width: 100%;"></div>
                        <div>
                            <input id="J_PassWordTxt" type="password" placeholder="<spring:message code='mobile.password'/>" name="password" onblur="checkPassword()" />
                        </div>
                        <span class="tips" id="showPawTips"></span>
                        <table style="width:100%;">
                            <tr>
                                <td style="width:50%;">
                                    <input type="checkbox" name="autoLogin" id="autoLogin" data-mini="false" data-theme="c"/>
                                    <label for="autoLogin"><font color="#2489ce"><spring:message code='mobile.autoLogin'/></font></label>
                                </td>
                                <td style="width:50%;" align="right">
                                    <input type="button" value="<spring:message code='mobile.login'/>" data-inline="true" id="submit" />
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr style="height: 20px;"></tr>
                            <tr>
                                <td style="width:50%;text-align:left;">
                                    <a href="javascript:toHome()">首页&gt;</a>
                                </td>
                                <td style="width:50%;text-align: right;">
                                    <a href="javascript:toRegister()"><spring:message code='mobile.register'/>&gt;</a>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
        </div>
        </c:if>
        <c:if test="${sessionScope.LoginUser!=null }">
        <div class="login-stainfo">已经登录，正在跳转到首页......</div>
        </c:if>
    </div>
</body>
</html>