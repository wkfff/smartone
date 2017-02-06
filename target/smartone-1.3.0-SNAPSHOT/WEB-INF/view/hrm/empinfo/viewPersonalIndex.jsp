<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
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
        f_getLeftMenu("hr0100");
        var _move=false;
        var _x;
        var _y;
        $("#floatDiv").mousedown(function(e){
            e.stopPropagation();
            _move=true;  
            _x=e.pageX-parseInt($("#floatDiv").css("left"));  
            _y=e.pageY-parseInt($("#floatDiv").css("top"));  
        });
        $(document).mousemove(function(e){
            e.stopPropagation();
            _menu_change=false;
            e.stopPropagation();
            if(_move){  
                var x=e.pageX-_x;//移动时根据鼠标位置计算控件左上角的绝对位置  
                var y=e.pageY-_y;  
                $("#floatDiv").css({top:y,left:x});//控件新位置  
            }
        }).mouseup(function(e){
            e.stopPropagation();
            _move=false;
            _menu_change=true;
        });
        $('#menu_manage').toggle(
            function() {
                $('#floatDiv').stop(true,true).animate({
                    height:20
                }, 500);
                $("#rightMenu").hide(300);
                $(this).html('<spring:message code="ass.expandthemenu"/>');
            },
            function() {
                $('#floatDiv').stop(true,true).animate({
                    height:280
                }, 500);
                $("#rightMenu").show(500);
                $(this).html('<spring:message code="ass.collapseMenu"/>');
            }
        );
        $('#floatDiv').mouseenter(function(event) {
            event.stopPropagation();
            $('#floatDiv').stop(true,true).animate({
                opacity : 1
            }, 500);
        }).mouseleave(function(event){
            event.stopPropagation();
            $('#floatDiv').stop(true,true).animate({
                opacity : 0.5
            }, 500);
        });
    });
    function spf_getNewWindow(i) {
        var data = $grid.getSelectedRow();
        if (tab.isTabItemExist($("#"+i).attr("tabid"))) {
            tab.removeTabItem($("#"+i).attr("tabid"));
        }
        if (data != null) {
            tab.addTabItem({
                tabid : $("#"+i).attr("tabid"),
                text : $("#"+i).attr("intro"),
                url : $("#"+i).attr("url")+'&EMPID=' + data.EMPID
            });
        } else {
            tab.addTabItem({
                tabid : $("#"+i).attr("tabid"),
                text : $("#"+i).attr("intro"),
                url : $("#"+i).attr("url")
            });
        }
    }

    function f_initGrid() {
        $grid = $("#hrSearchEmp").ligerGrid({
            columns : [ 
                        {display : '<spring:message code="hrms.empid"/>',name : 'EMPID',width : '120',frozen:true},
                        {display : '<spring:message code="hrms.name"/>',name : 'CHINESENAME',width : '120',frozen:true},
                        {display : '<spring:message code="hrms.post"/>',name : 'POST_NAME',width : '120',frozen:true},
                        {display : '<spring:message code="ass.jobLevel"/>',name : 'POST_LEVEL_NAME',width : '90'},
                        {display : '<spring:message code="hrms.dept"/>',name : 'DEPTNAME',width : '120'},
                        {display : '<spring:message code="hrms.hireDate"/>',name : 'JOIN_DATE',width : '120'},
                        {display : '<spring:message code="hrms.eduHis" />',name : 'EDU_HIS_NAME',width : '120'},
                        {display : '<spring:message code="hrms.EmpStatus"/>',name : 'STATUS',width : '90'},
                        {display : '<spring:message code="hrms.empDivision" />',name : 'EMP_TYPE_NAME' ,width : '120'}
                ],
            usePager : true,
            rownumbers : true,
            url : "/hrm/empinfo/getHrSearchEmployeeList",
            pageSize:10,
            pageSizeOptions:[10,20,30,40,50],
            width:'99.8%',
            height:'100%',
            onDblClickRow:send
        });
    }
    function spf_search() {
        $grid.setOptions({
            parms : [
                        {name:'keyWord',value : $("#keyWord").val()}, 
                        {name:'DEPTID',value : $("#DEPTID").val()},
                        {name: 'S_DATE', value: $("#S_DATE").attr('value')},
                        {name: 'E_DATE', value: $("#E_DATE").attr('value')},
                        {name: 'BS_DATE', value: $("#BS_DATE").attr('value')},
                        {name: 'BE_DATE', value: $("#BE_DATE").attr('value')},
                        {name:'EDU_HIS_CODE',value : $("#EDU_HIS_CODE").val()},
                        {name:'EMP_TYPE_CODE',value : $("#EMP_TYPE_CODE").val()},
                        {name:'POST_ID',value : $("#POST_ID").val()},
                        {name:'STATUS_CODE',value:$("#STATUS_CODE").val()}
                    ],
            newPage:1
        });
        $grid.loadData(true);
    }
    var tab = parent.tab;
    function send(){
        var data = $grid.getSelectedRow();
        if (tab.isTabItemExist('hr0101')) {
            tab.removeTabItem('hr0101');
        }
        tab.addTabItem({
            tabid:'hr0101',
            text:'<spring:message code="ass.basicInformation"/>',
            url:'/hrm/empinfo/viewPersonalInfo?MENU_CODE=hr0101&EMPID='+data.EMPID
        });
    }
    function f_getLeftMenu(code) {
        if ($("#rightMenu").text() == "") {
            $.ajax({
                type:'get',
                cache : false,
                contentType : 'application/json',
                url : '/login/getLeftMenu?mainMenu=' + code,
                dataType : 'json',
                success : function(data) {
                    var temp = "";
                    $.each(
                        data.leftMenuList,
                        function(i, item) {
                            if(i==0){
                                return;}
                            var url=item.MENU_URL+"";
                            temp = temp+"<li class='menuItem'><span url='"+url
                                +"' tabid='"+item.MENU_CODE+"' intro='"+item.MENU_INTRO
                                +"' onclick='spf_getNewWindow("+i+")' id='"+i+"'>"+item.MENU_INTRO+"</span></li>";});
                    $("#rightMenu").html(temp);},
                error : function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }
    }
    window.onscroll = sfp_scall;
    window.onresize = sfp_scall;
    window.onload = sfp_scall;
    function sfp_scall() {
        document.getElementById("floatDiv").style.top = (document.documentElement.scrollTop)+100+"px";
        document.getElementById("floatDiv").style.left=(document.documentElement.scrollLeft
                + document.documentElement.clientWidth - document
                .getElementById("floatDiv").offsetWidth)- 20 + "px";}
    
    function spf_delete(){
        var rows = $grid.getSelectedRow();  
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){ 
                    var jsonData = '[' ;  
                    if (jsonData.length > 1){
                        jsonData += ',{' ;
                    }else{
                        jsonData += '{' ;
                    }
                    jsonData += ' "EMPID": "' + rows.EMPID + '"' ;
                        jsonData += '}' ;
                    jsonData += ']' ;
                if(jsonData.length == 2){
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>') ;
                    return ;
                }
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/hrm/empinfo/deleteEmpInfo', 
                        [   
                            { name: 'jsonData', value: jsonData },
                        ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function (){
                            $grid.loadData(true); //加载数据
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        });
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

#floatDiv {
    position: absolute;
    width: 130px;
    height: 280px;
    top: 100px;
    filter: alpha(opacity =   50);
    opacity: 0.5;
    right: 10px;
    top: 100px;
    background-image: url("/resources/images/login/rmenu_bg.gif");
}

.menuItem {
    width: 100%;
    height: 25px;
    padding-left: 20px;
    padding-top: 5px;
    padding-bottom: 5px;
}

.menuItem span {
    display: block;
    font-family: "微软雅黑";
    width: 90px;
    height: 25px;
    cursor: pointer;
    font-size: 14px;
    text-align: center;
    line-height: 25px;
    color: #78828c;
    background-image: url("/resources/images/login/menuitem_bg.gif");
}

.menuItem span:hover {
    color: #f8af61;
    background-image: url("/resources/images/login/menuitem_bg2.gif");
}

#menu_btn {
    width: 130px;
    height: 20px;
    font-family: "华文行楷";
    font-size: 18px;
    color: gray;
    background-image: url("/resources/images/login/showMenu_bg.gif");
}

#menu_manage {
    display: block;
    width: 90px;
    height: 20px;
    margin-left: 20px;
    text-align: center;
    line-height: 20px;
    cursor: pointer;
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
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="keyWord" /></td>
                                <td class="l-table-edit-c" width="20%"><input width="120"
                                    type="text" name="keyWord" id="keyWord" /></td>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.post" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectPost
                                        name="POST_ID" limit="all" onChange="spf_search()" /></td>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.dept" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:deptTree name="DEPTID" limit="all" /></td>
                            </tr>
                            <tr>
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
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.empDivision" /></td>
                                <td class="l-table-edit-c" width="20%"><SipingSoft:selectSyCode
                                        parentCode="EmpDivision" name="EMP_TYPE_CODE" limit="all"
                                        onChange="spf_search()" /></td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t" width="10%"><spring:message
                                        code="hrms.hireDate" /></td>
                                <td class="l-table-edit-c" colspan="5"><input type="text"
                                    name="S_DATE" id="S_DATE" value="" size="25"
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    readonly="readonly" /> ~ <input type="text" name="E_DATE"
                                    id="E_DATE" value="" size="25"
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    readonly="readonly" /></td>
                            </tr>
                            <tr>
                                <td class="l-table-edit-t" width="20%"><spring:message
                                        code="hrms.birthDate" /></td>
                                <td class="l-table-edit-c" colspan="5"><input type="text"
                                    name="BS_DATE" id="BS_DATE" value="" size="25"
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    readonly="readonly" /> ~ <input type="text" name="BE_DATE"
                                    id="BE_DATE" value="" size="25"
                                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                    readonly="readonly" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" class="l-table-edit">
                <tr>
                    <td align="left" height="30px"><SipingSoft:button /></td>
                </tr>
            </table>
        </div>
        <div position="center" id="hrSearchEmp"></div>
    </div>
    <div id="floatDiv">
        <div id="menu_btn">
            <label id="menu_manage"><spring:message code="ass.collapseMenu"/></label><br />
        </div>
        <div id="rightMenu"></div>
    </div>
</body>
</html>