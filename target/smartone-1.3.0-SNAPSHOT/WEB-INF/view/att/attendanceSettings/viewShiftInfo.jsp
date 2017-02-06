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
    var $activitySelectList ; 
    var $companySelectList ; 
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
        $activitySelectList = getActivitySelectList() ;
        $companySelectList = getCompanySelectList() ; 
         f_initGrid();
         
    });
	//扩展一个 多行文本框 的编辑器
	$.ligerDefaults.Grid.editors['textarea'] = {
		create: function(container, editParm) {
			var input = $("<textarea class='l-textarea' />");
			container.append(input);
			return input;
		},
		getValue: function(input, editParm) {
			return input.val();
		},
		setValue: function(input, value, editParm) {
			input.val(value);
		},
		resize: function(input, width, height, editParm) {
			var column = editParm.column;
			if (column.editor.width) input.width(column.editor.width);
			else input.width(width);
			if (column.editor.height) input.height(column.editor.height);
			else input.height(height);
		}
	};
    function spf_initGrid()
    {
    	$grid = $("#shiftParameterInfo").ligerGrid({
            columns: [
            { display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME',width:120},
            { display: '<spring:message code="hrms.startDate"/>', name: 'BEGIN_DAY_OFFSET_NAME',width:120},
            { display: '<spring:message code="hrms.startedTime"/>', name: 'FROM_TIME',width:120},
            { display: '<spring:message code="hrms.endDate"/>', name: 'END_DAY_OFFSET_NAME',width:120},
            { display: '<spring:message code="hrms.endTime"/>', name: 'TO_TIME',width:120}
            ],
            enabledEdit: false, usePager: false,
            width: '99.6%', height: '100%',
            heightDiff : 0
        });
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
    function f_initGrid()
    {
    	$grid = $("#shiftInfo").ligerGrid({
            columns: [
            { display: '<spring:message code="hrms.primaryKey"/>', name: 'SHIFT_NO',width:0,hide:1},
            { display: '<spring:message code="hrms.workingShift.code"/>', name: 'SHIFT_ID',width:0,hide:1}, 
            { display: '<spring:message code="hrms.chineseName"/>', name: 'SHIFT_NAME',width:160, editor: { type: 'text' }}, 
            { display: '<spring:message code="hrms.englishName"/>', name: 'SHIFT_EN_NAME',width:160, editor: { type: 'text' }}, 
            { display: '<spring:message code="hrms.description"/>', name: 'DESCR',width:260,
            	editor: {type: 'textarea',height: 100}
            }, 
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',width: 120,isSort: false,
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
            }
            ],
            enabledEdit: true, usePager: true,
            url: '/att/attendanceSettings/getShiftInfoList',
            width: '99.6%', height: '100%',
            showTitle: false,width:'99.6%',
            detail: { onShowDetail: spf_showDetailData,height:'auto' }
        });
    }
    
    function spf_showDetailData(row, detailPanel,callback){	
        var grid = document.createElement('div'); 
        $(detailPanel).append(grid);
        $(grid).css('margin',10).ligerGrid({
            columns:[
				{ display: '<spring:message code="hrms.attItemName"/>', name: 'ITEM_NAME',width:120},
				{ display: '<spring:message code="hrms.startDate"/>', name: 'BEGIN_DAY_OFFSET_NAME',width:120},
				{ display: '<spring:message code="hrms.startedTime"/>', name: 'FROM_TIME',width:120},
				{ display: '<spring:message code="hrms.endDate"/>', name: 'END_DAY_OFFSET_NAME',width:120},
				{ display: '<spring:message code="hrms.endTime"/>', name: 'TO_TIME',width:160}
			], 
            usePager: false,rownumbers: true,
            isScroll: false, showToggleColBtn: false, width: '90%',
            url: '/att/attendanceSettings/getShiftParameterInfo', 
            parms: [{ name: 'SHIFT_NO', value: row.SHIFT_NO}],
            showTitle: false, columnWidth: 360, 
            onAfterShowData: callback,allowUnSelectRow:true
        });
    }
    
    function spf_add()
    {
    	$grid.addRow(); 
    }
    
    function spf_save()
    {  
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/att/attendanceSettings/addAndUpdateShiftInfo", 
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
    function f_ChildWindowClose (){ 
    	$grid.loadData(true); //加载数据
    	$dialog.close() ;
    }
    function spf_update()
    { 
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
    		url: '/att/attendanceSettings/updateShiftInfo?SHIFT_NO=' + rows.SHIFT_NO
       	  });
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
		        	 $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.onlyOneRow"/>') ; 
		        	 return ;  
		         } 
				
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/att/attendanceSettings/deleteShiftInfo", 
		                [	
		                 	{ name: 'SHIFT_NO', value: rows.SHIFT_NO }
		                ]
		        , function (result)
		        {
		        	$.ligerDialog.closeWaitting();
		            if (result == "Y")
		            {
		                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>', '<spring:message code="hrms.warning"/>',function ()
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
    
	</script>
<style type="text/css"> 
	body{ padding:5px; margin:0; padding-bottom:15px;}
	#layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding: 2px">
	<div id="layout1">
		<div align="left" position="center" id='' title=' '>
			<div align="left">
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /></td>
					</tr>
				</table>
				<div id="shiftInfo"></div>
			</div>
		</div>
	</div>
</body>
</html>
