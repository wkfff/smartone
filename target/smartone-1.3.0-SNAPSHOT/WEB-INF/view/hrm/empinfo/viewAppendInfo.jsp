<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<html>
<head>
<title>Translate information</title>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
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
</head>
<SCRIPT type="text/javascript">
  var $grids={};
/**
	附加信息
*/
  $(function () {
		  			$(this).loginWait('mainBody','loading',250);
		  			$(this).initStyle('/system/getModel?mtype=hrm&mjsp=appendInfo','/system/updateModel?mtype=hrm&mjsp=appendInfo');
 			  $("#appendInfoGrid").ligerGrid({
                columns: [
                { display: '<spring:message code="hrms.selection"/>', name: 'EMPID', minWidth: 65, 
                	render: function (item)
	                    {
	                        return "<input type='checkbox'/>"
	                    } 
                },
                { display: '<spring:message code="hrms.releaseDate"/>', name: 'EVENTDATE', align: 'center', width: 140, minWidth: 60,type: 'date', editor: { type: 'date'} },
                { display: '<spring:message code="hrms.informationType"/>', name: 'INFOTYPECODE', minWidth: 100 ,editor:{type : 'string'}},
                { display: '<spring:message code="hrms.details"/>', name: 'DETATLS', minWidth: 110 ,editor:{type : 'string'}}, 
                { display: '<spring:message code="hrms.registrants"/>', name: 'REGISTER', minWidth: 110 }
                ], 
                enabledEdit: true,
                url: "/hrm/empinfo/getAppendInfoList?empid=${basicInfo.EMPID }",  
                sortName: 'EMPID', 
		        dataAction: 'server',	               
			    pageSize: 5,
			    pageSizeOptions: [5,4,3,2,1], 
			    width: '92%',
			    height: '33%'
            });  
             $grids=$.ligerExpandGrid.CRUD.initSubmit("#appendInfoGrid");
        });
     function delRow()
	   {
	  $grids.delRow();
	   }



function addRow()
	   {
	   $grids.addRow();

	   }


function save()
	   {
	   	$grids.gridSubmit(); 
	   	var input="<input type='hidden' name='#fappendInfoGrid' value='"+$grids.jsonData['#appendInfoGrid']+"'/>";
			$("#updateGrid").append(input);
	     	$("#updateGrid").submit();
	     return false;  
	   }
</SCRIPT>
<style type="text/css">           
        	.l-button-update,.l-button-edit{width:80px; float:right; 
        	margin-right:10px;margin-top: 10px;}    
    	</style>
<body>
<div id="loading" style="width:90%;text-align:center;padding-top: 200px;position: absolute;">
			<img src="/resources/images/loading.gif">
</div>
<div id="mainBody">
		<input type="button" value='删除' id="delect" onclick="delRow();" class="l-button l-button-update"/>
		<input type="button" value='添加' id="add" onclick="addRow()" class="l-button l-button-update"/>
		<input type="button" value='保存' id="save" onclick="save()" class="l-button l-button-update"/>
		<input type="button" value='<spring:message code="submit"/>' id="update" class="l-button l-button-update"/>
		<input type="button" value='<spring:message code="edit"/>' onclick="edit();" class="l-button l-button-edit" />		
	

<form id="infoForm">
	<%@include file="viewBasicInfo.jsp"%>

 	<div id="appendInfoinfo" onmouseout="change('appendInfoinfo');"
					style="border: dashed 1px #cccccc;position: absolute;">
					<table cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
						<tr>
							<td align="right">
							<img src="/resources/images/title/top_1.gif" align="center"/>
							</td>
							<td align="left"><!-- 附加信息 -->
								<font size="2"><spring:message code="hrms.additionalInformation"/></font>
							</td>						
						</tr>
					</table>
	</div>
    <div id="appendInfoGrid"   onmouseout="change('appendInfoGrid');" style="position: absolute;"></div>
</form>
</div>

<form id="updateGrid" method="post" action="/hrm/empinfo/updateFappendInfoGrid?updateBy=${basicInfo.EMPID }"></form>
</body>
</html>
