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

<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/core/base.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js"
    type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
    type="text/javascript"></script>
<script src="/resources/js/json2.js" type="text/javascript"></script>

<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>

<script type="text/javascript">

    $(function(){
        spf_initAdv();

        $(".advOption").live("mouseover",function(){
            $(this).css("background-color","#d9e8fb");
        });
        $(".advOption").live("mouseout",function(){
            if($(this).attr("chose") == "true"){
                $(this).css("background-color","#d9e8fb");
            }else{
                $(this).css("background-color","white");
            }
        });
        
        $("#PRODUCT_NAME").bind("click",function(){
            spf_showProducts();
        });
        $(".advOption").live("click",function(){
            if($(this).attr("chose") == "false"){
                $(this).attr("chose","true");
                $(this).css("background-color","#d9e8fb");
                
                $(this).siblings().attr("chose","false");
                $(this).siblings().css("background-color","white");
                
                $("#ADV_NO").val($(this).attr("ADV_NO"));
                $("#PHOTOPATH").val($(this).attr("PHOTOPATH"));
                $("#proImage").attr("src","/resources/picture/mobileAdv/"+$(this).attr("PHOTOPATH"));
                
                $("#PRODUCT_NAME").val($(this).attr("PRODUCT_NAME"));
                $("#PRODUCT_NO").val($(this).attr("PRODUCT_NO"));
                $("#PRODUCT_NAME").unbind("click");
            }else{
                $(this).attr("chose","false");
                $(this).css("background-color","white");
                
                spf_clear();
            }
        });
    });
    
    function spf_initAdv(){
        $.post("/mobile/mobileManage/getMobileAdv"
            , function (data){
                var temp = "";
                $.each(
                    data.Rows,
                    function(i, item) {
                        if(item.PRODUCT_NAME.length>16){
                            temp = temp + "<div chose='false' class='advOption' PRODUCT_NO='"+item.PRODUCT_NO+
                            "' PHOTOPATH='"+item.PHOTOPATH+"' PRODUCT_NAME='"+item.PRODUCT_NAME+
                            "' ADV_NO='"+item.ADV_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME.substr(0,16)+"......</div>";
                        }else{
                            temp = temp + "<div chose='false' class='advOption' PRODUCT_NO='"+item.PRODUCT_NO+
                            "' PHOTOPATH='"+item.PHOTOPATH+"' PRODUCT_NAME='"+item.PRODUCT_NAME+
                            "' ADV_NO='"+item.ADV_NO+"'>&nbsp;&nbsp;"+item.PRODUCT_NAME+"</div>";
                        }
                    }
                );
                $("#advDiv").html(temp);
                $("#ADV_CNT").val(data.Total);
            }
        );
    }
        
    function spf_showProducts(){
        $.ligerDialog.open({ 
            title: '<spring:message code="hrms.goodsList"/>', 
            name:'objectselector'+Math.random(),
            width: 800, 
            height: 400, 
            url: '/utility/proInfo/viewProductListB', 
            buttons: [
                { text: '<spring:message code="okay"/>', onclick: spf_selectObjectOK },
                { text: '<spring:message code="cancel"/>', onclick: spf_selectObjectCancel }
            ]
        });
    }
    
    function spf_selectObjectOK(item, dialog){
        var fn ;

        fn = dialog.frame.spf_selectProduct || dialog.frame.window.spf_selectProduct; 

        var data = fn();
        if (!data){
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        $("#PRODUCT_NO").val(data.PRODUCT_NO);
        $("#PRODUCT_NAME").val(data.PRODUCT_NAME);
        dialog.close();
    }
    function spf_selectObjectCancel(item, dialog){
        dialog.close();
    }
    
    function spf_uploadPhoto() {
        if($("#PRODUCT_NO").val() == ""){
            $.ligerDialog.warn('<spring:message code="mobile.pleaseSelectAProduct"/>','<spring:message code="hrms.warning"/>');
            return;
        }
        $dialog = $.ligerDialog.open({
            isDrag : false,
            title : '<spring:message code="mat.uploadPictures"/>',
            width : 420,
            height : 220,
            url : '/upload/fileUpload/uploadMobileAdvImage?PRODUCT_NO='+$("#PRODUCT_NO").val()
        });
    }
    function spf_photo_ChildWindowClose(fileName) {
        $("#PHOTOPATH").val(fileName);
        $("#proImage").attr("src","/resources/picture/mobileAdv/"+fileName);
        $dialog.close();
    }
    
    function spf_save(){
        if($("#PRODUCT_NO").val() == "" || $("#PHOTOPATH").val() == ""){
            $.ligerDialog.warn('<spring:message code="mobile.Pleaseselectanduploadpictures"/>','<spring:message code="hrms.warning"/>');
            return;
        }
        
        if($("#ADV_CNT").val()>=6 && $("#ADV_NO").val() == ""){
            $.ligerDialog.warn('<spring:message code="mobile.Billboards"/>','<spring:message code="hrms.warning"/>');
            return;
        }
        
        $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
        $.post("/mobile/mobileManage/addOrUpdateMobileAdv", 
            [   
                { name: 'PRODUCT_NO', value: $("#PRODUCT_NO").val() },
                { name: 'PHOTOPATH', value: $("#PHOTOPATH").val() },
                { name: 'OLD_PHOTOPATH', value: $(".advOption[chose='true']").attr("PHOTOPATH")}
            ]
            , function (result){
                $.ligerDialog.closeWaitting();
                if (result == "Y"){
                    $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                        spf_initAdv();
                        spf_clear();
                    });
                }else{
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                }
            }
        );
    }
    
    function spf_clear(){
        $("#ADV_NO").val("");
        $("#PHOTOPATH").val("");
        $("#proImage").attr("src","");
        
        $("#PRODUCT_NAME").val("");
        $("#PRODUCT_NO").val("");
        
        $("#PRODUCT_NAME").bind("click",function(){
            spf_showProducts();
        });
    }
    
    function spf_delete(){
        if($("#ADV_NO").val() == ""){
            $.ligerDialog.warn('<spring:message code="mobile.Pleaseselecttheitems"/>','<spring:message code="hrms.warning"/>');
            return;
        }
        
        $.ligerDialog.confirm('<spring:message code="mobile.areDeleteTheZone"/>？',
                '<spring:message code="hrms.warning"/>', 
            function (yes){
                if(yes){
                    $.post("/mobile/mobileManage/deleteMobileAdv", 
                        [   
                            { name: 'ADV_NO', value: $("#ADV_NO").val() },
                            { name: 'PHOTOPATH', value: $("#PHOTOPATH").val()}
                        ]
                        , function (result){
                            $.ligerDialog.closeWaitting();
                            if (result == "Y"){
                                $.ligerDialog.success('<spring:message code="hrms.deleteSuccess"/>','<spring:message code="hrms.warning"/>', function (){
                                    spf_initAdv();
                                    spf_clear();
                                });
                            }else{
                                $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                            }
                        }
                    );
                }
            }
        );
    }
</script>

<style type="text/css">
body {
    padding: 5px;
    margin: 0;
    padding-bottom: 15px;
}

#layout1 {
    width: 99.8%;
    margin: 0;
    padding: 0;
}
#showAdvDiv{
    width:800px;
    height:800px;
    margin:0 auto;
    border:1px solid #c5c5c5;
}
.setButton{
    display:block;
    width:90px;
    height:30px;
    background-color:#fe9e00;
    color:white;
    font-size:15px;
    text-align:center;
    line-height:30px;
    text-decoration: none;
}
.inputClass{
    width:300px;
    height:30px;
    text-align:center;
}
.advSelect{
    width:300px;
    height:500px;
    overflow:hidden;
    border:1px solid #c5c5c5;
}
.advOption{
    width:300px;
    height:30px;
    text-align:left;
    line-height:30px;
    font-size:14px;
    border-bottom:1px solid #c5c5c5;
    cursor:pointer;
}
a{
    float:right;
    margin-right:5px;
    text-align:center;
    text-decoration:none;
    display:block;
    width:15px;
    height:15px;
    line-height:13px;
    border:1px solid #c5c5c5;
    color:green;
}
</style>
</head>
<body style="padding: 2px">
    <div id="layout1">
        <div id="showAdvDiv">
            <input type="hidden" id="M_AREA_NO"/>
          
            <div style="width:600px;margin:0 auto;">
                <table width="100%" cellpadding="1" cellspacing="1"
                    style="height: 25px; font-size: 12px;">
                    <tr height="100">
                        <td width="5%" align="center"><img
                            src="/resources/images/title/top_1.gif" /></td>
                        <td width="25%" align="left" style="font-weight: bold;font-size:15px;"><spring:message code="mobile.billboardsManagement"/></td>
                        <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
                        <td width="65%" align="right">&nbsp;&nbsp;&nbsp;</td>
                    </tr>
                </table>
                
                <table width="100%">
                    <tr>
                        <td align="right" width="50%">
                             <input type="hidden" id="ADV_CNT"/>
                             <div class="advSelect">
                                 <div id="advDiv" style="width: 300px;height: 475px;"></div>
                                 <div style="width: 300px;height: 25px;">
                                     <a href="javascript:spf_clear()">+</a><a href="javascript:spf_delete()">-</a>
                                 </div>
                             </div>
                        </td>
                        <td align="left" width="50%">
                             <input type="hidden" id="ADV_NO"/>
                             <div id="detailDiv" class="advSelect">
                                 <table width="100%">
                                     <tr height="10">
                                         <td colspan="2"></td>
                                     </tr>
                                     <tr height="250">
                                         <td align="center" colspan="2">
                                             <img src="" id="proImage"
                                                onerror="this.src='/resources/picture/none.gif'" width="250" height="250"/>
                                             <input type="hidden" id="PHOTOPATH"/>
                                         </td>
                                     </tr>
                                     <tr height="25">
                                         <td align="right" colspan="2">
                                             <a class="l-button"
                                                style="width: 50px;float:right;margin-right:25px;color:white; height: 15px;line-height:15px;background-image:url(''); background-color:#4a87dd;"
                                                onclick="javascript:spf_uploadPhoto()"><spring:message code="mobile.upload"/></a>
                                         </td>
                                     </tr>
                                     <tr height="185">
                                         <td width="100"><p style="font-size:12px;margin-left:25px;"><spring:message code="mobile.linkCommodity"/></p></td>
                                         <td width="220">
                                             <input id="PRODUCT_NO" type="hidden"/>
                                             <input id="PRODUCT_NAME" type="text" style="width:150px;height:20px;font-size:14px;float:right;margin-right:25px;"/>
                                         </td>
                                     </tr>
                                     <tr>
                                         <td colspan="2">
                                             <a class="l-button"
                                                style="width: 60px;float:right;margin-right:25px; height: 20px;background-image:url(''); "
                                                onclick="javascript:spf_save()"><spring:message code="hrms.save"/></a>
                                         </td>
                                     </tr>
                                 </table>
                             </div>
                        </td>
                    </tr>
                </table>
            </div>
            
            
        </div>
    </div>
</body>
</html>
