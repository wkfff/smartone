<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="siping" tagdir="/WEB-INF/tags" %>
<html>
<head>
<title></title>
<script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>

<script type="text/javascript">
    function spf_getExtendLimitationData(){
        var type = "";
        if($("#type1").is(':checked') == true){
            type = $("#type1").val();
        }else{
            type = $("#type2").val();
        }
        return {activateType: type, licenseKey: $("#licenseKey").val()};
    }
</script>
<style type="text/css">
        #main{
        width:1000px;
        margin:0 auto;
    }
    #logo{
        width:100%;
        height:70px;
        line-height:70px;
        font-family:"隶书";
        font-size:30px;
        text-align: center;
    }
    #content{
        width:100%;
        height:600px;
        background-color:#f1f1f1;
        border:1px solid #dddddd;
    }
    #footer{
        text-align:center;
        line-height:25px;
        font-size:12px;
        color:#0b568f;
        text-decoration:none;
        margin-top:5px;
    }
    input{
        height:23px;
    }
    .title{
        font-family:"微软雅黑";
        font-size:14px;
        color:#333433;
    }
    
    .title2{
        font-family:"宋体";
        font-size:12px;
        color:#333433;
    }
    
    table{
        width:500px;
        margin-top:50px;
    }
</style>
</head>
<body>
    <h2>更新License Key</h2>
    <table>
        <tr>
            <td class="title" colspan="4">请选择激活方式:</td>
        </tr>
        <tr>
            <td width="20">
                <input type="radio" id="type1" name="activateType" value="1" checked="checked"/>
            </td>
            <td width="100" class="title2">在线激活</td>
            <td width="20">
                <input type="radio" id="type2" name="activateType" value="0"/>
            </td>
            <td width="360" class="title2">本地激活</td>
        </tr>
        <tr>
            <td colspan="4">&nbsp;</td>
        </tr>
        <tr>
            <td class="title" colspan="4">请输入License Key:</td>
        </tr>
        <tr>
            <td colspan="4"><input name="licenseKey" id="licenseKey" type="text" style="width:100%;"/></td>
        </tr>
    </table>
</body>
</html>
