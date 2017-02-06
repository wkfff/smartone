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
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid = null;
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
        $("#layout1").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        spf_initGrid();
    });
    function spf_whExcel() {
        var paMonth = $("#paYear").val() + $("#paMonth").val();
        var jsonDataList = 'EMPID,CHINESENAME,PRO_NAME,PROD_ID,PROJ_PROS_TYPE_NAME,START_DATE,WORK_CONTENT,QUANTITY,REMARK';
        var jsonDataSum = 'EMPID,CHINESENAME,QUANTITY_SUM';
        location.href = '/report/pa/salary/viewPaWhReport?PA_MONTH=' + paMonth + '&jsonDataList=' + jsonDataList + '&jsonDataSum=' + jsonDataSum;
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
    }
    function spf_initGrid() {
        var paMonth = $("#paYear").val() + $("#paMonth").val();
        $grid = $("#empInfo").ligerGrid({
            columns : [ {
                display : '<spring:message code="hrms.empid"/>',
                name : 'EMPID',
                width : 120,
                totalSummary : {
                    type : 'count'
                },
                frozen : true
            }, {
                display : '<spring:message code="hrms.name"/>',
                name : 'CHINESENAME',
                width : 120,
                frozen : true
            }, {
                display : '<spring:message code="hrms.dept"/>',
                name : 'DEPTNAME',
                width : 120,
                frozen : true
            }, {
                display : '<spring:message code="hrms.date"/>',
                name : 'START_DATE',
                width : 120,
                frozen : true
            }, {
                display : '<spring:message code="hrms.attItemName"/>',
                name : 'PRO_NAME',
                width : 120
            }, {
                display : '物料编码',
                name : 'PROD_ID',
                width : 120
            }, {
                display : '工序',
                name : 'PROJ_PROS_TYPE_NAME',
                width : 100
            }, {
                display : '工单金额',
                name : 'QUANTITY',
                align : 'right',
                width : 90,
                totalSummary : {
                    type : 'sum'
                }
            }, {
                display : '<spring:message code="hrms.workingDescription"/>',
                name : 'WORK_CONTENT',
                align : 'left',
                width : 160,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="hrms.remarks"/>',
                name : 'REMARK',
                width : 160
            }, {
                display : '',
                name : 'WH_NO',
                width : 10,
                hide : 1
            } ],
            enabledEdit : true,
            usePager : true,
            rownumbers : true,
            url : '/pa/wagebase/getPaWhInfo',
            parms : [ {
                name : 'PA_MONTH',
                value : paMonth
            } ],
            width : '99.6%',
            height : '100%'
        });
    }
    function spf_search() {
        var paMonth = $("#paYear").val() + $("#paMonth").val();
        $grid.setOptions({
            parms : [ {
                name : 'PA_MONTH',
                value : paMonth
            } ],
            newPage : 1
        }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function f_ChildWindowClose() {
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
    width: 99.6%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99%" cellpadding="0" cellspacing="0" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="20%" class="l-table-edit-t"><spring:message code="hrms.wageMonth" /></td>
                        <td width="80%" class="l-table-edit-c"><SipingSoft:date yearName="paYear" monthName="paMonth" onChange="spf_search()" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px;" onclick="spf_whExcel()"><spring:message
                                    code="hrms.excelExport" /></a> <SipingSoft:button /></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='empInfo'></div>
        </div>
    </div>
</body>
</html>
