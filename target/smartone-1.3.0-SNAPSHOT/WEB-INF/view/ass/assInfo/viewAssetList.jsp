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
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
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
        $grid = $("#assetInfo").ligerGrid({
            //checkbox: true,           
            columns: [   
                        { display: '资产编号', name: 'ASSET_ID', width: 120},
                        { display: '<spring:message code="ass.assetName"/>', name: 'ASSET_NAME', width: 140},
                        { display: '<spring:message code="ass.assetClasses"/>', name: 'ASSET_CATEGORY', width: 120},
                        { display: '<spring:message code="ass.dateOfPurchase"/>', name: 'PURCHASE_DATE', width: 120},
                        { display: '<spring:message code="ass.assetStatus"/>', name: 'STATUS', width: 100},
                        { display: '<spring:message code="ass.assetType"/>', name: 'ASSET_MODEL', width: 120},
                        { display: '<spring:message code="ass.assetDescription"/>', name: 'DESCRIPTION', width: 160},
                        { display: '<spring:message code="ass.assetDetails"/>', width: 100,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_showDetail(\''+item.ASSET_ID+'\')"><spring:message code="ass.clickHereToView"/></div>';
                            } 
                        } 
                    ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ass/assInfo/getAssetList',
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
    var tab = parent.tab;
    function spf_showDetail(ASSET_ID){
        if(tab.isTabItemExist('ass0102')){
            tab.removeTabItem('ass0102');
        }
        tab.addTabItem({ tabid : 'ass0102',text: '<spring:message code="ass.assetDetails"/>', url: '/ass/assInfo/viewAssetDetail?ASSET_ID='+ASSET_ID });

    }
    function spf_update(){
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        }
        if(tab.isTabItemExist('ass0202')){
            tab.removeTabItem('ass0202');
        }
        tab.addTabItem({ tabid : 'ass0202',text: '<spring:message code="ass.modifyAssets"/>', url: '/ass/assManage/updateAsset?MENU_CODE=ass0202&ASSET_ID='+row.ASSET_ID });
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
    function spf_delete()
    {   
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        }
        $dialog = $.ligerDialog.open({isDrag: false, 
            title:'<spring:message code="ass.deletingAssets"/>', 
            width: 420, 
            height: 220, 
            url: '/ass/assManage/removeAsset?ASSET_ID='+row.ASSET_ID
        });
    }
    function spf_add(){
        if(tab.isTabItemExist('ass0201')){
            tab.removeTabItem('ass0201');
        }
        tab.addTabItem({ tabid : 'ass0201',text: '<spring:message code="ass.newAssets"/>', url: '/ass/assManage/addAsset?MENU_CODE=ass0201' });
    }
    function spf_search()
    {
        //alert($("#TOOL_NAME_CODE").attr('value'));
        $grid.setOptions({ parms: [ 
                        { name: 'keyWord', value: $("#keyWord").attr('value')}, 
                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},  
                    { name: 'STATUS_CODE', value: $("#STATUS_CODE").attr('value')},
                    { name: 'ASSET_CATEGORY_CODE', value: $("#ASSET_CATEGORY_CODE").attr('value')},
                    { name: 'DEPTID', value: $("#DEPTID").attr('value')}
                       ],
               newPage: 1
             }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
    function spf_afterRemove(){
        $dialog.close();
        $grid.loadData(true); //加载数据
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
                        <td width="15%" class="l-table-edit-t"><spring:message code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c">
                            <input name="keyWord" type="text" id="keyWord" size="30" /></td>
                        <td class="l-table-edit-t" width="15%"><spring:message code="ass.dateOfPurchase"/></td>
                        <td class="l-table-edit-c" width="35%" ><input type="text" name="S_DATE"
                            id="S_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd HH:mm'})"
                            readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t" width="15%"><spring:message code="ass.assetStatus"/></td>
                        <td width="35%" class="l-table-edit-c">
                            <SipingSoft:selectSyCode parentCode="ReturnTypeCode" name="STATUS_CODE" onChange="spf_search();" limit="all" />
                        </td>
                        <td class="l-table-edit-t" width="15%"><spring:message code="ass.assetClasses"/></td>
                        <td width="35%" class="l-table-edit-c">
                            <SipingSoft:selectSyCode parentCode="AssetCategoryCode" name="ASSET_CATEGORY_CODE" onChange="spf_search();" limit="all" />
                        </td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="ass.department"/></td>
                        <td width="35%" class="l-table-edit-c" nowrap="nowrap" colspan="3"> 
                            <SipingSoft:deptTree name="DEPTID" limit="hr"/></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id='assetInfo'></div>
        </div>
    </div>
</body>
</html>