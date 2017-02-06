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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid = null;
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
			topHeight : 30,
			allowLeftResize : false, //是否允许 左边可以调整大小
			allowRightResize : false, //是否允许 右边可以调整大小
			allowTopResize : false, //是否允许 头部可以调整大小
			allowBottomResize : false
		//是否允许 底部可以调整大小
		});
		f_initGrid();
	});

	function f_initGrid() {
		$grid = $("#empInfo").ligerGrid(
			{
				checkbox : true,
				columns : [
					{display : '',name : 'PROD_NO',width : 160,hide:1},
					{display : '物料编码',name : 'PROD_ID',width : 120
					},
					{display : '物料描述',name : 'DRAWING_NO',width : 120
					},
					{display : '重量',name : 'WEIGHT',width : 100
					},
					{display : '单价',name : 'UNIT_PRICE',width : 100,
						editor : {
							type : 'float'
						}
					},
					{display : '<spring:message code="hrms.projectQuantity"/>',name : 'QUANTITY',width : 120,
						type : 'float'
					},
					{display : '<spring:message code="hrms.remarks"/>',name : 'REMARK',align : 'left',
								width : 120,
								editor : {
									type : 'textarea',
									height : 100
								}
					}
				],
				enabledEdit : true,
				usePager : true,
				rownumbers : true,
				url : '/ess/viewApp/getProductionOrderInfo?PRO_NO='+"${paraMap.PRO_NO}",
				parms : [],
				width : '99.6%',
				height : '100%',
				onAfterEdit: f_onAfterEdit
			});
	}
	
	function f_onAfterEdit(e){
		$grid.updateCell('QUANTITY', format_number(e.record.UNIT_PRICE * e.record.WEIGHT,2), e.record);
	}

	function format_number(pnumber, decimals) {
		if (isNaN(pnumber)) {
			return 0
		}
		;
		if (pnumber == '') {
			return 0
		}
		;
		var snum = new String(pnumber);
		var sec = snum.split('.');
		var whole = parseFloat(sec[0]);
		var result = '';
		if (sec.length > 1) {
			var dec = new String(sec[1]);
			dec = String(parseFloat(sec[1])
					/ Math.pow(10, (dec.length - decimals)));
			dec = String(whole + Math.round(parseFloat(dec))
					/ Math.pow(10, decimals));
			var dot = dec.indexOf('.');
			if (dot == -1) {
				dec += '.';
				dot = dec.indexOf('.');
			}
			while (dec.length <= dot + decimals) {
				dec += '0';
			}
			result = dec;
		} else {
			var dot;
			var dec = new String(whole);
			dec += '.';
			dot = dec.indexOf('.');
			while (dec.length <= dot + decimals) {
				dec += '0';
			}
			result = dec;
		}
		return result;
	}
	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据  
		$dialog.close();
	}
	
	function spf_add() {
		$dialog = $.ligerWindow.show({
			isDrag : true,
			title : '<spring:message code="hrms.add"/>',
			width : 500,
			height : 250,
			left : 120,
			top : 90,
			url : '/ess/infoApp/viewAddProductionOrder?PRO_NO='+"${paraMap.PRO_NO}"
		});
	}
	
	function spf_save() {
		var jsonData = '[';
		var quantity = 0;
		var rows = $grid.getCheckedRows();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return false;
		}
		$(rows).each(
			function(index, row) {
				quantity = this.UNIT_PRICE * this.WEIGHT;
				if (this.PROD_ID == null|| this.PROD_ID == ''|| this.PROD_ID == 'undefined') {
					$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','生产订单号'
						+ ". "+ '<spring:message code="input.required"/>');
					return false;
				}
				if (this.DRAWING_NO == null || this.DRAWING_NO == ''
						|| this.DRAWING_NO == 'undefined') {
					$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','物料描述'
						+ ". "+ '<spring:message code="input.required"/>');
					return false;
				}
				if (this.WEIGHT == null || this.WEIGHT == ''|| this.WEIGHT == 'undefined') {
					$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.projectQuantity"/>'
						+ ". "+ '<spring:message code="input.required"/>');
					return false;
				} else {
					if (jsonData.length > 1) {
						jsonData += ',{';
					} else {
						jsonData += '{';
					}
					jsonData += ' "PROD_NO": "' + this.PROD_NO + '", ';
					jsonData += ' "PROD_ID": "'
							+ this.PROD_ID + '", ';
					jsonData += ' "DRAWING_NO": "'
							+ this.DRAWING_NO + '", ';
					jsonData += ' "WEIGHT": "'
							+ this.WEIGHT + '",';
					jsonData += ' "UNIT_PRICE": "'
						+ this.UNIT_PRICE + '",';
					jsonData += ' "QUANTITY": "'
						+ quantity + '",';
					jsonData += ' "REMARK": "'
							+ MyCheckNull(this.REMARK) + '"';
					jsonData += '}';
				}
			});
		jsonData += ']';
		var jsonList = eval("(" + jsonData + ")");
		if (jsonData.length == 0) {
			return;
		}
		if (jsonList.length == rows.length) {
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			$.post("/ess/infoApp/updateProductionOrderInfo", [ {name : 'jsonData',value : jsonData} ],
				function(result) {
					$.ligerDialog.closeWaitting();
					if (result == "Y") {
						$.ligerDialog.success(
								'<spring:message code="hrms.saveSuccess"/>',
								'<spring:message code="hrms.warning"/>',
								function() {
									$grid.loadData(true); //加载数据 
								});
					} else {
						$.ligerMessageBox.error(
								'<spring:message code="hrms.warning"/>', result);
					}
				}
			);
		}
	}
	function spf_checkData() {
		var rows = $grid.getCheckedRows();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return false;
		}
		return true;
	}
	function spf_delete() {
		$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>',
			function(yes) {
				if (yes) {
					var jsonData = '[';
					var rows = $grid.getCheckedRows();
					if (!rows || rows.length == 0) {
						$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
						return false;
					}
					$(rows).each(
						function(index, row) {
							if (jsonData.length > 1) {
								jsonData += ',{';
							} else {
								jsonData += '{';
							}
							jsonData += ' "PROD_NO": "'+ this.PROD_NO+ '" ';
							jsonData += '}';
						});
					jsonData += ']';
					var jsonList = eval("(" + jsonData + ")");
					if (jsonData.length == 0) {
						$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>','<spring:message code="hrms.chooseLine"/>');
						return false;
					}
					$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
					$.post(
						'/ess/infoApp/deleteProductionOrderInfo',
						[ {name : 'jsonData',value : jsonData} ],
						function(result) {
							$.ligerDialog.closeWaitting();
							if (result == "Y") {
								$.ligerDialog
										.success(
												'<spring:message code="hrms.deleteSuccess"/>',
												'<spring:message code="hrms.warning"/>',
												function() {
													$grid.loadData(true); //加载数据  
												});
							} else {
								$.ligerMessageBox
										.error(
												'<spring:message code="hrms.warning"/>',
												result);
							}
						});
				}
			});
	}
	function spf_inExcel() {
		$dialogUpload = $.ligerDialog.open({
			isDrag : false,
			title : '上传文件',
			width : 430,
			height : 230,
			url : '/ess/infoApp/uploadProductionOrder?PRO_NO='+"${paraMap.PRO_NO}"
		});
	}
	
	function spf_afterUploadSuccess()
	{
		$dialogUpload.close();
		$grid.loadData(true);
	}
	
	function spf_downloadProductionOrderTemplate() {
		location.href = "/ess/infoApp/downloadProductionOrderTemplate";
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
		<div position="top">
			<table width="99.5%" cellpadding="1" cellspacing="1"
				style="font-size: 12px;">
				<tr>
					<td align="right" height="30px;">
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_downloadProductionOrderTemplate()">下载模板</a>
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_inExcel()">导入</a>
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_add()"><spring:message code="hrms.add" /></a>
						<a	class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_save()"><spring:message code="hrms.save" /></a>
						<a class="l-button"
							style="width: 79px; height: 20px; float: right; margin-right: 10px; "
							onclick="spf_delete()"><spring:message code="hrms.delete" /></a>
					</td>
				</tr>
			</table>
		</div>
		<div position="center" id='empInfo'></div>
	</div>
</body>
</html>
