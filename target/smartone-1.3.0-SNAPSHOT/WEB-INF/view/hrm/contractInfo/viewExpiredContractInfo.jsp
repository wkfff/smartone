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
    
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
	<script src="/resources/js/function.js" type="text/javascript"></script>
 
    <script type="text/javascript"> 
    var $grid ;
    var $contractTypeSelectList ;
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
        $contractTypeSelectList = getContractTypeSelectList();
         f_initGrid(); 
    });

    function getContractTypeSelectList(){
    	//请求服务器
    	var contractTypeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getContractTypeSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	contractTypeSelectList = list ; 
            }
        });

        return contractTypeSelectList ;
    } 
    function f_initGrid()
    {
    	$grid = $("#contractInfo").ligerGrid({
    		checkbox: true,
    		columns: [
    		{ display: '', name: 'NEXT_PERIOD', width: 10,hide:1},
            { display: '<spring:message code="hrms.times"/>', name: 'TOTAL_PERIOD', width: 60, type: 'int' },
            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90},
            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120},
            
            { display: '<spring:message code="hrms.hireDate"/>', name: 'JOINDATE', width: 90},
            { display: '<spring:message code="hrms.contractType"/>', name: 'CONTRACT_TYPE_CODE', align: 'center', width: 130,isSort: false,
                editor: { 
                	type: 'select', data: $contractTypeSelectList, dataValueField: 'CONTRACT_TYPE_CODE',dataDisplayField: 'CONTRACT_TYPE_NAME', 
                	displayColumnName: 'CONTRACT_TYPE_NAME', valueColumnName: 'CONTRACT_TYPE_CODE'
                }, render: function (item)
                {
                    for (var i = 0; i < $contractTypeSelectList.length; i++)
                    {
                        if ($contractTypeSelectList[i]['CONTRACT_TYPE_CODE'] == item.CONTRACT_TYPE_CODE)
                            return $contractTypeSelectList[i]['CONTRACT_TYPE_NAME']
                    }
                    return item.CONTRACT_TYPE_NAME;
                }
	        },  
            { display: '<spring:message code="hrms.duration"/>', name: '',render: function (item)
                    {
                        return item.O_STARTDATE+"~"+item.O_ENDDATE;
                    }
            }, 
            { display: '<spring:message code="hrms.startDate"/>', name: 'STARTDATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
            { display: '<spring:message code="hrms.endDate"/>', name: 'ENDDATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
             
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 120,
            	editor: { type: 'textarea', height: 100 }
            }
            ],
            enabledEdit: true,usePager: true, rownumbers: true,
            url: '/hrm/contractInfo/getExpiredContractInfoList',
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){
           	 spf_showDetailData(rowdata.EMPID);
            } 
        });
    }

    function spf_showDetailData(empID)
    { 
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.detail"/>', 
    		width: 800, 
    		height: 400, 
    		url: '/hrm/contractInfo/viewEmpContractInfo?keyWord=' + empID
       	  });
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')},
	                        	{ name: 'totalPeriod', value: $("#totalPeriod").attr('value')},
	                        	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
	                        	{ name: 'CONTRACT_TYPE_CODE', value: $("#CONTRACT_TYPE_CODE").attr('value')}, 
	                        	{ name: 'sDate', value: $("#sDate").attr('value')},
	                        	{ name: 'eDate', value: $("#eDate").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {   
    	var jsonData = '[' ;
    	var rows = $grid.getCheckedRows(); 
    	
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        }
       $(rows).each(function (index, row)
             {
	    	   if(this.__status != null && this.__status == 'update'){
					 
		             if (this.CONTRACT_TYPE_CODE == null || this.CONTRACT_TYPE_CODE == "") { 
		            	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.contractType"/>') ; 
		            		 return ; 
		             }
		             if (this.STARTDATE == null || this.STARTDATE == "") { 
		            	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.startDate"/>') ; 
		            		 return ; 
		             }
		             if (this.ENDDATE == null || this.ENDDATE == "") { 
		            	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.endDate"/>') ; 
		            		 return ; 
		             }
	    		     if (jsonData.length > 1){
		             	jsonData += ',{' ;
		             }
		             else{
		             	jsonData += '{' ;
		             } 
		             jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
		          	 jsonData += ' "CONTRACT_TYPE_CODE": "' + this.CONTRACT_TYPE_CODE+ '", ' ; 
		             jsonData += ' "STARTDATE": "' + MyToDate(this.STARTDATE) + '", ' ;
		             jsonData += ' "ENDDATE": "' + MyToDate(this.ENDDATE) + '", ' ;
		             jsonData += ' "TOTAL_PERIOD": "' + this.NEXT_PERIOD + '", ' ;
		             jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '"' ;
		             jsonData += '}' ;
	        } 
        }); 
    	jsonData += ']' ; 
    	if(jsonData.length == 2){
	        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        }
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/hrm/contractInfo/addContractInfo", 
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
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" > 
     <div position="center" id='' title=' ' >
	 <div position="top">  
	   		<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr>
	               <td width="15%" class="l-table-edit-t">
	               		<spring:message code="keyWord"/></td>
	               <td width="35%" class="l-table-edit-c">
	               		<input name="keyWord" type="text" id="keyWord" size="30"/></td>
	               <td width="15%" class="l-table-edit-t">
	               		<spring:message code="hrms.dept"/></td>
	               <td width="35%" class="l-table-edit-c"> 
	               		<SipingSoft:deptTree name="DEPTID" limit="hr"/></td>
	           </tr>
	             <tr>
	               <td  class="l-table-edit-t">
	               		<spring:message code="hrms.contractType"/></td>
	               <td  class="l-table-edit-c">
	                    <SipingSoft:selectSyCode parentCode="ContractTypeCode" name="CONTRACT_TYPE_CODE" limit="all"/>	 
	               </td> 
	               <td  class="l-table-edit-t">
	               		<spring:message code="hrms.times"/></td>
	               <td  class="l-table-edit-c">
	               		<input name="totalPeriod" type="text" id="totalPeriod" size="30" 
	               		onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" /></td>
	           
	           </tr>
	             <tr> 
	               <td  class="l-table-edit-t">
	               		<spring:message code="hrms.startDate"/></td>
	               <td  class="l-table-edit-c">
				      	 <input type="text" name="sDate" id="sDate" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/>  
	               </td>
	               <td  class="l-table-edit-t">
	               		<spring:message code="hrms.endDate"/></td>
	               <td  class="l-table-edit-c">
				      	 <input type="text" name="eDate" id="eDate" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/> 
	               </td> 
	           </tr>
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left">  
	                    		<SipingSoft:button/> 
					</td>
	           </tr>  
       		</table> 
	  </div> 
      	<div position="center" id='contractInfo'></div>
  </div>
</div>
</body>
</html>
