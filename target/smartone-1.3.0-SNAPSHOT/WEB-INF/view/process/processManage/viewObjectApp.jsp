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
	<script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
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
	function searchEmp(){
	   	 $dialog = $.ligerWindow.show({isDrag: false, 
			    title:'<spring:message code="employee.information"/>',
	      	 	width: 800 , 
	      	 	height: 400 , 
	      	 	left:160,top:90,
	  		    url: '/utility/empInfo/viewHrSearchEmployee'
	      	  });
	   }
    function f_initGrid()
    {
    	$grid = $("#empInfo").ligerGrid({
    		checkbox: true,
    		columns: [   
			            { display: '', name: 'OBJECT_TYPE_ID', width: 10,hide: 1},
			            { display: '', name: 'OBJECT_STATUS_ID', width: 10,hide: 1},
			            { display: '审核号', name: 'PROCESS_NO', width: 50},
			            { display: '审核对象', name: 'OBJECT_ID', width: 120},
			            { display: '对象类型', name: 'OBJECT_TYPE', width: 100},
			            { display: '对象状态', name: 'OBJECT_STATUS', width: 100},
			            { display: '提交时间', name: 'CREATE_DATE', width: 140},  
			            { display: '审批人', name: 'AFFIRMOR_NAME', width: 140},  
			            { display: '<spring:message code="hrms.approvalActive"/>', name: 'APP_STATUS', width: 100,
			            	render: function (item)
		                    { 
		                        if( item.AFFIRM_FLAG == 0){   //待审批 
			        	        	return '<img style="cursor: pointer;" src="/resources/images/0.gif" onclick="spf_reject(2,4);" >' + '&nbsp;&nbsp;&nbsp;&nbsp;' + '<img style="cursor: pointer;" src="/resources/images/1.gif" onclick="spf_approve(1,4)" >';
			            	    } else if( item.AFFIRM_FLAG == 1){
			            	    	return '已通过';
			            	    } else if( item.AFFIRM_FLAG == 2){
			            	    	return '已否决';
			            	    }
		                    } 
			            },
			            { display: '<spring:message code="hrms.approvalRemarks"/>', name: 'APP_REMARK', align: 'left', width: 220,
			            	editor: { type: 'textarea', height: 100 }
			            }
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            url: '/process/processManage/getAffirmObjectInfo',
            parms: [	
                   ],
            width: '99.6%', height: '100%',
            onDblClickRow: function(rowdata, rowindex, rowDomElement){ 
           	 	spf_showDetailData(rowdata.OBJECT_ID, rowdata.PROCESS_NO);
            }
        });
    }
    function spf_showDetailData(OBJECT_ID,PROCESS_NO)
    {    
    	$dialog = $.ligerDialog.open({isDrag: false, 
    		title:'<spring:message code="hrms.approvalActive"/>', 
    		width: 700, 
    		height: 320, 
  		    url: '/process/processManage/viewApproverInfo?OBJECT_ID='+OBJECT_ID+'&PROCESS_NO='+PROCESS_NO+''
       	  });
    }
    function spf_search()
    {
    	$grid.setOptions({ parms: [	
	   	                        	{ name: 'keyWord', value: $("#keyWord").attr('value')}, 
		                        	{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
		                        	{ name: 'E_DATE', value: $("#E_DATE").attr('value')}, 
		                        	{ name: 'AFFIRMOR_ID', value: $("#AFFIRMOR_ID").attr('value')},
		                        	{ name: 'PARENT_TYPE_ID', value: $("#PARENT_TYPE_ID").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
    }

    function f_ChildWindowClose (){
    	$grid.loadData(true); //加载数据 
    }
    function spf_reject(flag,tag){ 
    	spf_approve(flag,tag);
    }
    function spf_approve(flag,tag)
    {     
        var	rows = $grid.getCheckedRows(); 
   	    var jsonData = '' ;
        if (!rows || rows.length == 0) { 
       	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
       		 return ; 
        } 
  
    	jsonData = '[' ;
 		$(rows).each(function (index, row)
 	    { 
 		    	       
  		    if (jsonData.length > 1){
             	jsonData += ',{' ;
            }
            else{
            	jsonData += '{' ;
            } 
            jsonData += ' "OBJECT_ID": "' + this.OBJECT_ID + '", ' ;
            jsonData += ' "PROCESS_NO": "' + this.PROCESS_NO + '", ' ;
            if(this.APP_REMARK!='undefined'&&this.APP_REMARK!=''&&this.APP_REMARK!=null){
           	 jsonData += ' "APP_REMARK": "' + this.APP_REMARK + '", ' ; 
            }
            jsonData += ' "AFFIRM_FLAG": "' + flag + '" ' ;
            jsonData += '}' ; 
 		           
 	        }); 
 	    	jsonData += ']' ;
 	     	var jsonList = eval("(" + jsonData + ")");
    	    
 	    	if(jsonData.length == 2 || jsonData.length == 0){ 
 	            return ;
 	        }
 	    	if(jsonList.length == rows.length){ 
 	            $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
 	            $.post("/process/processManage/affirmApp", 
 	                    [	
 	                     	{ name: 'jsonData', value: jsonData }
 	                    ]
 	            , function (result)
 	            {
 	            	$.ligerDialog.closeWaitting();
 	                if (result.flag == "Y")
 	                {
 	                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
 	                    {
 	                       	$grid.loadData(true); //加载数据  
 	                    });
 	                } else if(result.flag == "N"){
 	                	$rejDialog = $.ligerDialog.open({isDrag: false, 
 	             			title:'选择跳转状态', 
 	             			width: 700, 
 	             			height: 320, 
 	             			buttons: [
 	             		            { text: '确定', onclick: spf_confirm }
 	             		        	],
 	           		   	 	url: '/process/processManage/selectRejectStatus?rejectedObjects='+JSON.stringify(result.rejectedObjects)
 	                	});
 	                }else
 	                {
 	                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result.flag);
 	                }
 	            });
 	        }
   		  
    } 
 		
 	var spf_confirm = function(){
 		var func = $rejDialog.frame.spf_confirm || $rejDialogialog.frame.window.spf_confirm;
 		func();
 	}
 	var closeRejDialog = function(){
 		$rejDialog.close();
 		$grid.loadData(true);
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
	               <td width="15%" class="l-table-edit-t">
	               		<spring:message code="keyWord"/></td>
	               <td width="35%" class="l-table-edit-c">
	               		<input name="keyWord" type="text" id="keyWord" size="30"/></td>
	               <td width="15%" class="l-table-edit-t">审核人</td>
	               <td width="35%" class="l-table-edit-c"> 
          	            <c:if test="${isSupervisor}">
	       	   				<input type="text" name="AFFIRMOR_ID" id="AFFIRMOR_ID" value="${basicInfo.EMPID }" onclick="searchEmp();"/>
          	            </c:if>
          	            <c:if test="${!isSupervisor}">${basicInfo.EMPID }
	       	   				<input type="hidden" name="AFFIRMOR_ID" id="AFFIRMOR_ID" value="${basicInfo.EMPID }"/>
          	            </c:if>
	               	</td>
	           </tr> 
	           <tr> 
	               <td  class="l-table-edit-t">创建日期</td>
	               <td  class="l-table-edit-c">
				      	 <input type="text" name="S_DATE" id="S_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/>  
						   ~             	 
				      	 <input type="text" name="E_DATE" id="E_DATE" 
						                	 value="" size="30"
						                	 onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"  
						                	 readonly="readonly"/> 
	               </td> 
		       	   <td class="l-table-edit-t">Object类型</td>
	           	   <td class="l-table-edit-c">
						<SipingSoft:selectObjectType name="PARENT_TYPE_ID" parentTypeID="SPERP" onChange="spf_search()" limit="all"/>
		       	   </td>
	           </tr> 
	       </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" height="30"> 
	           <tr>
	                <td align="left"> 
	                    <SipingSoft:button/> 
	                    <SipingSoft:buttonCon/>
					</td>
	           </tr>  
       		</table> 
	  </div> 
      	<div position="center" id='empInfo'></div>
  </div>
</div>
</body>
</html>