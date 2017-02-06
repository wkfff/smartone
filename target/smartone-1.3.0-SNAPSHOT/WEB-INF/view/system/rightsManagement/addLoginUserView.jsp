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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
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
/*      $deptTree = $("#deptTree").ligerTree({ 
                data:${dataJson},
                method:'POST',
                idFieldName :'deptID',
                  parentIDFieldName :'parentDeptID',
                  textFieldName:'deptName', 
                  topParentIDValue:'${LoginUser.cpnyId}'
        }); */
    });
    function f_save(){
          if($('#LOGIN_TYPE').val()==""){
              $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','请选择类型！');
              return;
          }
          if($('#ADMINID').val()==""){
              $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','请填写编号！');
              return;
          }
          if($('#USERNAME').val()==""){
              $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','请填写账号！');
              return;
          }
          $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
          var options = {
              url:'/system/rightsManagement/addLoginUserInfo',
              type:'POST',
              success:function (result){
                  $.ligerDialog.closeWaitting();
                  if (result == "Y"){
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>',
                        function (){
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
        for (var i = 0; i < notes.length; i++)
        {
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
        jsonData += ']' ;
        $('#jsonData').attr('value' , jsonData) ;
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
        <div style="border: 0px solid #A3C0E8;">
            <div align="left">
                <form name="form1" method="post" action="" id="form1">
                    <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t">类型</td>
                            <td class="l-table-edit-c">
                                <SipingSoft:selectSyCode parentCode="LoginTypeCode" name="LOGIN_TYPE" limit="all"/>
                            </td>
                        </tr>
                        <tr height="35">
                            <td class="l-table-edit-t">编号</td>
                            <td class="l-table-edit-c">
                                <input id="ADMINID" name="ADMINID" type="text" style="height: 25px;" 
                                    title="填写系统中已存在的相应用户的ID"/>
                                <input id="jsonData" name="jsonData" type="hidden" value=""/>
                            </td>
                        </tr>
                        <tr height="35">
                            <td class="l-table-edit-t"><spring:message code="username" /></td>
                            <td class="l-table-edit-c">
                                <input id="USERNAME" name="USERNAME" type="text" style="height: 25px;" 
                                    title="填写用于登录系统的账号"/>
                            </td>
                        </tr>
                    </table>
                </form>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" style="width: 100%">
                    <tr>
                        <td colspan="10" height="30px" style="padding-left: 80%" ><a class="l-button"
                            style="width: 79px; height: 20px; float: left; margin-left: 1px; "
                            onclick="f_save()"><spring:message code="hrms.save" /></a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>