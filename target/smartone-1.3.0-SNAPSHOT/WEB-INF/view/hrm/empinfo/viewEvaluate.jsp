<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<html>
<head>

<title>Translate information</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<!-- css -->
<link href="/resources/js/ligerUI/skins/Silvery/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<!-- js -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerMenu.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerMenuBar.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerToolBar.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>
<script src="/resources/js/common.js" type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<SCRIPT type="text/javascript">
/**
	综合工作评价
*/
  $(function () {
					$(this).loginWait('mainBody','loading',250);
		  			$(this).initStyle('/system/getModel?mtype=hrm&mjsp=evaluate','/system/updateModel?mtype=hrm&mjsp=evaluate');
 			  $("#evalGrid").ligerGrid({
                columns: [
                { display: '<spring:message code="hrms.evaluateDate"/>', name: 'EV_PERIOD_ID', align: 'center', width: 140, minWidth: 60 },
                { display: '<spring:message code="hrms.abilityEvaluate"/>', name: 'ABILITY', minWidth: 100 ,  render: function(item,index)
		                {
		                	if(item.ABILITY==null)
		                	{
		                		 item.ABILITY='0';
		                		 return item.ABILITY;
		                	}
		                	 return item.ABILITY;
		                }
		        },
                { display: '<spring:message code="hrms.experienceEvaluate"/>', name: 'EXPERIENCE', minWidth: 110, render: function(item,index)
		                {
		                	if(item.EXPERIENCE==null)
		                	{
		                		 item.EXPERIENCE='0';
		                		 return item.EXPERIENCE;
		                	}
		                	 return item.EXPERIENCE;
		                }
		         }, 
                { display: '<spring:message code="hrms.trainEvaluate"/>', name: 'EDU', minWidth: 110,  render: function(item,index)
		                {
		                	if(item.EDU==null)
		                	{
		                		 item.EDU='0';
		                		 return item.EDU;
		                	}
		                	 return item.EDU;
		                }
                }, 
                { display: '<spring:message code="hrms.subtractionEvaluate"/>', name: 'ADDSUB', minWidth: 110,  render: function(item,index)
		                {
		                	if(item.ADDSUB==null)
		                	{
		                		 item.ADDSUB='0';
		                		 return item.ADDSUB;
		                	}
		                	 return item.ADDSUB;
		                }
                
                }, 
                { display: '<spring:message code="hrms.total"/>', name: 'TOTAL', minWidth: 110 }
                ], 
                url: "/hrm/empinfo/getEvalList?empid=${basicInfo.EMPID }",
                sortName: 'EMPNUM', 
                dataAction: 'server',	               
			    pageSize: 5,
			    pageSizeOptions: [5,4,3,2,1], 
			    width: '92%',
			    height: '33%'
            });  
  /**
  		业绩能力评价
  */
  			$("#evaluateGrid").ligerGrid({
                columns: [
                { display: '<spring:message code="hrms.evaluateDate"/>', name: 'EV_PERIOD_ID', align: 'center', width: 140, minWidth: 60 },
                { display: '<spring:message code="hrms.evaluateDept"/>', name: 'EV_DEPT_NAME', minWidth: 110 },
                { display: '<spring:message code="hrms.evaluateGrade"/>(A)', name: 'EV_ITEM_GRADE_ID1', minWidth: 130 }, 
                { display: '<spring:message code="hrms.evaluators"/>(A)', name: 'EV_MASTER1', minWidth: 130 }, 
                { display: '<spring:message code="hrms.evaluateGrade"/>(B)', name: 'EV_ITEM_GRADE_ID2', minWidth: 160 }, 
                { display: '<spring:message code="hrms.evaluators"/>(B)', name: 'EV_MASTER2', minWidth: 210 }, 
                { display: '<spring:message code="hrms.finalGrade"/>（A+B）', name: 'EV_GRADE_ID', render: function(item,index)
		                {
		                	if(item.REASONS==null)
		                	{
		                		 item.REASONS='';
		                		 return item.REASONS;
		                	}
		                	 return item.REASONS;
		                }
                },
                { display: '<spring:message code="hrms.sectorRating"/>（C）', name: 'EV_DEPT_GRADE_ID', minWidth: 210 }, 
                { display: '<spring:message code="hrms.overallRating"/>[(A+B)+C]', name: 'EV_ACHIVE_ABILITY_GRADE_ID', minWidth: 210 }
                ], 
                 url: "/hrm/empinfo/getEvaluateList?empid=${basicInfo.EMPID }", 
                sortName: 'EV_EMP_ID', 
                dataAction: 'server',	               
			    pageSize: 5,
			    pageSizeOptions: [5,4,3,2,1], 
			    width: '92%',
			    height: '33%'
            });    
          
	});
</SCRIPT>
<style type="text/css">           
        	.l-button-update,.l-button-edit{width:80px; float:right; 
        	margin-right:10px;margin-top: 10px;}    
    	</style>
</head>
<body>
<div id="loading" style="width:90%;text-align:center;padding-top: 200px;position: absolute;">
			<img src="/resources/images/loading.gif">
</div>
<div id="mainBody">
		<input type="button" value='<spring:message code="submit"/>' id="update" class="l-button l-button-update"/>
		<input type="button" value='<spring:message code="edit"/>' onclick="edit();" class="l-button l-button-edit" />		
	
<form id="infoForm">
	<%@include file="viewBasicInfo.jsp"%>
	<div id="evalinfo" onmouseout="change('evalinfo');"
					style="border: dashed 1px #cccccc;position: absolute;">
	<table cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
						<tr>
							<td align="right">
							<img src="/resources/images/title/top_1.gif" align="center"/>
							</td>
							<td align="left">
								<font size="2"><spring:message code="hrms.ComprehensiveJobEvaluation"/></font>
							</td>						
						</tr>
					</table>
	</div>
    <div id="evalGrid" onmouseout="change('evalGrid');"
					style="position: absolute;"></div>
    <div id="evaluateinfo" onmouseout="change('evaluateinfo');"
					style="border: dashed 1px #cccccc;position: absolute;">
	<table cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
						<tr>
							<td align="right">
							<img src="/resources/images/title/top_1.gif" align="center"/>
							</td>
							<td align="left">
								<font size="2"><spring:message code="hrms.EvaluateInfo"/></font>
							</td>						
						</tr>
					</table>
	</div>
    <div id="evaluateGrid" onmouseout="change('evaluateGrid');"
					style="position: absolute;"></div>
</form>
</div>
</body>
</html>
