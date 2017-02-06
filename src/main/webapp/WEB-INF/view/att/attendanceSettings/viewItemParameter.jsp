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
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({ leftWidth: 180});

         $tree = $("#itemTree").ligerTree(
	          { 
		          checkbox: false,
	              onSelect: onSelect
	          }
          );

         f_initGrid();

    });

    function onSelect(note)
    {       

 		 $.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	            			            	
	       	url:'/att/attendanceSettings/getItemParameterInfoList?AR_ITEM_NO=' + note.data.url,            	
	       	dataType:'json',
	       	success:function(response){ 
	        		var jsonObj = {};
	               jsonObj.Rows = response ; 
	     		   $grid.setOptions({ data : jsonObj }); //设置数据参数
	               $grid.loadData(true); //加载数据
	       	}          	
      	});
    }

    function f_initGrid()
    {
    	$grid = $("#itemParameterInfoList").ligerGrid({
            columns: [
                        { display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME'},
			            { display: '<spring:message code="hrms.workingShift.group"/>', name: 'AR_GROUP_NAME'},
			            { display: '<spring:message code="hrms.referenceTimecard"/>', name: 'CARD_FLAG_NAME'},
			            { display: '<spring:message code="hrms.referenceApplication"/>', name: 'APPLY_FLAG_NAME'},
			            { display: '<spring:message code="hrms.dateType"/>', name: 'DATE_TYPE_NAME'},
			            { display: '<spring:message code="hrms.active"/>', name: 'ACTIVITY', width: 60, render: function (row, index)
			                {
			            		return '<img src="/resources/images/a_' + row.ACTIVITY + '.gif">';
			            	}
			        	}
            ],
            enabledEdit: false, usePager: false,rownumbers: true,
            width: '100%', height: '100%',
            heightDiff : 0
        });
    }

    function spf_add()
    {
    	var note = $tree.getSelected();

    	if (note == null){ return ;}

    	$dialog = $.ligerDialog.open({isDrag: false, 
   		       title:'<spring:message code="hrms.add"/>', 
    		   width: 1100, 
    		   height: 510, 
    		   url: '/att/attendanceSettings/addItemParameterInfo?AR_ITEM_NO=' + note.data.url
        	  });
    }

    function f_ChildWindowClose (){

    	var note = $tree.getSelected(); 
    	if (note == null){ return ;}
    	
    	onSelect(note) ;
    	
    	$dialog.close() ;
    }
    
    function spf_update()
    {  
    	var row = $grid.getSelectedRow();
		
        if (!row || row.length == 0) { 
	       	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	    	 return ; 
	    } 

    	$dialog = $.ligerDialog.open({isDrag: false, 
   		    title:'<spring:message code="hrms.update"/>', 
    		width: 1100, 
    		height: 510, 
    		url: '/att/attendanceSettings/upadteItemParameterInfo?AR_PARAM_NO=' + row.AR_PARAM_NO
        	  });

    }

    function spf_delete()
    { 
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){
		        var row = $grid.getSelectedRow();
		    	var note = $tree.getSelected();
		
		        if (!row || row.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        } 
		
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/att/attendanceSettings/deleteItemParameterInfo", 
		                [	
		                 	{ name: 'AR_PARAM_NO', value: row.AR_PARAM_NO  }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', function ()
		                {
		                	onSelect(note) ; //加载数据
		                });
		            }
		            else
		            {
		                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
		            }
		        });
            }
        });
    }
    
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" >
            <div position="left" id="parentCode" class="l-scroll" style="height:95%;overflow:auto;" title='<spring:message code="hrms.basicCode"/>'>
	            <!--不带复选框-->
			    <ul id="itemTree">
			    	<c:forEach items="${itemInfoList}" var="itemInfo" varStatus="i">
			    		<c:if test="${i.index == 0}" >
			    			<li url="${itemInfo.ITEM_NO}" isexpand="false" >
					            <span >${itemInfo.ITEM_NAME}</span>
					            <ul>
			    		</c:if>
			    		
			    		<c:if test="${i.index != 0 && itemInfo.DEPTH == 0}" >
					            </ul>
					        </li> 
			    			<li url="${itemInfo.ITEM_NO}" isexpand="false">
					            <span >${itemInfo.ITEM_NAME}</span>
					            <ul>
			    		</c:if>
			    		
			    		<c:if test="${itemInfo.DEPTH != 0}" >
			    			<li url="${itemInfo.ITEM_NO}" ><span >${itemInfo.ITEM_NAME}</span></li>
			    		</c:if>
			    		
			    	</c:forEach>
						    </ul>
						 </li>
			    </ul>
            
            </div>
            <div position="center" id='itemParameterInfo' title='<spring:message code="hrms.detailCode"/>' >
            	
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
	                    <SipingSoft:button/>     
					</td>
	           </tr>  
       		</table> 
            	<div id="itemParameterInfoList" ></div>
        	</div> 
       </div>
</body>
</html>
