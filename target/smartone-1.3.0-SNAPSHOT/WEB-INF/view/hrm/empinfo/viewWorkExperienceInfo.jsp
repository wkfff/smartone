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
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid;
    var $eduGrid;
    var $traGrid;
    var $worGrid;
    var $dialog;
    var $Flag = "EDU";
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
        $("#navtab1").ligerTab({
            onAfterSelectTabItem : function(tabid) {
                if (tabid == "tabitem1") {
                    $Flag = "EDU";
                    f_education_initGrid();
                    $grid = $eduGrid;
                }
                if (tabid == "tabitem2") {
                    $Flag = "TRA";
                    f_train_initGrid();
                    $grid = $traGrid;
                }
                if (tabid == "tabitem3") {
                    $Flag = "WOR";
                    f_workExp_initGrid();
                    $grid = $worGrid;
                }
            }
        });
        f_education_initGrid();
        $grid = $eduGrid;
    });
    //获取教育信息
    function f_education_initGrid() {
        $eduGrid = $("#educationInfo").ligerGrid({
            checkbox : false,
            columns : [ {
                display : '',
                name : 'EDUC_NO',
                width : 10,
                hide : 1
            }, {
                display : '<spring:message code="hrms.startDate"/>',
                name : 'START_DATE',
                width : 160
            }, {
                display : '<spring:message code="hrms.endDate"/>',
                name : 'END_DATE',
                width : 160
            }, {
                display : '<spring:message code="hrms.institutionName"/>',
                name : 'INSTITUTION_NAME',
                width : 130
            }, {
                display : '<spring:message code="hrms.major"/>',
                name : 'MAJOR_NAME',
                width : 120
            }, {
                display : '<spring:message code="hrms.eduHis"/>',
                name : 'EDU_HIS_NAME',
                width : 110
            }, {
                display : '<spring:message code="hrms.degree"/>',
                name : 'DEGREE_NAME',
                width : 120
            }, {
                display : '<spring:message code="hrms.courseContent"/>',
                name : 'CONTENT',
                width : 110
            }, {
                display : '<spring:message code="hrms.address"/>',
                name : 'ADDRESS',
                width : 110
            }, {
                display : '<spring:message code="hrms.remarks"/>',
                name : 'REMARK',
                width : 110
            } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/hrm/empinfo/getEduInfoList?EMPID=${basicInfo.EMPID }",
            pageSize : 5,
            pageSizeOptions : [ 5, 4, 3, 2, 1 ],
            heightDiff : 0,
            width : '99.6%',
            height : '100%'
        });
    }
    //获取培训信息
    function f_train_initGrid() {
        $traGrid = $("#trainingInfo").ligerGrid({
            checkbox : false,
            columns : [
                { display: '<spring:message code="hrms.courseName"/>', name: 'COURSE_NAME', width: 90,frozen:true} ,
                { display: '<spring:message code="hrms.trainingDate"/>', name: 'START_DATE', width: 120}, 
                { display: '<spring:message code="hrms.classHour"/>', name: 'CLASS_HOUR', width: 70},  
                { display: '<spring:message code="hrms.fraction"/>', name: 'MARK', width: 70},
                { display: '<spring:message code="hrms.courseContent"/>', name: 'COURSE_CONTENT', width: 120, editor:{type:'textarea',height:100}},
                { display: '<spring:message code="hrms.teacher"/>', name: 'TEACHER', width: 120},
                { display: '<spring:message code="hrms.teachingMethods"/>', name: 'TEACHING_METHODS', width: 120},
                { display: '<spring:message code="hrms.evaluationMethods"/>', name: 'EVALUATION_METHODS', width: 120},
                { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 120 , editor:{type:'textarea',height:100}}],
            enabledEdit : true,
            usePager : false,
            rownumbers : true,
            url : "/hrm/empinfo/getTrainingInfoList?EMPID=${basicInfo.EMPID }",
            pageSize : 5,
            pageSizeOptions : [ 5, 4, 3, 2, 1 ],
            heightDiff : 0,
            width : '99.6%',
            height : '100%'
        });
    }
    //获取工作经历信息
    function f_workExp_initGrid() {
        $worGrid = $("#workExperienceInfo")
                .ligerGrid(
                        {
                            checkbox : false,
                            columns : [
                                    {
                                        display : '<spring:message code="hrms.startDate"/>',
                                        name : 'START_DATE',
                                        width : 160
                                    },
                                    {
                                        display : '<spring:message code="hrms.endDate"/>',
                                        name : 'END_DATE',
                                        width : 160
                                    },
                                    {
                                        display : '<spring:message code="hrms.workUnit"/>',
                                        name : 'CPNY_NAME',
                                        width : 130
                                    },
                                    {
                                        display : '<spring:message code="hrms.workDept"/>',
                                        name : 'DEPT_NAME',
                                        width : 110
                                    },
                                    {
                                        display : '<spring:message code="hrms.workingDescription"/>',
                                        name : 'WORK_CONTENT',
                                        width : 160
                                    },
                                    {
                                        display : '<spring:message code="hrms.position"/>',
                                        name : 'POSITION',
                                        width : 110
                                    },
                                    {
                                        display : '<spring:message code="hrms.leaveSubject"/>',
                                        name : 'LEAVE_REASON',
                                        width : 210
                                    } ],
                            enabledEdit : false,
                            usePager : false,
                            rownumbers : true,
                            url : "/hrm/empinfo/getWorkExperienceInfoList?EMPID=${basicInfo.EMPID }",
                            pageSize : 5,
                            pageSizeOptions : [ 5, 4, 3, 2, 1 ],
                            heightDiff : 0,
                            width : '99.6%',
                            height : '100%'
                        });
    }

    function f_ChildWindowClose() {
        $grid.loadData(true); //加载数据
        $dialog.close();
    }

    function spf_add() {
        if ($Flag == "EDU") {
            $dialog = $.ligerDialog.open({
                isDrag : false,
                showMax : false,
                showMin : false,
                title : '<spring:message code="hrms.add"/>',
                width : 800,
                height : 400,
                name : 'addEduDialog' + Math.random(),
                url : '/hrm/empinfo/addEduInfo?EMPID=${basicInfo.EMPID}'
            });
        } else if ($Flag == "TRA") {
            $dialog = $.ligerDialog.open({
                isDrag : false,
                showMax : false,
                showMin : false,
                title : '<spring:message code="hrms.add"/>',
                width : 800,
                height : 400,
                name : 'addTraDialog' + Math.random(),
                url : '/hrm/empinfo/addTrainingInfo?EMPID=${basicInfo.EMPID}'
            });
        } else if ($Flag == "WOR") {
            $dialog = $.ligerDialog.open({
                    isDrag : false,
                    showMax : false,
                    showMin : false,
                    title : '<spring:message code="hrms.add"/>',
                    width : 800,
                    height : 400,
                    name : 'addWorDialog' + Math.random(),
                    url : '/hrm/empinfo/addWorkExperienceInfo?EMPID=${basicInfo.EMPID}'
                });
        }
    }

    function spf_update() {
        var rows = $grid.getSelectedRow();
        if (!rows || rows.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>',
                    '<spring:message code="hrms.chooseLine"/>');
            return;
        }
        if ($Flag == "EDU") {
            $dialog = $.ligerDialog.open({
                isDrag : false,
                title : '<spring:message code="hrms.update"/>',
                width : 800,
                height : 400,
                url : '/hrm/empinfo/updateEduInfo?EDUC_NO=' + rows.EDUC_NO
            });
        } else if ($Flag == "TRA") {
            $dialog = $.ligerDialog.open({
                isDrag : false,
                title : '<spring:message code="hrms.update"/>',
                width : 800,
                height : 400,
                url : '/hrm/empinfo/updateTrainingInfo?TRAIN_OUT_NO='
                        + rows.TRAIN_OUT_NO
            });
        } else if ($Flag == "WOR") {
            $dialog = $.ligerDialog.open({
                isDrag : false,
                title : '<spring:message code="hrms.update"/>',
                width : 800,
                height : 400,
                url : '/hrm/empinfo/updateWorkExperienceInfo?WORK_EXPER_NO='
                    + rows.WORK_EXPER_NO
            });
        }
    }

    function spf_delete() {
        $.ligerDialog
                .confirm(
                        '<spring:message code="hrms.whetherDelete"/>',
                        '<spring:message code="hrms.warning"/>',
                        function(yes) {
                            if (yes) {
                                var rows = $grid.getSelectedRow();
                                ;

                                if (!rows || rows.length == 0) {
                                    $.ligerMessageBox
                                            .error(
                                                    '<spring:message code="hrms.warning"/>',
                                                    '<spring:message code="hrms.chooseLine"/>');
                                    return;
                                }
                                $.ligerDialog
                                        .waitting('<spring:message code="hrms.deleting"/>');

                                if ($Flag == "EDU") {
                                    $
                                            .post(
                                                    "/hrm/empinfo/deleteEduInfo",
                                                    [ {
                                                        name : 'EDUC_NO',
                                                        value : rows.EDUC_NO
                                                    } ],
                                                    function(result) {
                                                        $.ligerDialog
                                                                .closeWaitting();
                                                        if (result == "Y") {
                                                            $.ligerDialog
                                                                    .success(
                                                                            '<spring:message code="hrms.deleteSuccess"/>',
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            function() {
                                                                                $grid
                                                                                        .loadData(true); //加载数据   
                                                                            });
                                                        } else {
                                                            $.ligerMessageBox
                                                                    .error(
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            result);
                                                        }
                                                    });
                                } else if ($Flag == "TRA") {
                                    $
                                            .post(
                                                    "/hrm/empinfo/deleteTrainingInfo",
                                                    [ {
                                                        name : 'TRAIN_OUT_NO',
                                                        value : rows.TRAIN_OUT_NO
                                                    } ],
                                                    function(result) {
                                                        $.ligerDialog
                                                                .closeWaitting();
                                                        if (result == "Y") {
                                                            $.ligerDialog
                                                                    .success(
                                                                            '<spring:message code="hrms.deleteSuccess"/>',
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            function() {
                                                                                $grid
                                                                                        .loadData(true); //加载数据   
                                                                            });
                                                        } else {
                                                            $.ligerMessageBox
                                                                    .error(
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            result);
                                                        }
                                                    });
                                } else if ($Flag == "WOR") {
                                    $
                                            .post(
                                                    "/hrm/empinfo/deleteWorkExperienceInfo",
                                                    [ {
                                                        name : 'WORK_EXPER_NO',
                                                        value : rows.WORK_EXPER_NO
                                                    } ],
                                                    function(result) {
                                                        $.ligerDialog
                                                                .closeWaitting();
                                                        if (result == "Y") {
                                                            $.ligerDialog
                                                                    .success(
                                                                            '<spring:message code="hrms.deleteSuccess"/>',
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            function() {
                                                                                $grid
                                                                                        .loadData(true); //加载数据   
                                                                            });
                                                        } else {
                                                            $.ligerMessageBox
                                                                    .error(
                                                                            '<spring:message code="hrms.warning"/>',
                                                                            result);
                                                        }
                                                    });
                                }
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
                <%@include file="viewBasicInfo.jsp"%>
                <br>
                <table width="99.5%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                code="hrms.trainingInfo" /></td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right"><SipingSoft:button /></td>
                    </tr>
                </table>
                <table width="100%" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-c" colspan="4">
                            <div id="navtab1"
                                style="width: 100%; overflow: hidden; border: 1px solid #A3C0E8;">
                                <div title='<spring:message code="hrms.educationInfo"/>'>
                                    <div id="educationInfo"></div>
                                </div>
                                <div title='<spring:message code="hrms.trainingInfo"/>'>
                                    <div id="trainingInfo"></div>
                                </div>
                                <div title='<spring:message code="hrms.workExperience"/>'>
                                    <div id="workExperienceInfo"></div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</body>
</html>