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
       
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
		var $grid = null;
	    var $dialog = null;
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
	    	$grid = $("#workExperienceInfo").ligerGrid({
	    		checkbox: false,
	            columns: [ 
	           	    { display: '', name: 'EDUC_NO',width: 10,hide:1},  
	           	    { display: '<spring:message code="hrms.startDate"/>', name: 'START_DATE', width: 120},
	           	    
					{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DATE', width: 120},
					{ display: '<spring:message code="hrms.institutionName"/>', name: 'INSTITUTION_NAME', width: 130}, 
					{ display: '<spring:message code="hrms.major"/>', name: 'MAJOR_NAME', width: 120}, 
					{ display: '<spring:message code="hrms.eduHis"/>', name: 'EDU_HIS_NAME', width: 110}, 
					{ display: '<spring:message code="hrms.degree"/>', name: 'DEGREE_NAME', width: 120},  
		            { display: '<spring:message code="hrms.courseContent"/>', name: 'CONTENT', align: 'left', width: 110,
		            	editor: { type: 'textarea', height: 100 }
		            } ,
		            { display: '<spring:message code="hrms.address"/>', name: 'ADDRESS', align: 'left', width: 110,
		            	editor: { type: 'textarea', height: 100 }
		            } ,
		            { display: '<spring:message code="hrms.remarks"/>', name: 'REMARK', align: 'left', width: 110,
		            	editor: { type: 'textarea', height: 100 }
		            }
	            ], 
	            enabledEdit: true, usePager: false,rownumbers: true, 
                url: "/hrm/empinfo/getEduInfoList?EMPID=${basicInfo.EMPID }", 
                pageSize: 5,	    
                pageSizeOptions: [5,4,3,2,1], 
	            heightDiff : 0, 
	            width: '99.5%', height: '99%'
	        });
	    }

	    function f_ChildWindowClose(){ 
	    	$grid.loadData(true); //加载数据
	    	$dialog.close() ;
	    }
	    
	    function spf_add()
	    {
	    	$dialog = $.ligerDialog.open({isDrag: false, showMax:false,showMin:false,
	   		    title:'<spring:message code="hrms.add"/>', 
	    		width: 800, height: 400, 
	    		url: '/hrm/empinfo/addEduInfo?EMPID=${basicInfo.EMPID}'
	        	  });
	    }
	    
	    function spf_update()
	    { 
	    	var rows = $grid.getSelectedRow(); 
	        if (!rows || rows.length == 0) { 
		       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		    	 return ; 
		    }
	        if (rows.length > 1){
	        	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
	        }
	          
	    	$dialog = $.ligerDialog.open({isDrag: false, 
	   		    title:'<spring:message code="hrms.update"/>', 
	    		width: 800, height: 400, 
	    		url: '/hrm/empinfo/updateEduInfo?EDUC_NO=' + rows.EDUC_NO
	       	  });
	    }
	    
	    function spf_delete()
	     {        
	     	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
	         {
	         	if(yes){
	 		     	 var rows = $grid.getSelectedRow(); ; 
	 		     	 
	 		         if (!rows || rows.length == 0) { 
	 		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	 		        	 return ; 
	 		        }
	 		         if (rows.length > 1){
	 		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
	 		         }
	   
	 		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
	 		        $.post("/hrm/empinfo/deleteEduInfo", 
	 		                [	
	 		                 	{ name: 'EDUC_NO', value: rows.EDUC_NO }
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
				<%@include file="viewBasicInfo.jsp"%>
				<br>
				<table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr>
						<td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
						<td width="25%" align="left" style="font-weight: bold;">
							<spring:message code="hrms.educationInfo"/>
						</td>	
						<td width="5%" align="right">&nbsp;</td>
						<td align="right"> 
	                    		<SipingSoft:button/>    
						</td>										    
					</tr> 
				</table>  
	</div>
				
      			<div position="left" id='workExperienceInfo'></div> 
	</div>
   </div> 
</body>
</html>
