<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>License Key管理</title>
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css"/>
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
    <link href="/resources/css/productStorage/prostor.css" rel="stylesheet" type="text/css"/>

    <script src="/resources/js/jquery/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        var $grid;
        $(function(){
            f_initGrid();
        });
        
        function f_initGrid() {
            $grid = $("#allLicenseTable").ligerGrid({
                columns: [
                          {display: "License Key", name: "licenseKey"},
                          {display: "激活类型", name: "activateType",render:function(item){
                              if(item.activateType==1){
                                  return "在线激活";
                              }else{
                                  return "网上激活";
                              }
                          }},
                          {display: "生效日期", name: "startDate"},
                          {display: "失效日期", name: "endDate"},
                          {display: "是否失效", name: "status",render:function(item){
                              if(item.status == 1){
                                  $("#licenseKey").val(item.licenseKey);
                                  $("#licenseKeyLabel").html(item.licenseKey);
                                  
                                  $("#activateType").val(item.activateType);
                                  if(item.activateType == 1){
                                      $("#activateTypeLabel").html("在线激活");
                                  }else{
                                      $("#activateTypeLabel").html("本地激活");
                                  }
                                  $("#startDateLabel").html(item.startDateStr);
                                  $("#endDateLabel").html(item.endDateStr);
                                  return "未失效";
                              }else{
                                  return "已失效";
                              }
                          }}
                ],
                enabledEdit : false,
                usePager : true,
                rownumbers : true,
                url : "/license/getLicenseList",
                pageSize:10,
                pageSizeOptions:[10,20,30,40,50],
                width:'99.8%',
                height:'100%'
            });
        }
        
        function spf_extendLimitation() {
            $.ligerDialog.open({ 
                title: '<spring:message code="prostor.theRoleOfInformation"/>',
                name:'winselector'+Math.random(),
                width: 800, 
                height: 450, 
                url: '/license/viewExtendLimitation',
                buttons: [
                            { text: '确认', onclick: spf_selectOK },
                            { text: '取消', onclick: spf_selectCancel }
                        ]
            });
        }
        
        function spf_selectOK(item, dialog){
            var fn = dialog.frame.spf_getExtendLimitationData || dialog.frame.window.spf_getExtendLimitationData; 
            var data = fn(); 
            if (!data){
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请输入数据') ; 
                return ;
            }
            if(data.licenseKey == ""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请输入License Key');
                return;
            }
            dialog.close();
            $.ligerDialog.waitting('更新中......');
            $.post("/activate/activate", 
                [   
                    { name: 'licenseKey', value: data.licenseKey },
                    { name: 'activateType', value: data.activateType }
                ]
                , function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('更新成功','<spring:message code="hrms.warning"/>', function (){
                            f_initGrid();
                        });
                    }else if(result.length>100){
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', "网络连接超时，请稍后再试");
                    }else{
                        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', result);
                    }
                }
            );
        }
        function spf_selectCancel(item, dialog){
            dialog.close();
        }
    </script>
</head>
<body>
    <div id="licenseManage">
        <div id="currentLicense">
            <div class="formHeader">当前生效的License Key</div>
            <form id="form1">
                <label class="l-table-edit-t label">License Key</label>
                <label class="l-table-edit-c value">
                    <input type=hidden id="licenseKey" name="licenseKey"/>
                    <label id="licenseKeyLabel"></label>
                </label>
    
                <label class="l-table-edit-t label">类型</label>
                <label class="l-table-edit-c value">
                    <input type="hidden" id="activateType" name="activateType"/>
                    <label id="activateTypeLabel"></label>
                </label>
    
                <br>
    
                <label class="l-table-edit-t label">生效日期</label>
                <label class="l-table-edit-c value">
                    <label id="startDateLabel"></label>
                </label>
                
                <label class="l-table-edit-t label">失效日期</label>
                <label class="l-table-edit-c value">
                    <label id="endDateLabel"></label>
                </label>
    
                <br>
                <input type="button" id="extend" class="l-button" onclick="spf_extendLimitation()" value="更新key"/>
            </form>
        </div>

        <div class="formHeader">历史使用记录</div>
        <div id="allLicenseTable"></div>

    </div>
</body>
</html>
