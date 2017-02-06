<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" >
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
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $dialog ;
    var $qual_grid ;
    var $health_grid ;
    var $account_grid ;
    var $calcFlagSelectList ; 
    var $Flag = "Q";
    // 初始调用
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
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,   //是否允许 左边可以调整大小
            allowRightResize: false,      //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false      //是否允许 底部可以调整大小
        });
        $("#navtab1").ligerTab({
            onAfterSelectTabItem: function (tabid){
                if(tabid=="tabitem1"){
                    $Flag = "Q";
                    spf_qual_initGrid();
                }
                if(tabid=="tabitem2"){
                    //已经分组人员
                    $Flag = "H";
                    spf_health_initGrid();
                }
                if(tabid=="tabitem3"){
                    //已经分组人员
                    $Flag = "P";
                    spf_account_initGrid();
                }
            }
        });
        spf_qual_initGrid();
        $calcFlagSelectList = getCalcFlagSelectList();
    });
    function getCalcFlagSelectList(){
        //请求服务器
        var calcFlagSelectList ;
        $.ajax({
            type: 'post',dataType: 'json',async: false,
            url: '/utility/otherInfo/getCalcFlagSelectList',
            success: function (list)
            {
                calcFlagSelectList = list ;
            }
        });
        return calcFlagSelectList ;
    } 
    //证书信息
    function spf_qual_initGrid()
    {
        $qual_grid = $("#qualificationInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '', name: 'NO',width:10,hide:1},
                { display: '<spring:message code="hrms.certificateType"/>', name: 'QUAL_TYPE_NAME', width: 120},
                { display: '<spring:message code="hrms.certificateName"/>', name: 'QUAL_CARD_NAME', width: 120},
                { display: '<spring:message code="hrms.certificateNumber"/>', name: 'QUAL_CARD_NO', width: 120},
                { display: '<spring:message code="hrms.certificationOffice"/>', name: 'QUAL_LOCATION', width: 120},
                { display: '<spring:message code="hrms.evidenceDate"/>', name: 'OPEN_DATE', width: 120},
                { display: '<spring:message code="hrms.startDate"/>',hide:1, name: 'START_DATE', width: 120},
                { display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120},
                { display: '<spring:message code="hrms.annualDate"/>', name: 'ANNUAL_DATE', width: 120},
                { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 160, editor: { type: 'textarea', height: 100 }}
            ],
            enabledEdit: true, usePager: false,rownumbers:true,
            url: "/hrm/empinfo/getQualificationInfoList?EMPID=${basicInfo.EMPID}",
            pageSize: 5,pageSizeOptions: [5,4,3,2,1],
            heightDiff : 0,width: '99.5%', height: '99%'
         });
    }
    //健康信息
    function spf_health_initGrid()
    {
        $health_grid = $("#healthInfo").ligerGrid({
            checkbox: false,
            columns: [
               { display: '', name: 'NO',width:10,hide:1},
               { display: '<spring:message code="hrms.examinationDate"/>', name: 'PHYSICAL_DATE',width:120},
               { display: '<spring:message code="hrms.physicalExamination"/>', name: 'CHECK_YN_NAME',width:120},
               { display: '<spring:message code="hrms.examinationResult"/>', name: 'CHECK_RESULT_NAME',width:120},
               { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',width:160, editor: { type: 'textarea', height: 100 }}
            ], 
            enabledEdit: true, usePager: false,rownumbers:true,
            url: "/hrm/empinfo/getHealthInfoList?EMPID=${basicInfo.EMPID}", 
            pageSize: 5,pageSizeOptions: [5,4,3,2,1], 
            heightDiff : 0,width: '99.5%', height: '99%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_showDetailData(rowdata.HEALTH_NO);
            }
        });
    }
    //账户信息
    function spf_account_initGrid()
    {
        $account_grid = $("#accountInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '', name: 'NO',width: 10,hide:1},  
                { display: '<spring:message code="hrms.wageMark"/>', name: 'CALC_FLAG_ID', width: 120,align: 'center',isSort: false,
                    editor: { type: 'select', data: $calcFlagSelectList, dataValueField: 'CALC_FLAG_ID',dataDisplayField: 'CALC_FLAG_NAME',
                        displayColumnName: 'CALC_FLAG_NAME', valueColumnName: 'CALC_FLAG_ID'}, 
                    render: function (item){
                        for (var i = 0; i < $calcFlagSelectList.length; i++){
                            if ($calcFlagSelectList[i]['CALC_FLAG_ID'] == item.CALC_FLAG_ID)
                                return $calcFlagSelectList[i]['CALC_FLAG_NAME'];
                        }
                        return item.CALC_FLAG_NAME;
                    }
                },
                { display: '<spring:message code="hrms.bank"/>', name: 'BANK_NAME',width: 160,editor:{type : 'text'}},
                { display: '<spring:message code="hrms.accountNumber"/>', name: 'CARD_NO',width: 160,editor:{type : 'text'}},  
                { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width: 160,editor: { type: 'textarea', height: 100 }}
            ],
            enabledEdit: true,usePager: false,rownumbers:true,
            url: "/hrm/empinfo/getPaEmpInfoList?EMPID=${basicInfo.EMPID}",
            pageSize: 5,pageSizeOptions: [5,4,3,2,1],
            heightDiff : 0, width: '99.5%', height: '99%',
        });
    }
    function f_ChildWindowClose (){
        if($Flag == "Q"){
            $qual_grid.loadData(true); //加载数据
        }
        if($Flag == "H"){
            $health_grid.loadData(true); //加载数据
        }
        if($Flag == "P"){
            $account_grid.loadData(true); //加载数据
        }
        $dialog.close() ;
    }
    function spf_add()
    {
        if($Flag == "P"){
            $account_grid.addRow();
            return;
        }
        var stringURL = "";
        if($Flag == "Q"){
            stringURL = "/hrm/empinfo/addQualificationInfo?EMPID=${basicInfo.EMPID}";
        }
        if($Flag == "H"){
            stringURL = "/hrm/empinfo/addHealthInfo?EMPID=${basicInfo.EMPID}";
        }
        $dialog = $.ligerDialog.open({
            isDrag: false, showMax:false,showMin:false,
            title:'<spring:message code="hrms.add"/>',
            width: 800, height: 400,
            url: stringURL
        });
    }
    function spf_update()
    {
        var rows = null;
        var stringURL = "";
        if($Flag == "Q"){
            rows = $qual_grid.getSelectedRow();
            stringURL = "/hrm/empinfo/updateQualificationInfo";
        }
        if($Flag == "H"){
            rows = $health_grid.getSelectedRow();
            stringURL = "/hrm/empinfo/updateHealthInfo";
        }
        if($Flag == "P"){
            spf_save();
            return;
        }
        if (!rows || rows.length == 0) {
             $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
             return ;
        }
        if (rows.length > 1) {
             $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>') ;
             return ;
        }
        $dialog = $.ligerDialog.open({isDrag: false,
            title:'<spring:message code="hrms.update"/>',
            width: 800, height: 400,
            url: stringURL+ '?NO=' + rows.NO
        });
    }
    function spf_save(){
        if($Flag == "P"){
            var data = $account_grid.getData(); 
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.post('/hrm/empinfo/saveAndUpdateEmpPaInfo', 
                [
                    { name: 'jsonData', value: JSON2.stringify(data)},
                    { name: 'EMPID', value: '${basicInfo.EMPID}' }
                ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>',
                        function (){
                            $account_grid.loadData(true); //加载数据   
                        });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
    }
    function spf_delete(){
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                var rows = null;
                var stringURL = "";
                if($Flag == "Q"){
                    rows = $qual_grid.getSelectedRow();
                    stringURL = "/hrm/empinfo/deleteQualificationInfo";
                }
                if($Flag == "H"){
                    rows = $health_grid.getSelectedRow();
                    stringURL = "/hrm/empinfo/deleteHealthInfo";
                }
                if($Flag == "P"){
                    rows = $account_grid.getSelectedRow();
                    stringURL = "/hrm/empinfo/deleteEmpPaInfo";
                }
                if (!rows || rows.length == 0) {
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
                    return ;
                }
                if (rows.length > 1){
                    alert('<spring:message code="hrms.onlyOneRow"/>'); return;
                }
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post(stringURL,
                    [
                        { name: 'NO', value: rows.NO }
                    ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                            if($Flag == "Q"){
                                $qual_grid.loadData(true); //加载数据
                            }
                            if($Flag == "H"){
                                $health_grid.loadData(true); //加载数据
                            }
                            if($Flag == "P"){
                                $account_grid.loadData(true); //加载数据
                            }
                        });
                    }
                    else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
             }
        });
    }
</script>
</head>
<style type="text/css">
    body{ padding:5px; margin:0; padding-bottom:15px;}
    #layout1{width:99.8%;margin:0; padding:0;}
</style>
<body style="padding:2px" >
    <div id="layout1" >
        <div align="left" position="center" id='' title=' ' >
            <div align="left">
                <%@include file="viewBasicInfo.jsp"%>
                <br>
                <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="hrms.otherInfo"/>
                        </td>
                        <td width="5%" align="right">&nbsp;</td>
                        <td align="right">
                            <SipingSoft:button/>
                        </td>
                    </tr>
                </table>
                <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td class="l-table-edit-c" colspan="4">
                            <div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; ">
                                <div title='<spring:message code="hrms.certificate"/>'>
                                    <div id="qualificationInfo"></div>
                                </div>
                                <div title='<spring:message code="hrms.healthInfo"/>'>
                                    <div id="healthInfo"></div>
                                </div>
                                <div title='<spring:message code="hrms.account"/>'>
                                    <div id="accountInfo"></div>
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
