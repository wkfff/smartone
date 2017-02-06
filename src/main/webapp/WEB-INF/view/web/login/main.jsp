<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css" />
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
     // 初始调用
     $(function ()
     {
         //布局
          $("#layout1").ligerLayout({
                 allowLeftResize: false,      //是否允许 左边可以调整大小
                 allowRightResize: false,     //是否允许 右边可以调整大小
                 allowTopResize: false,      //是否允许 头部可以调整大小
                 allowBottomResize: false     //是否允许 底部可以调整大小
          });
          /* $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid)
              {
                   if(tabid=="tabitem1"){
                       //已经分组人员
                   }
                   if(tabid=="tabitem2"){
                       //已经分组人员
                       spf_exp_con_initGrid();
                       spf_exp_initGrid();
                       spf_endProbation_initGrid();
                       spf_exp_cer_initGrid();
                       spf_eduOutside_initGrid();
                   }
              }
          }); */
          //f_tip();
     });
     function f_tip() {
         $.ligerDialog.tip({  title: '提示信息',content:'您已经登录' });
     }
     function spf_firstLogin()
        {
             $.post('/login/checkFirstLogin',{"ADMINID":''},function(back){
                 if(back == 'Y'){
                     $dialog = $.ligerDialog.open({isDrag: true,showMax: false,showMin: false,
                            title: '<spring:message code="change.password"/>',
                            width: 450 ,
                            height: 320 ,
                            url: '/ess/password/changePassword?MENU_CODE=ess0401'
                      });
                 }
            });
        }

     function spf_showWaringInfo(){
         setTimeout('spf_birthday_initGrid()',2000);
         setTimeout('spf_exp_initGrid()',3000);
         if(${mapAppInfo.isContract == true }){
             setTimeout('spf_exp_con_initGrid()',4000);
             setTimeout('spf_no_con_initGrid()',5000);
         }
         setTimeout('spf_endProbation_initGrid()',6000);
         setTimeout('spf_dispatch_initGrid()',7000);
         setTimeout('spf_eduOutside_initGrid()',8000);
     }
     //**************************************************************************
     function spf_birthday_initGrid()
     {
        $birthday_grid = $("#birthdayInfo").ligerGrid({
            checkbox: false,
             columns: [
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 100} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.birthDate"/>', name: 'BIRTHDAY', width: 90}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getBirthday&cntType=getBirthdayCnt",
             parms: [
                    { name: 'page', value: 1},
                    { name: 'pagesize', value: 5}
                      ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_exp_initGrid()
     {
        $exp_grid = $("#expInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.ccommType"/>', name: 'TRANS_CODE_NAME', width: 120,frozen:true},
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true} ,
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.effectDate"/>', name: 'START_DATE', width: 120}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getMonthExperience&cntType=getMonthExperienceCnt",
             parms: [
                    { name: 'page', value: 1},
                    { name: 'pagesize', value: 5}
                      ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_exp_con_initGrid()
     {
        $exp_con_grid = $("#expContractInfo").ligerGrid({
            checkbox: false,
             columns: [
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.endDate"/>', name: 'END_CONTRACT_DATE', width: 120},
                { display: '<spring:message code="countdownDays"/>', name: 'DAYS', width: 90}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getExpiredContract&cntType=getExpiredContractCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_no_con_initGrid()
     {
        $no_con_grid = $("#noContractInfo").ligerGrid({
            checkbox: false,
             columns: [
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 100,frozen:true} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.hireDate"/>', name: 'JOIN_DATE', width: 120}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getNotExistContract&cntType=getNotExistContractCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_endProbation_initGrid()
     {
        $endProbation_grid = $("#endProbationInfo").ligerGrid({
            checkbox: false,
             columns: [
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90},
                { display: '<spring:message code="hrms.endProbationDate"/>', name: 'END_PROBATION_DATE', width: 120}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getExpiredProbation&cntType=getExpiredProbationCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_dispatch_initGrid()
     {
        $dispatch_grid = $("#dispatchInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.dispatchType"/>', name: 'DIS_TYPE_NAME', width: 120,frozen:true},
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 100,frozen:true} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.dispatchOffice"/>', name: 'CONTENTS', minWidth: 120 },
                { display: '<spring:message code="hrms.workingDescription"/>', name: 'DIS_TARGET', minWidth: 120 }
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getDispatchInfo&cntType=getDispatchInfoCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_exp_cer_initGrid()
     {
        $exp_cer_grid = $("#expCertificateInfo").ligerGrid({
            checkbox: false,
             columns: [
                //{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 80,frozen:true},
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.certificateName"/>', name: 'QUAL_CARD_NAME', width: 120} ,
                { display: '<spring:message code="hrms.endDate"/>', name: 'END_QUAL_DATE', width: 120},
                { display: '<spring:message code="hrms.annualDate"/>', name: 'ANNUAL_DATE', width: 120}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getExpiredCertification&cntType=getExpiredCertificationCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }
     function spf_eduOutside_initGrid()
     {
        $eduOutside_grid = $("#eduOutsideInfo").ligerGrid({
            checkbox: false,
             columns: [
                { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},
                { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120} ,
                { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 90} ,
                { display: '<spring:message code="hrms.courseName"/>', name: 'COURSE_NAME', width: 90} ,
                { display: '<spring:message code="hrms.trainingDate"/>', name: 'START_DATE', width: 120},
                { display: '<spring:message code="hrms.classHour"/>', name: 'CLASS_HOUR', width: 70},
                { display: '<spring:message code="hrms.fraction"/>', name: 'MARK', width: 70}
           ],
             enabledEdit: false,usePager: false,rownumbers: true,
             url: "/myhome/getapp?listType=getEduOutside&cntType=getEduOutsideCnt",
             parms: [
                        { name: 'page', value: 1},
                        { name: 'pagesize', value: 5}
                       ],
             pageSize: 5,
             pageSizeOptions: [5,10,15,20,25],
             width: '99.7%'
         });
     }

      function spf_showPage(type)
      {
          $dialog = $.ligerWindow.show({isDrag: true,
                title: '<spring:message code="hrms.details"/>',
                width: 800 ,
                height: 360 ,
                left:120,top:80,
                url: '/login/showWarningInfo?type='+type
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
<!-- <body style="padding:0px" onload="spf_firstLogin()"> -->
<body style="padding: 2px">
    <div id="layout1">
        <div align="left">
            <div id="navtab1">
                <div title='<spring:message code="homepage.one"/>'>
                    <%-- <%@include file="shortcut.jsp"%> --%>
                    <%@include file="viewBasicInfo.jsp"%>
                    <%@include file="viewAppInfo.jsp"%>
                </div>
                <%-- <div title='<spring:message code="homepage.two"/>'>
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="49.525%" align="center" valign="top">
                                <table width="99.5%" cellpadding="1" cellspacing="1"
                                    style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('EC');">
                                        <td width="5%" align="center"><img
                                            src="/resources/images/title/top_1.gif" /></td>
                                        <td width="25%" align="left" style="font-weight: bold;">
                                            <spring:message code="expiredContract" />
                                        </td>
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
                            <td width="49.525%" align="center" valign="top">
                                <table width="99.5%" cellpadding="1" cellspacing="1"
                                    style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('ME');">
                                        <td width="5%" align="center"><img
                                            src="/resources/images/title/top_1.gif" /></td>
                                        <td width="25%" align="left" style="font-weight: bold;">
                                            <spring:message code="monthExperience" />
                                        </td>
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
                    <c:if test="${mapAppInfo.isContract == true }">
                        <table width="99.5%" cellpadding="1" cellspacing="1"
                            style="height: 25px; font-size: 12px;">
                            <tr>
                                <td width="49.525%" align="center" valign="top">
                                    <table width="99.5%" cellpadding="1" cellspacing="1"
                                        style="height: 25px; font-size: 12px;">
                                        <tr style="cursor: pointer;" onclick="spf_showPage('EC');">
                                            <td width="5%" align="center"><img
                                                src="/resources/images/title/top_1.gif" /></td>
                                            <td width="25%" align="left" style="font-weight: bold;">
                                                <spring:message code="expiredContract" />
                                            </td>
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
                                <td width="49.525%" align="center" valign="top">
                                    <table width="99.5%" cellpadding="1" cellspacing="1"
                                        style="height: 25px; font-size: 12px;">
                                        <tr style="cursor: pointer;" onclick="spf_showPage('NC');">
                                            <td width="5%" align="center"><img
                                                src="/resources/images/title/top_1.gif" /></td>
                                            <td width="25%" align="left" style="font-weight: bold;">
                                                <spring:message code="notExistContract" />
                                            </td>
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
                    </c:if>
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
                        <tr>
                            <td width="49.525%" align="center" valign="top">
                                <table width="99.5%" cellpadding="1" cellspacing="1"
                                    style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('EP');">
                                        <td width="5%" align="center"><img
                                            src="/resources/images/title/top_1.gif" /></td>
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
                            </td>
                            <td width="49.525%" align="center" valign="top">
                                <table width="99.5%" cellpadding="1" cellspacing="1"
                                    style="height: 25px; font-size: 12px;">
                                    <tr style="cursor: pointer;" onclick="spf_showPage('ECF');">
                                        <td width="5%" align="center"><img
                                            src="/resources/images/title/top_1.gif" /></td>
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
                            </td>
                        </tr>
                    </table>
                    <br />
                    <table width="99.5%" cellpadding="1" cellspacing="1"
                        style="height: 25px; font-size: 12px;">
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
                </div> --%>
                <!--
                    <div title='<spring:message code="homepage.three"/>'>
                        <div id="othersInfos"></div>
                    </div>
                -->
            </div>
        </div>
    </div>
</body>
</html>