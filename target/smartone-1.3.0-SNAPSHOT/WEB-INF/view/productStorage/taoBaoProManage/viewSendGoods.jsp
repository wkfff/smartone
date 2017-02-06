<%@ page contentType="text/html; charset=UTF-8" language="java"  errorPage="" %>
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
<script src="/resources/js/ligerUI/js/ligerui.min.js"
    type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script src="/resources/js/My97DatePicker/WdatePicker.js"
    type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<%@ include file="/resources/js/pcc.jsp"%>
<script type="text/javascript">
    $(function(){
        spf_initSellerAddress();
        spf_initLogCompanies();
    });

    function spf_initSellerAddress(){
        $.post("/productStorage/taoBaoProManage/getSellerAddress", 
            function (addressList){
                $("#sellerAddress").html("<option value=''>请选择</option>");
                var temp = "";
                var value = "";
                $(addressList).each(function (index, row){
                    value = JSON.stringify(row).replace(/"/g,'-');
                    temp = '<option value="'+value+'">'+row.contactName+'-'+row.province+'-'+row.city+'-'+row.country+'</option>';
                    $("#sellerAddress").append(temp);
                    temp = "";
                });
            }
        );
    }

    function spf_initLogCompanies(){
        $.post("/productStorage/taoBaoProManage/getLogCompanies", 
            function (companyList){
                $("#company_id").html("");
                var temp = "";
                $(companyList).each(function (index, row){
                    temp = '<option value="'+row.id+'">'+row.name+'</option>';
                    $("#company_id").append(temp);
                    temp = "";
                });
            }
        );
    }
    
    function spf_selectAddress(){
        if($("#sellerAddress").val() == ""){
            $("#s_name").val("");
            $("#s_mobile_phone").val("");
            $("#s_zip_code").val("");
            $("#s_address").val("");
            $("#s_area_id").val("");
        }else{
            var address = eval('('+$("#sellerAddress").val().replace(/-/g,'"')+')');
            $("#s_name").val(address.contactName);
            $("#s_mobile_phone").val(address.mobilePhone);
            $("#s_zip_code").val(address.zipCode);
            $("#s_address").val(address.province+address.city+address.country+address.addr);
            $("#s_area_id").val(address.areaId);
            
            $("#s_prov_name").val(address.province);
            $("#s_city_name").val(address.city);
            $("#s_dist_name").val(address.country);
        }
    }

    function changeProvince(){
        var pro = $("#receiverProvince").val();
        if(pro!=""){
            var addressList = getAreaByParent(pro);
            var temp = "<select class='inputClass' id='receiverCity' onchange='changeCity()'>"+
                        "<option value=''>请选择</option>";
            $(addressList).each(function (index, row){
                temp = temp + '<option value="'+row.CODE_ID+'">'+row.CODE_NAME+'</option>';
            });
            temp = temp + '</select>';
            $("#citySpan").html(temp);
        }else{
            $("#citySpan").html("");
            $("#distSpan").html("");
        }
    }

    function changeCity(){
        var pro = $("#receiverCity").val();
        if(pro!=""){
            var addressList = getAreaByParent(pro);
            var temp = "<select class='inputClass' id='r_area_id' name='r_area_id'>"+
                        "<option value=''>请选择</option>";
            $(addressList).each(function (index, row){
                temp = temp + '<option value="'+row.CODE_ID+'">'+row.CODE_NAME+'</option>';
            });
            temp = temp + '</select>';
            $("#distSpan").html(temp);
        }else{
            $("#distSpan").html("");
        }
    }

    function getAreaByParent(pid){
        var result;
        $.ajax({
            type:'post',
            cache : false,
            contentType : 'application/json',
            url : '/productStorage/taoBaoProManage/getTaoBaoStatus?parentCode='+pid,
            dataType : 'json',
            async: false,
            success : function(data) {
                result = data;
            }
        });
        return result;
    }
    
    function spf_quit(){
        parent.f_closeSendWindow();
    }
    
    function f_saveSend(){
        var flag = true;
        var $input = $(".inputClass");
        for(var i = 0;i<$input.length;i++){
            if($($input[i]).val()==""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请将数据填写完整！');
                flag = false;
                return;
            }
        }
        if(flag){
            if($("#receiverProvince").val()==""){
                $.ligerMessageBox.warn('<spring:message code="hrms.warning"/>', '请将数据填写完整！');
                return;
            }
            var options = {
                url:'/productStorage/taoBaoProManage/saveSend',
                type:'POST',
                success: function (result){
                    $.ligerDialog.closeWaitting();
                    if (result == "Y"){
                        $.ligerDialog.success('<spring:message code="hrms.saveSuccess"/>','<spring:message code="hrms.warning"/>');
                    }else{
                        $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', result);
                    }
                },
                error:function(){
                    $.ligerMessageBox.error('<spring:message code="hrms.warning"/>', '保存失败！');
                }
            };
            $('#form1').ajaxSubmit(options);
        }
    }
</script>
<style type="text/css">
#layout1{
    width:99.8%;
    margin:0;
    padding:0;
}
.titleDiv{
    width:99.8%;
    height:25px;
    line-height:25px;
    font-size:14px;
    font-weight: bold;
    color:#3283be;
    background-color:#c6e3ff;
    border:1px solid #c6e3ff;
}
.contentDiv{
    width:99.8%;
    height:100px;
    background-color:#edf6ff;
    border:1px solid #c6e3ff;
}
.tabClass{
    font-size:12px;
    width:100px;
    text-align:right;
}
.inputClass,select{
    width:150px;
    height:23px;
    color:black;
    background-color: #f4f9ff;
    border:1px solid #c6e3ff;
    font-size:12px;
}
</style>
</head>
<body style="padding:0px">
<div id="layout1" >
    <form name="form1" method="post" action="" id="form1">
    
    <input type="hidden" id="user_id" name="user_id" value="${sessionScope.taoBaoSeller.userId }"/>
    <input type="hidden" id="order_source" name="order_source" value="30"/>
    <input type="hidden" id="order_type" name="order_type" value="30"/>
    <input type="hidden" id="logis_type" name="logis_type" value="2"/>
    <input type="hidden" id="trade_id" name="trade_id" value="${trade.tid }"/>
    <input type="hidden" id="s_area_id" name="s_area_id" value=""/>
    <input type="hidden" id="item_json_string" name="item_json_string" value="${trade.orders }"/>
    
    <input type="hidden" id="s_prov_name" name="s_prov_name" value=""/>
    <input type="hidden" id="s_city_name" name="s_city_name" value=""/>
    <input type="hidden" id="s_dist_name" name="s_dist_name" value=""/>
    
    <input type="hidden" id="r_prov_name" name="r_prov_name" value="${trade.receiverState}"/>
    <input type="hidden" id="r_city_name" name="r_city_name" value="${trade.receiverCity}"/>
    <input type="hidden" id="r_dist_name" name="r_dist_name" value="${trade.receiverDistrict }"/>
    
    <div class="titleDiv">&nbsp;卖家信息</div>
    <div class="contentDiv">
        <table style="width:100%;">
            <tr height="33">
                <td  class="tabClass">卖家地址库:</td>
                <td>
                    <select class="inputClass" id="sellerAddress" onchange="spf_selectAddress()"></select>
                </td>
                <td align="left" colspan="4">
                    <a class="l-button"
                        style="width: 79px;height: 20px;"
                        onclick="spf_initSellerAddress()">刷新地址库</a>
                </td>
            </tr>
            <tr height="33">
                <td class="tabClass">发货人:&nbsp;</td>
                <td><input type="text" class="inputClass" value="" id="s_name" name="s_name"/></td>
                <td class="tabClass">手机号码:&nbsp;</td>
                <td><input type="text" class="inputClass" value="" id="s_mobile_phone" name="s_mobile_phone"/></td>
                <td class="tabClass">邮政编码:&nbsp;</td>
                <td><input type="text" class="inputClass" value="" id="s_zip_code" name="s_zip_code"/></td>
            </tr>
            <tr height="33">
                <td class="tabClass">卖家地址:&nbsp;</td>
                <td colspan="5"><input type="text" class="inputClass" style="width:673px;" id="s_address" name="s_address"
                    value=""/></td>
            </tr>
        </table>
    </div>
    
    <div class="titleDiv">&nbsp;买家信息</div>
    <div class="contentDiv">
        <table style="width:100%;">
            <tr height="33">
                <td class="tabClass">收货人:&nbsp;</td>
                <td><input type="text" class="inputClass" id="r_name" name="r_name" value="${trade.receiverName }"/></td>
                <td class="tabClass">手机号码:&nbsp;</td>
                <td><input type="text" class="inputClass" id="r_mobile_phone" name="r_mobile_phone" value="${trade.receiverMobile }"/></td>
                <td class="tabClass">邮政编码:&nbsp;</td>
                <td><input type="text" class="inputClass" id="r_zip_code" name="r_zip_code" value="${trade.receiverZip }"/></td>
            </tr>
            <tr height="33">
                <td class="tabClass">买家地址:&nbsp;</td>
                <td colspan="5">
                    <span id="provSpan"><SipingSoft:selectSyCode parentCode="BornPlaceCode" name="receiverProvince" limit="all" onChange="changeProvince()"/></span>
                    <span id="citySpan"></span>
                    <span id="distSpan"></span>
                </td>
            </tr>
            <tr height="33">
                <td class="tabClass">收货人地址:&nbsp;</td>
                <td colspan="5">
                    <input type="text" class="inputClass" id="r_address" name="r_address" style="width:673px;"
                        value="${trade.receiverState}${trade.receiverCity}${trade.receiverDistrict }${trade.receiverAddress}"/>
                </td>
            </tr>
        </table>
    </div>
    
    <div class="titleDiv">&nbsp;物流信息</div>
    <div class="contentDiv">
        <table style="width:100%;margin-top:10px;">
            <tr height="40">
                <td class="tabClass">物流公司:&nbsp;</td>
                <td width="160">
                    <select id="company_id" name="company_id" class="inputClass"></select>
                </td>
                <td align="left">
                    <a class="l-button"
                        style="width: 79px;height: 20px;"
                        onclick="spf_initLogCompanies()">刷新物流公司</a>
                </td>
            </tr>
            <tr height="40">
                <td class="tabClass">物流单号:&nbsp;</td>
                <td colspan="2">
                    <input type="text" id="mail_no" name="mail_no" class="inputClass" value=""/>
                </td>
            </tr>
        </table>
    </div>
    </form>
    <table style="width:100%;height:30px;">
        <tr>
            <td align="right">
                <a class="l-button"
                    style="width: 79px;height: 20px;"
                    onclick="javascript:spf_quit()">取消</a>
            </td>
            <td width="100" align="center">
                <a class="l-button"
                    style="width: 79px;height: 20px;"
                    onclick="f_saveSend()">保存</a>
            </td>
        </tr>
    </table>
</div>
</body>
</html>

