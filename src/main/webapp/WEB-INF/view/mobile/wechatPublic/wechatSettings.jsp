<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>微信设置</title>
<link href="/resources/css/popup.css" rel="stylesheet" type="text/css" />

<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/jquery/jquery.form.js" type="text/javascript"></script>
<script type="text/javascript">
function checkMenuData(){
    var menuName = $("#menuName").val();
    if(menuName.trim()==""){
        alert("请输入菜单名称");
        return false;
    }
    return true;
}
function saveMenuName(){
    if (checkMenuData()) {
        var options = {
            url : '/wechat/addWechatMenu',
            type : 'post',
            error : function(){
                alert('保存失败');
            },
            success : function(str){
                if (str == "Y") {
                    window.location.reload(true);
                } else {
                    alert(str);
                }
            }
        };
        $("#menu_name_form").ajaxSubmit(options);
    }
    return false;
}
function delMenu(id){
    $.ajax({
        url : '/wechat/deleteMenu',
        type : 'post',
        data : {
            id : id
        },
        error : function() {
            alert('删除失败');
        },
        success : function(str) {
            if (str == "Y") {
                window.location.reload(true);
            } else {
                alert(str);
            }
        }
    });
}
function updateMenuName(){
    if (checkMenuData()) {
        var options = {
            url : '/wechat/updateMenuName',
            type : 'post',
            error : function(){
                alert('保存失败');
            },
            success : function(str){
                if (str == "Y") {
                    window.location.reload(true);
                } else {
                    alert(str);
                }
            }
        };
        $("#menu_name_form").ajaxSubmit(options);
    }
    return false;
}
function chooseMenu(dom,id){
    $("#contentShowTipsDiv").hide();
    $("#menuResponseSetting").show();
    $(dom).css("background-color","rgb(223, 223, 223)");
    $(dom).siblings().css("background-color","");
    $("#urlSettingDiv").hide();
    $("#replySettingDiv").hide();
    $("#menuRepSubmBtn").hide();
    $("#menuRespActionForm").clearForm();
    $("#slectRespType").val("");
    $("#msgTypeSelect").val("");
    $("#selectedMenuId").val(id);
    $.ajax({
        url : '/wechat/getMenuById',
        type : 'post',
        data : {
            id : id
        },
        error : function() {
            alert('数据获取失败');
        },
        success : function(menu) {
            if(menu.menuType=="click"){
                $("#slectRespType").val(menu.menuType);
                $("#menuKey").attr("disabled",false);
                $("#replyText").attr("disabled",false);
                $("#msgTypeSelect").attr("disabled",false);
                $("#replySettingDiv").show();
                $("#urlSettingDiv").hide();
                $("#menuRepSubmBtn").show();
                $("#menuUrl").val("");
                $("#menuUrl").attr("disabled",true);
                $("#menuKey").val(menu.menuKey);
                $("#replyText").val(menu.replyText);
            }else if(menu.menuType=="view"){
                $("#slectRespType").val("view");
                $("#menuUrl").attr("disabled",false);
                $("#urlSettingDiv").show();
                $("#replySettingDiv").hide();
                $("#menuRepSubmBtn").show();
                $("#menuKey").val("");
                $("#menuKey").attr("disabled",true);
                $("#replyText").val("");
                $("#replyText").attr("disabled",true);
                $("#msgTypeSelect").val("");
                $("#msgTypeSelect").attr("disabled",true);
                $("#menuUrl").val(menu.menuUrl);
            }else{
                $("#slectRespType").val("");
            }
        }
    });
}
function respOnchange(){
    var selected = $("#slectRespType").val();
    if(selected==""){
        $("#replySettingDiv").hide();
        $("#urlSettingDiv").hide();
        $("#menuRepSubmBtn").hide();
    }
    if(selected=="click"){
        $("#menuKey").attr("disabled",false);
        $("#replyText").attr("disabled",false);
        $("#msgTypeSelect").attr("disabled",false);
        $("#replySettingDiv").show();
        $("#urlSettingDiv").hide();
        $("#menuRepSubmBtn").show();
        $("#menuUrl").val("");
        $("#menuUrl").attr("disabled",true);
    }
    if(selected=="view"){
        $("#menuUrl").attr("disabled",false);
        $("#urlSettingDiv").show();
        $("#replySettingDiv").hide();
        $("#menuRepSubmBtn").show();
        $("#menuKey").val("");
        $("#menuKey").attr("disabled",true);
        $("#replyText").val("");
        $("#replyText").attr("disabled",true);
        $("#msgTypeSelect").val("");
        $("#msgTypeSelect").attr("disabled",true);
    }
}
function chooseMsgType(){
    
}
function checkMenuKey(){
    var key = $("#menuKey").val();
    var id = $("#selectedMenuId").val();
    var flag = false;
    $.ajax({
        url : '/wechat/checkMenuKey',
        type : 'post',
        async : false,
        data : {
            id : id,
            menuKey : key
        },
        error : function() {
            flag = false;
            alert('key值验证失败');
        },
        success : function(result) {
            if (result == false) {
                flag = false;
            }else{
                flag = true;
            }
        }
    });
    return flag;
}
function checkData(){
    var selected = $("#slectRespType").val();
    if(selected=="click"){
        var key = $("#menuKey").val();
        if(key.trim()==""){
            alert("key值不能为空！");
            return false;
        }else{
            var flag = checkMenuKey();
            if(flag==false){
                alert("该key值已在其他子菜单使用，请重新输入");
                return false;
            }
        }
    }
    if(selected=="view"){
        if($("#menuUrl").val()==""){
            alert("跳转链接地址不能为空！");
            return false;
        }
    }
    return true;
}
function saveMenuAction(){
    if (checkData()) {
        var options = {
            url : '/wechat/updateMenu',
            type : 'post',
            error : function(){
                alert('保存失败');
            },
            success : function(str){
                if (str == "Y") {
                    alert("保存成功");
                    window.location.reload(true);
                } else {
                    alert(str);
                }
            }
        };
        $("#menuRespActionForm").ajaxSubmit(options);
    }
    return false;
}
function enforce(){
    $.ajax({
        url : '/wechat/createMenu',
        type : 'post',
        error : function() {
            alert('服务器响应异常');
        },
        success : function(result) {
            alert(result);
        }
    });
}
</script>
<style type="text/css">
body,div{
    margin: 0 auto;
    font-size: 12px;
}
a{
    cursor: pointer;
}
.wechatMain{
    width: 90%;
}
#topTipsTitle{
    height: 35px;
    line-height: 35px;
    font-size: 14px;
    color: #FF0000;
}
.menuTitleDiv{
    width: 30%;
    float: left;
}
.menuResponseDiv{
    width: 68%;
    float: left;
}
.titleDiv{
    height: 30px;
    line-height: 30px;
    background-color: #D5E8FF;
    text-indent: 1em;
    border-left: 1px solid #C7C7C7;
    border-top: 1px solid #C7C7C7;
    border-right: 1px solid #C7C7C7;
}
.contentDiv{
    height: 450px;
    border: 1px solid #C7C7C7;
    overflow: scroll;
}
.addImg{
    width: 20px;
    height: 20px;
    margin-top: 5px;
    float: right;
    margin-right: 40px;
}
.titleSpan{
    height: 30px;
    line-height: 30px;
    border-bottom: 1px solid #C7C7C7;
    width: 100%;
    text-indent: 1em;
    cursor: pointer;
}
.subTitleSpan{
    height: 30px;
    line-height: 30px;
    border-bottom: 1px solid #C7C7C7;
    width: 100%;
    text-indent: 3em;
    cursor: pointer;
}
.titleSpan:hover,.subTitleSpan:hover{
    background-color: rgb(223, 223, 223)
}
.contentDiv img{
    float: right;
    margin-top: 5px;
    margin-right: 10px;
}
#contentShowTipsDiv{
    text-align: center;
    margin-top: 23%;
}
#menuResponseSetting{
    height: 100%;
}
#chooseResponseType{
    margin: 0 auto;
    width: 70%;
}
#urlSettingDiv{
    margin: 0 auto;
    width: 70%;
    margin-top: 15%;
}
#replySettingDiv{
    margin: 0 auto;
    width: 80%;
    margin-top: 10%;
}
#menuRepSubmBtn{
    text-align: right;
    width: 50%;
    margin-top: 15px;
    display: none;
}
#menu_name_form{
    margin: 0 auto;
    width: 75%;
    height: 70%;
    margin-top: 60px;
}
.menuNameInput{
    height: 70%;
}
.sbmMenuNameBtns{
    text-align: right;
    height: 29%;
}
#enforceBtn{
    height: 28px;
    width: 55px;
    margin-left: 100px;
    font-size: 15px;
}
.menuImg{
    width: 25px;
    height: 25px;
}
.menuImg:hover {
    background-color: #BBBEC0;
}
</style>
</head>
<body>
    <div class="wechatMain">
        <div class="menuSettings">
            <div id="topTipsTitle">
                <label>可创建最多3个一级菜单，每个一级菜单下可创建最多5个二级菜单，拥有二级菜单的一级菜单的响应动作将不会生效！</label>
                <input id="menusSize" type="hidden" value="${menuSize }"/>
                <button id="enforceBtn" onclick="enforce()">发布</button>
            </div>
            <div class="menuManageDiv">
                <div class="menuTitleDiv">
                    <div class="titleDiv">菜单管理<a onclick="showPopup()"><img class="addImg" alt="添加" src="/resources/images/addImg.png" /></a></div>
                    <div class="contentDiv">
                        <c:forEach items="${menus }" var="menu">
                        <div class="titleSpan" onclick="chooseMenu(this,'${menu.id}')">${menu.menuName }
                            <a onclick="delMenu(${menu.id})"><img class="menuImg" alt="删除" src="/resources/images/button/w_delete.png"></a>
                            <a onclick="showPopupForUp('${menu.id}','${menu.menuName }')"><img class="menuImg" alt="修改" src="/resources/images/button/w_update.png"></a>
                            <a onclick="showPopupForAdd(${menu.id})"><img class="menuImg" alt="添加" src="/resources/images/button/w_add.png"></a>
                        </div>
                        <c:forEach items="${menu.sonMenus }" var="subMenu">
                        <div class="subTitleSpan" onclick="chooseMenu(this,'${subMenu.id}')">${subMenu.menuName }
                            <a onclick="delMenu(${subMenu.id})"><img class="menuImg" alt="删除" src="/resources/images/button/w_delete.png"></a>
                            <a onclick="showPopupForUp('${subMenu.id}','${subMenu.menuName }')"><img class="menuImg" alt="修改" src="/resources/images/button/w_update.png"></a>
                        </div>
                        </c:forEach>
                        </c:forEach>
                    </div>
                </div>
                <div class="menuResponseDiv">
                    <div class="titleDiv">设置动作</div>
                    <div class="contentDiv">
                        <div id="contentShowTipsDiv">你可以先添加/选择一个菜单，然后开始为其设置响应动作</div>
                        <div id="menuResponseSetting" style="display: none;">
                            <form id="menuRespActionForm">
                            <div id="chooseResponseType">设置此菜单的动作类型为：
                                <select id="slectRespType" name="menuType" onchange="respOnchange()">
                                    <option value="">请选择</option>
                                    <option value="click">自动回复</option>
                                    <option value="view">跳转页面</option>
                                </select>
                            </div>
                            <div id="urlSettingDiv">
                                <div>点击该子菜单会跳转到以下链接：</div>
                                <input name="menuUrl" id="menuUrl" style="width: 400px;" placeholder="地址以http://或https://开头"/>
                            </div>
                            <div id="replySettingDiv">
                                <div>为此动作类型赋一个key值<font color="#FF0000">(由字母、下划线组成)</font>：
                                    <input name="menuKey" id="menuKey" placeholder="值唯一，不能与其他key值重复" style="width: 200px;" />
                                </div>
                                <p></p>
                                <div>回复消息类型：
                                    <select id="msgTypeSelect" onchange="chooseMsgType()">
                                        <option value="">请选择</option>
                                        <option value="text" selected="selected">文本消息</option>
                                        <option value="image">图片消息</option>
                                        <option value="news">图文消息</option>
                                    </select>
                                </div>
                                <p></p>
                                <div>点击该子菜单会自动回复以下内容：</div>
                                <textarea rows="8" cols="60" id="replyText" name="replyText" placeholder="最多可输入1333个汉字(含标点)"></textarea>
                            </div>
                            <div id="menuRepSubmBtn">
                                <input id="selectedMenuId" name="id" type="hidden"/>
                                <button type="submit" onclick="return saveMenuAction();">保存</button>
                            </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="pop" class="pop" style="display: none">
            <div class="pop_head">
                <label id="showDialogTitle">输入提示框</label><a href="javascript:void(0);" onclick="hide()">[关闭]</a>
            </div>
            <div class="pop_body">
                <form id="menu_name_form">
                    <div class="menuNameInput">
                        <label>菜单名称不多于<font id="maxHanzi"></font>个汉字或<font id="maxLetter"></font>个字母：</label>
                        <input id="menuId" name="id" value="0" type="hidden"/>
                        <input id="parentMenuId" name="parentMenuId" type="hidden"/>
                        <input id="menuName" name="menuName" />
                    </div>
                    <div class="sbmMenuNameBtns">
                        <button id="saveMenuBtn" type="submit" onclick="return saveMenuName();">确认</button>
                        <button id="updateMenuBtn" type="submit" onclick="return updateMenuName();">确认</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="/resources/js/popup/popup.js" type="text/javascript"></script>
</body>
</html>