<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link rel="stylesheet" href="/resources/css/mobile/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/mobile/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="/resources/css/mobile/flexigrid.pack.css" />
</head>
<body>
    <div>
        <form id="searchForm" style="margin-top: 20px;">
            <table>
            <tr><td><input type="text" id="keyWord" name="keyWord" value="" placeholder="输入昵称关键字" style="margin-bottom: 0;"/></td>
            <td><button type="button" onclick="searchData()">搜索</button></td></tr>
            </table>
        </form>
        <table id="userGrid" style="display:none"></table>
    </div>
    <script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/resources/js/mobile/bootstrap.min.js" type="text/javascript"></script>
    <script src="/resources/js/mobile/flexigrid.pack.js" type="text/javascript"></script>
    <script type="text/javascript">
        $("#userGrid").flexigrid({
            url: '/wechat/getRegistUserList',
            dataType: 'json',
            colModel : [
                {display: '编号', name : 'id', width : 40, align: 'center'},
                {display: '昵称', name : 'nickname', width : 130, align: 'center'},
                {display: '加密编号', name : 'openid', width : 220, align: 'center'},
                {display: '状态', name : 'subscribe', width : 90, align: 'center'},
                {display: '关注日期', name : 'subscribeTime', width : 130, align: 'center'},
                {display: '省份', name : 'province', width : 130, align: 'center'},
                {display: '城市', name : 'city', width : 130, align: 'center'}
                ],
            usepager: true,
            title: '用户列表',
            pr :10,
            useRp: true,
            showTableToggleBtn: false,
            onSubmit: addFormData,
            width: '100%',
            height: 400,
            searchitems : [{display: '昵称', name : 'nickname'}]
        });
        function addFormData(){
            var dt = $('#searchForm').serializeArray();
            $("#userGrid").flexOptions({params: dt});
            return true;
        }
        function searchData(){
            $('#userGrid').flexReload();
        }
    </script>
</body>
</html>