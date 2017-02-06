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
         
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
	
<script type="text/javascript">
    var flag = 'CONDITION';
	//初始调用
	$(function ()
	{
		//布局
	    $("#layout1").ligerLayout(
	     {  
	     }
	   );
	
	    spf_inputItemTree();
	    spf_itemTree();
	    spf_hrTree();
	    spf_attTree();
	});

	function filltext(values,valuess) {
		
		if (parent){
		 
			if (parent.form1) { 
				if (flag == "CONDITION") { 
					var target = parent.form1.CONDITION;
				}else{ 
					var target = parent.form1.FORMULAR;
					var targets = parent.form1.DESCRIPTION;
				}
				if(values == '0'||values == '1'
					||values == '2'||values == '3'
					||values == '4'||values == '5'
					||values == '6'||values == '7'
					||values == '8'||values == '9'
					||values == '.'||values == "'"){
					target.value+=values;
					targets.value+=valuess; 
				}else{
					target.value+=' '+values+' ';
					targets.value+=' '+valuess+' '; 
				}
			}
		}
	}

	function changeradio(note){
		flag = note;
	}

	function onSelect(note){      
		filltext(note.data.ITEM_ID_F,note.data.ITEM_NAME_F); 
	}

	function spf_inputItemTree()
	{
		$.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/att/attendanceSettings/getItemInfo',            	
	       	dataType:'json',
	       	success:function(response){ 
	               $tree = $("#attDTree").ligerTree(
		           	          { 
		           		          checkbox: false, 
    		                      treeLine: true,
    		                      parentIcon: null, 
    		                      childIcon: null,  
	    		                  nodeWidth: 160,
		           	              onSelect: onSelect,
		           	              data: response.Rows,
		           	           	  idFieldName: 'ITEM_ID_F', textFieldName: 'ITEM_NAME_F'
		           	          }
	                     );
	       	}          	
	  	}); 
	}
	function spf_itemTree()
	{
		$.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/att/attendanceSettings/getAttMItemInfo',            	
	       	dataType:'json',
	       	success:function(response){ 
	               $tree = $("#attMTree").ligerTree(
		           	          { 
		           		          checkbox: false, 
    		                      treeLine: true,
    		                      parentIcon: null, 
    		                      childIcon: null,  
	    		                  nodeWidth: 160,
		           	              onSelect: onSelect,
		           	              data: response.Rows,
		           	           	  idFieldName: 'ITEM_ID_F', textFieldName: 'ITEM_NAME_F'
		           	          }
	                     );
	       	}          	
	  	}); 
	}
	function spf_hrTree()
	{
		$.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/utility/otherInfo/getToolItemSelectList?TABLE_NAME=PA_HR_V',            	
	       	dataType:'json',
	       	success:function(response){ 
	               $tree = $("#hrTree").ligerTree(
		           	          { 
		           		          checkbox: false, 
    		                      treeLine: true,
    		                      parentIcon: null, 
    		                      childIcon: null,  
	    		                  nodeWidth: 160,
		           	              onSelect: onSelect,
		           	              data: response.Rows,
		           	           	  idFieldName: 'ITEM_ID_F', textFieldName: 'ITEM_NAME_F'
		           	          }
	                     );
	       	}          	
	  	}); 
	}
	 
</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:0px" > 
	  <div id='layout1' style="position: inherit;margin:0px auto; ">
		     <form name="form1" method="post" action="" id="form1">
		         <table width="99%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
					<tr> 
						<td height="30px;"> 
		           			&nbsp;
		           			<input type="hidden" id="obj" name="obj" value="obj">
						</td>										    
					</tr> 
				</table>     
		   		<table width="99%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
		           <tr>
			       	   <td width="23%" class="l-table-edit-cc"><spring:message code="hrms.attendanceItem"/></td>
		           	   <td width="23%" class="l-table-edit-cc"><spring:message code="hrms.monthlyItem"/></td>
		           	   <td width="24%" class="l-table-edit-cc"><spring:message code="hrms.personnelItem"/></td> 
		           	   <td width="30%" class="l-table-edit-cc"><spring:message code="tool"/></td>
		           </tr> 
		           <tr>
			       	   <td width="20%" height="" class="l-table-edit-c">
    					<div style="width:200px; height:300px; margin:0px; float:left; border:1px solid #A3C0E8; overflow:auto; ">
			       	   		<ul id="attDTree"> </ul>
			       	   	</div>
			       	   </td>
			       	   <td width="20%" class="l-table-edit-c">
			       	   		<div style="width:200px; height:300px; margin:5px; float:left; border:1px solid #A3C0E8; overflow:auto;  ">
			       	   		<ul id="attMTree"> </ul>
			       	   	</div></td>
			       	   <td width="20%" class="l-table-edit-c">
			       	   		<div style="width:200px; height:300px; margin:0px; float:left; border:1px solid #A3C0E8; overflow:auto;  ">
			       	   		<ul id="hrTree"> </ul>
			       	   	</div></td> 
			       	   <td width="40%" class="l-table-edit-c"> 
			       	   
						    <table width="99%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			          			 <tr>
							        <td class="l-table-edit-cc">
							        	<input type="radio" name="radiobutton" value="CONDITION" onClick="changeradio(this.value)" checked>
							      		<spring:message code="condition"/>
									</td>
							        <td class="l-table-edit-cc">
								        <input type="radio" name="radiobutton" value="FORMULAR" onClick="changeradio(this.value)">
								        <spring:message code="formula"/>
							        </td>
							      </tr>
						    </table>
						    
						      <table width="99%" border="0" cellspacing="0" cellpadding="0">
						        <tr align="center">
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="1"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="2"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="3"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="+"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="'"></td>
						        </tr>
						        <tr align="center">
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="4"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="5"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="6"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="-"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="IN"></td>
						        </tr>
						        <tr align="center">
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="7"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="8"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="9"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="*"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="AND"></td>
						        </tr>
						        <tr align="center">
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="("></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="0"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value=")"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="%"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="OR"></td>
						        </tr>
						        <tr align="center">
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="="></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="<"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="BETWEEN"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value=">"></td>
						          <td width="40" height="36"><input name="button" type="button" class="l-button" onClick="filltext(this.value,this.value)" value="<>"></td>
						        </tr>
						        <tr align="center">  
						          <td height="36" colspan="5">
						            <a class="l-button" style="width:79px; height:20px; float:left; " onclick="filltext('.','.')">.</a> 
						            <a class="l-button" style="width:79px; height:20px; float:right; " onclick="filltext(' ',' ')">Space</a>   
						          </td>
						        </tr> 
						</table>
					</td></tr> 
		       </table>
	         </form>
	  </div>
</body>
</html>
