<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
    <script type="text/javascript"> 
    var $grid = null ; 
    var $bankSelectList ; 
    var $calcFlagSelectList ;
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
        $bankSelectList = getBankSelectList() ;
        $calcFlagSelectList = getCalcFlagSelectList() ;
         f_initGrid(); 
    });

    function getBankSelectList(){
    	//请求服务器
    	var bankSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getBankSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	bankSelectList = list ; 
            }
        });
        return bankSelectList ;
    } 
    function getCalcFlagSelectList(){
    	//请求服务器
    	var calcFlagSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getCalcFlagSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	calcFlagSelectList = list ; 
            }
        });
        return calcFlagSelectList ;
    } 
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: false,
    		columns: [     
    	     	        { display: '', name: 'PA_NO',width: 10,hide:1}, 
			            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120},
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120},
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},
			            { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 100},
			            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 90},
		    	        { display: '<spring:message code="hrms.wageMark"/>', name: 'CALC_FLAG_ID', width: 90,align: 'center',isSort: false,
		                    editor: { 
		                    	type: 'select', data: $calcFlagSelectList, dataValueField: 'CALC_FLAG_ID',dataDisplayField: 'CALC_FLAG_NAME',
		                    	displayColumnName: 'CALC_FLAG_NAME', valueColumnName: 'CALC_FLAG_ID'
		                    }, render: function (item)
		                    {
		                        for (var i = 0; i < $calcFlagSelectList.length; i++)
		                        {
		                            if ($calcFlagSelectList[i]['CALC_FLAG_ID'] == item.CALC_FLAG_ID)
		                                return $calcFlagSelectList[i]['CALC_FLAG_NAME']
		                        }
		                        return item.CALC_FLAG_NAME;
		                    }
		    	        },
		    	        { display: '<spring:message code="hrms.bank"/>', name: 'BANK_NAME', width: 160,align: 'center',editor:{type : 'text'}},
		                { display: '<spring:message code="hrms.accountNumber"/>', name: 'CARD_NO',width: 160,editor:{type : 'text'}},  
			            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
			            	editor: { type: 'textarea', height: 100 }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/pa/wagebase/getPaAccountInfo', 
            width: '99.6%', height: '100%'
        });
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
               { name: 'keyWord', value: $("#keyWord").attr('value')}, 
               { name: 'DEPTID', value: $("#DEPTID").attr('value')}, 
               { name: 'CALC_FLAG', value: $("#CALC_FLAG").attr('value')}
           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
     
    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据 
    }

    function spf_save()
    {
    	var jsonData = '[' ; 
    	var rows = $grid.getData(); 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
       $(rows).each(function (index, row)
             { 
       	        if(this.__status != null && this.__status == 'update'){
			     	 if (jsonData.length > 1){
			             	jsonData += ',{' ;
			             }
			             else{
			             	jsonData += '{' ;
			             }  
			             jsonData += ' "PA_NO": "' + this.PA_NO + '", ' ;    
			             jsonData += ' "EMPID": "' + this.EMPID + '", ' ;    
			             jsonData += ' "CALC_FLAG_ID": "' + this.CALC_FLAG_ID + '",' ;  
			             jsonData += ' "BANK_NAME": "' + this.BANK_NAME + '",' ;  
			             jsonData += ' "CARD_NO": "' + this.CARD_NO + '",' ;  
			             jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
			             jsonData += '}' ; 
	           } 
        }); 
    	jsonData += ']' ;  
    	if(jsonData.length == 2){
	        return ;
        }  
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/pa/wagebase/updatePaAccountInfo", 
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
               		$grid.loadData(true); //加载数据 
               });
           }
           else
           {
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
           }
       }); 
    }  
    function spf_delete()
    {   
    	 var jsonData = '[' ; 
    	 
    	 var rows = $grid.getCheckedRows(); 
    	 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
       $(rows).each(function (index, row)
             {
		     	 if (jsonData.length > 1){
	             	jsonData += ',{' ;
	             }
	             else{
	             	jsonData += '{' ;
	             }  
	             jsonData += ' "INS_NO": "' + this.INS_NO + '" ' ;
	             jsonData += '}' ;  
        }); 
       
    	jsonData += ']' ;  
  	     
    	if(jsonData.length == 2){
	        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        } 
       $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
       $.post("/pa/ins/deleteInsEmpInfo", 
               [	
                	{ name: 'jsonData', value: jsonData }
               ]
       , function (result)
       {
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
	</script>
	
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="10%" class="l-table-edit-t">
							<spring:message code="keyWord" /></td>
						<td width="23%" class="l-table-edit-c">
							<input name="keyWord" type="text" id="keyWord" size="30" /></td>
						<td width="10%" class="l-table-edit-t">
							<spring:message code="hrms.dept" /></td>
						<td width="23%" class="l-table-edit-c">
							<SipingSoft:deptTree name="DEPTID" limit="hr" /></td>
						<td width="10%" class="l-table-edit-t">
							<spring:message code="hrms.wageMark" /></td>
						<td width="23%" class="l-table-edit-c">
							<select id="CALC_FLAG" name="CALC_FLAG" onchange="spf_search();">
								<option value="">
									<spring:message code="hrms.selection" />
								</option>
								<option value="Y">是</option>
								<option value="N">否</option>
							</select>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
			</div>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
