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
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/function.js" type="text/javascript"></script>
    <script type="text/javascript">
    var $grid = null ;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm)
        {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm)
        {
            return input.val();
        },
        setValue: function (input, value, editParm)
        {
            input.val(value);
        },
        resize: function (input, width, height, editParm)
        {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({
            topHeight:220,
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
         f_initGrid();
    });

    function f_initGrid()
    {
        $grid = $("#empInfo").ligerGrid({
            onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
            },
            checkbox: true,
            columns: [
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:90 ,frozen:true, totalSummary:
                          {
                              type: 'count'
                          }},
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:90,frozen:true},
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:120,frozen:true},
                        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:90,frozen:true},
                        { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                        { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                        { display: '<spring:message code="hrms.projectQuantity"/>', name: 'QUANTITY', width: 120,align: 'right', editor: { type: 'float' },totalSummary:{type: 'sum'}},
                        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/utility/empInfo/getHrSearchEmployeeList',
            parms: [
                    { name: 'keyWord', value: $("#keyWord").val()},
                    { name: 'DEPTID', value: $("#DEPTID").val()},
                    { name: 'STATUS_CODE', value: $("#STATUS_CODE").val()}
                   ],
            width: '99.6%', height: '100%'
        });
    }

    function spf_search()
    {
        $grid.setOptions({ parms: [
                                    { name: 'keyWord', value: $("#keyWord").attr('value')},
                                    { name: 'DEPTID', value: $("#DEPTID").attr('value')},
                                    { name: 'STATUS_CODE', value: $("#STATUS_CODE").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {
    if(spf_checkData()){
             var jsonData = '[' ;
             var rows = $grid.getCheckedRows();
             var quantity = 0;
           $(rows).each(function (index, row)
                 {
                       if(this.START_DATE == null || this.START_DATE == '' || this.START_DATE == 'undefined' ){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'  +". " + '<spring:message code="input.required"/>') ;
                             return false;
                       }
                       if(this.END_DATE == null || this.END_DATE == '' || this.END_DATE == 'undefined' ){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'  +". " + '<spring:message code="input.required"/>') ;
                             return false;
                       }
                       if(this.QUANTITY == null || this.QUANTITY == '' || this.QUANTITY == 'undefined' ){
                            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.projectQuantity"/>'  +". " + '<spring:message code="input.required"/>') ;
                             return false;
                       }else{
                         if (jsonData.length > 1){
                            jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         }
                         quantity = quantity + this.QUANTITY;
                         jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
                         jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
                         jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
                         jsonData += ' "QUANTITY": "' + MyCheckNull(this.QUANTITY) + '", ' ;
                         jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
                         jsonData += '}' ;
                       }
            });
           $("#QUANTITY").val(quantity);
            jsonData += ']' ;
            var jsonList = eval("(" + jsonData + ")");

            if(jsonData.length == 2){
                return ;
            }
            if(jsonList.length == rows.length){
               $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
               $.post("/ess/infoApp/addProInfo",
                       [
                            { name: 'jsonData', value: jsonData },
                            { name: 'PRO_NAME', value: $("#PRO_NAME").val() },
                            { name: 'PRO_EN_NAME', value: $("#PRO_EN_NAME").val() },
                            { name: 'PRO_MODULE', value: '' },
                            { name: 'TYPE_CODE', value: $("#TYPE_CODE").val() },
                            { name: 'START_DATE', value: $("#START_DATE").val() },
                            { name: 'END_DATE', value: $("#END_DATE").val() },
                            { name: 'QUANTITY', value: $("#QUANTITY").val() },
                            { name: 'DESCRIPTION', value: $("#DESCRIPTION").val() },
                            { name: 'REMARK', value: $("#REMARK").val() }
                       ]
               , function (result)
               {
                $.ligerDialog.closeWaitting();
                   if (result == "Y")
                   {
                       $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                       {
                            parent.f_ChildWindowClose() ; //加载数据
                       });
                   }
                   else
                   {
                       $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                   }
               });
            }
        }
    }
    function spf_checkData()
    {
        var proName = $("#PRO_NAME").val();
        var proModule = $("#PRO_MODULE").val();
        var typeCode = $("#TYPE_CODE").val();
        var sDate = $("#START_DATE").val();
        var eDate = $("#END_DATE").val();

        if (typeCode == null || typeCode == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.type"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if (proName == null || proName == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chineseName"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
        }
        if (sDate == null || sDate == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        if (eDate == null || eDate == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
        var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return false;
        }
        return true;
    }
    </script>

    <style type="text/css">
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" >
    <div position="top">
        <table width="100%" border="0" >
            <tr><td height="2"></td></tr>
            <tr>
                <td align="center" valign="middle">
            <form name="form1" method="post" action="" id="form1">
                   <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                        <tr>
                            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="hrms.projectInfo"/>
                            </td>
                            <td width="5%" align="right">&nbsp;</td>
                            <td align="right" height="30px;">
                                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_search()"><spring:message code="search"/></a>
                                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_save()"><spring:message code="hrms.save"/></a>
                            </td>
                        </tr>
                    </table>
                    <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                      <tr>
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="hrms.type"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <SipingSoft:selectSyCode parentCode="projectTypeCode" name="TYPE_CODE" limit="all"/></td>
                           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <input name="PRO_NAME" type="text" id="PRO_NAME" size="30"/>
                           </td>
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="hrms.englishName"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <input name="PRO_EN_NAME" type="text" id="PRO_EN_NAME" size="30"/></td>
                           <%--
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="hrms.module"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <input name="PRO_MODULE" type="text" id="PRO_MODULE" size="30"/></td>
                           --%>
                       </tr>
                       <tr>
                           <td width="10%" class="l-table-edit-t" ><spring:message code="hrms.startDate"/></td>
                           <td width="23%" class="l-table-edit-c" >
                                <input type="text" name="START_DATE" id="START_DATE"
                                                         value=""
                                                         onclick="WdatePicker({maxDate:'#F{$dp.$D(\'END_DATE\')||\'2025-10-01\'}'})"
                                                         size="30" readonly="readonly"/>
                           </td>
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="hrms.endDate"/></td>
                           <td width="23%" class="l-table-edit-c" colspan="3">
                                <input type="text" name="END_DATE" id="END_DATE"
                                                         value=""
                                                         onclick="WdatePicker({minDate:'#F{$dp.$D(\'START_DATE\')}',maxDate:'2025-10-01'})"
                                                         size="30" readonly="readonly"/>
                                <input name="QUANTITY" type="hidden" id="QUANTITY" size="30"
                                    onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" readonly="readonly"/>
                            </td>

                           <%--
                           <td width="10%" class="l-table-edit-t" nowrap="nowrap">
                                <spring:message code="hrms.projectQuantity"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <input name="QUANTITY" type="text" id="QUANTITY" size="30"
                                onkeyup="if(isNaN(value))execCommand('undo')" onafterpaste="if(isNaN(value))execCommand('undo')" readonly="readonly"/></td>
                           --%>
                       </tr>
                       <tr>
                           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.description"/></td>
                           <td width="23%" class="l-table-edit-c" colspan="5">
                                        <textarea rows="" cols="" style="height: 30px; width: 600px"
                                            id="DESCRIPTION" name="DESCRIPTION"></textarea>
                           </td>
                       </tr>
                       <tr>
                           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.remarks"/></td>
                           <td width="23%" class="l-table-edit-c" colspan="5">
                                        <textarea rows="" cols="" style="height: 30px; width: 600px"
                                            id="REMARK" name="REMARK"></textarea>
                           </td>
                       </tr>
                   </table>
                   <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                        <tr>
                            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="search.condition"/>
                            </td>
                            <td width="5%" align="right">&nbsp;</td>
                            <td align="right" height="25px;">
                            &nbsp;
                            </td>
                        </tr>
                    </table>
                    </form>
                   <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.EmpStatus"/></td>
                           <td width="23%" class="l-table-edit-c">
                               <SipingSoft:selectSyCode parentCode="EmpStatus" name="STATUS_CODE" onChange="spf_search();" limit="all"/>
                           </td>
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="keyWord"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <input name="keyWord" type="text" id="keyWord" size="30"/></td>
                           <td width="10%" class="l-table-edit-t">
                                <spring:message code="hrms.dept"/></td>
                           <td width="23%" class="l-table-edit-c">
                                <SipingSoft:deptTree name="DEPTID" limit="hr"/></td>
                       </tr>
                   </table>
                </td>
            </tr>
        </table>
    </div>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
            <spring:message code="hrms.projectMember"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
                &nbsp;
            </td>
        </tr>
    </table>
    <div position="center" id='empInfo'></div>
</div>
</body>
</html>
