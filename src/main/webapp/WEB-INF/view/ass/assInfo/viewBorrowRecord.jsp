<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
   <meta http-equiv="X-UA-Compatible" content="IE=edge" >    
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
     <!-- JS -->
   <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>  
    <script type="text/javascript">
    var $grid ; 
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
         spf_initGrid();
    });
   
    function spf_initGrid()
    {
        $grid = $("#previewTool").ligerGrid({
         checkbox: false,   
            columns: [ 
            { display: '<spring:message code="ass.productName"/>', name: 'ASSET_NAME',width:90},
            { display: '<spring:message code="ass.lentTime"/>', name: 'BORROW_DATE',width:90},
            { display: '<spring:message code="ass.returnTime1"/>', name: 'RETURN_DATE',width:90},
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS', width: 90,
                render: function (item)  /*状态0是待确认，1是同意，2是否决，3是已取消，4是已归还*/
                { 
                    if(item.ACTIVITY == 0 ){  
                        return '<spring:message code="ass.unrecognized"/>';
                    }else if (item.ACTIVITY == 1 ){
                        return '<spring:message code="ass.recognizedd"/>';
                    }else if (item.ACTIVITY == 2 ){
                        return '<spring:message code="ess.rejected"/>';
                    }else if (item.ACTIVITY == 3 ){
                        return '<spring:message code="ass.canceled"/>';
                    }else if (item.ACTIVITY == 4 ){
                        return '<spring:message code="ass.hasReturned"/>';
                    }else{
                        return item.ACTIVITY;
                    }
                } 
            },
            { display: '<spring:message code="ass.returnStatus"/>', name: 'RETURN_TYPE',width:90},
            { display: '<spring:message code="ass.statusRemarks"/>', name: 'RETURN_REMARK',width:90}
            ],
            usePager: false,rownumbers: true,
            dataAction: 'server', 
            root: 'toolLoanList',
            url: '/ass/assInfo/getBorrowRecord?ASSET_ID=${assetDetail.ASSET_ID}',
            width: '99%', height: '99%'
        });
    }
    </script>
</head>
<body style="padding:0px" >
        <div id="previewTool"></div>
        <input type="hidden" name="ASSET_ID" id="ASSET_ID" value="${assetDetail.ASSET_ID}" /> 
</body>
</html>
