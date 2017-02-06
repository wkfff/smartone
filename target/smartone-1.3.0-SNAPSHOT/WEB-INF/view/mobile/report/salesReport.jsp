<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>销售报表</title>
<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<style type="text/css">
    *{padding:0;margin:0;border:0;list-style:none;}
    #main{height:100%;}
    a:link,a:hover{color:#fff;text-decoration:none;}
    h1{font-weight:normal;font-size:50px;color:#fff;background:#5B92C1;height:100px;line-height:100px;padding-left:5px;}
    .content{background-color: #fff;height:95%;}
</style>
</head>
<body>
    <div id="main">
        <h1>销售报表</h1>
        <div class="content">
            <object  width="100%"  style="background-color: #fff;" height="95%" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0">
                <param name="movie" value="/resources/flash/sales_mobile.swf">
                <param name="quality" value="high">
                <param name="play" value="true">
                <param name=“bgColor” value=“#fff″ />
                <embed src="/resources/flash/sales_mobile.swf"  autostart="true" width="100%"  height="95%"  type="application/x-shockwave-flash" style="background: #fff;">
            </object>
        </div>
    </div>
</body>
</html>