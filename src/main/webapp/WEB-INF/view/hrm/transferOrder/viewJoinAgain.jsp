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
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerTextBox.js" type="text/javascript"></script>  
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	<script src="/resources/js/function.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript"> 
    var $grid = null ; 
    var $statusSelectList ;
    var $postSelectList ; 
    var $deptSelectList ; 
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
        $postSelectList = getPostSelectList() ; 
        $statusSelectList = getStatusSelectList() ;  
        $deptSelectList = getDeptSelectList() ; 
         f_initGrid(); 
    });

    function getPostSelectList(){
    	//请求服务器
    	var postSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPostSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	postSelectList = list ;
            }
        });
        return postSelectList ;
    }
    
    function getStatusSelectList(){
    	//请求服务器
    	var statusSelectList ;
        $.ajax({
            type: 'post',
            url: "/utility/otherInfo/getStatusSelectList?OFF_PROBATION=YES", 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	statusSelectList = list ;
            }
        });
        return statusSelectList ;
    }
    
    function getDeptSelectList(){
    	//请求服务器
    	var deptSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/deptInfo/getDeptSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	deptSelectList = list ;
            }
        });

        return deptSelectList ;
    }
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
     		onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
                },
    		checkbox: false,
    		columns: [  
            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90 ,frozen:true},
            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90 ,frozen:true}, 
            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 120 ,frozen:true},  
            { display: '<spring:message code="hrms.post"/>', name: 'POST_NAME', width: 120 ,frozen:true},  
            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME', width: 90 ,frozen:true},  
            { display: '<spring:message code="hrms.leftDate"/>', name: 'LEFT_DATE', width: 120,frozen:true}, 
	        { display: '<spring:message code="hrms.post"/>', name: 'POST_ID', align: 'center',isSort: false,
                editor: { 
                	type: 'select', data: $postSelectList, dataValueField: 'POST_ID',width: 130,dataDisplayField: 'POST_NAME', 
                	displayColumnName: 'POST_NAME', valueColumnName: 'POST_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $postSelectList.length; i++)
                    {
                        if ($postSelectList[i]['POST_ID'] == item.POST_ID)
                            return $postSelectList[i]['POST_NAME']
                    }
                    return item.POST_NAME;
                }
	        },
	        { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_CODE', align: 'center',width: 130,isSort: false,
                editor: { 
                	type: 'select', data: $statusSelectList, dataValueField: 'STATUS_CODE',dataDisplayField: 'STATUS_NAME', 
                	displayColumnName: 'STATUS_NAME', valueColumnName: 'STATUS_CODE'
                }, render: function (item)
                {
                    for (var i = 0; i < $statusSelectList.length; i++)
                    {
                        if ($statusSelectList[i]['STATUS_CODE'] == item.STATUS_CODE)
                            return $statusSelectList[i]['STATUS_NAME']
                    }
                    return item.STATUS_NAME;
                }
	        }, 
            { display: '<spring:message code="hrms.joinDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }},
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
            	editor: { type: 'textarea', height: 100 }
            }
            ],
            enabledEdit: true,usePager: true,rownumbers: true,  
            url: '/hrm/transferOrder/getEmpInfoList',
            parms: [	
                   	{ name: 'joinAgain', value: 'joinAgain'}
                   ],
            width: '99.6%', height: '100%' 
        });
    }
 
    function f_selectDepartment() { 
    	$.ligerDialog.open(
            	{ isDrag: true, showMax:true,showMin:true,
            	  title: '<spring:message code="hrms.dept.information"/>', 
            	  width: 800, 
            	  height: 400, 
            	  url: '/utility/deptInfo/selectDepartment', 
            	  buttons: [
    	                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK_DEPT },
    	                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel_DEPT }
            	  ]
            }); 
        return false;
    }
    function spf_selectOK_DEPT(item, dialog)
    {
		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
        var data = fn(); 
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       	    return ; 
        }  
        $grid.updateCell('DEPTID', data.DEPTID,$grid.getSelectedRow());
        $grid.endEdit();
        dialog.close();
    }
    function spf_selectCancel_DEPT(item, dialog)
    {
        dialog.close();
    }
    
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
	                        	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
	                           	{ name: 'joinAgain', value: 'joinAgain'},
	                        	{ name: 'S_LEFT_DATE', value: $("#S_LEFT_DATE").attr('value')},
	                        	{ name: 'E_LEFT_DATE', value: $("#E_LEFT_DATE").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {   
    	var jsonData = '[' ;
    	var rows = $grid.getData(); 
    	
       $(rows).each(function (index, row)
             {
	    	   if(this.__status != null && this.__status == 'update' ){

	    		     if (jsonData.length > 1){
		             	jsonData += ',{' ;
		             }
		             else{
		             	jsonData += '{' ;
		             } 
			             jsonData += ' "EMPID": "' + this.EMPID + '", ' ;
			          	 jsonData += ' "DEPTID": "' + this.DEPTID+ '", ' ;
			             jsonData += ' "START_DATE": "' + this.START_DATE + '", ' ; 
			             jsonData += ' "STATUS_CODE": "' + this.STATUS_CODE + '", ' ; 
			             jsonData += ' "TRANS_CODE": "'+'${TRANS_CODE}'+'", ' ;
			             jsonData += ' "TRANS_NO": "' + '${TRANS_NO}' + '", ' ;
			             jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '",' ;
			             jsonData += ' "TYPE": "joinAgain"' ;
			             jsonData += '}' ;
	        } 
        });
       
    	jsonData += ']' ;
    	 
    	if(jsonData.length == 0){
	        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        }
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/hrm/transferOrder/saveTransferOrder", 
               [	
                	{ name: 'jsonData', value: jsonData },
                	{ name: 'type', value: 'joinAgain' }
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
	   		<table width="99.%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
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
	               		<spring:message code="hrms.leftDate"/></td>
	               <td  class="l-table-edit-c" colspan="3">
				      	 <input type="text" name="S_LEFT_DATE" id="S_LEFT_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/>  
						   ~             	 
				      	 <input type="text" name="E_LEFT_DATE" id="E_LEFT_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/> 
	               </td>
	           </tr>
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
	           <tr>
	                <td align="left">  
	                    <SipingSoft:button/>      
					</td>
	           </tr>  
       		</table> 
	  </div> 
      	<div position="center" id='empInfo'></div>
  </div>
</div>
</body>
</html>
