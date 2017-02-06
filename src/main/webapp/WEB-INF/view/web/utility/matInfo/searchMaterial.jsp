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
    <script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>   
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script type="text/javascript">
    var $grid ;
    var $dialog ;
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
    	$grid = $("#materialInfo").ligerGrid({
    		//checkbox: true,   		
    		columns: [   
			            { display: '物料编号', name: 'MAT_ID', width: 150},
			            { display: '物料名称', name: 'MAT_NAME', width: 150},
			            { display: '描述', name: 'MAT_DESCRIPTION', width: 200}
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/utility/matInfo/getMaterialList',
            /*parms: [	
                   	{ name: 'CHANNEl_ID',value: '${productDetail.CHANNEl_ID}'},
                	{ name: 'qryType', value: $("#qryType").attr('value')} 
                   ],*/
            width: '99.6%', height: '100%'
        });
    }  
    
    var tab = parent.tab;

    function spf_selectMaterial()
    {
        return $grid.getSelectedRow();
    }
    
    function spf_search()
    {
    	$grid.setOptions({parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}
   	                           ],
   	                   newPage: 1
   	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout3{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>	
<body style="padding:2px" >
<div id="layout3" id='' title=' '> 
     <div position="center" id='' title=' ' style="border: 0px;"> 
		<div position="top">
			<table width="99.6%" cellpadding="0" cellspacing="0"
				class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
				<tr>
					<td width="15%" class="l-table-edit-t">物料名称<spring:message
							code="keyWord" /></td>
					<td width="25%" class="l-table-edit-c"><input name="keyWord"
						type="text" id="keyWord" size="30" /></td>
					<%-- <td width="15%" class="l-table-edit-t">信用额度</td>
					<td class="l-table-edit-c"><input type="text" name="S_DATE"
						id="S_DATE" value="" size="20"
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /> ~ <input type="text" name="E_DATE"
						id="E_DATE" value="" size="20"
						onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
						readonly="readonly" /></td> --%>
				</tr>
				<tr>
				<td colspan="3">
					<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>
				</td>	
				</tr>
			</table>
		</div>		 
		<div id="materialInfo" ></div>
   </div>
   </div>    
</body>
</html>