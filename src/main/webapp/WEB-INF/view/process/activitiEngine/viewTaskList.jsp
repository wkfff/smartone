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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $statusgrid = null;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create : function(container, editParm) {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue : function(input, editParm) {
            return input.val();
        },
        setValue : function(input, value, editParm) {
            input.val(value);
        },
        resize : function(input, width, height, editParm) {
            var column = editParm.column;
            if (column.editor.width)
                input.width(column.editor.width);
            else
                input.width(width);
            if (column.editor.height)
                input.height(column.editor.height);
            else
                input.height(height);
        }
    };
    // 初始调用
    $(function() {
        //布局
        $("#statuslayout").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        f_initGrid();
    });
    function f_initGrid() {
        $taskgrid = $("#taskInfo").ligerGrid({
            onBeforeEdit : function(e) {
                $.ligerui.win.masking = true;
            },
            columns : [{
                display : '<spring:message code="process.taskName"/>',
                name : 'NAME',
                width : '15%'
            },{
                display : '<spring:message code="process.createTime"/> ',
                name : 'CREATE_TIME',
                width : '10%'
            },{
                display : '<spring:message code="process.Applicant"/>',
                name : 'applicant',
                width : '7%'
            },{
                display : '<spring:message code="process.applicationDescription"/>',
                name : 'DESCRIPTION',
                width : '55%',
                editor : {
                    type : 'textarea',
                    height : 100
                }
            },{
                display : '<spring:message code="process.applicationTime"/>',
                name : 'application_time',
                width : '10%'
            } ],
            enabledEdit : false,
            usePager : false,
            pageSize : 20,
            url : '/process/activitiEngine/getTaskList',
            detail : {
                onShowDetail : spf_getTaskForm,
                height : 'auto'
            },
            parms : [],
            width : '99.6%',
            height : '100%'
        });
    }

    var tab = parent.tab;

    function spf_getTaskForm(row, detailPanel, callback) {
        $.post("/process/activitiEngine/getTaskForm",
        [ {
            name : 'TASKID',
            value : row.ID
        } ],
        function(list) {
            var form = document.createElement('form');
            $(form).css('margin', 10);
            $(form).css('margin-left', 30);
            form.id = 'TASKFORM_' + row.ID;
            form.action = '/process/activitiEngine/submitTask?TASKID='+ row.ID;
            form.method = 'post';
            $(detailPanel).append(form);
            for ( var i = 0; i < list.length; i++) {
                $(form).append(list[i].NAME + '</br>');
                if (list[i].TYPE.name == 'date') {
                    $(form).append('<input type="text" name="'
                        + list[i].ID
                        + '" id="'
                        + list[i].ID
                        + '" value="" size="25" onclick="WdatePicker({isShowClear:true,readOnly:true,dateFmt: \'yyyy-MM-dd\'})" readonly="readonly" />');
                } else if (list[i].TYPE.name == 'boolean') {
                    var boolinput = document.createElement('select');
                    boolinput.name = list[i].ID;
                    boolinput.id = list[i].ID;
                    $(boolinput).append('<option value ="true"><spring:message code="yes"/></option>');
                    $(boolinput).append('<option value ="false"><spring:message code="no"/></option>');
                    $(form).append(boolinput);
                } else if (list[i].TYPE.name == 'string') {
                    var stringinput = document.createElement('textarea');
                    stringinput.name = list[i].ID;
                    stringinput.id = list[i].ID;
                    $(stringinput).css('width', '40%');
                    $(form).append(stringinput);
                } else {
                    var numbinput = document.createElement('input');
                    numbinput.type = 'text';
                    numbinput.name = list[i].ID;
                    numbinput.id = list[i].ID;
                    $(form).append(numbinput);
                }
                $(form).append('</br>');
            }
            $(form).append('<input type="submit" value="<spring:message code='confirm'/>" class="l-button" style="width:79px; height:20px; float:left;"/>');
        });
    }
    //删除
/*  function spf_delete() {
        var row = $taskgrid.getSelectedRow();
        if (!row || row.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/process/activitiEngine/deleteTask", [ {
            name : 'TASKID',
            value : row.ID
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function() {
                    spf_search();
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
    } */
    //搜索
    function spf_search() {
        $taskgrid.setOptions({
            parms : [ {
                name : 'keyWord',
                value : $("#keyWord").attr('value')
            } ],
            newPage : 1
        }); //设置数据参数
        $taskgrid.loadData(true); //加载数据
    }
    function spf_reject(taskid, tag) {
        spf_approve(taskid, tag);
    }
    function spf_approve(taskid, tag) {
        /* $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
         $.post("/process/activitiEngine/submitTask", 
         [  
         { name: 'TASKID', value: taskid },
         { name: 'TAG', value: tag },
         ]
         , function (result)
         {
         $.ligerDialog.closeWaitting();
         if (result == "Y")
         {
         $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
         {
         spf_search(); //加载数据  
         });
         }
         else
         {
         $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
         }
         }); */
    }
    function spf_checkPurchaseOrder(serialNum){
        if (tab.isTabItemExist('prosto0207')) {
            tab.removeTabItem('prosto0207');
        }
        tab.addTabItem({
            tabid:'prosto0207',
            text:'<spring:message code="process.purchaseAuditDetails"/>',
            url: '/productStorage/proBusinessManage/viewCheckPurchaseOrder?PURCHASE_ORDER_ID='+serialNum
        });
    }
    function spf_checkSalesOrder(serialNum){
        if (tab.isTabItemExist('prosto0208')) {
            tab.removeTabItem('prosto0208');
        }
        tab.addTabItem({
            tabid:'prosto0208',
            text:'<spring:message code="process.salesOfSingleAuditDetails"/>',
            url: '/productStorage/proBusinessManage/viewCheckSalesOrder?SALES_ORDER_ID='+serialNum
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
        <div position="center" id='' title=' '>
            <div position="center" id="taskInfo"></div>
        </div>
    </div>
</body>
</html>