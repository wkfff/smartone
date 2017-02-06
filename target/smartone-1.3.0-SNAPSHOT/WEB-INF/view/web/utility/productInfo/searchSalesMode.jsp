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
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
	var $grid;
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
		f_initGrid();
	});

	function f_initGrid() {
		$grid = $("#hrSearchEmp").ligerGrid({
			columns : [ 
						{display : '',name : 'SALES_MODE_NO',width : '80',hide:true,frozen:true},
						{display : '',name : 'SALES_MODE_ID',width : '100',frozen:true,hide:1},
						{display : '<spring:message code="hrms.salesMode"/>',name : 'SALES_MODE_NAME',width : '160',frozen:true},
						{display : '<spring:message code="hrms.description"/>',name : 'REMARK',width : '200',frozen:true},
						{display : '<spring:message code="hrms.active"/>',name : 'STATUS',width : '100',frozen:true,
							render : function(item) {
								if(item.STATUS == 0){
									return '<p style="color: red;"><spring:message code="hrms.disable"/></p>';
								}else{
									return '<p style="color: green;"><spring:message code="hrms.enable"/></p>';
								}
							}
						}
				],
			enabledEdit : true,
			usePager : true,
			rownumbers : true,
			url : "/productStorage/proBusinessManage/getSalesModelList",
			pageSize:10,
			pageSizeOptions:[10,20,30,40,50],
			width:'99.8%',
			height:'100%'
		});
	}
	
	function spf_search() {
		$grid.setOptions({
			parms : [
						{name:'keyWord',value : $("#keyWord").val()},
						{name:'STATUS',value : $("#STATUS").val()}
					],
			newPage:1
		});
		$grid.loadData(true);
	}
	
	function spf_selectSalesModeInfo(){
	    var row = $grid.getSelectedRow();
	    return row;
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
#showProductDetailDiv{
	display:none;
}
#hrSearchEmp{
	margin-top:5px;
}
select{
	width:120px;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div>
			<table width="99.6%" align="center" cellpadding="0"
				cellspacing="0" class="l-table-edit_01" border="1xp"
				bordercolor="#A3C0E8">
				<tr>
					<td class="l-table-edit-t" width="15%">
						<spring:message code="keyWord"/></td>
					<td class="l-table-edit-c" width="35%">
						<input type="text" name="keyWord" id="keyWord" style="width:120px;"/></td>
					<td class="l-table-edit-t" width="15%">
						<spring:message code="hrms.active"/></td>
					<td class="l-table-edit-c" width="35%">
						<SipingSoft:selectStatus name="STATUS" limit="all" onChange="spf_search()"/></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit">
				<tr>
					<td align="left" height="30px">
						<a class="l-button"
                            style="width: 79px; height: 20px; float: left; "
                            onclick="spf_search()">搜索</a>
					</td>
				</tr>
			</table>
		</div>
		<div id="hrSearchEmp"></div>
	</div>
</body>
</html>
