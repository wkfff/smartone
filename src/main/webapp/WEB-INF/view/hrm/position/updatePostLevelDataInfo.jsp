<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >

	<!-- CSS -->
	<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
	<!-- JS -->
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
	<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.validate.min.js" type="text/javascript"></script>
	<script src="/resources/js/jquery/jquery.metadata.js" type="text/javascript"></script>
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
	<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>

<script type="text/javascript">
var $dg_grid ;
var $emp_grid ;
var tabFlag = 0;
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
$(function(){
	//布局
	$("#layout1").ligerLayout({
		allowLeftResize: false,		//是否允许 左边可以调整大小
		allowRightResize: false,	//是否允许 右边可以调整大小
		allowTopResize: false,		//是否允许 头部可以调整大小
		allowBottomResize: false	//是否允许 底部可以调整大小
	});
	$("#navtab1").ligerTab({ onAfterSelectTabItem: function (tabid){
			if(tabid=="tabitem1"){
				//已经分组人员
				tabFlag = 0;
				spf_dg_initGrid();
			}
			if(tabid=="tabitem2"){
				//未分组人员
				tabFlag = 1;
				spf_emp_initGrid();
			}
		} 
	});
	spf_dg_initGrid();
});

//限额休假
function spf_dg_initGrid(){
	$dg_grid = $("#dgEmpInfo").ligerGrid({
		checkbox: true,
		columns: [
					{ display: '', name: 'POST_GRADE_NO', width: 0, hide:1},
					{ display: '级别ID', name: 'POST_GRADE_ID', width: 90},
					{ display: '级别名称', name: 'POST_GRADE_NAME', width: 120}, 
					{ display: '基本工资标准', name: 'BASIC_SALARY', width: 120,editor: { type: 'float' }},
					{ display: '月度考核工资', name: 'KPI_SALARY', width: 120,editor: { type: 'float' }}
		],
		usePager: true,enabledEdit: true,
		url: '/hrm/position/getPostLevelDataInfo', 
		parms: [
				{ name: 'POST_ID', value: '${POST_ID.POST_ID}'}
		],
		width: '99%',height:'98%'
	});
}
//休假明细
function spf_emp_initGrid(){
	$emp_grid = $("#empInfo").ligerGrid({
		checkbox: true,
		columns: [
				{ display: '', name: 'POST_GRADE_NO', width: 0, hide:1},
					{ display: '级别ID', name: 'POST_GRADE_ID', width: 90},
					{ display: '级别名称', name: 'POST_GRADE_NAME', width: 160}, 
					{ display: '基本工资标准', name: 'BASIC_SALARY', width: 120,editor: { type: 'float' }},
					{ display: '月度考核工资', name: 'KPI_SALARY', width: 120,editor: { type: 'float' }}
		],
		usePager: true,enabledEdit: true,
		url: '/hrm/position/getPostLevelDataInfo', 
		parms: [
				{ name: 'POST_NOT_ID', value: '${POST_ID.POST_ID}'}
		],
		width: '99%',height:'98%'
	});
}

function spf_delete(){
	var jsonData = '[' ;
	var rows = $dg_grid.getCheckedRows(); 
	if (!rows || rows.length == 0) { 
		$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		return ; 
	}
	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
		if(yes){
			$(rows).each(function (){
				if (jsonData.length > 1){
					jsonData += ',{'
				}else{
					jsonData += '{'
				}
				jsonData += ' "POST_ID": "' + '${POST_ID.POST_ID}' + '", ' ;
				jsonData += ' "POST_GRADE_ID": "' + this.POST_GRADE_ID + '"' ;
				jsonData += '}' ;
			}); 
			jsonData += ']' ;

			$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
			$.post("/hrm/position/deletePostLevelDataInfo", 
				[	
					{ name: 'jsonData', value: jsonData }
				]
			, function (result){
				$.ligerDialog.closeWaitting();
				if (result == "Y"){
					$.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
						$dg_grid.loadData(true); //加载数据
						parent.f_ChildWindowClose();
					});
				}else{
					$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
				}
			});
		}
	});
}

function spf_save(){
	var flag = true;
	var rows;
	var type;
	var jsonData = '[' ;
	if(tabFlag==0){
		type = "update";
		rows = $dg_grid.getCheckedRows(); 
	}else{
		type = "add";
		rows = $emp_grid.getCheckedRows(); 
	}

	if (!rows || rows.length == 0) { 
	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		return ; 
	}
	
	$(rows).each(function (){
		if(this.BASIC_SALARY < 0 || this.KPI_SALARY < 0){
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请输入正确的工资数目') ;
			flag = false;
			return;
		}
		if (jsonData.length > 1){
			jsonData += ',{'
		}else{
			jsonData += '{'
		}
		jsonData += ' "POST_ID": "' +'${POST_ID.POST_ID}' + '", ' ;
		jsonData += ' "POST_GRADE_ID": "' + this.POST_GRADE_ID + '", ' ;
		jsonData += ' "BASIC_SALARY": "' + this.BASIC_SALARY + '", ' ;
		jsonData += ' "KPI_SALARY": "' + this.KPI_SALARY + '"' ;
		jsonData += '}' ;
	}); 
	jsonData += ']' ;
	if(flag){
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.post("/hrm/position/addOrUpdatePostLevelDataInfo", 
			[	
				{ name: 'jsonData', value: jsonData },
				{ name: 'type', value: type }
			]
		, function (result){
		$.ligerDialog.closeWaitting();
			if (result == "Y"){
				$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
					if(type == "update"){
						$dg_grid.loadData(true); //加载数据
						parent.f_ChildWindowClose();
					}else{
						$dg_grid.loadData(true); //加载数据
						$emp_grid.loadData(true); //加载数据
						parent.f_ChildWindowClose();
					}
				});
			}else{
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		});
	}
}

</script>
	<style type="text/css"> 
		body{ padding:5px; margin:0; padding-bottom:15px;}
		#layout1{  width:99%;margin:0; padding:0;  } 
	</style>
</head>
<body style="padding:0px">
<div id = 'layout1'>
	<div align="left">
		<table cellpadding="0" cellspacing="0" class="l-table-edit">
			<tr>
				<td align="left" height="30px">
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
				</td>
			</tr>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td class="l-table-edit-c" colspan="4">
					<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8; ">
						<div title='职位现有等级'>
							<div id="dgEmpInfo"></div>
						</div>
						<div title='职位未选等级'>
							<div id="empInfo"></div>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>
