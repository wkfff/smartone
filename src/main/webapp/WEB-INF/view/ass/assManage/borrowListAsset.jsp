<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
var $grid ;
var $AssBrokenSelectList = [];

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
        allowTopResize: false,      //是否允许 头部可以调整大小
        allowBottomResize: false     //是否允许 底部可以调整大小
    });
    spf_initGrid();
    $("#TOOL_TYPE_CODE").ligerComboBox({
        onBeforeOpen: spf_selectTool, width:150
    });
    selectList = getAssBrokenSelectList();
    for(var i=0;i<selectList.length;i++){
        $AssBrokenSelectList.push(selectList[i]);
    }
});
function getAssBrokenSelectList(){
    //请求服务器
    var assBrokenSelectList;
    $.ajax({
        type: 'post',
        url: '/ass/assInfo/getAssBrokenSelectList',
        dataType: 'json',
        async: false,
        success: function (list){
            assBrokenSelectList = list;
        }
    });
    return assBrokenSelectList;
}
function spf_initGrid(){
    $grid = $("#previewTool").ligerGrid({
     checkbox: false,
     columns: [
            { display: '', name: 'TOOL_NO', width: 10,hide: 1},
            { display: '', name: 'ASSET_NO', width: 10,hide: 1},
            { display: '<spring:message code="ass.productName"/>', name: 'ASSET_NAME',width:120,frozen:true},
            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:120,frozen:true},
            { display: '<spring:message code="ess.borrowers"/>', name: 'EMP_NAME',width:120,frozen:true},
            { display: '<spring:message code="hrms.dept"/>', name: 'DEPT_NAME',width:120,frozen:true},
            { display: '<spring:message code="ass.lentTime"/>', name: 'BORROW_DATE',width:120},
            { display: '<spring:message code="ass.returnTime"/>', name: 'RETURN_DATE',width:120},
            { display: '<spring:message code="hrms.reasonToBorrow"/>', name: 'BORROW_REASON',width:160, editor:{ type: 'textarea', height: 100 }},
            { display: '<spring:message code="ess.borrowRemarks"/>', name: 'BORROW_REMARK',width:160, editor:{ type: 'textarea', height: 100 }},
            { display: '<spring:message code="ass.returnStatus"/>', name: 'RETURN_FLAG', width: 70,
                render: function (item)  /*状态0是待确认，1是同意，2是否决，3是已取消，4是已归还*/
                {
                    if(item.RETURN_FLAG == 0 ){
                        return '<p style="color: red;"><spring:message code="ass.unreturned"/></p>';
                    }else if (item.RETURN_FLAG == 1 ){
                        return '<p style="color: green;"><spring:message code="ass.hasReturned"/></p>';
                    }
                }
            },
            { display: '<spring:message code="ass.itemStats"/>', name: 'STATUS_ID', align: 'center',isSort: false, width:130,
                editor: {
                    type: 'select', data: $AssBrokenSelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
                    displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $AssBrokenSelectList.length; i++)
                    {
                        if ($AssBrokenSelectList[i]['STATUS_ID'] == item.STATUS_ID){
                            return $AssBrokenSelectList[i]['STATUS'];
                        }
                    }
                    return item.STATUS;
                }
            },
            {display: '<spring:message code="ass.returnRemarks"/>', name: 'RETURN_REMARK',width:180, editor:{ type: 'textarea', height: 100 }}
       ],
       enabledEdit: true,usePager: true,rownumbers: true,
       url: '/ass/assInfo/getBorrowRecordList',
        width: '99%', height: '99%'
    });
}
function spf_selectTool(){
    $.ligerDialog.open({
        title: '<spring:message code="hrms.assetsList"/>',
        name:'winselector'+Math.random(),
        width: 800, 
        height: 400, 
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
function spf_search(){
    $grid.setOptions({ parms: [
        {name: 'keyWord', value: $("#keyWord").attr('value')},
        { name: 'S_DATE', value: $("#S_DATE").attr('value')},
        { name: 'E_DATE', value: $("#E_DATE").attr('value')},
        { name: 'TOOL_TYPE_CODE', value: $("#TOOL_TYPE_CODE").attr('value')}
        ],
        newPage: 1
    }); //设置数据参数
    $grid.loadData(true); //加载数据
}
function spf_return(){
    var jsonData = '[';
    var rows = $grid.getCheckedRows();
    if (!rows || rows.length == 0) {
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>'); 
        return;
    }
   $(rows).each(function (index, row){
        if(this.RETURN_FLAG != 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.hasbeenreturned"/>!') ; 
                return false;
        }
        if (this.STATUS_ID == null || this.STATUS_ID == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="ass.Pleaseselect"/>！') ;
            return false;
        }else{
            if (jsonData.length > 1){
                jsonData += ',{' ;
            }else{
                jsonData += '{' ;
            }
            jsonData += '"TOOL_NO":"'+this.TOOL_NO+'",';
            jsonData += '"ASSET_NO":"'+this.ASSET_NO+'",';
            jsonData += '"STATUS_ID":"'+this.STATUS_ID+'",';
            jsonData += '"RETURN_REMARK":"'+MyCheckNull(this.RETURN_REMARK)+'"';
            jsonData += '}';
        }
    });
    jsonData += ']';
    var jsonList = eval("(" + jsonData + ")");
    if(jsonData.length == 2){
        return ;
    }
    if(jsonList.length == rows.length){
        $.ligerDialog.confirm('<spring:message code="ass.PleaseselectTip"/>?','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.canceling"/>');
                $.post("/ass/assInfo/assReturnUpdate",
                        [
                            { name: 'jsonData', value: jsonData }
                        ],
                function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="ass.hasReturned"/>！','<spring:message code="hrms.warning"/>', function (){
                            $grid.loadData(true); //加载数据  
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="ass.returnFailure"/>！');
                    }
                });
            }
        });
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
                   <td width="15%" class="l-table-edit-t"><spring:message code="ess.borrowers"/>(<spring:message code="hrms.empid"/>、<spring:message code="hrms.name"/>)</td>
                   <td width="35%" class="l-table-edit-c"><input name="keyWord" type="text" id="keyWord" size="30"/></td>
                   <td width="15%" class="l-table-edit-t" ><spring:message code="hrms.borrowItems"/></td>
                   <td width="35%" class="l-table-edit-c"><input type="text" name="TOOL_TYPE_CODE" id="TOOL_TYPE_CODE" value=""/></td>
               </tr>
               <tr> 
                   <td width="15%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
                   <td class="l-table-edit-c" colspan="3" class="l-table-edit-c">
                         <input type="text" name="S_DATE" id="S_DATE"  value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                                readonly="readonly"/>
                         <input type="text" name="E_DATE" id="E_DATE" value="" size="25"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
                            readonly="readonly"/> 
                   </td>
               </tr>
           </table>
           <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
               <tr>
                    <td align="left">  
                        <SipingSoft:button/>
                        <a class="l-button" id="return_btn" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_return()"><spring:message code="ass.returnProcessing"/></a>
                    </td>
               </tr>
            </table>
    </div>
        <div id="previewTool"></div>
    </div>
</div>
</body>
</html>
