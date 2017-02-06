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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
	<script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
<script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    var $activitySelectList ; 
    var $companySelectList ;   
    var $postSelectList ;     
    var $leaveTypeSelectList ; 
    var $deptSelectList ;    
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({  
        	     topHeight:60,
		         allowLeftResize: false,      //是否允许 左边可以调整大小
		         allowRightResize: false,     //是否允许 右边可以调整大小
		         allowTopResize: false,      //是否允许 头部可以调整大小
		         allowBottomResize: false     //是否允许 底部可以调整大小
          }
         );
         
         $activitySelectList = getActivitySelectList() ;
         $companySelectList = getCompanySelectList() ;  
         $postSelectList = getPostSelectList() ;   
         $leaveTypeSelectList = getLeaveTypeSelectList() ;  
         $deptSelectList = getDeptSelectList() ;  
         spf_initGrid();

    });
 
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
 
    function getLeaveTypeSelectList(){
    	//请求服务器
    	var leaveTypeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getLeaveTypeSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	leaveTypeSelectList = list ;
            }
        });   
        return leaveTypeSelectList ;
    }
 
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
 
    function getActivitySelectList(){
    	//请求服务器
    	var activitySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getActivitySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		activitySelectList = list ;
            }
        });   
        return activitySelectList ;
    }
    
    function getCompanySelectList(){
    	//请求服务器
    	var companySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getCompanySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		companySelectList = list ; 
            }
        });

        return companySelectList ;
    } 
      
    function spf_initGrid()
    {
    	$grid = $("#leaveParameterInfo").ligerGrid({
    	 checkbox: false,   
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'PARAMETER_NO', width: 80},
            { display: '<spring:message code="hrms.leaveType"/>', name: 'LEAVE_TYPE_CODE', width: 130,
                editor: { 
                	type: 'select', data: $leaveTypeSelectList, dataValueField: 'LEAVE_TYPE_CODE',dataDisplayField: 'LEAVE_TYPE_NAME', 
                	displayColumnName: 'LEAVE_TYPE_NAME', valueColumnName: 'LEAVE_TYPE_CODE'
                }, render: function (item)
                {
                    for (var i = 0; i < $leaveTypeSelectList.length; i++)
                    {
                        if ($leaveTypeSelectList[i]['LEAVE_TYPE_CODE'] == item.LEAVE_TYPE_CODE)
                            return $leaveTypeSelectList[i]['LEAVE_TYPE_NAME']
                    }
                    return item.LEAVE_TYPE_NAME;
                }
	        },
	        { display: '<spring:message code="hrms.leaveLength"/>', columns:
                [
                 { display: '<spring:message code="hrms.startedHours"/>', name: 'LEAVE_LENGTH_S',width: 120,type: 'int', editor: { type: 'int' }},
                 { display: '<spring:message code="hrms.endHours"/>', name: 'LEAVE_LENGTH_E',width: 120,type: 'int',editor: { type: 'int' }}
                ]
            }, 
            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTID', width: 180, isSort: false,
                editor: { type: 'select',
		                   ext:
		                function (rowdata)
		                {
		                    return {
		                        onBeforeOpen: spf_selectDepartmentBeforeOpen,
		                        render: function ()
		                        { 
		                            for (var i = 0; i < $deptSelectList.length; i++)
		                            {
		                                if ($deptSelectList[i]['DEPTID'] == rowdata.DEPTID)
		                                    return $deptSelectList[i]['DEPTNAME'];
		                            } 
		                        }
		                    };
		                }
                },render: function (item)
                {
                    for (var j = 0; j < $deptSelectList.length; j++)
                    {
                        if ($deptSelectList[j]['DEPTID'] == item.DEPTID)
                            return $deptSelectList[j]['DEPTNAME']
                    }
                    return item.DEPTNAME;
                }
            },
        	{ display: '<spring:message code="hrms.post"/>', name: 'POST_ID', width: 130,
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
            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARKS',width: 120,align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.approvalLevel"/>', name: 'AFFIRM_LEVEL',width: 100,type: 'int', editor: { type: 'int' }},  
        	{ display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', width: 100,
                editor: { 
                	type: 'select', data: $activitySelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
                	displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $activitySelectList.length; i++)
                    {
                        if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID)
                            return $activitySelectList[i]['STATUS']
                    }
                    return item.STATUS;
                }
	        },  
	        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_ID', width: 100,
                editor: { 
                	type: 'select', data: $companySelectList, dataValueField: 'CPNY_ID',dataDisplayField: 'CPNY_NAME',
                	displayColumnName: 'CPNY_NAME', valueColumnName: 'CPNY_ID'
                }, render: function (item)
                {
                    for (var i = 0; i < $companySelectList.length; i++)
                    {
                        if ($companySelectList[i]['CPNY_ID'] == item.CPNY_ID)
                            return $companySelectList[i]['CPNY_NAME']
                    }
                    return item.CPNY_NAME;
                }
	        }
            ],
            enabledEdit: true,usePager: true, rownumbers: true,dataAction: 'server', root: 'leaveAppParameterInfoList', record: 'leaveAppParameterInfoCnt',
            url: '/system/systemParameter/getLeaveAppParameterInfo',
            width: '99.6%', height: '100%',
        });
    }
     
    function spf_save()
    {  
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/systemParameter/saveAndUpdateLeaveAppParameterInfo", 
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
                	$grid.loadData(true); 
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
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
		     	 var rows = $grid.getSelectedRow(); 
		         
		         if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
		         if (rows.length > 1){
		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		         }
  
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/systemParameter/deleteLeaveAppParameterInfo", 
		                [	
		                 	{ name: 'PARAMETER_NO', value: rows.PARAMETER_NO }
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
        }); 
    }
    
    function spf_add()
    {
    	$grid.addRow();
    }

    function spf_search()
    {  
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'keyWord', value: $("#keyWord").val()},  
    	                        	{ name: 'CPNY_ID', value: $("#CPNY_ID").val()},
    	                        	{ name: 'LEAVE_TYPE_CODE', value: $("#LEAVE_TYPE_CODE").val()},   
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()}
    	                           ],
    	                   newPage: 1
    	                 });  //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_selectDepartmentBeforeOpen() { 
        $.ligerDialog.open(
        	{ title: '<spring:message code="hrms.dept.information"/>', 
        	  width: 800, 
        	  height: 400, 
        	  url: '/utility/deptInfo/selectDepartmentBeforeOpen', 
        	  buttons: [
	                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
	                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel }
        	  ]
        });
        return false;
    }
    function spf_selectOK(item, dialog)
    {
		var fn = dialog.frame.spf_selectDeptInfo || dialog.frame.window.spf_selectDeptInfo; 
        var data = fn(); 
        if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       	 return ; 
        }
        $grid.updateCell('DEPTID', data.DEPTID, $grid.getSelected());
        $grid.endEdit();
        dialog.close();
    } 
    function spf_selectCancel(item, dialog)
    {
        dialog.close();
    } 
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" >  
		  <div position="top">
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td align="center" valign="middle"> 
		            		<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">	            
				                <tr>
					               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
					           	   <td class="l-table-edit-c">
						       	   		<input type="text" name="keyWord" id="keyWord" />
						       	   </td>
					               <td class="l-table-edit-t"><spring:message code="hrms.leaveType"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectSyCode parentCode="LeaveTypeCode" name="LEAVE_TYPE_CODE" limit="all"/>
						       	   </td>
					               <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectCompany name="CPNY_ID" limit="all"/>
						       	   </td>
						       	   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
					           	   <td class="l-table-edit-c">
										<SipingSoft:selectStatus name="ACTIVITY" limit="all"/>
						       	   </td>  
					           </tr> 
					       </table>
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
               <div position="center" id="leaveParameterInfo" ></div>
</div>  
</body>
</html>
