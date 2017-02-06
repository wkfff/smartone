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
 
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
 
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
    	$grid = $("#productInfo").ligerGrid({
    		//checkbox: true,   		
    		columns: [   
			            { display: '货品编号', name: 'PRODUCT_ID', width: 90},
			            { display: '货品名称', name: 'PRODUCT_NAME', width: 120},
			            { display: '货品规格', name: 'SPECIFICATION', width: 100},
			            { display: '计量单位', name: 'UNIT_CODE', width: 90},
			            { display: '货品价格', name: 'UNIT_PRICE', width: 90},
			            { display: '库存数量', name: 'LEFT_QUANTITY', width: 90},
			            { display: '启用状态', name: 'STATUS' , width:80 ,
							render : function(item) {
								if(item.STATUS == 0){
									return "停用";
								}else{
									return "启用";
								}
							}
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: "/productStorage/productManage/getProductList",
            /*parms: [	
                   	{ name: 'PRODUCT_ID',value: '${productDetail.PRODUCT_ID}'},
                	{ name: 'qryType', value: $("#qryType").attr('value')} 
                   ],*/
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
            	spf_selectProduct();
            }
        });
    }  
    
    var tab = parent.tab;

    function spf_selectProduct()
    {
        
        var data;
    	data = $grid.getSelectedRow() 
    	if (!data)
        {
        	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
        	return ;
        }
        return data;
    }
    
    function spf_search()
    {
    	$grid.setOptions({parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')},
	   	                        	{name:'STATUS',value : $("#STATUS").val()}
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
					<td width="20%" class="l-table-edit-t">产品名称<spring:message
							code="keyWord" /></td>
					<td width="30%" class="l-table-edit-c"><input name="keyWord"
						type="text" id="keyWord" size="30" /></td>
					<td width="20%" class="l-table-edit-t">启用状态</td>
					<td class="l-table-edit-c" width="23%">
						<SipingSoft:selectStatus name="STATUS" limit="all" onChange="spf_search()"/></td>
				</tr>
			</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit" > 
		           <tr>
		              <td align="left" height="30px">
		               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a>   
		               </td>
		           </tr> 
		       </table>
		</div>		 
		<div id="productInfo" ></div>  

   </div>
   </div>    
</body>
</html>