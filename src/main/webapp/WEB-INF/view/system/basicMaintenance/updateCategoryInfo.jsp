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
				spf_dg_initGrid();
			}
			if(tabid=="tabitem2"){
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
			{ display: '', name: 'PROPERTY_NO',width:90,hide:1},
			{ display: '属性ID', name: 'PROPERTY_ID' ,width:120},
			{ display: '属性名', name: 'PROPERTY_NAME',width:120},
			{ display: '值类型', name: 'CODE_NAME',width:120},
			{ display: '属性描述', name: 'REMARK',width:90},
			{ display: '是否继承', name: 'IS_PARENT',width:100,render:function(item){
				if(item.IS_PARENT == "YES"){
					return "父类继承";
				}else{
					return "自身属性";
				}
			}
		}
		],
		usePager: true,
		url: '/system/basicMaintenance/getPropertyList', 
		parms: [{ name: 'CATEGORY_ID', value: '${category.CATEGORY_ID}'}],
		width: '99%',height:'98%'
	});
}
//休假明细
function spf_emp_initGrid(){
	$emp_grid = $("#empInfo").ligerGrid({
		checkbox: true,
		columns: [
			{ display: '', name: 'PROPERTY_NO',width:90,hide:1},
			{ display: '属性ID', name: 'PROPERTY_ID' ,width:120},
			{ display: '属性名', name: 'PROPERTY_NAME',width:120},
			{ display: '值类型', name: 'CODE_NAME',width:120},
			{ display: '属性描述', name: 'REMARK',width:90}
		],
		usePager: true,
		url: '/system/basicMaintenance/getPropertyList', 
		parms: [{ name: 'NOT_CATEGORY_ID', value: '${category.CATEGORY_ID}'}],
		width: '99%',height:'98%'
	});
}

function spf_delete(){
	var jsonData = '[' ;
	var isParent = false;
	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
		if(yes){
			var rows = $dg_grid.getCheckedRows(); 
			if (!rows || rows.length == 0) { 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
				return ; 
			}
			$(rows).each(function (){
			    if (this.IS_PARENT == "YES") { 
	                isParent = true;
	                return ; 
	            }
			    
				if (jsonData.length > 1){
					jsonData += ',{'
				}else{
					jsonData += '{'
				}
				jsonData += ' "CATEGORY_ID": "${category.CATEGORY_ID}", ';
				jsonData += ' "PROPERTY_ID": "' + this.PROPERTY_ID + '" ';
				jsonData += '}' ;
			}); 
			jsonData += ']' ;
		    
			if (isParent) { 
			    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '父类继承属性非自身属性，不可删除') ; 
                return ; 
            }
			   
			$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
			$.post("/system/basicMaintenance/deletePropertyFromCategory", 
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
		jsonData += ' "PROPERTY_ID": "' +this.PROPERTY_ID + '", ' ;
		jsonData += ' "CATEGORY_ID": "${category.CATEGORY_ID}" ' ;
		jsonData += '}' ;
	}); 
	jsonData += ']' ;

	$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
	$.post("/system/basicMaintenance/addPropertyToCategory", 
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

</script>
	<style type="text/css"> 
		body{ padding:5px; margin:0; padding-bottom:15px;}
		#layout1{  width:99%;margin:0; padding:0;  } 
	</style>
</head>
<body style="padding:0px">
<div id = 'layout1'>
	<div align="left">
		<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td class="l-table-edit-t" width="20%">类别ID</td>
				<td class="l-table-edit-c" width="30%">
					${category.CATEGORY_ID }
					<input type="hidden" name="CATEGORY_ID" id="CATEGORY_ID" value="${category.CATEGORY_ID }"/>
				</td>
				<td class="l-table-edit-t" width="20%">类别名称</td>
				<td class="l-table-edit-c" width="30%">
					${category.CATEGORY_NAME }
				</td>
			</tr>
		</table>
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
						<div title='已有属性'>
							<div id="dgEmpInfo"></div>
						</div>
						<div title='未包含属性'>
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
