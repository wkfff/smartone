<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="siping" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>产品激活</title>
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"/>

<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>

<script type="text/javascript">
$(function(){
    $("#getYear").html(new Date().getFullYear());
});

function sp_activate(){
    var pattern = /^[A-Za-z0-9]+$/;
    if($("#licenseKey").val() == ""){
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请输入密钥') ;
    }else if($("#licenseKey").val().length != 30 || !pattern.test($("#licenseKey").val())){
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '密钥格式错误') ;
    }else{
        var type = "";
        if($("#type1").is(':checked') == true){
            type = $("#type1").val();
        }else{
            type = $("#type2").val();
        }
        
        $.ligerDialog.waitting('激活中......');
        $.post("/activate/activate", 
            [   
                { name: 'licenseKey', value: $("#licenseKey").val() },
                { name: 'activateType', value: type }
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('激活成功<br/>确认后自动跳转','<spring:message code="hrms.warning"/>', function (){
                        window.location = "/";
                    });
                }else if(result.length>100){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', "网络连接超时，请稍后再试");
                }else{
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
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
    height:100%;
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
    background-image:url("/resources/images/home/divBody_back.gif");
    background-repeat:repeat-x;
    border-top:1px solid white;
}
#footer{
    width:100%;
    height:60px;
    border-top:3px solid #8ecbe8;
    background-color:#e5eff6;
}
#content{
    width:700px;
    height:450px;
    color:#014d7e;
    font-family:"微软雅黑";
    background-color:#f5f9fb;
    border:1px solid #A3C0E8;
    margin:0 auto;
}
#contentMain{
    width:640px;
    margin:0 auto;
}
.divTitle{
    width:100%;
    height:23px;
    color:#014d7e;
    font-size:12px;
    line-height:23px;
    font-weight: bold;
    background-image:url('/resources/images/myimage/divTitle.gif');
    border-bottom:1px solid #A3C0E8;
}
#activateBtn{
    width:80px;
    height:30px;
}
</style>
</head>
<body>
<div id="logo">
    <div style="width:20%;height:60px;float:right;">
        <img src="/resources/images/home/logoCloud.gif" style="width:120px;height:60px;margin-right:0px;float:right;"/>
    </div>
    <div style="width:80%;height:60px;float:right;">
       <img src="/resources/images/home/logo_title.png" style="width:450px;height:60px;margin-left:10px;float:left;"/>
    </div>
</div>
<div id="divBody">
    <br/>
    <div id="content">
        <div class="divTitle">&nbsp;产品激活</div>
        <div id="contentMain">
            <table style="width:100%;">
                <tr>
                    <td>
                        <img src="/resources/images/key.png" width="30" height="30" style="margin-top:10px;"/>
                    </td>
                    <td>
                        <label style="font-size:18px;">您好，您尚未激活本产品，请输入您的密钥进行激活</label>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" height="30"></td>
                </tr>
            </table>
            
            <form id="form1">
                <table style="font-size:14px;">
                    <tr>
                        <td class="title" colspan="4">激活方式:</td>
                    </tr>
                    <tr>
                        <td width="20">
                            <input type="radio" id="type1" name="activateType" value="1" checked="checked"/>
                        </td>
                        <td width="100" class="title2">在线激活</td>
                        <td width="20">
                            <input type="radio" id="type2" name="activateType" value="0"/>
                        </td>
                        <td width="500" class="title2">本地激活</td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="title" colspan="4">请输入密钥:</td>
                    </tr>
                    <tr>
                        <td colspan="4"><input name="licenseKey" id="licenseKey" type="text" style="width:100%;"/></td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right" height="100"><input id="activateBtn" type="button" value="激活" onclick="sp_activate()"/></td>
                    </tr>
                </table>
            </form>
            <div>提示：如果您是在线激活，激活期间，请保持您的网络畅通</div>
        </div>
    </div>
</div>
<div id="footer" style="position:absolute;left:0px;bottom:0px;text-align:center;line-height:25px;font-size:12px;color:#0b568f;text-decoration:none;margin-top:5px;">版权所有 © 
    <a href="javascript:s_goSiping()" style="font-size:12px;color:#0b568f;text-decoration:none;margin-top:5px;">成都四平软件有限公司 </a>2008-<label id="getYear"></label>
</div>
<img src="/resources/images/home/siping_logo.png" style="position: absolute;top:75px;left:15px;"/>
</body>
</html>
