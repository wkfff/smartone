<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" >

	<!-- CSS -->
	<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
	<link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
	<!-- JS -->
	<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>   
	<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>   
	<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script> 
	<script src="/resources/js/json2.js" type="text/javascript"></script>

	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  

	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
	var $dialog ;
	$(function (){
		$("#loading").hide();
		//布局
		$("#layout1").ligerLayout({	
			allowLeftResize: false,	//是否允许 左边可以调整大小
			allowRightResize: false,	//是否允许 右边可以调整大小
			allowTopResize: false,	//是否允许 头部可以调整大小
			allowBottomResize: false	//是否允许 底部可以调整大小
		}
		);
	});

	function  spf_Calculate(){
		var attMonth = $("#attYear").val() + $("#attMonth").val() ;
		$.ligerDialog.confirm('<spring:message code="hrms.beganToCalculate"/>','<spring:message code="hrms.warning"/>', function (yes){
			if(yes){
				$("#loading").show();
				//$("#monthCalculate").hide() ;
				$.ajax({
					type:'post',
					cache:false,
					contentType:'application/json',
					url: '/att/attendanceMintenance/monthCalculate?attMonth='+attMonth+'&empID=ALL',
					dataType:'json',
					success:function(responseStr){ 
						$("#calculateResult").html(responseStr) ;
						$("#loading").hide();
						//$("#monthCalculate").show() ;
					}
				});
			}
		});
	}
	</script>
</head>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
<body style="padding:2px" >
<div id="layout1" >
	<div align="left" position="center" id='' title=' ' >
	<div align="left">   
	<div id="loading" style="width:100%;text-align:center;padding-top: 200px;position: absolute;">
				<img src="/resources/images/loading.gif">
			</div>	
			<div id='monthCalculate' >
				<table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="20%" class="l-table-edit-t"><spring:message code="hrms.attendanceMonth"/></td>
						<td width="80%" class="l-table-edit-c" >
							<SipingSoft:date yearName="attYear" monthName="attMonth"/>
						</td>
					</tr>
					<tr>
						<td class="l-table-edit-c" colspan="2"> 
							<table cellpadding="0" cellspacing="0" class="l-table-edit" > 
								<tr>
									<td align="left" height="30px"> 
										<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_Calculate()"><spring:message code="calculate"/></a>  
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
				<table height="100px;" cellpadding="0" cellspacing="0" class="l-table-edit" >
					<tr><td colspan="2"><div id="calculateResult"></div></td></tr>
				</table> 
		</div>
</div>
</div>
</div>
</body>
</html>
