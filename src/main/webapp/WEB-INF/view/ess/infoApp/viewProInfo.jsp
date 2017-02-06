<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<!-- <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script> -->
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
     var $dialog ;
     var $pro_grid ;
     var $pro_m_grid ;
     var empID = "" ;
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
                 allowTopResize: false,      //是否允许 头部可以调整大小
                 allowBottomResize: false     //是否允许 底部可以调整大小
           }
          );
          $proTypeCodeSelectList = getProTypeCodeSelectList() ;
          spf_pro_initGrid();
     });

     function getProTypeCodeSelectList(){
        //请求服务器
        var proTypeCodeSelectList ;
         $.ajax({
             type: 'post',
             url: '/utility/otherInfo/getProTypeCodeSelectList',
             dataType: 'json',
             async: false,
             success: function (list)
             {
                 proTypeCodeSelectList = list ;
             }
         });
         return proTypeCodeSelectList ;
     }
   //项目信息
     function spf_pro_initGrid()
     {
        $pro_grid = $("#proInfo").ligerGrid({
            onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
            },
            checkbox: false,
            columns: [
                    { display: '<spring:message code="hrms.type"/>', name: 'TYPE_CODE', width: 140,align: 'left',
                        editor: {
                            type: 'select', data: $proTypeCodeSelectList, dataValueField: 'TYPE_CODE',dataDisplayField: 'TYPE_NAME',
                            displayColumnName: 'TYPE_NAME', valueColumnName: 'TYPE_CODE'
                        }, render: function (item)
                        {
                            for (var i = 0; i < $proTypeCodeSelectList.length; i++)
                            {
                                if ($proTypeCodeSelectList[i]['TYPE_CODE'] == item.TYPE_CODE)
                                    return $proTypeCodeSelectList[i]['TYPE_NAME']
                            }
                            return item.TYPE_NAME;
                        }
                    },
                    { display: '<spring:message code="hrms.chineseName"/>', name: 'PRO_NAME', width: 130,align: 'left', editor: { type: 'text' }},
                    { display: '<spring:message code="hrms.englishName"/>', name: 'PRO_EN_NAME', width: 130,align: 'left', editor: { type: 'text' }},
                    //{ display: '<spring:message code="hrms.module"/>', name: 'PRO_MODULE', width: 120, editor: { type: 'text' }},
                    { display: '<spring:message code="hrms.projectQuantity"/>', name: 'QUANTITY', width: 120},
                    { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                    { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
                    { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left', width: 140,
                        editor: { type: 'textarea', height: 100 }
                    },
                    { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 140,
                        editor: { type: 'textarea', height: 100 }
                    }

            ],
            enabledEdit: true, usePager: true,rownumbers: false,
            url: "/ess/viewApp/getProInfo",
            width: '99.6%', height: '100%',
            pageSize:20,
            showTitle: false,width:'99.6%',columnWidth:380,
            detail: { onShowDetail: spf_showDetailData,height:'auto' }
         });
     }
     function spf_showDetailData(row, detailPanel,callback)
     {
         var grid = document.createElement('div');
         $(detailPanel).append(grid);
         $pro_m_grid = $(grid).css('margin',10).ligerGrid({
             columns:
                         [
                            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:90 },
                            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:90},
                            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:120},
                            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME',width:90},
                            { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120},
                            { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120},
                            { display: '<spring:message code="hrms.projectQuantity"/>', name: 'QUANTITY', width: 170, type: 'float',totalSummary:{type: 'sum'}},
                            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
                                editor: { type: 'textarea', height: 100 }
                            }
                         ],
                         enabledEdit: true,usePager: false, rownumbers: true,
                         isScroll: false, showToggleColBtn: false, width: '93%',
                         url: '/ess/viewApp/getProMemberInfo?PRO_NO='+row.PRO_NO,
                         showTitle: false, columnWidth: 120,
                         onDblClickRow: function(rowdata, rowindex, rowDomElement){
                             spf_upateProMemberInfo(row.PRO_NO);
                         }
         });
     }
        function f_ChildWindowClose (){
            $pro_grid.loadData(true); //加载数据
            $dialog.close() ;
        }

        function spf_upateProMemberInfo(proNo)
        {
            if(proNo == "" || proNo == "undefined"){
                  $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                  return ;
            }else{
                $dialog = $.ligerWindow.show({isDrag: true,
                    title: '<spring:message code="hrms.projectMember"/>',
                    width: 900 ,
                    height: 450 ,
                    left:120,top:90,
                    url: '/ess/infoApp/upateProMemberInfo?PRO_NO='+proNo
                });
            }
        }
        function spf_add()
        {
            $dialog = $.ligerWindow.show({isDrag: true,
                title: '<spring:message code="hrms.add"/>',
                width: 900 ,
                height: 450 ,
                left:120,top:90,
                url: '/ess/infoApp/addProInfo'
            });
        }
     function spf_delete()
     {
        var rows = $pro_grid.getSelectedRow();

        if (!rows || rows.length == 0) {
          $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
          return ;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
         {
            if(yes){

                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/ess/viewApp/delProInfo',
                        [
                            { name: 'PRO_NO', value: rows.PRO_NO },
                            { name: 'EMPID', value: empID }
                        ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y")
                    {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            $pro_grid.loadData(true); //加载数据
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

     function spf_save()
     {
         var jsonData = '[' ;
         var flag = '0' ;
         var rows = $pro_grid.getData();
        $(rows).each(function (index, row)
              {
               if(this.__status != null && this.__status == 'update'){

                   if(this.TYPE_CODE == null || this.TYPE_CODE == '' || this.TYPE_CODE == 'undefined'){
                         $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.type"/>'+". " + '<spring:message code="input.required"/>') ;
                         return ;
                   }
                   if(this.PRO_NAME == null || this.PRO_NAME == '' || this.PRO_NAME == 'undefined'){
                         $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chineseName"/>'+". " + '<spring:message code="input.required"/>') ;
                         return ;
                   }else{
                       flag = '1';
                       if (jsonData.length > 1){
                            jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         }
                         jsonData += ' "PRO_NO": "' + this.PRO_NO + '", ' ;
                         jsonData += ' "PRO_NAME": "' + this.PRO_NAME + '", ' ;
                         jsonData += ' "PRO_EN_NAME": "' + MyCheckNull(this.PRO_EN_NAME) + '", ' ;
                         jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
                         jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
                         jsonData += ' "TYPE_CODE": "' + this.TYPE_CODE + '",' ;
                         jsonData += ' "DESCRIPTION": "' + MyCheckNull(this.DESCRIPTION) + '",' ;
                         jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
                         jsonData += '}' ;
                   }
            }
         });

        jsonData += ']' ;
        if (flag == '0') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
             return ;
        }
        if(flag == '1'){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.post("/ess/infoApp/updateProInfo",
                    [
                        { name: 'jsonData', value: jsonData },
                    ]
            , function (result)
            {
                $.ligerDialog.closeWaitting();
                if (result == "Y")
                {
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        $pro_grid.loadData(true); //加载数据
                    });
                }
                else
                {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
     }
        
     //项目搜索
     function spf_search()
     {
         $pro_grid.setOptions({ 
             url : '/ess/viewApp/getProInfo', 
             parms: [{ name: 'keyWord', value: $("#txt_nameMatch").attr('value')},
                     /* { name: 'START_DATE', value: $("#S_DATE").attr('value')},
                     { name: 'END_DATE', value: $("#E_DATE").attr('value')}, */
                     { name: 'CODE_ID', value: $("#CODE_ID").attr('value')}
                     ],
             newPage: 1
         }); //设置数据参数
         $pro_grid.loadData(true); //加载数据
     }    
    </script>
</head>
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
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="typeMatch" />
                        <td width="15%" class="l-table-edit-c">
                            <SipingSoft:selectSyCode parentCode="projectTypeCode" name="CODE_ID" onChange="spf_search();" limit="all"/>
                        </td>
                        <%-- <td class="l-table-edit-t" width="15%"><spring:message code="hrms.date" /> --%>
                        <%-- <td class="l-table-edit-c" width="35%"><input type="text" name="S_DATE" id="S_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})" readonly="readonly" /> ~ <input type="text"
                            name="E_DATE" id="E_DATE" value="" size="30" onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /></td> --%>
                        <td class="l-table-edit-t" width="15%"><spring:message code="name" /></td>
                        <td width="15%" class="l-table-edit-c"><input name="txt_nameMatch" type="text" id="txt_nameMatch" size="30" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td><SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div id="proInfo"></div>
        </div>
    </div>
</body>
</html>
