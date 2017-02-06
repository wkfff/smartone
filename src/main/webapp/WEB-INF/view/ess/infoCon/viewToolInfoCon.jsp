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
        $returnTypeSelectList = getReturnTypeSelectList();
         f_initGrid(); 
    });
 
    function f_initGrid()
    {
        $grid = $("#empInfo").ligerGrid({
            //checkbox: true,           
            columns: [   
                        { display: '', name: 'TOOL_NO', width: 10,hide: 1},
                        { display: '借用物品', name: 'ASSET_NAME', width: 90},
                        { display: '借用时间', name: 'START_DATE', width: 140},  
                        { display: '(预计)归还时间', name: 'RETURN_DATE', width: 140},  
                        { display: '借用人', name: 'PERSON_NAME', width: 90},  
                        { display: '工号', name: 'EMPID', width: 90},  
                        { display: '借用缘由', name: 'TOOL_CONTENT', width: 120},  
                        { display: '借用备注', name: 'TOOL_REMARK', width: 120}, 
                        { display: '<spring:message code="hrms.confirmationActive"/>', name: 'STATUS', width: 90,
                            render: function (item)  /*状态0是待确认，1是同意，2是否决，3是已取消，4是已归还*/
                            { 
                                if(item.ACTIVITY == 0 ){  
                                    return '未确认';
                                }else if (item.ACTIVITY == 1 ){
                                    return '已确认';
                                }else if (item.ACTIVITY == 2 ){
                                    return '已否决';
                                }else if (item.ACTIVITY == 3 ){
                                    return '已取消';
                                }else if (item.ACTIVITY == 4 ){
                                    return '已归还';
                                }else{
                                    return item.ACTIVITY;
                                }
                            } 
                        }, 
                        { display: '执行操作', name: 'FUNCTION', width: 90,
                            render: function (item)  /*状态0是待确认，1是同意，2是否决，3是已取消，4是已归还*/
                            //'<img style="cursor: pointer;" src="/resources/images/delete.gif" onclick="spf_delete();" >'
                            { 
                                if(item.ACTIVITY == 0 ){  
                                    return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="spf_reject(2,4,'+item.TOOL_NO+');">' + '&nbsp;&nbsp;&nbsp;' 
                                         + '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="spf_approve(1,4,'+item.TOOL_NO+')">';
                                }else if (item.ACTIVITY == 1 ){
                                    return '<img style="cursor: pointer;" src="/resources/images/4.gif" onclick="spf_return(4,4,'+item.TOOL_NO+')">';
                                }else if (item.ACTIVITY == 2 ){
                                    return ;
                                }else if (item.ACTIVITY == 3 ){
                                    return ;
                                }else if (item.ACTIVITY == 4 ){
                                    return ;
                                }else{
                                    return item.ACTIVITY;
                                }
                            } 
                        },   
                        { display: '确认/否决备注', name: 'CON_REMARK', align: 'left', width: 90,
                            editor: { type: 'textarea', height: 90 }
                        },
                        { display: '取消备注', name: 'CANCEL_REMARK', align: 'left', width: 90,
                            editor: { type: 'textarea', height: 90 }
                        },
                        { display: '归还状态', name: 'RETURN_TYPE_CODE', align: 'left', width: 90,
                            editor: { 
                                type: 'select', data: $returnTypeSelectList, dataValueField: 'RETURN_TYPE_CODE',dataDisplayField: 'RETURN_TYPE_NAME', 
                                displayColumnName: 'RETURN_TYPE_NAME', valueColumnName: 'RETURN_TYPE_CODE'
                            }, render: function (item)
                            {
                                for (var i = 0; i < $returnTypeSelectList.length; i++)
                                {
                                    if ($returnTypeSelectList[i]['RETURN_TYPE_CODE'] == item.RETURN_TYPE_CODE)
                                        return $returnTypeSelectList[i]['RETURN_TYPE_NAME']
                                }
                                return item.RETURN_TYPE_NAME;
                            }
                        },
                        { display: '归还备注', name: 'RETURN_REMARK', align: 'left', width: 90,
                            editor: { type: 'textarea', height: 90 }
                        }
                        
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ess/viewApp/getToolInfo',
            parms: [    
                    { name: 'ACTIVITY',value: $("#ACTIVITY").attr('value')},
                    { name: 'qryType', value: $("#qryType").attr('value')} 
                   ],
            width: '99.6%', height: '100%',
            /*onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
                spf_showDetailData(rowdata.APPLY_NO);
            }*/
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
              success: function (list)
              {  
                  ReturnTypeSelectList = list ; 
              }
          });

          return ReturnTypeSelectList ;
      }     
    
    function spf_showDetailData(applyNo)
    {    
        $dialog = $.ligerDialog.open({isDrag: false, 
            title:'<spring:message code="hrms.approvalActive"/>', 
            width: 700, 
            height: 320, 
            url: '/ess/viewApp/viewApproverInfo?PAGE=B&FLAG=0&APPLY_TYPE=OtApply&APPLY_NO='+applyNo
          });
    }
    function spf_search()
    {
        //alert($("#TOOL_TYPE_CODE").attr('value'));
        $grid.setOptions({ parms: [ 
                                    { name: 'keyWord', value: $("#keyWord").attr('value')}, 
                                    { name: 'ASSET_ID', value: $("#ASSET_ID").attr('value')},
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},  
                                    { name: 'qryType', value: $("#qryType").attr('value')}, 
                                    { name: 'ACTIVITY', value: $("#ACTIVITY").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_return(flag,tag,tool_no){
        spf_approve(flag,tag,tool_no);
    }
    function spf_reject(flag,tag,tool_no){ 
        spf_approve(flag,tag,tool_no);
    }
    function spf_delete(){
        spf_approve(3);
    }
    function spf_approve(flag,tag,tool_no)
    {     
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        } 
        //alert(tool_no);
        if(tool_no != 'undefined' && tool_no != null && tool_no != ''){
            if (row.TOOL_NO != tool_no ) { 
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选中当前行再进行操作') ; 
                return ;
            }
        } 
    
        var jsonData = '' ;

        jsonData = '[' ;
                                                        
        if(flag == 4 && (row.RETURN_TYPE_CODE == null || row.RETURN_TYPE_CODE == '' || row.RETURN_TYPE_CODE == 'undefined' )){ 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '归还状态'  +". " + '<spring:message code="input.required"/>') ; 
            return false;  
        } 
                   
        if (jsonData.length > 1){
            jsonData += ',{' ;
           }
           else{
             jsonData += '{' ;
           } 
        jsonData += ' "APPLY_NO": "' + row.TOOL_NO + '", ' ; 
        jsonData += ' "EMPID": "' + row.EMPID + '", ' ; 
        jsonData += ' "ACTIVITY": "' + flag + '", ' ; 
        if(flag == 1 ||flag ==2){
            if(row.CON_REMARK==null||row.CON_REMARK==''||row.CON_REMARK=='undefined') row.CON_REMARK = '';           
            jsonData += ' "CON_REMARK": "' + row.CON_REMARK + '",' ; 
        }       
        else if(flag == 3){
            if(row.CANCEL_REMARK==null||row.CANCEL_REMARK==''||row.CANCEL_REMARK=='undefined') row.CANCEL_REMARK = '';           
            jsonData += ' "CANCEL_REMARK": "' + row.CANCEL_REMARK + '",' ; 
        }
        else if(flag == 4){
            if(row.RETURN_REMARK==null||row.RETURN_REMARK==''||row.RETURN_REMARK=='undefined') row.RETURN_REMARK = '';           
            jsonData += ' "RETURN_REMARK": "' + row.RETURN_REMARK + '",' ;
            if(row.RETURN_TYPE_CODE==null||row.RETURN_TYPE_CODE==''||row.RETURN_TYPE_CODE=='undefined') row.RETURN_TYPE_CODE = '';           
            jsonData += ' "RETURN_TYPE_CODE": "' + row.RETURN_TYPE_CODE + '",' ; 
        }
        jsonData += ' "APPLY_TYPE": "ToolApply" ' ;
        jsonData += '}' ;                                            
        jsonData += ']' ;
           //alert(jsonData);
        var jsonList = eval("(" + jsonData + ")");
         
        if(jsonData.length == 2 || jsonData.length == 0){ 
            return ;
        }
        if(jsonList.length == 1){ 
               $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
               $.post("/ess/infoCon/confirmApp", 
                      [ 
                        { name: 'jsonData', value: jsonData },
                        { name: 'appType', value: 'ToolInfo' }
                      ]
               , function (result)
               {
                 $.ligerDialog.closeWaitting();
                   if (result == "Y")
                  {
                      $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
    }

    function spf_delete()
    {          

        var rows = $grid.getCheckedRows(); 
         
         if (!rows || rows.length == 0) { 
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        } 
        jsonData = '[' ;
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){
                $(rows).each(function (index, row)
                     {  
                         if (jsonData.length > 1){
                                jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         } 
                         jsonData += ' "APPLY_NO": "' + row.TOOL_NO + '", ' ;  
                         jsonData += ' "EMPID": "' + row.EMPID + '", ' ;  
                         jsonData += ' "APPLY_TYPE": "ToolApply" ' ;  
                         jsonData += '}' ;  
                }); 
                jsonData += ']' ;

                 if (jsonData.length == 2) { 
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                     return ; 
                } 
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/ess/infoCon/delApp', 
                        [   
                            { name: 'jsonData', value: jsonData },
                            { name: 'appType', value: 'ToolInfo' }
                        ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y")
                    { 
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
        }); 
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
                        <td width="15%" class="l-table-edit-t"><spring:message
                                code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord"
                            type="text" id="keyWord" size="30" /></td>
                        <td class="l-table-edit-t" width="15%"><spring:message
                                code="hrms.confirmationActive" /></td>
                        <td class="l-table-edit-c" width="35%"><SipingSoft:selectConStatus
                                name="ACTIVITY" limit="all" selected="-1"
                                onChange="spf_search();" /></td>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t">物品名称</td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectAssetID
                                name="ASSET_ID" onChange="spf_search();" limit="all" /></td>
                        <td class="l-table-edit-t" width="15%">借用时间</td>
                        <td class="l-table-edit-c" width="35%"><input type="text"
                            name="S_DATE" id="S_DATE" value="" size="20"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="20"
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
            <div position="center" id='empInfo'></div>
        </div>
    </div>
</body>
</html>
