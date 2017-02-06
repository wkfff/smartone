<%@ page contentType="text/html; charset=UTF-8" language="java"
	errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">

<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css">
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>
<script src="/resources/js/function.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
	type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript"> 
    var $actiongrid = null ; 
    var $systemAnnouncementTypeSelectList ;
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
        $("#announcementlayout").ligerLayout({
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        }); 
        $systemAnnouncementTypeSelectList = getAnnouncementTypeSelectList();
        //alert($custActionStateSelectList);
        f_initGrid(); 
    });
 
    function f_initGrid()
    {
    	
    	$announcementgrid = $("#announcementInfo").ligerGrid({
    		//checkbox: true,   	
     		onBeforeEdit:function(e){
                $.ligerui.win.masking=true;
                },
    		columns: [
			            { display: '', name: 'ANN_NO', width: 0,hide: 1},
			            { display: '创建日期', name: 'CREATED_DATE', width: 90,frozen: true},
			            { display: '公告类型', name: 'ANN_TYPE_CODE', width: 100,
	                        editor: { 
	                        	type: 'select', data: $systemAnnouncementTypeSelectList, dataValueField: 'ID',dataDisplayField: 'NAME',
		  	                  	displayColumnName: 'NAME', valueColumnName: 'ID'
	                        }, render: function (item)
	                        {
	                            for (var i = 0; i < $systemAnnouncementTypeSelectList.length; i++)
	                            {
	                                if ($systemAnnouncementTypeSelectList[i]['ID'] == item.ANN_TYPE_CODE) { 
	                                    return $systemAnnouncementTypeSelectList[i]['NAME'];
	                                	
	                                }
	                            }
	                            return item.ANN_TYPE;
	                        }
			            },
			            { display: '公告内容', name: 'ANN_CONTENT', width: 250,
			            	editor: { type: 'textarea', height: 100 }
						},  
			            { display: '备注', name: 'REMARK', width: 250,
			            	editor: { type: 'textarea', height: 100 }
						}
		            ],
            enabledEdit: true,usePager: true, rownumbers:true,
            pageSize:20,
            url: '/system/basicMaintenance/getAnnouncementList',
            parms: [
                   ],
            width: '99.6%', height: '100%'
            });
    }

    function spf_add(){
    	var row = $announcementgrid.getRow(0);
		$announcementgrid.addRow(null,row,true);
	}
    
    function spf_search()
    {
    	$announcementgrid.setOptions({ parms: [	
									{ name: 'keyWord', value: $("#keyWord").attr('value')},
									{ name: 'S_DATE', value: $("#S_DATE").attr('value')},
									{ name: 'E_DATE', value: $("#E_DATE").attr('value')}
    	                           ],
    	                   newPage: 1
    	                 }); //设置数据参数
        $announcementgrid.loadData(true); //加载数据
    }

	function spf_delete()
	{
    	var	row = $announcementgrid.getSelectedRow(); 
	    if (!row || row.length == 0) { 
	   	 	$.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
	   		 return ; 
	    }
    	$.ligerDialog.confirm('您确定要删除该条公告信息','<spring:message code="hrms.warning"/>', function (yes)
    	   	    {
    				if(yes)
    					{
	    					$.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
	    			        $.post("/system/basicMaintenance/removeAnnouncement", 
	    			                [	
	    			                   { name: 'ANN_NO', value: row.ANN_NO}
	    			                 ]
	    			        , function (result)
	    			        {
	    			        	$.ligerDialog.closeWaitting();
	    			            if (result == "Y")
	    			            {
	    			                $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function ()
	    			                {
	    			                	$announcementgrid.loadData(true);
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
	
	
	function spf_save()
    {
    	 var jsonData = '[' ; 
    	 
    	 var rows = $announcementgrid.getData(); 
    	 
    	 //alert(JSON2.stringify(rows));
       $(rows).each(function (index, row){
    	   if(this.__status != null && (this.__status == 'add'||this.__status == 'update')){
    		   if(this.ANN_CONTENT == null || this.ANN_CONTENT == 'undefined'||this.ANN_CONTENT == ''){ 
    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '公告信息'+". " + '<spring:message code="input.required"/>') ; 
    		       	 return ; 
    		   }
    		   if(this.ANN_TYPE_CODE == null|| this.ANN_TYPE_CODE == '' || this.ANN_TYPE_CODE == 'undefined'){ 
    		       	 $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '公告类型'+". " + '<spring:message code="input.required"/>') ; 
    		       	 return ; 
    		   }
    		   else{
    			   if(this.REMARK == null || this.REMARK == 'undefined'){
    				   this.REMARK = '';
    			   }
					if (jsonData.length > 1){
						jsonData += ',{' ;
					}
					else{
						jsonData += '{' ;
					}
					jsonData += ' "__status": "' + this.__status + '", ' ;
					jsonData += ' "ANN_NO": "' + this.ANN_NO + '", ';
					jsonData += ' "ANN_TYPE_CODE": "' + this.ANN_TYPE_CODE + '", ';
					jsonData += ' "ANN_CONTENT": "' + this.ANN_CONTENT + '", ';
					jsonData += ' "REMARK": "' + this.REMARK + '"' ;
					jsonData += '}' ; 
        		}
    		}
       	}); 
		jsonData += ']' ;
       $.ligerDialog.waitting('<spring:message code="hrms.submitting"/>');
       $.post("/system/basicMaintenance/transferAnnouncement", 
               [	
                	{ name: 'jsonData', value: jsonData }
               ]
       , function (result)
       {
       	$.ligerDialog.closeWaitting();
           if (result == "Y")
           {
               $.ligerDialog.success('<spring:message code="hrms.submitSuccess"/>','<spring:message code="hrms.warning"/>', function ()
               {
                    $announcementgrid.loadData(true); //加载数据  
               });
           }
           else
           {
               $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
               $announcementgrid.loadData(true); //加载数据  
           }
       });
    }
     function getAnnouncementTypeSelectList(){
      	//请求服务器 
      	var systemAnnouncementTypeSelectList ;
          $.ajax({
              type: 'post',
              url: '/utility/otherInfo/getAnnouncementTypeSelectList', 
              dataType: 'json',
              async: false,
              success: function (list)
              {  
            	  systemAnnouncementTypeSelectList = list ; 
              }
          });
          return systemAnnouncementTypeSelectList;
      }
	</script>

<style type="text/css">
body {
	padding: 5px;
	margin: 0;
	padding-bottom: 15px;
}

#actionlayout {
	width: 99.8%;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body style="padding: 2px">
	<div id="announcementlayout">
		<div position="center" id='' title=' '>
			<div position="top">
				<table width="99.6%" cellpadding="0" cellspacing="0"
					class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
					<tr>
						<td width="15%" class="l-table-edit-t"><spring:message
								code="keyWord" /></td>
						<td width="35%" class="l-table-edit-c"><input name="keyWord"
							type="text" id="keyWord" size="30" /></td>
					</tr>
					<td class="l-table-edit-t">创建日期</td>
						<td class="l-table-edit-c"><input type="text" name="S_DATE"
							id="S_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /> ~ <input type="text" name="E_DATE"
							id="E_DATE" value="" size="25"
							onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
							readonly="readonly" /></td>
				</table>
				<table cellpadding="0" cellspacing="0" class="l-table-edit"
					height="30">
					<tr>
						<td align="left"><SipingSoft:button /> <%-- <SipingSoft:buttonCon /> --%>
						</td>
					</tr>
				</table>
			</div>
			<div position="center" id='announcementInfo'></div>
		</div>
	</div>
</body>
</html>
