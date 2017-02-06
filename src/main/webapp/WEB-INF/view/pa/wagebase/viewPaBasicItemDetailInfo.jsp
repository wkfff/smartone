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
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid ;
	var $mc1stSelectList ;
	var $mc2ndSelectList ;
	var $dtSelectList ;
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
			leftWidth: 250,height:'99%'
		});
		$mc1stSelectList = getMC1STSelectList() ;
		$mc2ndSelectList = getMC2NDSelectList() ;
		$dtSelectList = getDataTypeSelectList() ;
		spf_inputItemInfo();
		spf_initGrid();
	});
	function getMC1STSelectList(){
		//请求服务器
		var mcSelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getMC1STSelectList?TABLE_NAME=PA_HR_V',
			dataType: 'json',
			async: false,
			success: function (list)
			{
				mcSelectList = list ;
			}
		});
		return mcSelectList ;
	}
	function getMC2NDSelectList(){
		//请求服务器
		var mcSelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getMC2NDSelectList?TABLE_NAME=PA_HR_V',
			dataType: 'json',
			async: false,
			success: function (list)
			{
				mcSelectList = list ;
			}
		});
		return mcSelectList ;
	}

	function getDataTypeSelectList(){
		//请求服务器
		var dtSelectList ;
		$.ajax({
			type: 'post',
			url: '/utility/otherInfo/getDataTypeSelectList?PARENT_CODE=DataType&DEPTH=2',
			dataType: 'json',
			async: false,
			success: function (list)
			{
				dtSelectList = list ;
			}
		});
		return dtSelectList ;
	}
	function spf_inputItemInfo()
	{
		$grid = $("#inputItemInfo").ligerGrid({
			checkbox: false,
			columns: 
				[
					{ display: '', name: 'ITEM_NO', width: 10,hide: 1},
					{ display: '<spring:message code="hrms.chineseName"/>', name: 'ITEM_NAME', width: 120,editor: { type: 'text' },frozen:true},
					{ display: '<spring:message code="hrms.englishName"/>', name: 'ITEM_EN_NAME', width: 120,editor: { type: 'text' },frozen:true},
					{ display: '<spring:message code="hrms.dataType"/>', name: 'DATA_TYPE_CODE', width: 130, align: 'center',isSort: false,
						editor: {
							type: 'select', data: $dtSelectList, dataValueField: 'DATA_TYPE_CODE',dataDisplayField: 'DATA_TYPE_NAME',
							displayColumnName: 'DATA_TYPE_NAME', valueColumnName: 'DATA_TYPE_CODE'
						}, render: function (item)
						{
							for (var i = 0; i < $dtSelectList.length; i++)
							{
								if ($dtSelectList[i]['DATA_TYPE_CODE'] == item.DATA_TYPE_CODE)
									return $dtSelectList[i]['DATA_TYPE_NAME']
							}
							return item.DATA_TYPE_NAME;
						}
					},
					{ display: '<spring:message code="hrms.markingColumn"/>'+'①', name: 'MC_1ST_CODE', width: 130, align: 'center',isSort: false,
						editor: {
							type: 'select', data: $mc1stSelectList, dataValueField: 'MC_1ST_CODE',dataDisplayField: 'MC_1ST_NAME',
							displayColumnName: 'MC_1ST_NAME', valueColumnName: 'MC_1ST_CODE'
						}, render: function (item)
						{
							for (var i = 0; i < $mc1stSelectList.length; i++)
							{
								if ($mc1stSelectList[i]['MC_1ST_CODE'] == item.MC_1ST_CODE)
									return $mc1stSelectList[i]['MC_1ST_NAME']
							}
							return item.MC_1ST_NAME;
						}
					},
					{ display: '<spring:message code="hrms.markingColumn"/>'+'②', name: 'MC_2ND_CODE', width: 130, align: 'center',isSort: false,
						editor: {
							type: 'select', data: $mc2ndSelectList, dataValueField: 'MC_2ND_CODE',dataDisplayField: 'MC_2ND_NAME',
							displayColumnName: 'MC_2ND_NAME', valueColumnName: 'MC_2ND_CODE'
						}, render: function (item)
						{
							for (var i = 0; i < $mc2ndSelectList.length; i++)
							{
								if ($mc2ndSelectList[i]['MC_2ND_CODE'] == item.MC_2ND_CODE)
									return $mc2ndSelectList[i]['MC_2ND_NAME']
							}
							return item.MC_2ND_NAME;
						}
					},
					{ display: '<spring:message code="hrms.defaultValue"/>', name: 'DEFAULT_VAL', type: 'float',width: 90,editor: { type: 'float' }},
					{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left', width: 160,
						editor: { type: 'textarea', height: 100 }
					}
				],
			enabledEdit: true,usePager: true, rownumbers:true,
			url: '/pa/wagebase/getPaBasicItemInfo',
			width: '99.6%', height: '100%'
		});
	}
	function spf_search()
	{
		$grid.setOptions({
			parms: [
				{ name: 'keyWord', value: $("#keyWord").attr('value')},
				{ name: 'DEPTID', value: $("#DEPTID").attr('value')}
			],
			newPage: 1
			}); //设置数据参数
		$grid.loadData(true); //加载数据
	}
	function spf_add()
	{
		$grid.addRow();
	}
	function f_ChildWindowClose (){
		$grid.loadData(true); //加载数据
	}
	function spf_save()
	{
		var jsonData = '[' ;
		var rows = $grid.getData();
		//alert(JSON2.stringify(rows));
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
			 return ;
		}
		$(rows).each(function (index, row){
			 if(this.ITEM_NAME == null || this.ITEM_NAME == '' || this.ITEM_NAME == 'undefined' ){
				 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chineseName"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			 }
			 if(this.DATA_TYPE_CODE == null || this.DATA_TYPE_CODE == '' || this.DATA_TYPE_CODE == 'undefined' ){
				 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataType"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			 }
			 if(this.MC_1ST_CODE == null || this.MC_1ST_CODE == '' || this.MC_1ST_CODE == 'undefined' ){
				 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.markingColumn"/>'+'①'	 +". " + '<spring:message code="input.required"/>') ;
				 return false;
			 }
			 if(this.DEFAULT_VAL == null){
				 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.defaultValue"/>'  +". " + '<spring:message code="input.required"/>') ;
				 return false;
			 }
			 if (jsonData.length > 1){
				jsonData += ',{' ;
			 }
			 else{
				jsonData += '{' ;
			 }
			 jsonData += ' "__status": "' + this.__status + '", ' ;
			 jsonData += ' "ITEM_NO": "' + MyCheckNull(this.ITEM_NO) + '", ' ;
			 jsonData += ' "ITEM_NAME": "' + this.ITEM_NAME + '", ' ;
			 jsonData += ' "ITEM_EN_NAME": "' + this.ITEM_EN_NAME + '", ' ;
			 jsonData += ' "DATA_TYPE_CODE": "' + this.DATA_TYPE_CODE + '", ' ;
			 jsonData += ' "MC_1ST_CODE": "' + this.MC_1ST_CODE + '", ' ;
			 jsonData += ' "MC_2ND_CODE": "' + MyCheckNull(this.MC_2ND_CODE) + '", ' ;
			 jsonData += ' "DEFAULT_VAL": "' + this.DEFAULT_VAL + '", ' ;
			 jsonData += ' "DESCRIPTION": "' + MyCheckNull(this.DESCRIPTION) + '"' ;
			 jsonData += '}' ;
		});
		jsonData += ']' ;
		var jsonList = eval("(" + jsonData + ")");
		if(jsonData.length == 2){
			return ;
		}
		if(jsonList.length == rows.length){
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/pa/wagebase/addAndupdatePaBasicItemInfo",
				[
					{ name: 'jsonData', value: jsonData }
				]
			, function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
					{
						$grid.loadData(true); //加载数据
						parent.f_ChildWindowClose(); //加载数据
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	}
	function spf_delete()
	{
		 var row = $grid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
			 return ;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.post("/pa/wagebase/deletePaBasicItemInfo",
			[
				{ name: 'ITEM_NO', value: MyCheckNull(row.ITEM_NO) }
			]
		, function (result){
			$.ligerDialog.closeWaitting();
			if (result == "Y"){
				$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
					$grid.loadData(true); //加载数据
					parent.f_ChildWindowClose(); //加载数据
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
		<div align="left" position="center" id=''>
			<div align="left">
				<table width="99.6%" cellpadding="1" cellspacing="1"
					style="height: 30px; font-size: 12px;">
					<tr>
						<td align="right"><a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-left: 10px; "
							onclick="spf_add()"><spring:message code="hrms.add" /></a> <a
							class="l-button"
							style="width: 79px; height: 20px; float: right; margin-left: 10px; "
							onclick="spf_save()"><spring:message code="hrms.save" /></a> <a
							class="l-button"
							style="width: 79px; height: 20px; float: right; margin-left: 10px; "
							onclick="spf_delete()"><spring:message code="hrms.delete" /></a>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='inputItemInfo'></div>
		</div>
	</div>
</body>
</html>
