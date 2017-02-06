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
	var $grid;
	var $evTypeSelectList;
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

		$evTypeSelectList = getEvTypeSelectList();
		spf_initGrid();

	});

	function getEvTypeSelectList() {
		//请求服务器
		var evTypeSelectList;
		$.ajax({
			type : 'post',
			url : '/utility/otherInfo/getEvTypeSelectList',
			dataType : 'json',
			async : false,
			success : function(list) {
				evTypeSelectList = list;
			}
		});

		return evTypeSelectList;
	}
	function spf_initGrid() {
		$grid = $("#info")
				.ligerGrid(
						{
							checkbox : false,
							columns : [
									{
										display : '<spring:message code="hrms.year"/>',
										name : 'EV_YEAR',
										width : 60
									},
									{
										display : '<spring:message code="hrms.duration"/>',
										name : 'EV_PERIOD_ID',
										width : 80
									},
									{
										display : '<spring:message code="hrms.duration"/>'
												+ ' '
												+ '<spring:message code="name"/>',
										name : 'EV_PERIOD_NAME',
										width : 120,
										editor : {
											type : 'text'
										}
									},

									{
										display : '<spring:message code="hrms.type"/>'
												+ ' '
												+ '<spring:message code="name"/>',
										name : 'EV_TYPE_ID',
										width : 130,
										align : 'center',
										editor : {
											type : 'select',
											data : $evTypeSelectList,
											dataValueField : 'EV_TYPE_ID',
											dataDisplayField : 'EV_TYPE_NAME',
											displayColumnName : 'EV_TYPE_NAME',
											valueColumnName : 'EV_TYPE_ID'
										},
										render : function(item) {
											for ( var i = 0; i < $evTypeSelectList.length; i++) {
												if ($evTypeSelectList[i]['EV_TYPE_ID'] == item.EV_TYPE_ID) {
													return $evTypeSelectList[i]['EV_TYPE_NAME'];

												}
											}
											return item.EV_TYPE_NAME;
										}
									},
									{
										display : '<spring:message code="hrms.description"/>',
										name : 'DESCRIPTION',
										width : 180,
										editor : {
											type : 'textarea',
											height : 100
										}
									},
									{
										display : '<spring:message code="hrms.remarks"/>',
										name : 'REMARK',
										align : 'left',
										width : 160,
										editor : {
											type : 'textarea',
											height : 100
										}
									} ],
							enabledEdit : true,
							usePager : false,
							rownumbers : true,
							url : '/eva/basicInfo/getEvaPeriodTypeInfo?EV_PERIOD_ID=${paraMap.EV_PERIOD_ID}',
							width : '99.6%',
							height : '100%',
							onDblClickRow : function(rowdata, rowindex,
									rowDomElement) {
								spf_showEvaPeriodTypeItemInfo(
										MyCheckNull(rowdata.EV_PERIOD_ID),
										MyCheckNull(rowdata.EV_TYPE_ID));
							}
						});
	}

	function spf_showEvaPeriodTypeItemInfo(evPeriodID, evTypeID) {
		$dialog = $.ligerWindow.show({
			isDrag : true,
			title : '<spring:message code="hrms.itemInfo"/>',
			width : 620,
			height : 250,
			left : 120,
			top : 30,
			url : '/eva/basicInfo/viewEvaPeriodTypeItemInfo?EV_PERIOD_ID='
					+ evPeriodID + '&EV_TYPE_ID=' + evTypeID
		});
	}
	function spf_save() {
		var jsonData = '[';

		var rows = $grid.getData();

		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$(rows)
				.each(
						function(index, row) {
							if (this.EV_TYPE_ID == null
									|| this.EV_TYPE_ID == 'undefined') {
								$.ligerMessageBox
										.warn(
												'<spring:message code="hrms.warning"/>',
												'<spring:message code="hrms.type"/>'
														+ ". "
														+ '<spring:message code="input.required"/>');
								return;
							} else {
								if (jsonData.length > 1) {
									jsonData += ',{';
								} else {
									jsonData += '{';
								}
								jsonData += ' "__status": "' + this.__status
										+ '", ';
								jsonData += ' "EV_TYPE_NO": "'
										+ MyCheckNull(this.EV_TYPE_NO) + '", ';
								jsonData += ' "EV_PERIOD_ID": "${paraMap.EV_PERIOD_ID}", ';
								jsonData += ' "EV_TYPE_ID": "'
										+ this.EV_TYPE_ID + '", ';
								jsonData += ' "DESCRIPTION": "'
										+ MyCheckNull(this.DESCRIPTION) + '",';
								jsonData += ' "REMARK": "'
										+ MyCheckNull(this.REMARK) + '"';
								jsonData += '}';
							}
						});

		jsonData += ']';

		if (jsonData.length == 2) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.editData"/>');
			return;
		}
		$.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
		$.post("/eva/basicInfo/saveAndUpdateEvaPeriodTypeInfo", [ {
			name : 'jsonData',
			value : jsonData
		} ], function(result) {
			$.ligerDialog.closeWaitting();
			if (result == "Y") {
				$.ligerDialog.success(
						'<spring:message code="hrms.submitSuccess"/>',
						'<spring:message code="hrms.warning"/>', function() {
							$grid.loadData(true);//加载数据 
						});
			} else {
				$.ligerMessageBox.error(
						'<spring:message code="hrms.warning"/>', result);
			}
		});
	}

	function f_ChildWindowClose() {
		$grid.loadData(true); //加载数据 
	}

	function spf_search() {
		$grid.setOptions({
			parms : [ {
				name : 'keyWord',
				value : $("#keyWord").attr('value')
			} ],
			newPage : 1
		}); //设置数据参数 
		$grid.loadData(true); //加载数据
	}
	function spf_add() {
		var rows = $grid.getData();
		if (!rows || rows.length == 0) {
			$grid.addRow();
		} else {
			$(rows).each(function(index, row) {
				if (index == rows.length - 1) {
					$grid.addRow({
						EV_YEAR : this.EV_YEAR,
						EV_PERIOD_ID : this.EV_PERIOD_ID,
						EV_PERIOD_NAME : this.EV_PERIOD_NAME,
						EV_TYPE_ID : this.EV_TYPE_ID,
						DESCRIPTION : this.DESCRIPTION,
						REMARK : this.REMARK
					});
				}
			});
		}
	}
	function spf_delete() {
		var row = $grid.getSelectedRow();

		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$.ligerDialog
				.confirm(
						'<spring:message code="hrms.whetherDelete"/>',
						'<spring:message code="hrms.warning"/>',
						function(yes) {
							if (yes) {

								$.ligerDialog
										.waitting('<spring:message code="hrms.deleting"/>');
								$
										.post(
												'/eva/basicInfo/deleteEvaPeriodTypeInfo',
												[ {
													name : 'EV_TYPE_NO',
													value : row.EV_TYPE_NO
												} ],
												function(result) {
													$.ligerDialog
															.closeWaitting();
													if (result == "Y") {
														$.ligerDialog
																.success(
																		'<spring:message code="hrms.deleteSuccess"/>',
																		'<spring:message code="hrms.warning"/>',
																		function() {
																			$grid
																					.loadData(true);//加载数据 
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
			<%-- 
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td align="center" valign="middle"> 
						  	 <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						           <tr> 
						               <td width="15%" class="l-table-edit-t">
						               		<spring:message code="keyWord"/></td>
						               <td width="35%" class="l-table-edit-c">
						               		<input name="keyWord" type="text" id="keyWord" size="30"/></td> 
						            </tr> 
						       </table> 
		       			</td>
			      	</tr>
			    </table>  
			    --%>

			<table cellpadding="0" cellspacing="0" class="l-table-edit"
				height="30px;">
				<tr>
					<td align="left"><a class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_save()"><spring:message code="hrms.save" /></a> <a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_add()"><spring:message code="hrms.add" /></a> <a
						class="l-button"
						style="width: 79px; height: 20px; float: left; margin-left: 10px; "
						onclick="spf_delete()"><spring:message code="hrms.delete" /></a></td>
				</tr>
			</table>
		</div>
		<div position="center" id="info"></div>
	</div>
</body>
</html>
