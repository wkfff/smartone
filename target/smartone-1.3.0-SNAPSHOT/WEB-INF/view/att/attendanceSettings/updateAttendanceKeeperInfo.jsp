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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>  
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
        
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
	<script src="/resources/js/json2.js" type="text/javascript"></script>
	
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	 
<script type="text/javascript">
    var $deptTree ;
 	// 初始调用
 	
    $(function() {

    	//布局
        $("#layout1").ligerLayout({
        		topHeight: 200,
	        	allowRightCollapse: false,     //是否允许 右边可以隐藏
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
        
    	$deptTree = $("#deptTree").ligerTree(
    	    	{ 
        	    	data:${dataJson},
        	    	method:'POST',
        	    	idFieldName :'deptID',
                    parentIDFieldName :'parentDeptID',
                    textFieldName:'deptName', 
                    topParentIDValue:'${LoginUser.cpnyId}',
                    nodeWidth:250
            	 }
        );

    });

    function f_save() { 

        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        getChecked() ;
        
        var options = {	                        
            url:'/att/attendanceSettings//updateAttendanceKeeperInfo',
            type:'POST',	                        
            success:function (result){
        			$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', function ()
		                {
		                	parent.f_ChildWindowClose() ;
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

    function collapseAll()
    {
    	$deptTree.collapseAll();
    }
    function expandAll()
    {
    	$deptTree.expandAll();
    }
    function getChecked()
    {
        var notes = $deptTree.getChecked();
        
        var jsonData = '[' ;
        for (var i = 0; i < notes.length; i++)
        {
        	if (jsonData.length > 1){
            	jsonData += ',{'
            }
            else{
            	jsonData += '{'
            }
            jsonData += ' "SUPERVISED_DEPTID": "' + notes[i].data.deptID + '", ' ;
            jsonData += ' "SUPERVISOR_ID": "${attendanceKeeperInfo.SUPERVISOR_ID}"' ;
            jsonData += '}' ;
        }
        jsonData += ']' ;

        $('#jsonData').attr('value' , jsonData) ;
        
    }


</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:0px" > 
<div id="layout1" >
     <div style="border:1px solid #A3C0E8;" >
	  <div align="left">
	     <form name="form1" method="post" action="" id="form1">
	        <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr>  
                <td width="10%"  class="l-table-edit-t"><spring:message code="hrms.empid"/></td>
                <td width="20%" class="l-table-edit-c">${attendanceKeeperInfo.SUPERVISOR_ID}
                	<input type="hidden" id="SUPERVISOR_ID" name="SUPERVISOR_ID"  value="${attendanceKeeperInfo.SUPERVISOR_ID}"/>
                	<input id="jsonData" name="jsonData" type="hidden" value=""/> 
                </td> 
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.chineseName"/></td>
                <td width="20%" class="l-table-edit-c">
                	${attendanceKeeperInfo.CHINESENAME}
                </td> 
                <td width="10%" class="l-table-edit-t"><spring:message code="hrms.englishName"/></td>
                <td width="20%" class="l-table-edit-c">
                	${attendanceKeeperInfo.CHINESENAME}
                </td> 
            </tr>
            <tr>  
                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
                <td class="l-table-edit-c">
                	${attendanceKeeperInfo.DEPTNAME}
                </td> 
                <td class="l-table-edit-t"><spring:message code="hrms.EmpStatus"/></td>
                <td class="l-table-edit-c">
                	${attendanceKeeperInfo.STATUS_NAME}
                </td> 
                <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
                <td class="l-table-edit-c">
                	${attendanceKeeperInfo.CPNY_NAME}
                </td> 
            </tr>   
           </table> 
           
	        <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	               <td colspan="10" height="30px">
	            		<a class="l-button" onclick="f_save()" style="width:79px; height:20px; float:left; margin-left:10px;"><spring:message code="hrms.save"/></a>   
			      		<a class="l-button" onclick="collapseAll()" style="width:79px; height:20px; float:left; margin-left:10px;"><spring:message code="hrms.collapse"/></a> 
			    		<a class="l-button" onclick="expandAll()" style="width:79px; height:20px; float:left; margin-left:10px;"><spring:message code="hrms.expand"/></a>   
	               </td>
	           </tr> 
	       </table>  
         </form>
	  </div>
      <table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr> 
				<td width="85px" class="l-table-edit-t">
			      <div position="center" id="dept" style="width:600px; height:350px; float:left; border:0px solid #A3C0E8; overflow:auto;">  
			      	<table width="100%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						<tr> 
							<td width="85px" class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
							<td width="450px" class="l-table-edit-c">
						      	<ul id="deptTree">
						      	</ul>
							</td>  
						</tr>  
					</table>
			      </div> 
      			</td>  
			</tr>  
		</table>
 </div>     	
 </div>	
</body>
</html>
