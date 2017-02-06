<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微信设置</title>
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
function manaParam(wId,aId,aSc){
    $("#basicParamForm").show();
    $("#basicParamTable").hide();
    $("#wechatId").val(wId);
    $("#appId").val(aId);
    $("#appSecret").val(aSc);
}
function paramBack(){
    $("#basicParamForm").hide();
    $("#basicParamTable").show();
    $("#wechatId").val("");
    $("#appId").val("");
    $("#appSecret").val("");
}
function checkData(){
    if($("#wechatId").val()==""){
        $("#wechatId").focus();
        return false;
    }
    if($("#appId").val()==""){
        $("#appId").focus();
        return false;
    }
    if($("#appSecret").val()==""){
        $("#appSecret").focus();
        return false;
    }
    return true;
}
function saveWechatParam(){
    if(checkData()){
        var options = {
            url : '/wechat/addOrUpWechatParam',
            type : 'post',
             error : function(){
                alert('保存失败');
            },
            success : function(str){
                if (str == "Y") {
                    alert("保存成功");
                    window.location.reload(true);
                } else {
                    alert(str);
                }
            }
        };
        $("#basicParamForm").ajaxSubmit(options);
    }
    return false;
}
</script>
<style type="text/css">
body,div{
    margin: 0 auto;
    font-size: 12px;
}
a{
    cursor: pointer;
}
.wechatMain{
    width: 80%;
}
.basicParamTable{
    width: 100%;
}
tr{
    height: 30px;
    line-height: 30px;
}
.line-t{
    width: 50px;
}
.line-c{
    width: 200px;
}
#basicParamForm{
    display: none;
}
.topTips{
    margin-top: 20px;
    height: 80px;
    line-height: 25px;
    text-indent: 2em;
    color: #FF0000;
}
.basicParamDiv{
    width: 60%;
}
</style>
</head>
<body>
    <div class="wechatMain">
        <div class="topTips">提醒：企业微信号由微信运营者通过网址https://mp.weixin.qq.com自行设定，AppId和AppSecret需在微信公众平台开发者中心获取，
        AppId和AppSecret是企业微信接口开发的重要凭证，请妥善保管，不要随意告诉他人，一旦泄露，可能发生菜单被恶意更改的情况。此页面信息不能随意更改，否则后果自负。</div>
        <div class="basicParamDiv">
            <table id="basicParamTable" class="basicParamTable">
                <tr>
                    <td class="line-t">企业微信号：</td>
                    <td class="line-c">${pa.wechatId }</td>
                </tr>
                <tr>
                    <td class="line-t">AppId：</td>
                    <td class="line-c">${pa.appId }</td>
                </tr>
                <tr>
                    <td class="line-t">AppSecret：</td>
                    <td class="line-c">${pa.appSecret }</td>
                </tr>
                <tr>
                    <td class="line-t"></td>
                    <td class="line-c"><button onclick="manaParam('${pa.wechatId }','${pa.appId }','${pa.appSecret }')">管理</button></td>
                </tr>
            </table>
            <form id="basicParamForm">
                <table class="basicParamTable">
                    <tr>
                        <td class="line-t">企业微信号：</td>
                        <td class="line-c"><input name="wechatId" id="wechatId" placeholder="填写企业的微信号" /></td>
                    </tr>
                    <tr>
                        <td class="line-t">AppId：</td>
                        <td class="line-c"><input name="appId" id="appId" placeholder="填写开发者AppId" /></td>
                    </tr>
                    <tr>
                        <td class="line-t">AppSecret：</td>
                        <td class="line-c"><input name="appSecret" id="appSecret" placeholder="填写开发者AppSecret" /></td>
                    </tr>
                    <tr>
                        <td class="line-t">
                            <c:if test="${pa==null }">
                            <input name="id" id="keyId" type="hidden" value="0"/>
                            </c:if>
                            <c:if test="${pa!=null }">
                            <input name="id" id="keyId" type="hidden" value="${pa.id }"/>
                            </c:if>
                        </td>
                        <td class="line-c">
                            <button type="button" onclick="paramBack()">返回</button>
                            <button type="submit" onclick="return saveWechatParam();">保存</button>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>