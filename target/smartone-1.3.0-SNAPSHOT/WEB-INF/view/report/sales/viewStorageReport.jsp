<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
cross-domain-policy SYSTEM "http://www.adobe.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
    <site-control permitted-cross-domain-policies="master-only"/>
    <allow-access-from domain="http://192.168.10.101/*"/>
    <allow-http-request-headers-from domain="*.adobe.com" headers="SOAPAction"/>
</cross-domain-policy>
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<style type="text/css">
body,p{
    padding: 0;
    margin: 0;
}
.salesReport p{padding:0;margin:0;}
</style>
</head>
<body>
    <div class="salesReport">
        <p>
            <object  height="650px" width="100%" border="0" >
                <param name="movie" value="/resources/flash/storage.swf">
                <embed src="/resources/flash/storage.swf"  height="650px"  width="100%" autoplay="true"  align="middle" >
            </object>
        </p>
    </div>
</body>
</html>