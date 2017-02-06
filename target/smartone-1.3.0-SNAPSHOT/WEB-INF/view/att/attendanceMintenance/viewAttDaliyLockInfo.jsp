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

    function f_ChildWindowClose (){
    	spf_search(); //加载数据
    	$dialog.close() ; 
    }
    
    function spf_search()
    {
		var year = $("#year").val() ;
		var month = $("#month").val() ;
        
        location.href = '/att/attendanceMintenance/viewAttDaliyLockInfo?year=' + year + "&month=" + month ; 
    }
   
    function gotob()
    {
    	var year = $("#year").val() ;
    	var month = $("#month").val() ;

    	var myDate=new Date();
    	myDate.setFullYear(year, month, 1);
    	month = myDate.getMonth() ;

    	if(month==1)
    	{
    		year=year-1;
    		month=12;
    	}
    	else if(month>1&&month<=12)
    	{
    		month=month-1;
    	}

    	month = month < 10 ? "0" + month : "" + month ;
    	
    	location.href = '/att/attendanceMintenance/viewAttDaliyLockInfo?year=' + year + "&month=" + month ; 
    }

    function gotoa()
    {
    	var year = $("#year").val() ;
    	var month = $("#month").val() ;

    	var myDate=new Date();
    	myDate.setFullYear(year, month, 1);
    	month = myDate.getMonth() ;
    	
    	if(month == 12)
    	{
    		year = year + 1;
    		month = 1;
    	}
    	else if(month >= 1 && month < 12)
    	{
    		month = month + 1 ;
    	}

    	month = month < 10 ? "0" + month : "" + month ;

    	location.href = '/att/attendanceMintenance/viewAttDaliyLockInfo?year=' + year + "&month=" + month ; 
    }
    function f_save(index,date)
    {     
		var year = $("#year").val() ;
		var month = $("#month").val() ;
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/att/attendanceMintenance/updateAttDaliyLockInfo", 
	           [	
                	{ name: 'AR_DATE_STR', value: date },
                	{ name: 'MONTHLY_LOCK_FLAG', value: index }
               ] 
        , function (result)
        {
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
            	$.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
     	        {
                    location.href = '/att/attendanceMintenance/viewAttDaliyLockInfo?year=' + year + "&month=" + month ; 
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
	  	<table width="100%" border="0" >
	        <tr><td height="2"></td></tr>
            <tr>
                <td align="center" valign="middle"> 
			   		<table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				        <tr>
						    <td class="l-table-edit-t" colspan="7">
						  		<img alt="" src="/resources/images/icon-prev.gif" onclick="javascript:gotob();" style="cursor: pointer;">
						       &nbsp;&nbsp;&nbsp;
						       <SipingSoft:date yearName="year" yearSelected="${param.year}" monthName="month" monthSelected="${param.month}" onChange="spf_search();"/>
						  		&nbsp;&nbsp;&nbsp;
						  		<img alt="" src="/resources/images/icon-next.gif" onclick="javascript:gotoa();" style="cursor: pointer;">
						  	</td> 
					  </tr>
					  <tr>
					    <td height="25" width="100" align="center"><font color="red"><spring:message code="calendar.sunday"/></font></td>
					    <td height="25" width="100" align="center"><spring:message code="calendar.monday"/></td>
					    <td height="22" width="100" align="center"><spring:message code="calendar.tuesday"/></td>
					    <td height="25" width="100" align="center"><spring:message code="calendar.wednesday"/></td>
					    <td height="25" width="100" align="center"><spring:message code="calendar.thursday"/></td>
					    <td height="25" width="100" align="center"><spring:message code="calendar.friday"/></td>
					    <td height="25" width="100" align="center"><font color="red"><spring:message code="calendar.saturday"/></font></td>
					  </tr>
					  <tr>
					  	<td colspan="7"><br>${calendarHtml} </td>
					  </tr> 
			       </table> 
       			</td>
	      	</tr>
	    </table>  
	  </div>   	
</div>       
</body>
</html>
