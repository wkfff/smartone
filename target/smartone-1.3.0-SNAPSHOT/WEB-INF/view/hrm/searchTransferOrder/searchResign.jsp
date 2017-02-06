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
 
    function f_initGrid(){
        $grid = $("#empInfo").ligerGrid({
            checkbox: true,
            columns: [
                        { display: '', name: 'RESIGN_NO', width: 10,hide:1},
                        { display: '', name: 'PROCESSID', width: 10,hide:1},
                        { display: '<spring:message code="hrms.documentNumber"/>', name: 'TRANS_NO', width: 120,hide:1},
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90 ,frozen:true},
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90 ,frozen:true},  
                        { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120},  
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120}, 
                        { display: '<spring:message code="hrms.leftType"/>', name: 'RESIGN_TYPE_NAME', width: 120},
                        { display: '<spring:message code="hrms.leftReason"/>', name: 'RESIGN_REASON', width: 160,
                            editor: { type: 'textarea', height: 100 }
                        },    
                        { display: '<spring:message code="hrms.leftDate"/>', name: 'RESIGN_DATE', width: 120}, 
                        { display: '<spring:message code="hrms.active"/>', name: 'EXECUTED', width: 60, render: function (row, index)
                            {
                                if(row.EXECUTED == 0){  
                                    return '<p style="color: purple;">未生效</p>';
                                }
                                if(row.EXECUTED == 1){
                                    return '<p style="color: green;">已生效</p>';
                                }
                            }
                        },
                        { display: '<spring:message code="hrms.approvalActive"/>', name: 'AFFIRM_FLAG', width: 60, render: function (row, index)
                            {     
                                if(row.AFFIRM_FLAG == 0){
                                    return '<p style="color: purple;">未审核</p>';
                                }
                                if(row.AFFIRM_FLAG == 1){
                                    return '<p style="color: green;">已通过</p>';
                                } 
                                if(row.AFFIRM_FLAG == 2){
                                    return '<p style="color: red;">已否决</p>';
                                }
                            }
                        },
                        { display: '<spring:message code="hrms.cancelRemarks"/>', name: 'CANCEL_REMARK', align: 'left', width: 160,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ],
            enabledEdit: true,usePager: true,rownumbers: true, 
            url: '/hrm/searchTransferOrder/getResignInfoList',
            parms: [
                    { name: 'TRANS_CODE',value: 'TransCode_200'},
                    { name: 'LEFT_DATE',value: 'LEFT_DATE'}
                   ],
            width: '99.6%', height: '100%'
        });
    }
//    function spf_showDetailData(empID)
//    { 
//      $dialog = $.ligerDialog.open({isDrag: false, 
//          title:'<spring:message code="hrms.histtory"/>', 
//          width: 800, 
//          height: 400, 
//          url: '/hrm/searchTransferOrder/viewEmpHisDetailInfo?EMPID=' + empID
//            });
//    }
    function spf_search(){
        $grid.setOptions({ parms: [
                                    { name: 'keyWord', value: $("#keyWord").attr('value')}, 
                                    { name: 'DEPTID', value: $("#DEPTID").attr('value')},
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                                    { name: 'RESIGN_TYPE_CODE', value: $("#RESIGN_TYPE_CODE").attr('value')},
                                    { name: 'TRANS_CODE',value: '${TRANS_CODE}'},
                                    { name: 'LEFT_DATE',value: 'LEFT_DATE'},
                                    { name: 'EXECUTED', value: $("#EXECUTED").attr('value')},
                                    { name: 'AFFIRM_FLAG', value: $("#AFFIRM_FLAG").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_delete(){
        var jsonData = '[';
        var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return;
        }
       $(rows).each(function (index, row){
            if(this.AFFIRM_FLAG != 0){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotCancel"/>') ; 
                return false;
            }
           if(this.CANCEL_REMARK == null || this.CANCEL_REMARK == 'undefined' ){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cancelRemarks"/>'  +". " + '<spring:message code="input.required"/>') ; 
                     return ;
            }else{
                if (jsonData.length > 1){
                    jsonData += ',{';
                 }else{
                        jsonData += '{';
                     }
                     jsonData += '"RESIGN_NO":"'+this.RESIGN_NO+'",';
                     jsonData += '"PROCESSID":"'+this.PROCESSID+'",';
                     jsonData += '"CANCEL_REMARK":"'+this.CANCEL_REMARK+'",';
                     jsonData += '"rollbackType":"Resign"';
                     jsonData += '}';
                }
        });
        jsonData += ']';
        if(jsonData.length == 2){
//          $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return;
       }
        $.ligerDialog.confirm('您确定要删除该条申请?','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                   $.post("/hrm/searchTransferOrder/cancelDoc", 
                           [
                                { name: 'jsonData', value: jsonData },
                                { name: 'rollbackType', value: 'Resign' }
                           ],
                   function (result){
                    $.ligerDialog.closeWaitting();
                       if (result == "Y"){
                           $.ligerDialog.success('<spring:message code="hrms.cancelSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                           {
                                $grid.loadData(true);//加载数据  
                           });
                       }else{
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cancelFailed"/>');
                       }
                   });
            }
        });
    }
  //将某个月份的职员离职信息导出
    function spf_insExcel(colums){
        var s_date = $("#S_DATE").val();
        var e_date = $("#E_DATE").val();
        var transCode = '${TRANS_CODE}';
        var executed = 1;
        
        if (s_date == '' || e_date == '') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请在"开始日期"选择正确的起止时间');
            return ;
        }
        var attMonth = getformatdate(s_date);
        location.href='/hrm/transferOrder/getResignInfoByExcel?PA_MONTH=' + attMonth+'&S_DATE='
                +s_date+'&E_DATE='+e_date+'&TRANS_CODE='+transCode+'&LEFT_DATE=LEFT_DATE';
        var manager = $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
        
    }
    //传入日期类型数据获得年和月 
    function getformatdate(date){ 
        var formate_datetime; 
        var array = date.split("-"); 
        var year = array[0]; 
        var month = array[1];  
        formate_datetime = array[0] + "年" + removeZero(array[1]) + "月"; 
        return formate_datetime; 
    } 
    //去掉月、日、时、分前的0 
    function removeZero(data) { 
        if(data.charAt(0) == "0"){ 
            return data.charAt(1); 
        } 
        else { 
            return data; 
        } 
    }
</script>
<style type="text/css"> 
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding:0px" >
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
                    <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.approvalActive" /></td>
                    <td class="l-table-edit-c" nowrap="nowrap" ><SipingSoft:selectAppStatus name="AFFIRM_FLAG" 
                        limit="all" onChange="spf_search();" /></td>
                    <td class="l-table-edit-t"><spring:message code="hrms.leftType"/></td>
                    <td class="l-table-edit-c">
                        <SipingSoft:selectSyCode parentCode="ResignTypeCode" name="RESIGN_TYPE_CODE" limit="all" onChange="spf_search();"/>
                   </td>
               </tr>
                 <tr> 
                   <td  class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
                   <td  class="l-table-edit-c">
                         <input type="text" name="S_DATE" id="S_DATE"  value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                                readonly="readonly"/>   ~
                         <input type="text" name="E_DATE" id="E_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                            readonly="readonly"/> 
                   </td>
                   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                   <td class="l-table-edit-c"><SipingSoft:selectOrderStatus name="EXECUTED" limit="all" 
                        selected="" onChange="spf_search();"/></td>
               </tr>
           </table>
           <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
               <tr>
                    <td align="left">  
                        <SipingSoft:button/>
                        <!-- <a class="l-button"
                            id="btn"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_insExcel()">Excel导出</a>  -->
                    </td>
               </tr>
            </table>
    </div>
        <div position="center" id='empInfo'></div>
  </div>
</div>
</body>
</html>
