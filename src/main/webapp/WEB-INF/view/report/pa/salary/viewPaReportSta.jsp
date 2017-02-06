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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var paColumnsList;
    var colums;
    var detailColumns;
    var columsName = "";
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,
            //是否允许 左边可以调整大小
            allowRightResize: false,
            //是否允许 右边可以调整大小
            allowTopResize: false,
            //是否允许 头部可以调整大小
            allowBottomResize: false //是否允许 底部可以调整大小
        });
        spf_initeHrItem();
        paColumnsList = ${paColumnsList};
        spf_initColumns(paColumnsList);
        spf_initGrid(colums); 
    });
    //初始化表标题，不从数据库读取，以免影响效率，前台判断换掉第一列显示为所选人事项目名即可
    function spf_initColumns(paColumns){
        colums = [];
        detailColumns = [];
        detailColumns.push({ display: '<spring:message code="hrms.month" />', name: 'PA_MONTH' , width:90 , totalSummary:
        {
            render: function (suminf, column, cell)
            {
                return "<font color='green'><spring:message code="pa.monthlyAverage" /><font>";
            },
            align: 'center'
        }});
        //columsName用于Excel导出时传的表标题，以免又从数据库读取，影响效率
        columsName = "";
        $(paColumns).each(function(index, row){
            if(row.COLUMN_NAME == "ITEM_ID"){
                if($("#PA_ITEM_NAME option:selected").text()==""){
                    colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:120}) ;
                    columsName = columsName + "" +row.ITEM_NAME + ",";
                }else{
                    colums.push({ display: $("#PA_ITEM_NAME option:selected").text(), name: row.COLUMN_NAME, width:120}) ;
                    columsName = columsName + "" +$("#PA_ITEM_NAME option:selected").text() + ",";
                }
            }else{
                detailColumns.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:100, totalSummary:
                {
                    render: function (suminf, column, cell)
                    {
                        return "<font color='blue'>"+format_number(suminf.sum/suminf.count,2)+"</font>";
                    },
                    align: 'center',
                }}) ;
                colums.push({ display: row.ITEM_NAME, name: row.COLUMN_NAME , width:100 }) ;
                columsName = columsName + "" +row.ITEM_NAME + ",";
            }
        });
    }

    function spf_initGrid(colums){
        var paStartMonth = $("#paStartYear").val() + $("#paStartMonth").val();
        var paEndMonth = $("#paEndYear").val() + $("#paEndMonth").val();
        $grid = $("#paMonthInfo").ligerGrid({ 
            columns: colums,
            url: '/report/pa/salary/getPaReportSta',
            parms: [
                { name: 'PA_START_MONTH', value: paStartMonth },
                { name: 'PA_END_MONTH', value: paEndMonth },
                { name: 'GROUP_BY', value: $("#PA_ITEM_NAME").val()},
                { name: 'keyWord', value: $("#keyWord").val()}
            ],
            enabledEdit: true,usePager: true,
            width: '99.6%', height: '100%',
            detail: { onShowDetail: f_showDetail,height:'auto' }
        });
    }

    function f_showDetail(row, detailPanel,callback)
    {
        var itemVal = row.ITEM_ID;
        var paStartMonth = $("#paStartYear").val() + $("#paStartMonth").val();
        var paEndMonth = $("#paEndYear").val() + $("#paEndMonth").val();
        var qualificationGrid = document.createElement('div'); 
        $(detailPanel).append(qualificationGrid);
        $(qualificationGrid).css('margin',5).ligerGrid({
             columns : detailColumns, 
             isScroll: false, showToggleColBtn: false, width: '99%',
             url: '/report/pa/salary/getPaStaDetail', 
             parms: [
                    { name: 'GROUP_BY', value: $("#PA_ITEM_NAME").val() },
                    { name: 'ITEM_VAL', value: itemVal },
                    { name: 'PA_START_MONTH', value: paStartMonth },
                    { name: 'PA_END_MONTH', value: paEndMonth }
                ],
             showTitle: false, columnWidth: 100,
             usePager: true,rownumbers: true,
             pageSize: 6, pageSizeOptions:[6,12,18,24,30]
        }); 
    }

    function spf_search(){
        var paStartMonth = $("#paStartYear").val() + $("#paStartMonth").val();
        var paEndMonth = $("#paEndYear").val() + $("#paEndMonth").val();
        $grid.setOptions({ parms: [
                { name: 'PA_START_MONTH', value: paStartMonth },
                { name: 'PA_END_MONTH', value: paEndMonth },
                { name: 'GROUP_BY', value: $("#PA_ITEM_NAME").val()},
                { name: 'keyWord', value: $("#keyWord").val()}
            ],
            newPage: 1
        }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function spf_initeHrItem() {
        $.ajax({
            type: 'post',
            cache: false,
            contentType: 'application/json',
            url: '/utility/otherInfo/getToolItemSelectList?TABLE_NAME=PA_HR_V',
            dataType: 'json',
            success: function(data) {
                var temp = "";
                $.each(data.Rows,function(i, item) {
                        temp = temp+"<option value='"+item.ITEM_ID+"'>"+item.ITEM_NAME+"</option>";
                });
                $("#PA_ITEM_NAME").html(temp);
            }
        });
    }
    
    function spf_changeItem(){
        spf_initColumns(paColumnsList);
        spf_initGrid(colums);
    }

    function getExcelSta(){
        var paMonth = $("#paStartYear").val() + $("#paStartMonth").val();
        var paEndMonth = $("#paEndYear").val() + $("#paEndMonth").val();
        location.href='/report/pa/salary/getExcelSta?PA_START_MONTH=' + paMonth + "&PA_END_MONTH=" + paEndMonth
                +"&GROUP_BY="+$("#PA_ITEM_NAME").val()+"&columsName="+columsName;
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
    }
</script>
<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99%;
    margin: 0;
    padding: 0;
}
</style>
</head>
<body style="padding: 0px">
    <div id="layout1">
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-t" width="10%"><spring:message code="keyWord" /></td>
                        <td class="l-table-edit-c" width="20%">
                            <input width="120" type="text" name="keyWord" id="keyWord" />
                        </td>
                        <td class="l-table-edit-t" width="20%"><spring:message code="hrms.personnelItem" /></td>
                        <td class="l-table-edit-c" width="30%">
                            <select name="PA_ITEM_NAME" id="PA_ITEM_NAME" style="width: 100px;"
                                onchange="spf_changeItem()"> </select>
                        </td>
                    </tr>
                    <tr>
                        <td width="20%" class="l-table-edit-t">
                            <spring:message code="hrms.startDate" />
                        </td>
                        <td width="30%" class="l-table-edit-c">
                            <SipingSoft:date yearName="paStartYear" monthName="paStartMonth"
                                onChange="spf_search()" />
                        </td>
                        <td width="20%" class="l-table-edit-t">
                            <spring:message code="hrms.endDate" />
                        </td>
                        <td class="l-table-edit-c" width="30%">
                            <SipingSoft:date yearName="paEndYear" monthName="paEndMonth"
                                onChange="spf_search()" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
                    <tr>
                        <td align="left">
                            <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                                onclick="getExcelSta()"><spring:message code="hrms.excelExport" /></a>
                            <a class="l-button" style="width: 79px; height: 20px; float: left; margin-left: 10px; "
                                onclick="spf_search()"><spring:message code="search" /></a>
                        </td>
                    </tr>
                </table>
            </div>
            <div position="center" id='paMonthInfo'></div>
        </div>
    </div>
</body>
</html>
