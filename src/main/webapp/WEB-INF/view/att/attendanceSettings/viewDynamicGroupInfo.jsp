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
    <script src="/resources/js/ligerUI/js/plugins/ligerSpinner.js" type="text/javascript"></script>  
    <script src="/resources/js/json2.js" type="text/javascript"></script>
	    
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
 
    <script type="text/javascript">
    
    var $grid ;
    var $dialog ;
    var $activitySelectList ; 
    var $companySelectList ; 
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
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );

        $activitySelectList = getActivitySelectList() ;
        $companySelectList = getCompanySelectList() ; 
        f_initGrid();
 
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
    
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: false,
            columns: [
                      { display: '<spring:message code="hrms.sequence"/>', name: 'GROUP_NO',width: 120},
                      { display: '<spring:message code="hrms.chineseName"/>', name: 'GROUP_NAME', editor: { type: 'text' }},
                      { display: '<spring:message code="hrms.englishName"/>', name: 'GROUP_EN_NAME', editor: { type: 'text' }},
                      { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION', align: 'left',width: 320,editor: { type: 'textarea', height: 100 }},
                      { display: '<spring:message code="hrms.active"/>', name: 'STATUS_ID', align: 'center',width: 135,isSort: false,
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
      		        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_ID', align: 'center',width: 135,isSort: false,
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
            usePager: true,enabledEdit: true,
            url: '/att/attendanceSettings/getDynamicGroupInfoList',
            width: '99.6%', height: '100%',
            showTitle: false,width:'99.6%',columnWidth:180,
            detail: { onShowDetail: spf_showDetailData,height:'auto' }
        });
    }
  
    function spf_showDetailData(row, detailPanel,callback)
    {	
        var grid = document.createElement('div'); 
        $(detailPanel).append(grid);
        $(grid).css('margin',10).ligerGrid({
            columns:
                        [
                      	{ display: '<spring:message code="hrms.empid"/>', name: 'EMPID'},
			            { display: '<spring:message code="hrms.name"/>', name: 'CHINESENAME'}, 
			            { display: '<spring:message code="hrms.dept"/>', name: 'DEPTNAME'},
			            { display: '<spring:message code="hrms.EmpStatus"/>', name: 'STATUS_NAME'}
                        ], 
                        usePager: true,rownumbers: true,
                        isScroll: false, showToggleColBtn: false, width: '90%',
                        url: '/att/attendanceSettings/getDynamicGroupEmpInfo', 
            			parms: [{ name: 'GROUP_NO', value: row.GROUP_NO},
            			        { name: 'keyWord', value: $("#keyWord").attr('value')},
            	        		{ name: 'DEPTID', value: $("#DEPTID").attr('value')}
            	        	],
                        showTitle: false, columnWidth: 220, 
             			onAfterShowData: callback,allowUnSelectRow:true
        });
    }
  
    function spf_search()
    {  
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'keyWord', value: $("#keyWord").val()},   
    	                        	{ name: 'DEPTID', value: $("#DEPTID").val()}
    	                           ],
    	                   newPage: 1
    	                 });  //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据
    	//$dialog.close() ;
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
				
		        $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
		        $.post("/att/attendanceSettings/deleteDynamicGroupInfo", 
		                [	
		                 	{ name: 'GROUP_NO', value: rows.GROUP_NO }
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
    
    
    function spf_add()
    {
    	$grid.addRow(); 
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
    		height: 475, 
    		url: '/att/attendanceSettings/updateDynamicGroupInfo?GROUP_NO=' + rows.GROUP_NO
       	  });
    }
    function spf_save()
    {  
        var data = $grid.getData(); 
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/att/attendanceSettings/addAndUpdateDynamicGroupInfo", 
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
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }  
    </style>
</head>
<body style="padding:2px" > 
	<div id="layout1" > 
     <div align="left" position="center" id='' title=' ' >
	  <div align="left">
	  	 <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
	           <tr> 
	               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
	           	   <td class="l-table-edit-c">
		       	   		<input type="text" name="keyWord" id="keyWord" />
		       	   </td>  
	                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
	                <td class="l-table-edit-c">
	                	<SipingSoft:deptTree name="DEPTID" limit="hr"/>
	                </td>  
                </tr> 
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
	                    <SipingSoft:button/>     
					</td>
	           </tr>  
       		</table> 
	  </div>
      <div position="center" id='empInfo' ></div>
     </div>
 </div>        
</body>
</html>
