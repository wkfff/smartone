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
    <script src="/resources/js/json2.js" type="text/javascript"></script>
    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    var $grid ;
    var $dialog ;
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
        
    }); 
    
    function f_save()
    {
    	var jsonData = '[' ;
    	$(":checkbox").each(function ()
  	        {
  	            if(this.checked){
  	            	if (jsonData.length > 1){
   	             		jsonData += ',{'
	   	            }
	   	            else{
	   	             	jsonData += '{'
	   	            }
  	   	            
  	            	jsonData += ' "DDATE_STR": "' + this.value + '", ' ;
  	             	jsonData += ' "SHIFT_NO": "' + $("#WORK_SHIFT").val() + '", ' ;
  	                jsonData += ' "WORKDAYFLAG": "1", ' ;
  	             	jsonData += ' "TYPEID": "' + $("#type").val() + '"' ;

  	             	jsonData += '}' ;
  	            }
  	        });
    	jsonData += ']' ;	

    	if (jsonData.length == 2){
	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	    	 return ; 
    	}

        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/att/attendanceSettings/updateCompanyCalendarInfo", 
                [	
                 	{ name: 'jsonData', value: jsonData }
                ]
        , function (result)
        {
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>', function ()
                { 
                	location.href= "/att/attendanceSettings/viewCompanyCalendar?MENU_CODE=ar0102&year=${param.year}&month=${param.month}" ; 
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
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title='${param.year}-${param.month}'>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td class="l-table-edit-c" width="14%"></td>
						<td class="l-table-edit-t" width="14%"><spring:message
								code="hrms.dateType" /></td>
						<td class="l-table-edit-c" width="14%"><select id="type"
							name="type">
								<option value="1">
									<spring:message code="weekday" />
								</option>
								<option value="2">
									<spring:message code="weekend" />
								</option>
								<option value="3">
									<spring:message code="holiday" />
								</option>
						</select></td>
						<td class="l-table-edit-c" width="14%"></td>
						<td class="l-table-edit-t" width="14%"><spring:message
								code="hrms.workingShift.name" /></td>
						<td class="l-table-edit-c" width="14%"><SipingSoft:select
								name="WORK_SHIFT" dataListName="shiftInfo" /></td>
						<td class="l-table-edit-cc" height="30px;" width="14%"><a
							class="l-button"
							style="width: 79px; height: 20px; float: center; margin-left: 10px; "
							onclick="f_save()"><spring:message code="hrms.save" /></a></td>
					</tr>
					<tr align="center">
						<td height="25" width="100" align="center"><font color="red"><spring:message
									code="calendar.sunday" /></font></td>
						<td height="25" width="100" align="center"><spring:message
								code="calendar.monday" /></td>
						<td height="22" width="100" align="center"><spring:message
								code="calendar.tuesday" /></td>
						<td height="25" width="100" align="center"><spring:message
								code="calendar.wednesday" /></td>
						<td height="25" width="100" align="center"><spring:message
								code="calendar.thursday" /></td>
						<td height="25" width="100" align="center"><spring:message
								code="calendar.friday" /></td>
						<td height="25" width="100" align="center"><font color="red"><spring:message
									code="calendar.saturday" /></font></td>
					</tr>
					<tr>
						<td colspan="7"><br>${calendarHtml}</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
