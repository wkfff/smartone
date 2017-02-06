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
    <script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
    <script src="/resources/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>  
    <script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
    <script src="/resources/js/dateString.js" type="text/javascript"></script>
   <%@ include file="/WEB-INF/view/web/inc/validateForm.jsp"%>
<script type="text/javascript">
    
//初始化数据 
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
             if($("#type").val() =='add'){
                 $("#MOBILEPHONE").attr("value",'CustomerStatus001');
             }
             $("#CUST_NAME").ligerComboBox({
                 onBeforeOpen: spf_selectCust
             });
            // spf_setTime();
             spf_changeType();
             //利用custActionNo初始化action数据
             var custActionNo=$("#custActionNo").val();
             $.post("/cust/custAction/getActionByCustActionNo",{"custActionNo":custActionNo},function(action){
                $("#CUST_ACTION_WAY_CODE").val(action.actionWayCode.codeId);
                $("#CUST_ACTION_TIME").val(action.actionTime);
                $("#CUST_ACTION_CONTENT").val(action.actionContent);
                $("#ACTION_TYPE_CODE").val(action.actionType.codeId);
                $("#PURCHASE_TEND_CODE").val(action.purchase.codeId);
                $("#CREATED_DATE").val(action.createDate);
                $("#CUST_ACTION_STATE_CODE").val(action.actionState.codeId);
                $("#CONTACT").append("<option>"+action.contact+"</option>");
                $("#CUST_NAME").val(action.custId);
             })
             init_css();
        });

    function init_css()
    {
        $("[name='CREATED_DATE'],[name='CUST_ACTION_STATE_CODE'],[name='CUST_ACTION_TIME'],[name='TRACE_STATUS_CODE'],[name='CUST_ACTION_WAY_CODE'],[name='PURCHASE_TEND_CODE'],[name='CONTACT'],[name='ACTION_TYPE_CODE']").css({
            border : "1px solid #c1dcfa",width:"200",height:"25"
        });
    }
 /*    function spf_setTime()
    {
        var myDate = new Date();
        myDate = myDate.valueOf();
        $("#CREATED_DATE").val(dateString(myDate));
        $("#CUST_ACTION_TIME").val(dateString(myDate));
        var newDate = myDate + 7*24*60*60*1000;
        $("#TIME_NEXT").val(dateString(newDate));
    } */

    function spf_selectCust()
        {
            $.ligerDialog.open({ 
                title: '<spring:message code="okay"/><spring:message code="hrms.customer"/>', 
                name:'custselector',
                width: 800, 
                height: 400, 
                url: '/utility/custInfo/viewCustomerList', 
                buttons: [
                    { text: '<spring:message code="okay"/>', onclick: spf_selectCustOK },
                    { text: '<spring:message code="cancel"/>', onclick: spf_selectCustCancel },
                    { text: '<spring:message code="clear"/>', onclick: spf_selectCustClear }
                ]
            });
            return false;
        }
    function spf_selectCustOK(item, dialog)
    {
        var fn = dialog.frame.spf_selectCustomer || dialog.frame.window.spf_selectCustomer; 
        var data = fn(); 
        if (!data)
        {
            $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.chooseLine"/>') ; 
            return;
        }
        
        $("#CUST_ID").val(data.CUST_ID);
        $("#CUST_NAME").val(data.CUST_NAME);
        $("#CONTACT").val(data.CONTACT);
        $("#MOBILEPHONE").val(data.MOBILEPHONE);
        $.post("/cust/custManager/getCustContactByCustId",{"CUST_ID":data.CUST_ID},function(data){
        	$("#contactTip").text("");
        	$("#CONTACT").empty();	
            $.each(data,function(index,item){
                var contactName=item.contactName;
                $("#CONTACT").append("<option value="+contactName+">"+contactName+"</option>"); 
            });
            if(data==null||data=="")
            {
                $("#contactTip").text("该客户还没有联系人，请为该客户添加联系人");
                return;
            }
        });
        dialog.close();
    }
    function spf_selectCustCancel(item, dialog)
    {
        dialog.close();
    }
    function spf_selectCustClear(item, dialog)
    {
        $("#CUST_ID").val("");
        $("#CUST_NAME").val("");
        $("#CONTACT").val("");
        $("#MOBILEPHONE").val("");
        dialog.close();
    }

/*  *************************************************** */

    function spf_update(){
        spf_save();
    }

    function spf_save() {
        /* if($('#type').val()=='update'&&($('#CUST_ID').val()==''||$('#CUST_ID').val()==null))
        {
            return;
        } */
             if (spf_checkData()) {// 这里需要检测action中的值
                 $.ligerDialog.waitting('<spring:message code="hrms.saveing"/>');
                 //contact json data
                 var action = {
                     custActionNo : $("#custActionNo").val(),
                     createDate : $("#CREATED_DATE").val(),
                     actionType : { codeNo : $("#ACTION_TYPE_CODE").val()},
                     actionWayCode : { codeNo : $("#CUST_ACTION_WAY_CODE").val()},
                     actionState : {codeNo:$("#CUST_ACTION_STATE_CODE").val()},
                     purchase : { codeNo : $("#PURCHASE_TEND_CODE").val()},
                     custId : $("#CUST_ID").val(),
                     actionTime : $("#CUST_ACTION_TIME").val(),
                     contact : $("#CONTACT").val(),
                     actionContent : $("#CUST_ACTION_CONTENT").val()
                 };
                 $.ajax({
                     url : "/cust/custAction/addOrUpdateCustAction",
                     type : 'POST',
                     contentType : 'application/json;charset=utf-8',
                     dataType : 'json',
                     data : JSON.stringify(action),
                     success : function(result) {
                         $.ligerDialog.closeWaitting();
                         if (result== "Y") {
                             $.ligerDialog.success(  '<spring:message code="hrms.saveSuccess"/>', '<spring:message code="hrms.warning"/>',function(){
                            	 parent.spf_afterAddOrRemove(); 
                             });
                         } else {
                             $.ligerMessageBox.error(
                                     '客户活动保存失败',
                                     "客户活动");
                         } 
                     }
                 });
             }
    }
    function spf_checkData()  //Reserved
    {
        var telereg = /^\d{8}$/;
        var mobreg = /^1[3|4|5|8][0-9]\d{8}$/;
        var mailreg = /^[\w-]+(\.[\w]+)*@([\w-]+\.)+[a-zA-z]{2,7}$/;
        if ($("#ACTION_TYPE_CODE").val() == null || $("#ACTION_TYPE_CODE").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.customerName"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
        }
        if ($("#CONTACT").val() == null || $("#CONTACT").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.contact"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
       }
        if ($("#CUST_ACTION_TIME").val() == null || $("#CUST_ACTION_TIME").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.activityTime"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
      }
        
        if ($("#CUST_ACTION_WAY_CODE").val() == null || $("#CUST_ACTION_WAY_CODE").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.activityPatterns"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
     }
        if ($("#CUST_ACTION_CONTENT").val() == null || $("#CUST_ACTION_CONTENT").val() == "") {  
             $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '<spring:message code="hrms.contentRecord"/>'+". " + '<spring:message code="input.required"/>') ; 
             return false; 
      }
     
        return true;     
    }
    function spf_refresh(){
        var type = '${type}';
        location.href="/cust/custAction/addCustomerAction?MENU_CODE=cust0504";
    }
    function spf_changeType(){
        var actionType = $("#ACTION_TYPE_CODE").val();
        //alert(actionType);
        if(actionType == "ActionType001" ||actionType == ""){  //Trace
            $("#way").html("<spring:message code="hrms.trackingMode"/>");
            $("#timeNext").html("<spring:message code="hrms.dateOfTheNextTrack"/>");
            $("#wayNext").html("<spring:message code="hrms.nextTrackMode"/>");
            $("#PURCHASE_TEND_CODE").attr("disabled",false);
            $("#TRACE_STATUS_CODE").attr("disabled",false);
        }
        if(actionType == "ActionType002"){  //Return Visit
            $("#way").html("<spring:message code="hrms.visitWay"/>");
            $("#timeNext").html("<spring:message code="hrms.dateOfNextVisit"/>");
            $("#wayNext").html("<spring:message code="hrms.nextVisitWay"/>");
            $("#PURCHASE_TEND_CODE").val("");
//            $("#PURCHASE_TEND_CODE").attr("disabled","disabled");
            $("#TRACE_STATUS_CODE").val("");
            $("#TRACE_STATUS_CODE").attr("disabled","disabled");
        }
    }
    var tab = parent.tab;
</script>
    <style type="text/css"> 
        body{ margin:0; padding-bottom:15px;overflow: hidden;}
        #layout1{  width:99.8%;margin:0; padding:0;  }   
    </style>
</head>
<body style="padding:2px" > 
<div id="layout1" style="width:99.6%;margin:0; padding:0;">  
    <input type="hidden" id="type" name="type" value='${type}' />
    <input type="hidden" id="custActionNo" value="${custActionNo}">
    <input type="hidden" name="CUST_ID" id="CUST_ID"/> 
        <table width="99.6%" cellpadding="1" cellspacing="1" style="font-size: 12px;">
            <tr style="height: 40px;">
                 <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                <td width="25%" align="left" style="font-weight: bold;">
                    <spring:message code="hrms.activityInformation"/>
                </td>   
                <td  width="65%"  align="right" style="float: right;padding-top:10px;"  id="saveAction"><a class="l-button" style="width: 79px; height: 20px; background-image: url('/resources/images/button/button.gif');" onclick="spf_save()"><spring:message code="hrms.save"/></a></td>
            </tr> 
        </table>
           <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
          <tr> 
               <td width="15%" class="l-table-edit-t"><spring:message code="hrms.createDate"/><font color="red">*</font></td>
               <td width="25%" class="l-table-edit-c" >
                    <input type="text" name="CREATED_DATE"
                    id="CREATED_DATE" value="${DDATE}" size="30" readonly="readonly" />
               </td>
               <td width="15%" class="l-table-edit-t"><spring:message code="hrms.activityStatus"/><font color="red">*</font></td>
                 <td width="25%" class="l-table-edit-c"><SipingSoft:selectSyCode parentCode="CustActionStateCode" name="CUST_ACTION_STATE_CODE" onChange="spf_search();" limit="all" /></td>
               
          </tr>
          <tr> 
          <td width="10%" class="l-table-edit-t"><spring:message code="hrms.customer"/><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">    
                        <input type="text" name="CUST_NAME" id="CUST_NAME"  size="30"/>  
               </td>
             <td width="10%" class="l-table-edit-t"><spring:message code="hrms.activityTime"  /><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">    
                    <input type="text" name="CUST_ACTION_TIME"
                    id="CUST_ACTION_TIME"  size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" />
               </td>
          </tr>
          <tr>
            <td width="10%" class="l-table-edit-t"><spring:message code="hrms.activityType"/><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">    
                        <SipingSoft:selectSyCode parentCode="ActionTypeCode" name="ACTION_TYPE_CODE" onChange="spf_changeType(); " />
               </td>
               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.activityPatterns"/><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                        <SipingSoft:selectSyCode parentCode="CustActionWayCode" name="CUST_ACTION_WAY_CODE" limit="all" />
               </td>
          </tr>
          <tr>
               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.contact"/><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                       <!-- <input type="text" name="CONTACT" id="CONTACT" size="18"/> -->
                         <select id="CONTACT" name="CONTACT" >
                        </select>
                        <label  id="contactTip" style="color: red"></label>
               </td>
               <td width="10%" class="l-table-edit-t"><spring:message code="hrms.intentionToBuyRating"/></td>
               <td width="20%" class="l-table-edit-c" colspan="3">   
                        <SipingSoft:selectSyCode parentCode="PurchaseTendCode" name="PURCHASE_TEND_CODE" limit="all" />
              <%--  </td>
               <td width="10%" class="l-table-edit-t">跟踪状态</td>
               <td width="20%" class="l-table-edit-c">    
                        <SipingSoft:selectSyCode parentCode="TraceStatusCode" name="TRACE_STATUS_CODE" limit="all" />
               </td>       --%>
          </tr>
          <%-- <tr> 
                
               <td width="10%" class="l-table-edit-t"><span id="way"></span><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                        <SipingSoft:selectSyCode parentCode="CustActionWayCode" name="CUST_ACTION_WAY_CODE" limit="all" />
               </td>
               <td width="10%" class="l-table-edit-t"><span id="timeNext"></span><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                    <input type="text" name="TIME_NEXT"
                    id="TIME_NEXT" value="" size="30"
                    onclick="WdatePicker({lang:<spring:message code='dateLanguage'/>,isShowClear:true,readOnly:true,dateFmt:'yyyy-MM-dd'})"
                    readonly="readonly" />
               </td>
          </tr>
          <tr> 
               <td width="10%" class="l-table-edit-t"><span id="wayNext"></span><font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                        <SipingSoft:selectSyCode parentCode="CustActionWayCode" name="WAY_CODE_NEXT" limit="all" />
               </td>
               <td width="10%" class="l-table-edit-t">提醒是否可用<font color="red">*</font></td>
               <td width="20%" class="l-table-edit-c">   
                        <SipingSoft:selectStatus name="REMINDER" />
               </td>
          </tr> --%>
            </table>  
            <table width="99.6%" cellpadding="1" cellspacing="1" style="height:40px;font-size: 12px;">
            <tr>
                <td width="5%" align="center"><img src="/resources/images/title/top_1.gif"/></td>
                <td width="25%" align="left" style="font-weight: bold;">
                    <spring:message code="htms.activityContent"/>
                </td>   
                <td width="65%" align="right">&nbsp;</td>
                <td width="5%" align="left">&nbsp;&nbsp;&nbsp;</td>
            </tr> 
        </table>   
           <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
            <tr> 
               <td width="15%" class="l-table-edit-t"><spring:message code="hrms.contentRecord"/><font color="red">*</font></td>
               <td width="80%" class="l-table-edit-c" >   
                        <textarea rows="10" cols="150" id="CUST_ACTION_CONTENT" name="CUST_ACTION_CONTENT"></textarea>
               </td>
            </tr>
            
          </table>
          </div>  
</body>
</html>
