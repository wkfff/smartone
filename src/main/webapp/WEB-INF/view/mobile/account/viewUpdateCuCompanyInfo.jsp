<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<!doctype html>
<html>
<head>
<title>Account Manage</title>
<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0" >
<link rel="stylesheet" href="/resources/css/mobile/jquery.mobile-1.3.2.min.css">

<script src="/resources/js/jquery/jquery-1.7.2.min.js"></script>
<script src="/resources/js/jquery/jquery.mobile-1.3.2.min.js"></script>
<script src="/resources/js/mobile/mobile.js"></script>

<script type="text/javascript">
    //注册地址：省份tap
    $("#REG_PRO_NAME").live("tap",function(){
        $.mobile.changePage("#regProDia");
    });
    //注册地址：省份保存
    $("#saveRegPro").live("tap",function(){
        $("#REG_PRO_CODE").val($("#registerPro").val());
        $("#REG_PRO_NAME").val($("#registerPro option:selected").text());
        //将注册地址中的城市和地区清空
        $("#REG_CITY_CODE").val("");
        $("#REG_CITY_NAME").val("");
        $("#REG_AREA_CODE").val("");
        $("#REG_AREA_NAME").val("");
    });
    //办公地址：省份tap
    $("#OFF_PRO_NAME").live("tap",function(){
        $.mobile.changePage("#offProDia");
    });
    //办公地址：省份保存
    $("#saveOffPro").live("tap",function(){
        $("#OFF_PRO_CODE").val($("#officePro").val());
        $("#OFF_PRO_NAME").val($("#officePro option:selected").text());
        //将办公地址中的城市和地区清空
        $("#OFF_CITY_CODE").val("");
        $("#OFF_CITY_NAME").val("");
        $("#OFF_AREA_CODE").val("");
        $("#OFF_AREA_NAME").val("");
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
    //注册地址：城市tap
    $("#REG_CITY_NAME").live("tap",function(){
        $.mobile.changePage("#regCityDia");
        getSelectList($("#REG_PRO_CODE").val(),"#regCitySelect");
    });
    //注册地址城市保存
    $("#saveRegCity").live("tap",function(){
        $("#REG_CITY_CODE").val($("#regCitySelect option:selected").val());
        $("#REG_CITY_NAME").val($("#regCitySelect option:selected").text());
        //将注册地址地区清空
        $("#REG_AREA_CODE").val("");
        $("#REG_AREA_NAME").val("");
    });
    //办公地址：城市tap
    $("#OFF_CITY_NAME").live("tap",function(){
        $.mobile.changePage("#offCityDia");
        getSelectList($("#OFF_PRO_CODE").val(),"#offCitySelect");
    });
    //办公地址城市保存
    $("#saveOffCity").live("tap",function(){
        $("#OFF_CITY_CODE").val($("#offCitySelect option:selected").val());
        $("#OFF_CITY_NAME").val($("#offCitySelect option:selected").text());
        //将办公地址地区清空 
        $("#OFF_AREA_CODE").val("");
        $("#OFF_AREA_NAME").val("");
    });
    //注册地址：地区tap
    $("#REG_AREA_NAME").live("tap",function(){
        $.mobile.changePage("#regAreaDia");
        getSelectList($("#REG_CITY_CODE").val(),"#regAreaSelect");
    });
    //注册地址地区保存
    $("#saveRegArea").live("tap",function(){
        $("#REG_AREA_CODE").val($("#regAreaSelect option:selected").val());
        $("#REG_AREA_NAME").val($("#regAreaSelect option:selected").text());
    });
    //注册地址：城市tap
    $("#OFF_AREA_NAME").live("tap",function(){
        $.mobile.changePage("#offAreaDia");
        getSelectList($("#OFF_CITY_CODE").val(),"#offAreaSelect");
    });
    //办公地址城市保存
    $("#saveOffArea").live("tap",function(){
        $("#OFF_AREA_CODE").val($("#offAreaSelect option:selected").val());
        $("#OFF_AREA_NAME").val($("#offAreaSelect option:selected").text());
    });
    //提交按钮，绑定屏幕触控事件
    $("#submit").live("tap",function() {
        var height = $(this).offset().top;
        spf_submit(height);
    });
    function spf_submit(height) {
        if(checkInput()) {
            $.post('/mobile/account/updateCustInfo', {
                CUST_NAME : $("#COMPANY_NAME").val(),
                TELEPHONE : $("#COMPANY_TELEPHONE").val(),
                EMAIL : $("#COMPANY_EMAIL").val(),
                PROVINCE : $("#REG_PRO_CODE").val(),
                CITY : $("#REG_CITY_CODE").val(),
                AREA : $("#REG_AREA_CODE").val(),
                ADDRESS : $("#REG_DETAIL_ADDR").val(),
                OFFICE_PROVINCE : $("#OFF_PRO_CODE").val(),
                OFFICE_CITY : $("#OFF_CITY_CODE").val(),
                OFFICE_AREA : $("#OFF_AREA_CODE").val(),
                OFFICE_ADDRESS : $("#OFF_DETAIL_ADDR").val(),
                BANK : $("#BANK").val(),
                BANK_ACCOUNT : $("#BANK_ACCOUNT").val(),
                TAXPAYER_IDCODE : $("#NPWP").val()
            }, function(result) {
                if (result == "UPDATE_SUCCESS") {
                    showTips( "<spring:message code='mobile.updateSuccess'/>", height-100, 1 );
                    location.href = "/mobile/account/viewUpdateCuCompanyInfo";
                } else { 
                    showTips( "<spring:message code='mobile.updateFail'/>", height-100, 1 );
                    location.href = "/mobile/account/viewUpdateCuCompanyInfo";
                }
            });
        }
    }
    //必填项非空检查
    function checkInput(){
        if(checkCompanyName()&&checkCompanyTel()) {
            return true;
        }else {
            return false;
        }
    }
    //检查公司名称非空
    function checkCompanyName(){
        var companyName = $("#COMPANY_NAME").val();
        if (companyName == "") {
            $("#showCompanyNameTips").attr("style", "display:block");
            $("#showCompanyNameTips").text("<spring:message code='mobile.inputFullCompanyName'/>");
            return;
        }else {
            $("#showCompanyNameTips").attr("style", "display:none");
            return true;
        }
    }
    //检查公司电话非空
    function checkCompanyTel(){
        var companyTel = $("#COMPANY_TELEPHONE").val();
        if (companyTel == "") {
            $("#showCompanyTelTips").attr("style", "display:block");
            $("#showCompanyTelTips").text("<spring:message code='mobile.inputCompanyTel'/>");
            return;
        }else {
            $("#showCompanyTelTips").attr("style", "display:none");
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
           <h1><spring:message code='mobile.modifyEnterpriseInformation'/></h1>
        </div>
        <div data-role="content" style="background-color:#eeeeee;">
            <div>
                <img id="backToAccountManage" src="/resources/images/myimage/back.png" style="width:40px;height:40px;"/>
            </div>
            <table id="companyInformation">
                <tbody>
                    <tr >
                        <td width="80" style="border-top: 1px dashed #cccccc;">
                            <spring:message code='mobile.companyName'/>
                            <font color="red">*</font>
                        </td>
                        <td colspan="2" style="border-top: 1px dashed #cccccc;">
                            <input id="COMPANY_NAME" type="text" value="${CUSTOMER.CUST_NAME }" onblur="checkCompanyName()"/>
                            <span class="tips" id="showCompanyNameTips"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.companyTelephone'/>
                            <font color="red">*</font>
                        </td>
                        <td colspan="2">
                            <input id="COMPANY_TELEPHONE" type="text" value="${CUSTOMER.TELEPHONE }" onblur="checkCompanyTel()"/>
                            <span class="tips" id="showCompanyTelTips"></span>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='hrms.e-mail'/>
                        </td>
                        <td colspan="2">
                            <input id="COMPANY_EMAIL" type="text" value="${CUSTOMER.EMAIL }" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-top: 1px dashed #cccccc;">
                            <spring:message code='mobile.registeredAddress'/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.province'/>
                        </td>
                        <td>
                            <input type="hidden" id="REG_PRO_CODE" value="${CUSTOMER.REG_PRO_CODE }"/>
                            <input type="text" id="REG_PRO_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                                readOnly value="${CUSTOMER.REG_PRO_NAME }"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.city'/>
                        </td>
                        <td>
                            <input type="hidden" id="REG_CITY_CODE" value="${CUSTOMER.REG_CITY_CODE }"/>
                            <input type="text" id="REG_CITY_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                               value="${CUSTOMER.REG_CITY_NAME }" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.area'/>
                        </td>
                        <td>
                            <input type="hidden" id="REG_AREA_CODE" value="${CUSTOMER.REG_AREA_CODE }"/>
                            <input type="text" id="REG_AREA_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                               value="${CUSTOMER.REG_AREA_NAME }" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.fullAddress'/>
                        </td>
                        <td colspan="2">
                            <input type="text" id="REG_DETAIL_ADDR" value="${CUSTOMER.REG_DETAIL_ADDR }"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style="border-top: 1px dashed #cccccc;">
                            <spring:message code='mobile.officeAddress'/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.province'/>
                        </td>
                        <td>
                            <input type="hidden" id="OFF_PRO_CODE" value="${CUSTOMER.OFF_PRO_CODE }"/>
                            <input type="text" id="OFF_PRO_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                               value="${CUSTOMER.OFF_PRO_NAME }" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <spring:message code='mobile.city'/>
                        </td>
                        <td>
                            <input type="hidden" id="OFF_CITY_CODE" value="${CUSTOMER.OFF_CITY_CODE }"/>
                            <input type="text" id="OFF_CITY_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                               value="${CUSTOMER.OFF_CITY_NAME }" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.area'/>
                        </td>
                        <td>
                            <input type="hidden" id="OFF_AREA_CODE" value="${CUSTOMER.OFF_AREA_CODE }"/>
                            <input type="text" id="OFF_AREA_NAME" placeholder="<spring:message code='mobile.clickModifyToChoose'/>" 
                               value="${CUSTOMER.OFF_AREA_NAME }" readOnly/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.fullAddress'/>
                        </td>
                        <td  colspan="2">
                            <input type="text" id="OFF_DETAIL_ADDR" value="${CUSTOMER.OFF_DETAIL_ADDR }"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="border-top: 1px dashed #cccccc;">
                            <spring:message code='mobile.bankName'/>
                        </td>
                        <td colspan="2" style="border-top: 1px dashed #cccccc;">
                            <input id="BANK" type="text" value="${CUSTOMER.BANK }" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.bankAccount'/>
                        </td>
                        <td colspan="2">
                            <input id="BANK_ACCOUNT" type="text" value="${CUSTOMER.BANK_ACOUNT }" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <spring:message code='mobile.NPWP'/>
                        </td>
                        <td colspan="2">
                            <input id="NPWP" type="text" value="${CUSTOMER.TEXPAYER_IDCODE }" />
                        </td>
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
    <div data-role="page" id="regProDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.province'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><SipingSoft:selectSyCode parentCode="BornPlaceCode" name="registerPro" limit="all"/></td>
                </tr>
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveRegPro" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="regCityDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.city'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="regCitySelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveRegCity" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="regAreaDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.area'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="regAreaSelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveRegArea" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="offProDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.province'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <table style="width:100%;">
                <tr>
                    <td><SipingSoft:selectSyCode parentCode="BornPlaceCode" name="officePro" limit="all"/></td>
                </tr>
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveOffPro" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="offCityDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.city'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="offCitySelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveOffCity" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
    <div data-role="page" id="offAreaDia" data-theme="b">
        <div data-role="header" data-theme="b">
            <h1><spring:message code='mobile.area'/></h1>
        </div>
        <div data-role="content" style="background-color: white;font-size:12px;color: #456f9a;font-family: '微软雅黑';">
            <select id="offAreaSelect">
            </select>
            <table style="width:100%;">
                <tr>
                    <td align="right"><div style="width:100px;"><a href="#mainPage" id="saveOffArea" data-role="button"><spring:message code='hrms.save'/></a></div></td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>