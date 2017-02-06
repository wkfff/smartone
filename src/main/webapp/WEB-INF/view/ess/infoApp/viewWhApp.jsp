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
<script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
    var $dialog;
    var $workingHours_grid;
    var $pro_grid;
    var $Flag = "workingHours";
    var $proSelectList;
    var $proTypeCodeSelectList;
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
            topHeight : 150,
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false
        //是否允许 底部可以调整大小
        });
        $proSelectList = getProSelectList();
        $proTypeCodeSelectList = getProTypeCodeSelectList();
        spf_workingHours_initGrid();
        spf_pro_initGrid();
    });
    function getProSelectList() {
        //请求服务器
        var proSelectList;
        $.ajax({
            type : 'post',
            url : '/utility/otherInfo/getProSelectList?EMPID=${basicInfo.EMPID }',
            dataType : 'json',
            async : false,
            success : function(list) {
                proSelectList = list;
            }
        });

        return proSelectList;
    }
    function getProSelectListByTypeCode(typeCode) {
        //请求服务器
        $.ajax({
            type : 'post',
            url : '/utility/otherInfo/getProSelectList?TYPE_CODE=' + typeCode,
            dataType : 'json',
            async : false,
            success : function(list) {
                $proSelectList = list;
            }
        });
        return $proSelectList;
    }
    function getProTypeCodeSelectList() {
        //请求服务器
        var proTypeCodeSelectList;
        $.ajax({
            type : 'post',
            url : '/utility/otherInfo/getProTypeCodeSelectList?EMPID=${basicInfo.EMPID }',
            dataType : 'json',
            async : false,
            success : function(list) {
                proTypeCodeSelectList = list;
            }
        });

        return proTypeCodeSelectList;
    }
    //工时申请
    function spf_workingHours_initGrid() {
        $workingHours_grid = $("#workingHoursInfo").ligerGrid({
            onBeforeEdit : function(e) {
                $.ligerui.win.masking = true;
            },
            checkbox : false,
            columns : [ {
                display : '<spring:message code="hrms.date"/>',
                name : 'START_DATE',
                width : 120,
                type : 'date',
                format : 'yyyy-MM-dd',
                editor : {
                    type : 'date'
                },
                frozen : true,
                totalSummary : {
                    type : 'count'
                }
            }, {
                display : '<spring:message code="hrms.type"/>',
                name : 'TYPE_CODE',
                width : 130,
                align : 'center',
                editor : {
                    type : 'select',
                    data : $proTypeCodeSelectList,
                    dataValueField : 'TYPE_CODE',
                    dataDisplayField : 'TYPE_NAME',
                    displayColumnName : 'TYPE_NAME',
                    valueColumnName : 'TYPE_CODE'
                },
                render : function(item) {
                    for (var i = 0; i < $proTypeCodeSelectList.length; i++) {
                        if ($proTypeCodeSelectList[i]['TYPE_CODE'] == item.TYPE_CODE) {
                            return $proTypeCodeSelectList[i]['TYPE_NAME'];

                        }
                    }
                    return item.TYPE_NAME;
                }
            }, {
                display : '<spring:message code="hrms.attItemName"/>',
                name : 'PRO_ID',
                align : 'center',
                width : 130,
                isSort : false,
                editor : {
                    type : 'select',
                    data : $proSelectList,
                    dataValueField : 'PRO_ID',
                    dataDisplayField : 'PRO_NAME',
                    displayColumnName : 'PRO_NAME',
                    valueColumnName : 'PRO_ID'
                },
                render : function(item) {
                    for (var i = 0; i < $proSelectList.length; i++) {
                        if ($proSelectList[i]['TYPE_CODE'] == item.TYPE_CODE && $proSelectList[i]['PRO_ID'] == item.PRO_ID)
                            return $proSelectList[i]['PRO_NAME']
                    }
                    return item.PRO_NAME;
                }
            }, {
                display : '<spring:message code="hrms.workingDescription"/>',
                name : 'WORK_CONTENT',
                width : 350,
                align : 'left',
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="hrms.workingHours"/>',
                name : 'WORK_HOUR',
                width : 120,
                align : 'right',
                editor : {
                    type : 'float'
                },
                totalSummary : {
                    type : 'sum'
                }
            }, {
                display : '<spring:message code="hrms.remarks"/>',
                name : 'REMARK',
                width : 160,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="hrms.confirmationActive"/>',
                name : 'CON_STATUS',
                width : 100
            } ],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            url : "/ess/viewApp/getWorkingHoursInfo?EMPID=${basicInfo.EMPID}&ACTIVITY=4",
            width : '99.6%',
            height : '100%',
            onDblClickRow : function(rowdata, rowindex, rowDomElement) {
                spf_delete(MyCheckNull(rowdata.NO));
            }
        });
    }
    //项目信息
    function spf_pro_initGrid() {
        $pro_grid = $("#proInfo").ligerGrid({
            checkbox : false,
            columns : [ {
                display : '',
                name : 'PRO_NO',
                width : 10,
                hide : 1
            }, {
                display : '<spring:message code="hrms.type"/>',
                name : 'TYPE_NAME',
                width : 120
            }, {
                display : '<spring:message code="hrms.attItemName"/>',
                name : 'PRO_NAME_NAME',
                align : 'left',
                width : 120
            },
            //{ display: '<spring:message code="hrms.module"/>', name: 'PRO_MODULE', width: 120},
            {
                display : '<spring:message code="hrms.projectQuantityHour"/>',
                name : 'QUANTITY_M',
                width : 170
            }, {
                display : '<spring:message code="hrms.startDate"/>',
                name : 'START_DATE',
                width : 120
            }, {
                display : '<spring:message code="hrms.endDate"/>',
                name : 'END_DATE',
                width : 120
            }, {
                display : '<spring:message code="hrms.description"/>',
                name : 'DESCRIPTION',
                align : 'left',
                width : 160,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            }, {
                display : '<spring:message code="hrms.remarks"/>',
                name : 'REMARK',
                align : 'left',
                width : 140,
                editor : {
                    type : 'textarea',
                    height : 100
                }
            } ],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            url : "/ess/viewApp/getProInfo?ESS_PRO_EMP=1",
            width : '99.6%',
            height : '118px',
            onDblClickRow : function(rowdata, rowindex, rowDomElement) {
                spf_showWhCalendarInfo();
            }
        });
    }
    function f_ChildWindowClose() {
        $workingHours_grid.loadData(true); //加载数据
        $pro_grid.loadData(true); //加载数据
    }

    function spf_add() {
        //$workingHours_grid.addRow();
        var rows = $workingHours_grid.getData();
        //alert(JSON2.stringify(rows));
        //alert(rows.length);
        if (rows.length > 0) {
            spf_application_auto();
        }
        if (!rows || rows.length == 0) {
            $workingHours_grid.addRow();
        } else {
            $(rows).each(function(index) {
                var row = $workingHours_grid.getRow(0);
                if (index == 0) {
                    $workingHours_grid.addRow({
                        PRO_ID : this.PRO_ID,
                        START_DATE : this.START_DATE
                    }, row, true);
                }
            });
        }
    }
    function spf_delete(no) {
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>', '<spring:message code="hrms.warning"/>', function(yes) {
            if (yes) {

                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/ess/viewApp/delWorkingHoursInfo', [ {
                    name : 'NO',
                    value : no
                }, {
                    name : 'ACTIVITY',
                    value : '0'
                } ], function(result) {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y") {
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                            $pro_grid.loadData(true);//加载数据
                            $workingHours_grid.loadData(true); //加载数据
                        });
                    } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
    }

    function spf_application() {
        var jsonData = '[';

        var rows = $workingHours_grid.getData();

        //alert(JSON2.stringify(rows));

        if (!rows || rows.length == 0) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        $(rows).each(function(index, row) {
            if (this.__status != null && (this.__status == 'add' || this.__status == 'update')) {

                if (this.START_DATE == null || this.START_DATE == 'undefined') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.date"/>' + ". " + '<spring:message code="input.required"/>');
                    return;
                }
                if (this.TYPE_CODE == null || this.TYPE_CODE == 'undefined') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.type"/>' + ". " + '<spring:message code="input.required"/>');
                    return;
                }
                if (this.PRO_ID == null || this.PRO_ID == 'undefined') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.attItemName"/>' + ". " + '<spring:message code="input.required"/>');
                    return;
                }
                if (this.WORK_CONTENT == null || this.WORK_CONTENT == 'undefined') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingDescription"/>' + ". " + '<spring:message code="input.required"/>');
                    return;
                }
                if (this.WORK_HOUR == null || this.WORK_HOUR == 'undefined') {
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.workingHours"/>' + ". " + '<spring:message code="input.required"/>');
                    return;
                } else {
                    if (jsonData.length > 1) {
                        jsonData += ',{';
                    } else {
                        jsonData += '{';
                    }
                    jsonData += ' "__status": "' + this.__status + '", ';
                    jsonData += ' "WH_NO": "' + this.NO + '", ';
                    jsonData += ' "PRO_NO": "' + this.PRO_ID + '", ';
                    jsonData += ' "WORK_HOUR": "' + this.WORK_HOUR + '", ';
                    jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ';
                    jsonData += ' "WORK_CONTENT": "' + this.WORK_CONTENT + '",';
                    jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"';
                    jsonData += '}';
                }
            }
        });

        jsonData += ']';
        //alert(jsonData);
        if (jsonData.length == 2) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>');
            return;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/ess/infoApp/saveWorkingHoursInfo", [ {
            name : 'jsonData',
            value : jsonData
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>', '<spring:message code="hrms.warning"/>', function() {
                    $pro_grid.loadData(true);//加载数据
                    $workingHours_grid.loadData(true); //加载数据
                });
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                $pro_grid.loadData(true);//加载数据
                $workingHours_grid.loadData(true); //加载数据
            }
        });
    }
    function spf_application_auto() {
        var jsonData = '[';

        var rows = $workingHours_grid.getData();

        if (!rows || rows.length == 0) {
            return;
        }
        $(rows).each(function(index, row) {
            if (this.__status != null && this.__status == 'add' || this.__status == 'update') {
                if (jsonData.length > 1) {
                    jsonData += ',{';
                } else {
                    jsonData += '{';
                }
                jsonData += ' "__status": "' + this.__status + '", ';
                jsonData += ' "WH_NO": "' + this.NO + '", ';
                jsonData += ' "PRO_NO": "' + this.PRO_ID + '", ';
                jsonData += ' "WORK_HOUR": "' + this.WORK_HOUR + '", ';
                jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ';
                jsonData += ' "WORK_CONTENT": "' + this.WORK_CONTENT + '",';
                jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"';
                jsonData += '}';
            }
        });

        jsonData += ']';
        if (jsonData.length == 2) {
            return;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
        $.post("/ess/infoApp/saveWorkingHoursInfo", [ {
            name : 'jsonData',
            value : jsonData
        } ], function(result) {
            $.ligerDialog.closeWaitting();
            if (result == "Y") {
                $pro_grid.loadData(true);//加载数据
                $workingHours_grid.loadData(true); //加载数据
            } else {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                $pro_grid.loadData(true);//加载数据
                $workingHours_grid.loadData(true); //加载数据
            }
        });
    }
    // function spf_show()
    // {
    //  $dialog = $.ligerWindow.show({isDrag: true,
    //   title: '<spring:message code="hrms.projectManagement"/>',
    //          width: 900 ,
    //          height: 400 ,
    //          left:120,top:90,
    //     url: '/ess/infoApp/viewProInfo?EMPID=${basicInfo.EMPID}'
    //      });
    // }
    function spf_showWhCalendarInfo() {
        $dialog = $.ligerWindow.show({
            isDrag : false,
            title : '<spring:message code="hrms.workingHoursCalendar"/>',
            width : 800,
            height : 480,
            left : 80,
            top : 5,
            url : '/ess/infoApp/viewWhCalendarInfo'
        });
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
<body style="padding: 2px" onload="spf_showWhCalendarInfo();">
    <div id="layout1">
        <div position="top">
            <table width="99.6%" cellpadding="1" cellspacing="1" style="height: 32px; font-size: 12px;">
                <tr>
                    <td width="30%" align="left" style="font-weight: bold;">&nbsp;&nbsp;&nbsp;<spring:message code="hrms.projectInfo" />
                    </td>
                    <td width="5%" align="right">&nbsp;</td>
                    <td align="right">
                        <%--
                        <c:if test="${isWhManager == 'true' }">
                            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;background-image: url('/resources/images/button/button.gif');" onclick="spf_show()"><spring:message code="hrms.projectManagement"/></a>
                        </c:if>
                        --%> <input type="hidden" id="EMPID" name="EMPID" value="${basicInfo.EMPID }"> <a href="/ess/infoApp/viewWhAppB?"+"<c:out value="Math.random()"/>">换回新版</a> <SipingSoft:button /> <a
                        class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px; background-image: url('/resources/images/button/button.gif');" onclick="spf_application()"><spring:message
                                code="submit" /></a>
                    </td>
                </tr>
            </table>
            <div id="proInfo"></div>
        </div>
        <div position="center" title="<spring:message code="hrms.workingHoursApplication"/>">
            <div id="workingHoursInfo"></div>
        </div>
    </div>
</body>
</html>
