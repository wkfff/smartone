<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" >
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript">
    var first=true;
    $(function ()
            {
                //布局
                $("#layout1").ligerLayout({
                    topHeight: 220,
                    allowLeftResize: false,      //是否允许 左边可以调整大小
                    allowRightResize: false,     //是否允许 右边可以调整大小
                    allowTopResize: false,       //是否允许 头部可以调整大小
                    allowBottomResize: false     //是否允许 底部可以调整大小
                });
                 spf_getProTypeInfo();
            });

    function spf_getProInfo(){
          var TYPE_CODE = document.getElementById("TYPE_CODE");
          if(TYPE_CODE.options[TYPE_CODE.selectedIndex].value == "") return;
          var typeCode = TYPE_CODE.options[TYPE_CODE.selectedIndex].value;

         //&callback=?"注意这个是为了解决跨域访问的问题
         $.post('/utility/otherInfo/getProInfo',{"TYPE_CODE": typeCode, "WORK_DATE": $("#START_DATE").val()},function(result){
                    spf_setProInfo(result);
                }
            );
    }
    function spf_getProTypeInfo(){
         //&callback=?"注意这个是为了解决跨域访问的问题
         $.post('/utility/otherInfo/getProTypeInfo',{"EMPID": '', "WORK_DATE": $("#START_DATE").val()},function(result){
             spf_setProTypeInfo(result);
                }
            );
    }
    //设置下拉列表
    function spf_setProInfo(result){
        clearSel(document.getElementById("PRO_NO")); //清空
        var PRO_NO = document.getElementById("PRO_NO");
        var jsonList = eval("(" + result + ")");
        var option = new Option('<spring:message code="hrms.selection"/>',"");
        PRO_NO.options.add(option);
        for(var i=0;i<jsonList.length;i++){
        var value = "0";var text = "0";
        for(var key in jsonList[i]){
             if(key == "ID")
                 value = jsonList[i][key];
             if(key == "Name")
                 text = jsonList[i][key];
            }
            option = new Option(text,value);
            PRO_NO.options.add(option);
          }
        if(first&&$('#type').val()=='update'){
            $('#PRO_NO').attr('value','${paraMap.PRO_NO}');
            first=false;
        }
    }
    function spf_setProTypeInfo(result){
        var index = "0";
        var typeCode = "";
        clearSel(document.getElementById("TYPE_CODE")); //清空
        var TYPE_CODE = document.getElementById("TYPE_CODE");

        var jsonList = eval("(" + result + ")");

        var option = new Option('<spring:message code="hrms.selection"/>',"");
        TYPE_CODE.options.add(option);
        for(var i=0;i<jsonList.length;i++){
            var value = "0";var text = "0";
            for(var key in jsonList[i]){
                if(key == "ID")
                    value = jsonList[i][key];
                if(key == "Name")
                            text = jsonList[i][key];
                }
            option = new Option(text,value);
            TYPE_CODE.options.add(option);
          }
        if($('#type').val()=='update'){
            $('#TYPE_CODE').attr('value','${paraMap.TYPE_CODE}');
        }
        spf_getProInfo();
    }
    function dateChanged(){
        clearSel(document.getElementById("PRO_NO")); //清空
        $("#TYPE_CODE").val(""); //清空
    }
    // 清空下拉列表
    function clearSel(oSelect){
        while(oSelect.childNodes.length>0){
            oSelect.removeChild(oSelect.childNodes[0]);
        }
    }
    /*提交申请*/
    function spf_application()
    {
    $.ligerDialog.confirm('您确定要提交报工吗？','<spring:message code="hrms.warning"/>',
        function (yes){
        if(yes){
            if(spf_checkData()){
                 $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                 $.post("/ess/infoApp/transferWorkingHoursInfo",
                         [
                            { name: 'type', value: $("#type").val()},
                            { name: 'WH_NO', value: $("#WH_NO").val()},
                            { name: 'PRO_NO', value: $("#PRO_NO").val()},
                            { name: 'START_DATE', value: $("#START_DATE").val()},
                            { name: 'WORK_HOUR', value: $("#WORK_HOUR").val()},
                            { name: 'WORK_CONTENT', value: $("#WORK_CONTENT").val()},
                            { name: 'REMARK', value: $("#REMARK").val()}
                          ]
                 , function (result)
                 {
                    $.ligerDialog.closeWaitting();
                     if (result == "Y")
                     {
                         $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                         {
                             parent.spf_afterAddOrRemove();
                         });
                     }
                     else
                     {
                         $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '保存报工失败！原因：'+result);
                     }
                 });
            }
        }});
    }

    function spf_checkData()
    {
        //return true;
        if ($("#TYPE_CODE").val() == null || $("#TYPE_CODE").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '项目类型'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        if ($("#PRO_NO").val() == null || $("#PRO_NO").val() == ""||$("#PRO_QUANTITY").val() == "0") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '项目名称'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#START_DATE").val() == null || $("#START_DATE").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '报工日期'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#WORK_HOUR").val() == null || $("#WORK_HOUR").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '工作时间'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#WORK_CONTENT").val() == null || $("#WORK_CONTENT").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '工作内容'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if ($("#REMARK").val() == null) {
            $("#REMARK").val()=='';
        }
        return true;
    }
    </script>
<style type="text/css">
   body{ padding:5px; margin:0; padding-bottom:15px;}
   #layout1{  width:99.8%;margin:0; padding:0;  }
</style>
</head>
<body>
<div id="layout1" >
     <div position="top">
        <input type="hidden" id="type" name="type" value="${type}" />
        <input type="hidden" id="WH_NO" name="WH_NO" value="${paraMap.WH_NO}" />
        <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                <td width="25%" align="left" style="font-weight: bold;">报工申请
                </td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;">
                <a class="l-button" style="width:79px; height:20px; font-weight: bold;float:right; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_application()"><spring:message code="hrms.application"/></a>
                </td>
            </tr>
        </table>
        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
               <td class="l-table-edit-t" width="20%"><spring:message code="hrms.attItemName"/><font color="red">*</font></td>
               <td class="l-table-edit-c" colspan="3">
                    <select name="TYPE_CODE" id="TYPE_CODE" onchange="spf_getProInfo();"></select>
                    <select name="PRO_NO" id="PRO_NO" ></select>
               </td>
           </tr>
           <tr>
                <td class="l-table-edit-t" width="20%">报工日期<font color="red">*</font></td>
                <td class="l-table-edit-c" width="30%">
                    <input type="text" name="START_DATE" id="START_DATE"
                                     value="${paraMap.DDATE}${paraMap.START_DATE}"
                                     onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                                     validate="{required:true}"
                                     onchange="dateChanged()"/>
                </td>
                <td class="l-table-edit-t" width="20%">工作时间<font color="red">*</font></td>
                <td class="l-table-edit-c" width="30%">
                    <select value="${paraMap.WORK_HOUR}" id="WORK_HOUR">
                        <option value="8" <c:if test="${paraMap.WORK_HOUR=='8'}">selected="true"</c:if>>全天（8小时）</option>
                        <option value="4" <c:if test="${paraMap.WORK_HOUR=='4'}">selected="true"</c:if>>半天（4小时）</option>
                    </select>
                </td>
           </tr>
            <tr>
                <td class="l-table-edit-t">工作内容<font color="red">*</font></td>
                <td class="l-table-edit-c" colspan="3">
                    <textarea rows="" cols="" style="width:500px; height:50px" id="WORK_CONTENT" name="WORK_CONTENT" >${paraMap.WORK_CONTENT}</textarea>
                </td>
           </tr>
           <tr>
                <td class="l-table-edit-t">备注</td>
                <td class="l-table-edit-c" colspan="3">
                    <textarea rows="" cols="" style="width:500px; height:50px" id="REMARK" name="REMARK" >${paraMap.REMARK}</textarea>
                </td>
           </tr>
       </table>
      </div>
  </div>
</body>
</html>