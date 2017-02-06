<%@ page contentType="text/html; charset=UTF-8" language="java"
    errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    // 初始调用
    $(function() {
        f_initGrid();
    });

    function f_initGrid() {
        $grid = $("#hrSearchEmp").ligerGrid({
            columns : [ 
                        {display : '<spring:message code="hrms.empid"/>',name : 'EMPID',width : '120',frozen:true},
                        {display : '<spring:message code="hrms.name"/>',name : 'CHINESENAME',width : '120',frozen:true},
                        {display : '<spring:message code="hrms.post"/>',name : 'POST_NAME',width : '120',frozen:true},
                        {display : '<spring:message code="hrms.jobLevel"/>',name : 'POST_LEVEL_NAME',width : '90'},
                        {display : '<spring:message code="hrms.dept"/>',name : 'DEPTNAME',width : '120'},
                        {display : '<spring:message code="hrms.hireDate"/>',name : 'JOIN_DATE',width : '120'},
                        {display : '<spring:message code="hrms.eduHis" />',name : 'EDU_HIS_NAME',width : '120'},
                        {display : '<spring:message code="hrms.EmpStatus"/>',name : 'STATUS_NAME',width : '90'},
                        {display : '<spring:message code="hrms.empDivision" />',name : 'EMP_TYPE_NAME' ,width : '120'}
                ],
            usePager : true,
            rownumbers : true,
            url : "/report/hr/getMenList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%'
        });
    }
       function spf_hrTree() {
            $.ajax({
                type: 'post',
                cache: false,
                contentType: 'application/json',
                url: '/utility/otherInfo/getToolItemSelectList?TABLE_NAME=PA_HR_V',
                dataType: 'json',
                success: function(response) {
                    $tree_3 = $("#hrTree").ligerTree({
                        checkbox: true,
                        treeLine: true,
                        parentIcon: null,
                        childIcon: null,
                        data: response.Rows,
                        idFieldName: 'ITEM_ID',
                        textFieldName: 'ITEM_NAME'
                    });
                }
            });
        }
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}, 
                        {name:'DEPTID',value : $("#DEPTID").val()},
                        {name:'S_DATE',value : $("#S_DATE").val()},
                        {name:'EDU_HIS_CODE',value : $("#EDU_HIS_CODE").val()},
                        {name:'STATUS_CODE',value : $("#STATUS_CODE").val()},
                        {name:'POST_ID',value : $("#POST_ID").val()},
                        {name:'GENDER_CODE',value : $("#GENDER_CODE").val()},
                        {name:'EMP_TYPE_CODE',value : $("#EMP_TYPE_CODE").val()}
                        
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    
    function spf_unCheckAll(ifAll)
    {
        $('input[type="checkbox"][name="HR_ITEM"]').each(
            function() {
                //alert(ifAll);
                $(this).attr('checked',ifAll);
            });
    }
    function spf_insExcel() {
        var jsonData_code = '';
/*         $('#HR_ITEM').each(function () {
            if ($(this).attr('checked'))
            {
                jsonData_code += $(this).val()+',';
            }
        });  */
         
        $('input[type="checkbox"][name="HR_ITEM"]:checked').each(
            function() {
                jsonData_code += $(this).val()+',';
            });
        
        if(jsonData_code.length < 3){
             return;
        }
        
        //alert(jsonData_code);
        location.href = '/report/hr/getMenListByExcel?keyWord=' + $("#keyWord").val()
            +'&DEPTID=' + $("#DEPTID").val() + '&S_DATE='+$("#S_DATE").val()+ '&EDU_HIS_CODE='+$("#EDU_HIS_CODE").val()
            +'&STATUS_CODE='+$("#STATUS_CODE").val()+'&POST_ID='+$("#POST_ID").val()+"&GENDER_CODE="+$("#GENDER_CODE").val()
            +'&GENDER_CODE='+$("#GENDER_CODE").val()+'&jsonData_code='+jsonData_code;
        
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
    }
    var tab = parent.tab;
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
        <div position="top">
            <table width="100%" border="0">
                <tr>
                    <td height="2"></td>
                </tr>
                <tr>
                    <td align="center" valign="middle">
                        <table width="99.6%" align="center" cellpadding="0"
                            cellspacing="0" class="l-table-edit_01" border="1xp"
                            bordercolor="#A3C0E8">
                            <tr>
                                <td class="l-table-edit-t" width="10%"><spring:message code="report.listDate"/></td>
                                <td class="l-table-edit-c" width="20%"><input type="text"
                                    name="S_DATE" id="S_DATE" value="" size="25"
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    readonly="readonly" />
                                </td>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="keyWord" /></td>
                                <td class="l-table-edit-c" width="20%"><input width="120"
                                    type="text" name="keyWord" id="keyWord" /></td>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.dept" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:deptTree
                                        name="DEPTID" limit="hr" /></td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.post" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectPost
                                        name="POST_ID" limit="all" onChange="spf_search()" /></td>
                                <td class="l-table-edit-t"><spring:message
                                        code="hrms.EmpStatus" /></td>
                                <td class="l-table-edit-c"><SipingSoft:selectSyCode
                                        parentCode="EmpStatus" name="STATUS_CODE" limit="all"
                                        onChange="spf_search()" /></td>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.eduHis" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectSyCode
                                        parentCode="EduHisCode" name="EDU_HIS_CODE" limit="all"
                                        onChange="spf_search()" /></td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.empDivision" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectSyCode
                                        parentCode="EmpDivision" name="EMP_TYPE_CODE" limit="all"
                                        onChange="spf_search()" /></td>
                                <td class="l-table-edit-t" width="10%"><spring:message code="hrms.sex"/></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectSyCode
                                        parentCode="GenderCode" name="GENDER_CODE" limit="all"
                                        onChange="spf_search()" /></td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="report.informationField"/></td>
                                <td class="l-table-edit-c" colspan="5" height="60" id='checkBoxTd'>
                                    <c:forEach items="${hrItemList}" var="hrItem">
                                        <input type="checkbox" name="HR_ITEM"
                                            value="${hrItem.ITEM_ID}" />
                                            ${hrItem.ITEM_NAME}&nbsp;&nbsp;&nbsp;&nbsp;
                                    </c:forEach>
                                    [&nbsp; <a onclick="spf_unCheckAll(true)"
                                    style="cursor: hand; font-weight: bold; color: purple;"><spring:message
                                    code="hrms.selectAll" /></a>&nbsp;&nbsp; <a
                                    onclick="spf_unCheckAll(false)"
                                    style="cursor: hand; font-weight: bold; color: purple;"><spring:message
                                    code="hrms.deselectAll" /></a>&nbsp;]
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                        <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                                onclick="spf_insExcel()"><spring:message code="hrms.excelExport" />
                    </td>
                </tr>
            </table>
        </div>
        <div position="center" id="hrSearchEmp"></div>
    </div>
</body>
</html>
