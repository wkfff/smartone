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
            alert("aa");
            $("#layout1").ligerLayout({
                    topHeight: 60, 
                    allowLeftResize: false, //是否允许 左边可以调整大小
                    allowRightResize: false,    //是否允许 右边可以调整大小
                    allowTopResize: false,  //是否允许 头部可以调整大小
                    allowBottomResize: false    //是否允许 底部可以调整大小
                }
            );
            f_initGrid();
        });

    function f_initGrid(){
    $grid =$("#hrSearchEmp").ligerGrid({
                checkbox: true,
                columns: [
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:90 },
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:90},
                        { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:120},
                        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:90},
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:120}
                ], 
                usePager: true, rownumbers: true,
                url: "/utility/empInfo/getHrSearchEmployeeList", pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
                parms: [
                        { name: 'EVA_KPI_ID',value: "${paraMap.EVA_KPI_ID}"}
                ],
                width: '99.6%', height: '100%',
                onDblClickRow:send
            });
    }
            
    function spf_search(){
        $grid.setOptions({parms: [
                { name: 'keyWord', value: $("#keyWord").val()},
                { name: 'DEPTID', value: $("#DEPTID").val()},
                { name: 'EVA_KPI_ID',value: "${paraMap.EVA_KPI_ID}"}
                ],
        newPage: 1
    });
    $grid.loadData(true);
    }

function send(){        
    var data = $grid.getSelectedRow();
    parent.spf_initSelectEmpInfo(data) ;
}
function save_manager(){
    var jsonData = '[' ; 
    var rows = $grid.getCheckedRows(); 
    if (!rows || rows.length == 0) { 
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
         return ; 
    }
    $(rows).each(function (index, row){ 
         if (jsonData.length > 1){
            jsonData += ',{' ;
         }else{
            jsonData += '{' ;
         }
         jsonData += ' "EMPID": "' + this.EMPID + '", ' ;   
         jsonData += ' "EVA_KPI_ID": "' + "${paraMap.EVA_KPI_ID}" + '"' ;
         jsonData += '}' ;
    }); 
    jsonData += ']' ;  
    var jsonList = eval("(" + jsonData + ")");
    if(jsonData.length == 2){
        return ;
    } 
    if(jsonList.length == rows.length){ 
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/eva/kpi/addKpiManagerInfo",[ {
                name : 'jsonData',
                value : jsonData
            } ]
            , function (result)
            {
            $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        $grid.loadData(true); //加载数据 
                        parent.d_ChildWindowClose(); //加载数据
                    });
            }else{
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
            }
        });
    }
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
        <table width="100%" border="0" >
            <tr><td height="2"></td></tr>
            <tr>
            <td align="center" valign="middle"> 
                    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr> 
                            <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
                            <td class="l-table-edit-c">
                                <input type="text" name="keyWord" id="keyWord" />
                            </td>
                            <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
                            <td class="l-table-edit-c">
                                <SipingSoft:deptTree name="DEPTID" limit="hr" onChange="spf_search()"/>
                            </td> 
                        </tr> 
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
            <tr>
                <td align="left" height="30px">
                    <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>   
                    <a class="l-button"
                        style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                        onclick="save_manager()">保存</a>
                </td>
            </tr>
        </table>
    </div>
    <div position="center"  id="hrSearchEmp"></div>
</div>
</body>
</html>
