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
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>  
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $dialog ; 
    var $activitySelectList ; 
    var $postGradeSelectList ; 
    
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
        $postGradeSelectList = getPostGradeSelectList() ; 
        
        f_initGrid() ;
    });
 	
    function getPostGradeSelectList(){
    	//请求服务器
    	var postGradeSelectList ;
        $.ajax({
            type: 'post',
            url: '/utility/otherInfo/getPostGradeSelectList', 
            dataType: 'json',
            async: false,
            success: function (list)
            {  
            	postGradeSelectList = list ;
            }
        });
        return postGradeSelectList ;
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
	            { display: '<spring:message code="hrms.primaryKey"/>', name: 'POSITION_NO',align: 'center', type: 'int',hide:1},
	            { display: '<spring:message code="hrms.basicCode"/>', name: 'POSITION_ID', align: 'center'},
	            { display: '<spring:message code="hrms.chineseName"/>', name: 'POSITION_NAME', align: 'center', editor: { type: 'text' }},
	            { display: '<spring:message code="hrms.englishName"/>', name: 'POSITION_EN_NAME', align: 'center', editor: { type: 'text' }},
	            { display: '<spring:message code="hrms.postGrade"/>', name: 'POST_GRADE_ID', align: 'center',isSort: false,
                    editor: { 
                    	type: 'select', data: $postGradeSelectList, dataValueField: 'POST_GRADE_ID',dataDisplayField: 'POST_GRADE_NAME', 
                    	displayColumnName: 'POST_GRADE_NAME', valueColumnName: 'POST_GRADE_ID'
                    }, render: function (item)
	                {
	                    for (var i = 0; i < $postGradeSelectList.length; i++)
	                    {
	                        if ($postGradeSelectList[i]['POST_GRADE_ID'] == item.POST_GRADE_ID)
	                            return $postGradeSelectList[i]['POST_GRADE_NAME']
	                    }
	                    return item.POST_GRADE_NAME;
	                }
		        },
		        { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left', editor:{type:'textarea', height: 100}},
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
		        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME', align: 'center',isSort: false}
            ],
            usePager: true, enabledEdit: true,rownumbers: true,
            url: '/hrm/position/getPositionInfo',
            width: '99.6%', height: '100%'
        });
    }

    function spf_save(){ 
         
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/hrm/position/updatePositionInfo", 
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
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()},
    	                        	{ name: 'POST_GRADE_ID', value: $("#POST_GRADE_ID").val()}
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
		        $.post("/hrm/position/deletePositionInfo", 
		                [	
		                 	{ name: 'POSITION_NO', value: rows.POSITION_NO },
		                 	{ name: 'POSITION_ID', value: rows.POSITION_ID }
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
    	$dialog = $.ligerDialog.open({isDrag: false, title:'<spring:message code="hrms.add"/>', 
    		 width: 820, height: 280, url: '/hrm/position/addPositionInfo'
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
	               <td class="l-table-edit-t"><spring:message code="hrms.postGrade"/></td>
	           	   <td class="l-table-edit-c">
		       	   		<SipingSoft:selectPostGrade name="POST_GRADE_ID" limit="all" onChange="spf_search()"/>
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
