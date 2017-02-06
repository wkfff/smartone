<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!BOMTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>

<!-- Chart JS -->
<script src="/resources/js/chart/ichart.1.2.min.js" type="text/javascript"></script>
<script src="/resources/js/chart/colorPool.js" type="text/javascript"></script>

<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
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
    	/* var data = [
		        	{name : 'Android',value : 52.5,color:'#4572a7'},
		        	{name : 'IOS',value : 34.3,color:'#aa4643'},
		        	{name : 'Sybian',value : 8.4,color:'#89a54e'},
		        	{name : 'Microsoft',value : 3.6,color:'#80699b'},
		        	{name : 'Other',value : 1.2,color:'#3d96ae'}
	        	]; */
	    var invoiceNO = 6;    	
	    var detail = getInvoiceDetail(invoiceNO);
	    var data = parseInvoicePositionToChartData(getInvoicePosition(invoiceNO), detail);    	
    	renderChart(data, detail.SUBJECT+': \n总金额: '+detail.PAYABLE_AMOUNT+'\n状态: '+detail.STATUS_NAME);
    }
    
    function getInvoiceDetail(INVOICE_NO){
    	var invoiceDetail ;
    	$.ajax({
    		type: 'post',
    		url: "/fico/invoice/getInvoiceDetail?INVOICE_NO="+INVOICE_NO, 
    		dataType: 'json',	
    		async: false,
    	    success: function(result){
    	    	invoiceDetail = result;
    		}
    	});
    	return invoiceDetail;
    }
    
    function getInvoicePosition(INVOICE_NO){
    	var invoicePosition ;
    	$.ajax({
    		type: 'post',
    		url: "/fico/invoice/getPositionList?INVOICE_NO="+INVOICE_NO, 
    		dataType: 'json',	
    		async: false,
    	    success: function(result){
    			invoicePosition = result.Rows;
    		}
    	});
    	return invoicePosition;
    }
    
    function parseInvoiceDetailToChartData(invoiceDetail){
    	
    }
    
    function parseInvoicePositionToChartData(invoicePosition, invoiceDetail){
    	var resultData = new Array();
    	var paidAmount = 0;
    	for(var i=0; i<invoicePosition.length; i++){
    		var tmpData = {};
    		var tmpPosition = invoicePosition[i];		
    		tmpData.value = tmpPosition.AMOUNT*tmpPosition.PER_NET;
    		tmpData.name = tmpPosition.POSITION_NO+'-'+tmpPosition.S_TEXT+': '+tmpData.value;
    		paidAmount = paidAmount + tmpData.value;
    		tmpData.value = tmpData.value*100/(invoiceDetail.PAYABLE_AMOUNT);
    		tmpData.color = colorPool[i];
    		
    		resultData.push(tmpData);
    	}
    	i++;
    	var leftAmount = invoiceDetail.PAYABLE_AMOUNT - paidAmount;
    	resultData.push({
    		name: 0+'-剩余款项: '+leftAmount,
    		value: (leftAmount*100)/invoiceDetail.PAYABLE_AMOUNT,
    	    color: colorPool[i]
    	});
    	return resultData;
    }
    
    function renderChart(data, titleText){

		var chart = new iChart.Pie3D({
			render : 'canvasDiv',
			data: data,
			title : {
				text : '帐款比例',
				height:40,
				fontsize : 30,
				color : '#282828'
			},
			footnote : {
				text : 'Sipingsoft.com',
				color : '#486c8f',
				fontsize : 12,
				padding : '0 38'
			},
			sub_option : {
				mini_label_threshold_angle : 40,//迷你label的阀值,单位:角度
				mini_label:{//迷你label配置项
					fontsize:20,
					fontweight:600,
					color : '#ffffff'
				},
				label : {
					background_color:null,
					sign:false,//设置禁用label的小图标
					padding:'0 4',
					border:{
						enable:false,
						color:'#666666'
					},
					fontsize:11,
					fontweight:600,
					color : '#4572a7'
				},
				border : {
					width : 2,
					color : '#ffffff'
				},
				listeners:{
					parseText:function(d, t){
						return d.get('value')+"%";//自定义label文本
					}
				} 
			},
			legend:{
				enable:true,
				padding:0,
				offsetx:120,
				offsety:50,
				color:'#3e576f',
				fontsize:20,//文本大小
				sign_size:20,//小图标大小
				line_height:28,//设置行高
				sign_space:10,//小图标与文本间距
				border:false,
				align:'left',
				background_color : null//透明背景
			}, 
			shadow : true,
			shadow_blur : 6,
			shadow_color : '#aaaaaa',
			shadow_offsetx : 0,
			shadow_offsety : 0,
			//background_color:'#f1f1f1',
			background_color:'#ffffff',
			align:'right',//右对齐
			offsetx:-100,//设置向x轴负方向偏移位置60px
			offset_angle:-90,//逆时针偏移120度
			fit: true,
			animation: true,
			animation_duration: 500,
			radius:150
		});
		//利用自定义组件构造右侧说明文本
		chart.plugin(new iChart.Custom({
				drawFn:function(){
					//在右侧的位置，渲染说明文字
					chart.target.textAlign('start')
					.textBaseline('top')
					.textFont('600 20px Verdana')
					.fillText(titleText,120,80,false,'#be5985',false,24)
					.textFont('600 12px Verdana')
					.fillText('Source:SipingSoft ePLM,2013',120,160,false,'#999999');
				}
		}));
		
		chart.draw();
    	
    }

	</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="top">

            	<div id='canvasDiv'></div>
			</div>
		</div>
	</div>
</body>
</html>
