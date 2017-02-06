<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $deptTree ;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
                topHeight: 110,
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
            });
        $deptTree = $("#deptTree").ligerTree({ 
                data:${dataJson},
                method:'POST',
                idFieldName :'deptID',
                  parentIDFieldName :'parentDeptID',
                  textFieldName:'deptName', 
                  topParentIDValue:'${LoginUser.cpnyId}'
            });
    });

    function f_save(){
          $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
          if('${loginUserInfo.ACCOUNT_TYPE}'=='EM'){
              getChecked();
          }
          var options = {
              url:'/system/rightsManagement/updateLoginUserInfo',
              type:'POST',
              success:function (result){
              $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            parent.f_ChildWindowClose() ;
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                }
           };
        $('#form1').ajaxSubmit(options); 
    }

    function collapseAll(){
        $deptTree.collapseAll(); 
    }
    function expandAll(){
        $deptTree.expandAll();
    }
    function getChecked(){
        var notes = $deptTree.getChecked();
        var jsonData = '[' ;
        for (var i = 0; i < notes.length; i++){
            if (jsonData.length > 1){
                jsonData += ',{'
            }
            else{
                jsonData += '{'
            }
            jsonData += ' "ADMIN_DEPTID": "' + notes[i].data.deptID + '", ' ;
            jsonData += ' "ADMIN_NO": ' + '${loginUserInfo.ADMINNO}' ;
            jsonData += '}' ;
        }
        jsonData += ']';
        $('#jsonData').attr('value' , jsonData);
    }
</script>

<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div style="border: 1px solid #A3C0E8;">
            <div align="left">
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" cellpadding="0" cellspacing="0"
                        class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t" width="10%">类型</td>
                            <td class="l-table-edit-c" width="10%">${loginUserInfo.TYPE_NAME}
                            </td>
                            <td class="l-table-edit-t" width="10%">编号</td>
                            <td class="l-table-edit-c" width="15%">${loginUserInfo.ADMINID}
                                <input id="ADMINNO" name="ADMINNO" type="hidden" value="${loginUserInfo.ADMINNO}"/>
                                <input id="jsonData" name="jsonData" type="hidden" value=""/>
                            </td>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.active" /></td>
                            <td class="l-table-edit-c" width="10%"><SipingSoft:selectStatus
                                    name="ACTIVITY" selected="${loginUserInfo.STATUS_ID}" /></td>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.company" /></td>
                            <td class="l-table-edit-c" width="25%">${loginUserInfo.CPNY_NAME}</td>
                        </tr>
                        <tr>
                            <td class="l-table-edit-t" width="10%"><spring:message code="hrms.role" /></td>
                            <td class="l-table-edit-c" colspan="7" height="60" id='checkBoxTd' width="90%">
                                <c:forEach items="${loginUserInfoRolesGroupList}" var="rolesGroup">
                                    <input type="checkbox" name="SCREEN_GRANT_ID"
                                        value="${rolesGroup.SCREEN_GRANT_ID}"
                                        <c:if test="${ rolesGroup.CHECKED == 1}">checked=true</c:if> />
                                            ${rolesGroup.SCREEN_GRANT_NAME}&nbsp;&nbsp;&nbsp;&nbsp;
                                </c:forEach>
                            </td>
                        </tr>
                    </table>
                </form>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" width="100%">
                        <tr>
                            <td colspan="10" height="30px" style="padding-left: 65%">
                                <c:if test="${loginUserInfo.ACCOUNT_TYPE=='EM'}">
                                    <a class="l-button" onclick="collapseAll()" style="width: 79px; height: 20px; float: right; 
                                        margin-left: 10px; ">
                                        <spring:message code="hrms.collapse" /></a> 
                                    <a class="l-button" onclick="expandAll()" style="width: 79px; height: 20px; float: right; 
                                        margin-left: 10px; ">
                                        <spring:message code="hrms.expand" />
                                    </a>
                                </c:if>
                                <a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 1px; 
                                    "
                                    onclick="f_save()"><spring:message code="hrms.save" />
                                </a>
                            </td>
                        </tr>
                </table>
            </div>
            <c:if test="${loginUserInfo.ACCOUNT_TYPE=='EM'}">
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr>
                    <td width="85px" class="l-table-edit-t">
                        <div position="center" id="dept"
                            style="width: 600px; height: 300px; float: left; border: 0px solid #A3C0E8; overflow: auto;">
                            <table width="100%" cellpadding="0" cellspacing="0"
                                class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                                <tr>
                                    <td width="85px" class="l-table-edit-t"><spring:message code="hrms.dept" /></td>
                                    <td class="l-table-edit-c">
                                        <ul id="deptTree"></ul>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                </table>
            </c:if>
        </div>
    </div>
</body>
</html>