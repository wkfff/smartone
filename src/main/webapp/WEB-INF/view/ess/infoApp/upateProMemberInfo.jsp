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
            topHeight:60,
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
                        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME',width:90,frozen:true},
                        { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                        { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                        { display: '<spring:message code="hrms.projectQuantity"/>', name: 'QUANTITY', width: 120,align: 'right', editor: { type: 'float' },totalSummary:{type: 'sum'}},
                        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/utility/empInfo/getProSearchEmployeeInfo',
            parms: [
                    { name: 'PRO_NO', value: '${paraMap.PRO_NO}'},
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
                                    { name: 'PRO_NO', value: '${paraMap.PRO_NO}'},
                                    { name: 'keyWord', value: $("#keyWord").val()},
                                    { name: 'DEPTID', value: $("#DEPTID").val()},
                                    { name: 'STATUS_CODE', value: $("#STATUS_CODE").val()}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {
         var jsonData = '[' ;
         var rows = $grid.getCheckedRows();
         if (!rows || rows.length == 0) {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                 return false;
         }
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
                     if(this.PRO_NO == "0"){
                         jsonData += ' "__status": "add", ' ;
                     }else{
                         jsonData += ' "__status": "update", ' ;
                     }
                     jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
                     jsonData += ' "PRO_NO": "${paraMap.PRO_NO}", ' ;
                     jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
                     jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
                     jsonData += ' "QUANTITY": "' + MyCheckNull(this.QUANTITY) + '",' ;
                     jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
                     jsonData += '}' ;
                       }
        });

        jsonData += ']' ;

            var jsonList = eval("(" + jsonData + ")");

        if(jsonData.length == 2){
            return ;
        }
        if(jsonList.length == rows.length){
           $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
           $.post("/ess/infoApp/addProMemberInfo",
                   [
                        { name: 'jsonData', value: jsonData }
                   ]
           , function (result)
           {
            $.ligerDialog.closeWaitting();
               if (result == "Y")
               {
                   $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                   {
                        $grid.loadData(true); //加载数据
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
    function spf_checkData()
    {
        var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return false;
        }
        return true;
    }
    function spf_delete()
    {
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){
                 var jsonData = '[' ;
                 var rows = $grid.getCheckedRows();
                 if (!rows || rows.length == 0) {
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                         return false;
                    }
                  $(rows).each(function (index, row)
                        {
                         if (jsonData.length > 1){
                                jsonData += ',{' ;
                             }
                             else{
                                jsonData += '{' ;
                             }
                             jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
                             jsonData += ' "PRO_NO": "${paraMap.PRO_NO}"' ;
                             jsonData += '}' ;
                   });

                jsonData += ']' ;
                var jsonList = eval("(" + jsonData + ")");
                if(jsonData.length == 2){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                     return false;
                }
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/ess/viewApp/delProMemberInfo',
                        [
                            { name: 'jsonData', value: jsonData }
                        ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y")
                    {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            $grid.loadData(true); //加载数据
                            parent.f_ChildWindowClose() ; //加载数据
                        });
                    }
                    else
                    {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
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
           <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                <tr>
                    <td align="left" height="30px;">
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_search()"><spring:message code="search"/></a>
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_save()"><spring:message code="hrms.save"/></a>
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
                    </td>
                </tr>
            </table>
      </div>
        <div position="center" id='empInfo'></div>
  </div>
</body>
</html>
