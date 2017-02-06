<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String sessionId = request.getSession().getId();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>My Uploadify Implementation</title>
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
<link rel="stylesheet" type="text/css" href="/resources/js/uploadify/uploadify.css" />
<script type="text/javascript" src="/resources/js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="/resources/js/uploadify/jquery.uploadify.js?f=<%=System.currentTimeMillis()%>"></script>
<style type="text/css">
#fileQueue {
    background-color: #FFF;
    border-radius: 3px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25);
    height: 120px;
    margin-bottom: 10px;
    overflow: auto;
    padding: 5px 10px;
    width: 450px;
}
.BUTTONA{
    background-image: url("/resources/images/button/button.gif");
    float: right;
    height: 20px;
    margin-left: 10px;
    width: 80px;
    border: 1px solid #A3C0E8;
    color: #2C4D79;
    cursor: pointer;
    display: block;
    font-family: Arial;
    font-size: 12px;
    line-height: 20px;
    overflow: hidden;
    text-align: center;
    text-decoration: none;
    }
.uploadify-button {
        background-color: transparent;
        border: none;
        padding: 0;
    }
.uploadify:hover .uploadify-button {
        background-color: transparent;
    } 
</style>
<script type="text/javascript">
    $(function() {
        if($('#TYPE').val()==='UPLOAD'){
             $('#file_upload').uploadify({
                'auto':false,
                'method':'post',
                'buttonImage' : '/resources/js/img/add.jpg',
                'swf':'<%=basePath%>resources/js/uploadify/uploadify.swf',
                'uploader':'<%=basePath%>doc/docManage/uploadFile;jsessionid=${pageContext.session.id}',
                'queueID':'fileQueue',
                'multi':true,
                'uploadLimit':8,
                'formData':{'TYPE' : $("#TYPE").val(), 'documentNo' : $("#DOC_NO").val() , 'DOC_TYPE_NO' : $("#DOC_TYPE_NO").val(), 'sessionid' : '<%=sessionId%>'},
                'removeCompleted':true,
                'buttonText':'选择文件',
                'onUploadSuccess' : function(file, data, response) {
                     if(data[8] != 0){
                          $("#uploadTip").text(data+"，上传失败！");
                     }
                 }
            });
        }
        if($('#TYPE').val()==='CHECKIN'){
            $('#file_upload').uploadify({
                'auto':false,
                'method':'post',
                'buttonImage' : '/resources/js/img/add.jpg',
                'swf':'<%=basePath%>resources/js/uploadify/uploadify.swf',
                'uploader':'<%=basePath%>doc/docManage/checkInFile;jsessionid=${pageContext.session.id}',
                'queueID':'fileQueue',
                'multi':false,
                'uploadLimit':1,
                'formData':{'TYPE' : $("#TYPE").val(), 'documentNo' : $("#DOC_NO").val() , 'DOC_TYPE_NO' : $("#DOC_TYPE_NO").val(), 'fileNo' : $("#FILE_NO").val(), 'sessionid' : '<%=sessionId%>'},
                'removeCompleted':true,
                'onUploadError' : function(file, errorCode, errorMsg, errorString) {
                    alert("error");
                    alert('The file ' + file.name + ' could not be uploaded: ' + errorString);
                },
                'onUploadSuccess' : function(file, data, response) {
                    if(data[8] != 0){
                        $("#uploadTip").text(data+"，上传失败！");
                    }
                },
                'buttonText':'选择文件'
            });
        }
    });
</script>
</head>
<body>
    <div id="fileQueue"></div>
    <div id="uploadTip" style="color:red;margin-left:12px;"></div>
    <div>
        <input type="hidden" name="TYPE" id="TYPE" value="${type}" />
        <input type="hidden" name="DOC_NO" id="DOC_NO" value="${paraMap.documentNo}" />
        <input type="hidden" name="DOC_TYPE_NO" id="DOC_TYPE_NO" value="${paraMap.DOC_TYPE_NO}" />
        <input type="hidden" name="FILE_NO" id="FILE_NO" value="${paraMap.fileNo}" /> 
        <input  type="file" name="file_upload" id="file_upload" />
        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;"
            href="javascript:$('#file_upload').uploadify('upload', '*')">上传文件</a>
        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;"
            href="javascript:$('#file_upload').uploadify('cancel', '*')">清除列表</a>
        <a class="l-button" style="width:79px; height:20px; float:right; margin-right:10px;"
            href="javascript:parent.spf_file_initGrid();parent.$dialog.close()">关闭页面</a>
    </div>
</body>
</html>