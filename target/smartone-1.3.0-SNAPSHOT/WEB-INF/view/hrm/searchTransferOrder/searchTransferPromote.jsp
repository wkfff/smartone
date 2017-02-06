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
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>  
    
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
        
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
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
            checkbox: true,
            columns: [  
                        { display: '', name: 'EXP_INSIDE_NO', width: 10,hide:1},
                        { display: '<spring:message code="hrms.documentNumber"/>', name: 'TRANS_NO', width: 100},
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},  
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 90},  
                        { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_NAME', width: 90}, 
                        { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90}, 
                        { display: '<spring:message code="hrms.effectDate"/>', name: 'START_DATE', width: 90},   
                        { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY', width: 60, render: function (row, index)
                            {     
                                if(row.ACTIVITY == 0){  
                                    return '<img src="/resources/images/a_0.gif" ';
                                }
                                if(row.ACTIVITY == 1){
                                    return '<img src="/resources/images/a_1.gif" >';
                                } 
                                if(row.ACTIVITY == 2){
                                    return '<img src="/resources/images/a_2.gif" >';
                                } 
                            }
                        },
                        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 120,
                            editor: { type: 'textarea', height: 100 }
                        },
                        { display: '<spring:message code="hrms.cancelRemarks"/>', name: 'CANCEL_REMARK', align: 'left', width: 160,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ],
            enabledEdit: true,usePager: true,  rownumbers: true, 
            url: '/hrm/searchTransferOrder/getGeneralDocInfoList',
            parms: [    
                    { name: 'ACTIVITY',value: $("#ACTIVITY").attr('value')},
                    { name: 'TRANS_CODE',value: 'TransCode_130'}
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
             spf_showDetailData(rowdata.EMPID);
            }
        });
    }
    function spf_showDetailData(empID)
    { 
        $dialog = $.ligerDialog.open({isDrag: false, 
            title:'<spring:message code="hrms.histtory"/>', 
            width: 800, 
            height: 400, 
            url: '/hrm/searchTransferOrder/viewEmpHisDetailInfo?EMPID=' + empID
          });
    }
    function spf_search()
    {
        $grid.setOptions({ parms: [ 
                                    { name: 'keyWord', value: $("#keyWord").attr('value')}, 
                                    { name: 'DEPTID', value: $("#DEPTID").attr('value')},
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                                    { name: 'EMP_LIST', value: $("#EMP_LIST").attr('value')},
                                    { name: 'TRANS_CODE',value: 'TransCode_130'},
                                    { name: 'ACTIVITY', value: $("#ACTIVITY").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_delete()
    {   
        var jsonData = '[' ;
        var rows = $grid.getCheckedRows(); 
        
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        } 
       $(rows).each(function (index, row)
             {   
               if(this.CANCEL_REMARK == null || this.CANCEL_REMARK == 'undefined' ){ 
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cancelRemarks"/>'  +". " + '<spring:message code="input.required"/>') ; 
                     return ;  
                 }else{
                     if (jsonData.length > 1){
                            jsonData += ',{' ;
                     }
                     else{
                        jsonData += '{' ;
                     } 
                     jsonData += ' "EXP_INSIDE_NO": "' + this.EXP_INSIDE_NO + '", ' ; 
                     jsonData += ' "CANCEL_REMARK": "' + this.CANCEL_REMARK + '", ' ; 
                     jsonData += ' "rollbackTyep": "normal"' ;
                     jsonData += '}' ;
                 }
           
        }); 
       
        jsonData += ']' ;
          
        if(jsonData.length == 2 || jsonData.length == 3){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        }
       $.ligerDialog.waitting('<spring:message code="hrms.canceling"/>');
       $.post("/hrm/searchTransferOrder/cancelDoc", 
               [    
                    { name: 'jsonData', value: jsonData },
                    { name: 'rollbackTyep', value: 'normal' }
               ]
       , function (result)
       {
        $.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="hrms.cancelSuccess"/>','<spring:message code="hrms.warning"/>', function ()
               {
                    $grid.loadData(true); //加载数据  
               });
           }
           else
           {
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
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
     <div position="center" id='' title=' ' >
     <div position="top">  
            <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
               <tr>
                   <td width="15%" class="l-table-edit-t">
                        <spring:message code="keyWord"/></td>
                   <td width="35%" class="l-table-edit-c">
                        <input name="keyWord" type="text" id="keyWord" size="30"/></td>
                   <td width="15%" class="l-table-edit-t">
                        <spring:message code="hrms.dept"/></td>
                   <td width="35%" class="l-table-edit-c"> 
                        <SipingSoft:deptTree name="DEPTID" limit="hr"/></td>
               </tr> 
                 <tr> 
                   <td  class="l-table-edit-t">
                        <spring:message code="hrms.effectDate"/></td>
                   <td  class="l-table-edit-c">
                         <input type="text" name="S_DATE" id="S_DATE" 
                                             value="" size="30"
                                             onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                                             readonly="readonly"/>  
                           ~                 
                         <input type="text" name="E_DATE" id="E_DATE" 
                                             value="" size="30"
                                             onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                                             readonly="readonly"/> 
                   </td>
                   <td  class="l-table-edit-t">
                        <spring:message code="hrms.batchSearch"/></td>
                   <td  class="l-table-edit-c">
                        <textarea rows="" cols="47" id="EMP_LIST" name="EMP_LIST" ></textarea>
                   </td> 
               </tr>
               <tr> 
                   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                   <td class="l-table-edit-c" colspan="3">
                        <SipingSoft:selectOrderStatus name="ACTIVITY" limit="all" selected="0" onChange="spf_search();"/>
                   </td>
               </tr>
           </table>
           <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
               <tr>
                    <td align="left">  
                        <SipingSoft:button/>
                    </td>
               </tr>  
            </table> 
      </div> 
        <div position="center" id='empInfo'></div>
  </div>
</div>
</body>
</html>
