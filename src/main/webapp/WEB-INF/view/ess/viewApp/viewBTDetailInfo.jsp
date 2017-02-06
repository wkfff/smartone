<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
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
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $grid = null ; 
    //扩展一个 多行文本框 的编辑器
    $.ligerDefaults.Grid.editors['textarea'] = {
        create: function (container, editParm)
        {
            var input = $("<textarea class='l-textarea' />");
            container.append(input);
            return input;
        },
        getValue: function (input, editParm)
        {
            return input.val();
        },
        setValue: function (input, value, editParm)
        {
            input.val(value);
        },
        resize: function (input, width, height, editParm)
        {
            var column = editParm.column;
            if (column.editor.width) input.width(column.editor.width);
            else input.width(width);
            if (column.editor.height) input.height(column.editor.height);
            else input.height(height);
        }
    };
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
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: false,
    		columns: [   
			            { display: '', name: 'APPLY_NO', width: 10,hide: 1},
			            { display: '<spring:message code="hrms.btType"/>', name: 'BT_TYPE_NAME', width: 120},  
			            { display: '<spring:message code="hrms.btDate"/>', name: 'BT_DATE', width: 120},  
			            { display: '<spring:message code="hrms.startedTime"/>', name: 'BT_FROM_TIME', width: 110},  
			            { display: '<spring:message code="hrms.endTime"/>', name: 'BT_TO_TIME', width: 110}, 
			            { display: '<spring:message code="hrms.btCity"/>', name: 'BT_CITY_NAME', width: 110}, 
			            { display: '<spring:message code="hrms.workingContent"/>', name: 'BT_CONTENT', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.remarks"/>', name: 'BT_REMARK', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 120},  
			            { display: '<spring:message code="hrms.confirmationActive"/>', name: 'CON_STATUS', width: 120},   
			            { display: '<spring:message code="hrms.confirmationRemarks"/>', name: 'CON_REMARK', align: 'left', width: 140,
			            	editor: { type: 'textarea', height: 100 }
			            },
			            { display: '<spring:message code="hrms.cancelRemarks"/>', name: 'CANCEL_REMARK', align: 'left', width: 120,
			            	editor: { type: 'textarea', height: 100 }
			            }
		            ],
            enabledEdit: true,usePager: false, rownumbers:true,
            url: '/ess/viewApp/getBTInfo',
            parms: [	
                   	{ name: 'BT_NO',value: ${paraMap.BT_NO}}
                   ],
            width: '99%', height: '99%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){  
           	 	spf_showDetailData(rowdata.APPLY_NO);
            }
        });
    }
    function spf_showDetailData(applyNo)
    {    
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.approvalActive"/>', 
    		width: 700, 
    		height: 300, 
  		    url: '/ess/viewApp/viewApproverInfo?PAGE=B&FLAG=0&APPLY_TYPE=BTApply&APPLY_NO='+applyNo
       	  });
    }
     
	</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#layout1 {
	width: 99%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 0px">
<body style="padding: 0px">
	<div id="layout1">
		<div position="center" id='' title=' '>
			<div position="center" id='empInfo'></div>
		</div>
	</div>
</body>
</html>
