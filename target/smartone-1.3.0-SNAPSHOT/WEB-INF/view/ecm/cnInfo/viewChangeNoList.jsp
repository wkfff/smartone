<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $grid = null ;
    $(function () {
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#changeNoInfo").ligerGrid({
            columns: [
                    { display: '变更号', name: 'id', width: 130},
                    { display: '变更日期', name: 'startDate', width: 130},
                    { display: '变更类型', name: 'processRunning.type.name', width: 130},
                    { display: '变更状态', name: 'processRunning.state.name', width: 130},
                    { display: '变更原因', name: 'reason', width: 200,editor:{type:'textarea', height: 100}},
                    { display: '变更描述', name: 'description', width: 200, editor:{type:'textarea', height: 100}},
                    { display: '详细信息',  width: 90,
                        render: function (item) {
                           return '<div style="cursor: pointer;" onClick="spf_showDetail(\''+item.no+'\')">点此查看</div>';
                        }
                    }
                ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/ecm/cnInfo/getChangeNoList',
            parms: [ ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_showDetail(rowdata.no);
            }
        });
    }
    var tab = parent.tab;
    function spf_showDetail(CHANGE_NO){
        if(tab.isTabItemExist('ecm0102')){
            tab.removeTabItem('ecm0102');
        }
        tab.addTabItem({ tabid : 'ecm0102',text: '变更号明细', url: '/ecm/cnInfo/viewChangeNoDetail?changeNo='+CHANGE_NO });
    }
    function spf_update(){
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        if(tab.isTabItemExist('ecm0104')){
            tab.removeTabItem('ecm0104');
        }
        tab.addTabItem({ tabid : 'ecm0104',text: '修改变更号', url: '/ecm/cnManage/updateChangeNo?MENU_CODE=ecm0104&changeNo='+row.no });
    }
    function spf_delete() {
        var row = $grid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'删除变更号',
            width: 420,
            height: 180,
            url: '/ecm/cnManage/removeChangeNo?changeNo='+row.no
        });
    }
    function spf_add(){
        if(tab.isTabItemExist('ecm0103')){
            tab.removeTabItem('ecm0103');
        }
        tab.addTabItem({ tabid : 'ecm0103',text: '新增变更号', url: '/ecm/cnManage/addChangeNo?MENU_CODE=ecm0103' });
    }
    function spf_search() {
        $grid.setOptions({ parms: [
                                    { name: 'keyWord', value: $("#keyWord").attr('value')},
                                    { name: 'S_DATE', value: $("#S_DATE").attr('value')},
                                    { name: 'E_DATE', value: $("#E_DATE").attr('value')},
                                    { name: 'CHANGE_TYPE_NO', value: $("#CHANGE_TYPE_NO").attr('value')},
                                    { name: 'CHANGE_STATUS_NO', value: $("#CHANGE_STATUS_NO").attr('value')}
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
                        <td width="15%" class="l-table-edit-t"><spring:message
                                code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord"
                            type="text" id="keyWord" size="30" /></td>
                        <td width="15%" class="l-table-edit-t">开始日期</td>
                        <td width="35%" class="l-table-edit-c"><input type="text"
                            name="S_DATE" id="S_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /> ~ <input type="text" name="E_DATE"
                            id="E_DATE" value="" size="30"
                            onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                            readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td width="15%" class="l-table-edit-t">变更类型</td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectObjectType name="CHANGE_TYPE_NO" parentTypeNo="1" onChange="spf_search()"
                                limit="all" /></td>
                        <td width="15%" class="l-table-edit-t">变更状态</td>
                        <td width="35%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="CHANGE_STATUS_NO" objectTypeNo="1"
                                onChange="spf_search()" limit="all" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left"><SipingSoft:button />
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id='changeNoInfo'></div>
        </div>
    </div>
</body>
</html>
