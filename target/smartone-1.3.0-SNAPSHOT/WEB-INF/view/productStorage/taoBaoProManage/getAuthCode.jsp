<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    function goSiping(){
        top.window.open('http://www.sipingsoft.com');
    }
</script>
<style type="text/css">
#layout1{
    width:99.8%;
    margin:0;
    padding:0;
}
</style>
</head>
<body style="padding:0px">
<div id="layout1" >
    <center>
        <c:if test="${requestScope.top_session == null }">
            <div style="width:1000px;height:80px;line-height:80px; background-color: #fe7b21;color:white;"><h1>获取授权码失败！</h1></div>
            <div style="width:998px;height:400px;border:1px solid #fe7b21;">
                <div style="font-size:13px;margin-top:100px;color:#ff640a;">获取授权码失败，可能是网络原因，请稍后再试！</div>
            </div>
        </c:if>
        <c:if test="${requestScope.top_session != null }">
            <div style="width:1000px;height:80px;line-height:80px; background-color: #fe7b21;color:white;"><h1>恭喜你，获取授权码成功！</h1></div>
            <div style="width:998px;height:400px;border:1px solid #ff640a;">
                <div style="font-size:16px;margin-top:100px;color:#4581a9;">授权码：${top_session }</div>
                <div style="font-size:13px;margin-top:30px;color:#ff640a;">注：请妥善保管您的授权码，不要让他人知道。授权码有一定的有效期，通常是24小时，如授权码失效，可重新获取授权码！</div>
            </div>
        </c:if>
        <div style="width:998px;height:60px;line-height:30px;">
            &nbsp;<a href="javascript:goSiping()" style="text-decoration:none;color:#4581a9;">成都四平软件有限公司</a>
        </div>
    </center>
</div>
</body>
</html>

