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
		        	    {name : 'IE8',value : 40.59,color:'#3A68D3'},
			        	{name : 'IE6',value : 19.1,color:'#3895BF'},
			        	{name : 'Chrome',value : 13.68,color:'#2A962A'},
			        	{name : 'IE9',value : 10.91,color:'#4267BE'},
			        	{name : '搜狗高速',value : 6.19,color:'#9F2626'},
			        	{name : 'IE7',value : 1.48,color:'#4F7DE7'},
			        	{name : '奇虎360',value : 1.35,color:'#7A3C9C'},
			        	{name : 'Maxthon',value : 1.27,color:'#B97944'},
			        	{name : 'Firefox',value : 1.18,color:'#782A56'},
			        	{name : '其他',value : 4.26,color:'#484848'}
	        	]; */ 
	    var projectDetail = getProjectDetail(1016);     	
	    var data = parseInvoiceToChartData(getInvoiceList(1016)); 
	    projectDetail.totalCost = data.total;
    	renderChart(data.result, projectDetail);
    }
    
    function getProjectDetail(PROJECT_ID){
    	var projectDetail ;
    	$.ajax({
    		type: 'post',
    		url: "/ess/viewApp/getProInfo?PRO_NO="+PROJECT_ID, 
    		dataType: 'json',	
    		async: false,
    	    success: function(result){
    	    	projectDetail = result.Rows[0];
    		}
    	});
    	return projectDetail;
    }
    
    function getInvoiceList(PROJECT_ID){
    	var invoiceList ;
    	$.ajax({
    		type: 'post',
    		url: "/fico/invoice/getInvoiceList?PROJECT_ID="+PROJECT_ID, 
    		dataType: 'json',	
    		async: false,
    	    success: function(result){
    	    	invoiceList = result.Rows;
    		}
    	});
    	return invoiceList;
    }

    function parseInvoiceToChartData(invoices){
    	var resultData = new Array();
    	var totalValue = 0;
    	for(var i=0; i<invoices.length; i++){
    		var tmpData = {};
    		var tmpInvoice = invoices[i];		
    		tmpData.value = tmpInvoice.PAYABLE_AMOUNT;
    		tmpData.name = tmpInvoice.SUBJECT;
    		tmpData.color = colorPool[i];
    		resultData.push(tmpData);
    		totalValue = totalValue + tmpData.value; 
    	}
    	return { result: resultData,
    	         total: totalValue
    	        };
    }
    function renderChart(data, detail){
		var chart = new iChart.Column3D({
			render : 'canvasDiv',
			data: data,
			title : {
				text : detail.PRO_NAME_NAME+' 项目支出 (合计: '+detail.totalCost+')',
				color : '#3e576f'
			},
			/* width : 800,
			height : 400, */
			fit: true,
			animation: true,
			animation_duration: 500,
			padding: 20,
			shadow: true,
			shadow_color:'#080808',
			background_color:'#eceeef',
			sub_option:{
				label : {
					color : '#2c2e2a',
					padding : 10
				}
			},
			coordinate:{
				left_board:false,
				scale:[{
					 position:'left',
					 start_scale:0,
					 //end_scale:20000,
					 scale_space:2000,
					 listeners:{
							parseText:function(t,x,y){
								return {text:t+" "}
							}
						}
				}],
			},
			legend: {
				background_color:iChart.toRgba('#213e49',0.6),
				border:{radius:5},
				enable: true,
				align: 'right',
				valign: 'top',
				row: 'max',
				color:'#fefefe',
				column: 1,
				line_height: 15
			},
			tip : {
				enable : true
			}
		});
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
