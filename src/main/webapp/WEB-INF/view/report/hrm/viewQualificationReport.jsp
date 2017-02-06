<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
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
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script>  
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript"> 
    var $grid = null ;  
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
    $(function (){
        //布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
         f_initGrid();
    });
    
    /*
    *职位弹出框收缩js
    */ 
    $(function (){
        $("#POSTNAME").ligerComboBox({
            onBeforeOpen: spf_selectPost, valueFieldID: 'POST_ID',width:150
        });
    });
    function spf_selectPost(){
        $.ligerDialog.open({ 
            title: '职位信息',
            name:'winselector'+Math.random(),
            width: 800, 
            height: 450, 
            url: '/utility/postInfo/searchPost', 
            buttons: [
                        { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
                        { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
                        { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                    ]
        });
        return false;
    }
    function spf_selectOK(item, dialog){
        var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
        var data = fn(); 
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ;
        }
        $("#POST_ID").val(data.POST_ID);
        $("#POSTNAME").val(data.POST_NAME+'['+data.POST_ID+']');
        spf_search();
        dialog.close();
    }
    function spf_selectCancel(item, dialog){
        dialog.close();
    }
    function spf_selectClear(item, dialog){
        $("#POST_ID").val("");
        $("#POSTNAME").val("");
        dialog.close();
    }
    
    function f_initGrid(){
        $grid = $("#empQualificationInfo").ligerGrid({
            checkbox: false,
            columns: [
                        { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
                        { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120},  
                        { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},   
                        { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120}, 
                        { display: '<spring:message code="hrms.qualificationNumber"/>', name: 'QUALIFICATIONNUMBER', width: 90}, 
                        { display: '<spring:message code="hrms.qualificationName"/>', name: 'QUALIFICATIONNAMES', align: 'left', width: 400,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ],
            isScroll: true, frozen:false,enabledEdit:true,
            usePager: true,rownumbers: true, 
            url: '/report/hr/getEmpQualificationInfoList',
            pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
            width: '99.6%', height: '100%',
            detail: { onShowDetail: f_showQualificationDetail,height:'auto' }
        });
    }
    
    //显示证件详细信息
    function f_showQualificationDetail(row, detailPanel,callback)
    {
        var empId = row.EMPID;
        var qualificationGrid = document.createElement('div'); 
        $(detailPanel).append(qualificationGrid);
        $(qualificationGrid).css('margin',10).ligerGrid({
            columns:[
                        { display: '<spring:message code="hrms.certificateNumber"/>', name: 'QUAL_CARD_NO',width:120},
                        { display: '<spring:message code="hrms.certificateName"/>', name: 'QUAL_CARD_NAME',width:120},  
                        { display: '<spring:message code="hrms.certificationOffice"/>', name: 'QUAL_LOCATION',width:120},   
                        { display: '<spring:message code="hrms.effectDate"/>', name: 'DATE_OBTAINED',width:120}, 
                        { display: '<spring:message code="hrms.endDate"/>', name: 'END_QUAL_DATE',width:120},
                        { display: '<spring:message code="hrms.annualDate"/>', name: 'ANNUAL_DATE',width:120},
                        { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK',width:160,
                            editor: { type: 'textarea', height: 100 }
                        }
                    ], 
             isScroll: false, showToggleColBtn: false, width: '99%',enabledEdit:true,
             url: '/report/hr/getEmpQualificationDetailList?EMPID='+empId, 
             showTitle: false, columnWidth: 100,
             usePager: true,rownumbers: true,
             pageSize: 5, pageSizeOptions:[5,10,15,20,25,30]
        }); 
    }
  
    function spf_search(){
        $grid.setOptions({ parms: [
                                    { name: 'keyWord', value: $("#keyWord").attr('value')}, 
                                    { name: 'DEPTID', value: $("#DEPTID").attr('value')},
                                    { name: 'POST_ID', value: $("#POST_ID").attr('value')}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    //
    function spf_insExcel(colums){
        var deptId = $("#DEPTID").val();
        var postId = $("#POST_ID").val();
        var keyWord = $("#keyWord").val();
        location.href='/report/hr/getEmpQualificationInfoByExcel?DEPTID=' + deptId+'&POST_ID='+postId+'&keyWord='+keyWord;
        var manager = $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
    }
    </script>
    
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div position="center" id='' title=' '>
            <div position="top">
                <table width="99.6%" cellpadding="0" cellspacing="0"
                    class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                    <tr>
                        <td width="20%" class="l-table-edit-t"><spring:message
                                code="keyWord" /></td>
                        <td width="30%" class="l-table-edit-c"><input name="keyWord"
                            type="text" id="keyWord" size="30" /></td>
                        <td width="20%" class="l-table-edit-t"><spring:message
                                code="hrms.dept" /></td>
                        <td width="30%" class="l-table-edit-c"><SipingSoft:deptTree
                                name="DEPTID" limit="hr" /></td>
                    </tr>
                    <tr>
                        <td class="l-table-edit-t"><spring:message code="hrms.post" /></td>
                        <td class="l-table-edit-c" colspan="3"><input type="text"
                            name="POSTNAME" id="POSTNAME" value="" /> <input type="hidden"
                            name="POST_ID" id="POST_ID" /></td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" class="l-table-edit"
                    height="30">
                    <tr>
                        <td align="left"><SipingSoft:button /> <a class="l-button"
                            id="btn"
                            style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_insExcel()"><spring:message code="hrms.excelExport" /></a></td>
                    </tr>
                </table>
            </div>
            <div position="center" id='empQualificationInfo'></div>
        </div>
    </div>
</body>
</html>