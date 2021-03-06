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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
    var flag = true;
    var $grid_d ; 
    var $grid_i ; 
    var paramNo = "" ;
    var lockFlag = "0" ;
    var $dialogUpload;
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm){
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm){
            return input.val();
        },
        setValue: function (input, value, editParm){
            input.val(value);
        },
        resize: function (input, width, height, editParm){
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
    // 初始调用
    $(function (){
        //布局
        $("#layout1").ligerLayout({ 
            leftWidth: 220,height:'99.6%',
            allowLeftResize:false
        }); 
        spf_inputKpiTypeInfo();
        spf_initGrid_kpiItem();
    });
    function spf_inputKpiTypeInfo(){
        $grid_i = $("#inputKpiTypeInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '', name: 'EVA_TYPE_NO', width: 10,hide: 1}, 
                { display: '<spring:message code="eva.assessmentCategory"/>', name: 'EVA_TYPE_NAME', align: 'center',width: 180},
                { display: '<spring:message code="eva.classID"/>', name: 'EVA_TYPE_ID', align: 'left',width: 10,hide: 1}    
            ],
            enabledEdit: true,usePager: false, rownumbers:true,
            url: '/eva/kpi/getEvaKpiTypeInfo', 
            width: '99.8%', height: '99.8%',
            onSelectRow: function (rowdata, rowindex, rowDomElement){
                paramNo = rowdata.EVA_TYPE_ID;
                spf_initGrid_kpiItem();
            },
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
                spf_showKpiTypeDetail();
            }
        });
    }
    function spf_initGrid_kpiItem(){
        $grid_d = $("#kpiItemInfo").ligerGrid({
            checkbox: true,
            columns: [
                { display: '', name: 'EVA_KPI_NO', width: 10,hide: 1},
                { display: '<spring:message code="eva.indexID"/>', name: 'EVA_KPI_ID', width: 10,hide: 1},
                { display: '<spring:message code="eva.assessmentCategory"/>', name: 'EVA_KPI_NAME', width:120,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.definition"/>', name: 'KPI_DEFINE', width: 200,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.calculation"/>', name: 'CAL_DES', width: 200,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.appraisalStandards"/>', name: 'KPI_STANDARD', width: 80,editor: { type: 'textarea', height: 100 }},
                { display: '<spring:message code="eva.category"/>', name: 'EVA_TYPE_NAME',width:160}
            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/eva/kpi/getEvaKpiItemInfo',
            parms: [
                { name: 'EVA_TYPE_ID',value: paramNo}
            ],
            width: '99.8%', height: '99.8%',pageSize:20,
        });
    }

    function spf_search()
    {
        $grid_d.setOptions({ 
            parms: [    
                { name: 'keyWord', value: $("#keyWord").attr('value')},
                { name: 'EVA_TYPE_ID',value: paramNo}
            ],
            newPage: 1
        }); //设置数据参数 
        $grid_d.loadData(true); //加载数据
    }
    function spf_search_i()
    { 
        $grid_i.setOptions({
            parms: [
                { name: 'PA_MONTH', value: $("#year").attr('value')+$("#month").attr('value')}
            ],
            newPage: 1
        }); //设置数据参数 
        $grid_i.loadData(true); //加载数据
    }

    function spf_showKpiTypeDetail()
    {
        $dialog = $.ligerWindow.show({isDrag: true,
            title: '<spring:message code="eva.category"/>',
            width: 900 , 
            height: 450 , 
            left:120,top:90,
            url: '/eva/basicInfo/viewKpiTypeDetailInfo'
        }); 
    }
    function spf_add(){
        if (!paramNo || paramNo == "") { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>'+'<spring:message code="eva.category"/>') ;
             return ; 
        }else{
            $dialog = $.ligerWindow.show({isDrag: true,
                title: '<spring:message code="eva.assessmentCategory"/>-'+'<spring:message code="hrms.add"/>'+'<spring:message code="hrms.detail"/>',
                width: 600 , 
                height: 260 ,
                url: '/eva/kpi/addKpiItemInfo?EVA_TYPE_ID='+paramNo
            }); 
        }
    }

    function f_ChildWindowClose (){
        $grid_i.loadData(true); //加载数据 
        $grid_d.loadData(true); //加载数据 
    }

    function spf_save(){
        var jsonData = '[' ; 
            var rows = $grid_d.getCheckedRows(); 
            if (!rows || rows.length == 0) { 
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                 return ; 
            }
            $(rows).each(function (index, row){
                if(this.EVA_KPI_NAME == null || this.EVA_KPI_NAME == '' || this.EVA_KPI_NAME == 'undefined'){ 
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.indexName"/>'    +". " + '<spring:message code="input.required"/>') ; 
                    return false;   
                }
                if(this.KPI_DEFINE == null || this.KPI_DEFINE == '' || this.KPI_DEFINE == 'undefined'){ 
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.definition"/>'   +". " + '<spring:message code="input.required"/>') ; 
                    return false;   
                }
                if(this.CAL_DES == null || this.CAL_DES == '' || this.CAL_DES == 'undefined'){ 
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.value"/>'  +". " + '<spring:message code="input.required"/>') ; 
                     return false;  
                }
                if(this.KPI_STANDARD == null || this.KPI_STANDARD == '' || this.KPI_STANDARD == 'undefined'){ 
                     $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.value"/>'  +". " + '<spring:message code="input.required"/>') ; 
                     return false;  
                }
                
                checkKpiName(this.EVA_KPI_NAME,this.EVA_KPI_NO);
                if(flag){
                    var kpiName = (""+this.EVA_KPI_NAME).replace(/\n/g,"");
                    var standard = (""+this.KPI_STANDARD).replace(/\n/g,"");
                    var define = (""+this.KPI_DEFINE).replace(/\n/g,"");
                    var des = (""+this.CAL_DES).replace(/\n/g,"");
                    if (jsonData.length > 1){
                        jsonData += ',{' ;
                     }else{
                        jsonData += '{' ;
                     }
                     jsonData += ' "EVA_KPI_NO": "' + this.EVA_KPI_NO + '", ' ;
                     jsonData += ' "EVA_KPI_NAME": "' + kpiName + '", ' ;
                     jsonData += ' "KPI_STANDARD": "' + standard + '", ' ;
                     jsonData += ' "KPI_DEFINE": "' + define + '", ' ;
                     jsonData += ' "CAL_DES": "' + des + '"' ;
                     jsonData += '}' ;
                }
            }); 
            jsonData += ']' ;  
            var jsonList = eval("(" + jsonData + ")");
            if(jsonData.length == 2){
                return ;
            } 
            if(jsonList.length == rows.length){ 
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post("/eva/kpi/updateKpiItemInfo",[ {
                        name : 'jsonData',
                        value : jsonData
                    } ]
                    , function (result)
                    {
                    $.ligerDialog.closeWaitting();
                        if (result == "Y"){
                            $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                $grid_d.loadData(true); //加载数据 
                            });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
                    }
                });
            }
    }

    //用于查询该指标名是否存在
    function checkKpiName(kpiName,ownKpiNo){
        $.ajax({
            type : 'post',
            url : '/eva/kpi/getKpiItemCount?isExistKpiName='+kpiName+"&ownKpiNo="+ownKpiNo,
            dataType : 'json',
            async : false,
            success : function(result) {
                if(result == "Y"){
                    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="eva.theindexalreadyexists"/>');
                    flag = false;
                }else{
                    flag = true;
                }
            },
            error : function(){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', 'Send Errow') ;
                flag = false;
            }
        });
    }

    function spf_delete(){
        var rows = $grid_d.getCheckedRows(); 
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        }
        $.ligerDialog.confirm('<spring:message code="cust.areYouSureYouWantToDeleteTheData"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    var jsonData = '[' ; 
                    $(rows).each(function (index, row){
                         if (jsonData.length > 1){
                            jsonData += ',{' ;
                         }
                         else{
                            jsonData += '{' ;
                         }  
                         jsonData += ' "EVA_KPI_NO": "' + this.EVA_KPI_NO + '",';
                         jsonData += ' "EVA_KPI_ID": "' + this.EVA_KPI_ID + '"'
                         jsonData += '}' ;
                    }); 
                    jsonData += ']' ;
                    if(jsonData.length == 2){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
                        return ;
                    }
                    $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                    $.post("/eva/kpi/deleteKpiItemInfo",
                        [
                            { name: 'jsonData', value: jsonData }
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    $grid_d.loadData(true); //加载数据 
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
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
    <div position="top">
        <table width="99%" cellpadding="0" cellspacing="0"
            class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>
                <td width="15%" class="l-table-edit-t"><spring:message
                            code="keyWord" /></td>
                <td width="85%" class="l-table-edit-c"><input name="keyWord"
                    type="text" id="keyWord" size="30"/>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
            <tr>
                <td align="left">
                    <SipingSoft:button />
                </td>
            </tr>
        </table>
    </div>
    <div id="layout1">
        <div position="left" id="inputKpiTypeInfo" class="l-scroll"
            title="<spring:message code="eva.category"/>&nbsp;&nbsp;<a href='javascript:spf_showKpiTypeDetail()'><spring:message code="eva.management"/></a>">
            </div>
        <div position="center" id='kpiItemInfo'
            title='<spring:message code="eva.assessmentIndicators"/>'></div>
    </div>
</body>
</html>
