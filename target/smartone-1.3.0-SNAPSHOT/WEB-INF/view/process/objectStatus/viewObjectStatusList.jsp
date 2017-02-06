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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $statusgrid = null;
    //扩展一个 多行文本框 的编辑器
    // 初始调用
    $(function() {
        //布局
        $("#statuslayout").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        f_initGrid();
    });

    function f_initGrid() {
        $statusgrid = $("#objectStatusInfo").ligerGrid({
            onBeforeEdit : function(e) {
                $.ligerui.win.masking = true;
            },
            columns : [ {
                display : '<spring:message code="process.statusCode"/>',
                name : 'id',
                width : 90
            }, {
                display : '<spring:message code="process.stateName"/>',
                name : 'name',
                width : 140,
                editor : {
                    type : 'text',
                    height : 100
                }
            }, {
                display : '<spring:message code="process.statusDescription"/>',
                name : 'description',
                width : 220,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="process.isAvailable"/>',
                name : 'active',
                width : 90
            } ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            pageSize : 20,
            url : '/process/objectStatus/getObjectStatusList',
            parms : [],
            width : '99.6%',
            height : '100%'
        });
    }
    var tab = parent.tab;

    function spf_add() {
        var rows = $statusgrid.getData();
        if (!rows || rows.length == 0) {
            $statusgrid.addRow({
                no : '',
                id : '',
                name :'',
                description:'',
                active:true
            });
        } else {
            $(rows).each(function(index) {
                var row = $statusgrid.getRow(0);
                if (index == 0) {
                    $statusgrid.addRow({
                        no : '',
                        id : '',
                        name :'',
                        description:'',
                        active:true
                    }, row, true);
                }
            });
        }
    }

    function spf_search() {
        $statusgrid.setOptions({
            parms : [ {
                name : 'keyWord',
                value : $("#keyWord").attr('value')
            } ],
            newPage : 1
        }); //设置数据参数
        $statusgrid.loadData(true); //加载数据
    }

    function spf_delete() {
        var row = $statusgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $.ligerDialog.confirm('<spring:message code="process.areYouSureYouWantToDeleteThisType"/>', '<spring:message code="hrms.warning"/>', function(isAgree) {
            if (isAgree) {
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post("/process/objectStatus/removeObjectStatus", [ {
                    name : 'stateNo',
                    value : row.no
                } ], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result.code == "0") {
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

    function spf_save() {
        $statusgrid.endEdit();
        var jsonData = '[';
        var flag = 0;
        var rows = $statusgrid.getData();

        $(rows).each(function(index, row) {
            if (this.__status != null && (this.__status == 'add' || this.__status == 'update')) {
                if (this.name == null || this.name == '') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="process.stateName"/>' + ". " + '<spring:message code="input.required"/>');
                    flag = 1;
                    return false;
                } else {
                    if (this.description == null || this.description == 'undefined') {
                        this.description = '';
                    }
                    if (jsonData.length > 1) {
                        jsonData += ',{';
                    } else {
                        jsonData += '{';
                    }
                    jsonData += ' "no": "' + this.no + '", '
                    jsonData += ' "id": "' + this.id + '", '
                    jsonData += ' "name": "' + this.name + '", ';
                    jsonData += ' "description": "' + this.description + '", ';
                    jsonData += ' "active": "' + this.active + '", ';
                    jsonData += '}';
                }
            }
        });
        if (flag == 1) {
            return;
        }
        jsonData += ']';
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/process/objectStatus/transferObjectStatus", [ {
            name : 'jsonData',
            value : jsonData
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result.code == "0") {
                $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                    $statusgrid.loadData(true); //加载数据
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
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

#statuslayout {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="statuslayout">
        <div position="center" id='' title=''>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="15%" class="l-table-edit-t"><spring:message code="keyWord" /></td>
                        <td width="35%" class="l-table-edit-c"><input name="keyWord" type="text" id="keyWord" size="30" /></td>
                        <td width="15%" class="l-table-edit-t"></td>
                        <td width="35%" class="l-table-edit-c"></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='objectStatusInfo'></div>
        </div>
    </div>
</body>
</html>
