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
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script src="/resources/js/function.js" type="text/javascript"></script>
<%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript"> 
    var $grid = null ; 
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
         spf_initGrid();
         //spf_getProductionOrderInfo();
    });
 	
  //取生产订单数据 
	function spf_getProductionOrderInfo(){
		 //&callback=?"注意这个是为了解决跨域访问的问题    
		$.post('/utility/otherInfo/getProductionOrderInfo',{},
			function(result){
				spf_setProductionOrderInfo(result); 
			}
		);
	}
	//设置生产订单下拉列表
	function spf_setProductionOrderInfo(result){ 
		clearSel(document.getElementById("PROD_NO")); //清空城市
		var PROD_NO = document.getElementById("PROD_NO"); 
		var jsonList = eval("(" + result + ")");
		var option = new Option('<spring:message code="hrms.selection"/>',"");
		PROD_NO.options.add(option); 
		for(var i=0;i<jsonList.length;i++){ 
			var value = "0";var text = "0";  
			for(var key in jsonList[i]){  
					if(key == "ID") 
						value = jsonList[i][key];  
					if(key == "Name") 
					text = jsonList[i][key];  
			}  
			option = new Option(text,value);
			PROD_NO.options.add(option); 
		}
	}
	// 清空下拉列表
	function clearSel(oSelect){ 
		while(oSelect.childNodes.length>0){
		 	oSelect.removeChild(oSelect.childNodes[0]);
		} 
	}
    
    function spf_initGrid(){
		$grid = $("#empInfo").ligerGrid({
			checkbox: true,
			columns: [
			            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 120,
			            	totalSummary:
			              {
			                  type: 'count'
			              },frozen:true
			            },  
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 120,frozen:true},
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120,frozen:true},  
			            { display: '<spring:message code="hrms.date"/>', name: 'START_DATE', width: 120,frozen:true}, 
			            { display: '<spring:message code="hrms.attItemName"/>', name: 'PRO_NAME', width: 120}, 
			            { display: '物料编码', name: 'PROD_ID', width: 120},
			            { display: '图纸号', name: 'DRAWING_NO', width: 120},
			            { display: '工序', name: 'PROJ_PROS_TYPE_NAME', width: 100},
			            { display: '工单金额', name: 'QUANTITY',align: 'right', width: 90,totalSummary:{type: 'sum'}},
			            { display: '<spring:message code="hrms.workingDescription"/>', name: 'WORK_CONTENT', align: 'left', width: 160,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', width: 160},   
			            { display: '', name: 'WH_NO', width: 10,hide:1} 
			        ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/ess/viewApp/getWhInfo',
            parms: [],
            width: '99.6%', height: '100%'
        });
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
               { name: 'DEPTID', value: $("#DEPTID").attr('value')},
               { name: 'S_DATE', value: $("#S_DATE").attr('value')},
               { name: 'E_DATE', value: $("#E_DATE").attr('value')}, 
               { name: 'keyWord', value: $("#keyWord").attr('value')}
        	],
    		newPage: 1
    		}); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_delete()
    {
        var jsonData = '[' ;
        var rows = $grid.getCheckedRows(); 
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        } 
       $(rows).each(function (index, row){ 
           if (jsonData.length > 1){
             	jsonData += ',{' ;
            }
            else{
            	jsonData += '{' ;
            } 
            jsonData += ' "PROJ_PROS_TYPE_CODE": "' + this.PROJ_PROS_TYPE_CODE + '", ' ; 
            jsonData += ' "WH_NO": "' + this.WH_NO + '", ' ; 
            jsonData += ' "CANCEL_REMARK": "' + MyCheckNull(this.CANCEL_REMARK) + '"' ; 
            jsonData += '}' ;
        }); 
    	jsonData += ']' ;
     	var jsonList = eval("(" + jsonData + ")");
    	if(jsonData.length == 0){ 
            return ;
        }
    	if(jsonList.length == rows.length){ 
            $.ligerDialog.waitting('<spring:message code="hrms.canceling"/>');
            $.post("/ess/viewApp/cancelWhApp", 
                    [	
                     	{ name: 'jsonData', value: jsonData },
                     	{ name: 'appType', value: 'whInfo' }
                    ]
            , function (result)
            {
            	$.ligerDialog.closeWaitting();
                if (result == "Y")
                {
                    $.ligerDialog.success('<spring:message code="hrms.cancelSuccess"/>','<spring:message code="hrms.warning"/>', function ()
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
    }
    function spf_whExcel() {
    	var s_date = $("#S_DATE").attr('value');
    	var e_date = $("#E_DATE").attr('value');
        if (s_date == '' || e_date == '') {
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请在选择起止日期');
            return ;
        }
        var jsonDataList = 'EMPID,CHINESENAME,PRO_NAME,PROD_ID,PROJ_PROS_TYPE_NAME,START_DATE,WORK_CONTENT,QUANTITY,REMARK';
        location.href = '/report/pa/salary/viewPaWhDetailReport?DEPTID=' + $("#DEPTID").attr('value') +'&keyWord='+$("#keyWord").attr('value')+'&S_DATE='+s_date+'&E_DATE='+e_date+'&jsonDataList='+jsonDataList;
        $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.dataExporting"/>');
    }
	</script>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99.6%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
                        <td width="15%" class="l-table-edit-t">
                            <spring:message code="keyWord"/></td>
                        <td width="35%" class="l-table-edit-c">
                            <input name="keyWord" type="text" id="keyWord" size="30"/></td>
						<td width="15%" class="l-table-edit-t"><spring:message code="hrms.dept" /></td>
						<td width="35%" class="l-table-edit-c"><SipingSoft:deptTree
								name="DEPTID" limit="hr" /></td>
					</tr>
					<tr>
						<td class="l-table-edit-t"><spring:message code="hrms.applicationDate" /></td>
						<td class="l-table-edit-c" colspan="3"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
					<td align="left">
                        <a class="l-button" style="width: 79px; height: 20px; float: right; margin-left: 10px; "
                            onclick="spf_whExcel()"><spring:message code="hrms.excelExport" /></a>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
			</div>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
