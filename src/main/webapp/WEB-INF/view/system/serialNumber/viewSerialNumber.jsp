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
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script> 
<%@ include file="/resources/js/pcc.jsp"%>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid;
    var $applyFunctionSelectList ;
    var $resetModelData = [{ RESET_MODEL: 0, text: '按月归零' }, { RESET_MODEL: 1, text: '按年归零'}];
    var $middleFieldData = [{ MIDDLE_FIELD: 'yyyy', text: '年' }, { MIDDLE_FIELD: 'yyyymm', text: '年月' }];

    // 初始调用
    $(function() {
        f_initGrid();
        spf_getApplyFunction();
        $applyFunctionSelectList = getApplyFunctionSelectList();
    });
    //获取应用功能数据，以list返回
    function getApplyFunctionSelectList(){
        //请求服务器
        var applyFunctionSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getApplyFunctionSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
                applyFunctionSelectList = list ; 
            }
        });

        return applyFunctionSelectList ;
    } 
    //取应用功能数据 
    function spf_getApplyFunction(){
         //&callback=?"注意这个是为了解决跨域访问的问题    
        $.post('/utility/otherInfo/getApplyFunction',{},
            function(result){
                spf_setApplyFunction(result); 
                spf_setApplyFunctionSearch(result);
            }
        );
    }
    //设置应用功能下拉列表
    function spf_setApplyFunction(result){ 
        clearSel(document.getElementById("ORDER_ID")); //清空城市
        var ORDER_ID = document.getElementById("ORDER_ID"); 
        var jsonList = eval("(" + result + ")");
        var option = new Option('<spring:message code="hrms.selection"/>',"");
        ORDER_ID.options.add(option); 
        for(var i=0;i<jsonList.length;i++){ 
            var value = "0";var text = "0";  
            for(var key in jsonList[i]){  
                    if(key == "ID") 
                        value = jsonList[i][key];  
                    if(key == "Name") 
                    text = jsonList[i][key];  
            }  
            option = new Option(text,value);
            ORDER_ID.options.add(option); 
        }
    }
    //设置搜索时应用功能下拉列表
    function spf_setApplyFunctionSearch(result){ 
        clearSel(document.getElementById("ORDER_ID_SEARCH")); //清空城市
        var ORDER_ID = document.getElementById("ORDER_ID_SEARCH"); 
        var jsonList = eval("(" + result + ")");
        var option = new Option('<spring:message code="hrms.selection"/>',"");
        ORDER_ID.options.add(option); 
        for(var i=0;i<jsonList.length;i++){ 
            var value = "0";var text = "0";  
            for(var key in jsonList[i]){  
                    if(key == "ID") 
                        value = jsonList[i][key]; 
                        
                    if(key == "Name") 
                    text = jsonList[i][key];  
                        
            }  
            option = new Option(text,value);
            ORDER_ID.options.add(option); 
        }
    }
    // 清空下拉列表
    function clearSel(oSelect){ 
        while(oSelect.childNodes.length>0){
            oSelect.removeChild(oSelect.childNodes[0]);
        } 
    }
    function f_initGrid() {
        $grid = $("#getAllSerialNum").ligerGrid({
            columns : [ 
                        {display : '',name : 'SERIAL_NUM_ALL_NO',hide:true,width:'0%'},
                        {display : '',name : 'ORDER_ID',hide:true,width:'0%'},
                        {display : '<spring:message code="hrms.applyFunction"/>',name : 'ORDER_NAME',width : '10%'},
                        {display : '<spring:message code="hrms.prefix"/>',name : 'PREFIX',width : '10%'},
                        {display : '<spring:message code="hrms.middleField"/>',name : 'MIDDLE_FIELD',width : '10%',
                                    render: function (item){
                                        if (item.MIDDLE_FIELD == 'yyyy') {
                                            return '年';
                                        } else if (item.MIDDLE_FIELD == 'yyyymm') {
                                             return '年月';
                                        }
                                    }   
                        },
                        {display : '<spring:message code="hrms.numberLength"/>',name : 'NUM_LENGTH',width : '5%'},
                        {display : '<spring:message code="hrms.resetModel"/>',name : 'RESET_MODEL',width : '10%',
                                    render: function (item){
                                        if (parseInt(item.RESET_MODEL) == 1) {
                                            return '按年归零';
                                        }else if (parseInt(item.RESET_MODEL) == 0) {
                                            return '按月归零';
                                        }
                                    }
                        },
                        {display : '<spring:message code="hrms.createDate"/>',name : 'CREATE_DATE',width : '10%'},
                        {display : '<spring:message code="hrms.effectDate"/>',name : 'EFFECT_DATE',width : '10%'},
                        {display : '<spring:message code="hrms.stopDate"/>',name : 'END_DATE',width : '10%'},
                        {display : '<spring:message code="hrms.active"/>',name : 'ACTIVITY',width : '10%',
                                    render: function (item){
                                        if (parseInt(item.ACTIVITY) == 1) {
                                            return '可用';
                                        }
                                        return '不可用';
                                    }   
                        },
                        {display : '<spring:message code="hrms.example"/>',name : 'EXAMPLE',width : '13%'}
                ],
            usePager : true,
            rownumbers : true,
            url : "/system/serialNumber/getAllSerialNum",
            pageSize:15,
            pageSizeOptions:[15,20,30,40,50],
            width:'99.8%',
            height:'100%'
        });
    }
    /*
    //获取编号规则radio中的值
    function spf_getMiddleFieldValue() {
        //return $("input[name='middleField'][checked]").val();  //在chrome和firefox下只会获取第一个的值
        return $("input[name='middleField']:checked").val();
    }
    //获取归零方式radio中的值
    function spf_getResetModelValue() {
        //return $("input[name='resetModel'][checked]").val(); 
        return $("input[name='resetModel']:checked").val();
    }
    */

    //获取Radio中的值
    function GetRadioValue(RadioName){
        var obj;    
        obj=document.getElementsByName(RadioName);
        if(obj!=null){
            var i;
            for(i=0;i<obj.length;i++){
                if(obj[i].checked){
                    return obj[i].value;
                }
            }
        }
        return null;
    }
    //取当前时间，格式为,yyyy-mm-dd
    function GetNow(){
      var d,s;
      d = new Date();
      s = d.getFullYear() + "-";             //取年份
      s = s + (d.getMonth() + 1) + "-";//取月份
      s += d.getDate() + " ";         //取日期

      return(s);
     } 
    // 求两个时间的天数差 日期格式为 YYYY-MM-dd   
    function daysBetween(DateOne,DateTwo){
        var OneMonth = DateOne.substring(5,DateOne.lastIndexOf ('-'));  
        var OneDay = DateOne.substring(DateOne.length,DateOne.lastIndexOf ('-')+1);  
        var OneYear = DateOne.substring(0,DateOne.indexOf ('-'));  
      
        var TwoMonth = DateTwo.substring(5,DateTwo.lastIndexOf ('-'));  
        var TwoDay = DateTwo.substring(DateTwo.length,DateTwo.lastIndexOf ('-')+1);  
        var TwoYear = DateTwo.substring(0,DateTwo.indexOf ('-'));  
      
        var cha=((Date.parse(OneMonth+'/'+OneDay+'/'+OneYear)- Date.parse(TwoMonth+'/'+TwoDay+'/'+TwoYear))/86400000);   
        
        return cha;  
    }  
    //补零
    function pad(num, n) {
        var i = (num + "").length;
        while(i++ < n){
            num = "0" + num;
        }
        return num;
    }
    //将当前日期按照格式(yyyy或者yyyymm)转换为字符串
    function dateToChar(formatStr){   
        var str = formatStr;
        var d = new Date();
        var month = d.getMonth() + 1;
        str=str.replace(/yyyy/,d.getFullYear());      
        
        str=str.replace(/mm/,month>9?month.toString():('0' + month));
        
        return str;   
    }  
    //将当前日期按照格式(yyyy-mm-dd)转换为字符串
    function dateToChar1(fromDate,formatStr){   
        var str = formatStr;
        var d = fromDate;
        var month;
        
        if (IsDate(d)) {
            return fromDate;
        }else {
            str=str.replace(/yyyy|YYYY/,d.getFullYear());      
            month = d.getMonth() + 1;
            str=str.replace(/MM/,month >9?month.toString():'0' + month); 
            
            str=str.replace(/dd|DD/,d.getDate()>9?d.getDate().toString():'0' + d.getDate());
            //alert(str);
            return str;
        }  
    }
    //判断输入框中输入的日期格式为yyyy-mm-dd和正确的日期 
    function   IsDate(mystring)   {   
        var reg = /^(\d{4})-(\d{2})-(\d{2})$/;   
        var str = mystring;   
        var arr = reg.exec(str);   
        if (str=="")   return   true;   
        if (!reg.test(str)&&RegExp.$2<=12&&RegExp.$3<=31){     
            return false;   
        }   
            return true;   
      }
    //添加编号规则放入sy_serial_num_all中
    function spf_addSerialNum() {
        var prefix = MyCheckNull($("#prefix").val());
        var middle_field = MyCheckNull(GetRadioValue("middleField"));
        var num_length = $("#suffixNumLength").val();
        if(spf_checkData()){ 
            $.ligerDialog.confirm('编号示例：'+prefix+dateToChar(middle_field)+pad(1,num_length)+'<br/>'+'您确定要生成吗？','<spring:message code="hrms.warning"/>', 
                    function (yes){
                        if(yes){          
                                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                                $.post("/system/serialNumber/addSerialNum", 
                                    [
                                        { name: 'PREFIX', value: prefix},
                                        { name: 'MIDDLE_FIELD', value: middle_field},
                                        { name: 'NUM_LENGTH', value: num_length},
                                        { name: 'ORDER_ID', value: $("#ORDER_ID").val()},
                                        { name: 'EFFECT_DATE', value: $("#EFFECT_DATE").val()},
                                        { name: 'RESET_MODEL', value: MyCheckNull(GetRadioValue("resetModel"))} 
                                    ]
                             , function (result){
                                $.ligerDialog.closeWaitting();
                                 if (result == "Y"){
                                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                         $grid.loadData(true);
                                         spf_clearAddSerialNumDiv();
                                     });
                                 }
                                 else{
                                     $grid.loadData(true);
                                     spf_clearAddSerialNumDiv();
                                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                                 }
                             }
                           );
                    }
                 }
                );
        }
    }
    //检查必选项是否填写
    function spf_checkData(){
        if ($("#suffixNumLength").val() == null || $("#suffixNumLength").val() == "" || $("#suffixNumLength").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '数字长度'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#ORDER_ID").val() == null || $("#ORDER_ID").val() == "" ) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '应用功能'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#EFFECT_DATE").val() == null || $("#EFFECT_DATE").val() == "" || $("#EFFECT_DATE").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '生效日期'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if (daysBetween($("#EFFECT_DATE").val(),GetNow()) < 0 ) {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '生效日期只能在今天或者今天之后！') ; 
             return false; 
        }
        return true;
    } 
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}, 
                        {name:'ORDER_ID',value : $("#ORDER_ID_SEARCH").val()},
                        {name: 'S_DATE', value: $("#S_DATE").attr('value')},
                        {name: 'E_DATE', value: $("#E_DATE").attr('value')},
                        {name:'ACTIVITY',value : $("#ACTIVITY").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    //添加流水号展开
    function spf_add(){
        spf_clearModifySerialNumDiv();
        $("#showAddSerialNumDiv input[type!='radio']").val("");
        $("#showAddSerialNumDiv").show(500);
    }
    //添加流水号收缩
    function spf_clearAddSerialNumDiv(){
        $("#showAddSerialNumDiv input[type!='radio']").val("");
        $("#showAddSerialNumDiv").hide(500);
    }
    //修改流水号展开
    function spf_update() {
        spf_clearAddSerialNumDiv();
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        if (row.ACTIVITY == 1) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '正在生效的编号不能修改！') ; 
            return ;
        }
        
        if (daysBetween(dateToChar1(row.EFFECT_DATE,'yyyy-MM-dd'),GetNow()) <= 0 ) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '只能修改今天之后未生效的编号!') ; 
             return false; 
        }
        
        $("#serialNumAllNoModify").val(row.SERIAL_NUM_ALL_NO);
        $("#prefixModify").val(row.PREFIX);
        $("#suffixNumLengthModify").val(row.NUM_LENGTH);
        $("#orderIdModify").val(row.ORDER_ID);
        $("#effectDateModify").val(row.EFFECT_DATE);
        $("#orderNameModify").val(spf_setApplyFunctionModify(row.ORDER_ID));
        ChooseRadioValue("middleFieldModify",row.MIDDLE_FIELD);
        ChooseRadioValue("resetModelModify",row.RESET_MODEL);

        $("#showModifySerialNumDiv").show(500);
    }
    //传值到修改页面时radio
    function ChooseRadioValue(radioName,Value){
        var radio = document.getElementsByName(radioName);
        for(var i = 0;i < radio.length;i++){
            if(radio[i].value == Value){
                radio[i].checked = true;
            }       
        }
    }
    //传值给修改页面应用功能填充
    function spf_setApplyFunctionModify(orderId){ 
        var jsonList = $applyFunctionSelectList;
        for(var i=0;i<jsonList.length;i++){ 
            if(jsonList[i]['ORDER_ID'] == orderId) {
                return jsonList[i]['ORDER_NAME'];
            };
        }
    }
    //添加流水号收缩
    function spf_clearModifySerialNumDiv(){
        $("#showModifySerialNumDiv input[type!='radio']").val("");
        $('input[name=middleFieldModify]:checked').attr('checked',false);//清除选中的radio，以免影响后续内容
        $('input[name=resetModelModify]:checked').attr('checked',false);
        $("#showModifySerialNumDiv").hide(500);
    }
    //删除流水号(直接从数据库中删除)
    function spf_delete(){
        var row = $grid.getSelectedRow(); 
        if (!row || row.length == 0) {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        if (row.ACTIVITY == 1) {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '正在生效的编号不能删除!') ; 
            return ;
        }
        if (daysBetween(row.EFFECT_DATE,GetNow()) <= 0 ) {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '只能删除今天之后未生效的编号!') ; 
             return false; 
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/system/serialNumber/deleteSerialNum',
                        {"SERIAL_NUM_ALL_NO":row.SERIAL_NUM_ALL_NO}, 
                        function(result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y")
                            {
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                                {
                                    $grid.loadData(true);
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        });
            }
        });
    }
    //检查必选项是否填写
    function spf_checkDataModify(){
        if ($("#suffixNumLengthModify").val() == null || $("#suffixNumLengthModify").val() == "" || $("#suffixNumLengthModify").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '数字长度'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#effectDateModify").val() == null || $("#effectDateModify").val() == "" || $("#effectDateModify").val() == undefined) {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '生效日期'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if (daysBetween($("#effectDateModify").val(),GetNow()) <= 0 ) {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '流水号修改后的生效日期只能在今天之后！') ; 
             return false; 
        }
        return true;
    } 
    //保存修改后的serial_num到sy_serial_num_all
    function spf_modifySerialNum() {
        if (spf_checkDataModify()){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $.post("/system/serialNumber/updateSerialNum", 
                    [   
                        { name: 'SERIAL_NUM_ALL_NO', value: $("#serialNumAllNoModify").val()},
                        { name: 'PREFIX', value: MyCheckNull($("#prefixModify").val())},
                        { name: 'ORDER_ID', value: MyCheckNull($("#orderIdModify").val())},
                        { name: 'MIDDLE_FIELD', value: MyCheckNull(GetRadioValue("middleFieldModify"))},
                        { name: 'NUM_LENGTH', value: MyCheckNull($("#suffixNumLengthModify").val())},
                        { name: 'EFFECT_DATE', value: MyToDate($("#effectDateModify").val())},
                        { name: 'RESET_MODEL', value: MyCheckNull(GetRadioValue("resetModelModify"))}   
                    ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        $grid.loadData(true);
                        spf_clearModifySerialNumDiv(); 
                    });
                }
                else{
                    spf_clearModifySerialNumDiv();
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            });
        }
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
#showAddSerialNumDiv{
    display:none;
}
#showModifySerialNumDiv{
    display:none;
}
#hrSearchEmp{
    margin-top:5px;
}
.inputClass{
    width:200px;
    height:23px;
    border:1px solid #A3C0E8;
}
.tableLabel{
    height:25px;
    line-height:25px;
    color:#014d7e;
    font-family:"宋体";
    text-align:center;
    background-color:#c1dbfa;
    font-size:12px;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div>
            <div style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="keyWord"/></div></td>
                        <td class="l-table-edit-c" width="30%">
                            <input width="120" type="text" name="keyWord" id="keyWord" class="inputClass"/></td>
                        <td width="10%"><div class="tableLabel">生效日期</div></td>
                        <td class="l-table-edit-c" width="50%">
                            <input type="text" name="S_DATE" id="S_DATE" value="" size="25"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" /> ~ 
                            <input type="text" name="E_DATE" id="E_DATE" value="" size="25"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" /></td>
                    </tr>
                    <tr>
                        <td width="10%">
                            <div class="tableLabel"><spring:message code="hrms.applyFunction"/></div>
                        </td>
                        <td class="l-table-edit-c" width="20%">
                            <select name="ORDER_ID_SEARCH" id="ORDER_ID_SEARCH" onChange="spf_search()"></select>
                        </td>
                        <td width="10%"><div class="tableLabel"><spring:message code="hrms.active"/></div></td>
                        <td class="l-table-edit-c">
                            <SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search()"/>
                        </td> 
                    </tr>
                </table>
            </div>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px">
                        <SipingSoft:button />
                    </td>
                </tr>
            </table>
            
            <div id = "showAddSerialNumDiv" style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.prefix"/></div>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="text" name="prefix" id="prefix" class="inputClass" />
                    </td>   
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.middleField"/></div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input id="middleField_0" type="radio" name="middleField" value="yyyy" />
                        <label for="middleField_0"><spring:message code="hrms.year"/></label> 
                        <input id="middleField_1" type="radio" name="middleField" value="yyyymm" />
                        <label for="middleField_1"><spring:message code="hrms.yearMonth"/></label>
                    </td>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.numberLength"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="number" name="suffixNumLength" id="suffixNumLength" class="inputClass"/></td>
                </tr>
                <tr>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.applyFunction"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <select name="ORDER_ID" id="ORDER_ID"></select>
                    </td>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.effectDate"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="text" name="EFFECT_DATE" id="EFFECT_DATE" class="inputClass" 
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                                validate="{required:true}" />
                    </td>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.resetModel"/></div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input id="resetModel_0" type="radio" name="resetModel" value="1" />
                        <label for="resetModel_0"><spring:message code="hrms.annualReset"/></label> 
                        <input id="resetModel_1" type="radio" name="resetModel" value="0" />
                        <label for="resetModel_1"><spring:message code="hrms.monthlyReset"/></label>
                    </td>
                </tr>
                </table>
                <table width="99%" align="center">
                    <tr>
                        <td height="30">
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right;  "
                                onclick="spf_clearAddSerialNumDiv()">取消</a>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right; margin-right: 10px; "
                                onclick="spf_addSerialNum()">保存</a>
                        </td>
                    </tr>
                </table>
            </div>
            
            <div id = "showModifySerialNumDiv" style="width:99%;margin:0 auto;border:1px solid #A3C0E8;">
                <table width="99%" align="center" cellpadding="0"
                    cellspacing="0" style="margin:0 auto;margin-top:3px;margin-bottom:3px;">
                    <tr>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.prefix"/></div></td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="text" name="prefixModify" id="prefixModify" class="inputClass" />
                    </td>   
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.middleField"/></div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input id="middleField_0" type="radio" name="middleFieldModify" value="yyyy"/>
                        <label for="middleField_0"><spring:message code="hrms.year"/></label> 
                        <input id="middleField_1" type="radio" name="middleFieldModify" value="yyyymm" />
                        <label for="middleField_1"><spring:message code="hrms.yearMonth"/></label>
                    </td>
                    <td width="10%">
                        <div class="tableLabel"><spring:message code="hrms.numberLength"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="number" name="suffixNumLengthModify" id="suffixNumLengthModify" class="inputClass" /></td>
                </tr>
                <tr>
                    <td width="10%">
                        <div class="tableLabel">
                        <spring:message code="hrms.applyFunction"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="hidden" name="orderIdModify" id="orderIdModify" />
                        <input width="120" type="hidden" name="serialNumAllNoModify" id="serialNumAllNoModify" />
                        <input width="120" type="text" name="orderNameModify" id="orderNameModify" class="inputClass" readOnly/>
                    </td>
                    <td width="10%">
                        <div class="tableLabel">
                        <spring:message code="hrms.effectDate"/>
                        <font color="red">*</font>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input width="120" type="text" name="effectDateModify" id="effectDateModify" class="inputClass"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readonly:true,dateFmt:'yyyy-MM-dd'});"
                                validate="{required:true}" />
                    </td>
                    <td class="l-table-edit-t" width="10%">
                        <div class="tableLabel">
                        <spring:message code="hrms.resetModel"/>
                        </div>
                    </td>
                    <td class="l-table-edit-c" width="20%">
                        <input id="resetModel_0" type="radio" name="resetModelModify" value="1"/>
                        <label for="resetModel_0"><spring:message code="hrms.annualReset"/></label> 
                        <input id="resetModel_1" type="radio" name="resetModelModify" value="0" />
                        <label for="resetModel_1"><spring:message code="hrms.monthlyReset"/></label>
                    </td>
                </tr>
                </table>
                <table width="99%" align="center">
                    <tr>
                        <td height="30">
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right; "
                                onclick="spf_clearModifySerialNumDiv()">取消</a>
                            <a class="l-button"
                                style="width: 79px; height: 20px; float: right; margin-right: 10px; "
                                onclick="spf_modifySerialNum()">保存</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div position="center" id="getAllSerialNum"></div>
    </div>
</body>
</html>
