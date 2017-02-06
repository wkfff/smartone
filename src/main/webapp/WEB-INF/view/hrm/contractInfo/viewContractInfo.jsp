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
    <script src="/resources/js/ligerUI/js/plugins/ligerDateEditor.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<script src="/resources/js/function.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
    <script type="text/javascript">
    var $grid ; 
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
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
         f_initGrid(); 
    });
    function f_initGrid()
    {
    	$grid = $("#contractInfo").ligerGrid({
    		columns: [
	            { display: '', name: 'CONTRACT_NO', width: 0,hide:1},
	            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,frozen:true},
	            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
	            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true},
	            { display: '<spring:message code="hrms.post"/>', name: 'POST', width: 120},
	            { display: '<spring:message code="hrms.contractType"/>', name: 'CONTRACTTYPE',width:120},
	            { display: '<spring:message code="hrms.startDate"/>', name: 'CONTRACTSTARTDATE',width:120},
	            { display: '<spring:message code="hrms.endDate"/>', name: 'CONTRACTENDDATE',width:120},
	            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,editor: { type: 'textarea', height: 100 }}
            ],
            enabledEdit: true,usePager: true,rownumbers: true,
            url: '/hrm/contractInfo/getContractInfoList',
            width: '99.6%', height: '100%', 
            heightDiff : 0
        });
    }
	//下载由合同模板生成的文档，并对里面相关信息进行替换
    function spf_downloadContract(contractNo,contractTypeCode){
		window.open('/hrm/contractInfo/downloadContract?CONTRACT_NO='+contractNo+'&CONTRACT_TYPE_CODE='+contractTypeCode,"文档下载");
	}
    function spf_search()
    {
    	$grid.setOptions({ 
    		parms: [	
           	{ name: 'keyWord', value: $("#keyWord").attr('value')},
           	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
           	{ name: 'CONTRACT_TYPE_CODE', value: $("#CONTRACT_TYPE_CODE").attr('value')}, 
           	{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
           	{ name: 'E_DATE', value: $("#E_DATE").attr('value')}
          ],
    	    newPage: 1
    	}); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_delete()
    {
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){
		    	var rows = $grid.getSelectedRow(); 
		        if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/hrm/contractInfo/deleteContractInfoInfo", 
		                [	
		                 	{ name: 'CONTRACT_NO', value: rows.CONTRACT_NO }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',function ()
		                {
		                	$grid.loadData(true); //加载数据
		                });
		            }
		            else
		            {
		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		            }
		        });
            }
        });
    }
    function spf_save()
    {    
    	var data = $grid.getData(); 
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/hrm/contractInfo/updateContractInfo", 
               [
                	{ name: 'jsonData', value: JSON2.stringify(data) }
               ]
       , function (result){
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
               {
                  	$grid.loadData(true); //加载数据  
               });
           }
           else{
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
           }
       });
    }
	</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<table width="99.6%" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="15%" class="l-table-edit-t"><spring:message
							code="keyWord" /></td>
					<td width="35%" class="l-table-edit-c"><input name="keyWord"
						type="text" id="keyWord" size="30" /></td>
					<td width="15%" class="l-table-edit-t"><spring:message
							code="hrms.dept" /></td>
					<td width="35%" class="l-table-edit-c"><SipingSoft:deptTree
							name="DEPTID" limit="hr" /></td>
				</tr>
				<tr>
					<td class="l-table-edit-t"><spring:message
							code="hrms.contractType" /></td>
					<td class="l-table-edit-c"><SipingSoft:selectSyCode
							parentCode="ContractTypeCode" name="CONTRACT_TYPE_CODE"
							limit="all" onChange="spf_search()"/></td>
					<td class="l-table-edit-t"><spring:message
							code="hrms.endDate" /></td>
					<td class="l-table-edit-c" nowrap="nowrap"><input type="text"
						name="S_DATE" id="S_DATE" value="" size="30"
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /> ~ <input type="text" name="E_DATE"
						id="E_DATE" value="" size="30"
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" class="l-table-edit" height="30">
				<tr>
					<td align="left"><SipingSoft:button /></td>
				</tr>
			</table>
			<div position="center" id='contractInfo'></div>
		</div>
	</div>
</body>
</html>
