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
        $("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid){
            if(tabid=="tabitem1"){
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
                $OBJ_TYPE = 'PROJ';
                spf_project_initGrid();
                $curgrid = $projgrid;
            }
            if(tabid=="tabitem4"){
                $OBJ_TYPE = 'MAT';
                spf_material_initGrid();
                $curgrid = $materialgrid;
            }
            if(tabid=="tabitem5"){
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
            checkbox: true,
            columns: [
                        { display: '', name: 'no', width: 0,hide: 1},
                        { display: '<spring:message code="hrms.documentName"/>', name: 'name', width: 350},
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
            usePager:false,
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
                         }); //设置数据参数
        $filegrid.loadData(true); //加载数据
    }

    function spf_admin_initGrid(){
        $admingrid = $("#docAdminInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'no', width: 200},
                        { display: '<spring:message code="hrms.userID"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewCustomer"/>',  width: 200,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_viewAdminDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.viewUser"/></div>';
                            }
                        }
                    ],
            usePager: false, rownumbers:true,
            fixedCellHeight:true,
            url: '/doc/docInfo/getDocObjectList?DOC_NO='+$('#DOC_NO').val(),
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
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_NO', width: 200},
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
        alert("To be finished");
    }

    function spf_customer_initGrid(){
        $custgrid = $("#docCustomerInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_NO', width: 200},
                        { display: '<spring:message code="hrms.customerNumber"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewCustomer"/>',  width: 200,
                            render: function (item)
                            {
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

   function spf_material_initGrid(){
        $materialgrid = $("#docMATInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_NO', width: 200},
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

    function spf_product_initGrid()
    {
        $productgrid = $("#docProductInfo").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.docNumber"/>', name: 'DOC_NO', width: 200},
                        { display: '<spring:message code="hrms.productCode"/>', name: 'OBJ_ID', width: 200},
                        { display: '<spring:message code="hrms.viewItem"/>',  width: 200,
                            render: function (item)
                            {
                               return '<div style="cursor: pointer;" onClick="spf_viewProductDetail(\''+item.OBJ_ID+'\')"><spring:message code="hrms.viewItem"/></div>';
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

    var tab = parent.tab;
    function spf_refresh(){
        if(tab.isTabItemExist('doc0202')){
            tab.removeTabItem('doc0202');
        }
        tab.addTabItem({ tabid : 'doc0202',text: '<spring:message code="hrms.editDocument"/>', url: '/doc/docManage/updateDocument?MENU_CODE=doc0202&DOC_NO='+DOC_NO });
    }

    function spf_downloadFile(){
        var rows = $filegrid.getSelecteds();
        if (!rows || rows.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
            return ;
        }
        var FILE_IDS = "";
        for(a=0;a<rows.length;a++){
            if(a==0){
                FILE_IDS = rows[0].no;
            }else{
                FILE_IDS = FILE_IDS + "," +rows[a].no;
            }
        }
        window.open('/doc/docManage/downloadFile?fileNos='+FILE_IDS+'&documentNo='+$("#DOC_NO").val(),"<spring:message code="hrms.documentDownload"/>");
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
            </td>
        </tr>
    </table>
    <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
      <tr>
           <td width="10%" class="l-table-edit-t"><spring:message code="hrms.docNumber"/></td>
           <td width="20%" class="l-table-edit-c">
                ${documentDetail.oriNo}  &nbsp;&nbsp;(<spring:message code="hrms.serialNumber"/>：${documentDetail.no})
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
               ${documentDetail.processRunning.state.name}
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
    </table>
    <!-- 文件列表 -->
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.documentList"/>
            </td>
            <td width="5%" align="right"><SipingSoft:selectStatus name="active" limit="all" onChange="spf_updateFileGrid()"/></td>
            <td align="right" height="30px">
                <a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_downloadFile()"><spring:message code="hrms.download"/></a>
            </td>
        </tr>
    </table>
    <div id="docFileInfo"></div> 
    <!-- 物件列表 -->
    <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size:12px;">
        <tr>
            <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
            <td width="25%" align="left" style="font-weight: bold;">
                <spring:message code="hrms.relatedObjects"/>
            </td>
            <td width="5%" align="right">&nbsp;</td>
            <td align="right" height="30px;">
            </td>
        </tr>
    </table>
    <div align="left" style="height:30%;">
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