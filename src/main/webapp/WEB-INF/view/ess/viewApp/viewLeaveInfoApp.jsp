<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
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
<script src="/resources/js/ligerUI/js/core/base.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
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
            checkbox:true,
            columns: [
                        { display: '', name: 'APPLY_NO', width: 10,hide: 1},
                        { display: '', name: 'PROCESSID', width: 10,hide:1},
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},  
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 90},
                        { display: '<spring:message code="hrms.empTypeName"/>', name: 'EMP_TYPE_NAME', width: 90},
                        { display: '<spring:message code="hrms.ApplyDate"/>', name: 'CREATE_DATE', width: 120},
                        { display: '<spring:message code="hrms.leaveType"/>', name: 'LEAVE_TYPE_NAME', width: 60},
                        { display: '<spring:message code="hrms.startedTime"/>', name: 'LEAVE_FROM_TIME', width: 110},
                        { display: '<spring:message code="hrms.endTime"/>', name: 'LEAVE_TO_TIME', width: 110},
                        { display: '<spring:message code="hrms.leaveReason"/>', name: 'LEAVE_REASON', align: 'left', width: 230,
                            editor: { type: 'textarea', height: 100 }
                        },
                        { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 90}
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ess/viewApp/getLeaveInfo',
            parms: [
                    { name: 'qryType',value: $("select[name='qryType']").attr('value')}
                   ],
            width: '99.6%', height: '100%'
//            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
//                  spf_showDetailData(rowdata.APPLY_NO);
//            }
        });
    }
    function spf_showDetailData(applyNo){
        $dialog = $.ligerDialog.open({isDrag: false, 
            title:'<spring:message code="hrms.approvalActive"/>', 
            width: 700, 
            height: 300, 
            url: '/ess/viewApp/viewApproverInfo?PAGE=B&FLAG=0&APPLY_TYPE=LeaveApply&APPLY_NO='+applyNo
          });
    }
    //搜索
    function spf_search(){
        $grid.setOptions({ parms: [
            { name: 'S_DATE', value: $("#S_DATE").attr('value')},
            { name: 'E_DATE', value: $("#E_DATE").attr('value')}, 
            { name: 'LEAVE_TYPE_CODE', value: $("#LEAVE_TYPE_CODE").attr('value')}, 
            { name: 'qryType', value: $("select[name='qryType']").attr('value')}
        ],
        newPage: 1
        }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    //删除
    function spf_delete(){
        var jsonData = '[';
        var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
            return;
        }
       $(rows).each(function (index, row){
            var notConfirm = '<p style="color: purple;">未审核</p>';//此字符串不能做任何更改，多一个或少一个空格都不行
            if(this.APP_STATUS != notConfirm){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotCancel"/>') ; 
                    return false;
            }else{
                if (jsonData.length > 1){
                    jsonData += ',{' ;
                }else{
                    jsonData += '{' ;
                } 
                jsonData += '"APPLY_NO":"'+this.APPLY_NO+'",';
                jsonData += '"PROCESSID":"'+this.PROCESSID+'",';
                jsonData += '"APPLY_TYPE":"LeaveApply",';
                jsonData += '"EMPID":"'+this.EMPID+'"';
                jsonData += '}';
            }
        });
        jsonData += ']';
        var jsonList = eval("(" + jsonData + ")");
        if(jsonData.length == 2){
            return ;
        }
        if(jsonList.length == rows.length){
            $.ligerDialog.confirm('您确定要删除该条申请?','<spring:message code="hrms.warning"/>', function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.canceling"/>');
                    $.post("/ess/viewApp/cancelApp", 
                            [
                                { name: 'jsonData', value: jsonData },
                                { name: 'appType', value: 'LeaveInfo' }
                            ],
                    function (result){
                        $.ligerDialog.closeWaitting();
                        if (result == "Y"){
                            $.ligerDialog.success('<spring:message code="hrms.cancelSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                $grid.loadData(true); //加载数据  
                            });
                        }else{
                            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.cancelFailed"/>');
                        }
                    });
                }
            });
        }
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
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message
                                code="hrms.leaveType" /></td>
                        <td class="l-table-edit-c" colspan="3" nowrap="nowrap"><SipingSoft:selectSyCode
                                parentCode="LeaveTypeCode" name="LEAVE_TYPE_CODE"
                                onChange="spf_search();" limit="all" /></td>
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.approvalActive" /></td>
                        <td class="l-table-edit-c" nowrap="nowrap" ><SipingSoft:selectAppStatus 
                                name="qryType" limit="all" onChange="spf_search();" /></td>
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.leaveDate" /></td>
                        <td class="l-table-edit-c" nowrap="nowrap"><input type="text"
                            name="S_DATE" id="S_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='empInfo'></div>
        </div>
    </div>
</body>
</html>