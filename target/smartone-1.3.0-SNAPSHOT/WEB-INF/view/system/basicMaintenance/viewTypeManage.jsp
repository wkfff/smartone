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

<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid;
	var $grid_p;
	var $grid_p_p;
	var $tree;
	var $tree2;
	var manager;
	var manager2;
	
	var $valueTypeList ;
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({
			leftWidth : 180
		});

		initTreeCategory();
		
		$tree2 = $("#tree2").ligerTree({
			checkbox : false,
			nodeWidth : 250,
			onSelect : onSelect2
		});
		
		manager = $("#tree1").ligerGetTreeManager();
		manager2 = $("#tree2").ligerGetTreeManager();
		
		$valueTypeList = getPropertyValueType();
		
		f_initGrid();
		p_initGrid();
		p_p_initGrid();
	});
	
	function initTreeCategory(){
		//初始化生成坐标类别树
		$("#tree1").html("");
		$tree = $("#tree1").ligerTree({
			checkbox : false,
			nodeWidth : 250,
			data: getCategoryByJson(),
			checkbox:false,
			idFieldName :'id',
			parentIDFieldName :'pid',
			onSelect : onSelect
		});
	}
	//选中类别后执行函数
	function onSelect(note){
		$("#detail").siblings().hide(500);
		$("#detail").show(500);
		$grid.setOptions({
			parms : [
						{name:'ROOT',value : note.data.id}
					],
			newPage:1
		});
		$grid.loadData(true);
	}
	//获取子类函数
	function getCategoryByJson(){
		var data2 = [];
		data2.push({ id: 'CATEGORY', pid: '', text: '货物类别', isexpand : true });
		$.ajax({
			type:'post',
			cache : false,
			contentType : 'application/json',
			url : '/system/basicMaintenance/getCategoryList',
			dataType : 'json',
			async : false,
			success : function(data) {
				$.each(
					data.Rows,
					function(i, item) {
						data2.push({ id: item.CATEGORY_ID, pid: item.PARENT_ID, text: ''+item.CATEGORY_NAME, isexpand : false });
					}
				);
			},
			error : function() {
				$.ligerDialog.error('Send Error');
			}
		});
		return data2;
	}
	
	//选中类别后执行函数
	function onSelect2(note){
		if(note.data.id == "property"){
			$("#propertyDetail").siblings().hide(500);
			$("#propertyDetail").show(500);
		}else if(note.data.id == "propertyValue"){
			$("#propertyValueDetail").siblings().hide(500);
			$("#propertyValueDetail").show(500);
		}
	}
	
	//初始化右边属性列表
	function f_initGrid() {
		$grid = $("#detail").ligerGrid({
			columns: [
					{display : '类别ID',name : 'CATEGORY_ID',width : '20%'},
					{display : '类别名',name : 'CATEGORY_NAME',width : '20%',editor: { type: 'text' }},
					{display : '商品编码前缀',name : 'PRE_CODE',width : '20%',editor: { type: 'text' }},
					{display : '类别描述',name : 'REMARK',width : '40%',editor: { type: 'text' }}
				],
			enabledEdit: true,
			usePager : true,
			url : "/system/basicMaintenance/getCategoryList",
			pageSize:10,
			pageSizeOptions:[10,20,30,40,50],
			width:'99.8%',
			height:'99%',
			showTitle: false,width:'99.8%',
			detail: { onShowDetail: spf_showPropertyDetail,height:'auto' }
		});
	}
	
	//初始化右边属性列表
	function p_initGrid() {
		$grid_p = $("#propertyDetail").ligerGrid({
			columns: [
					{display : '',name : 'PROPERTY_NO',width : '',hide:true},
					{display : '属性编号',name : 'PROPERTY_ID',width : '20%'},
					{display : '属性名',name : 'PROPERTY_NAME',width : '25%',editor: { type: 'text' }},
					{display : '值类型',name : 'P_VALUE_TYPE',width : '20%',editor: { 
                        type: 'select', data: $valueTypeList, dataValueField: 'CODE_ID',dataDisplayField: 'CODE_NAME', 
                        displayColumnName: 'CODE_NAME', valueColumnName: 'CODE_ID'
	                    }, render: function (item){
	                        for (var i = 0; i < $valueTypeList.length; i++){
	                            if ($valueTypeList[i]['CODE_ID'] == item.P_VALUE_TYPE)
	                                return $valueTypeList[i]['CODE_NAME']
	                        }
	                        return item.CODE_NAME;
	                    }
                    },
					{display : '属性描述',name : 'REMARK',width : '35%',editor: { type: 'text' }}
				],
			enabledEdit: true,
			usePager : true,
			url : "/system/basicMaintenance/getPropertyList",
			pageSize:10,
			pageSizeOptions:[10,20,30,40,50],
			width:'99.8%',
			height:'320',
			showTitle: false,width:'99.8%',
			detail: { onShowDetail: spf_showPropertyValueDetail,height:'auto' }
		});
	}
	//初始化右边属性列表
	function p_p_initGrid() {
		$grid_p_p = $("#propertyValueDetail").ligerGrid({
			columns: [
					{display : '',name : 'P_VALUE_NO',width : '',hide:true},
					{display : '值编号',name : 'P_VALUE_ID',width : '25%'},
					{display : '值内容',name : 'P_VALUE',width : '30%',editor: { type: 'text' }},
					{display : '描述',name : 'REMARK',width : '45%',editor: { type: 'text' }}
				],
			enabledEdit: true,
			usePager : true,
			url : "/system/basicMaintenance/getPropertyValueList",
			pageSize:10,
			pageSizeOptions:[10,20,30,40,50],
			width:'99.8%',
			height:'320',
			showTitle: false,width:'99.8%'
		});
	}
	
	function spf_showPropertyDetail(row, detailPanel,callback){
		var grid = document.createElement('div'); 
		$(detailPanel).append(grid);
		$(grid).css('margin',10).ligerGrid({
			columns:[
				{ display: '', name: 'PROPERTY_NO',width:90,hide:1},
				{ display: '属性ID', name: 'PROPERTY_ID' ,width:120},
				{ display: '属性名', name: 'PROPERTY_NAME',width:120},
				{ display: '值类型', name: 'CODE_NAME',width:120},
				{ display: '属性描述', name: 'REMARK',width:200},
				{ display: '是否继承', name: 'IS_PARENT',width:100,render:function(item){
						if(item.IS_PARENT == "YES"){
							return "父类继承";
						}else{
							return "自身属性";
						}
					}
				}
			], 
			usePager: false,rownumbers: true,
			isScroll: false, showToggleColBtn: false, width: '90%',
			url: '/system/basicMaintenance/getPropertyList', 
			parms: [{ name: 'CATEGORY_ID', value: row.CATEGORY_ID}],
			showTitle: false, columnWidth: 360, 
			onAfterShowData: callback,allowUnSelectRow:true
		});
	}
	function spf_showPropertyValueDetail(row, detailPanel,callback){
		var grid = document.createElement('div'); 
		$(detailPanel).append(grid);
		$(grid).css('margin',10).ligerGrid({
			columns:[
				{ display: '', name: 'P_VALUE_NO',width:90,hide:1},
				{ display: '值ID', name: 'P_VALUE_ID' ,width:120},
				{ display: '值内容', name: 'P_VALUE',width:120},
				{ display: '描述', name: 'REMARK',width:200}
			], 
			usePager: false,rownumbers: true,
			isScroll: false, showToggleColBtn: false, width: '90%',
			url: '/system/basicMaintenance/getPropertyValueList', 
			parms: [{ name: 'PROPERTY_ID', value: row.PROPERTY_ID}],
			showTitle: false, columnWidth: 360, 
			onAfterShowData: callback,allowUnSelectRow:true
		});
	}
	
	function spf_update(){
		if($("#detail").css("display") != "none"){
			var rows = $grid.getSelectedRow(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			if (rows.length > 1){
				alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			}
			$dialog = $.ligerDialog.open({isDrag: false, 
				title:'<spring:message code="hrms.update"/>', 
				width: 900, 
				height: 450, 
				url: '/system/basicMaintenance/updateCategoryInfo?CATEGORY_ID=' + rows.CATEGORY_ID+"&CATEGORY_NAME=" + rows.CATEGORY_NAME
			});
		}else if($("#propertyDetail").css("display") != "none"){
			var rows = $grid_p.getSelectedRow(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			if (rows.length > 1){
				alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			}
			$dialog = $.ligerDialog.open({isDrag: false, 
				title:'<spring:message code="hrms.update"/>', 
				width: 900, 
				height: 500, 
				url: '/system/basicMaintenance/updatePropertyInfo?PROPERTY_ID=' + rows.PROPERTY_ID+"&PROPERTY_NAME="+rows.PROPERTY_NAME
			});
		}
	}
	
	function spf_add(){
		var display = $("#detail").css("display");
		if($("#detail").css("display") != "none"){
			var note = manager.getSelected(); 
	    	if (note == null){ 
	    		$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请选择父类') ; 
	    		return ;
	    	}
			$dialog = $.ligerDialog.open({isDrag: true,
				title: '添加明细',
				width: 600 , 
				height: 280 ,
				url: '/system/basicMaintenance/viewAddCategoryInfo?PARENT_ID='+note.data.id+'&PARENT_NAME='+note.data.text
			}); 
		}else if($("#propertyDetail").css("display") != "none"){
			$dialog = $.ligerDialog.open({isDrag: true,
				title: '添加明细',
				width: 600 , 
				height: 260 ,
				url: '/system/basicMaintenance/viewAddPropertyInfo'
			}); 
		}else if($("#propertyValueDetail").css("display") != "none"){
			$dialog = $.ligerDialog.open({isDrag: true,
				title: '添加明细',
				width: 600 , 
				height: 250 ,
				url: '/system/basicMaintenance/viewAddPropertyValueInfo'
			}); 
		}
		
	}
	
	function spf_save(){
		if($("#detail").css("display") != "none"){
			var data = $grid.getData(); 
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/system/basicMaintenance/updateCategory", 
				[
					{ name: 'jsonData', value: JSON2.stringify(data)}
				]
			,function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						$grid.loadData(true);
						f_ChildWindowClose();
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}else if($("#propertyDetail").css("display") != "none"){
			var data = $grid_p.getData(); 
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/system/basicMaintenance/updateProperty", 
				[
					{ name: 'jsonData', value: JSON2.stringify(data)}
				]
			,function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						$grid_p.loadData(true);
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}else if($("#propertyValueDetail").css("display") != "none"){
			var data = $grid_p_p.getSelectedRows(); 
			if(!data || data.length == 0){
			    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请选择您要修改的行') ;
	            return ;
			}
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/system/basicMaintenance/updatePropertyValue", 
				[
					{ name: 'jsonData', value: JSON2.stringify(data)}
				]
			,function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						$grid_p_p.loadData(true);
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	}
	
	function spf_delete(){
		if($("#detail").css("display") != "none"){
			var rows = $grid.getSelectedRow(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			if (rows.length > 1){
				alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			}
			$.ligerDialog.confirm('你确定要删除该数据吗？',
					'<spring:message code="hrms.warning"/>', 
				function (yes){
					if(yes){
						$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
						$.post("/system/basicMaintenance/deleteCategoryInfo", 
							[	
								{ name: 'CATEGORY_ID', value: rows.CATEGORY_ID }
							]
							, function (result){
								$.ligerDialog.closeWaitting();
								if (result == "Y"){
									$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
										$grid.loadData(true); //加载数据 
										f_ChildWindowClose();
									});
								}else{
									$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
								}
							}
						);
					}
				}
			);
		}else if($("#propertyDetail").css("display") != "none"){
			var rows = $grid_p.getSelectedRow(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			if (rows.length > 1){
				alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			}
			$.ligerDialog.confirm('你确定要删除该数据吗？',
					'<spring:message code="hrms.warning"/>', 
				function (yes){
					if(yes){
						$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
						$.post("/system/basicMaintenance/deletePropertyInfo", 
							[	
								{ name: 'PROPERTY_ID', value: rows.PROPERTY_ID }
							]
							, function (result){
								$.ligerDialog.closeWaitting();
								if (result == "Y"){
									$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
										$grid_p.loadData(true); //加载数据 
									});
								}else{
									$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
								}
							}
						);
					}
				}
			);
		}else if($("#propertyValueDetail").css("display") != "none"){
			var rows = $grid_p_p.getSelectedRow(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			if (rows.length > 1){
				alert('<spring:message code="hrms.onlyOneRow"/>'); return;
			}
			alert(rows.P_VALUE_ID+"-"+rows.P_VALUE);
			$.ligerDialog.confirm('你确定要删除该数据吗？',
					'<spring:message code="hrms.warning"/>', 
				function (yes){
					if(yes){
						$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
						$.post("/system/basicMaintenance/deletePropertyValueInfo", 
							[	
								{ name: 'P_VALUE_ID', value: rows.P_VALUE_ID }
							]
							, function (result){
								$.ligerDialog.closeWaitting();
								if (result == "Y"){
									$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
										$grid_p_p.loadData(true); //加载数据 
									});
								}else{
									$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
								}
							}
						);
					}
				}
			);
		}
		
	}
	
	function f_ChildWindowClose(){
		var display = $("#detail").css("display");
		if($("#detail").css("display") != "none"){
			initTreeCategory();
		}else if($("#propertyDetail").css("display") != "none"){
			$grid_p.loadData(true);
		}else if($("#propertyValueDetail").css("display") != "none"){
			$grid_p_p.loadData(true);
		}
	}
	
	function getPropertyValueType(){
		//请求服务器
		var valueType ;
		$.ajax({
			type: 'post',
			url: '/system/basicMaintenance/getPropertyValueType', 
			dataType: 'json',
			async: false,
			success: function (list){
				valueType = list ;
			}
		});
		return valueType ;
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
		<div align="left" position="left" id="parentCode" class="l-scroll"
			style="height: 95%; overflow: auto;"
			title='货品分类'>
			<ul id="tree1">
				
			</ul>
		</div>

		<div align="left" position="center" id='codeInfo' title='分类管理'>
			<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
				<tr>
					<td align="left">
						<SipingSoft:button/>
					</td>
				</tr>  
			</table>
			<div>
				<div id="detail"></div>
				<div id="propertyDetail"></div>
				<div id="propertyValueDetail" style="display:none;"></div>
			</div>
		</div>
		
		<div position="right" id="propertyCode" class="l-scroll"
			style="height: 95%; overflow: auto;"
			title='类别属性'>
			<ul id="tree2">
				<li isexpand="false" id="PROPERTY"><span>类属性管理</span>
					<ul>
						<li isexpand="false" id="property"><span>类属性管理</span>
						<li isexpand="false" id="propertyValue"><span>属性值管理</span>
					</ul></li>
			</ul>
		</div>
	</div>
</body>
</html>
