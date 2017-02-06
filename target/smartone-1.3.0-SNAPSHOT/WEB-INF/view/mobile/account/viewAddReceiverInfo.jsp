<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Account Manage</title>
<meta name="viewport" content="width=device-width,height=device-height,user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css">

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    //省份tap
    $("#PROVINCE_NAME").live("tap",function(){
        $.mobile.changePage("#provinceDia");
    });
    //省份保存
    $("#saveProvince").live("tap",function(){
        $("#PROVINCE_CODE").val($("#province").val());
        $("#PROVINCE_NAME").val($("#province option:selected").text());
        //将城市和地区清空
        $("#CITY_CODE").val("");
        $("#CITY_NAME").val("");
        $("#AREA_CODE").val("");
        $("#AREA_NAME").val("");
        //将错误信息隐藏
        $("#showProvinceTips").attr("style", "display:none");
    });
    //依据parent_code从sy_code中获取城市list
    function getSelectList(parentCode,selectId) {
        $.post("/mobile/account/getSelectList", 
                [   
                    { name: 'PARENT_CODE', value: parentCode }
                ]
                , function (result){
                    var temp = "<option value=''>请选择</option>";
                    $.each(
                        result,
                        function(i, item) {
                            temp = temp + "<option value='"+item.CODE_ID+"'>"+item.CODE_NAME+"</option>";
                        }
                    );
                    $(selectId).html(temp);
                }
            );
    }
    //城市tap
    $("#CITY_NAME").live("tap",function(){
        $.mobile.changePage("#cityDia");
        getSelectList($("#PROVINCE_CODE").val(),"#citySelect");
    });
    //城市保存
    $("#saveCity").live("tap",function(){
        $("#CITY_CODE").val($("#citySelect option:selected").val());
        $("#CITY_NAME").val($("#citySelect option:selected").text());
        //将注册地址地区清空
        $("#AREA_CODE").val("");
        $("#AREA_NAME").val("");
        $("#showCityTips").attr("style", "display:none");
    });
    //地区tap
    $("#AREA_NAME").live("tap",function(){
        $.mobile.changePage("#areaDia");
        getSelectList($("#CITY_CODE").val(),"#areaSelect");
    });
    //地区select
    $(".updateArea").live("tap",function(){
        getSelectList($("#CITY_CODE").val(),"#areaSelect");
    });
    //地区保存
    $("#saveArea").live("tap",function(){
        $("#AREA_CODE").val($("#areaSelect option:selected").val());
        $("#AREA_NAME").val($("#areaSelect option:selected").text());
        $("#showAreaTips").attr("style", "display:none");
    });
    //提交按钮，绑定屏幕触控事件
    $("#submit").live("tap",function() {
        var height = $(this).offset().top;
        spf_submit(height);
    });
    function spf_submit(height) {
        if(checkInput()){
            $.post('/mobile/account/addReceiver', {
                RECEIVER_NAME : $("#NAME").val(),
                RECEIVER_TELEPHONE : $("#TELEPHONE").val(),
                RECEIVER_MOBILE1 : $("#MOBILE").val(),
                RECEIVER_EMAIL : $("#EMAIL").val(),
                RECEIVER_PROVINCE : $("#PROVINCE_CODE").val(),
                RECEIVER_CITY : $("#CITY_CODE").val(),
                RECEIVER_AREA : $("#AREA_CODE").val(),
                RECEIVER_ADDRESS : $("#ADDRESS").val()
            }, function(result) {
                if (result == "INSERT_SUCCESS") {
                    showTips( "<spring:message code='mobile.addSuccess'/>", height-100, 1 );
                    location.href = "/mobile/account/viewAddReceiverInfo";
                } else { 
                    showTips( "<spring:message code='mobile.addFail'/>", height-100, 1 );
                    location.href = "/mobile/account/viewAddReceiverInfo";
                }
            });
        }
    }
    function checkInput(){
        if(checkName()&checkMobile()&checkProvince()&checkCity()&checkArea()&checkAddress()){
            return true;
        }else{
            return false;
        }
    }
    //检查收货人非空
    function checkName(){
        var name = $("#NAME").val();
        if (name == "") {
            $("#showNameTips").attr("style", "display:block");
            $("#showNameTips").text("<spring:message code='mobile.inputReceiver'/>");
            return;
        }else {
            $("#showNameTips").attr("style", "display:none");
            return true;
        }
    }
    //检查手机号码非空
    function checkMobile(){
        var mobile = $("#MOBILE").val();
        if (mobile == "") {
            $("#showMobileTips").attr("style", "display:block");
            $("#showMobileTips").text("<spring:message code='mobile.inputMobile'/>");
            return;
        }else {
            $("#showMobileTips").attr("style", "display:none");
            return true;
        }
    }
    //检查省份非空
    function checkProvince(){
        var name = $("#PROVINCE_NAME").val();
        if (name == "") {
            $("#showProvinceTips").attr("style", "display:block");
            $("#showProvinceTips").text("<spring:message code='mobile.inputProvince'/>");
            return;
        }else {
            $("#showProvinceTips").attr("style", "display:none");
            return true;
        }
    }
    //检查城市非空
    function checkCity(){
        var name = $("#CITY_NAME").val();
        if (name == "") {
            $("#showCityTips").attr("style", "display:block");
            $("#showCityTips").text("<spring:message code='mobile.inputCity'/>");
            return;
        }else {
            $("#showCityTips").attr("style", "display:none");
            return true;
        }
    }
    //检查地区非空
    function checkArea(){
        var name = $("#AREA_NAME").val();
        if (name == "") {
            $("#showAreaTips").attr("style", "display:block");
            $("#showAreaTips").text("<spring:message code='mobile.inputArea'/>");
            return;
        }else {
            $("#showAreaTips").attr("style", "display:none");
            return true;
        }
    }
    //检查详细地址非空
    function checkAddress(){
        var name = $("#ADDRESS").val();
        if (name == "") {
            $("#showAddressTips").attr("style", "display:block");
            $("#showAddressTips").text("<spring:message code='mobile.inputDetailAddress'/>");
            return;
        }else {
            $("#showAddressTips").attr("style", "display:none");
            return true;
        }
    }
</script>
<style>
    div{
        font-family:"微软雅黑";
        font-size:1em;
    }
    div[data-role="page"]{
        height:100%;
    }
    div[data-role="content"]{
        height:100%;
        background-color:#eeeeee;
    }
    .tips{
        display: none;
        color:red;
    }
    .ui-input-text{
        background-color:#ffffff;
    }
</style>
</head>
<body>
    <div data-role="page" id="mainPage" data-theme="b">
        <div data-role="header" data-theme="b">
           <h1><spring:message code='mobile.addReceiver'/></h1>
        </div>
        <div data-role="content">
            <div style="clear:both;">
                <img id="backToAccountManage" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
            </div>
            <table id="companyInformation">
                <tbody>
                    <tr>
                        <td>
                            <spring:message code='hrms.deliveryAddress'/>
                        </td>
                    </tr>
                    <tr>
                        <td width="80">
                            <spring:message code='mobile.province'/>
                            <font color="red">*</font>
                        </td>
                        <td>
                            <input type="hidden" id="PROVINCE_CODE" />
                            <input type="text" id="PROVINCE_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" readOnly/>
                            <span class="tips" id="showProvinceTips"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.city'/>
                            <font color="red">*</font>
                        </td>
                        <td>
                            <input type="hidden" id="CITY_CODE" />
                            <input type="text" id="CITY_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" readOnly/>
                            <span class="tips" id="showCityTips"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.area'/>
                            <font color="red">*</font>
                        </td>
                        <td>
                            <input type="hidden" id="AREA_CODE" />
                            <input type="text" id="AREA_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" readOnly/>
                            <span class="tips" id="showAreaTips"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.fullAddress'/>
                            <font color="red">*</font>
                        </td>
                        <td colspan="2">
                            <input type="text" id="ADDRESS" onblur="checkAddress()"/>
                            <span class="tips" id="showAddressTips"></span>
                        </td>
                    </tr>
                    <tr>
                       <td>
                            <spring:message code='hrms.consignee'/>
                            <font color="red">*</font>
                       </td>
                       <td colspan="2">
                            <input id="NAME" type="text" onblur="checkName()"/>
                            <span class="tips" id="showNameTips"></span>
                      </td>
                    </tr>
                    <tr>
                       <td>
                            <spring:message code='hrms.phoneNumber'/>
                            <font color="red">*</font>
                       </td>
                       <td colspan="2">
                            <input id="MOBILE" type="text" onblur="checkMobile()"/>
                            <span class="tips" id="showMobileTips"></span>
                       </td>
                    </tr>
                    <tr>
                       <td><spring:message code='hrms.fixedTelephone'/></td>
                       <td colspan="2"><input id="TELEPHONE" type="text"/></td>
                    </tr>
                    <tr>
                       <td><spring:message code='hrms.e-mail'/></td>
                       <td colspan="2"><input id="EMAIL" type="text"/></td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <input type="button" value="<spring:message code='submit'/>" id="submit" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div data-role="page" id="provinceDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.province'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><SipingSoft:selectSyCode parentCode="BornPlaceCode" name="province" limit="all"/></td>
                </tr>
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveProvince" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="cityDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.city'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="citySelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveCity" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="areaDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.area'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="areaSelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveArea" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>