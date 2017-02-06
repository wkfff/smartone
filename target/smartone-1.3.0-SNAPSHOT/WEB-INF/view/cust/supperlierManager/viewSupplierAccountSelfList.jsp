<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title></title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%--<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%> --%>

<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
	var $grid;
	var flag = true;
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
	
	function toggleActivity(ACTIVITY)
	{
		
		var row=$grid.getSelectedRow(); 
		if(ACTIVITY==0)
			{
			ACTIVITY=1;
			}
		else
			{
			ACTIVITY=0;
			}
		$.post("/cust/supplierAccountSelfManager/toggleSupplierActivity",{ACTIVITY:ACTIVITY,ADMINNO:row.ADMINNO},function(result){
			if(result=='Y')
				{
				$.ligerDialog.success(
						'<spring:message code="hrms.saveSuccess"/>',
						'切换状态成功');
				f_initGrid();
				}
			else
				{
				$.ligerMessageBox
				.error(
						'<spring:message code="hrms.warning"/>',
						'内部发生错误');
				}
		});
		
	}
	// 初始调用
	$(function() {

		f_initGrid();
		$("*[name='ACTIVITY']").width(180);
		$("*[name='ACTIVITY']").css({
			border : "1px solid #c1dcfa"
		});
		$("*[name='supplier_TYPE_CODE']").css({
			border : "1px solid #c1dcfa"
		});
		$("*[name='supplier_TYPE_CODE']").width(180);
		$("*[name='STATUS_S']").css({
			border : "1px solid #c1dcfa"
		});
		$("*[name='STATUS_S']").width(180);
		$("#showSupplierAccountDiv").hide();
		spf_check();
		var $open;
	});

	function f_initGrid() {
		$grid = $("#hrSearchEmp").ligerGrid({
			columns : [ 
			            {display : '',name : 'ADMINNO',width : '5%',hide : true},
			            {display : '供应商id',name : 'SUPPLIER_ID',width : '5%',hide:true},
			            {display : '公司名称',name : 'SUPPLIER_NAME',width : '25%'},
			            {display : '登录账号',name : 'USERNAME',width : '15%'},
			            {display : '状态',name : 'ACTIVITY',width : '10%',render : function(item) {
							if (item.ACTIVITY == 0) {
									return "锁定中&nbsp;&nbsp;<a class='activity' onclick='toggleActivity("+item.ACTIVITY+")' >开启</a>";
							} else if (item.ACTIVITY == 1) {
									return "开启中&nbsp;&nbsp;<a class='activity' onclick='toggleActivity("+item.ACTIVITY+")' >锁定</a>";
							} else {
									return "待定";
							}
					}
				} ],
			enabledEdit : false,
			usePager : true,
			rownumbers : true,
			isScroll : true,
			url : "/cust/supplierAccountSelfManager/getSupplierAccountSelfModelList",
			pageSize : 10,
			pageSizeOptions : [ 10, 20, 30, 40, 50 ],
			width : '99.8%',
			height : '100%',
			enabledSort : true,
			onDblClickRow : spf_update
		});

	}

	function spf_check() {
		$("#PASSWORD").focus(function() {
			$("#message").hide();
		})
		$("#USERNAME").focus(function() {
			$("#message").hide();
		});

	}
	function showSalesModelDetail() {
		var row = $grid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}
		$("#USERNAME").val(row.USERNAME);
		$("#USERNAME").attr("readonly","readonly");
		$("#SUPPLIER_ID").val(row.SUPPLIER_ID);
		$("#ADMINNO").val(row.ADMINNO);
		$("#PASSWORD").val("");
		$("#showSupplierAccountDiv").show();
	}
	function showSalesModelDetailAdd() {
		

				$("#USERNAME").removeAttr("readonly");
				$("#USERNAME").val("");
				$("#PASSWORD").val("");
				$("#ADMINNO").val("");
				$("#showSupplierAccountDiv").show();
				
	}
	function spf_checkUSERNAME() {

		if ($("#USERNAME").val() == null || $("#USERNAME").val() == "") {
			$("#message").show();
			$("#message").text("账户名不能为空");
			return false;
		}

		if ($("#PASSWORD").val() == null || $("#PASSWORD").val() == "") {
			$("#message").show();
			$("#message").text("密码不能为空");
			return false;
		}
		if($("#PASSWORD").val().length<6)
		{
			
			$("#message").show();
			$("#message").text("输入的密码不得少于6位");
			return false;
		
		}
		return true;
	}

	function spf_search() {
		$grid.setOptions({
			parms : [ {
				name : 'keyWord',
				value : $("#keyWord").val()
			}, {
				name : 'STATUS',
				value : $("#STATUS_S").val()
			} ],
			newPage : 1
		});

		$grid.loadData(true);
	}

	function spf_add() {
		showSalesModelDetailAdd();
		$open = $.ligerDialog.open({
			target : $("#showSupplierAccountDiv"),
			width : '320',
			title : '添加账号',
			left : '30%',
			top : '30%',
		});

	}

	function spf_clear() {
		$open.hidden();
	}

	function spf_account() {
		$("#account").show(500);
	}

	function f_saveOrUpdate() {
		if(!spf_checkUSERNAME())
			{
				return false;
			}
		else{
			$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
			var options = {
				url : '/cust/supplierAccountSelfManager/addOrUpdateSupplierAccountSelfModel',
				type : 'POST',
				success : function(result) {
					$.ligerDialog.closeWaitting();
					if(result=="Exist")
						{
							$("#message").show();
							$("#message").text("用户名已经存在!");
							
						}
					else{
						if (result == "Y") {
	
							$.ligerDialog.success(
									'<spring:message code="hrms.saveSuccess"/>',
									'<spring:message code="hrms.warning"/>');
	
							$grid.loadData(true);
							$open.hidden();
	
						} else {
							$.ligerMessageBox
									.error('<spring:message code="hrms.warning"/>',result);
						}
					}
				},
				error : function() {
					alert("wrong");
				}
			};
			$('#form1').ajaxSubmit(options);
		}
		

	}

	function spf_update() {
		var row = $grid.getSelectedRow();
		if (!row || row.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}

		if (row.USERNAME == null || row.USERNAME == "") {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'对不起，不能编辑本行!');
			return;
		}
		showSalesModelDetail();
		$open = $.ligerDialog.open({
			target : $("#showSupplierAccountDiv"),
			width : '320',
			title : '修改账号',
			left : '30%',
			top : '35%',
		});
	}

	function spf_delete() {
		var rows = $grid.getSelectedRows();
		if (!rows || rows.length == 0) {
			$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>',
					'<spring:message code="hrms.chooseLine"/>');
			return;
		}

		$.ligerDialog
				.confirm(
						'你确定要删除该数据吗？',
						'<spring:message code="hrms.warning"/>',
						function(yes) {
							if (yes) {
								var jsonData = '[';
								$(rows)
										.each(
												function(index, row) {
													if (row.USERNMAE == ""
															|| row.USERNAME == null) {
														$.ligerMessageBox
																.warn(
																		'<spring:message code="hrms.warning"/>',
																		'对不起，选择用户含有没有添加账号！');
														return;
													}

													if (jsonData.length > 1) {
														jsonData += ',{';
													} else {
														jsonData += '{';
													}
													jsonData += ' "USERNAME": "'+ this.USERNAME
+ '",';
													jsonData += ' "SUPPLIER_ID": "'
															+ this.SUPPLIER_ID
															+ '"';
													jsonData += '}';
												});
								jsonData += ']';
								if (jsonData.length == 2) {
									$.ligerMessageBox
											.warn(
													'<spring:message code="hrms.warning"/>',
													'<spring:message code="hrms.editData"/>');
									return;
								}
								$.ligerDialog
										.waitting('<spring:message code="hrms.deleting"/>');
								//alert(1);
								$
										.post(
												"/cust/supplierAccountSelfManager/deleteSupplierAccountSelfModel",
												{
													jsonData : jsonData
												}
												/* [	
													{ name: 'jsonData', value: jsonData }
												] */
												,
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
																					.loadData(true); //加载数据 
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

#showSupplierAccountDiv {
	display: none;
}

#hrSearchEmp {
	margin-top: 5px;
}

#add {
	margin-left: 10px;
	text-align: left;
	line-height: 30px;
	height: 30px;
}

table .text {
	padding: 3px 0px 3px 3px;
}

table .text1 {
	text-align: center;
	font-size: 12px;
	line-height: 2px;
	padding-left: 5px;
	background-color: #c1dcfa;
	color: #12436b;
	font-family: serif;
}

table .SUPPLIER_DESCRIPTION {
	border-color: #c1dcfa;
	border: 1px solid #c1dcfa;
	font-size: 12px;
}

table .SUPPLIER {
	width: 200px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #c1dcfa;
	font-size: 12px;
}

table .SUPPLIER1 {
	width: 200px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #c1dcfa;
	font-size: 12px;
	color: #777777;
}
#hrSearchEmp .activity{
	text-decoration:underline;
	color: #0099CC;
	cursor: pointer;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div>
			<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td class="l-table-edit-t" width="15%"><spring:message
							code="keyWord" /></td>
					<td class="l-table-edit-c" width="35%"><input type="text"
						name="keyWord" id="keyWord" class="SUPPLIER" /></td>
					<td class="l-table-edit-t" width="15%">状态</td>
					<td class="l-table-edit-c" width="35%"><SipingSoft:selectStatus
							name="STATUS_S" limit="all" onChange="spf_search()" /></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="left" height="30px"><SipingSoft:button /></td>

				</tr>
			</table>

			<div id="showSupplierAccountDiv">
				
				<form name="form1" method="post" action="" id="form1">
					<input type="hidden" name="ADMINNO" id="ADMINNO"> <input
						type="hidden" name="SUPPLIER_ID" id="SUPPLIER_ID" />
					<table width="270px" align="center" cellpadding="1" cellspacing="1"
						class="l-table-edit_01" bordercolor="#A3C0E8">
						
						
						
						<tr>
							<td class="text1" width="30%">账户名</td>
							<td class="text" width="70%"><input type="text"
								name="USERNAME" id="USERNAME" class="SUPPLIER"
								style="width: 180px;" /></td>

						</tr>
						<tr>
							<td class="text1" width="30%">密码</td>
							<td class="text" width="70%"><input type="password"
								name="PASSWORD" id="PASSWORD" class="SUPPLIER"
								style="width: 180px;" /></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align: center; color: red;"
								id="check"><label id="message"></label></td>
						</tr>

					</table>

				</form>
				<table width="99%" align="center">
					<tr align="center">

						<td height="30" align="center"><a class="l-button"
							style="width: 50px; height: 20px; margin-left: 80px; ackground-image: url('/resources/images/button/button.gif');"
							onclick="f_saveOrUpdate()">保存</a></td>
						<td><a class="l-button"
							style="width: 50px; height: 20px; margin-right: 80px; "
							onclick="spf_clear()">取消</a></td>
					</tr>
				</table>
			</div>

		</div>
		<div id="hrSearchEmp"></div>
	</div>
</body>
</html>
