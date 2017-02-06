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
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#whInfo").ligerGrid({
            //checkbox: true,   		
            columns : [ {
                display : '',
                name : 'EMPID',
                width : 10,
                hide : 1
            }, {
                display : '日期',
                name : 'MONTH',
                width : 90,
                frozen : true
            }, {
                display : '<spring:message code="hrms.name"/>',
                name : 'CHINESENAME',
                width : 90,
                frozen : true,
                render : function(row) {
                    return '<span onClick="spf_showWhCalendarInfo(' + row.EMPID + ');" style="cursor: pointer;color: black;font-weight:bold;"> ' + row.CHINESENAME + '</span>';
                }
            }, {
                display : '有效工时',
                name : 'TOTAL_WH',
                width : 90
            }, {
                display : '有效日',
                name : 'TOTAL_WD',
                width : 90
            }, {
                display : '出勤小时',
                name : 'WEI_1_HOUR',
                width : 90
            }, {
                display : '出勤日',
                name : 'WEI_1_DAY',
                width : 90
            }, {
                display : '绩效小时',
                name : 'WEI_2_HOUR',
                width : 90
            }, {
                display : '列',
                name : 'WEI_2_DAY',
                width : 90
            }, {
                display : '病假小时',
                name : 'WEI_3_HOUR',
                width : 90
            }, {
                display : '病假日',
                name : 'WEI_3_DAY',
                width : 90
            }, {
                display : '事假小时',
                name : 'WEI_4_HOUR',
                width : 90
            }, {
                display : '事假日',
                name : 'WEI_4_DAY',
                width : 90
            }, {
                display : '外部项目绩效日',
                name : 'WEI_5_DAY',
                width : 90
            }, {
                display : '内部项目绩效日',
                name : 'WEI_6_DAY',
                width : 90
            }  ],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            url : '/ess/infoApp/getWhConclusionList',
            parms : [ {
                name : 'ACTIVITY',
                value : $("#ACTIVITY").attr('value')
            }, {
                name : 'MONTH',
                value : $("#attYear").attr('value') + $("#attMonth").attr('value')
            } ],
            width : '99.6%',
            height : '100%'
        });
    }

    function spf_Calculate() {
        var attMonth = $("#attYear").attr('value') + $("#attMonth").attr('value');
        $.post('/ess/infoApp/calculateWhConclusion?MONTH=' + attMonth, [], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $.ligerDialog.success('数据计算成功', '<spring:message code="hrms.warning"/>', function() {
                    spf_search();
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
    }

    function spf_showWhCalendarInfo(empID) {
        $dialog = $.ligerWindow.show({
            isDrag : false,
            title : '<spring:message code="hrms.workingHoursCalendar"/>',
            width : 800,
            height : 480,
            left : 80,
            top : 5,
            url : '/ess/infoApp/viewWhCalendarInfo?EMPID=' + empID
        });
    }

    function spf_search() {
        //alert($("#TOOL_NAME_CODE").attr('value'));
        $grid.setOptions({
            parms : [ {
                name : 'MONTH',
                value : $("#attYear").attr('value') + $("#attMonth").attr('value')
            } ],
            newPage : 1
        }); //设置数据参数
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
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="20%" class="l-table-edit-t"><spring:message code="hrms.attendanceMonth" /></td>
                        <td width="80%" class="l-table-edit-c"><SipingSoft:date yearName="attYear" monthName="attMonth" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px;" onclick="spf_Calculate()"><spring:message
                                    code="calculate" /></a></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='whInfo'></div>
        </div>
    </div>
</body>
</html>
