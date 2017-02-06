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
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
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
         //spf_search();
    });
 
    function f_initGrid()
    {
    	$grid = $("#appendixInfo").ligerGrid({
    		//checkbox: true,   		
    		columns: [   
			            { display: '', name: 'CUST_ID', width: 0,hide: 1},
			            { display: '', name: 'CUST_APPEN_ID', width: 0,hide: 1},
			            { display: '所属客户', name: 'CUST_NAME', width: 120}, 
						{ display: '附件名称', name: 'ORIGINAL_NAME', width: 120},
			            { display: '格式', name: 'APPENDIX_FORMAT', width: 70},  
			            { display: '上传时间', name: 'CREATE_DATE', width: 100},
			            { display: '备注', name: 'REMARK', width: 140},
			            { display: '下载附件',  width: 90,
			            	render: function (item)  
		                    { 
		                       return '<div style="cursor: pointer;" onClick="spf_download(\''+item.CUST_APPEN_ID+'\')">点此下载</div>';
		                    }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/cust/custAppendix/getAppendixList',
            parms: [
                	{ name: 'CUST_ID', value: $("#CUST_ID").attr('value')}
                   ],
            width: '99.6%', height: '100%'
        });
    }
    function spf_delete()
    {   
    	var	row = $grid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
		$dialog = $.ligerDialog.open({isDrag: false, 
     	    title:'删除附件', 
     		width: 420, 
     		height: 180, 
     		url: '/cust/custAppendix/removeAppendix?CUST_APPEN_ID='+row.CUST_APPEN_ID
    	});
    }
    function spf_add(){
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'上传附件', 
    		width: 1000, 
    		height: 620, 
    		isResize: true,
    		url: '/upload/fileUpload/uploadCustAppendix'
    	});   	
    }
    function spf_download(CUST_APPEN_ID){
  		location.href ='/download/fileDownload/downloadCustAppendix?CUST_APPEN_ID='+CUST_APPEN_ID;
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
		                        	{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
		                        	{ name: 'E_DATE', value: $("#E_DATE").attr('value')},
		                        	{ name: 'CUST_ID', value: $("#CUST_ID").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
	function spf_afterAddOrRemove(){
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
		<div position="center" id='' title='附件列表'>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="25"/></td>
						<td width="15%" class="l-table-edit-t">上传时间</td>
						<td width="35%" class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button />
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='appendixInfo'></div>
		</div>
	</div>
</body>
</html>
