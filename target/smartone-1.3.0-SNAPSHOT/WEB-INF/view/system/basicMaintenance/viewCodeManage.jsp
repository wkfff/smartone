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
    <script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script>
        
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $tree ; 
    var $activitySelectList ; 
    var $companySelectList ; 
    // 初始调用
    $(function ()
    {
        //布局
         $("#layout1").ligerLayout({ leftWidth: 180});

         $tree = $("#parentTree").ligerTree(
	          { 
		          checkbox: false,
	              onSelect: onSelect
	          }
          );

        $activitySelectList = getActivitySelectList() ;
        $companySelectList = getCompanySelectList() ;
        spf_initGrid();

    });

    function getActivitySelectList(){
    	//请求服务器
    	var activitySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getActivitySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		activitySelectList = list ;
            }
        });   
        return activitySelectList ;
    }
    
    function getCompanySelectList(){
    	//请求服务器
    	var companySelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getCompanySelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
        		companySelectList = list ; 
            }
        });

        return companySelectList ;
    } 


    function onSelect(note)
    {       
 		 $.ajax({
	       	type:'post',
	       	cache:false,
	       	contentType:'application/json',	             	
	       	url:'/system/basicMaintenance/getCodeListByParentCode?parentCode=' + note.data.url,            	
	       	dataType:'json',
	       	success:function(response){ 
	        		var jsonObj = {};
	               jsonObj.Rows = response ;
	     		   $grid.setOptions({ data : jsonObj }); //设置数据参数
	               $grid.loadData(true); //加载数据
	       	}          	
      	}); 
    }

    function spf_initGrid()
    {
    	$grid = $("#codeList").ligerGrid({
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'CODE_NO', width: 90, type: 'int' },
            { display: '<spring:message code="hrms.basicCode"/>', name: 'CODE_ID', align: 'left',editor: { type: 'text' }},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'CODE_NAME', align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.englishName"/>', name: 'CODE_EN_NAME', align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left', editor: { type: 'text' }},
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $activitySelectList, dataValueField: 'STATUS_ID',dataDisplayField: 'STATUS', 
                    	displayColumnName: 'STATUS', valueColumnName: 'STATUS_ID'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $activitySelectList.length; i++)
                        {
                            if ($activitySelectList[i]['STATUS_ID'] == item.STATUS_ID)
                                return $activitySelectList[i]['STATUS']
                        }
                        return item.STATUS;
                    }
		        },  
		        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_ID', align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $companySelectList, dataValueField: 'CPNY_ID',dataDisplayField: 'CPNY_NAME',
                    	displayColumnName: 'CPNY_NAME', valueColumnName: 'CPNY_ID'
                    }, render: function (item)
                    {
                        for (var i = 0; i < $companySelectList.length; i++)
                        {
                            if ($companySelectList[i]['CPNY_ID'] == item.CPNY_ID)
                                return $companySelectList[i]['CPNY_NAME']
                        }
                        return item.CPNY_NAME;
                    }
		        }
            ],
            enabledEdit: true, usePager: true,rownumbers: true,
            width: '99.6%', height: '100%',
            heightDiff : 1
        });
    }  
    function spf_search()
    {      
    	$grid.setOptions({ parms: [
    	                        	{ name: 'CPNY_ID', value: $("#CPNY_ID").val()},
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()}
    	                           ],
    	                  newPage: 1
    	                }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_save()
    {
    	var note = $tree.getSelected(); 
    	if (note == null){ return ;}
         
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/system/basicMaintenance/saveAndUpdateCodeInfo", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)},
                 	{ name: 'parentCode', value: note.data.url}
                 ]
        , function (result)
        {
       
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$grid.loadData(true);
                	 onSelect(note) ;
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
    }
    function spf_delete()
    {      
    	var note = $tree.getSelected(); 
    	$.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
        	if(yes){
		     	 var rows = $grid.getSelectedRow(); 
		         
		         if (!rows || rows.length == 0) { 
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
		        	 return ; 
		        }
		         if (rows.length > 1){
		         	alert('<spring:message code="hrms.onlyOneRow"/>'); return;
		         }
  
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/system/basicMaintenance/deleteCodeInfo", 
		                [	
		                 	{ name: 'CODE_NO', value: rows.CODE_NO },
		                 	{ name: 'CODE_ID', value: rows.CODE_ID }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            { 
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		                {
		                	$grid.loadData(true); //加载数据 
		                	onSelect(note) ;
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
    
    function spf_add()
    {
    	$grid.addRow();
    }
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px"> 
      <div id="layout1" >
            <div align="left" position="left" id="parentCode" class="l-scroll" style="height:95%;overflow:auto;" title='<spring:message code="hrms.basicCode"/>'>
	           <c:set var="parentSize" value="${fn:length(parentCodeList)}" />
	            <!--不带复选框-->
			    <ul id="parentTree">
					
			    	<c:forEach items="${parentCodeList}" var="parentCode" varStatus="i">
			    		<c:if test="${i.index == 0}" >
			    			<li url="${parentCode.CODE_ID}" isexpand="false" >
					            <span >${parentCode.CODE_NAME}</span>
					            <ul>
			    		</c:if>
			    		
			    		<c:if test="${i.index != 0 && parentCode.DEPTH == 0}" >
					            </ul>
					        </li> 
			    			<li url="${parentCode.CODE_ID}" isexpand="false">
					            <span >${parentCode.CODE_NAME}</span>
					            <ul>
			    		</c:if>
			    		
			    		<c:if test="${parentCode.DEPTH != 0}" >
			    			<li url="${parentCode.CODE_ID}" ><span >${parentCode.CODE_NAME}</span></li>
			    		</c:if>
			    		
			    	</c:forEach>
						    </ul>
						 </li>
			    </ul>
            
            </div>
            <div align="left" position="center" id='codeInfo' title='<spring:message code="hrms.detailCode"/>' >
          
            
            <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30px;"> 
	           <tr>
	                <td align="left">
	                <SipingSoft:button/>  
				</td>
	           </tr>  
	       </table>
            	<div id="codeList" ></div>
        	</div> 
    </div>
</body>
</html>
