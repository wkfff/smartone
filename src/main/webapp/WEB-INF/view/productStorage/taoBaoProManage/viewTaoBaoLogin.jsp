<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta http-equiv="Pragma" content="No-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Expires" content="-1">
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" /> 
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/resources/css/jquery.jqzoom.css">
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script> 
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src='/resources/js/jquery/jquery.jqzoom-core.js'></script> 

    <script type="text/javascript">
        function spf_getSessionKey(){
            top.window.open("http://container.api.tbsandbox.com/container?appkey=1021733955");
        }
    
        function spf_returnSessionKey(){
            return $("#sessionKey").val().replace(/\n/g,"");
        }
        
        function spf_checkTaoBaoLogin(){
            if($("#nick").val()==""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请输入店家昵称');
                return;
            }
            if($("#sessionKey").val()==""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请输入授权码');
                return;
            }
            $.ligerDialog.waitting('登录中......');
            $.post("/productStorage/taoBaoProManage/checkTaoBaoLogin", 
                [   
                    { name: 'nick', value: $("#nick").val() },
                    { name: 'sessionKey', value: $("#sessionKey").val().replace(/\n/g,"") }
                ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if(result == "Y"){
                        parent.spf_viewTaoBaoProList($("#nick").val(),$("#sessionKey").val().replace(/\n/g,""));
                    }else{
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '输入店家昵称与授权码不正确');
                    }
                }
            );
        }
    </script>
<style type="text/css">
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout2{  width:99.8%;margin:0; padding:0;}
    #layout3{  width:99.8%;margin:0; padding:0;}
    .goTaoBao{
        width:100px;
        height:30px;
        line-height:30px;
        text-align:center;
        display:block;
        color:white;
        text-decoration:none;
        background-color: #ff640a;
    }
</style>
</head>
<body style="padding:0px">
    <div id="layout2" >
        <table cellpadding="0" cellspacing="0" class="l-table-edit" width="99.8%" style="margin:0 auto;">
            <tr>
                <td align="center" height="50px" colspan="2" style="background-color:#ff640a;color:white;font-weight:bold;">
                    &nbsp;淘宝登入界面<br/>
                </td>
            </tr>
            <tr height="20">
                <td colspan="2"></td>
            </tr>
            <tr height="40">
                <td width="130" align="right" style="font-size:13px;">商家昵称：</td>
                <td align="center">
                    <input id="nick" style="width:378px;height:25px;"/>
                </td>
            </tr>
            <tr>
                <td align="right" valign="top" style="font-size:13px;">淘宝授权码：</td>
                <td align="center">
                    <textarea id="sessionKey" style="width:378px;height:100px;"></textarea>
                </td>
            </tr>
            <tr height="50">
                <td colspan="2" align="center">
                    <a class="goTaoBao" href="javascript:spf_checkTaoBaoLogin()">进入网店</a>
                </td>
            </tr>
            <tr>
                <td align="center" colspan="2"><a style="font-size:12px;" href="javascript:spf_getSessionKey()">获取授权码</a></td>
            </tr>
        </table>
    </div>
</body>
</html>

