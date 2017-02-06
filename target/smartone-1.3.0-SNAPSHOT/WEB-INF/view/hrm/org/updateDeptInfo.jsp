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
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script type="text/javascript">
	var $grid ;
	var $quota_grid;
	var $dialog;
	var $positionSelectList;
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
				topHeight: 230, 
				allowLeftResize: false,		 //是否允许 左边可以调整大小
				allowRightResize: false,	 //是否允许 右边可以调整大小
				allowTopResize: false,		//是否允许 头部可以调整大小
				allowBottomResize: false	 //是否允许 底部可以调整大小
			}
		  );
		if($('#DEPTID').val()==null || $('#DEPTID').val()==''|| $('#DEPTID').val()=='undefined'){
	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '请点击左边的“组织预览”进入，在“部门列表”中选择要修改部门，然后在“部门信息”点击“修改”进入此页面', function afterClick(){
	       		 top.tab.removeTabItem('hr0601');
	       	 });
        }else {
			//$positionSelectList = getPositionSelectList();
			spf_employee_initGrid();
			$("#navtab1").ligerTab({
				onAfterSelectTabItem: function (tabid){
					if(tabid=="tabitem1"){
						$Flag = "E";
						spf_employee_initGrid();
					}
					if(tabid=="tabitem2"){
						$Flag = "P";
						spf_deptQuota_initGrid();
					}
				}
			});
        }
		
	});
	//员工列表
	function spf_employee_initGrid(){
		$emp_grid =$("#employeeInfo").ligerGrid({
				checkbox: true,
				columns: [
					{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID',width:120 },
					{ display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME' ,width:120},
					{ display: '<spring:message code="hrms.post"/>', name: 'POST_NAME',width:120},
					{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME',align: 'center', width: 130,isSort: false},
					{ display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS',width:90},	 
					{ display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', width:120}
				],
				enabledEdit: true,usePager: true,dataAction: 'server', root: 'empInfoList', record: 'empInfoListCnt',rownumbers:true,
				url: "/utility/empInfo/getEmpInfoList?DEPTID=${deptInfoMap.DEPTID }", 
				pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
				width: '99.8%', height: '100%',
				heightDiff : 0
		});
	}
	//获取职位列表
	function getPositionSelectList() {
		//请求服务器
		var positionSelectList;
		$.ajax({
			type:'post',
			url:'/utility/otherInfo/getPositionSelectList',
			dataType:'json',
			async:false,
			success:function(list) {
				positionSelectList = list;
			}
		});
		return positionSelectList;
	}
	//定编列表
	function spf_deptQuota_initGrid(){
		$quota_grid = $("#deptQuotaInfo").ligerGrid({
			checkbox: false,
			columns: [
				{ display: '<spring:message code="hrms.post"/>', name:'POST_NAME', width: 120},
				{ display: '<spring:message code="hrms.quotaNumber"/>', name: 'QUOTA_NUMBER', width: 120,editor:{type:'text'}},
				{ display: '<spring:message code="hrms.realNumber"/>', name: 'REAL_NUMBER', width: 120},
				{display: '<spring:message code="hrms.differenceOfPeople"/>', name: 'DIFFERENCE', width: 120,
							render: function(rowdata, index){
								rowdata.DIFFERCENCE = rowdata.REAL_NUMBER - rowdata.QUOTA_NUMBER;
								if (rowdata.QUOTA_NUMBER > rowdata.REAL_NUMBER) {
									return '<p style="color:red">'+rowdata.DIFFERCENCE+'</p>';
								} else {
									return '<p style="color:green">'+rowdata.DIFFERCENCE+'</p>';
								}
							}
				},
				{ display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', width: 200, editor:{type:'textarea',height:100}}
			],
			usePager: true,rownumbers:true,
			url: "/hrm/org/getDeptQuotaList?DEPTID=${deptInfoMap.DEPTID }",
			pageSize: 10, pageSizeOptions:[10, 20, 30, 40, 50],
			width: '99.8%', height: '100%',
			enabledEdit: true,
			rowAttrRender:function(rowdata,rowid) {
				if (rowdata.quotaNumber > rowdata.realNumber) {
					return "style='backgroud:#FFFFFF;'";
				}
				return "";
			}
		 });
	}
	 /*
	 *职员信息弹出框收缩js
	*/
	$(function (){
		$("#MANAGER_EMP_NAME").ligerComboBox({
			onBeforeOpen: spf_selectEmp, valueFieldID: 'EMPID',width:150
		});
	});
	function spf_selectEmp()
	{
		$.ligerDialog.open({ 
			title: '<spring:message code="employee.information"/>', 
			name:'winselector'+Math.random(),
			width: 800, 
			height: 400, 
			url: '/utility/empInfo/viewHrSearchEmployeeB', 
			buttons: [
				{ text: '<spring:message code="okay"/>', onclick: spf_selectOK_EMP },
				{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_EMP },
				{ text: '<spring:message code="clear"/>', onclick: spf_selectClear_EMP }
			]
		});
		return false;
	}
	function spf_selectOK_EMP(item, dialog)
	{
		var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
		var data = fn(); 
		if (!data)
		{
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			 return ; 
		}
		$("#MANAGER_EMP_NAME").val(data.EMPID+","+data.CHINESENAME);
		$("#EMPID").val(data.EMPID);
		$("#EMP_DEPT_ID").val(data.DEPTID);
		dialog.close();
	}
	function spf_selectCancel_EMP(item, dialog)
	{
		dialog.close();
	}
	function spf_selectClear_EMP(item, dialog)
	{
		$("#MANAGER_EMP_NAME").val("");
		$("#EMPID").val("");
		$("#EMP_DEPT_ID").val("");
		dialog.close();
	}
	/*
	 *部门息弹出框收缩js
	*/
	$(function (){  
		$("#PARENT_DEPT_NAME").ligerComboBox({
			onBeforeOpen: spf_selectDepartment, valueFieldID: 'PARENTDEPTID',width:150
		});
	});
	function spf_selectDepartment() { 
		$.ligerDialog.open({
			title: '<spring:message code="hrms.dept.information"/>', 
			width: 800, 
			height: 400, 
			url: '/utility/deptInfo/selectDepartment', 
			buttons: [
				{ text: '<spring:message code="okay"/>', onclick: spf_selectOK_DEPT },
				{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_DEPT },
				{ text: '<spring:message code="clear"/>', onclick: spf_selectClear_DEPT }
			]
		});
		return false;
	}
	function spf_selectOK_DEPT(item, dialog){
		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
		var data = fn(); 
		if (!data)
		{
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return ; 
		}
		$("#PARENT_DEPT_NAME").val(data.DEPTNAME.replace(/&nbsp;/g,""));
		$("#PARENTDEPTID").val(data.DEPTID);
		dialog.close(); 
	} 
	function spf_selectCancel_DEPT(item, dialog){
		dialog.close();
	} 
	function spf_selectClear_DEPT(item, dialog){
		$("#PARENT_DEPT_NAME").val("");
		$("#PARENTDEPTID").val("");
		dialog.close();
	}
	function spf_save(){
		$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
		var options = {
			url:'/hrm/org/updateDeptInfo',
			type:'POST',
			success: function (result){
					$.ligerDialog.closeWaitting();
					if (result == "Y"){
						$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
						{
							parent.f_ChildWindowClose() ;
						});
					}else{
						$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
					}
				}
			}; 
		$('#form1').ajaxSubmit(options);
		/* else{
			$.ligerDialog.confirm('该部门负责人并不属于该部门，是否继续？','<spring:message code="hrms.warning"/>', 
				function (yes){
					if(yes){
						$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
						var options = {
							url:'/hrm/org/updateDeptInfo',
							type:'POST',
							success: function (result){
								$.ligerDialog.closeWaitting();
								if (result == "Y"){
									$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
									{
										parent.f_ChildWindowClose() ;
									});
								}else{
									$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.sameDataAlreadyExists"/>');
								}
							}
						}; 
						$('#form1').ajaxSubmit(options);
					}
			});
		} */
	}
	//增加定编信息
	function spf_addDeptQuotaInfo()
	{
		$dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
    		width: 900, height: 540, 
    		url: "/hrm/org/addDeptQuotaInfo?DEPTID=${deptInfoMap.DEPTID }",
    	});	
	}
	//删除定编信息
	function spf_deleteDeptQuotaInfo()
    {	
		var row = $quota_grid.getSelectedRow(); 
    	if (!row || row.length == 0) {
   			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
   			return ;
    	}
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes){
			if(yes){
				$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
				$.post('/hrm/org/deleteDeptQuotaInfo',
						{"POST_ID":row.POST_ID,"DEPTID":row.DEPTID,"CPNY_ID":row.CPNY_ID}, 
						function(result){
							$.ligerDialog.closeWaitting();
							if (result == "Y")
		  		            {
		  		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		  		                {
		  		                	$quota_grid.loadData(true);
		  		                });
		  		            }else{
		  		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		  		            }
						});
			}
		});
	}
	//修改定编信息
	function spf_saveDeptQuotaInfo()
    {  
        var data = $quota_grid.getData();     
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/org/updateDeptQuotaInfo", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)}
                 ]
        , function (result)
        {
       
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$quota_grid.loadData(true); 
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
    }
	function f_ChildWindowClose(){
		$quota_grid.loadData(true); //加载数据
		$dialog.close();
	}
	function spf_transferEmployees() {
    	var rows = $emp_grid.getCheckedRows(); 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
        $.ligerDialog.open({
			title: '<spring:message code="hrms.dept.information"/>', 
			width: 800, 
			height: 400, 
			url: '/utility/deptInfo/selectDepartment', 
			name:'deptselect'+Math.random(),
			buttons: [
				{ text: '<spring:message code="okay"/>', onclick: spf_selectOK_ToDEPT },
				{ text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_ToDEPT }
			]
		});
		return false;
	}
	function spf_selectOK_ToDEPT(item, dialog){
		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
		var data = fn(); 
		if (!data)
		{
			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
			return ; 
		}
		var toDeptid = data.DEPTID;
		var jsonData = '[' ;
    	var rows = $emp_grid.getCheckedRows(); 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
		$(rows).each(function (index, row){
   	    	if (jsonData.length > 1){
   		    	jsonData += ',{' ;
   		    }
   		    else{
   		        jsonData += '{' ;
   		    } 
   		        jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
   		        jsonData += ' "DEPTID": "' + toDeptid + '"' ;
   		        jsonData += '}' ;
           }); 
       	jsonData += ']' ; 
       	if(jsonData.length == 2){
  // 	        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
               return ;
        }
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/org/massTransferEmployees", 
                [	
                 	{ name: 'jsonData', value: jsonData }
                ]
        , function (result)
        {
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {	
                	spf_employee_initGrid(); 
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
		dialog.close(); 
	} 
	function spf_selectCancel_ToDEPT(item, dialog){
		dialog.close();
	}
</script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
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
	<div id='layout1' >
		<div position="center" id='' >
			<div position="top" >
				<form name="form1" method="post" action="" id="form1">
					<table width="99.6%" cellpadding="1" cellspacing="1"
						style="height: 25px; font-size: 12px;">
						<tr>
							<td width="5%" align="center"><img
								src="/resources/images/title/top_1.gif" /></td>
							<td width="25%" align="left" style="font-weight: bold;">
								部门信息</td>
							<td width="5%" align="right">&nbsp;</td>
							<td align="right" height="30px;">
								<SipingSoft:button/>
							</td>
						</tr>
					</table>
					<table align="center" width="99.6%" cellpadding="0" cellspacing="0"
						class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr>
							<td class="l-table-edit-t" width="15%">
								<spring:message code="hrms.basicCode" />
							</td>
							<td class="l-table-edit-c" colspan="3">
								${deptInfoMap.DEPTID }
								<input name="DEPTID" type="hidden" id="DEPTID" value="${deptInfoMap.DEPTID }" />
								<input name="DEPTNO" type="hidden" id="DEPTNO" value="${deptInfoMap.DEPTNO }" />
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-t" width="15%"><spring:message
									code="hrms.manager" /></td>
							<td class="l-table-edit-c" width="35%">
								<input type="text" id="MANAGER_EMP_NAME" name="MANAGER_EMP_NAME" value="${deptInfoMap.MANAGER_EMP_NAME }" />
								<input type="hidden" id="EMPID" name="EMPID" value="${deptInfoMap.MANAGER_EMP_ID }" /> 
								<input type="hidden" id="EMP_DEPT_ID" name="EMP_DEPT_ID" />
							</td>
							<td class="l-table-edit-t" width="15%"><spring:message
								code="hrms.dept.parent" /></td>
							<td class="l-table-edit-c" width="35%">
								<input type="text" id="PARENT_DEPT_NAME" name="PARENT_DEPT_NAME" value="${deptInfoMap.PARENT_DEPT_NAME }"/>
								<input type="hidden" id="PARENTDEPTID" name="PARENTDEPTID" value="${deptInfoMap.PARENT_DEPT_ID }" />
							</td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message
								code="hrms.chineseName" /></td>
							<td class="l-table-edit-c"><input name="DEPTNAME" type="text"
								id="DEPTNAME" value="${deptInfoMap.DEPTNAME }"
								validate="{required:true}" /></td>
							<td class="l-table-edit-t"><spring:message
									code="hrms.englishName" /></td>
							<td class="l-table-edit-c"><input name="DEPT_EN_NAME"
								type="text" id="DEPT_EN_NAME"
								value="${deptInfoMap.DEPT_EN_NAME }" /></td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message
								code="hrms.startDate" /></td>
							<td class="l-table-edit-c"><input type="text"
								name="DATE_CREATED" id="DATE_CREATED"
								value="${deptInfoMap.DATE_CREATED }"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true})"
								validate="{required:true}" readonly="readonly" /></td>
							<td class="l-table-edit-t"><spring:message
									code="hrms.endDate" /></td>
							<td class="l-table-edit-c"><input type="text"
								name="DATE_ENDED" id="DATE_ENDED"
								value="${deptInfoMap.DATE_ENDED }"
								onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,readOnly:true})"
								readonly="readonly" /></td>
						</tr>
						<tr>
							<td class="l-table-edit-t"><spring:message
								code="hrms.description" /></td>
							<td class="l-table-edit-c" colspan="3"><textarea 
								rows="4" name="DESCRIPTION" id="DESCRIPTION"
								style="width:400px" >${deptInfoMap.DESCRIPTION }</textarea></td>
						</tr>
					</table>
				</form>
			</div>
			<!-- 定编信息 -->
			<table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
				<tr>
					<td align="right" height="30px">
						<a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_deleteDeptQuotaInfo()">删除定编</a>
						<a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_addDeptQuotaInfo()">添加定编</a>
						<a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_saveDeptQuotaInfo()">保存修改</a>
						<a class="l-button" style="width:79px; height:20px; float:right; margin-left:10px;" onclick="spf_transferEmployees()">员工 转移</a>
					</td>
				</tr>
			</table>
			<div id="navtab1" style="width: 100%; overflow: hidden; border:1px solid #A3C0E8;">
				<!-- div id="deptQuotaInfo"></div> -->
				<div title='<spring:message code="hrms.empInfo"/>'>
					<div id="employeeInfo"></div>
				</div>
				<div title='<spring:message code="hrms.quotaInfo"/>'>
					<div id="deptQuotaInfo"></div>
				</div>		
			</div>
		</div>
	</div>
</body>
</html>
