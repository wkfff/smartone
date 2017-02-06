<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    $(function(){
    	parent.f_initGrid();
    });
</script>
<style type="text/css" >
    h2{font-size:14px;margin-top:150px;text-align:center;font-weight:normal;}
</style>
</head>
<body>
    <div>
        <h2><img src="/resources/picture/finish.gif" width="40px"/><spring:message code="cust.addingCustomerSuccess"/>!
        </h2>
    </div>
</body>
</html>