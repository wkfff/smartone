<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<script type="text/javascript">

//取所有省份
function getIdCardProvince(proCode, cityCode, countyCode) {
    //&callback=?"注意这个是为了解决跨域访问的问题
    $.post('/utility/otherInfo/getAreasByParentID', {"areaId": 'BornPlaceCode'}, function (result) {
                setIdCardProvince(result, proCode, cityCode, countyCode);
            }
    );
}
//取所有省份
function getHomeProvince(proCode, cityCode, countyCode) {
    //&callback=?"注意这个是为了解决跨域访问的问题
    $.post('/utility/otherInfo/getAreasByParentID', {"areaId": 'BornPlaceCode'}, function (result) {
                setHomeProvince(result, proCode, cityCode, countyCode);
            }
    );
}
//取所有省份
function getProvince(proCode, cityCode, countyCode) {
    //&callback=?"注意这个是为了解决跨域访问的问题
    $.post('/utility/otherInfo/getAreasByParentID', {"areaId": 'BornPlaceCode'}, function (result) {
                setProvince(result, proCode, cityCode, countyCode);
            }
    );
}
//设置省份
function setIdCardProvince(result, proCode, cityCode, countyCode) {
    var index = "0";
    var IDCARD_PROVINCE = document.getElementById("IDCARD_PROVINCE");

    var jsonList = eval("(" + result + ")");

    var option = new Option('<spring:message code="hrms.selection"/>', "");
    IDCARD_PROVINCE.options.add(option);
    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (proCode == value){
                index = i + 1;
            }
        }
        option = new Option(text, value);
        IDCARD_PROVINCE.options.add(option);
    }
    if (index != '0') {
        IDCARD_PROVINCE[index].selected = true;
        getArea('city', 'IdCard', cityCode, countyCode);
    }
}
function setHomeProvince(result, proCode, cityCode, countyCode) {
    var index = "0";
    var HOME_PROVINCE = document.getElementById("HOME_PROVINCE");

    var jsonList = eval("(" + result + ")");

    var option = new Option('<spring:message code="hrms.selection"/>', "");
    HOME_PROVINCE.options.add(option);
    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (proCode == value){
                index = i + 1;
            }
        }
        option = new Option(text, value);
        HOME_PROVINCE.options.add(option);
    }
    if (index != '0') {
        HOME_PROVINCE[index].selected = true;
        getArea('city', 'Home', cityCode, countyCode);
    }
}
function setProvince(result, proCode, cityCode, countyCode) {
    var index = "0";
    var PROVINCE = document.getElementById("PROVINCE");

    var jsonList = eval("(" + result + ")");

    var option = new Option('<spring:message code="hrms.selection"/>', "");
    PROVINCE.options.add(option);
    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (proCode == value){
                index = i + 1;
            }
        }
        option = new Option(text, value);
        PROVINCE.options.add(option);
    }
    if (index != '0') {
        PROVINCE[index].selected = true;
        getArea('city', '', cityCode, countyCode);
    }
}
//按上级ID取子地区
function getArea(name, id, cityCode, countyCode) {
    if (name == 'city') {
        var IDCARD_PROVINCE = "";
        var HOME_PROVINCE = "";
        var PROVINCE = "";
        var areaId = "";
        if (id == 'IdCard') {
            clearSel(document.getElementById("IDCARD_CITY")); //清空城市
            IDCARD_PROVINCE = document.getElementById("IDCARD_PROVINCE");
            if (IDCARD_PROVINCE.options[IDCARD_PROVINCE.selectedIndex].value == "") return;
            areaId = IDCARD_PROVINCE.options[IDCARD_PROVINCE.selectedIndex].value;
        }
        if (id == 'Home') {
            clearSel(document.getElementById("HOME_CITY")); //清空城市
            HOME_PROVINCE = document.getElementById("HOME_PROVINCE");
            if (HOME_PROVINCE.options[HOME_PROVINCE.selectedIndex].value == "") return;
            areaId = HOME_PROVINCE.options[HOME_PROVINCE.selectedIndex].value;
        }
        if (id == '') {
            clearSel(document.getElementById("CITY")); //清空城市
            PROVINCE = document.getElementById("PROVINCE");
            if (PROVINCE.options[PROVINCE.selectedIndex].value == "") return;
            areaId = PROVINCE.options[PROVINCE.selectedIndex].value;
            //alert(PROVINCE);
        }

        $.post('/utility/otherInfo/getAreasByParentID', {"areaId": areaId}, function (result) {
                    if (id == 'IdCard') {
                        setIdCardCity(result, cityCode, countyCode);
                    }
                    if (id == 'Home') {
                        setHomeCity(result, cityCode, countyCode);
                    }
                    if (id == '') {
                        //alert(0);
                        setCity(result, cityCode, countyCode);
                    }
                }

        );
    } else if (name == 'county') {
        var IDCARD_CITY = "";
        var HOME_CITY = "";
        var CITY = "";
        var areaId = "";
        if (id == 'IdCard') {
//			  clearSel(document.getElementById("IDCARD_AREA")); //清空城区
            IDCARD_CITY = document.getElementById("IDCARD_CITY");
            if (IDCARD_CITY.options[IDCARD_CITY.selectedIndex].value == "") return;
            areaId = IDCARD_CITY.options[IDCARD_CITY.selectedIndex].value;
        }
        if (id == 'Home') {
            clearSel(document.getElementById("HOME_AREA")); //清空城区
            HOME_CITY = document.getElementById("HOME_CITY");
            if($("#HOME_CITY").val() === null) {
                return;
            }
            areaId = HOME_CITY.options[HOME_CITY.selectedIndex].value;
        }
        if (id == '') {
            clearSel(document.getElementById("AREA")); //清空城区
            CITY = document.getElementById("CITY");
            if (CITY.options[CITY.selectedIndex].value == "") return;
            areaId = CITY.options[CITY.selectedIndex].value;
        }

        $.post('/utility/otherInfo/getAreasByParentID', {"areaId": areaId}, function (result) {
//			  if(id=='IdCard'){
//				setIdCardCounty(result,cityCode,countyCode);
//			  }
                    if (id == 'Home') {
                        setHomeCounty(result, cityCode, countyCode);
                    }
                    if (id == '') {
                        setCity(result, cityCode, countyCode);
                    }
                }
        );
    }
}
//当改变省份时设置城市
function setIdCardCity(result, cityCode, countyCode) {
    var index = "0";
    var IDCARD_CITY = document.getElementById("IDCARD_CITY");
    var jsonList = eval("(" + result + ")");

    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (cityCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        IDCARD_CITY.options.add(option);
    }
    if (index != '0') {
        IDCARD_CITY[index].selected = true;
    }
    getArea('county', 'IdCard', cityCode, countyCode);
}
function setHomeCity(result, cityCode, countyCode) {
    var index = "0";
    var HOME_CITY = document.getElementById("HOME_CITY");
    var jsonList = eval("(" + result + ")");

    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (cityCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        HOME_CITY.options.add(option);
    }
    if (index != '0') {
        HOME_CITY[index].selected = true;
    }
    getArea('county', 'Home', cityCode, countyCode);
}
function setCity(result, cityCode, countyCode) {
    var index = "0";
    var CITY = $('#CITY');
    var jsonList = eval("(" + result + ")");
    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (cityCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        //alert(option.text);
        CITY.options.add(option);
    }
    if (index != '0') {
        CITY[index].selected = true;
    }
    getArea('county', '', cityCode, countyCode);
}
//当改变省份时设置城市
function setIdCardCounty(result, cityCode, countyCode) {
    var index = "0";
    var IDCARD_AREA = document.getElementById("IDCARD_PROVINCE");
    var jsonList = eval("(" + result + ")");

    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (countyCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        IDCARD_AREA.options.add(option);
    }
    if (index != '0') {
        IDCARD_AREA[index].selected = true;
    }
}
function setHomeCounty(result, cityCode, countyCode) {
    var index = "0";
    var HOME_AREA = document.getElementById("HOME_AREA");
    var jsonList = eval("(" + result + ")");

    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (countyCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        HOME_AREA.options.add(option);
    }
    if (index != '0') {
        HOME_AREA[index].selected = true;
    }
}
function setCounty(result, cityCode, countyCode) {
    var index = "0";
    var AREA = document.getElementById("AREA");
    var jsonList = eval("(" + result + ")");

    for (var i = 0; i < jsonList.length; i++) {
        var value = "0";
        var text = "0";
        for (var key in jsonList[i]) {
            if (key == "ID"){
                value = jsonList[i][key];
            }
            if (key == "Name"){
                text = jsonList[i][key];
            }
            if (countyCode == value){
                index = i;
            }
        }
        var option = new Option(text, value);
        AREA.options.add(option);
    }
    if (index != '0') {
        AREA[index].selected = true;
    }
}

// 清空下拉列表
function clearSel(oSelect) {
    while (oSelect.childNodes.length > 0) {
        oSelect.removeChild(oSelect.childNodes[0]);
    }
}

function initializeArea(proID,proCode,cityID,cityCode,countyID,countyCode){
    setAreaCode(proID,"",proCode);
    setAreaCode(cityID,proID,cityCode);
    setAreaCode(countyID,cityID,countyCode);
}

function setSubAreaCode(tagid,parentTagid,areaCode,subTagid){
    setAreaCode(tagid,parentTagid,"");
    setAreaCode(subTagid,tagid,"");
}

var setAreaCode = function(tagid, parentTagid, areaCode, sac) {
    var parentAreaCode = "BornPlaceCode";
    if (parentTagid != null && parentTagid != "" && parentTagid != "null") {
        parentAreaCode = $("#" + parentTagid).val();
    }

    $.ajax({
        type : "post",
        url : '/utility/otherInfo/getAreasByParentID',
        async : false,
        data : "areaId=" + parentAreaCode,
        success : function(result) {
            var area_tag = document.getElementById(tagid);
            clearSel(area_tag);
            var index = "0";
            var jsonList = eval("(" + result + ")");
            for (var i = 0; i < jsonList.length; i++) {
                var value = "0";
                var text = "0";
                for ( var key in jsonList[i]) {
                    if (key == "ID") {
                        value = jsonList[i][key];
                    }
                    if (key == "Name") {
                        text = jsonList[i][key];
                    }
                    if (areaCode == value) {
                        index = i;
                    }
                }
                var option = new Option(text, value);
                area_tag.options.add(option);
            }
            $("#" + tagid).val(areaCode);
        }
    });
}
</script>