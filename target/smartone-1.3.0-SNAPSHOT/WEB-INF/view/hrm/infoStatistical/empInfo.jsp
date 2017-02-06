<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 <html>
 <title></title>
 <head>   
   <meta http-equiv="X-UA-Compatible" content="IE=edge" >
   <meta http-equiv="Pragma" CONTENT="no-cache">
   <meta http-equiv="Cache-Control" CONTENT="no-cache">
   <meta http-equiv="Expires" CONTENT="0">
   
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css">
     <!-- JS -->
    <script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/core/base.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>  
    <script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script>   
    <script src="/resources/js/ligerUI/js/plugins/ligerComboBox.js" type="text/javascript"></script>       
         
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
   
    
    <script type="text/javascript"> 
    var $grid = null ; 
    var $tree_1 = null ; 
    var $tree_2 = null ;  
    // 初始调用
    $(function ()
    {
        //布局
        $("#layout1").ligerLayout({
            leftWidth: 180,
            rightWidth: 280, 
            topHeight: 30, 
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });  
        spf_infoTable();
        spf_infoTableTree('');
        f_initGrid('');
    }); 
     
    function spf_infoTableTree(flag)
    {  $tree_1 = null;
        TYPE_ID = flag;
        $.ajax({
            type:'post',
            cache:false,
            contentType:'application/json',                                         
            url:'/hrm/infoStatistical/getInfoTableList?TYPE_ID='+flag,              
            dataType:'json',
            success:function(response){ 
                $tree_1 = $("#infoTableTree").ligerTree(
                              { 
                                  checkbox: true, 
                                  treeLine: true,
                                  parentIcon: null, 
                                  childIcon: null,  
                                  nodeWidth: 100, 
                                  onCheck: onCheck1,
                                  data: response.Rows,
                                  idFieldName: 'TABLE_ID', textFieldName: 'TABLE_NAME'
                              }
                         ); 
            }           
        }); 
    } 
    function spf_infoTable()
    {  $.ajax({
        type:'post',
        cache:false,
        contentType:'application/json',                                         
        url:'/hrm/infoStatistical/getInfoTableJson',                
        dataType:'json',
        success:function(data){  
        var proData = eval("(" + data.TRows + ")");
        var cityData = eval("(" + data.FRows + ")");
        
        $("#txtPro").ligerComboBox(
                  {  
                      isMultiSelect: false,  
                      data: proData,
                      onSelected: function (newvalue)
                      {
                           var newData = new Array();
                           for (i = 0; i < cityData.length; i++)
                           {
                               if (cityData[i].pid == newvalue)
                               {
                                   newData.push(cityData[i]);
                               }
                           }
                           $("#txtCity").ligerGetComboBoxManager().setData(newData);
                       },
                  }
             ); 
       $("#txtCity").ligerComboBox({ data: null, isMultiSelect: false, isShowCheckBox: false,onSelected: function (newvalue)
           {
                spf_search(newvalue);
           } 
       });
        }
    });
    } 
    function spf_infoFieldTree(flag)
    {       
            $.ajax({
                type:'post',
                cache:false,
                contentType:'application/json',                                         
                url:'/hrm/infoStatistical/getInfoFieldList?TABLE_ID='+flag,             
                dataType:'json',
                success:function(response){ 
                    $tree_2 = $("#infoFieldItemTree").ligerTree(
                                  { 
                                      checkbox: true, 
                                      treeLine: true,
                                      parentIcon: null, 
                                      childIcon: null,  
                                      nodeWidth: 100,  
                                      onClick: removeTreeItem,
                                      onCheck: onCheck2,
                                      data: response.Rows,
                                      idFieldName: 'FIELD_ID', textFieldName: 'FIELD_NAME'
                                  }
                             ); 
                }           
            });  
    }  
    function onCheck1(note,checked){    
        if(checked){   
            spf_add(note.data.TABLE_ID);
        }else{
            spf_delete(note.data.TABLE_ID,'');  
        }
    } 
    function f_initGrid()
    {
        $grid = $("#infoFieldInfo").ligerGrid({
            checkbox: true,
            columns: [   
                        { display: '', name: 'FIELD_NO', width: 10,hide: 1},
                        { display: '<spring:message code="hrms.basicCode"/>', name: 'FIELD_ID', align: 'left', width: 180},
                        { display: '<spring:message code="name"/>', name: 'FIELD_NAME', align: 'left', width: 180},
                        { display: '<spring:message code="hrms.basicCode"/>', name: 'TABLE_ID', align: 'left', width: 180},
                        { display: '<spring:message code="name"/>', name: 'TABLE_NAME', align: 'left', width: 180}
                    ],
            enabledEdit: false,usePager: true, rownumbers: true,
            url: '/hrm/infoStatistical/getFieldInfo',
            pageSize: 18, pageSizeOptions:[18, 30, 60,120],  
            width: '99.6%',height: '100%'
        });
    }  
    function spf_search(tableID)
    {
        $grid.setOptions({ parms: [  
                                    { name: 'TABLE_ID', value: tableID}
                                   ],
                           newPage: 1
                         }); //设置数据参数
        $grid.loadData(true); //加载数据
    }
    function spf_clear(){           
        $tree_1.clear();   
    }
    function spf_delete_all()
    {         
        var jsonData = '[' ; 
        var rows = $grid.getCheckedRows(); 
         
        if (!rows || rows.length == 0) { 
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        }
        $(rows).each(function (index, row)
                 {  
                     if (jsonData.length > 1){
                        jsonData += ',{' ;
                     }
                     else{
                        jsonData += '{' ;
                     }  
                     jsonData += ' "FIELD_ID": "' + this.FIELD_ID + '", ' ;    
                     jsonData += ' "TABLE_ID": "' + this.TABLE_ID + '"' ;
                     jsonData += '}' ;  
            }); 
           
        jsonData += ']' ; 
        
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){  
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/hrm/infoStatistical/deleteFieldInfo', 
                        [   
                            { name: 'jsonData', value: jsonData }
                        ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){ 
                        $grid.loadData(true);//加载数据 
                    }
                    else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        }); 
    }
    function spf_delete(tableID,fieldID)
    {         
        $.ligerDialog.confirm('<spring:message code="hrms.whetherDelete"/>','<spring:message code="hrms.warning"/>', function (yes)
        {
            if(yes){  
                $.ligerDialog.waitting('<spring:message code="hrms.deleting"/>');
                $.post('/hrm/infoStatistical/deleteFieldInfo', 
                        [   
                            { name: 'FIELD_ID', value: fieldID },
                            { name: 'TABLE_ID', value: tableID },
                            { name: 'jsonData', value: '' }
                        ]
                , function (result)
                {
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){ 
                        $grid.loadData(true);//加载数据 
                    }
                    else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                });
            }
        }); 
    } 
    function spf_add(tableID)
    {          
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post('/hrm/infoStatistical/addFieldInfo', 
                [    
                    { name: 'TABLE_ID', value: tableID }
                ]
        , function (result)
        {
            $.ligerDialog.closeWaitting();
            if (result == "Y"){ 
                $grid.loadData(true);//加载数据 
            }
            else{
                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
            }
        }); 
    }

    function spf_showDataInfo()
    {    
        var rows = $grid.getData(); 
        if(!rows || rows.length == 0){
            $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
             return ; 
        }else{
            $dialog = $.ligerWindow.show({isDrag: true,
                title: '<spring:message code="hrms.details"/>',
                width: 900 , 
                height: 450 , 
                left:120,top:60,
                url: '/hrm/infoStatistical/viewDataInfo'
            }); 
        }
    } 
    </script>
    
    <style type="text/css"> 
        body{ padding:10px; margin:0; padding-bottom:15px;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<form name="form1" method="post" action="" id="form1">
<div id="layout1">  
     <div position="top">   
                <table width="99.6%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr> 
                        <td width="10%" align="center"  style="font: bolder;">
                             <spring:message code="hrms.dataBelong"/>
                       </td> 
                        <td width="12%">
                             <input type="text" id="txtPro"/> 
                       </td> 
                       <td width="15%"> 
                             <input type="text" id="txtCity"/> 
                       </td>
                        <td width="10%" align="center" height="30px;">   
                            <a class="l-button" style="width:79px; height:20px; float: center; margin-left:10px;" onclick="spf_showDataInfo()"><spring:message code="hrms.details"/></a>
                        </td>   
                        <td width="10%" align="center" height="30px;">   
                            <a class="l-button" style="width:79px; height:20px; float:center; margin-left:10px;" onclick="spf_delete_all()"><spring:message code="hrms.delete"/></a>  
                        </td>
                        <td width="40%" align="center" height="30px;">   
                           &nbsp;
                        </td>
                    </tr> 
                </table>  
      </div>  
             <div  position="left" title='<spring:message code="hrms.basicCode"/>' style="width:99.6%;height:95%; margin:0px; float:left; overflow:auto;  ">
                <ul id="infoTableTree"> </ul></div>
            <div position="center" title='<spring:message code="hrms.detailCode"/>' style="width:99.6%;height:95%; margin:0px; float:left; overflow:auto;  "> 
                 <div id="infoFieldInfo"></div>
            </div>  
</div> 
</form>
</body>
</html>