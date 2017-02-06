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
    
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
	
<script type="text/javascript">
 	
//初始化数据 
	$(function ()
	    {
	        //布局
	         $("#layout1").ligerLayout({  
	
	    	         allowLeftResize: false,      //是否允许 左边可以调整大小
	    	         allowRightResize: false,     //是否允许 右边可以调整大小
	    	         allowTopResize: false,      //是否允许 头部可以调整大小
	    	         allowBottomResize: false     //是否允许 底部可以调整大小
	          }
	         ); 
	    	 //alert('${DOC_ID}');
	    });  
 	// 初始调用 
    function spf_remove() { 
    	if(spf_checkData()){ 	 		      
             $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
             $.post("/doc/docManage/removeDocument", 
                     [	
                        { name: 'REMOVE_REMARK', value: $("#REMOVE_REMARK").val()},
                        { name: 'DOC_ID', value: $("#DOC_ID").val()}
                      ]
             , function (result)
             {
             	$.ligerDialog.closeWaitting();
                 if (result == "Y")
                 {
                     $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                     {
                     	parent.spf_afterRemove();
                     });
                 }
                 else
                 {
                     $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                 }
             });
    	}
     }
    function spf_checkData()
    {     
    	//return true;
        if ($("#DOC_ID").val() == null || $("#DOC_ID").val() == "") {  
	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '文档编号'+". " + '<spring:message code="input.required"/>') ; 
	       	 return false; 
        }  
        if ($("#REMOVE_REMARK").val() == null || $("#REMOVE_REMARK").val() == "") { 
  	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '删除备注'+". " + '<spring:message code="input.required"/>') ; 
  	       	 return false; 
  	    }    
   		return true;     
    } 

</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" >
	<div id="layout1" style="width: 99.6%; margin: 0; padding: 0;">
		<input type="hidden" id="DOC_ID" name="DOC_ID" value='${documentDetail.DOC_ID}' />
		<table width="99.6%" align="center" cellpadding="0" cellspacing="0"
			class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
			<tr>
				<td width="100%" class="l-table-edit-c">
					删除备注<font color="red">*</font>
				</td>
			</tr>
			<tr>
				<td width="100%" class="l-table-edit-c" colspan="5" nowrap="nowrap">
					<textarea rows="3" cols="60" id="REMOVE_REMARK" name="REMOVE_REMARK"></textarea>
				</td>
			</tr>
			<tr>
				<td>		
		           <a class="l-button" style="width:79px; height:20px; float: left; margin-left:1px;
		              " onclick="spf_remove()">删除</a>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>
