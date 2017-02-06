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
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript"> 
	var $grid_d ; 
	var $grid_i ; 
	var paramNo = "" ;
	var lockFlag = "0" ;
	var $dialogUpload;
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create: function (container, editParm){
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue: function (input, editParm){
			return input.val();
		},
		setValue: function (input, value, editParm){
			input.val(value);
		},
		resize: function (input, width, height, editParm){
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
			leftWidth: 220,height:'99.6%',
			allowLeftResize:false
		}); 
		spf_inputItemInfo(); 
		spf_lockFlag();
	});
	function spf_lockFlag(){
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		$.post('/pa/salary/getPaProgressLockFlag?LOCK_FLAG=PA_LOCK_FLAG&PA_MONTH='+paMonth,function(back){
				lockFlag = back;
			}
		);
	}
	function spf_inputItemInfo(){
		$grid_i = $("#inputItemInfo").ligerGrid({
			checkbox: false,
			columns: [
				{ display: '', name: 'PARAM_NO', width: 10,hide: 1}, 
				{ display: '<spring:message code="hrms.attItemName"/>', name: 'PARAM_NAME', align: 'left',width: 90},
				{ display: '<spring:message code="hrms.defaultValue"/>', name: 'DEFAULT_VAL', align: 'left',width: 90}	
			],
			enabledEdit: true,usePager: false, rownumbers:true,
			url: '/pa/salary/getPaInputItemInfo', 
			parms: [
				{ name: 'PA_MONTH',value: $("#year").attr('value') + $("#month").attr('value')}
			],
			width: '99.8%', height: '99.8%',
			onSelectRow: function (rowdata, rowindex, rowDomElement){
				if(rowdata.MC_1ST_CODE == 'EMPID'){
					paramNo = rowdata.PARAM_NO;
					mcCode = rowdata.MC_1ST_CODE;
					spf_initGrid_empID();
				}else{
					paramNo = rowdata.PARAM_NO;
					mcCode = rowdata.MC_1ST_CODE;
					spf_initGrid();
				}
			},
			onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
				spf_showInputItemDetail(rowdata.PA_MONTH);
			}
		});
	}
	function spf_initGrid_empID(){
		$grid_d = $("#empInfo").ligerGrid({
			checkbox: true,
			columns: [
				{ display: '', name: 'PARAM_DATA_NO', width: 10,hide: 1},
				{ display: '', name: 'PARAM_NO', width: 10,hide: 1},
				{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
				{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120},  
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},
				{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120},
				{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 90}, 
				{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 100,editor: { type: 'float' },render:function(item){
				    if(item.RETURN_VALUE<=0){
				        item.RETURN_VALUE = '0';
				        return '0';
				    }else{
				        return item.RETURN_VALUE;
				    }
				}},  
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
					editor: { type: 'textarea', height: 100 }
				}
			],
			enabledEdit: true,usePager: true, rownumbers:true,
			url: '/pa/salary/getPaInputItemDataInfo',
			parms: [
				{ name: 'PARAM_NO',value: paramNo},
				{ name: 'MC_CODE',value: 'EMPID'},
				{ name: 'keyWord', value: $("#keyWord").attr('value')},
				{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
				{ name: 'PA_MONTH',value:  $("#year").attr('value')+$("#month").attr('value')}
			],
			width: '99.8%', height: '99.8%',pageSize:20,
		});
	}
	function spf_initGrid(){ 
		/* $.post('/utility/otherInfo/getMCName?TABLE_NAME=PA_HR_V&MC_CODE='+mcCode,function(back){ */
				$grid_d = $("#empInfo").ligerGrid({
					checkbox: true,
					columns: [	 
						{ display: '', name: 'PARAM_DATA_NO', width: 10,hide: 1},
						{ display: '', name: 'PARAM_NO', width: 10,hide: 1},
						{ display: '部门编号', name: 'DEPTID', width: 120},
						{ display: '部门名称', name: 'DEPTNAME', width: 120},
						{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 100, editor: { type: 'float' },render:function(item){
		                    if(item.RETURN_VALUE<=0){
		                        item.RETURN_VALUE = '0';
		                        return '0';
		                    }else{
		                        return item.RETURN_VALUE;
		                    }
		                }},  
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
							editor: { type: 'textarea', height: 100 }
						}
					],
					enabledEdit: true,usePager: true, rownumbers:true,
					url: '/pa/salary/getPaInputItemDataInfo',
					parms: [	 
						{ name: 'PARAM_NO',value: paramNo},
						{ name: 'MC_CODE',value: 'DEPTID'},
						{name: 'PA_MONTH',value:  $("#year").attr('value')+$("#month").attr('value')}
					],
					width: '99.8%', height: '99.8%',pageSize:20
				});
			/* } */
		/* );  */
	}
	function spf_search()
	{
		spf_lockFlag();
		if (!paramNo || paramNo == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>'+'<spring:message code="hrms.inputItem"/>') ; 
			 return ; 
		}else{
			$grid_d.setOptions({ 
				parms: [	
					{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
					{ name: 'DEPTID', value: $("#DEPTID").attr('value')}, 
					{ name: 'PA_MONTH', value: $("#year").attr('value')+$("#month").attr('value')},
					{ name: 'PARAM_NO',value: paramNo},
					{ name: 'MC_CODE',value: mcCode}
				],
				newPage: 1
			}); //设置数据参数 
			$grid_d.loadData(true); //加载数据
		}
	}
	function spf_search_i()
	{ 
		$grid_i.setOptions({ 
			parms: [
				{ name: 'PA_MONTH', value: $("#year").attr('value')+$("#month").attr('value')}
			],
			newPage: 1
		}); //设置数据参数 
		$grid_i.loadData(true); //加载数据
	}

	function spf_showInputItemDetail(paMonth)
	{
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		$dialog = $.ligerWindow.show({isDrag: true,
			title: '<spring:message code="hrms.inputItem"/>',
			width: 900 , 
			height: 450 , 
			left:120,top:90,
			url: '/pa/salary/viewPaInputItemDetailInfo?PA_MONTH='+paMonth
		}); 
	}
	function spf_add(){
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		if (!paramNo || paramNo == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>'+'<spring:message code="hrms.inputItem"/>') ; 
			 return ; 
		}if(lockFlag == '0'){
			$dialog = $.ligerWindow.show({isDrag: true,
				title: '<spring:message code="hrms.add"/>'+'<spring:message code="hrms.detail"/>',
				width: 900 , 
				height: 450 , 
				left:120,top:90,
				url: '/pa/salary/addPaInputItemDataInfo?PA_MONTH='+paMonth+'&PARAM_NO='+paramNo+'&MC_CODE='+mcCode
			}); 
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotAdd"/>') ; 
			return ; 
		}
	} 
	function f_ChildWindowClose (){
		$grid_i.loadData(true); //加载数据 
		$grid_d.loadData(true); //加载数据 
	}
	function spf_save()
	{
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		var jsonData = '[' ; 
		if(lockFlag == '0'){
			var rows = $grid_d.getCheckedRows(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				 return ; 
			}
			$(rows).each(function (index, row){ 
				 if(this.RETURN_VALUE == null || this.RETURN_VALUE == '' || this.RETURN_VALUE == 'undefined' || this.DEFAULT_VAL == 'NAN' ){ 
					 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.value"/>'	+". " + '<spring:message code="input.required"/>') ; 
					 return false;	
				 }
				 if (jsonData.length > 1){
					jsonData += ',{' ;
				 }else{
					jsonData += '{' ;
				 }
				 jsonData += ' "PARAM_DATA_NO": "' + this.PARAM_DATA_NO + '", ' ;	
				 jsonData += ' "RETURN_VALUE": "' + this.RETURN_VALUE + '", ' ;	   
				 jsonData += ' "PA_MONTH": "' + paMonth + '", ' ;	
				 jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK).replace(/\n/g,"") + '"' ;
				 jsonData += '}' ;
			}); 
			jsonData += ']' ;  
			var jsonList = eval("(" + jsonData + ")");
			if(jsonData.length == 2){
				return ;
			} 
			if(jsonList.length == rows.length){ 
				$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
				$.post("/pa/salary/updatePaInputItemDataInfo", 
					[	
						{ name: 'jsonData', value: jsonData },
						{ name: 'PA_MONTH', value: paMonth }
					]
					, function (result)
					{
					$.ligerDialog.closeWaitting();
						if (result == "Y"){
							$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
								$grid_d.loadData(true); //加载数据 
							});
					}else{
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result); 
					}
				});
			}
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotUpdate"/>') ; 
			 return ; 
		}
	}  
	function spf_delete() {
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		var jsonData = '[';
		if (lockFlag == '0') {
			var rows = $grid_d.getCheckedRows();
			if (!rows || rows.length == 0) {
				$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>');
				return;
			}
			$.ligerDialog.confirm('是否确定删除数据?', '<spring:message code="hrms.warning"/>',
			function(yes) {
				if (yes) {
					$(rows).each(function(index, row) {
						if (jsonData.length > 1) {
							jsonData += ',{';
						} else {
							jsonData += '{';
						}
						jsonData += ' "PARAM_DATA_NO": "' + this.PARAM_DATA_NO + '", ';
						jsonData += ' "PA_MONTH": "' + paMonth + '", ';
						jsonData += ' "PARAM_NO": "' + this.PARAM_NO + '" ';
						jsonData += '}';
					});
					jsonData += ']';
					if (jsonData.length == 2) {
						$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>');
						return;
					}
					$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
					$.post("/pa/salary/deletePaInputItemDataInfo", [{
						name: 'jsonData',
						value: jsonData
					},
					{
						name: 'PA_MONTH',
						value: paMonth
					}],
					function(result) {
						$.ligerDialog.closeWaitting();
						if (result == "Y") {
							$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',
							function() {
								$grid_d.loadData(true); //加载数据 
							});
						} else {
							$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
						}
					});
				}
			});
		} else {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotdelete"/>');
			return;
		}
	}
	function spf_paItemImportExcel(){
		var paMonth = $("#year").attr('value') + $("#month").attr('value');
		if (!paramNo || paramNo == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>'+'<spring:message code="hrms.inputItem"/>') ; 
			 return ; 
		}
		if (mcCode != "EMPID") { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择标识号为工号的输入项目') ; 
             return ; 
        }
		if(lockFlag == '0'){
			$dialogUpload = $.ligerDialog.open({
				isDrag:false,
				title:'上传文件',
				width:350,
				height:260,
				url:'/pa/salary/uploadPaParamData?PA_MONTH='+paMonth+'&PARAM_NO='+paramNo
			});
		}else{
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.canNotAdd"/>') ; 
			return ; 
		}
	}
	function spf_afterUploadSuccess(){
		spf_search();
		$dialogUpload.close();
	}
	function spf_paGetExcelTemplate(){
		location.href = "/pa/salary/downloadPaDataTemplate";
	}
</script>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
	<div position="top">
		<table width="99%" cellpadding="0" cellspacing="0"
			class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td width="10%" class="l-table-edit-t"><spring:message
						code="hrms.wageMonth" /></td>
				<td width="23%" class="l-table-edit-c"><SipingSoft:date
						yearName="year" yearSelected="${year}" monthName="month"
						monthSelected="${month}" onChange="spf_search();spf_lockFlag();" />
				</td>
				<td width="10%" class="l-table-edit-t"><spring:message
						code="keyWord" /></td>
				<td width="23%" class="l-table-edit-c"><input name="keyWord"
					type="text" id="keyWord" size="30" /></td>
				<td width="10%" class="l-table-edit-t"><spring:message
						code="hrms.dept" /></td>
				<td width="23%" class="l-table-edit-c"><SipingSoft:deptTree
						name="DEPTID" limit="hr" /></td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
			<tr>
				<td align="left">
					<a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px; "
						onclick="spf_paItemImportExcel()"><spring:message code="hrms.excelImport" /></a>
					<a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px; "
						onclick="spf_paGetExcelTemplate()">下载模板</a>
					<SipingSoft:button />
				</td>
			</tr>
		</table>
	</div>
	<div id="layout1">
		<div position="left" id="inputItemInfo" class="l-scroll"
			title="<spring:message code='hrms.inputItem'/>&nbsp;&nbsp;<a href='javascript:spf_showInputItemDetail()'>管理</a>"></div>
		<div position="center" id='empInfo'
			title='<spring:message code="hrms.detail"/>'></div>
	</div>
</body>
</html>
