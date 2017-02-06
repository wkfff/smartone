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
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog ;
    var $birthday_grid ;
    var $exp_grid ;
    var $exp_con_grid ;
    var $no_con_grid ;
    var $endProbation_grid ;
    var $dispatch_grid ;
    var $eduOutside_grid ;
    var $exp_cer_grid;
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
    $(function () {
        //布局
         $("#layout12").ligerLayout({
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
          });
         setTimeout('showDetail()',2000);
    });
    function showDetail(){
        if(${paraMap.type == 'BD'}){
               spf_birthday_initGrid();
        }if(${paraMap.type == 'ME'}){
            spf_exp_initGrid();
        }if(${paraMap.type == 'EC'}){
            spf_exp_con_initGrid();
        }if(${paraMap.type == 'NC'}){
            spf_no_con_initGrid();
        }if(${paraMap.type == 'EP'}){
            spf_endProbation_initGrid();
        }if(${paraMap.type == 'DI'}){
            spf_dispatch_initGrid();
        }if(${paraMap.type == 'TR'}){
            spf_eduOutside_initGrid();
        }if(${paraMap.type == 'ECF'}) {
            spf_exp_cer_initGrid();
        }
    }

    function spf_birthday_initGrid() {
       $birthday_grid = $("#birthdayInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.birthDate"/>', name: 'BIRTHDAY', width: 120}
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getBirthday&cntType=getBirthdayCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_exp_initGrid() {
       $exp_grid = $("#expInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.ccommType"/>', name: 'TRANS_CODE_NAME', width: 120},
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.effectDate"/>', name: 'START_DATE', width: 120}
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getMonthExperience&cntType=getMonthExperienceCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_exp_con_initGrid() {
       $exp_con_grid = $("#expContractInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.endDate"/>', name: 'END_CONTRACT_DATE', width: 120},
               { display: '<spring:message code="countdownDays"/>', name: 'DAYS', width: 120}
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getExpiredContract&cntType=getExpiredContractCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_no_con_initGrid() {
        $no_con_grid = $("#noContractInfo").ligerGrid({
            checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.hireDate"/>', name: 'JOIN_DATE', width: 120}
               ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getNotExistContract&cntType=getNotExistContractCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_endProbation_initGrid() {
       $endProbation_grid = $("#endProbationInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.endProbationDate"/>', name: 'END_PROBATION_DATE', width: 120}
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getExpiredProbation&cntType=getExpiredProbationCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_dispatch_initGrid() {
       $dispatch_grid = $("#dispatchInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.dispatchType"/>', name: 'DIS_TYPE_NAME', width: 120},
               { display: '<spring:message code="hrms.position"/>', name: 'POSITION_NAME', width: 120} ,
               { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_NAME', width: 120} ,
               { display: '<spring:message code="hrms.dispatchOffice"/>', name: 'CONTENTS', minWidth: 120 },
               { display: '<spring:message code="hrms.workingDescription"/>', name: 'DIS_TARGET', minWidth: 120 }
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getDispatchInfo&cntType=getDispatchInfoCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_exp_cer_initGrid() {
       $exp_cer_grid = $("#expCertificateInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120} ,
               { display: '<spring:message code="hrms.certificateName"/>', name: 'QUAL_CARD_NAME', width: 120} ,
               { display: '<spring:message code="hrms.endDate"/>', name: 'END_QUAL_DATE', width: 120},
               { display: '<spring:message code="hrms.annualDate"/>', name: 'ANNUAL_DATE', width: 120}
          ],
            enabledEdit: false,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getExpiredCertification&cntType=getExpiredCertificationCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
        });
    }

    function spf_eduOutside_initGrid() {
       $eduOutside_grid = $("#eduOutsideInfo").ligerGrid({
           checkbox: false,
            columns: [
               { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90,frozen:true},
               { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
               { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90,frozen:true} ,
               { display: '<spring:message code="hrms.courseName"/>', name: 'COURSE_NAME', width: 90,frozen:true} ,
               { display: '<spring:message code="hrms.trainingDate"/>', name: 'START_DATE', width: 120},
               { display: '<spring:message code="hrms.classHour"/>', name: 'CLASS_HOUR', width: 70},
               { display: '<spring:message code="hrms.fraction"/>', name: 'MARK', width: 70},
               { display: '<spring:message code="hrms.courseContent"/>', name: 'COURSE_CONTENT', width: 120, editor:{type:'textarea',height:100}},
               { display: '<spring:message code="hrms.teacher"/>', name: 'TEACHER', width: 120},
               { display: '<spring:message code="hrms.teachingMethods"/>', name: 'TEACHING_METHODS', width: 120},
               { display: '<spring:message code="hrms.evaluationMethods"/>', name: 'EVALUATION_METHODS', width: 120},
               { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 120, editor:{type:'textarea',height:100}}
          ],
            enabledEdit: true,usePager: true,rownumbers: true,
            url: "/myhome/getapp?listType=getEduOutside&cntType=getEduOutsideCnt",
            pageSize: 10,
            pageSizeOptions: [10,20,30,40,50],
            width: '99.9%', height: '100%'
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
            <c:choose>
                <c:when test="${paraMap.type == 'BD'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="birthdaylist" /></td>
                            <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                    </table>
                    <table width="99.5%" cellpadding="1" cellspacing="1" style="height: 25px; font-size: 12px;">
                        <tr>
                            <td align="left" colspan="4">
                                <div id="birthdayInfo"></div>
                            </td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${paraMap.type == 'ME'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="monthExperience" /></td>
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
                </c:when>
                <c:when test="${paraMap.type == 'EC'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" /></td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="expiredContract" /></td>
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
                </c:when>
                <c:when test="${paraMap.type == 'NC'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" /></td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="notExistContract" /></td>
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
                </c:when>
                <c:when test="${paraMap.type == 'EP'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="expiredProbation" />
                            </td>
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
                </c:when>
                <c:when test="${paraMap.type == 'DI'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="dispatch" />
                            </td>
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
                </c:when>
                <c:when test="${paraMap.type == 'ECF'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="expiredCertificate" />
                            </td>
                            <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                            <td width="5%" align="right">&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                    </table>
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
                        <tr>
                            <td align="left" colspan="4">
                                <div id="expCertificateInfo"></div>
                            </td>
                        </tr>
                    </table>
                </c:when>
                <c:when test="${paraMap.type == 'TR'}">
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px; ">
                        <tr>
                            <td width="5%" align="center">
                                <img src="/resources/images/title/top_1.gif" />
                            </td>
                            <td width="25%" align="left" style="font-weight: bold;">
                                <spring:message code="hrms.trainingInfo" />
                            </td>
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
                </c:when>
                <c:otherwise>
            </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>