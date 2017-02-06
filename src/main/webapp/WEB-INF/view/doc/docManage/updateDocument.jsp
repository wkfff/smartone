<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/ligerUI/js/ligerui-1.2.2.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var $OBJ_TYPE = 'ADMIN';
    var $dialog = null;
    var $filegrid=null;
    var $curgrid = null;
    var $admingrid=null;
    var $materialgrid=null;
    var $custgrid=null;
    var $projgrid=null;
    var $productgrid=null;
    $(function (){
         $("#layout1").ligerLayout({
             allowLeftResize: false,      //是否允许 左边可以调整大小
             allowRightResize: false,     //是否允许 右边可以调整大小
             allowTopResize: false,      //是否允许 头部可以调整大小
             allowBottomResize: false     //是否允许 底部可以调整大小
          });
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid)
          {
            if(tabid=="tabitem1"){
                //已经分组人员
                $OBJ_TYPE = 'ADMIN';
                spf_admin_initGrid();
                $curgrid = $admingrid;
            }
            if(tabid=="tabitem2"){
                $OBJ_TYPE = 'CUST';
                spf_customer_initGrid();
                $curgrid = $custgrid;
            }
            if(tabid=="tabitem3"){
                //已经分组人员
                $OBJ_TYPE = 'PROJ';
                spf_project_initGrid();
                $curgrid = $projgrid;
            }
            if(tabid=="tabitem4"){
                //已经分组人员
                $OBJ_TYPE = 'MAT';
                spf_material_initGrid();
                $curgrid = $materialgrid;
            }
            if(tabid=="tabitem5"){
                //已经分组人员
                $OBJ_TYPE = 'PRODUCT';
                spf_product_initGrid();
                $curgrid = $productgrid;
            }
          }
          });
         spf_file_initGrid();
         spf_admin_initGrid();
         $curgrid = $admingrid;
    });

    function spf_file_initGrid(){
        $filegrid = $("#docFileInfo").ligerGrid({
            columns: [
                        { display: '', name: 'no', width: 0,hide: 1},
                        { display: '<spring:message code="hrms.fileName"/>', name: 'name', width: 350},
                        { display: '<spring:message code="hrms.fileVesion"/>', name: 'version', width:120,
                            render:function(item){
                                return "Ver. "+item.version;
                            }
                        },
                        { display: '<spring:message code="hrms.fileStatus"/>', name: 'active', width: 120,
                            render:function(item){
                                if(item.active=='0'){
                                    return '<img src="/resources/images/notuse.png">';
                                }
                                if(item.active=='1'){
                                    return '<img src="/resources/images/inuse.png">';
                                }
                            }
                        },
                        { display: '<spring:message code="hrms.fileLocking"/>', name: 'locked', width: 120,
                            render:function(item){
                                if(item.locked=='0'){
                                    return '<img src="/resources/images/lock_open.gif">';
                                }
                                if(item.locked=='1'){
                                    return '<img src="/resources/images/lock.gif">';
                                }
                            }
                        },
                        { display: '<spring:message code="hrms.detection"/>', name: 'lockUser.chineseName', width: 120}
                    ],
            rownumbers:true,
            resizable:false,
            usePager:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getFileList?DOC_NO='+$('#DOC_NO').val(),
            parms: [
                   ],
            width: '99.6%', height: '200px'
        });
    }
    function spf_updateFileGrid(){
        $filegrid.setOptions({ parms: [
                                    { name: 'active', value: $("#active").attr('value')}
                                   ]
                         });
        $filegrid.loadData(true);
    }

    function spf_admin_initGrid(){
        $admingrid = $("#docAdminInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_ID', width: 200},
                        { display: '<spring:message code="hrms.userID"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewUser"/>',  width: 200,
                            render: function (item){
                               return '<div style="cursor: pointer;" onClick="spf_viewAdminDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.viewUser"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_ID='+$('#DOC_ID').val(),
            parms: [
                     { name: 'OBJ_TYPE', value: 'ADMIN'}
                   ],
            width: '100%', height: '200px',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewAdminDetail(rowdata.OBJ_ID);
            }
        });
    }

    function spf_viewAdminDetail(ADMIN_ID){
        if(tab.isTabItemExist('hr0101')){
            tab.removeTabItem('hr0101');
        }
        tab.addTabItem({ tabid : 'hr0101',text: '员工信息', url: '/hrm/empinfo/viewPersonalInfo?MENU_CODE=hr0101&EMPID='+ADMIN_ID });
    }

    function spf_project_initGrid(){
        $projgrid = $("#docProjectInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_ID', width: 200},
                        { display: '<spring:message code="hrms.projectNumber"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.reviewProject"/>',  width: 200,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_viewProjectDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.reviewProject"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_NO='+$('#DOC_NO').val(),
            parms: [
                     { name: 'OBJ_TYPE', value: 'PROJ'}
                   ],
            width: '100%', height: '200px',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewProjectDetail(rowdata.OBJ_ID);
            }
        });
    }

    function spf_viewProjectDetail(PROJ_ID){
        alert('项目模块完善中');
    }

    function spf_customer_initGrid(){
        $custgrid = $("#docCustomerInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_ID', width: 200},
                        { display: '<spring:message code="hrms.customerNumber"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewCustomer"/>',  width: 200,
                            render: function (item){
                               return '<div style="cursor: pointer;" onClick="spf_viewCustomerDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.viewCustomer"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_NO='+$('#DOC_NO').val(),
            parms: [
                     { name: 'OBJ_TYPE', value: 'CUST'}
                   ],
            width: '100%', height: '200px',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewCustomerDetail(rowdata.OBJ_ID);
            }
        });
    }

    function spf_viewCustomerDetail(CUST_ID){
        if(tab.isTabItemExist('cust0102')){
            tab.removeTabItem('cust0102');
        }
        tab.addTabItem({ tabid : 'cust0102',text: '<spring:message code="hrms.customerInformation"/>', url: '/cust/custInfo/viewCustomerDetail?MENU_CODE=cust0102&CUST_ID='+CUST_ID });
    }

    function spf_material_initGrid()
    {
        $materialgrid = $("#docMATInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_ID', width: 200},
                        { display: '<spring:message code="hrms.materialNumber"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewMaterial"/>',  width: 200,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_viewMaterialDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.viewMaterial"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_NO='+$('#DOC_NO').val(),
            parms: [
                     { name: 'OBJ_TYPE', value: 'MAT'}
                   ],
            width: '100%', height: '200px',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewMaterialDetail(rowdata.OBJ_ID);
            }
        });
    }

    function spf_viewMaterialDetail(MAT_ID){
        if(tab.isTabItemExist('mat0102')){
            tab.removeTabItem('mat0102');
        }
        tab.addTabItem({ tabid : 'mat0102',text: '<spring:message code="hrms.materialInformation"/>', url: '/mat/matInfo/viewMaterialDetail?MENU_CODE=mat0102&MAT_ID='+MAT_ID });
    }

    function spf_product_initGrid(){
        $productgrid = $("#docProductInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_ID', width: 200},
                        { display: '<spring:message code="hrms.productCode"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.reviewItem"/>',  width: 200,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_viewProductDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.reviewItem"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_NO='+$('#DOC_NO').val(),
            parms: [
                     { name: 'OBJ_TYPE', value: 'PRODUCT'}
                   ],
            width: '100%', height: '200px',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
                spf_viewProductDetail(rowdata.OBJ_ID);
            }
        });
    }

    function spf_viewProductDetail(pid){
        if(tab.isTabItemExist('prosto0106')){
            tab.removeTabItem('prosto0106');
        }
        tab.addTabItem({ tabid : 'prosto0106',text: '<spring:message code="hrms.itemDetails"/>', url: '/productStorage/productManage/viewProductDetail?PRODUCT_ID='+pid });
    }

    function spf_update(){
        spf_save();
    }

    function spf_save() {
        if($('#DOC_NO').val()==null||$('#DOC_NO').val()==''){
            return;
        }
        if(spf_checkData()){
            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
            var $documentJson = {};
            $documentJson.name = $("#DOC_NAME").val();
            $documentJson.no = $("#DOC_NO").val();
            $documentJson.description = $("#DESCRIPTION").val();
            $documentJson.part = $("#DOC_PART").val();
            $documentJson.version = $("#DOC_VERSION").val();
            $documentJson.processRunning = {};
            $documentJson.processRunning.no = '${documentDetail.processRunning.no}';
            $documentJson.processRunning.type = {};
            $documentJson.processRunning.type.no = $("#DOC_TYPE_NO").val();
            $documentJson.processRunning.state = {};
            $documentJson.processRunning.state.no = $("#DOC_STATUS_NO").val();

            $.post("/doc/docManage/transferDocument", [
                       { name: 'jsonData', value: JSON.stringify($documentJson) }
                     ]
            ,  function (result){
               $.ligerDialog.closeWaitting();
                if (result.code == 0){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                       spf_refresh();
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                }
            });
         }
     }
    function spf_checkData(){
       if ($("#DOC_STATUS_NO").val() == null || $("#DOC_STATUS_NO").val() == "") {
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.docStatus"/>'+". " + '<spring:message code="input.required"/>') ;
             return false;
       }
       return true;
    }

    var tab = parent.tab;
    function spf_refresh(){
        var DOC_NO = '${documentDetail.no}';
        location.href = "/doc/docManage/updateDocument?MENU_CODE=doc0202&documentNo="+DOC_NO;
    }

    function spf_addFile(){
        $dialog = $.ligerDialog.open({
            isDrag: false,
            title:'<spring:message code="hrms.uploadFile"/>',
            width: 550,
            height: 300,
            isResize: true,
            url: '/doc/docManage/viewUploadFile?documentNo='+$('#DOC_NO').val()+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val()+'&r='+Math.random()
        });
    }

    function spf_deleteFile(){
        var row = $filegrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        $.ligerDialog.confirm('<spring:message code="hrms.AreYouSureToDeleteTheFile"/>',function(yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/doc/docManage/deleteFile?documentNo='+$('#DOC_NO').val()+'&fileNo='+row.no+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val(),
                   function (result) {
                    $.ligerDialog.closeWaitting();
                       if (result.code == 0) {
                           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                               spf_file_initGrid();
                           });
                       }  else {
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                       }
                   });
             }
        });
    }

    function spf_downloadFile(){
        var row = $filegrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        location.href ='/doc/docManage/downloadFile?documentNo='+$('#DOC_NO').val()+'&fileNos='+row.no+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val();
    }

    function spf_checkOutFile(){
        var row = $filegrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
         }
         $.ligerDialog.confirm('<spring:message code="hrms.AreYouSureYouCheckOutTheFile"/>',function(yes) {
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/doc/docManage/checkOutFile?documentNo='+$('#DOC_NO').val()+'&fileNo='+row.no+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val(),
                   function (result) {
                    $.ligerDialog.closeWaitting();
                       if (result.code == 0) {
                           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                               spf_file_initGrid();
                               window.open('/doc/docManage/downloadFile?documentNo='+$('#DOC_NO').val()+'&fileNos='+row.no+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val());
                           });
                       } else {
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                       }
                   });
             }
        });

    }

    function spf_releaseFileLock(){
        var row = $filegrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
         }
         $.ligerDialog.confirm('<spring:message code="hrms.AreYouSureYouReleaseTheFileLock"/>',function(yes){
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/doc/docManage/releaseFileLock?documentNo='+$('#DOC_NO').val()+'&fileNo='+row.no,
                   function (result) {
                    $.ligerDialog.closeWaitting();
                       if (result.code == 0) {
                           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                               spf_file_initGrid();
                           });
                       } else {
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                       }
                   });
             }
        });
    }

    function spf_checkInFile(){
        var row = $filegrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
         }
        if (row.locked =='0'){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.FileIsNotLocked"/>') ;
            return ;
         }
        $.post('/doc/docManage/checkPermission?documentNo='+$('#DOC_NO').val()+'&fileNo='+row.no,
            function (result) {
                 if (result.code == 0) {
                     $dialog = $.ligerDialog.open({
                        isDrag: false,
                        title:'<spring:message code="hrms.CheckInFiles"/>',
                        width: 500,
                        height: 300,
                        isResize: true,
                        url: '/doc/docManage/viewCheckInFile?documentNo='+$('#DOC_NO').val()+'&fileNo='+row.no
                     });
                  } else {
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.message);
                  }
             });
    }

    function reloadDocObject(){
        if($OBJ_TYPE=='ADMIN'){
            $admingrid.loadData(true);
        }
        if($OBJ_TYPE=='CUST'){
            $custgrid.loadData(true);
        }
        if($OBJ_TYPE=='PROJ'){
            $projgrid.loadData(true);
        }
        if($OBJ_TYPE=='MAT'){
            $materialgrid.loadData(true);
        }
        if($OBJ_TYPE=='PRODUCT'){
            $productgrid.loadData(true);
        }
    }

    function spf_addDocObject(){
        var $title = '';
        var $url = '';
        if($OBJ_TYPE=='ADMIN'){
            var $title = '<spring:message code="hrms.StaffList"/>';
            var $url = '/utility/empInfo/viewHrSearchEmployeeB';
        }
        if($OBJ_TYPE=='CUST'){
            var $title = '<spring:message code="hrms.CustomerList"/>';
            var $url = '/utility/custInfo/viewCustomerList';
        }
        if($OBJ_TYPE=='PROJ'){
            var $title = '<spring:message code="hrms.projectList"/>';
            var $url = '/utility/projInfo/viewProjectList';
        }
        if($OBJ_TYPE=='MAT'){
            var $title = '<spring:message code="hrms.materialsList"/>';
            var $url = '/utility/matInfo/viewMaterialList';
        }
        if($OBJ_TYPE=='PRODUCT'){
            var $title = '<spring:message code="hrms.goodsList"/>';
            var $url = '/utility/proInfo/viewProductListB';
        }
        $.ligerDialog.open({
            title: $title,
            name:'objectselector'+Math.random(),
            width: 800,
            height: 400,
            url: $url,
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectObjectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectObjectCancel }
            ]
        });
    }

    function spf_selectObjectOK(item, dialog)
    {
        var fn ;
        if($OBJ_TYPE=='ADMIN'){
            fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo;
        }
        if($OBJ_TYPE=='CUST'){
            fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer;
        }
        if($OBJ_TYPE=='PROJ'){

        }
        if($OBJ_TYPE=='MAT'){
            fn = dialog.frame.spf_selectMaterial || dialog.frame.window.spf_selectMaterial;
        }
        if($OBJ_TYPE=='PRODUCT'){
            fn = dialog.frame.spf_selectProduct || dialog.frame.window.spf_selectProduct;
        }
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        var $obj_id;
        if($OBJ_TYPE=='ADMIN'){
            $obj_id=data.EMPID;
        }
        if($OBJ_TYPE=='CUST'){
            $obj_id=data.CUST_ID;
        }
        if($OBJ_TYPE=='PROJ'){

        }
        if($OBJ_TYPE=='MAT'){
            $obj_id=data.MAT_ID;
        }
        if($OBJ_TYPE=='PRODUCT'){
            $obj_id=data.PRODUCT_ID;
        }

         $.post('/doc/docManage/addDocObject',{"OBJ_TYPE":$OBJ_TYPE,"DOC_ID":$('#DOC_ID').val(),"OBJ_ID":$obj_id,"DOC_TYPE_ID":$("#DOC_TYPE_ID").val()},function(result){
             if(result=='Y'){
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                    {
                        reloadDocObject();
                    });
             }else{
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
             }
         });
        dialog.close();
    }
    function spf_selectObjectCancel(item, dialog)
    {
        dialog.close();
    }

    function checkDocumentID()
    {
         if($('#id_type:checked').val()!='O'){
            $('#tipid').html('<font color="green"><spring:message code="hrms.available"/></font>');
            return;
         }
         var documentID = $("#DOC_T_ID").val();
         if(documentID==''){
            $('#tipid').html('<font color="red"><spring:message code="hrms.required"/></font>');
            return;
         }
         $.post('/doc/docInfo/checkDocumentID',{"DOC_NO":documentNO},function(result){
             if(result=='0'){
                $('#tipid').html('<font color="green"><spring:message code="hrms.available"/></font>');
             }else{
                $('#tipid').html('<font color="red"><spring:message code="hrms.unavailable"/></font>');
             }
         });
    }

    function spf_deleteDocObject(){
        var row = $curgrid.getSelectedRow();
        if (!row || row.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
         }
        $.ligerDialog.confirm('<spring:message code="hrms.deleteAssociation"/>',function(yes)
         {
            if(yes){
                $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                $.post('/doc/docManage/deleteDocObject?DOC_NO='+$('#DOC_NO').val()+'&OBJ_ID='+row.OBJ_ID+'&OBJ_TYPE='+$OBJ_TYPE+'&DOC_TYPE_NO='+$("#DOC_TYPE_NO").val(),
                   function (result)
                   {
                    $.ligerDialog.closeWaitting();
                       if (result == "Y")
                       {
                           $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                           {
                               reloadDocObject();
                           });
                       }
                       else
                       {
                           $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                       }
                   });
             }
        });

    }

    $(function ()
        {
            $("#DOC_TYPE_NAME").ligerComboBox({
                onBeforeOpen: spf_selectDocType
            });
        });

    function spf_selectDocType(){
        $.ligerDialog.open({
            title: '<spring:message code="hrms.docType"/>',
            name:'doctypeselector',
            width: 800,
            height: 400,
            url: '/utility/docInfo/viewDocTypeList',
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectDocTypeOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectDocTypeCancel },
                { text: '<spring:message code="clear"/>', onclick: spf_selectDocTypeClear }
            ]
        });
        return false;
    }
    function spf_selectDocTypeOK(item, dialog){
        var fn = dialog.frame.spf_selectDocType || dialog.frame.window.spf_selectDocType;
        var data = fn();
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return;
        }
        $("#DOC_TYPE_NO").val(data.DOC_TYPE_NO);
        $("#DOC_TYPE_NAME").val(data.DOC_TYPE_NAME);
        dialog.close();
    }
    function spf_selectDocTypeCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectDocTypeClear(item, dialog)
    {
        $("#DOC_TYPE_NO").val("");
        $("#DOC_TYPE_NAME").val("");
        dialog.close();
    }
</script>
    <style type="text/css">
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" style="width:99.6%;margin:0; padding:0;">
    <input type="hidden" name="DOC_NO" id="DOC_NO" value="${documentDetail.no}" size="30"/>
    <input type="hidden" name="DOC_TYPE_NO" id="DOC_TYPE_NO" value="${documentDetail.processRunning.type.no}" size="30"/>
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.basicInfo"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
                <SipingSoft:button/>
            </td>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docNumber"/></td>
           <td width="20%" class="l-table-edit-c">
                ${documentDetail.no}
           </td>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docName"/><font color="red">*</font></td>
           <td width="20%" class="l-table-edit-c">
                ${documentDetail.name}
           </td>
      </tr>
      <tr>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docType"/><font color="red">*</font></td>
           <td width="20%" class="l-table-edit-c">
               ${documentDetail.processRunning.type.name}
           </td>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docStatus"/><font color="red">*</font></td>
           <td width="20%" class="l-table-edit-c">
               <SipingSoft:selectStatusNo name="DOC_STATUS_NO" selected="${documentDetail.processRunning.state.no}" processResult="${documentDetail.processRunning.result}" curStatusNo="${documentDetail.processRunning.state.no}" objectTypeNo="${documentDetail.processRunning.type.no}"/>
           </td>
       </tr>
       <tr>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.documentationSection"/><font color="red">*</font></td>
           <td width="20%" class="l-table-edit-c">
               ${documentDetail.part}
           </td>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docVersion"/><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">
              ${documentDetail.version}
           </td>
       </tr>
       <tr>
            <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docDescription"/></td>
            <td width="20%" class="l-table-edit-c" nowrap="nowrap" colspan="3">
               <textarea rows="2" cols="90" id="DESCRIPTION" name="DESCRIPTION">${documentDetail.description}</textarea>
           </td>
       </tr>
       <c:if test="${paramMap.CHANGE_NO!=null}">
           <tr>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.changeNumber"/></td>
                <td width="20%" class="l-table-edit-c" nowrap="nowrap">
                   <input type="text" name="CHANGE_NO" id="CHANGE_NO" size="30" value="${paramMap.CHANGE_NO}"/>
               </td>
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.startDate"/></td>
                <td width="20%" class="l-table-edit-c" nowrap="nowrap">
                   <input type="text" name="S_DATE"
                                id="S_DATE" value="" size="25"
                                onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                                readonly="readonly" />
               </td>
           </tr>
       </c:if>
    </table>
    <!-- 文件列表 -->
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.theListOfFiles"/>
            </td>
            <td width="5%" align="right"><SipingSoft:selectStatus name="active" limit="all" onChange="spf_updateFileGrid()"/></td>
            <td align="right" height="30px">
            <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_releaseFileLock()"><spring:message code="hrms.unlock"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_checkInFile()"><spring:message code="hrms.checkIn"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_checkOutFile()"><spring:message code="hrms.checkOut"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_downloadFile()"><spring:message code="hrms.download"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_deleteFile()"><spring:message code="hrms.delete"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_addFile()"><spring:message code="hrms.add"/></a>
            </td>
        </tr>
    </table>
    <div id="docFileInfo">

    </div>
    <!-- 物件列表 -->
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size:12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.relatedObjects"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_deleteDocObject()"><spring:message code="hrms.delete"/></a>
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_addDocObject()"><spring:message code="hrms.add"/></a>
            </td>
        </tr>
    </table>
    <div align="left" style="heigth:30%">
        <div id="navtab1">
            <div title='<spring:message code="hrms.userRelated"/>'>
                <div id="docAdminInfo"></div>
            </div>
            <div title='<spring:message code="hrms.customerRelated"/>'>
                <div id="docCustomerInfo"></div>
            </div>
            <div title='<spring:message code="hrms.projectRelated"/>'>
                <div id="docProjectInfo"></div>
            </div>
            <div title='<spring:message code="hrms.materialsRelated"/>'>
                <div id="docMATInfo"></div>
            </div>
            <div title='<spring:message code="hrms.relatedGoods"/>'>
                <div id="docProductInfo"></div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
