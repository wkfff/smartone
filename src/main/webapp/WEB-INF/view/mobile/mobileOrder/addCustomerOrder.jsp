<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" name="viewport">
<title>Add Order</title>
<link href='http://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css' />
<!-- jquery mobile css -->
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile.structure-1.3.1.min.css" />
<link rel="stylesheet" href="/resources/css/mobile/my-custom-theme.min.css" />
<!-- jquery mobile js -->
<script src="/resources/js/jquery/jquery-1.7.1.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.1.min.js"></script>
<!-- 特定样式 未加载-->
<link rel="stylesheet" href="/resources/css/mobile/addCustomerOrder.css" />	
</head>
<body>
	<div data-role="page" data-position="inline">
<script type="text/javascript">
	var r = /^[0-9]*[1-9][0-9]*$/;//正整数 
	$(document).bind('pageinit', function(){
		$("#mobile_order_sub").click(function(){
			spf_submit();
		})
	});
	function spf_submit(){
		if($("#number").val() == null){
			alert("请填写数量");
			return;
		}
	//alert("number is not null");
	if( !r.test($("#number").val()) ){
		alert("请填写正整数");
		return;
	} 
	var data ={
		PRODUCT_ID: $("#PRODUCT_ID").val(),
		PRO_QUANTITY: $("#number").val(),
		ADDRESS: $("#address").val()
	};
	//alert("data");
	$.post('/ord/ordManage/addCustomerOrder',data, function(result){
		if(result == "Y"){
			alert("购买成功，返回主页");
			location.href="/mobile/home";
		}else{
			alert("购买失败，请重新登录或联系客服");
		}
	});
}
</script>
		<div data-role="header" data-theme="a">
			<a href="/mobile/home" data-rel="back" data-iconpos="left"
				data-theme="a" data-icon="home">Home</a>
			<h1>吉峰农机</h1>
		</div>
		<div data-role="content">		
				<label for="name">购买商品: </label>&nbsp;&nbsp;<font color="red">${paramMap.PRODUCT_NAME}</font>
				<div data-role="fieldcontain">
					<label for="number">请输入购买数量:  </label><input type="text"
						name="number" id="number" value="" /> <input type="hidden"
						name="PRODUCT_ID" id="PRODUCT_ID" value="${paramMap.PRODUCT_ID}" />
				</div>
				<div data-role="fieldcontain">
					<label for="address">请输入收货人地址:</label>
				<Textarea name="address" id="address">${customer.PROVINCE}&nbsp;${customer.CITY}&nbsp;${customer.AREA}&nbsp;${customer.ADDRESS}</Textarea>
				</div>
				<div class="button">
					<a class="confirmbutton" id="mobile_order_sub" data-role="button"
						data-theme="a" data-inline="true" data-rel="dialog"
						data-transition="fade" >确定</a> <a
						class="cancelbutton" href="/mobile/home" data-role="button"
						data-theme="a" data-inline="true">取消</a>
				</div>
		</div>
			<div data-theme="b" data-role="footer" role="contentinfo">
				<p class="ui-bar-f">
					© copyright 2013 -Made by SiPingSoft. <br /> <span>成都四平软件有限公司</span>
				</p>
			</div>
		</div>
	</div>
</body>
</html>