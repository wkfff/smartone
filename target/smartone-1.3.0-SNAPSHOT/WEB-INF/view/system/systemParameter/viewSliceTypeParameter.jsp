<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $dialog;
	var $slice_type_grid;
	var $pro_m_grid;
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create : function(container, editParm) {
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue : function(input, editParm) {
			return input.val();
		},
		setValue : function(input, value, editParm) {
			input.val(value);
		},
		resize : function(input, width, height, editParm) {
			var column = editParm.column;
			if (column.editor.width)
				input.width(column.editor.width);
			else
				input.width(width);
			if (column.editor.height)
				input.height(column.editor.height);
			else
				input.height(height);
		}
	};
	// 初始调用
	$(function() {
		//布局
		$("#layout1").ligerLayout({

			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
		spf_slice_type_initGrid();
	});
	//项目信息
	function spf_slice_type_initGrid() {
		$slice_type_grid = $("#sliceType").ligerGrid(
						{
							onBeforeEdit : function(e) {
								$.ligerui.win.masking = true;
							},
							checkbox : false,
							columns : [
									{
										display : '主键',
										name : 'PARAMETER_NO',
										width : 100
									},
									{
										display : '切割方式',
										name : 'SLICE_TYPE_NAME',
										width : 150,
										editor : {
											type : 'text'
										}
									},
									{
										display : '创建日期',
										name : 'CREATE_DATE',
										width : 150,
										type : 'date'
									},
									{
										display : '<spring:message code="hrms.remarks"/>',
										name : 'REMARKS',
										align : 'left',
										width : 200,
										editor : {
											type : 'textarea',
											height : 100
										}
									}
							],
							enabledEdit: true,
							usePager: true, 
							rownumbers: false,
							dataAction: 'server', 
							root: 'sliceTypeParameterList', 
							record: 'sliceTypeParameterCnt',
				            url: '/system/systemParameter/getSliceTypeParameter',
							width : '99.6%',
							height : '100%',
							pageSize : 20,
							showTitle : false,
							columnWidth : 380,
							detail : {
								onShowDetail:spf_showDetailData,
								height : 'auto'
							}
						});
	}
	function spf_showDetailData(row, detailPanel, callback) {
		var grid = document.createElement('div');
		$(detailPanel).append(grid);
		$pro_m_grid = $(grid).css('margin', 10).ligerGrid({
			columns : [ 
            { display: '起始厚度:(mm)', 
              name: 'MIN_THICKNESS',
              width: 120,
              type: 'int'
             },
             { display: '结束厚度:(mm)', 
               name: 'MAX_THICKNESS',
               width: 120,
               type: 'int'},
             
			{
				display : '单价:(元/米)',
				name : 'UNIT_PRICE',
				width : 120,
				type : 'float'
			},
			{
				display : '<spring:message code="hrms.remarks"/>',
				name : 'REMARKS',
				align : 'left',
				width : 160,
				editor : {
					type : 'textarea',
					height : 100
				}
			} ],
			enabledEdit : false,
			usePager : true,
			rownumbers : true,
			pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
			isScroll : false,
			showToggleColBtn : false,
			width : '97%',
			url : '/system/systemParameter/getSliceTypeDetail?PARAMETER_NO=' + row.PARAMETER_NO,
			showTitle : false
		});
	}
	function f_ChildWindowClose() {
		$slice_type_grid.loadData(true); //加载数据  
		$dialog.close();
	}
	function spf_updateSliceTypeParameter(parameterNo) {
		if (parameterNo == "" || parameterNo == "undefined") {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		} else {
			$dialog = $.ligerWindow.show({
				isDrag : true,
				title : '详细信息',
				width : 700,
				height : 400,
				left : 120,
				top : 50,
				url : '/system/systemParameter/updateSliceTypeParameter?PARAMETER_NO=' + parameterNo
			});
		}
	}
	function spf_update() {
		var rows = $slice_type_grid.getSelectedRow();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
			return;
		}
		spf_updateSliceTypeParameter(rows.PARAMETER_NO);
	}
	function spf_add()
    {
		$slice_type_grid.addRow();
    }
	function spf_delete() {
		var rows = $slice_type_grid.getSelectedRow();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>',
		function(yes) {
			if (yes) {
				$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
				$.post('/system/systemParameter/deleteSliceTypeParameter',
				[ {
					name : 'PARAMETER_NO',
					value : rows.PARAMETER_NO
				}],
				function(result) {
					$.ligerDialog.closeWaitting();
					if (result == "Y") {
						$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>',
							function() {
								$slice_type_grid.loadData(true); //加载数据  
							});
					} else {
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>',result);
					}
				});
			}
		});
	}
	function spf_save() {
		var data = $slice_type_grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/systemParameter/saveAndUpdateSliceTypeParameter", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)}
                 ]
        , function (result){
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$slice_type_grid.loadData(true); 
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
	}
</script>
</head>
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
<body style="padding: 2px">
	<div id="layout1">
		<div align="center">
			<table width="99.6%" cellpadding="1" cellspacing="1"
				style="height: 30px; font-size: 12px;">
				<tr>
					<td width="5%" align="center"><img
						src="/resources/images/title/top_1.gif" /></td>
					<td width="25%" align="left" style="font-weight: bold;">切割方式</td>
					<td width="5%" align="right">&nbsp;</td>
					<td align="right"><SipingSoft:button /></td>
				</tr>
			</table>

			<div id="sliceType"></div>
		</div>
	</div>
</body>
</html>
