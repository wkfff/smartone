<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!BOMTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $grid = null ; 
    var $returnTypeSelectList ;
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
    	$accountgrid = $("#accountInfo").ligerGrid({
    		columns: [
						{ display: '账户编号', name: 'ACCOUNT_NO', width: 60},
						{ display: '账户名称', name: 'ACCOUNT_NAME', width: 90,
							editor: { type: 'text', height: 100 }	
						},
						{ display: '描述', name: 'DESCRIPTION', width: 90,
							editor: { type: 'text', height: 100 }	
						},
						{ display: '状态', name: 'STATUS_ID', width: 90},
						{ display: '现有款', name: 'MONEY_AMOUNT', width: 120,
							editor: { type: 'int', height: 100 }
						},
						{ display: '创建日期', name: 'CREATE_DATE', width: 120}	
		            ],
            enabledEdit: true, rownumbers:true,resizable:false,
            fixedCellHeight:true,
            url: '/fico/account/getAccountList',
            usePager:false,
            parms: [
                   ],
            width: '99.6%', height: '100%'
        });
    }

    function spf_add()
    {
    	var rows = $accountgrid.getData();
    	
    	if (!rows || rows.length == 0) { 
			$accountgrid.addRow({
				//ACCOUNT_NO: $positionData.ACCOUNT_NO 
			});
		}else{
			$(rows).each(function (index){
				var row = $accountgrid.getRow(0);
				if(index == 0){  
					$accountgrid.addRow({
						//ACCOUNT_NO: $positionData.ACCOUNT_NO
					},row,true); 
				}
			});
		}
    }
    
    function spf_save()
    {
    	 $accountgrid.endEdit();
    	 var rows = $accountgrid.getData(); 
    	 var resultJSON = null;
    	 resultJSON = getAccountJSON(rows);
		 if (resultJSON == '[]'){
		 	 return ;
		 }
    	 if(resultJSON == undefined || resultJSON == null){
    		 return ;
    	 }
	     $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
	     $.post("/fico/account/transferAccounts",
	         [	     
	          	{ name: 'jsonData', value: resultJSON }
	         ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result.RESULT == "Y")
	           {
	               $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	               {
	                    $accountgrid.loadData(true); //加载数据  
	               });
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.REASON);
	               $accountgrid.loadData(true);  //加载数据   
	           }
	       });
      }
      
      function getAccountJSON(rows){
         var jsonData = '[';
    	  $(rows).each(function (index, row)
             {
	    	   if(this.__status != null && (this.__status == 'add'||this.__status == 'update')){
	    		   if(this.ACCOUNT_NO == null || this.ACCOUNT_NO == undefined){ 
	    			   this.ACCOUNT_NO = '';
	    		   }
	    		   if( isNaN(this.MONEY_AMOUNT) ){ 
	    			   $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '现款额'+". " + '数字类型') ; 
	    		       	 return null
	    		   }
	    		   if(this.ACCOUNT_NAME == null || this.ACCOUNT_NAME == undefined){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '账户名'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 return null; 
	    		   } 
	    		   if(this.STATUS_ID == null || this.STATUS_ID == undefined){ 
	    		       	 this.STATUS_ID = ''; 
	    		   } 
					if (jsonData.length > 1){
						jsonData += ',{' ;
					}
					else{
						jsonData += '{' ;
					}
					jsonData += ' "__status": "' + this.__status + '", ' ;
					jsonData += ' "ACCOUNT_NO": "' + this.ACCOUNT_NO + '", ' ;
					jsonData += ' "ACCOUNT_NAME": "' + this.ACCOUNT_NAME + '", ' ;
					jsonData += ' "DESCRIPTION": "' + this.DESCRIPTION + '", ' ;
					jsonData += ' "STATUS_ID": "' + this.STATUS_ID + '", ' ;
					jsonData += ' "MONEY_AMOUNT": "' + this.MONEY_AMOUNT + '" ' ;
					jsonData += '}' ; 
			}
        });
     	jsonData += ']' ;
        return jsonData;
      }
    
    function spf_delete()
    {   
    	var	row = $grid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
	    $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '暂不支持删除') ; 
    }
    
    
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
									{ name: 'keyWord', value: $("#keyWord").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }    
	function spf_afterRemove(){
		$dialog.close();
		$grid.loadData(true); //加载数据
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
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c" colspan="3"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
						
					</tr>

				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> 
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='accountInfo'></div>
		</div>
	</div>
</body>
</html>
