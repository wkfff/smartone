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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>

<script src="/resources/js/json2.js" type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $grid ;
	var $dialog ; 
	var $itemInfoSelectList ; 
	var $unitSelectList ; 
	// 初始调用
	$(function (){
		//布局
		$("#layout1").ligerLayout({  
			allowTopResize: false       //是否允许 头部可以调整大小
		}
		);
		f_initGrid();
	});

	function f_initGrid(){
		$grid = $("#arDetailInfo").ligerGrid({
			checkbox: false,
			columns: [
						{ display: '', name: 'PK_NO' ,width: 5,hide:1},
						{ display: '<spring:message code="hrms.attendanceDate"/>', name: 'AR_DATE_STR',width: 110},
						{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME',width: 150,align: 'left'},
						{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',width: 150,align: 'left'},
						{ display: '<spring:message code="hrms.workingShift.name"/>', name: 'SHIFT_NAME',width: 130}, 
						{ display: '<spring:message code="hrms.attendanceItem"/>', name: 'ITEM_NAME', align: 'center',width: 130},
						{ display: '<spring:message code="hrms.startedTime"/>', name: 'FROMTIME',width: 140 },
						{ display: '<spring:message code="hrms.endTime"/>', name: 'TOTIME',width: 140 },
						{ display: '<spring:message code="hrms.quantity"/>', name: 'QUANTITY',width: 60}, 
						{ display: '<spring:message code="hrms.unit"/>', name: 'UNIT_CODE', align: 'center',width: 60},
						{ display: '', name: 'LOCK_YN_CODE',width: 5,hide:1},
						{ display: '', name: 'DATE_TYPE',width: 5,hide:1},
						{ display: '<spring:message code="hrms.active"/>', name: 'LOCK_YN_NAME',width: 70}
			],
			enabledEdit: false, usePager: true,  rownumbers:true,
			url: '/att/attendanceInfomation/getPersonalAttDetailList',
			parms: [	
					{ name: 'sDate', value: $("#sDate").val()},
					{ name: 'eDate', value: $("#eDate").val()},
					{ name: 'empId', value: '${empId }'}
			], 
			width: '99.6%', height: '100%' 
		}); 
	}
	/*
	 *弹出框收缩js
	 */ 
	$(function (){ 
		$("#key").ligerComboBox({
			onBeforeOpen: spf_selectEmp, valueFieldID: 'keyWord',width:150
		});
	});
	function spf_selectEmp(){
		$.ligerDialog.open({ 
			title: '<spring:message code="employee.information"/>', 
			name:'winselector'+Math.random(),
			width: 800, 
			height: 400, 
			url: '/utility/empInfo/viewHrSearchEmployeeB', 
			buttons: [
				{ text: '<spring:message code="okay"/>', onclick: spf_selectOK },
				{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
				{ text: '<spring:message code="clear"/>', onclick: spf_selectClear }
				]
			});
			return false;
	}
	function spf_selectOK(item, dialog){
		var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
		var data = fn(); 
		if (!data){
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return ;
		}
		$("#key").val(data.EMPID+","+data.CHINESENAME);
		$("#keyWord").val(data.EMPID); 
		dialog.close();
	}
	function spf_selectCancel(item, dialog){
		dialog.close();
	}
	function spf_selectClear(item, dialog){
		$("#key").val("");
		$("#keyWord").val("");
		dialog.close();
	}
	/*
	 *弹出框收缩js
	 */
	/**
	*提交改变数据
	*/
	function spf_save(){
		var rows = $grid.getData() ; 
		var jsonData = '[' ;
		$(rows).each(function(index, row){ 
			if(this.__status != null && this.__status == 'update'){
				if (jsonData.length > 1){
					jsonData += ',{' ;
				}else{
					jsonData += '{' ;
				}
				if(this.LOCK_YN_CODE == 'N'){ 
					jsonData += ' "PK_NO": "' + this.PK_NO + '", ' ;
					jsonData += ' "ITEM_NO": "' + this.ITEM_NO+ '", ' ;
					jsonData += ' "UNIT_CODE": "' + this.UNIT_CODE + '", ' ;
					jsonData += ' "DATE_TYPE": "' + this.DATE_TYPE + '", ' ;
					jsonData += ' "QUANTITY": "' + this.QUANTITY + '"' ;
					jsonData += '}' ;
				}
			}
		});
		jsonData += ']' ;
		if(jsonData.length == 2){
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return ; 
		}

		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		$.post('/att/attendanceMintenance/updateAttDetailInfo', 
				[	
					{ name: 'jsonData', value: jsonData },
				]
		, function (result){
			if (result == "Y"){
				$.ligerDialog.closeWaitting();
				$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',function (){
					$grid.loadData(true);
				});
			}else{ 
				$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
			}
		}); 
	}

	function spf_search(){
		$grid.setOptions({ parms: [	
									{ name: 'sDate', value: $("#sDate").attr('value')},
									{ name: 'eDate', value: $("#eDate").attr('value')}, 
									{ name: 'itemNo', value: $("#itemNo").attr('value')},
									{ name: 'empId', value: '${empId}'}
								],
							newPage: 1
						}); //设置数据参数
		$grid.loadData(true); //加载数据
	}

	function f_ChildWindowClose (){ 
		$grid.loadData(true); //加载数据
		$dialog.close() ;
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
		<div align="left" position="center" id='' title=' '>
			<div align="left">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="hrms.startDate" /></td>
						<td width="35%" class="l-table-edit-c"><input type="text"
							name="sDate" id="sDate" value="${S_DATE}" size="30"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy/MM/dd'})"
							readonly="readonly" /></td>
							
						<td class="l-table-edit-t" width="15%"><spring:message
								code="hrms.endDate" /></td>
						<td class="l-table-edit-c" width="35%"><input type="text" name="eDate"
							id="eDate" size="30" value="${E_DATE}"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy/MM/dd'})"
							readonly="readonly" /></td>
					</tr>
					<tr>
						<td width="10%" class="l-table-edit-t"><spring:message
								code="hrms.attendanceItem" /></td>
						<td width="20%" class="l-table-edit-c" colspan="3"><SipingSoft:select
							name="itemNo" dataListName="itemList" limit="all"
								onChange="spf_search();" /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
				<div position="center" id='arDetailInfo'></div>
			</div>
		</div>
	</div>
</body>
</html>
