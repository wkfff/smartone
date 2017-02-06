<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
<script src="/resources/js/web/password/password.js" type="text/javascript"></script>
<script type="text/javascript">
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            topHeight : 220,
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
    });

    function spf_Check() {
        if ($("#password").val() != $("#repassword").val()) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '两次密码输入不一致！！');
            return;
        }
        if ($("#password").val().length < 6) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
                    '<spring:message code="password6"/>' + ". "
                            + '<spring:message code="input.required"/>');
            return false;
        }
        $.ajax({
            type : 'get',
            url : '/ess/password/checkCheckCodeUpdatePassword',
            data : $("#form1").serialize(),//序列化表单里所有的内容
            async : false,
            success : function(data) {
                if (data === 'Y') {
                    parent.$.ligerMessageBox.success('成功', '密码修改成功！请用新密码登录');
                    parent.$dialog.close();
                } else {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','验证码匹配失败！请登录邮箱查询！');
                }
            }
        });
    }

    function getVerifyCode(){
        $("#textInfo").html("正在努力获取中...");
        setTimeout(function(){
            $.post("/ess/password/getVerifyCode",
                    [{name:"USERNAME",value:"${username}"}],
                    function(returnMsg){
                        if(returnMsg=='N'){
                            document.getElementById('textInfo').style.color='red';
                            $("#textInfo").html("获取失败！用户名不存在，或者你的个人信息还没有添加找回密码的邮箱，请联系人事管理员添加");
                        }else{
                            $("#textInfo").html("系统已将验证码发送到邮箱"+returnMsg);
                        }
                });
        },2000);
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    width:99%;
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
        <div position="top" style="width: 99%">
            <form name="form1" method="post"
                    action="/ess/password/checkCheckCodeUpdatePassword" id="form1">
                    <table width="99.6%" border="0">
                        <tr height="5px;"></tr>
                        <tr>
                            <td align="center" valign="middle" width="100%">
                                <table width="99.6%" cellpadding="1" cellspacing="1"
                                    style="height: 40px; font-size: 12px;">
                                    <tr>
                                      <td>
                                          <a id="getVerifyCode" class="l-button" style="width: 79px; height: 20px; float: left; 
                                            margin-left: 10px;" onclick="getVerifyCode()">获取验证码</a>
                                      </td>
                                      <td><div id="textInfo" style="color: green;"></div></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">① 点击获取验证码，系统将验证码发送到您的公司邮箱</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">② 登录邮箱获取验证码，进行密码修改(12 小时内有效)</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20%" align="right">验证码 :</td>
                                        <td width="84.6%" align="left"><input type="text"
                                            name="CHECK_CODE" id="CHECK_CODE" size="45"
                                            style="color: rgb(153, 153, 153); font-style: italic;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><input type="hidden" name="username" value="${username}"/></td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20%" align="right">新密码 :</td>
                                        <td width="84.6%" align="left"><input type="password"
                                            name="password" id="password" size="45"
                                            style="color: rgb(153, 153, 153); font-style: italic;"/></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td width="20%" align="right">重复新密码 :</td>
                                        <td width="84.6%" align="left"><input type="password"
                                            name="repassword" id="repassword" size="45"
                                            style="color: rgb(153, 153, 153); font-style: italic;"/></td>
                                    </tr>
                                </table>
                                <table width="99.6%" cellpadding="0" cellspacing="0"
                                    class="l-table-edit" height="25px;">
                                    <tr height="5px;"></tr>
                                    <tr>
                                        <td align="right" width="80px;"><a class="l-button"
                                            style="width: 79px; height: 21px; float: right; margin-left: 10px; "
                                            onclick="spf_Check()"><spring:message code="submit" /></a></td>
                                        <td width="15%"></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </form>
        </div>
    </div>
</body>
</html>