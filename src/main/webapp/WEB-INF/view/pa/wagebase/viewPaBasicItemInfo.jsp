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
	var itemNo = "" ;  
	var mcCode = "" ;  
	var $reasonSelectList ; 
	var $activitySelectList ; 
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
			leftWidth: 230,
			topHeight: 60, 
			allowTopResize: false
			//是否允许 头部可以调整大小
		}); 
		$reasonSelectList = getReasonSelectList() ;
		$activitySelectList = getActivitySelectList() ;
		spf_basicItemInfo(); 
	});
	
	function spf_basicItemInfo()
	{
		$grid_i = $("#basicItemInfo").ligerGrid({
			checkbox: false,
			columns: [	 
				{ display: '', name: 'ITEM_NO', width: 10,hide: 1}, 
				{ display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME', width: 90},
				{ display: '<spring:message code="hrms.defaultValue"/>', name: 'DEFAULT_VAL', width: 90}  
			],
			enabledEdit: true,usePager: false, rownumbers:true,
			url: '/pa/wagebase/getPaBasicItemInfo', 
			width: '99.6%', height: '100%',
			onSelectRow: function (rowdata, rowindex, rowDomElement) 
			{
				if(rowdata.MC_1ST_CODE == 'EMPID'){
					itemNo = rowdata.ITEM_NO;
					mcCode = rowdata.MC_1ST_CODE;
					spf_initGrid_empID();
				}else{
					itemNo = rowdata.ITEM_NO;
					mcCode = rowdata.MC_1ST_CODE;
					spf_initGrid();
				}
			},
			onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
				spf_showBasicItemDetail();
			}
		});
	}
	function getReasonSelectList(){
		//请求服务器
		var reasonSelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getReasonSelectList', 
			dataType: 'json',
			async: false,
			success: function (list)
			{  
				reasonSelectList = list ; 
			}
		});
		return reasonSelectList ;
	}
	function getActivitySelectList(){
		//请求服务器
		var activitySelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getActivitySelectList', 
			dataType: 'json',
			async: false,
			success: function (list)
			{  
				activitySelectList = list ;
			}
		});
		return activitySelectList ;
	}
	function spf_initGrid_empID()
	{
		$grid_d = $("#empInfo").ligerGrid({
			checkbox: true,
			columns: [
				{ display: '', name: 'BASIC_DATA_NO', width: 10,hide: 1},
				{ display: '', name: 'ITEM_NO', width: 10,hide: 1},
				{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90,frozen:true},
				{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90,frozen:true}, 
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true},
				{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 90,frozen:true}, 
				{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}}, 
				{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}},
				{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 90,editor: { type: 'float' }},  
				{ display: '<spring:message code="hrms.adjustmentReason"/>', name: 'REASON_CODE', width: 120,align: 'center',isSort: false,
					editor: { 
						type: 'select', data: $reasonSelectList, dataValueField: 'REASON_CODE',dataDisplayField: 'REASON_NAME',
						displayColumnName: 'REASON_NAME', valueColumnName: 'REASON_CODE'
					}, render: function (item)
					{
						for (var i = 0; i < $reasonSelectList.length; i++)
						{
							if ($reasonSelectList[i]['REASON_CODE'] == item.REASON_CODE)
								return $reasonSelectList[i]['REASON_NAME']
						}
						return item.REASON_NAME;
					}
				},
				{ display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',isSort: false,
					editor: { 
						type: 'select', data: $activitySelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
						displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
					}, render: function (item)
					{
						for (var i = 0; i < $activitySelectList.length; i++)
						{
							if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID)
								return $activitySelectList[i]['STATUS']
						}
						return item.STATUS;
					}
				},	
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
					editor: { type: 'textarea', height: 100 }
				}
			],
			enabledEdit: true,usePager: true, rownumbers:true,
			url: '/pa/wagebase/getPaBasicItemDataInfo',
			parms: [	 
					{ name: 'ITEM_NO',value: itemNo},
					{ name: 'MC_CODE',value: 'EMPID'}
				   ],
			width: '99.6%', height: '100%'
		});
	}
	function spf_initGrid()
	{ 
		$.post('/utility/otherInfo/getMCName?TABLE_NAME=PA_HR_V&MC_CODE='+mcCode,function(back){
				$grid_d = $("#empInfo").ligerGrid({
					checkbox: true,
					columns: [
						{ display: '', name: 'BASIC_DATA_NO', width: 10,hide: 1},
						{ display: '', name: 'ITEM_NO', width: 10,hide: 1},
						{ display: back, name: 'FIELD1_VALUE', width: 120},
						{ display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}}, 
						{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date'}},
						{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 90,editor: { type: 'float' }},  
						{ display: '<spring:message code="hrms.adjustmentReason"/>', name: 'REASON_CODE', width: 130,align: 'center',isSort: false,
							editor: { 
								type: 'select', data: $reasonSelectList, dataValueField: 'REASON_CODE',dataDisplayField: 'REASON_NAME',
								displayColumnName: 'REASON_NAME', valueColumnName: 'REASON_CODE'
							}, render: function (item)
							{
								for (var i = 0; i < $reasonSelectList.length; i++)
								{
									if ($reasonSelectList[i]['REASON_CODE'] == item.REASON_CODE)
										return $reasonSelectList[i]['REASON_NAME']
								}
								return item.REASON_NAME;
							}
						},
						{ display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',isSort: false,
							editor: { 
								type: 'select', data: $activitySelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
								displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
							}, render: function (item)
							{
								for (var i = 0; i < $activitySelectList.length; i++)
								{
									if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID)
										return $activitySelectList[i]['STATUS']
								}
								return item.STATUS;
							}
						},	
						{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 180,
							editor: { type: 'textarea', height: 100 }
						}
					],
					enabledEdit: true,usePager: true,
					url: '/pa/wagebase/getPaBasicItemDataInfo',
					parms: [	 
							{ name: 'ITEM_NO',value: itemNo},
							{ name: 'MC_CODE',value: mcCode}
						   ],
					width: '99.6%', height: '100%'
				});
			}
		); 
	}
	
	function spf_search()
	{ 
		$grid_d.setOptions({ 
			parms: [
				{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
				{ name: 'DEPTID', value: $("#DEPTID").attr('value')}, 
				{ name: 'ACTIVITY', value: $("#ACTIVITY").attr('value')},
				{ name: 'MC_CODE',value: mcCode},
				{ name: 'ITEM_NO',value: itemNo}
			],
			newPage: 1
		}); //设置数据参数 
		$grid_d.loadData(true); //加载数据
	} 

	function spf_showBasicItemDetail()
	{	 
		$dialog = $.ligerWindow.show({isDrag: true,
			title: '<spring:message code="hrms.basicItem"/>',
			width: 900 , 
			height: 450 , 
			left:120,top:90,
			url: '/pa/wagebase/viewPaBasicItemDetailInfo'
		}); 
	}
	
	function spf_add()
	{	 
		if (!itemNo || itemNo == "") { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.selection"/>'+'<spring:message code="hrms.inputItem"/>') ; 
			 return ; 
		}else{
			$dialog = $.ligerWindow.show({isDrag: true,
				title: '<spring:message code="hrms.add"/>'+'<spring:message code="hrms.detail"/>',
				width: 900 , 
				height: 450 , 
				left:120,top:90,
				url: '/pa/wagebase/addPaBasicItemDataInfo?ITEM_NO='+itemNo+'&MC_CODE='+mcCode
			}); 
		}
	} 
	
	function f_ChildWindowClose (){
		$grid_i.loadData(true); //加载数据 
		$grid_d.loadData(true); //加载数据 
	}

	function spf_save(){
		 var jsonData = '[' ; 
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
			 }
			 else{
				jsonData += '{' ;
			 }
			 jsonData += ' "BASIC_DATA_NO": "' + this.BASIC_DATA_NO + '", ' ;	
			 jsonData += ' "RETURN_VALUE": "' + this.RETURN_VALUE + '", ' ;	 
			 jsonData += ' "REASON_CODE": "' + this.REASON_CODE + '", ' ;
			 jsonData += ' "ACTIVITY": "' + this.STATUS_ID + '", ' ;
			 jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
			 jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;	 
			 jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
			 jsonData += '}' ;	 
		}); 
		jsonData += ']' ;  
		var jsonList = eval("(" + jsonData + ")");
		if(jsonData.length == 0){
			return ;
		}
		if(jsonList.length == rows.length){
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/pa/wagebase/updatePaBasicItemDataInfo", 
				[	
					{ name: 'jsonData', value: jsonData }
				]
			, function (result){
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
	}
	function spf_delete()
	{
		 var jsonData = '[' ; 
		 var rows = $grid_d.getCheckedRows(); 
		if (!rows || rows.length == 0) { 
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			 return ; 
		}
		$(rows).each(function (index, row){
			 if (jsonData.length > 1){
				jsonData += ',{' ;
			 }
			 else{
				jsonData += '{' ;
			 }	
			 jsonData += ' "BASIC_DATA_NO": "' + this.BASIC_DATA_NO + '", ' ;
			 jsonData += ' "ITEM_NO": "' + this.ITEM_NO + '" ' ;
			 jsonData += '}' ;	
		}); 
		jsonData += ']' ;
		if(jsonData.length == 2){
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
			return ;
		} 
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.post("/pa/wagebase/deletePaBasicItemDataInfo", 
			[
				{ name: 'jsonData', value: jsonData }
			]
		, function (result){
			$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
					{
						$grid_d.loadData(true); //加载数据 
				 	});
			}else{
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		});
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
		<div position="top" id="itemTop">
			<table width="99.6%" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="10%" class="l-table-edit-t">
						<spring:message code="keyWord" /></td>
					<td width="23%" class="l-table-edit-c">
						<input name="keyWord" type="text" id="keyWord" size="30" /></td>
					<td width="10%" class="l-table-edit-t">
						<spring:message code="hrms.dept" /></td>
					<td width="23%" class="l-table-edit-c">
						<SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
					<td class="l-table-edit-t">
						<spring:message code="hrms.active" />
					</td>
					<td class="l-table-edit-c">
						<SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search();" /></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
		</div>
		<div position="left" id="basicItemInfo"
			title='<spring:message code="hrms.basicItem"/>'></div>
		<div position="center" id='empInfo'
			title='<spring:message code="hrms.detail"/>'></div>
	</div>
</body>
</html>
