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
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $salarygrid = null ; 
    var $workAreaSelectList ;
    var $salaryReferenceSelectList ;
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
        $("#actionlayout").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
        $workAreaSelectList = getWorkAreaSelectList();
        $salaryReferenceSelectList = getSalaryReferenceSelectList();
        //alert($salaryReferenceSelectList);
        f_initGrid(); 
    });
 
    function f_initGrid()
    {
    	
    	$salarygrid = $("#directSalesInfo").ligerGrid({
    		//checkbox: true,   	
     		onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
                },
    		columns: [
			            { display: '', name: 'DIRECT_SALES_SALARY_ID', width: 0,hide: 1},
			            { display: '', name: 'PRODUCT_ID', width: 0,hide: 1},
			            { display: '产品名称', name: 'PRODUCT_NAME', width: 140,
				            editor: { type: 'select', ext :function (rowdata)
					                    {
						            		return {
					                            onBeforeOpen : f_selectProduct,
					                            render : function(){
					                            	return rowdata.PRODUCT_NAME;
					                            }
					                        };
					                    }
				            		}
						},
						{ display: '地点', name: 'SALES_AREA_CODE', width: 100,
	                        editor: { 
	                        	type: 'select', data: $workAreaSelectList, dataValueField: 'ID',dataDisplayField: 'NAME',
		  	                  	displayColumnName: 'NAME', valueColumnName: 'ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $workAreaSelectList.length; i++)
	                            {
	                                if ($workAreaSelectList[i]['ID'] == item.SALES_AREA_CODE) { 
	                                    return $workAreaSelectList[i]['NAME'];
	                                	
	                                }
	                            }
	                            return item.SALES_AREA_CODE;
	                        }
						},
						{ display: '参考属性', name: 'REFER', width: 90,
							editor: { 
	                        	type: 'select', data: $salaryReferenceSelectList, dataValueField: 'ID',dataDisplayField: 'NAME',
	                        	displayColumnName: 'NAME', valueColumnName: 'ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $salaryReferenceSelectList.length; i++)
	                            {
	                                if ($salaryReferenceSelectList[i]['ID'] == item.REFER) {
	                                	
	                                    return $salaryReferenceSelectList[i]['NAME'];
	                                	
	                                }
	                            }
	                            return item.REFER;
	                        }
			            },
			            { display: '满足条件最小值', name: 'BOUNDARY', width: 90,editor: { type: 'int' }},
			            { display: '提成基础', name: 'BASIS', width: 90,
							editor: { 
	                        	type: 'select', data: $salaryReferenceSelectList, dataValueField: 'ID',dataDisplayField: 'NAME',
	                        	displayColumnName: 'NAME', valueColumnName: 'ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $salaryReferenceSelectList.length; i++)
	                            {
	                                if ($salaryReferenceSelectList[i]['ID'] == item.BASIS) {
	                                	
	                                    return $salaryReferenceSelectList[i]['NAME'];
	                                	
	                                }
	                            }
	                            return item.BASIS;
	                        }
			            },
			            { display: '提成比例', name: 'PERCENTAGE', width: 90,editor: { type: 'float' }},
			            { display: '开始时间', name: 'BEGIN_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
			            { display: '结束时间', name: 'END_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }}
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/sales/salesSetting/getDirectSalesList',
            parms: [
                   ],
            width: '99.6%', height: '100%'
            });
    }
    
    function f_selectProduct() { 
        $.ligerDialog.open({ title: '选择产品', width: 700, height: 400, 
        	url: '/utility/proInfo/viewBasicProductList',
        	buttons: [
            { text: '确定', onclick: f_selectProductOK },
            { text: '取消', onclick: f_selectProductCancel }
        	]
        });
        return false;
    }
    
    function f_selectProductOK(item, dialog)
    {
        var data = dialog.frame.spf_selectProduct();
        if (!data)
        {
            alert('请选择行!');
            return;
        }
        dialog.close();
        $salarygrid.updateCell('PRODUCT_ID', data.PRODUCT_ID,$salarygrid.getSelectedRow());
        $salarygrid.endEdit();
        $salarygrid.updateCell('PRODUCT_NAME', data.PRODUCT_NAME,$salarygrid.getSelectedRow());
        $salarygrid.endEdit();
    }
    function f_selectProductCancel(item, dialog)
    {
        dialog.close();
    }
    
    function spf_add(){
    	var rows = $salarygrid.getData();
    	if (!rows || rows.length == 0) { 
			$salarygrid.addRow({
				//EMP_NAME:$("#ADMIN_NAME").val(),
				//SALES_AREA_CODE:$("#ADMIN_ID").val()
			});
		}else{
			$(rows).each(function (index){
				var row = $salarygrid.getRow(0);
				if(index == 0){  
					$salarygrid.addRow({
						//BOUNDARY:  this.BOUNDARY,
						//EMP_NAME:$("#ADMIN_NAME").val(),
						//SALES_AREA_CODE:$("#ADMIN_ID").val()
					},row,true); 
				}
			});
		}
	}
    function spf_search()
    {
    	$salarygrid.setOptions({ parms: [
									{ name: 'PRODUCT_ID', value: $("#PRODUCT_ID").attr('value')},
									{ name: 'SALES_AREA_CODE', value: $("#SALES_AREA_CODE").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $salarygrid.loadData(true); //加载数据
    }
	
    function spf_selectPro()
    {
        $.ligerDialog.open({ 
        	title: '产品', 
        	name:'proselector',
        	width: 800, 
        	height: 400, 
        	url: '/utility/proInfo/viewBasicProductList', 
        	buttons: [
             { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
             { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
             { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
        	]
        });
        return false;
    }
    function spf_selectOK(item, dialog)
    {
		var fn = dialog.frame.spf_selectProduct || dialog.frame.window.spf_selectProduct; 
        var data = fn(); 
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return;
        	dialog.close();
        }
        $("#PRODUCT_ID").val(data.PRODUCT_ID);
        dialog.close();
    }
    function spf_selectCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectClear()
    {
    	$("#PRODUCT_ID").val('');
    	dialog.close();
    }
	function spf_delete()
	{
    	var	row = $salarygrid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
    	$.ligerDialog.confirm('您确定要删除该条提成方式','<spring:message code="hrms.warning"/>', function (yes)
    	   	    {
    				if(yes)
    					{
	    					$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	    			        $.post("/sales/salesSetting/removeDirectSales", 
	    			                [	
	    			                   { name: 'DIRECT_SALES_SALARY_ID', value: row.DIRECT_SALES_SALARY_ID}
	    			                 ]
	    			        , function (result)
	    			        {
	    			        	$.ligerDialog.closeWaitting();
	    			            if (result == "Y")
	    			            {
	    			                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	    			                {
	    			                	$salarygrid.loadData(true);
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
    	 var jsonData = '[' ; 
    	 var flag = 0;
    	 var rows = $salarygrid.getData(); 
    	 
    	 //alert(JSON2.stringify(rows));
       $(rows).each(function (index, row)
             {
	    	   if(this.__status != null && (this.__status == 'add'||this.__status == 'update')){
	    		   if(this.PRODUCT_ID == null || this.PRODUCT_ID == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '产品名称'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
	    		   if(this.SALES_AREA_CODE == null || this.SALES_AREA_CODE == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '地点'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
	    		   if(this.REFER == null || this.REFER == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '参考属性'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   } 
	    		   if(this.BOUNDARY == null || this.BOUNDARY == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '最小值'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   } 
	    		   if(this.BASIS == null || this.BASIS == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '提成基础'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
	    		   if(this.PERCENTAGE == null || this.PERCENTAGE == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '提成比例'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
	    		   if(this.BEGIN_DATE == null || this.BEGIN_DATE == 'undefined'){ 
	    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '开始时间'+". " + '<spring:message code="input.required"/>') ; 
	    		       	 flag =1;
	    		       	 return ; 
	    		   }
					if (jsonData.length > 1){
						jsonData += ',{' ;
					}
					else{
						jsonData += '{' ;
					}
					jsonData += ' "__status": "' + this.__status + '", ' ;
					jsonData += ' "PRODUCT_ID": "' + this.PRODUCT_ID + '", '
					jsonData += ' "DIRECT_SALES_SALARY_ID": "' + this.DIRECT_SALES_SALARY_ID + '", ' ;
					jsonData += ' "SALES_AREA_CODE": "' + this.SALES_AREA_CODE + '", ' ;
					jsonData += ' "REFER": "' + this.REFER + '", ' ;
					jsonData += ' "BOUNDARY": "' + this.BOUNDARY + '", ' ;
					jsonData += ' "BEGIN_DATE": "' + MyToDate(this.BEGIN_DATE) + '", ' ;
					jsonData += ' "END_DATE": "' + MyToDate(this.END_DATE) + '", ' ;
					jsonData += ' "BASIS": "' + this.BASIS + '", ' ; 
					jsonData += ' "PERCENTAGE": "' + this.PERCENTAGE + '" ' ;
					jsonData += '}' ; 
	    	}
					
        });
		jsonData += ']' ;
    	 if(flag==1)
			return;
	       $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
	       $.post("/sales/salesSetting/transferDirectSales", 
	               [	
	                	{ name: 'jsonData', value: jsonData }
	               ]
	       , function (result)
	       {
	       	$.ligerDialog.closeWaitting();
	           if (result == "Y")
	           {
	               $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	               {
	                    $salarygrid.loadData(true); //加载数据  
	               });
	           }
	           else
	           {
	               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
	               $salarygrid.loadData(true); //加载数据  
	           }
	       });
    }
       
    function getWorkAreaSelectList(){
       	//请求服务器  
       	var workAreaSelectList;
           $.ajax({
               type: 'post',
               url: '/utility/otherInfo/getWorkAreaList', 
               dataType: 'json',
               async: false,
               success: function (list)
               {  
            	   workAreaSelectList = list ;
               }
           });
           //alert(workAreaSelectList);
           return workAreaSelectList;
       }
     function getSalaryReferenceSelectList(){

      	//请求服务器 
      	var salaryReferenceSelectList ;
          $.ajax({
              type: 'post',
              url: '/utility/otherInfo/getSalaryReferenceList', 
              dataType: 'json',
              async: false,
              success: function (list)
              {  
            	  salaryReferenceSelectList = list ; 
              }
          });
          //alert(salaryReferenceSelectList);
          return salaryReferenceSelectList;
      }
	</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#actionlayout {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="actionlayout">
		<div position="center" id='' title=' '>
			<div position="top">
			<input type="hidden" name = "ADMIN_ID" id = "ADMIN_ID" value = "${admin.adminID}">
			<input type="hidden" name = "ADMIN_NAME" id = "ADMIN_NAME" value = "${admin.chineseName}">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t">产品名称</td>
						<td width="35%" class="l-table-edit-c"><input name="PRODUCT_ID"
							type="text" id="PRODUCT_ID" size="30" onclick = "spf_selectPro()"/></td>
						<td width="15%" class="l-table-edit-t">地点</td>
						<td width="35%" class="l-table-edit-c">
							<SipingSoft:selectSyCode parentCode="WorkAreaCode" name="SALES_AREA_CODE" onChange="spf_search();" limit="all"/>
						</td>
					</tr>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='directSalesInfo'></div>
		</div>
	</div>
</body>
</html>
