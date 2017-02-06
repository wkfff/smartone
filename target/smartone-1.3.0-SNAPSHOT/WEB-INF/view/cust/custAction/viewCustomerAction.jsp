<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title></title>
<head>   
<meta http-equiv="X-UA-Compatible" content="IE=edge" >
<%!
    int week=0;
    int first=0;
%>
<!-- CSS -->
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link href="/resources/css/default.css" rel="stylesheet" type="text/css"> 
<!-- JS -->
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>  
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script> 
<script src="/resources/js/ligerUI/js/plugins/ligerGrid.js" type="text/javascript"></script> 
<script src="/resources/js/json2.js" type="text/javascript"></script>
<script type="text/javascript">
var $dialog;
    // 初始调用
    $(function ()
   {
        //布局
        $("#layout1").ligerLayout({
            topHeight: "100%",
            allowLeftResize: false,      //是否允许 左边可以调整大小
            allowRightResize: false,     //是否允许 右边可以调整大小
            allowTopResize: false,       //是否允许 头部可以调整大小
            allowBottomResize: false     //是否允许 底部可以调整大小
        });
        spf_getWhInfo();
        init_css();
    });

    function init_css()
    {
        $("[name='month'],[name='year']").css({width:"80px",height:"20px","font-size":"14px"});	
        $("[name='empName']").css({width:"80px",height:"20px","font-size":"12px"});
    }
    function spf_search()
    {
        var year = $("#year").val() ;
        var month = $("#month").val() ;
        //alert(month);
        var empID = $("#EMPID").val() ;
        
        location.href =  '/cust/custAction/viewCustomerAction?year=' + year + "&month=" + month +"&EMPID="+empID;  
    }

    function gotob()
    {
        var year = $("#year").val() ;
        var month = $("#month").val() ;
        var empID = $("#EMPID").val() ;

        var myDate=new Date();
        myDate.setFullYear(year, month, 1);
        month = myDate.getMonth() ;

        if(month==1||month == 0)
        {
            year=Number(year)-Number(1);
            month=12;
        }
        else if(month>1&&month<=12)
        {
            month=Number(month)-1;
        }

        month = month < 10 ? "0" + month : "" + month ;
        
        location.href =  '/cust/custAction/viewCustomerAction?year=' + year + "&month=" + month +"&EMPID="+empID;  
    }

    function gotoa()
    {
        var year = $("#year").val() ;
        var month = $("#month").val() ;
        var empID = $("#EMPID").val() ;

        var myDate=new Date();
        myDate.setFullYear(year, month, 1);
        month = myDate.getMonth() ;
        
        if(month == 12||month == 0)
        {
            year = Number(year) + Number(1);
            month = 1;
        }
        else if(month >= 1 && month < 12)
        {
            month = Number(month) + Number(1) ;
        }

        month = month < 10 ? "0" + month : "" + month ;

        location.href =  '/cust/custAction/viewCustomerAction?year=' + year + "&month=" + month +"&EMPID="+empID;  
    }

    function spf_getWhInfo()
    {
        var year = $("#year").val() ;
        var month = $("#month").val() ;
        var empID = $("#EMPID").val() ;
        $.ajax({
            type: 'post',
            url: '/cust/custAction/getCustActionByCondition?EMP_ID='+empID+'&CUST_ACTION_TIME='+ year+'-'+month+'&ACTIVITY=4', 
            dataType: 'json',
            async: false,
            success: function (result)
            {
                 var content='';
                 $('.weekday').find("ul li:not(li:last)").remove();
                for(var i=0;i<result.length;i++){
                    if(result[i].empId.length>=7){
                        content = result[i].empId.substring(0,7)+'..';//empId里面映射的是客户名字
                    }else
                    {
                        content = result[i].empId;
                    }
                    //alert('#div_'+actionTime+' 00:00:00.0');
                    var litag = '<li class="action">';
                    var atag = '<a class="updateevent" id="'+result[i].custActionNo+'" onclick="updateEvent(event);" style="padding-left:5px;" href="javascript:;" ><i class="ico_square"></i>'+content+'<span style="float:right;margin-right:10px;color:#0e8ec2;">'+result[i].actionState.codeName+'</span>';
                    $('#div_'+result[i].actionTime+'>div>ul').prepend(litag+atag+'</a></li>');
                    content=''; 
                } 
            }
        }); 
    }
    
    function spf_afterAddOrRemove()
    {
        spf_search();
    }
    
    function updateEvent(event)
    {
        var obj = event.srcElement || event.target;
        var custActionNo = obj.getAttribute('id');
        var height=$(document.body).height()-120;
        var width=$(document.body).width()-200;
        $dialog = $.ligerWindow.show({
                title: '修改活动',
                width: width , 
                height: height , 
            url: '/cust/custAction/updateCustomerAction?custActionNo='+custActionNo
            });
    }
    
    function addEvent(event)
    {
        var obj = event.srcElement || event.target;
        var ddate = obj.getAttribute('date');
        var height=$(document.body).height()-120;
        var width=$(document.body).width()-250;
        var empId = $("#EMPID").val() ;
        $dialog = $.ligerWindow.show({
                title: '新建活动',
                width:width , 
                height: height, 
            url: '/cust/custAction/addCustomerAction?DDATE='+ddate+'&empId='+empId
            });
    }
    function viewmore(event)
    {
        var obj = event.srcElement || event.target;
        selectDay(obj.parentNode.firstElementChild);
        expandDiv(obj.parentNode.firstElementChild);
        var st = obj.parentNode.firstElementChild.style;
    }
    
    function selectDay(obj)
    {
        var oldobjs = $('.expand_div').removeClass('expand_div');
        var oldobjs=$('.date_selected').removeClass('date_selected');
        /*document.getElementsByClassName('date_selected');
        for (var i=0; i<oldobj.length; i++ ) {
            oldobj[i].className = oldobj[i].className.replace(new RegExp("\\s*\\bdate_selected\\b", "g"), "");
            }*/
        obj.className +=(obj.className? " " : "")+'date_selected';
        if(obj.parentNode.getElementsByTagName('ul')[0].getElementsByTagName('li').length>4)
        {
            obj.className +=(obj.className? " " : "")+'expand_div';
        }
    }
    
    function expandDiv(obj)
    {
        var oldobjs = $('.expand_div').removeClass('expand_div');
        /*document.getElementsByClassName('date_selected');
        for (var i=0; i<oldobj.length; i++ ) {
            oldobj[i].className = oldobj[i].className.replace(new RegExp("\\s*\\bdate_selected\\b", "g"), "");
            }*/
        obj.className +=(obj.className? " " : "")+'expand_div';
    }

    function spf_initSelectEmpInfo(employee)
    {
        $("#ownerName").val(employee.CHINESENAME);
        $("#EMPID").val(employee.EMPID);
        spf_getWhInfo();
        $dialog.close();
    }
    
    function searchEmp(){
        $dialog = $.ligerDialog.open({
            isDrag: false,width: 800, height: 400,
            title:'<spring:message code="employee.information"/>',
            url: '/utility/empInfo/viewCustSearchEmployee'
        });

   }
    </script>
<style type="text/css"> 
     body { padding:5px; margin:0; padding-bottom:15px;}
     #layout1{width:99.8%;margin:0; padding:0;  }
     .date_selected {background-color: #FFFFFF;border: 1px solid #93D4FC;border-collapse: separate;box-shadow: 0 0 5px #60CAFF;}
     
     .weekday{height:90px; width:100px;}
     .weekday .month_event  li{list-style: none;color:red;}
     
     .date_box{position:relative;height:100%;width:100%;font-family: georgia;font-size: 13px;}
     
     .date_box_in{position:absolute;z-index:1;top:0;left:0;height:100%;width:100%;font-family: georgia;font-size: 13px;}
     .expand_div{background-color: #FFFFFF;z-index:10;left:-15px;top:-15px;width:120%;height:auto}
     
     .month_date {color: #B2B7BF;height: 20px;line-height: 20px;padding: 0 8px;text-align: left;}
     .day_type{float: right;}
     
     .expand_div .month_event{height:100%;}
     .month_event{text-align: left;width:100%;height:70px;overflow:hidden;}
     .ico_square{background-color: #949494;float: left;height: 5px;margin: 5px 0 0 2px;overflow: hidden;width: 5px;}
     
     .updateevent{text-decoration:none;height: 20px;color: #202020;}
     
     .addevent{text-decoration:none;color:#FFFFFF;display:none;}
     .date_selected .addevent{text-decoration:none;color: #0000FF;display:block;}
     .date_box:hover .addevent{text-decoration:none;color: #0000FF;display:block;}
     
     .more_event{position:absolute;z-index:2;display:none;bottom:0;height:10px;width:100%;text-align: center;}
     
     .selected_border {border: 1px solid transparent;bottom: -1px;height: auto;left: -1px;overflow: hidden;position: relative;right: 0;top: 0;width: 100%;}
     .arrow_b{border-style: solid dashed dashed;border-color: #000000 transparent transparent;text-align: center;border-width: 4px 4px 0;cursor: pointer;border-top-color: #999999;display: inline-block;font-size: 0;line-height: 0;width: 0;}
</style>
</head>
<body style="padding:2px" >
<div id="layout1" > 
   <div position="top"> 
                <table width="100%" border="0" >
                    <tr><td height="2"></td></tr>
                    <tr>
                        <td align="center" valign="middle"> 
                            <table width="99.6%" align="center" cellpadding="0" cellspacing="0" class="l-table-edit_01" border="1xp" bordercolor="#A3C0E8">
                                <tr  style="height: 30px;">
                                    <td class="l-table-edit-t" colspan="7">
                                        <img alt="" src="/resources/images/icon-prev.gif" onclick="javascript:gotob();" style="cursor: pointer;vertical-align: middle;">
                                       &nbsp;&nbsp;&nbsp;
                                       <SipingSoft:date yearName="year" yearSelected="${param.year}" monthName="month" monthSelected="${param.month}" onChange="spf_search();"/>
                                        <input type="hidden" id="EMPID" name="EMPID" value="${basicInfo.EMPID}">
                                        &nbsp;&nbsp;&nbsp;
                                        <img alt="" src="/resources/images/icon-next.gif" onclick="javascript:gotoa();" style="cursor: pointer;vertical-align: middle;padding-right: 30px;">
                                         
                                         <c:if test="${isSupervisor}">
                                            客户经理：
                                            <input type="text" name="empName" id="ownerName" onclick="searchEmp()" value="${basicInfo.CHINESENAME}" size="30" />
                                        </c:if>
                                    
                                    </td> 
                              </tr>
                              <tr>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><font color="red"><spring:message code="calendar.sunday"/></font></td>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><spring:message code="calendar.monday"/></td>
                                <td height="22" width="100" align="center" style="font-size: 12px;"><spring:message code="calendar.tuesday"/></td>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><spring:message code="calendar.wednesday"/></td>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><spring:message code="calendar.thursday"/></td>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><spring:message code="calendar.friday"/></td>
                                <td height="25" width="100" align="center" style="font-size: 12px;"><font color="red"><spring:message code="calendar.saturday"/></font></td>
                              </tr>
                              <tr>
                                <td height="30px" colspan="7"></td>
                              </tr>
                              <c:if test="${head!=0}">
                                  <tr>
                                  <c:forEach var="i" begin="0" end="${head-1}">
                                    <td class="weekday"></td>
                                  </c:forEach>
                              </c:if>
                              <c:forEach var="day" items="${calendarList}">
                                <c:if test="${day.IWEEK==\"0\"}">
                                    <tr>
                                </c:if>
                                <td class="weekday">
                                    <div date="<c:out value="${day.DDATE}"/>" id="div_<c:out value="${day.DDATE}"/>" class="date_box">
                                        <div class="date_box_in" onclick="selectDay(this);">
                                            <div class="month_date">
                                                <span class="month_date"><c:out value="${day.IDAY}"/>日</span>
                                                <span class="day_type"><c:out value="${day.TYPE_NAME}"/></span>
                                            </div>
                                            <ul class="month_event">
                                                <li>
                                                    <a class="addevent" date="<c:out value="${day.DDATE}"/>" onclick="addEvent(event);" href="javascript:;">新建活动..</a>
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="more_event" onclick="viewmore(event);"><span class="arrow_b"></span></div>
                                    </div>
                                </td>
                                <c:if test="${day.IWEEK==\"6\"}">
                                    </tr>
                                    <c:set var="week" value="${week+1}"></c:set>
                                </c:if>
                              </c:forEach>
                              <c:if test="${end!=6}">
                                  <c:forEach var="i" begin="${end+1}" end="6">
                                    <td class="weekend"></td>
                                  </c:forEach>
                                  </tr>
                              </c:if>
                           </table>  
                        </td>
                    </tr>
                </table> 
      </div>  
</div>    
</body>
</html>
