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
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="/resources/js/json2.js" type="text/javascript"></script>
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    var $grid ;
    // 初始调用
    $(function() {
        //布局
        $("#layout1").ligerLayout({
                topHeight: 80,
                allowLeftResize: false,      //是否允许 左边可以调整大小
                allowRightResize: false,     //是否允许 右边可以调整大小
                allowTopResize: false,      //是否允许 头部可以调整大小
                allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
        $grid = $("#rolesGroupPageInfo").ligerGrid({
            checkbox: false,
            columns: [
                { display: '<spring:message code="hrms.sequence"/>', name: 'MENU_NO', width: 90, type: 'int' ,frozen:true},
                { display: '<spring:message code="hrms.level"/>', name: 'DEPTH', width: 70, align: 'center',frozen:true},
                { display: '<spring:message code="hrms.basicCode"/>', name: 'MENU_CODE', width: 90, align: 'center',frozen:true},
                { display: '<spring:message code="hrms.chineseName"/>', name: 'MENU_INTRO', width: 160,align: 'left',frozen:true},
                { display: '<spring:message code="hrms.englishName"/>', name: 'MENU_EN_INTRO', width: 160,align: 'left',frozen:true},
                { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',width: 100, align: 'left',frozen:true},
                { display: '<spring:message code="hrms.add"/>', name: 'RInsert', width: 60, render: function (row, index)
                    {
                        if(row.INSERTR == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'I\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'I\','+row.MENU_NO+')" >';
                        }
                    }
                },
                { display: '<spring:message code="hrms.save"/>', name: 'RSave', width: 60, render: function (row, index)
                    {
                        if(row.SAVER == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'B\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'B\','+row.MENU_NO+')" >';
                        }
                    }
                },
                { display: '<spring:message code="hrms.update"/>', name: 'RUpdate', width: 60, render: function (row, index)
                    {
                        if(row.UPDATER == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'U\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'U\','+row.MENU_NO+')" >';
                        }
                    }
                },
                { display: '<spring:message code="hrms.delete"/>', name: 'RDelete', width: 60, render: function (row, index)
                    {
                        if(row.DELETER == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'D\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'D\','+row.MENU_NO+')" >';
                        }
                    }
                },
                { display: '<spring:message code="confirm"/>', name: 'RCancel', width: 60, render: function (row, index)
                    {
                        if(row.CANCELR == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'C\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'C\','+row.MENU_NO+')" >';
                        }
                    }
                },
                { display: '<spring:message code="search"/>', name: 'RFore', width: 60, render: function (row, index)
                    {
                        if(row.SELECTR == 0){
                            return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="f_save(1,\'S\','+row.MENU_NO+')" >';
                        }else{
                            return '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="f_save(0,\'S\','+row.MENU_NO+')" >';
                        }
                    }
                }
            ],
            usePager: true, dataAction: 'server', root: 'rolesGroupPageList', record: 'rolesGroupPageCnt', enabledSort: true,
            url: '/system/rightsManagement/getRolesGroupPageInfo?SCREEN_GRANT_ID=${rolesGroupInfo.SCREEN_GRANT_ID}',
            width: '99%', height: '99%'
        });
    });

    function spf_search()
    {
        $grid.setOptions({ parms: [
                                    { name: 'MENU_CODE', value: $("#MENU_CODE").val()}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

      function f_save(flag,tag,MenuNo){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            $('#FLAG').attr('value' , flag) ;
            $('#MENU_NO').attr('value' , MenuNo) ;
            $('#MENU_TAG').attr('value' , tag) ;
            var options = {
                    url:'/system/rightsManagement/updateRolesGroupInfo',
                    type:'POST',
                    success: function (result){
                    $.ligerDialog.closeWaitting();
                        if (result == "Y")
                            {
                                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                                {
                                    $grid.loadData(true);
                                    parent.f_ChildWindowClose() ;
                                });
                            }
                            else
                            {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    };
              $('#form1').ajaxSubmit(options);

    }

</script>

    <style type="text/css">
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" >
     <div style="border:1px solid #A3C0E8;" >
      <div align="left">
         <form name="form1" method="post" action="" id="form1">
                        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                        <tr>
                            <td class="l-table-edit-t"><spring:message code="hrms.basicCode"/></td>
                            <td class="l-table-edit-c" width="10%">
                                <input id="MENU_TAG" name="MENU_TAG" type="hidden" value=""/>
                                <input id="FLAG" name="FLAG" type="hidden" value=""/>
                                <input id="MENU_NO" name="MENU_NO" type="hidden" value=""/>
                                <input id="SCREEN_GRANT_ID" name="SCREEN_GRANT_ID" type="hidden" value="${rolesGroupInfo.SCREEN_GRANT_ID}"/>
                                <input id="SCREEN_GRANT_NO" name="SCREEN_GRANT_NO" type="hidden" value="${rolesGroupInfo.SCREEN_GRANT_NO}"/>
                                ${rolesGroupInfo.SCREEN_GRANT_ID}
                            </td>
                            <td class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                            <td class="l-table-edit-c">
                                <input name="SCREEN_GRANT_NAME" type="text" value="${rolesGroupInfo.SCREEN_GRANT_NAME}" id="SCREEN_GRANT_NAME" ltype="text" validate="{required:true}" />
                            </td>
                            <td class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
                            <td class="l-table-edit-c">
                                <input name="SCREEN_GRANT_EN_NAME" value="${rolesGroupInfo.SCREEN_GRANT_EN_NAME}" type="text" id="SCREEN_GRANT_EN_NAME" ltype="text"  validate="{required:true}"/>
                            </td>
                        </tr>
                            <tr>
                                <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:selectCompany name="CPNY_ID" selected="${rolesGroupInfo.CPNY_ID}"/>
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                                <td class="l-table-edit-c">
                                    <SipingSoft:selectStatus name="ACTIVITY" selected="${rolesGroupInfo.STATUS_ID}"/>
                                </td>
                                <td class="l-table-edit-t"><spring:message code="hrms.description"/></td>
                                <td class="l-table-edit-c" >
                                    <textarea cols="100" rows="2" name="DESCRIPTION" id="DESCRIPTION" style="width:400px" >${rolesGroupInfo.DESCRIPTION}</textarea>
                                </td>
                            </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" class="l-table-edit" >
                       <tr>
                           <td height="32px">
                                <a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;" onclick="f_save()"><spring:message code="hrms.save"/></a>
                                <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>

                           </td>
                           <td height="32px">
                                &nbsp; &nbsp;
                           </td>
                           <td colspan="8" height="32px">
                                <SipingSoft:select dataListName="menuSelectList" name="MENU_CODE" limit="all"/>
                           </td>
                       </tr>
                   </table>
         </form>
      </div>
      <div position="center" id='rolesGroupPageInfo'></div>
 </div>
</div>
</body>
</html>
