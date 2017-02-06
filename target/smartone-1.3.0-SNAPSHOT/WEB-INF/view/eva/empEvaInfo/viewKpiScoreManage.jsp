<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head> 
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
        var $grid ;
        // 初始调用
        $(function (){
            //布局
            $("#layout1").ligerLayout({
                    topHeight: 90, 
                    allowLeftResize: false, //是否允许 左边可以调整大小
                    allowRightResize: false,    //是否允许 右边可以调整大小
                    allowTopResize: false,  //是否允许 头部可以调整大小
                    allowBottomResize: false    //是否允许 底部可以调整大小
                });
            f_initGrid();
        });

    function f_initGrid(){
        var paMonth = $("#year").val() + $("#month").val();
        $grid =$("#hrSearchEmp").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:80 },
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:100},
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:100},
                        { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:100},
                        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:90},
                        { display: '<spring:message code="eva.performanceScores"/>', name: 'SCORE', width:90}
                ],
            usePager: true, rownumbers: true,
            url: "/utility/empInfo/getHrSearchEmployeeList", pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
            parms: [
                    { name: 'PA_MONTH',value: paMonth}
            ],
            width: '99.6%', height: '100%',
            onDblClickRow:showScoreDetail
        });         
    }

function spf_search(){
    var paMonth = $("#year").val() + $("#month").val();
    $grid.setOptions({parms: [
                { name: 'keyWord', value: $("#keyWord").val()},
                { name: 'DEPTID', value: $("#DEPTID").val()},
                { name: 'PA_MONTH', value: paMonth}
                ],
        newPage: 1
    });
    $grid.loadData(true);
}

function showScoreDetail(){
    var row = $grid.getSelectedRow();
    if (!row || row.length == 0) { 
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        return ; 
    }
    $dialog = $.ligerWindow.show({isDrag: true,
        title: '<spring:message code="eva.assessmentScoreDetails"/>',
        width: 800 , 
        height: 500 , 
        left:120,top:90,
        url: '/eva/empEvaInfo/viewOneKpiScore?EMPID='+row.EMPID+"&month="+$("#month").val()
    }); 
}
function spf_insExcel(colums){
    var attMonth = $("#year").val() + $("#month").val() ;
    location.href='/eva/kpi/getScoreByExcel?PA_MONTH=' + attMonth+"&DEPTID="+$("#DEPTID").val();
    /* $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>'); */
}
</script>
<style type="text/css"> 
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{  width:99.8%;margin:0; padding:0;}
</style>
</head> 
<body style="padding:2px" >   
    <div id="layout1" > 
        <div position="top">
            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                <tr> 
                    <td class="l-table-edit-t" width="20%"><spring:message code="keyWord"/></td>
                    <td class="l-table-edit-c" width="30%">
                        <input type="text" name="keyWord" id="keyWord" />
                    </td>
                    <td class="l-table-edit-t" width="20%"><spring:message code="hrms.dept"/></td>
                    <td class="l-table-edit-c" width="30%">
                        <SipingSoft:deptTree name="DEPTID" limit="hr" onChange="spf_search()"/>
                    </td>
                </tr>
                <tr>
                    <td width="20%" class="l-table-edit-t"><spring:message code="eva.assessmentMonth"/></td>
                    <td width="80%" class="l-table-edit-c" colspan="3"><SipingSoft:date
                            yearName="year" monthName="month"
                            onChange="spf_search();" /></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit" >
                <tr>
                    <td align="left" height="30px">
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>
                        <a class="l-button"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_insExcel()"><spring:message code="hrms.excelExport"/></a>
                        <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="showScoreDetail()">
                        <spring:message code="process.view"/></a>
                    </td>
                </tr>
            </table>
        </div>
    <div position="center"  id="hrSearchEmp"></div>
</div>
</body>
</html>
