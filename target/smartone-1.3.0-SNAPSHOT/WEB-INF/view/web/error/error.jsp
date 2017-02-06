<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ page import="java.lang.Exception"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>错误页面</title>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
</head>
<body>
    <h1>出错了</h1>
    <%Exception e = (Exception) request.getAttribute("exception");out.print(e.getMessage());%>
</body>
</html>
