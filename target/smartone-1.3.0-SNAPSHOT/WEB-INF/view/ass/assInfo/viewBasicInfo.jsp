<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<meta http-equiv="Pragma" content="No-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="Expires" content="-1">
    <!-- CSS -->
    <link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
    <link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
     <!-- JS -->    
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script type="text/javascript">
        function searchEmp(){
         $dialog = $.ligerWindow.show({isDrag: false, 
                title:'<spring:message code="employee.information"/>',
                width: 800 , 
                height: 400 , 
                left:160,top:90,
                url: '/utility/empInfo/viewHrSearchEmployee'
              }); 
       } 
      function spf_initSelectEmpInfo(data){  
             $("#EMPID").attr("value", data.EMPID) ; 
             var url=( location.href).split("?");   
             var _url=url[1].split("&");  
             
             location.href=url[0]+"?"+_url[0]+"&EMPID="+data.EMPID;
              
            $dialog.close() ;
      }
      function spf_uploadPhoto()
      {
          var ASSET_ID = '${assetDetail.ASSET_ID}';
         $dialog = $.ligerDialog.open({isDrag: false, 
                title:'<spring:message code="ass.uploadPictures"/>', 
                width: 420, 
                height: 220, 
                url: '/upload/fileUpload/uploadAssetPic?ASSET_ID='+ASSET_ID
         });
      }
      function spf_photo_ChildWindowClose (picPath){
          $("#headImage").attr("src",picPath+"?"+Math.random());
          $dialog.close() ;
      }
      function spf_search(){
          var NAME_CODE =  $("#ASSET_NAME_CODE").attr('value');
          //alert(NAME_CODE);
          location.href="/ass/assInfo/viewAssetDetail?ASSET_NAME_CODE="+NAME_CODE;
      }
      var tab = parent.tab;
      function spf_updateInfo(){
          //alert('${assetDetail.ASSET_ID}');
          var ASSET_ID = '${assetDetail.ASSET_ID}';
          if(tab.isTabItemExist('ass0202')){
              tab.removeTabItem('ass0202');
          }
          tab.addTabItem({ tabid : 'ass0202',text: '<spring:message code="ass.updateAsset"/>', url: '/ass/assManage/updateAsset?MENU_CODE=ass0202&ASSET_ID='+ASSET_ID });
      }
      function spf_removeAsset(){
          var ASSET_ID = '${assetDetail.ASSET_ID}';
          $dialog = $.ligerDialog.open({isDrag: false, 
                title:'<spring:message code="ass.deletingAssets"/>', 
                width: 420, 
                height: 220, 
                url: '/ass/assManage/removeAsset?ASSET_ID='+ASSET_ID
          });
      }
      function spf_afterRemove(){
          $dialog.close();
          tab.removeSelectedTabItem(); //关闭当前窗口
          if(tab.isTabItemExist('ass0101')){  //刷新资产列表窗口
              tab.reload('ass0101');
          }
      }
      function spf_viewRecord(){
          $dialog = $.ligerDialog.open({isDrag: false, 
                title:'<spring:message code="ass.itemsLendingConditions"/>', 
                width: 620, 
                height: 200, 
                url: '/ass/assInfo/viewBorrowRecord?ASSET_ID=${assetDetail.ASSET_ID}'
          });
      }
    </script>
<style type="text/css"> 
      body{ padding:5px; margin:0; padding-bottom:15px;}
      #layout1{  width:99.8%;margin:0; padding:0;  }   
</style>
</head>
<body style="padding:0px" > 
    <div id="layout1" >  
      <div align="center">  
                <table width="99.5%" cellpadding="1" cellspacing="1" style="height:25px;font-size: 12px;">
                    <tr>
                        <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                        <td width="25%" align="left" style="font-weight: bold;">
                            <spring:message code="ass.theCompanyAssets"/>
                        </td>
                        <td width="5%" align="left">
                            &nbsp;&nbsp;&nbsp;
                        </td>
                        <td width="65%" align="right">
                        &nbsp;&nbsp;&nbsp;
                        </td>                                               
                    </tr> 
                </table> 
                 <table width="99.5%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                       <tr>  
                           <td width="10%" class="l-table-edit-cc" rowspan="6" style="cursor: pointer;">
                                  
                                <img src="${assetDetail.PHOTOPATH}" id="headImage" alt="<spring:message code="ass.clickUploadImage"/>" title="<spring:message code="ass.clickUploadImage"/>"
                                    onerror="this.src='/resources/picture/none.gif'" onClick="spf_uploadPhoto()" width="100" height="120"/>
                           </td>  
                        </tr>
                       <tr> 
                           <td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.assetID"/></td>
                           <td width="20%" class="l-table-edit-c" nowrap="nowrap">
                                <div name="ASSET_ID" id="ASSET_ID">${assetDetail.ASSET_ID}</div>      
                           </td> 
                           <td width="10%" class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.assetName"/></td>
                           <td width="20%" class="l-table-edit-c" nowrap="nowrap" > 
                                ${assetDetail.ASSET_NAME }
                           </td>
                        </tr>                        
                       <tr> 
                           <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.borrowRecord"/></td>
                           <td class="l-table-edit-c" nowrap="nowrap">
                                <div style="cursor: pointer;" onclick="spf_viewRecord()"><spring:message code="ass.clickHereToView"/></div>
                           </td> 
                           <td class="l-table-edit-t" nowrap="nowrap"></td>
                           <td class="l-table-edit-c" nowrap="nowrap"></td>                            
                       </tr>  
                       <tr>  
                           <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.updateInformation"/></td>
                           <td class="l-table-edit-c" nowrap="nowrap">
                                <div style="cursor: pointer;" onclick="spf_updateInfo()"><spring:message code="ass.clickHereToModify"/></div>
                           </td> 
                           <td class="l-table-edit-t" nowrap="nowrap"></td>
                           <td class="l-table-edit-c" nowrap="nowrap"></td> 
                       </tr>
                       <tr>   
                           <td class="l-table-edit-t" nowrap="nowrap"><spring:message code="ass.deletingAssets"/></td>
                           <td class="l-table-edit-c">
                                <div style="cursor: pointer;" onclick="spf_removeAsset()"><spring:message code="ass.clickHereToDelete"/></div>
                           </td> 
                           <td class="l-table-edit-t" nowrap="nowrap"></td>
                           <td class="l-table-edit-c" nowrap="nowrap"></td> 
                       </tr>
                   </table>   
      </div>
      </div> 
</body>
</html>
