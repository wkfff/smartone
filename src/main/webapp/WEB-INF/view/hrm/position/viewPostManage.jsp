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
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $dialog ; 
    var $activitySelectList ; 
    var $postGroupSelectList ; 
    var $positionSelectList ; 
    
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
        	topHeight: 60,
            allowTopResize: false       //是否允许 头部可以调整大小
        }); 
         
        $activitySelectList = getActivitySelectList() ;
        $postGroupSelectList = getPostGroupSelectList() ; 
        $positionSelectList = getPositionSelectList() ; 
        
        f_initGrid() ;
    });

    function getPositionSelectList(){
    	//请求服务器
    	var postSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPositionSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	positionSelectList = list ;
            }
        });

        return positionSelectList ;
    }
    
    function getPostGroupSelectList(){
    	//请求服务器
    	var postGroupSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPostGroupSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	postGroupSelectList = list ;
            }
        });

        return postGroupSelectList ;
    }
   
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
    
    function f_initGrid()
    { 
    	$grid = $("#gridInfo").ligerGrid({
    		checkbox: false,
            columns: [
	            { display: '<spring:message code="hrms.primaryKey"/>', name: 'POST_NO', width: 90,align: 'center', type: 'int',hide:1},
	            { display: '<spring:message code="hrms.basicCode"/>', name: 'POST_ID',width:90, align: 'center'},
	            { display: '<spring:message code="hrms.chineseName"/>', name: 'POST_NAME',width:120, align: 'center', editor: { type: 'text' }},
	            { display: '<spring:message code="hrms.englishName"/>', name: 'POST_EN_NAME',width:120, align: 'center', editor: { type: 'text' }},
		        { display: '<spring:message code="hrms.position"/>', name: 'POSITION_ID',width:90, align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $positionSelectList, dataValueField: 'POSITION_ID',dataDisplayField: 'POSITION_NAME', 
                    	displayColumnName: 'POSITION_NAME', valueColumnName: 'POSITION_ID'
                    }, render: function (item)
	                {
	                    for (var i = 0; i < $positionSelectList.length; i++)
	                    {
	                        if ($positionSelectList[i]['POSITION_ID'] == item.POSITION_ID)
	                            return $positionSelectList[i]['POSITION_NAME']
	                    }
	                    return item.POSITION_NAME;
	                }
		        },  
	            { display: '<spring:message code="hrms.postGroup"/>', name: 'POST_GROUP_ID',width:100, align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $postGroupSelectList, dataValueField: 'POST_GROUP_ID',dataDisplayField: 'POST_GROUP_NAME', 
                    	displayColumnName: 'POST_GROUP_NAME', valueColumnName: 'POST_GROUP_ID'
                    }, render: function (item)
	                {
	                    for (var i = 0; i < $postGroupSelectList.length; i++)
	                    {
	                        if ($postGroupSelectList[i]['POST_GROUP_ID'] == item.POST_GROUP_ID)
	                            return $postGroupSelectList[i]['POST_GROUP_NAME']
	                    }
	                    return item.POST_GROUP_NAME;
	                }
		        },  
		        { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left',width:150, editor:{type:'textarea', height: 100}}, 
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
		        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME',width:90, align: 'center',isSort: false}
            ],
            usePager: true, enabledEdit: true,
            showTitle: false,
            detail: { onShowDetail: spf_showDetailLevelData,height:'auto' },
            url: '/hrm/position/getPostInfo',
            width: '99.6%', height: '100%'
        });
    }

    function spf_showDetailLevelData(row, detailPanel,callback){	
		var grid = document.createElement('div'); 
		$(detailPanel).append(grid);
		$(grid).css('margin',10).ligerGrid({
			columns:[
				{ display: '职位等级', name: 'POST_GRADE_NAME',width:90 },
				{ display: '基本工资标准', name: 'BASIC_SALARY' ,width:120},
				{ display: '月度考核工资', name: 'KPI_SALARY',width:120}
			], 
			usePager: false,rownumbers: true,
			isScroll: false, showToggleColBtn: false, width: '90%',
			url: '/hrm/position/getPostLevelDataInfo', 
			parms: [{ name: 'POST_ID', value: row.POST_ID}],
			showTitle: false, columnWidth: 360, 
			onAfterShowData: callback,allowUnSelectRow:true
		});
	}
    
    function spf_save(){ 
         
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/position/updatePostInfo", 
                [	
                 	{ name: 'jsonData', value: JSON2.stringify(data)}
                 ]
        , function (result)
        {
       
        	$.ligerDialog.closeWaitting();
            if (result == "Y")
            {
                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
                {
                	$grid.loadData(true);
                });
            }
            else
            {
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        });
        
    }
    
    function spf_search()
    {     
    	$grid.setOptions({ parms: [
									{name:'keyWord',value : $("#keyWord").val()}, 
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()},
    	                        	{ name: 'POST_GROUP_ID', value: $("#POST_GROUP_ID").val()},
    	                        	{ name: 'POSITION_ID', value: $("#POSITION_ID").val()}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    }
  
    
    function spf_delete()
    {
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
 ; 
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/hrm/position/deletePostInfo", 
		                [	
		                 	{ name: 'POST_NO', value: rows.POST_NO },
		                 	{ name: 'POST_ID', value: rows.POST_ID }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function ()
		                {
		                	$grid.loadData(true); //加载数据
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
    
     function spf_add(){ 

    	$dialog = $.ligerDialog.open({isDrag: false, 
    		 title:'<spring:message code="hrms.add"/>', 
    		 width: 800, height: 260, 
    		 url: '/hrm/position/addPostInfo'
       	  });
    }
     
     function spf_update(){
 		var rows = $grid.getSelectedRow(); 
 		if (!rows || rows.length == 0) { 
 			$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
 			return ; 
 		}
 		if (rows.length > 1){
 			alert('<spring:message code="hrms.onlyOneRow"/>'); return;
 		}
 		$dialog = $.ligerDialog.open({isDrag: false, 
 			title:'<spring:message code="hrms.update"/>', 
 			width: 900, 
 			height: 450, 
 			url: '/hrm/position/updatePostLevelDataInfo?POST_ID=' + rows.POST_ID
 		});
 	}
     
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" >
<div id="layout1" > 
     <div position="center" id='' title=' ' >
	 <div position="top"> 
		    <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr>
					<td class="l-table-edit-t" width="20%">
						<spring:message code="keyWord"/></td>
					<td class="l-table-edit-c" width="30%">
						<input width="120" type="text" name="keyWord" id="keyWord" /></td>
	           	   <td class="l-table-edit-t" width="20%">
	           	   		<spring:message code="hrms.position"/></td>
	           	   <td class="l-table-edit-c" width="30%">
		       	   		<SipingSoft:selectPosition name="POSITION_ID" limit="all" onChange="spf_search()"/>
		       	   </td>
		       </tr>
		       <tr>
	               <td class="l-table-edit-t"><spring:message code="hrms.postGroup"/></td>
	           	   <td class="l-table-edit-c">
		       	   		<SipingSoft:selectPostGroup name="POST_GROUP_ID" limit="all" onChange="spf_search()"/>
		       	   </td>
		       	   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
	           	   <td class="l-table-edit-c">
						<SipingSoft:selectStatus name="ACTIVITY" limit="all" onChange="spf_search()"/>
		       	   </td>
	           </tr>  
	       </table> 
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	               <td colspan="6" height="30px">
	                    <SipingSoft:button/>
	               </td>
	           </tr> 
	       </table> 
	  </div>
      <div position="center" id='gridInfo'></div>
	  </div>     	
</div>       
</body>
</html>
