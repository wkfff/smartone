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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $dialog = null;
    var $grantgrid = null;
    var $statusgrid = null;

    //初始化数据
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        if ($('#OBJECT_TYPE_NO').val() == null || $('#OBJECT_TYPE_NO').val() == '' || $('#OBJECT_TYPE_NO').val() == 'undefined') {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="process.pleaseSelectThisPage"/>', function afterClick() {
                tab.removeTabItem('process0103');
            });

        } else {
            spf_grant_initGrid();
            spf_status_initGrid();
        }
    });

    /*****************************************************/
    function spf_grant_initGrid() {
        $grantgrid = $("#objectTypeGrantInfo").ligerGrid({
            onBeforeEdit : function(e) {
                $.ligerui.win.masking = true;
            },
            rownumbers : true,
            columns : [ {
                display : '<spring:message code="hrms.chineseName"/>',
                name : 'role.name',
                width : 120,
                align : 'center'
            }, {
                display : '<spring:message code="hrms.description"/>',
                name : 'role.description',
                width : 220,
                align : 'left'
            }, {
                display : '<spring:message code="process.view"/>',
                name : 'readable',
                width : 100,
                editor : {type:'checkbox',height:'100',width:'100'}
            }, {
                display : '<spring:message code="hrms.update"/>',
                name : 'writeable',
                width : 100,
                editor : {type:'checkbox',height:'100',width:'100'}
            }, {
                display : '<spring:message code="hrms.add"/>',
                name : 'createable',
                width : 100,
                editor : {type:'checkbox',height:'100',width:'100'}
            }, {
                display : '<spring:message code="hrms.delete"/>',
                name : 'deleteable',
                width : 100,
                editor : {type:'checkbox',height:'100',width:'100'}
            } ],
            enabledEdit : true,
            usePager : true,
            enabledSort : true,
            url : '/process/objectType/getObjectTypeGrantList?typeNo=' + $("#OBJECT_TYPE_NO").val(),
            pageSize : 10,
            width : '99%',
            height : '300px'
        });
    }

    function spf_status_initGrid() {
        $statusgrid = $("#statusAffirmInfo").ligerGrid({
            checkbox : false,
            rownumbers : true,
            columns : [ {
                display : '<spring:message code="process.statusCode"/>',
                name : 'state.no',
                width : 0,
                hide : 1
            }, {
                display : '<spring:message code="process.stateName"/>',
                name : 'state.name',
                width : 120,
                render : function(item) {
                    if (!item.active)
                        return '<font style="color:red;font-weight:bold">' + item.state.name + '</font>';
                    else
                        return '<font style="color:green;font-weight:bold">' + item.state.name + '</font>';
                }
            }, {
                display : '<spring:message code="process.successfulState"/>',
                name : 'nextState',
                width : 120,
                render : function(item) {
                    if (item.nextState != null)
                        return '<img src="/resources/images/1.gif"/>' + item.nextState.name;
                }
            }, {
                display : '<spring:message code="process.returnStatus"/>1',
                name : 'preState1',
                width : 120,
                render : function(item) {
                    if (item.preState1 != null)
                        return '<img src="/resources/images/0.gif"/>' + item.preState1.name;
                }
            }, {
                display : '<spring:message code="process.returnStatus"/>2',
                name : 'preState2',
                width : 120,
                render : function(item) {
                    if (item.preState2 != null)
                        return '<img src="/resources/images/0.gif"/>' + item.preState2.name;
                }
            }, {
                display : '<spring:message code="process.returnStatus"/>3',
                name : 'preState3',
                width : 120,
                render : function(item) {
                    if (item.preState3 != null)
                        return '<img src="/resources/images/0.gif"/>' + item.preState3.name;
                }
            }, {
                display : '<spring:message code="process.returnStatus"/>3',
                name : 'ifProcess',
                width : 120,
                render : function(item) {
                    if (item.processModel != null && item.processModel.id != "")
                        return "执行审批";
                }
            }  ],
            usePager : true,
            enabledSort : true,
            url : '/process/objectType/getProcessItemList?typeNo=' + $("#OBJECT_TYPE_NO").val(),
            pageSize : 10,
            width : '99%',
            height : '200px'
        });
    }

    function spf_update() {
        spf_save();
    }

    function spf_save() {
        if (spf_checkData()) {
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var $typeJson = {};
            $typeJson.no = $("#OBJECT_TYPE_NO").val();
            $typeJson.name = $("#OBJECT_TYPE_NAME").val();
            $typeJson.active = $("#ACTIVITY").val();
            $typeJson.defaultState = {};
            $typeJson.defaultState.no = $("#DEFAULT_STATUS_NO").val();
            $typeJson.description = $("#DESCRIPTION").val();

            var $grantsJson = spf_getGrants();

            $.post("/process/objectType/transferObjectType", [{
                    name : 'jsonData',
                    value : JSON.stringify($typeJson)
                },
                {   name : 'jsonGrants',
                    value : JSON.stringify($grantsJson) 
                }],
            function(result) {
                $.ligerDialog.closeWaitting();
                if (result.code == 0) {
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                        spf_refresh($("#OBJECT_TYPE_NO").val());
                    });
                } else {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                }
            });
        }
    }

    function spf_addProcessItem() {
        $dialog = $.ligerDialog.open({
            isDrag : true,
            title : '<spring:message code="process.addingProcess"/>',
            name : 'addProcessItem' + Math.random(),
            width : 1000,
            height : 250,
            url : '/process/objectType/addProcessItem?typeNo=' + $('#OBJECT_TYPE_NO').val(),
            buttons: [
              { text: '取消', onclick: function (item, dialog) {
                      var fn = $dialog.frame.spf_cancel || $dialog.frame.window.spf_cancel;
                      if(fn()){
                          $dialog.close();
                      }
                  }
              },
              { text: '保存', onclick: function (item, dialog) { 
                      var fn = $dialog.frame.spf_save || $dialog.frame.window.spf_save;
                      fn();
                  }
              }
           ]
        });
    }

    function spf_removeProcessItem() {
        var row = $statusgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="process.sureDelete"/>？', function(result) {
            if (result) {
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/process/objectType/removeProcessItem', [ {
                    name : 'processItemNo',
                    value : row.no
                }], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == 0) {
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            $statusgrid.loadData(true);
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                    }
                });
            }
        });
    }

    function spf_updateProcessItem() {
        var row = $statusgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $dialog = $.ligerDialog.open({
            isDrag : true,
            title : '<spring:message code="process.modifyTheProcess"/>',
            width : 1000,
            height : 250,
            url : '/process/objectType/updateProcessItem?processItemNo='+row.no+'&typeNo=' + $("#OBJECT_TYPE_NO").val() + '&stateNo=' + row.STATUS_NO,
            buttons: [
              { text: '取消', onclick: function (item, dialog) {
                      var fn = $dialog.frame.spf_cancel || $dialog.frame.window.spf_cancel;
                      if(fn()){
                          $dialog.close();
                      }
                  }
              },
              { text: '保存', onclick: function (item, dialog) { 
                      var fn = $dialog.frame.spf_save || $dialog.frame.window.spf_save;
                      fn();
                  }
              }
           ]
        });
    }

    function spf_checkData() {
        if ($("#OBJECT_TYPE_NAME").val() == null || $("#OBJECT_TYPE_NAME").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="process.typeName"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        if ($("#DEFAULT_STATUS_NO").val() == null || $("#DEFAULT_STATUS_NO").val() == "") {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="process.initialState"/>' + ". " + '<spring:message code="input.required"/>');
            return false;
        }
        return true;
    }

    var tab = parent.tab;
    function spf_refresh(OBJECT_TYPE_NO) {
        if (tab.isTabItemExist('process0103')) {
            tab.removeTabItem('process0103');
        }
        tab.addTabItem({
            tabid : 'process0103',
            text : '<spring:message code="process.editType"/>',
            url : '/process/objectType/updateObjectType?MENU_CODE=process0103&typeNo=' + OBJECT_TYPE_NO
        });
    }

    function spf_getGrants() {
        $grantgrid.endEdit();
        var $grants = [];
        var rows = $grantgrid.getData();

        $(rows).each(function(index, row) {
            if (this.__status == null || this.__status == 'update') {
                var $grant={};
                $grant.role = {};
                $grant.role.no = this.role.no;
                $grant.readable = this.readable;
                $grant.writeable = this.writeable;
                $grant.deleteable= this.deleteable;
                $grant.createable = this.createable;
                $grants.push($grant);
            }
        });
        return $grants;
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
    <div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
        <input type="hidden" name="FLAG" id="FLAG" />
        <input type="hidden" name="SCREEN_GRANT_ID" id="SCREEN_GRANT_ID" value="${ObjectTypeDetail.id}"/>
        <input type="hidden" name="OBJECT_TYPE_NO" id="OBJECT_TYPE_NO" value="${ObjectTypeDetail.no}" />
        <input type="hidden" name="GRANT_TAG" id="GRANT_TAG" />

        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="ass.Information" /></td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;"><SipingSoft:button /></td>
            </tr>
        </table>
        <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="process.typeName" /><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="OBJECT_TYPE_NAME" id="OBJECT_TYPE_NAME" value="${ObjectTypeDetail.name}" size="30" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.englishName" /></td>
                <td width="20%" class="l-table-edit-c"><input type="text" name="OBJECT_TYPE_EN_NAME" id="OBJECT_TYPE_EN_NAME" value="${ObjectTypeDetail.name}" size="30" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="process.isAvailable" /></td>
                <td width="20%" class="l-table-edit-c"><Static:isActive name="ACTIVITY" selected="${ObjectTypeDetail.active}" /></td>
                <td width="10%" class="l-table-edit-t"><spring:message code="process.initialState" /><font color="red">*</font></td>
                <td width="20%" class="l-table-edit-c"><SipingSoft:selectStatusNo name="DEFAULT_STATUS_NO" objectTypeNo="${ObjectTypeDetail.no}"
                        selected="${ObjectTypeDetail.defaultState.no}" limit="all" /></td>
            </tr>
            <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="process.typeDescription" /></td>
                <td width="20%" class="l-table-edit-c" nowrap="nowrap" colspan="3"><textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION">${ObjectTypeDetail.description}</textarea></td>
            </tr>
        </table>
        <!-- 权限 -->
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="process.typePermissions" /></td>
                <td width="5%" align="right"></td>
                <td align="right" height="30px;">&nbsp;</td>
            </tr>
        </table>
        <div id="objectTypeGrantInfo"></div>
        <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif" /></td>
                <td width="25%" align="left" style="font-weight: bold;"><spring:message code="process.statusProcess" /></td>
                <td width="5%" align="right">&nbsp;</td>
                <td align="right" height="30px;">&nbsp; <a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_removeProcessItem()"><spring:message
                            code="cust.delete1" /></a> <a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_updateProcessItem()"><spring:message
                            code="hrms.update" /></a> <a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_addProcessItem()"><spring:message
                            code="eva.add" /></a>
                </td>
            </tr>
        </table>
        <div id="statusAffirmInfo"></div>
</body>
</html>
