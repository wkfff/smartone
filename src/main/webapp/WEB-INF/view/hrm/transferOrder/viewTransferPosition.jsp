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
    var $postGradeSelectList ; 
    var $postSelectList ;   
    var $positionSelectList ;  
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
        $postGradeSelectList = getPostGradeSelectList() ; 
        $postSelectList = getPostSelectList() ;  
        $positionSelectList = getPositionSelectList() ;  
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
    
    function getPostGradeSelectList(){
    	//请求服务器
    	var postGradeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPostGradeSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	postGradeSelectList = list ;
            }
        });

        return postGradeSelectList ;
    }
    function getPositionSelectList(){
    	//请求服务器
    	var positionSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPositionSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	positionSelectList = list ;
            }
        });

        return positionSelectList ;
    }
      
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: false,
    		columns: [  
            { display: '<spring:message code="hrms.empid"/>', name: 'EMPID', width: 90},
            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME', width: 90}, 
            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', width: 200}, 
            { display: '<spring:message code="hrms.joinDate"/>', name: 'JOIN_DATE', width: 90}, 
              
	        { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_ID', align: 'center',isSort: false,
                editor: { 
                	type: 'select', data: $postGradeSelectList, dataValueField: 'POST_GRADE_ID',dataDisplayField: 'POST_GRADE_NAME', 
                	displayColumnName: 'POST_GRADE_NAME', valueColumnName: 'POST_GRADE_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $postGradeSelectList.length; i++)
                    {
                        if ($postGradeSelectList[i]['POST_GRADE_ID'] == item.POST_GRADE_ID)
                            return $postGradeSelectList[i]['POST_GRADE_NAME']
                    }
                    return item.POST_GRADE_NAME;
                }
	        },   
	        { display: '<spring:message code="hrms.post"/>', name: 'POST_ID', align: 'center',isSort: false,
                editor: { 
                	type: 'select', data: $postSelectList, dataValueField: 'POST_ID',dataDisplayField: 'POST_NAME', 
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
	        { display: '<spring:message code="hrms.position"/>', name: 'POSITION_ID', align: 'center',isSort: false,
                editor: { 
                	type: 'select', data: $positionSelectList, dataValueField: 'POSITION_ID',dataDisplayField: 'POSITION_NAME', 
                	displayColumnName: 'POSITION_NAME', valueColumnName: 'POSITION_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $positionSelectList.length; i++)
                    {
                        if ($positionSelectList[i]['POSITION_ID'] == item.POSITION_ID)
                            return $positionSelectList[i]['POSITION_NAME']
                    }
                    return item.POSITION_NAME;
                }
	        },   
	        { display: '<spring:message code="hrms.effectDate"/>', name: 'START_DATE', width: 120, type: 'date', format: 'yyyy-MM-dd', editor: { type: 'date' }}, 
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 160,
            	editor: { type: 'textarea', height: 100 }
            }
            ],
            enabledEdit: true,usePager: true, rownumbers: true, 
            url: '/hrm/transferOrder/getEmpInfoList',
            width: '99.6%', height: '100%' 
        });
    }
  
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
	                        	{ name: 'DEPTID', value: $("#DEPTID").attr('value')},
	                        	{ name: 'S_JOIN_DATE', value: $("#S_JOIN_DATE").attr('value')},
	                        	{ name: 'E_JOIN_DATE', value: $("#E_JOIN_DATE").attr('value')},
	                        	{ name: 'EMP_LIST', value: $("#EMP_LIST").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {   
    	var jsonData = '[' ;
    	var rows = $grid.getData(); 
    	
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
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
		             jsonData += ' "EMPID": "' + this.EMPID + '", ' ; 
		             jsonData += ' "POSITION_ID": "' + this.POSITION_ID + '", ' ; 
		             jsonData += ' "POST_GRADE_ID": "' + this.POST_GRADE_ID + '", ' ;
		             jsonData += ' "POST_ID": "' + this.POST_ID + '", ' ;
		             jsonData += ' "START_DATE": "' + MyToDate(this.START_DATE) + '", ' ;
		             jsonData += ' "TRANS_CODE": "TransCode_220", ' ;
		             jsonData += ' "TRANS_NO": "' + ${TRANS_NO} + '", ' ;
		             jsonData += ' "REMARK": "' + MyCheckNull(this.REMARK) + '",' ;
		             jsonData += ' "TYPE": "position"' ;
		             jsonData += '}' ;
	        } 
        }); 
       
    	jsonData += ']' ;
    	 
    	if(jsonData.length == 2){
	        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.editData"/>') ;
            return ;
        }
       $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
       $.post("/hrm/transferOrder/saveTransferOrder", 
               [	
                	{ name: 'jsonData', value: jsonData },
                	{ name: 'type', value: 'position' }
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
	               		<spring:message code="hrms.joinDate"/></td>
	               <td  class="l-table-edit-c">
				      	 <input type="text" name="S_JOIN_DATE" id="S_JOIN_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/>  
						   ~             	 
				      	 <input type="text" name="E_JOIN_DATE" id="E_JOIN_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/> 
	               </td>
	               <td  class="l-table-edit-t">
	               		<spring:message code="hrms.batchSearch"/></td>
	               <td  class="l-table-edit-c">
	                    <textarea rows="" cols="47" id="EMP_LIST" name="EMP_LIST" ></textarea>
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
