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
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script type="text/javascript"> 
var $grid ;
var mcCode="";
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
		allowLeftResize: false,		 //是否允许 左边可以调整大小
		allowRightResize: false,	 //是否允许 右边可以调整大小
		allowTopResize: false,		 //是否允许 头部可以调整大小
		allowBottomResize: false	 //是否允许 底部可以调整大小
	});
	mcCode = '${paraMap.MC_CODE}';
	if(mcCode == 'EMPID'){
		f_initGrid_empID();
	}else{
		f_initGrid(mcCode);
	}
});

function f_initGrid_empID()
{
	$grid = $("#empInfo").ligerGrid({
		checkbox: true,
		columns: [
			{ display: '', name: 'PARAM_NO', width: 10,hide: 1},
			{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:120 },
			{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:120},
			{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width:120},
			{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME',width:90},
			{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 100, editor: { type: 'float' },render:function(item){
                if(item.RETURN_VALUE<=0){
                    item.RETURN_VALUE = '0';
                    return '0';
                }else{
                    return item.RETURN_VALUE;
                }
            }},
			{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
				editor: { type: 'textarea', height: 100 }
			}
		],
		enabledEdit: true,usePager: true, rownumbers:true,
		url: '/pa/salary/getPaInputItemDataEmpInfo?PA_MONTH=${paraMap.PA_MONTH}&PARAM_NO=${paraMap.PARAM_NO}&MC_CODE=${paraMap.MC_CODE}',
		width: '99%', height: '99%'
	});
}
function f_initGrid(mcCode)
{
	/* $.post('/utility/otherInfo/getMCName?TABLE_NAME=PA_HR_V&MC_CODE='+mcCode,function(back){ */
		$grid = $("#empInfo").ligerGrid({
			checkbox: true,
			columns: [
				{ display: '', name: 'PARAM_NO', width: 10,hide: 1},
				{ display: '部门编号', name: 'DEPTID',width:120 },
				{ display: '部门名称', name: 'DEPTNAME',width:120 },
				{ display: '<spring:message code="hrms.value"/>', name: 'RETURN_VALUE', width: 100, editor: { type: 'float' },render:function(item){
                    if(item.RETURN_VALUE<=0){
                        item.RETURN_VALUE = '0';
                        return '0';
                    }else{
                        return item.RETURN_VALUE;
                    }
                }},
				{ display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
					editor: { type: 'textarea', height: 100 }
				}
			],
			enabledEdit: true,usePager: true, rownumbers:true,
			url: '/pa/salary/getPaInputItemDataOtherInfo?PA_MONTH=${paraMap.PA_MONTH}&PARAM_NO=${paraMap.PARAM_NO}&MC_CODE=${paraMap.MC_CODE}',
			width: '99%', height: '99%'
		});
	/* 	}
	); */
}
function spf_search()
{
	$grid.setOptions({ 
		parms: [
			{ name: 'keyWord', value: $("#keyWord").attr('value')},
			{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
			{ name: 'STATUS_CODE', value: $("#STATUS_CODE").attr('value')}
		],
		newPage: 1
	}); //设置数据参数
	$grid.loadData(true); //加载数据
}
function spf_search2()
{
	$grid.setOptions({ 
		parms: [
			{ name: 'keyWord', value: $("#keyWord").attr('value')}
		],
		newPage: 1
	}); //设置数据参数
	$grid.loadData(true); //加载数据
}
function spf_save()
{
	 var jsonData = '[' ;
	 var rows = $grid.getCheckedRows();
	 if (!rows || rows.length == 0) {
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ;
		 return ;
	 }
	$(rows).each(function (index, row){
		if(this.RETURN_VALUE == null || this.RETURN_VALUE == '' || this.RETURN_VALUE == '0' || this.RETURN_VALUE == '0.0' || this.RETURN_VALUE == 'undefined' ){
			/* $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.value"/>'  +". " + '<spring:message code="input.required"/>') ; */
			 return;
		}else {
			if (jsonData.length > 1){
				jsonData += ',{' ;
			 }
			 else{
				jsonData += '{' ;
			 }
			 jsonData += ' "PARAM_NO": "' + this.PARAM_NO + '", ' ;
			 jsonData += ' "PA_MONTH": "${paraMap.PA_MONTH}", ' ;
			 jsonData += ' "FIELD1_VALUE": "' + this.FIELD1_VALUE + '", ' ;
			 jsonData += ' "RETURN_VALUE": "' + this.RETURN_VALUE + '", ' ;
			 jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
			 jsonData += '}' ;
		}
	});
	jsonData += ']' ;
	if(jsonData.length == 2){
		$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
		return ;
	}
	$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	$.post("/pa/salary/addPaInputItemDataInfo",
		[
			{ name: 'jsonData', value: jsonData},
			{name: 'PA_MONTH', value: '${paraMap.PA_MONTH}'}
		]
		, function (result){
			$.ligerDialog.closeWaitting();
			if (result == "Y"){
				$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
					$grid.loadData(true); //加载数据
					parent.f_ChildWindowClose() ; //加载数据
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
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' >
			<c:choose>
				<c:when test="${paraMap.MC_CODE == 'EMPID'}">
					<table width="99%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td width="10%" class="l-table-edit-t"><spring:message
									code="keyWord" /></td>
							<td width="23%" class="l-table-edit-c"><input name="keyWord"
								type="text" id="keyWord" size="30" /></td>
							<td width="10%" class="l-table-edit-t"><spring:message
									code="hrms.EmpStatus" /></td>
							<td width="23%" class="l-table-edit-c"><SipingSoft:selectSyCode
									parentCode="EmpStatus" name="STATUS_CODE"
									onChange="spf_search();" limit="all" /></td>
							<td width="10%" class="l-table-edit-t"><spring:message
									code="hrms.dept" /></td>
							<td width="23%" class="l-table-edit-c"><SipingSoft:deptTree
									name="DEPTID" limit="hr" /></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="l-table-edit"
						height="30">
						<tr>
							<td align="left"><a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_search()"><spring:message code="search" /></a> <a
								class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
						</tr>
					</table>
				</c:when>
				<c:otherwise>
					<table width="99%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td width="10%" class="l-table-edit-t"><spring:message
									code="keyWord" /></td>
							<td width="23%" class="l-table-edit-c"><input name="keyWord"
								type="text" id="keyWord" size="30" /></td>
						</tr>
					</table>
					<table cellpadding="0" cellspacing="0" class="l-table-edit"
						height="30">
						<tr>
							<td align="left">
								<a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_search2()"><spring:message code="search" /></a>
								<a class="l-button"
								style="width: 79px; height: 20px; float: left; margin-left: 10px; "
								onclick="spf_save()"><spring:message code="hrms.save" /></a></td>
						</tr>
					</table>
				</c:otherwise>
			</c:choose>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
