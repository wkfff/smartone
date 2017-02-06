<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerDialog.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
	type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script src="/resources/js/myhome.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">
     // 初始调用
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
          init_detail();
       
     }); 
    function check()
    {
    	var telereg = /^[0-9]{1,}$/;
    	var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
    	
    	  if (  $("*[name='SUPPLIER_EMAIL']").val() != "" && !mailreg.test($("*[name='SUPPLIER_EMAIL']").val())) {  
	 	       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '邮箱' + '格式错误') ; 
	 	       	 return false; 
	        	}
    	 if( $("*[name='SUPPLIER_PHONE1']").val()!= "")
   		  {
	    	  if (!telereg.test($("*[name='SUPPLIER_PHONE1']").val())) {  
			       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '联系方式1'+ '格式错误') ; 
			       	 return false; 
		       }
	      
   	 	 }
    	 
    	 if( $("*[name='SUPPLIER_PHONE2']").val() != "")
   	 	 {
	    	  if (!telereg.test($("*[name='SUPPLIER_PHONE2']").val())) {  
			       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '联系方式2'+ '格式错误') ; 
			       	 return false; 
		       }
	  	    
   		  }
    	 
    	 if( $("*[name='SUPPLIER_FAX']").val() != "")
   	 	 {
	    	  if (!telereg.test($("*[name='SUPPLIER_FAX']").val())) {  
			       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '传真'+ '格式错误') ; 
			       	 return false; 
		       }
	      
   	 	 }
	    
	  
				 
				 return true;
    }
	function init_detail()
	{
		$.ajax({
			   type: "GET",
			   url: "/cust/supperlierManager/getSupplierDetail",
			   success:function(result){
				 $("#suppliername").text(result.SUPPLIER.SUPPLIER_NAME);
			     $("#supplier_name").text(result.SUPPLIER.SUPPLIER_NAME);
			     $("#supplier_contacts").text(result.SUPPLIER.SUPPLIER_CONTACTS);
			     $("#supplier_username").text(result.SUPPLIER.USERNAME);
			     $("#supplier_fax").text(result.SUPPLIER.SUPPLIER_FAX);
			     $("#supplier_status").text(function(){
			    	 if(result.SUPPLIER.ACTIVITY=='1')
			    		 {
			    		 	return "可用";
			    		 }
			    	 else
			    		 {
			    		 	return "不可用";
			    		 }
			     });
			     
			     $("#supplier_phone1").text(result.SUPPLIER.SUPPLIER_PHONE1);
			     $("#supplier_phone2").text(result.SUPPLIER.SUPPLIER_PHONE2);
			     $("#supplier_email").text(result.SUPPLIER.SUPPLIER_EMAIL);
			     $("#supplier_address").text(result.SUPPLIER.SUPPLIER_ADDRESS);
			     $("#supplier_product_count").text(result.supplierProductCount+" 件");
			   } 
			});
	}
	function spf_update(){
		$("#updateSupplier").fadeIn(1000);
		$("*[name='SUPPLIER_CONTACTS']").val($("#supplier_contacts").text());
		$("*[name='SUPPLIER_PHONE1']").val($("#supplier_phone1").text());
		$("*[name='SUPPLIER_PHONE2']").val($("#supplier_phone2").text());
		$("*[name='SUPPLIER_EMAIL']").val($("#supplier_email").text());
		$("*[name='SUPPLIER_FAX']").val($("#supplier_fax").text());
		$("*[name='SUPPLIER_ADDRESS']").val($("#supplier_address").text());
	}
	function spf_updateSupplier()
	{
		if(!check())
			{
				return;
			}
		var param={
				SUPPLIER_CONTACTS:$("*[name='SUPPLIER_CONTACTS']").val(),
				SUPPLIER_PHONE1:$("*[name='SUPPLIER_PHONE1']").val(),
				SUPPLIER_PHONE2:$("*[name='SUPPLIER_PHONE2']").val(),
				SUPPLIER_EMAIL:$("*[name='SUPPLIER_EMAIL']").val(),
				SUPPLIER_FAX:$("*[name='SUPPLIER_FAX']").val(),
				SUPPLIER_ADDRESS:$("*[name='SUPPLIER_ADDRESS']").val()
						
		};
		$.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		$.ajax({
			  url: "/cust/supperlierManager/updateSupplierBySupplier",
			  data: param,
			  type: "POST",
			  success: function(){
				  $.ligerDialog.closeWaitting();
				  $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
				  $("#updateSupplier").hide(1000);
				  init_detail();
			  },
			  error:function(){
				  $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', "wrong");
			  }
			});
		/* $.post("/cust/supperlierManager/updateSupplierBySupplier",param,function(result){
			
		}); */
	}
	function spf_clear()
	{
		$("#updateSupplier").hide(500);
	}
	
    </script>
</head>
<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
	overflow: hidden;
	font-size: 12px;
}

#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
	height: 99%;
}

#title {
	font-size: 16px;
	color: #360;
	margin-top: 20px;
	margin-left: 20px;
}

#logo {
	margin-left: 20px;
	border-bottom: solid 1px #c1dcfa;
}

#tubiao {
	margin-top: 20px;
	margin-left: 5%;
}

#logo span {
	font-size: 16px;
	color: #333333;
	text-shadow: gray;
	letter-spacing: 1px;
}

#detailtable {
	border: solid 1px #c1dcfa;
	font-size: 12px;
	margin-left: 5%;
}

#detail table tr {
	line-height: 30px;
	border-bottom: solid 1px #c1dcfa;
}

#detail table tr .title {
	color: #003366;
	background-color: #c1dcfa;
	text-align: center;
}

#detail table tr .content {
	color: #333333;
	padding-left: 5px;
}

#updateSupplier {
	margin-top: 10px;
	margin-left: 5%;
	margin-right: 5%;
	padding: 5px;
	display: none;
}

#updateSupplier .updatetitle {
	color: #003366;
	font-size: 12px;
	text-align: center;
}

#updateSupplier .updatecontent {
	border: solid 1px #c1dcfa;
	margin-bottom: 5px;
	font-size: 12px;
	width: 180px;
	text-align: left;
	line-height: 20px;
	height: 20px;
}
</style>



<!-- <body style="padding:0px" onload="spf_firstLogin()"> -->
<body style="padding: 2px">
	<div id="layout1">
		<div id="title">
			<img src="/resources/images/title/top_1.gif">&nbsp;优质供应商
		</div>
		<br />
		<div id="logo">
			&nbsp;&nbsp;<img src="/resources/images/login/supplier.png"
				height="70"><span id="suppliername"></span>
		</div>
		<div id="updateSupplier">
			<form  name="form1" method="post" action="" id="form1">

				<table width="90%" cellpadding="0" cellspacing="0">
					<tr>
						<td width="5%" class="updatetitle">负责人</td>
						<td width="10%"><input type="text" name="SUPPLIER_CONTACTS"
							class="updatecontent" /></td>
						<td width="5%" class="updatetitle">联系方式1</td>
						<td width="10%"><input type="text" name="SUPPLIER_PHONE1"
							/ class="updatecontent"></td>
						<td width="5%" class="updatetitle">联系方式2</td>
						<td width="10%"><input type="text" name="SUPPLIER_PHONE2"
							class="updatecontent" /></td>

					</tr>
					<tr>
						<td width="5%" class="updatetitle">邮箱</td>
						<td width="10%"><input type="text" name="SUPPLIER_EMAIL"
							class="updatecontent" /></td>
						<td width="5%" class="updatetitle">传真</td>
						<td width="10%"><input type="text" name="SUPPLIER_FAX"
							class="updatecontent" /></td>

						<td width="5%" class="updatetitle">地址</td>
						<td width="15%"><input type="text" name="SUPPLIER_ADDRESS"
							class="updatecontent" /></td>

					</tr>

				</table>

			</form>
			<table width="30%" align="right" style="margin-top: 10px;">
				<tr align="center">

					<td height="30" align="center"><a class="l-button"
						style="width: 50px; height: 20px; margin-left: 80px; ackground-image: url('/resources/images/button/button.gif');"
						onclick="spf_updateSupplier()">保存</a></td>
					<td><a class="l-button"
						style="width: 50px; height: 20px; margin-right: 80px; "
						onclick="spf_clear()">取消</a></td>
				</tr>
			</table>
		</div>

		<div id="detail">
			<div id="tubiao">
				<img src="/resources/images/title/top_1.gif">&nbsp;基本信息&nbsp;&nbsp;
				<a href="#" onclick="spf_update()"
					style="color: #000; cursor: pointer; text-decoration: none;">编辑信息</a>
			</div>
			<table width="90%" cellpadding="0" cellspacing="0" id="detailtable">
				<tr>
					<td width="10%" rowspan="4"><img width="100"
						src="/resources/images/login/supplier_admin.png"></td>
					<td width="10%" class="title">公司名称：</td>
					<td width="20%" class="content" id="supplier_name"></td>

					<td class="title">商品总数：</td>
					<td width="20%" class="content" id="supplier_product_count"></td>

					<td class="title">状&nbsp;态：</td>
					<td width="20%" class="content" id="supplier_status"></td>
				</tr>
				<tr>
					<td width="10%" class="title">负责人：</td>
					<td width="20%" class="content" id="supplier_contacts"></td>

					<td width="10%" class="title">账户名：</td>
					<td width="20%" class="content" id="supplier_username"></td>

					<td class="title">传&nbsp;真：</td>
					<td class="content" id="supplier_fax"></td>

				</tr>
				<tr>

					<td width="10%" class="title">联系方式1：</td>
					<td class="content" id="supplier_phone1"></td>
					<td width="10%" class="title">联系方式2：</td>
					<td class="content" id="supplier_phone2"></td>
					<td width="10%" class="title">邮&nbsp;箱：</td>
					<td class="content" id="supplier_email"></td>
				</tr>
				<tr>




					<td width="10%" class="title">公司地址:</td>
					<td class="content" colspan="5" id="supplier_address"></td>
				</tr>

			</table>
		</div>
	</div>
</body>
</html>