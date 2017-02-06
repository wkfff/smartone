<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp" %>
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
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="/resources/js/ligerUI/js/plugins/ligerMessageBox.js" type="text/javascript"></script>
    <%@ include file="/resources/js/pcc.jsp" %>
    <link href="/resources/css/productStorage/prostor.css" rel="stylesheet" type="text/css"/>

    <script>
        var $grid;
        var $proList;
        var selectedRows;
        $(function () {
            f_initGrid();
            getHomeProvince();
        });

        function f_initGrid() {
            $grid = $("#storageList").ligerGrid({
                columns: [
                    {display: '<spring:message code="prostor.storage.id"/>', name: 'STORAGEID', width: '120'},
                    {display: '<spring:message code="prostor.storage.name"/>', name: 'STORAGENAME', width: '150'},
                    /* {display: '<spring:message code="prostor.storage.start.date"/>', name: 'STORAGESTARTDATE', width: '120'},
                    {display: '<spring:message code="prostor.storage.end.date"/>', name: 'STORAGEENDDATE', width: '120'}, */
                    {display: '<spring:message code="prostor.storage.addr"/>', name: 'FULLADDR', width: '200'},
                    {display: '<spring:message code="prostor.storage.remark"/>', name: 'STORAGEMEMO', width: '200'},
                    {display: 'NO', name: 'STORAGENO', width: '20',hide:1},
                    {display: '<spring:message code="prostor.storeInformation"/>', name: '',width: '120',render:function(item){
                        return "<a class='clickA' href='javascript:spf_showProList()'><spring:message code='hrms.clickToView'/></a>";
                    }}
                ],
                usePager: true,
                rownumbers: true,
                url: "/productStorage/storageManage/getStorageList",
                pageSize: 10,
                pageSizeOptions: [10, 20, 30, 40, 50],
                enabledSort:false,
                width: '99.8%',
                onDblClickRow: function(rowdata, rowindex, rowDomElement){
                    $("#STORAGE_NO").val(rowdata.STORAGENO);
                    $("#STORAGE_NAME").val(rowdata.STORAGENAME);
                    spf_showProList(rowdata.STORAGENO);
                }
            });
        }

        function spf_search() {
            $grid.setOptions({
                parms: [
                    {name: 'keyWord', value: $("#keyWord").val()},
                    {name: 'STORAGESTARTDATE', value: $("#S_DATE").val()},
                    {name: 'STORAGEENDDATE', value: $("#E_DATE").val()}
                ],
                newPage: 1
            });
            $grid.loadData(true);
        }

        function spf_add() {
            selectedRows = {};
            $("#saveButton").show();
            $("#upButton").hide();
            $("#storageDetailDiv input").val("");
            $("#HOME_PROVINCE").val("");
            spf_onProvinceChange();
            spf_onCityChange();
            $("#storageId").attr("disabled","");
            $("#storageDetailDiv").slideDown(500);
        }

        function spf_update() {
            selectedRows = $grid.getSelectedRows();
            var selectedRow;

            if (!selectedRows || selectedRows.length == 0) {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
                return;
            }
            if (selectedRows.length > 1) {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>');
                return;
            }
            $("#storageId").attr("disabled","disabled");
            selectedRow = selectedRows[0];
            getHomeProvince(selectedRow.PROVINCECODE, selectedRow.CITYCODE, selectedRow.COUNTYCODE);
            $("#upButton").show();
            $("#saveButton").hide();
            $("#storageDetailDiv").slideDown(500);
            $("#storageDetailDiv input").val("");

            $("#storageId").val(selectedRow.STORAGEID);
            $("#storageName").val(selectedRow.STORAGENAME);
            /* $("#storageStartDate").val(selectedRow.STORAGESTARTDATE);
            $("#storageEndDate").val(selectedRow.STORAGEENDDATE); */
            $("#HOME_PROVINCE").val(selectedRow.PROVINCECODE);
            $("#HOME_CITY").val(selectedRow.CITYCODE);
            $("#HOME_COUNTY").val(selectedRow.COUNTYCODE);
            $("#HOME_ADDRESS").val(selectedRow.STORAGEADDR);
            $("#storageMemo").val(selectedRow.STORAGEMEMO);
        }


        function spf_checkdata() {
            if ($("#storageName").val() == "") {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.storage.name.empty"/>');
                return;
            }
            /* if ($("#storageStartDate").val() == "") {
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="prostor.storage.start.date.empty"/>');
                return;
            } */
            return true;
        }
        function spf_saveStorage(behaviour) {
            var postParam = [
                { name: "storageId", value: $("#storageId").val()},
                { name: "storageName", value: $("#storageName").val()},
                /* { name: "storageStartDate", value: $("#storageStartDate").val()},
                { name: "storageEndDate", value: $("#storageEndDate").val()}, */
                { name: "storageStartDate", value: ""},
                { name: "storageEndDate", value: ""},
                { name: "storageAreaCode", value: $("#HOME_AREA").val()},
                { name: "storageAddr", value: $("#HOME_ADDRESS").val()},
                { name: "storageMemo", value: $("#storageMemo").val()}
            ];
            if (behaviour === "update") {
                postParam = postParam.concat([
                    { name: "storageNo", value: selectedRows[0].STORAGENO}
                ]);
            };
            if (spf_checkdata()) {
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post("/productStorage/storageManage/saveStorage",
                        postParam,
                        function (result) {
                            $.ligerDialog.closeWaitting();
                            if (result == "Y") {
                                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>', function () {
                                    $grid.loadData(true);
                                    spf_clear();
                                });
                            }
                            else {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                );
            }
        }

        function spf_clear() {
            $("#storageDetailDiv input").val("");
            $("#HOME_PROVINCE").val("");
            spf_onProvinceChange();
            spf_onCityChange();
            $("#storageId").attr("disabled","");
            $("#storageDetailDiv").slideUp(500);
        }

        function spf_delete() {
            $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>', '<spring:message code="hrms.warning"/>',
                    function (yes) {
                        if (yes) {
                            selectedRows = $grid.getSelectedRows();
                            if (!selectedRows || selectedRows.length == 0) {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
                                return;
                            }

                            if (selectedRows.length > 1) {
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>');
                                return;
                            }

                            $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                            $.post('/productStorage/storageManage/deleteStorage',
                                    [
                                        {name: 'NO', value: selectedRows[0].STORAGENO}
                                    ],
                                    function (result) {
                                        $.ligerDialog.closeWaitting();
                                        if (result == "Y") {
                                            $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>', function () {
                                                $grid.loadData(true);
                                                spf_clear();
                                            });
                                        } else if (result == "N") {
                                            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>',
                                                    '<spring:message code="prostor.storage.delete.failure"/>');
                                        } else {
                                            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotdelete"/>');
                                        }
                                    }
                            );
                        }
                    });
        }
        function spf_onProvinceChange() {
            getArea('city', 'Home', '');
        }
        function spf_onCityChange() {
            getArea('county', 'Home', '');
        }
        function spf_showProList(){
            var row = $grid.getSelectedRow();
            if (!row || row.length == 0) { 
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                return ; 
            }
            $("#STORAGE_NO").val(row.STORAGENO);
            $("#STORAGE_NAME").val(row.STORAGENAME);
            $("#showProducts").show();
            var STOR_NAME = row.STORAGENAME;
            $("#storNamePros").text('<spring:message code="prostor.storageDetail"/>('+STOR_NAME+')');
            $proList = $("#storageProList").ligerGrid({
                columns: [
                          {display: '<spring:message code="hrms.itemCode"/>', name: 'PRODUCT_ID', width: '120'},
                          {display: '<spring:message code="hrms.productName"/>', name: 'PRODUCT_NAME', width: '150'},
                          {display: '<spring:message code="hrms.productSpecification"/>', name: 'SPECIFICATION', width: '120'},
                          {display: '<spring:message code="prostor.storeQuantity"/>', name: 'LEFT_QUANTITY', width:'120'},
                          {display: '<spring:message code="hrms.unit"/>', name: 'CODE_NAME', width:'120'},
                          {display: '', name: 'UNIT_CODE_ID', width:'10',hide:1},
                          {display: '<spring:message code="prostor.warningValue"/>', name: 'MIN_QUANTITY', width:'80'},
                          {display: '<spring:message code="prostor.storeAddr"/>', name: 'STOR_ADDR', width:'200'},
                          {display: '<spring:message code="hrms.active"/>', name: 'STATUS', width: '100',render:function(item){
                              if(item.STATUS == 1 ){
                                  return '<p style="color: green;"><spring:message code="hrms.enable"/></p>';
                              }else{
                                  return '<p style="color: red;"><spring:message code="hrms.disable"/></p>';
                              }
                          }}/* ,
                          {display: '操作', name: '', width:'100',render:function(item){
                              return '<a class="clickA" href="#">参数设置</a>&nbsp;&nbsp;<a class="clickA" href="#">移除</a>';
                          }} */
                      ],
                      usePager: true,
                      rownumbers: true,
                      parms : [
                            {name:'STORAGE_NO',value : row.STORAGENO}
                        ],
                      url: "/productStorage/storageManage/getStorageProList",
                      pageSize: 10,
                      pageSizeOptions: [10, 20, 30, 40, 50],
                      width: '99.8%',
                      height: '320',
                      rowAttrRender: function (rowdata){
                          //alert(rowdata.LEFT_QUANTITY +"-"+ rowdata.MIN_QUANTITY);
                          if (parseFloat(rowdata.LEFT_QUANTITY) < parseFloat(rowdata.MIN_QUANTITY)){
                              //alert(rowdata.LEFT_QUANTITY +"-"+ rowdata.MIN_QUANTITY);
                              return "style='color:red;'";
                          }else{
                              return "style='color:black;'";
                          }
                      }
           });
        }
        function spf_searchPros(type){
            if(type == 2){
                $proList.setOptions({
                    parms : [
                                {name:'proKeyWords',value : $("#proKeyWords").val()},
                                {name:'STORAGE_NO',value : $("#STORAGE_NO").val()},
                                {name:'Warning',value : "true"}
                            ],
                    newPage:1
                });
            }else{
                $proList.setOptions({
                    parms : [
                                {name:'proKeyWords',value : $("#proKeyWords").val()},
                                {name:'STORAGE_NO',value : $("#STORAGE_NO").val()}
                            ],
                    newPage:1
                });
            }
            
            $proList.loadData(true);
        }
        
        function spf_proTransfer(){
            var row = $proList.getSelectedRow();
            if (!row || row.length == 0) { 
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
                return ; 
            }
            $dialog = $.ligerDialog.open({isDrag: true,
                title: '<spring:message code="prostor.stockTransfer"/>',
                width: 800 , 
                height: 400 ,
                url: '/productStorage/storageManage/viewProductTransfer?PRODUCT_NO='+row.PRODUCT_NO+'&STORAGE_NO='+$("#STORAGE_NO").val()
                        +'&page=1&pagesize=10'
            });
        }
        
        function f_ChildWindowClose(){
            $proList.setOptions({
                parms : [
                            {name:'STORAGE_NO',value : $("#STORAGE_NO").val()}
                        ],
                newPage:1
            });
            $proList.loadData(true);
            $dialog.close();
        }
    </script>
    <style type="text/css">
    #showProducts{
        display: none;
    }
    .clickA{
        color:green;
        text-decoration:none;
    }
    </style>
</head>
<body>
<div id="layout1">
    <div position="top">
        <div id="storageSearch">
            <div class="form">
                    <div class="l-table-edit-t label"><spring:message code="keyWord"/></div>
                    <div
                            class="l-table-edit-c value"><input class="inputClass" type="text" name="keyWord" id="keyWord" 
                            title="<spring:message code='prostor.Youcanenterthe '/>"/></div>
                    <%-- <div class="l-table-edit-t label"><spring:message code="prostor.storage.search.date"/></div>
                    <div class="l-table-edit-c value">
                        <input type="text" name="S_DATE" id="S_DATE"
                               onclick="WdatePicker({lang:<spring:message
                                       code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                               readonly="readonly" class="inputClass"/> ~
                        <input type="text" name="E_DATE" id="E_DATE"
                               onclick="WdatePicker({lang:<spring:message
                                       code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                               readonly="readonly" class="inputClass"/>
                    </div> --%>
            </div>
            <table class="buttonGroup">
                <tr>
                    <td>
                        <SipingSoft:button/>
                    </td>
                </tr>
            </table>
        </div>

        <div id="storageDetailDiv">
            <div class="formHeader"><spring:message code="edit"/></div>
            <div class="form1">
                    <div class="l-table-edit-t label"><spring:message code="prostor.storage.id"/></div>
                    <div class="l-table-edit-c value"><input class="inputClass" type="text" name="keyWord" id="storageId"/></div>
                    <div class="l-table-edit-t label"><spring:message code="prostor.storage.search.name"/></div>
                    <div class="l-table-edit-c value"><input class="inputClass" type="text" name="keyWord" id="storageName"/></div>
                <br>

                    <%-- <div class="l-table-edit-t label"><spring:message code="prostor.storage.start.date"/></div>
                    <div class="l-table-edit-c value">
                        <input class="inputClass" type="text" name="storageStartDate" id="storageStartDate"
                               onclick="WdatePicker({lang:<spring:message
                                       code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                               readonly="readonly"/>
                    </div>

                    <div class="l-table-edit-t label"><spring:message code="prostor.storage.end.date"/></div>
                    <div class="l-table-edit-c value">
                        <input class="inputClass" type="text" name="storageEndDate" id="storageEndDate"
                               onclick="WdatePicker({lang:<spring:message
                                           code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                               readonly="readonly"/>
                    </div>
                <br> --%>

                    <div class="l-table-edit-t label"><spring:message code="prostor.storage.addr"/></div>
                    <div class="l-table-edit-c value">
                        <select name="HOME_PROVINCE" id="HOME_PROVINCE" onChange="spf_onProvinceChange()"></select>
                        <select name="HOME_CITY" id="HOME_CITY" onChange="spf_onCityChange()"></select>
                        <select name="HOME_AREA" id="HOME_AREA"></select>
                        <input type="text" name="HOME_ADDRESS" id="HOME_ADDRESS"/>
                    </div>

                <br>
                    <div class="l-table-edit-t label"><spring:message code="prostor.storage.remark"/></div>
                    <div class="l-table-edit-c value"><input class="inputClass" type="text" name="storageMemo"
                                                             id="storageMemo"/></div>
            </div>
            <ul class="buttonGroup">
                <li><a class="l-button" onclick="spf_saveStorage('addNew')" id="saveButton"><spring:message
                        code="hrms.save"/></a></li>
                <li class="updatebtn"><a class="l-button" onclick="spf_saveStorage('update')"
                                      id="upButton"><spring:message
                        code="hrms.save"/></a></li>
                <li><a class="l-button" onclick="spf_clear()"><spring:message code="cancel"/></a></li>
            </ul>
        </div>

    </div>
    <div class="formHeader"><spring:message code="prostor.storage.list"/></div>
    <div position="center" id="storageList"></div>
    <div position="center" id="showProducts">
        <div class="formHeader" id="storNamePros"></div>
        <input type="hidden" id="STORAGE_NO" name="STORAGE_NO"/>
        <input type="hidden" id="STORAGE_NAME" name="STORAGE_NAME"/>
        <table style="font-size: 12px; border: 0px; margin-bottom: 5px;margin-left: 25px;">
            <tr>
                <td style="border: 0px;">
                    <input type="text" name="proKeyWords" id="proKeyWords" style="float:left; width:200px;height:20px;
                        border: 1px solid gray; text-align: left; margin-right: 5px;"/>
                    <a class="l-button" style="float:left;margin-left:10px;" 
                        onclick="spf_searchPros(1)"><spring:message code="search"/></a>
                    <a class="l-button" style="float:left;margin-left:10px;" 
                        onclick="spf_searchPros(2)"><spring:message code="prostor.warningSearch"/></a>
                    <a class="l-button" style="float:left;margin-left:10px;" 
                        onclick="spf_proTransfer()"><spring:message code="prostor.proTransfer"/></a>
                </td>
            </tr>
        </table>
        <div id="storageProList"></div>
    </div>
</div>
</body>
</html>
