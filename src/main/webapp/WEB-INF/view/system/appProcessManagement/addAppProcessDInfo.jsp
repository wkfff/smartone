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
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
<script type="text/javascript">
    var $grid ;
    var $grid1 ;
 	// 初始调用
 	
    $(function() { 
    	//布局
        $("#layout1").ligerLayout({
        		topHeight: 60,
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
    	
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: true,
            columns: [
				{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID'},
				{ display: '<spring:message code="hrms.chineseName"/>', name: 'CHINESENAME', align: 'center'},
				{ display: '<spring:message code="hrms.englishName"/>', name: 'ENGLISHNAME', align: 'center'},
				{ display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME', align: 'center'},  
				{ display: '<spring:message code="hrms.active"/>', name: 'STATUS', align: 'center'}, 
				{ display: '<spring:message code="hrms.active"/>', name: 'CPNY_ID', align: 'center',hide:1},   
				{ display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', align: 'center'}
            ],
            usePager: true, rownumbers: true, dataAction: 'server', root: 'appProcessPList', record: 'appProcessPCnt',
            url: '/system/appProcessManagement/getAppProcessPInfo',
            width: '99%', height: '99%',
            pageSize: 7, pageSizeOptions:[7,15, 20, 30, 40, 50], 
    	    isChecked: f_isChecked, onCheckRow: f_onCheckRow, onCheckAllRow: f_onCheckAllRow
        }); 
    	
    	$grid1 = $("#empInfo1").ligerGrid({
    		checkbox: false,
            columns: [
				{ display: '<spring:message code="hrms.approvalType"/>', name: 'AFFIRM_TYPE_NAME'},
				{ display: '<spring:message code="hrms.approvalType"/>', name: 'AFFIRM_TYPE_ID',hide:1},
				{ display: '<spring:message code="hrms.1level"/>', name: 'NAME1', align: 'center'},
				{ display: '<spring:message code="hrms.2level"/>', name: 'NAME2', align: 'center'},
				{ display: '<spring:message code="hrms.3level"/>', name: 'NAME3', align: 'center'},  
				{ display: '<spring:message code="hrms.4level"/>', name: 'NAME4', align: 'center'}, 
				{ display: '<spring:message code="hrms.5level"/>', name: 'NAME5', align: 'center'},   
				{ display: '<spring:message code="hrms.6level"/>', name: 'NAME6', align: 'center'}
            ],
            usePager: false,rownumbers: true,  dataAction: 'server', root: 'appProcessDAList',
            url: '/system/appProcessManagement/getAppProcessDAInfo?DEPTID='+$("#AFFIRM_OBJECT").val(),
            width: '99%', height: '99%',allowUnSelectRow:true,
            onSelectRow: function (data, rowindex, rowobj)
            { 
                spf_delete($("#AFFIRM_OBJECT").val(),data.AFFIRM_TYPE_ID)
            }
        }); 
    }); 
    /*
     *部门信息弹出框收缩js
    */
    $(function ()
            {  
                $("#DEPTID_NAME").ligerComboBox({
                    onBeforeOpen: spf_selectDepartment, valueFieldID: 'DEPTID',width:150
                });
            });
	        function spf_selectDepartment() { 
	            $.ligerDialog.open(
	            	{ title: '<spring:message code="hrms.dept.information"/>', 
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
	        function spf_selectOK_DEPT(item, dialog)
	        {
	    		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
	            var data = fn(); 
	            if (!data)
	            {
	            	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	           	    return ; 
	            }   
                $("#DEPTID_NAME").val(data.DEPTNAME.replace(/&nbsp;/g,""));
                $("#DEPTID").val(data.DEPTID);
                dialog.close(); 
	        } 
	        function spf_selectCancel_DEPT(item, dialog)
	        {
	            dialog.close();
	        } 
            function spf_selectClear_DEPT(item, dialog)
            {
            	$("#DEPTID_NAME").val("");
            	$("#DEPTID").val("");
                dialog.close();
            }

        /*
         *部门弹出框收缩js
        */	
    /*
           该例子实现 表单分页多选
           即利用onCheckRow将选中的行记忆下来，并利用isChecked将记忆下来的行初始化选中
    */
    function f_onCheckAllRow(checked)
    {
        for (var rowid in this.records)
        {
            if(checked)
                addCheckedEmpID(this.records[rowid]['EMPID']);
            else
                removeCheckedEmpID(this.records[rowid]['EMPID']);
        }
    } 
    var checkedEmpID = [];
    function findCheckedEmpID(EmpID)
    {
        for(var i =0;i<checkedEmpID.length;i++)
        {
            if(checkedEmpID[i] == EmpID) return i;
        }
        return -1;
    }
    function addCheckedEmpID(EmpID)
    {
        if(findCheckedEmpID(EmpID) == -1)
            checkedEmpID.push(EmpID);
    }
    function removeCheckedEmpID(EmpID)
    {
        var i = findCheckedEmpID(EmpID);
        if(i==-1) return;
        checkedEmpID.splice(i,1);
    }
    function f_isChecked(rowdata)
    {
        if (findCheckedEmpID(rowdata.EMPID) == -1)
            return false;
        return true;
    }
    function f_onCheckRow(checked, data)
    {
        if (checked) addCheckedEmpID(data.EMPID);
        else removeCheckedEmpID(data.EMPID);
    } 
    /*
           该例子实现 表单分页多选
           即利用onCheckRow将选中的行记忆下来，并利用isChecked将记忆下来的行初始化选中
    */

    function spf_search()
    {     
    	$grid.setOptions({ parms: [
    	                        	{ name: 'keyWord', value: $("#keyWord").val()},
    	                        	{ name: 'DEPTID', value: $("#DEPTID").val()}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
 	 
    function f_save() {
  	  
        var jsonData = '[' ;
    	var rows = $grid.getCheckedRows();
        if (!rows || rows.length == 0) { 
       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
    	 return ; 
    }
        $(rows).each(function ()
                {
		        	if (jsonData.length > 1){
		             	jsonData += ',{'
		             }
		             else{
		             	jsonData += '{'
		             }
                     jsonData += ' "AFFIRM_OBJECT": "' + $("#AFFIRM_OBJECT").val() + '", ' ;
                        jsonData += ' "AFFIRM_LEVEL": "' + $("#AFFIRM_LEVEL").val() + '", ' ;
                        jsonData += ' "AFFIRM_TYPE_ID": "' + $("#AFFIRM_TYPE_ID").val() + '", ' ;
                        jsonData += ' "CPNY_ID": "' + this.CPNY_ID + '", ' ;
                        jsonData += ' "AFFIRMOR_ID": "' + this.EMPID + '"';
                        jsonData += '}' ;
                     
                }); 
		jsonData += ']' ;
       
		$('#jsonData').attr('value' , jsonData) ;
		 
        var options = {	                        
                url:'/system/appProcessManagement/addAppProcessDInfo',
                type:'POST',	                        
                success: function (result){
          	    $.ligerDialog.closeWaitting();
      		            if (result == "Y")
      		            {
      		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', function ()
      		                { 
      		                    $grid.loadData(true);//加载数据 
      		                    $grid1.loadData(true);//加载数据 
      		                	//parent.f_ChildWindowClose() ;
      		                });
      		            }
      		            else
      		            {
      		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
      		            }
      		        }              
                }; 
                $('#form1').ajaxSubmit(options);
		 
      }
        

    function f_ChildWindowClose (){ 
    	$grid.loadData(true); //加载数据  
        $grid1.loadData(true);//加载数据 
    	$dialog.close() ;
    }
    
    function spf_delete(AFFIRM_OBJECT,AFFIRM_TYPE_ID)
    {  
    	$dialog = $.ligerDialog.open({isDrag: false,  title:'<spring:message code="hrms.delete"/>', 
    		width: $("#layout1").width()-40, height: $("#layout1").height()-40, url: '/system/appProcessManagement/deleteAppProcessDInfo?AFFIRM_OBJECT='+AFFIRM_OBJECT+'&AFFIRM_TYPE_ID='+AFFIRM_TYPE_ID+'&DEPTID='+AFFIRM_OBJECT
       	  });
    }
</script>
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  } 
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" >
     <div style="border:1px solid #A3C0E8;" >
	  <div align="left">
	     <form name="form1" method="post" action="" id="form1"> 
       		<input type="hidden" id="jsonData" name="jsonData" value=""/>
       		<input type="hidden" id="AFFIRM_OBJECT" name="AFFIRM_OBJECT" value="${appProcessDInfo.DEPTID }"/>
	        <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>  
                <td class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.DEPTNAME } 
                </td> 
                <td class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.DEPT_EN_NAME } 
                </td>
                <td class="l-table-edit-t"><spring:message code="hrms.location"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.AREA } 
                </td>
            </tr>
            <tr>
                <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.STATUS } 
                </td>
                <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.CPNY_NAME } 
                </td>
                <td class="l-table-edit-t"><spring:message code="hrms.setApprover"/></td>
                <td class="l-table-edit-c">
                	${appProcessDInfo.SET_APP_NAME } 
                </td>
            </tr>  
           </table>  
	        <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	               <td colspan="10" height="30px"> 
						<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="f_save()" ><spring:message code="hrms.save"/></a>
	               	    <a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()" ><spring:message code="search"/></a>
	                
	               </td>
            </tr> 
	       </table> 
	            
	           <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr>
	                <td width="10%" class="l-table-edit-t" title='<spring:message code="search.condition"/>'><spring:message code="keyWord"/></td>
	                <td width="15%" class="l-table-edit-c" title='<spring:message code="search.condition"/>'>
	                	<input id="keyWord" name="keyWord" />
	                </td>
	                <td width="10%" class="l-table-edit-t" title='<spring:message code="search.condition"/>'><spring:message code="hrms.dept"/></td>
	                <td width="15%" class="l-table-edit-c" title='<spring:message code="search.condition"/>'>
	                	<input type="text" id="DEPTID_NAME" name="DEPTID_NAME" value="" />
		       	   		<input type="hidden" id="DEPTID" name="PARENTDEPTID" value=""/> 
	                </td>  
	                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.level"/></td>
	                <td width="15%" class="l-table-edit-c" >
	                	<SipingSoft:select dataListName="appLevelList" name="AFFIRM_LEVEL"/>
	                </td> 
	                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.approvalType"/></td>
	                <td width="15%" class="l-table-edit-c"> 
	                	<SipingSoft:selectSyCode parentCode="ApplyTypeCode" name="AFFIRM_TYPE_ID"/>
	                </td>
	            </tr> 
            </table>
                
        </form>  
	   </div> 
   		<div id='empInfo1' style="height:170px;"></div>  
   		<div id='empInfo'></div> 
 </div>     	
</div>    
</body>
</html>
