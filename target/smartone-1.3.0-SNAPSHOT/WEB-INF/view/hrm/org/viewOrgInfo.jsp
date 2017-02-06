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
    <script src="/resources/js/json2.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $grid ; 
    // 初始调用
    $(function (){
        //布局
         $("#layout1").ligerLayout({
                 allowLeftResize: false,      //是否允许 左边可以调整大小
                 allowRightResize: false,     //是否允许 右边可以调整大小
                 allowTopResize: false,      //是否允许 头部可以调整大小
                 allowBottomResize: false     //是否允许 底部可以调整大小
          });
         spf_initGrid();
    });

    function spf_initGrid(){
        $grid = $("#deptInfo").ligerGrid({
         checkbox: false,
            columns: [ 
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'DEPTNO', width: 80,hide: 1},
            { display: '<spring:message code="hrms.basicCode"/>', name: 'DEPTID', width: 90,hide: 1},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'DEPTNAME',width: 160,align: 'left'},
            { display: '<spring:message code="hrms.englishName"/>', name: 'DEPT_EN_NAME',width: 160,align: 'center'}, 
            { display: '<spring:message code="hrms.manager"/>', name: 'MANAGER_EMP_NAME',width: 80}, 
            { display: '<spring:message code="hrms.dept.parent"/>', name: 'PARENT_DEPT_NAME',width: 160,align: 'center'}, 
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',width: 160}, 
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS',width: 100}, 
            { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME',width: 120}
            ],
            usePager: true, rownumbers: false,
            pageSize: 20,
            url: '/hrm/org/getDeptInfo',
            width: '99.6%', height: '100%',
            showTitle: false,width:'99.5%',columnWidth:160,
            detail: { onShowDetail: spf_showDetailData,height:'auto' }
        });
    }
    function spf_showDetailData(row, detailPanel,callback){
        var grid = document.createElement('div'); 
        $(detailPanel).append(grid);
        $(grid).css('margin',10).ligerGrid({
            columns: [
                    { display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:100 },
                    { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:100},
                    { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:100},
                    { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:160},
                    { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:100},  
                    { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width:160}
                   ], 
                   usePager: true,rownumbers:true,dataAction: 'server', root: 'empInfoList', record: 'empInfoListCnt',
                   url: "/utility/empInfo/getEmpInfoList?DEPTID="+row.DEPTID, 
                   pageSize: 8, pageSizeOptions:[8,15, 20, 30, 40, 50],  
                   isScroll: false, showToggleColBtn: false, width: '80%', 
                   showTitle: false, columnWidth: 100, 
                   onAfterShowData: callback,allowUnSelectRow:true
        });
    }
    function f_ChildWindowClose (){
        $grid.loadData(true); //加载数据
        $dialog.close() ;
    }

    function spf_delete(){
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
            if(yes){
                 var rows = $grid.getSelectedRow();
                 if (!rows || rows.length == 0) {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                     return ;
                 }
                 if (rows.length > 1){
                    alert('<spring:message code="hrms.onlyOneRow"/>'); return;
                 }
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post("/hrm/org/deleteDeptInfo", 
                        [
                            { name: 'DEPTNO', value: rows.DEPTNO }
                        ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                        {
                            $grid.loadData(true); //加载数据  
                        });
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        }); 
    }

    function spf_search(){
        $grid.setOptions({ parms: [
                                    { name: 'keyWord', value: $("#keyWord").val()},
                                    { name: 'DEPTID', value: $("#DEPTID").val()},
                                    { name: 'ACTIVITY', value: $("#ACTIVITY").val()}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function spf_update(){
        var rows = $grid.getSelectedRow(); 
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return ; 
        }

        if (rows.length > 1){
            alert('<spring:message code="hrms.onlyOneRow"/>'); return;
        } 
        
        $dialog = $.ligerDialog.open({isDrag: false,  title:'<spring:message code="hrms.update"/>',
            width: $("#layout1").width()-60, height: $("#layout1").height()-50, url: '/hrm/org/updateDeptInfo?DEPTNO=' + rows.DEPTNO
          });
    }

    function spf_add(){
        $dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
             width: $("#layout1").width()-60, height: $("#layout1").height()-50, url: '/hrm/org/addDeptInfo'
          });
    }
    </script>
    <style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" > 
         <div align="left" position="center" id='' title=' ' >
          <div position="top">
                    <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">                
                        <tr>
                           <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
                           <td class="l-table-edit-c">
                                <input type="text" name="keyWord" id="keyWord" width="200px"/>
                           </td>
                            <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
                            <td class="l-table-edit-c">
                                <SipingSoft:deptTree name="DEPTID" onChange="spf_search()"/>
                            </td>
                           <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                           <td class="l-table-edit-c">
                                <SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search()"/>
                           </td>  
                       </tr> 
                   </table>
                    <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
                       <tr>
                            <td align="left"> 
                                <SipingSoft:button/>
                            </td>
                       </tr>
                    </table>
                </div>
               <div position="center" id="deptInfo" ></div>
            </div>
       </div>
</body>
</html>