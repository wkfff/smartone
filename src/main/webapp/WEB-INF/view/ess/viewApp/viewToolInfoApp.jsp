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
    var $returnTypeSelectList ;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm){
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm){
            return input.val();
        },
        setValue: function (input, value, editParm){
            input.val(value);
        },
        resize: function (input, width, height, editParm){
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    $(function (){
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
        $returnTypeSelectList = getReturnTypeSelectList();
         f_initGrid();
         $("#TOOL_TYPE_CODE").ligerComboBox({
            onBeforeOpen: spf_selectTool, width:150
        });
    });
 
    function f_initGrid(){
        $grid = $("#toolInfo").ligerGrid({
            checkbox: true,
            columns: [
                        { display: '', name: 'TOOL_NO', width: 10,hide: 1},
                        { display: '', name: 'PROCESSID', width: 10,hide:1},
                        { display: '<spring:message code="ess.borrowers"/>', name: 'EMPNAME', width: 90},
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
                        { display: '<spring:message code="hrms.borrowItems"/>', name: 'ASSET_NAME', width: 90},
                        { display: '<spring:message code="hrms.borrowingDate"/>', name: 'BORROW_DATE', width: 140},
                        { display: '<spring:message code="hrms.expectedReturnDate"/>', name: 'RETURN_DATE', width: 140},
                        { display: '<spring:message code="hrms.reasonToBorrow"/>', name: 'TOOL_CONTENT', width: 220, editor:{ type: 'textarea', height: 100 }},
                        { display: '<spring:message code="ess.borrowRemarks"/>', name: 'TOOL_REMARK', width: 220, editor:{ type: 'textarea', height: 100 }},
                        { display: '<spring:message code="hrms.approvalActive"/>', name: 'AFFIRM_FLAG', width: 90,
                            render: function (item)  /*状态0是待确认，1是同意，2是否决，3是已取消，4是已归还*/
                            {
                                if(item.AFFIRM_FLAG == 0 ){
                                    return '<p style="color: purple;"><spring:message code="ess.unaudited"/></p>';
                                }else if (item.AFFIRM_FLAG == 1 ){
                                    return '<p style="color: green;"><spring:message code="ess.hasaPassed"/></p>';
                                }else if (item.AFFIRM_FLAG == 2 ){
                                    return '<p style="color: red;"><spring:message code="ess.rejected"/></p>';
                                }else{
                                    return '<p style="color: gray;"><spring:message code="ess.unknownState"/></p>';
                                }
                            }
                        }
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ess/viewApp/getToolInfo',
            parms: [
                    { name: 'qryType', value: $("select[name='qryType']").attr('value')} 
                   ],
            width: '99.6%', height: '100%'
        });
    }
    //获取Return_Type_Code列表
    function getReturnTypeSelectList(){
        var ReturnTypeSelectList ;
          $.ajax({
              type: 'post',
              url: '/utility/otherInfo/getReturnTypeSelectList',
              dataType: 'json',
              async: false,
              success: function (list){
                  ReturnTypeSelectList = list;
              }
         });
          return ReturnTypeSelectList;
      }
    function spf_showDetailData(applyNo){
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.approvalActive"/>',
            width: 700,
            height: 320,
            url: '/ess/viewApp/viewApproverInfo?PAGE=B&FLAG=0&APPLY_TYPE=OtApply&APPLY_NO='+applyNo
          });
    }
    function spf_search(){
        //alert($("#TOOL_TYPE_CODE").attr('value'));
        $grid.setOptions({ parms: [
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                                    { name: 'ASSET_ID', value: $("#TOOL_TYPE_CODE").attr('value')},
                                    { name: 'qryType', value: $("select[name='qryType']").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function spf_delete(){
        var jsonData = '[';
        var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
            return;
        }
       $(rows).each(function (index, row){
            if(this.AFFIRM_FLAG != 0){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotCancel"/>') ; 
                    return false;
            }else{
                if (jsonData.length > 1){
                    jsonData += ',{' ;
                }else{
                    jsonData += '{' ;
                }
                jsonData += '"APPLY_NO":"'+this.TOOL_NO+'",';
                jsonData += '"PROCESSID":"'+this.PROCESSID+'",';
                jsonData += '"APPLY_TYPE":"ToolApply",';
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
            $.ligerDialog.confirm('<spring:message code="ess.areYouSureYouWantToDeleteTheClauseToApply"/>?','<spring:message code="hrms.warning"/>', function (yes){
                if(yes){
                    $.ligerDialog.waitting('<spring:message code="hrms.canceling"/>');
                    $.post("/ess/viewApp/cancelApp",
                            [
                                { name: 'jsonData', value: jsonData },
                                { name: 'appType', value: 'ToolInfo'}
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
    function spf_selectTool(){
        $.ligerDialog.open({
            title: '<spring:message code="hrms.assetsList"/>',
            name:'winselector'+Math.random(),
            width: 700, 
            height: 450, 
            url: '/utility/toolInfo/searchTool',
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                    ]
        });
        return false;
    }
    function spf_selectOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return ;
        }
        $("#TOOL_TYPE_CODE").val(data.ASSET_NAME);
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#TOOL_TYPE_CODE").val("");
        dialog.close();
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
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.borrowItems"/></td>
                    <!--    <td class="l-table-edit-c" nowrap="nowrap"><SipingSoft:selectAssetID
                                name="ASSET_ID" onChange="spf_search();" limit="all" /></td>     -->
                        <td class="l-table-edit-c"><input type="text" name="TOOL_TYPE_CODE" id="TOOL_TYPE_CODE" value=""/></td>
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.approvalActive" /></td>
                        <td class="l-table-edit-c" nowrap="nowrap"><SipingSoft:selectAppStatus 
                                name="qryType" limit="all" onChange="spf_search();" /></td>
                        <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="hrms.borrowingDate"/></td>
                        <td class="l-table-edit-c" colspan="3" nowrap="nowrap"><input
                            type="text" name="S_DATE" id="S_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id='toolInfo'></div>
        </div>
    </div>
</body>
</html>
