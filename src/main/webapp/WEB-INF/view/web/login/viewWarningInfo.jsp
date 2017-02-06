<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- JS -->
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog;
    var $birthday_grid;
    var $exp_grid;
    var $exp_con_grid;
    var $no_con_grid;
    var $endProbation_grid;
    var $dispatch_grid;
    var $eduOutside_grid;
    // 初始调用
    $(function() {
        //布局
        $("#layout12").ligerLayout({
            allowLeftResize : false, //是否允许 左边可以调整大小
            allowRightResize : false, //是否允许 右边可以调整大小
            allowTopResize : false, //是否允许 头部可以调整大小
            allowBottomResize : false //是否允许 底部可以调整大小
        });
        spf_birthday_initGrid();
        spf_exp_initGrid();
        spf_exp_con_initGrid();
        spf_no_con_initGrid();
        spf_endProbation_initGrid();
        spf_dispatch_initGrid();
        spf_eduOutside_initGrid();
    });
    function spf_showWaringInfo() {
        setTimeout('spf_birthday_initGrid()', 2000);
        setTimeout('spf_exp_initGrid()', 3000);
        setTimeout('spf_exp_con_initGrid()', 4000);
        setTimeout('spf_no_con_initGrid()', 5000);
        setTimeout('spf_endProbation_initGrid()', 6000);
        setTimeout('spf_dispatch_initGrid()', 7000);
        setTimeout('spf_eduOutside_initGrid()', 8000);
    }
    function spf_birthday_initGrid() {
        $birthday_grid = $("#birthdayInfo").ligerGrid({
            checkbox : false,
            columns : [ {
                display : '<spring:message code="hrms.empid"/>',
                name : 'EMPID',
                width : 80
            }, {
                display : '<spring:message code="hrms.name"/>',
                name : 'CHINESENAME',
                width : 90
            }, {
                display : '<spring:message code="hrms.dept"/>',
                name : 'DEPTNAME',
                width : 100
            }, {
                display : '<spring:message code="hrms.position"/>',
                name : 'POSITION_NAME',
                width : 90
            }, {
                display : '<spring:message code="hrms.postGrade"/>',
                name : 'POST_GRADE_NAME',
                width : 90
            }, {
                display : '<spring:message code="hrms.birthDate"/>',
                name : 'BIRTHDAY',
                width : 90
            } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getBirthday&cntType=getBirthdayCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_exp_initGrid() {
        $exp_grid = $("#expInfo").ligerGrid({
            checkbox : false,
            columns : [
                    {
                        display : '<spring:message code="hrms.ccommType"/>',
                        name : 'TRANS_CODE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.empid"/>',
                        name : 'EMPID',
                        width : 90
                    },
                    {
                        display : '<spring:message code="hrms.name"/>',
                        name : 'CHINESENAME',
                        width : 90
                    },
                    {
                        display : '<spring:message code="hrms.dept"/>',
                        name : 'DEPTNAME',
                        width : 100
                    },
                    {
                        display : '<spring:message code="hrms.position"/>',
                        name : 'POSITION_NAME',
                        width : 90
                    },
                    {
                        display : '<spring:message code="hrms.postGrade"/>',
                        name : 'POST_GRADE_NAME',
                        width : 90
                    },
                    {
                        display : '<spring:message code="hrms.effectDate"/>',
                        name : 'START_DATE',
                        width : 90
                    } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getMonthExperience&cntType=getMonthExperienceCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_exp_con_initGrid() {
        $exp_con_grid = $("#expContractInfo").ligerGrid({
                checkbox : false,
                columns : [
                        {
                            display : '<spring:message code="hrms.empid"/>',
                            name : 'EMPID',
                            width : 120
                        },
                        {
                            display : '<spring:message code="hrms.name"/>',
                            name : 'CHINESENAME',
                            width : 120
                        },
                        {
                            display : '<spring:message code="hrms.dept"/>',
                            name : 'DEPTNAME',
                            width : 120
                        },
                        {
                            display : '<spring:message code="hrms.position"/>',
                            name : 'POSITION_NAME',
                            width : 120
                        },
                        {
                            display : '<spring:message code="hrms.postGrade"/>',
                            name : 'POST_GRADE_NAME',
                            width : 120
                        },
                        {
                            display : '<spring:message code="hrms.endDate"/>',
                            name : 'END_CONTRACT_DATE',
                            width : 120
                        },
                        {
                            display : '<spring:message code="countdownDays"/>',
                            name : 'DAYS',
                            width : 120
                        } ],
                enabledEdit : false,
                usePager : false,
                rownumbers : true,
                url : "/myhome/getapp?listType=getExpiredContract&cntType=getExpiredContractCnt",
                parms : [ {
                    name : 'page',
                    value : 1
                }, {
                    name : 'pagesize',
                    value : 5
                } ],
                pageSize : 5,
                pageSizeOptions : [ 5, 10, 15, 20, 25 ],
                width : '99.7%'
            });
    }
    function spf_no_con_initGrid() {
        $no_con_grid = $("#noContractInfo").ligerGrid({
            checkbox : false,
            columns : [
                    {
                        display : '<spring:message code="hrms.empid"/>',
                        name : 'EMPID',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.name"/>',
                        name : 'CHINESENAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.dept"/>',
                        name : 'DEPTNAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.position"/>',
                        name : 'POSITION_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.postGrade"/>',
                        name : 'POST_GRADE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.hireDate"/>',
                        name : 'JOIN_DATE',
                        width : 120
                    } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getNotExistContract&cntType=getNotExistContractCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_endProbation_initGrid() {
        $endProbation_grid = $("#endProbationInfo").ligerGrid({
            checkbox : false,
            columns : [
                    {
                        display : '<spring:message code="hrms.empid"/>',
                        name : 'EMPID',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.name"/>',
                        name : 'CHINESENAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.dept"/>',
                        name : 'DEPTNAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.position"/>',
                        name : 'POSITION_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.postGrade"/>',
                        name : 'POST_GRADE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.endProbationDate"/>',
                        name : 'END_PROBATION_DATE',
                        width : 120
                    } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getExpiredProbation&cntType=getExpiredProbationCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_dispatch_initGrid() {
        $dispatch_grid = $("#dispatchInfo").ligerGrid({
            checkbox : false,
            columns : [
                    {
                        display : '<spring:message code="hrms.dispatchType"/>',
                        name : 'DIS_TYPE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.empid"/>',
                        name : 'EMPID',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.name"/>',
                        name : 'CHINESENAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.dept"/>',
                        name : 'DEPTNAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.position"/>',
                        name : 'POSITION_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.postGrade"/>',
                        name : 'POST_GRADE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.dispatchOffice"/>',
                        name : 'CONTENTS',
                        minWidth : 120
                    },
                    {
                        display : '<spring:message code="hrms.workingDescription"/>',
                        name : 'DIS_TARGET',
                        minWidth : 120
                    } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getDispatchInfo&cntType=getDispatchInfoCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_eduOutside_initGrid() {
        $eduOutside_grid = $("#eduOutsideInfo").ligerGrid({
            checkbox : false,
            columns : [
                    {
                        display : '<spring:message code="hrms.empid"/>',
                        name : 'EMPID',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.name"/>',
                        name : 'CHINESENAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.dept"/>',
                        name : 'DEPTNAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.position"/>',
                        name : 'POSITION_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.postGrade"/>',
                        name : 'POST_GRADE_NAME',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.startDate"/>',
                        name : 'START_DATE',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.endDate"/>',
                        name : 'END_DATE',
                        width : 120
                    },
                    {
                        display : '<spring:message code="hrms.description"/>',
                        name : 'DESCRIPTION',
                        width : 120
                    } ],
            enabledEdit : false,
            usePager : false,
            rownumbers : true,
            url : "/myhome/getapp?listType=getEduOutside&cntType=getEduOutsideCnt",
            parms : [ {
                name : 'page',
                value : 1
            }, {
                name : 'pagesize',
                value : 5
            } ],
            pageSize : 5,
            pageSizeOptions : [ 5, 10, 15, 20, 25 ],
            width : '99.7%'
        });
    }
    function spf_showPage(type) {
        $dialog = $.ligerWindow.show({
            isDrag : true,
            title : '<spring:message code="hrms.details"/>',
            width : 800,
            height : 360,
            left : 120,
            top : 80,
            url : '/login/showWarningInfo?type=' + type
        });
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout12 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout12">
        <div align="center">
            <br />
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('BD');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="birthdaylist" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="birthdayInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('ME');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="monthExperience" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="expInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('EC');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="expiredContract" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="expContractInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('NC');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="notExistContract" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="noContractInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('EP');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="expiredProbation" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="endProbationInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="49.525%" align="center">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px; ">
                            <tr style="cursor: pointer;" onclick="spf_showPage('DI');">
                                <td width="5%" align="center"><img
                                    src="/resources/images/title/top_1.gif" /></td>
                                <td width="25%" align="left" style="font-weight: bold;"><spring:message
                                        code="dispatch" /></td>
                                <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                                <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            </tr>
                        </table>
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td align="left" colspan="4">
                                    <div id="dispatchInfo"></div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px; ">
                <tr style="cursor: pointer;" onclick="spf_showPage('TR');">
                    <td width="5%" align="center"><img
                        src="/resources/images/title/top_1.gif" /></td>
                    <td width="25%" align="left" style="font-weight: bold;"><spring:message
                            code="hrms.trainingInfo" /></td>
                    <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                    <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                </tr>
            </table>
            <table width="99.5%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td align="left" colspan="4">
                        <div id="eduOutsideInfo"></div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>