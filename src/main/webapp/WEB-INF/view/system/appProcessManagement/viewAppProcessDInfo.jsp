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
    <script src="/resources/js/ligerUI/js/plugins/ligerCheckBox.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerResizable.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerDrag.js" type="text/javascript"></script> 
    <script src="/resources/js/ligerUI/js/plugins/ligerDialog.js" type="text/javascript"></script> 
    <script src="/resources/js/json2.js" type="text/javascript"></script> 
	<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script> 
    
      
    <script type="text/javascript">
    
    var $grid ;
    var $dialog ;
    // 初始调用
    $(function ()
    {
    	//布局
        $("#layout1").ligerLayout({
    	        topHeight:90,
	            allowLeftResize: false,      //是否允许 左边可以调整大小
	            allowRightResize: false,     //是否允许 右边可以调整大小
	            allowTopResize: false,      //是否允许 头部可以调整大小
	            allowBottomResize: false     //是否允许 底部可以调整大小
            }
          );
        
         f_initGrid();
 
    });

    function f_initGrid()
    {
    	$grid = $("#loginUserInfo").ligerGrid({
    		checkbox: false,
            columns: [
            { display: '<spring:message code="hrms.basicCode"/>', name: 'DEPTID',width:90},
            { display: '<spring:message code="hrms.chineseName"/>', name: 'DEPTNAME',id: 'id2',width:180, align: 'left'},
            { display: '<spring:message code="hrms.englishName"/>', name: 'DEPT_EN_NAME',width:220, align: 'left'},
            { display: '<spring:message code="hrms.location"/>', name: 'AREA',width:90},
            { display: '<spring:message code="hrms.description"/>', name: 'DESCRIPTION',width:250, align: 'left'}, 
            { display: '<spring:message code="hrms.active"/>', name: 'STATUS',width:90},  
	        { display: '<spring:message code="hrms.company"/>', name: 'CPNY_NAME',width:90},
	        { display: '<spring:message code="hrms.setApprover"/>', name: 'SET_APP_NAME',width:90}
            ],
            usePager: true, dataAction: 'server', root: 'appProcessDList', record: 'appProcessDCnt',
            url: '/system/appProcessManagement/getAppProcessDInfo',
            width: '99.6%', height: '100%',
            showTitle: false,width:'99.6%',columnWidth:160, 
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
                         { display: '<spring:message code="hrms.approvalType"/>', name: 'AFFIRM_TYPE_NAME' , align: 'center'}, 
         				 { display: '<spring:message code="hrms.approvalType"/>', name: 'AFFIRM_TYPE_ID',hide:1}, 
         				 { display: '<spring:message code="hrms.approvalType"/>', name: 'DEPTID',hide:1},
                         { display: '<spring:message code="hrms.1level"/>', name: 'NAME1', align: 'center'},  
             	         { display: '<spring:message code="hrms.2level"/>', name: 'NAME2', align: 'center'},
             	         { display: '<spring:message code="hrms.3level"/>', name: 'NAME3', align: 'center'},
             	         { display: '<spring:message code="hrms.4level"/>', name: 'NAME4', align: 'center'},
             	         { display: '<spring:message code="hrms.5level"/>', name: 'NAME5', align: 'center'},
             	         { display: '<spring:message code="hrms.6level"/>', name: 'NAME6', align: 'center'}
                        ], 
                        usePager: false,rownumbers: true, dataAction: 'server', root: 'appProcessDAList',
                        isScroll: false, showToggleColBtn: false, width: '90%',
                        url: '/system/appProcessManagement/getAppProcessDAInfo?DEPTID='+row.DEPTID , 
                        showTitle: false, columnWidth: 100, 
             			onAfterShowData: callback,allowUnSelectRow:true,
                        onSelectRow: function (data, rowindex, rowobj)
                        { 
                            spf_delete(data.DEPTID,data.AFFIRM_TYPE_ID)
                        }
        });
    }
    function spf_search()
    {  
    	$grid.setOptions({ parms: [	
    	                        	{ name: 'DEPTID', value: $("#DEPTID").val()},
    	                        	{ name: 'keyWord', value: $("#keyWord").val()}, 
    	                        	{ name: 'AREA_CODE', value: $("#AREA_CODE").val()},
    	                        	{ name: 'AFFIRM_TYPE_ID', value: $("#AFFIRM_TYPE_ID").val()},
    	                        	{ name: 'AFFIRMORID', value: $("#AFFIRMORID").val()},
    	                        	{ name: 'CPNY_ID', value: $("#CPNY_ID").val()},
    	                        	{ name: 'ACTIVITY', value: $("#ACTIVITY").val()},
    	                        	{ name: 'SET_APP', value: $("#SET_APP").val()}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $grid.loadData(true); //加载数据
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
        
    	$dialog = $.ligerDialog.open({isDrag: false,  title:'<spring:message code="hrms.update"/>', 
    		width: $("#layout1").width(), height: $("#layout1").height(), url: '/system/appProcessManagement/addAppProcessDInfo?DEPTID=' + rows.DEPTID
       	  });
    }
   

    function spf_delete(DEPTID,AFFIRM_TYPE_ID)
    {  
    	$dialog = $.ligerDialog.open({isDrag: false,  title:'<spring:message code="hrms.delete"/>', 
    		width: $("#layout1").width()-40, height: $("#layout1").height()-40, url: '/system/appProcessManagement/deleteAppProcessDInfo?AFFIRM_OBJECT='+DEPTID+'&AFFIRM_TYPE_ID='+AFFIRM_TYPE_ID+'&DEPTID='+DEPTID
       	  });
    }
    
    /*
     *弹出框收缩js
    */
    $(function ()
            { 
                $("#AFFIRMOR_ID_NAME").ligerComboBox({
                    onBeforeOpen: spf_selectEmp, valueFieldID: 'AFFIRMORID',width:150
                });
            });
            function spf_selectEmp()
            {
                $.ligerDialog.open({ 
                	title: '<spring:message code="employee.information"/>', 
                	name:'winselector'+Math.random(),
                	width: 800, 
                	height: 400, 
                	url: '/utility/empInfo/viewHrSearchEmployeeB', 
                	buttons: [
	                    { text: '<spring:message code="okay"/>', onclick: spf_selectOK },
	                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCancel },
	                    { text: '<spring:message code="clear"/>', onclick: spf_selectClear }
                	]
                });
                return false;
            }
            function spf_selectOK(item, dialog)
            {
    			var fn = dialog.frame.spf_selectEmpInfo || dialog.frame.window.spf_selectEmpInfo; 
                var data = fn(); 
                if (!data)
                {
                	$.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
               	 return ; 
                }
                $("#AFFIRMOR_ID_NAME").val(data.EMPID+","+data.CHINESENAME);
                $("#AFFIRMORID").val(data.EMPID);
                dialog.close();
            }
            function spf_selectCancel(item, dialog)
            {
                dialog.close();
            }
            function spf_selectClear(item, dialog)
            {
            	$("#AFFIRMOR_ID_NAME").val("");
            	$("#AFFIRMORID").val("");
                dialog.close();
            }

        /*
         *弹出框收缩js
        */
	</script>
	
	<style type="text/css"> 
        body{ padding:5px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }  
    </style>
</head>
<body style="padding:2px" > 
	<div id="layout1" > 
		  <div position="top">
			  	<table width="100%" border="0" >
			        <tr><td height="2"></td></tr>
		            <tr>
		                <td align="center" valign="middle"> 
						  	 <table width="99.6%" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
						           <tr> 
						               <td class="l-table-edit-t"><spring:message code="keyWord"/></td>
						           	   <td class="l-table-edit-c">
							       	   		<input type="text" name="keyWord" id="keyWord" />
							       	   </td> 
						               <td class="l-table-edit-t"><spring:message code="hrms.approver"/></td>
						           	   <td class="l-table-edit-c">
							       	   		<input type="text" name="AFFIRMOR_ID_NAME" id="AFFIRMOR_ID_NAME" />
							       	   		<input type="hidden" name="AFFIRMORID" id="AFFIRMORID" />
							       	   </td> 
						                <td class="l-table-edit-t"><spring:message code="hrms.dept"/></td>
						                <td class="l-table-edit-c">
						                	<SipingSoft:deptTree name="DEPTID" limit="hr"/>
						                </td> 
							       	   <td class="l-table-edit-t"><spring:message code="hrms.appType"/></td>
						           	   <td class="l-table-edit-c">
							       	   		<SipingSoft:selectSyCode parentCode="ApplyTypeCode" name="AFFIRM_TYPE_ID" limit="all"/>
							       	   </td> 
					                </tr>
					                <tr>
						               <td class="l-table-edit-t"><spring:message code="hrms.company"/></td>
						           	   <td class="l-table-edit-c">
											<SipingSoft:selectCompany name="CPNY_ID" limit="all"/>
							       	   </td>
							       	   <td class="l-table-edit-t"><spring:message code="hrms.active"/></td>
						           	   <td class="l-table-edit-c">
											<SipingSoft:selectStatus name="ACTIVITY" limit="all"/>
							       	   </td> 
							       	   <td class="l-table-edit-t"><spring:message code="hrms.setApprover"/></td>
						           	   <td class="l-table-edit-c">
							       	   		<SipingSoft:selectSyCode parentCode="yesOrno" name="SET_APP" limit="all"/>
							       	   </td> 
							       	   <td class="l-table-edit-t"><spring:message code="hrms.location"/></td>
						           	   <td class="l-table-edit-c">
							       	   		<SipingSoft:selectSyCode parentCode="WorkAreaCode" name="AREA_CODE" limit="all"/>
							       	   </td> 
						           </tr> 
						       </table>
		       			</td>
			      	</tr>
			    </table>
	       <table cellpadding="0" cellspacing="0" class="l-table-edit" > 
	           <tr>
	              <td align="left" height="30px">
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_search()"><spring:message code="search"/></a> 
	               		<a class="l-button" style="width:79px; height:20px; float:left; margin-left:10px;" onclick="spf_update()"><spring:message code="hrms.update"/></a>  
	               </td>
	           </tr> 
	       </table>
	  </div>
      <div position="center" id='loginUserInfo'></div>
     </div>     
</body>
</html>
