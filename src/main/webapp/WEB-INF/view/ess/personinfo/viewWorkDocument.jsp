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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $grid = null ; 
    var $returnTypeSelectList ;
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
    $(function ()
    {
    	//布局
        $("#layout1").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        f_initGrid();
        $("#DOC_TYPE_NAME").ligerComboBox({
          onBeforeOpen: spf_selectDocType
        });
    });
    
    function spf_selectDocType()
    {
        $.ligerDialog.open({ 
        	title: '文档类型', 
        	name:'doctypeselector'+Math.random(),
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
    function spf_selectDocTypeOK(item, dialog)
    {
		var fn = dialog.frame.spf_selectDocType || dialog.frame.window.spf_selectDocType; 
        var data = fn(); 
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        }
        $("#DOC_TYPE_ID").val(data.DOC_TYPE_ID);
    	$("#DOC_TYPE_NAME").val(data.DOC_TYPE_NAME);
    	spf_search();
        dialog.close();
    }
    function spf_selectDocTypeCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectDocTypeClear(item, dialog)
    {
    	$("#DOC_TYPE_ID").val("");
    	$("#DOC_TYPE_NAME").val("");
    	spf_search();
        dialog.close();
    }
    
    function f_initGrid()
    {
    	$grid = $("#documentInfo").ligerGrid({
    		columns: [
			            { display: '流水号', name: 'DOC_ID', width: 0, hide:1},
			            { display: '<spring:message code="hrms.docNumber"/>', name: 'ORI_ID', width: 150},
						{ display: '<spring:message code="hrms.docName"/>', name: 'DOC_NAME', width: 150},
						{ display: '<spring:message code="hrms.docVersion"/>', name: 'DOC_VERSION', width:150},
						{ display: '<spring:message code="hrms.docType"/>', name: 'DOC_TYPE', width: 150},
						{ display: '<spring:message code="hrms.docStatus"/>', name: 'DOC_STATUS', width: 120},
						{ display: '<spring:message code="hrms.docDescription"/>', name: 'DESCRIPTION', width: 200},
						{ display: '<spring:message code="hrms.docNumber"/>',  width: 120,
			            	render: function (item)  
		                    { 
		                       return '<div style="cursor: pointer;" onClick="spf_viewDocumentDetail(\''+item.DOC_ID+'\')">点此查看</div>';
		                    }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/doc/docInfo/getWorkDocumentList',
            parms: [
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
            	spf_viewDocumentDetail(rowdata.DOC_ID);
            }
        });
    }
    
    function spf_showApproverInfo(OBJECT_ID,AFFIRM_OBJECT)
    {    
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.approvalActive"/>', 
    		width: 700, 
    		height: 320, 
  		    url: '/process/processManage/viewApproverInfo?OBJECT_ID='+OBJECT_ID+'&AFFIRM_OBJECT='+AFFIRM_OBJECT+''
       	  });
    }
    
    var tab = parent.tab;
    function spf_viewDocumentDetail(DOC_ID){
    	if(tab.isTabItemExist('doc0102')){
    		tab.removeTabItem('doc0102');
    	}
        tab.addTabItem({ tabid : 'doc0102',text: '文档信息', url: '/doc/docInfo/viewDocumentDetail?MENU_CODE=doc0102&DOC_ID='+DOC_ID });
    }
  
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
									{ name: 'keyWord', value: $("#keyWord").attr('value')},
									{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
									{ name: 'E_DATE', value: $("#E_DATE").attr('value')},  
									{ name: 'DOC_TYPE_ID', value: $("#DOC_TYPE_ID").attr('value')},
									{ name: 'DOC_STATUS_ID', value: $("#DOC_STATUS_ID").attr('value')}
									],
								newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
	function spf_afterRemove(){
		$dialog.close();
		$grid.loadData(true); //加载数据
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
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
						<td class="l-table-edit-t"><spring:message
								code="hrms.createDate" />	</td>
						<td class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.docType" /></td>
						<td width="35%" class="l-table-edit-c">
							<SipingSoft:selectObjectType name="DOC_TYPE_ID" parentTypeID="DOC" onChange="spf_search()" limit="all"/>
						</td>
		 				<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.docStatus" /></td>
						<td width="35%" class="l-table-edit-c">
							<SipingSoft:selectStatusID name="DOC_STATUS_ID" objectTypeID="DOC" onChange="spf_search()" limit="all"/>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='documentInfo'></div>
		</div>
	</div>
</body>
</html>
