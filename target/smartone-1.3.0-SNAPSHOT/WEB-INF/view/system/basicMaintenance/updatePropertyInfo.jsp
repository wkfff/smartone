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
var tab = 1;
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
				tab = 1;
				//已经分组人员
				spf_dg_initGrid();
			}
			if(tabid=="tabitem2"){
				tab = 2;
				//未分组人员
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
			{ display: '', name: 'P_VALUE_NO',width:90,hide:1},
			{ display: '值编号', name: 'P_VALUE_ID' ,width:100},
			{ display: '值内容', name: 'P_VALUE',width:120},
			{ display: '描述', name: 'REMARK',width:200}
		],
		usePager: true,
		url: '/system/basicMaintenance/getPropertyValueList', 
		parms: [
			{ name: 'PROPERTY_ID', value: '${property.PROPERTY_ID}'},
			{ name: 'keyWord', value: $("#keyWord").val()}
		],
		width: '99%',height:'98%'
	});
}
//休假明细
function spf_emp_initGrid(){
	$emp_grid = $("#empInfo").ligerGrid({
		checkbox: true,
		columns: [
			{ display: '', name: 'P_VALUE_NO',width:90,hide:1},
			{ display: '值编号', name: 'P_VALUE_ID' ,width:100},
			{ display: '值内容', name: 'P_VALUE',width:120},
			{ display: '描述', name: 'REMARK',width:200}
		],
		usePager: true,
		url: '/system/basicMaintenance/getPropertyValueList', 
		parms: [
				{ name: 'NOT_PROPERTY_ID', value: '${property.PROPERTY_ID}'},
				{ name: 'keyWord', value: $("#keyWord").val()}
			],
		width: '99%',height:'98%'
	});
}

function spf_delete(){
	var jsonData = '[' ;
	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
		if(yes){
			var rows = $dg_grid.getCheckedRows(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			$(rows).each(function (){
				if (jsonData.length > 1){
					jsonData += ',{'
				}else{
					jsonData += '{'
				}
				jsonData += ' "PROPERTY_ID": "${property.PROPERTY_ID}", ';
				jsonData += ' "P_VALUE_ID": "' + this.P_VALUE_ID + '" ';
				jsonData += '}' ;
			}); 
			jsonData += ']' ;

			$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
			$.post("/system/basicMaintenance/deleteValueFromProperty", 
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
	var jsonData = '[' ;
	var rows = $emp_grid.getCheckedRows(); 

	if (!rows || rows.length == 0) { 
	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		return ; 
	}
	
	$(rows).each(function (){
		if (jsonData.length > 1){
			jsonData += ',{'
		}else{
			jsonData += '{'
		}
		jsonData += ' "P_VALUE_ID": "' +this.P_VALUE_ID + '", ' ;
		jsonData += ' "PROPERTY_ID": "${property.PROPERTY_ID}" ' ;
		jsonData += '}' ;
	}); 
	jsonData += ']' ;

	$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
	$.post("/system/basicMaintenance/addValueToProperty", 
		[	
			{ name: 'jsonData', value: jsonData }
		]
	, function (result){
	$.ligerDialog.closeWaitting();
		if (result == "Y"){
			$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
				$emp_grid.loadData(true); //加载数据
				$dg_grid.loadData(true); //加载数据
				parent.f_ChildWindowClose();
			});
		}else{
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		}
	});
}

function spf_search(){
	if(tab == 1){
		spf_dg_initGrid();
	}else{
		spf_emp_initGrid();
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
		<table width="99%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8" style="margin-left:5px;">
			<tr>
				<td class="l-table-edit-t" width="20%">属性编号</td>
				<td class="l-table-edit-c" width="30%">
					${property.PROPERTY_ID }
					<input type="hidden" name="PROPERTY_ID" id="PROPERTY_ID" value="${property.PROPERTY_ID }"/>
				</td>
				<td class="l-table-edit-t" width="20%">属性名称</td>
				<td class="l-table-edit-c" width="30%">
					${property.PROPERTY_NAME }
				</td>
			</tr>
		</table>
		<table cellpadding="0" cellspacing="0" class="l-table-edit">
			<tr>
				<td align="left" height="30px">
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:5px;" onclick="spf_save()"><spring:message code="hrms.save"/></a>
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_delete()"><spring:message code="hrms.delete"/></a>
				</td>
			</tr>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td class="l-table-edit-c" colspan="4">
					<table width="100%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td width="10%" class="l-table-edit-t">关键字</td>
							<td width="23%" class="l-table-edit-c">
								<input name="keyWord" type="text" id="keyWord" size="30" style="float:left;"/>
								<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" 
									onclick="spf_search()"><spring:message code="search"/>
								</a>
							</td>
						</tr>
					</table>
				
					<div id="navtab1" style="width: 100%;overflow:hidden; border:1px solid #A3C0E8;margin-top:3px;">
						<div title='已有值'>
							<div id="dgEmpInfo"></div>
						</div>
						<div title='新值'>
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
