<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/view/web/inc/initTaglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SipingSoft ERP</title>
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTab.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerLayout.js" type="text/javascript"></script>
<script src="/resources/js/oncontextmenu.js" type="text/javascript"></script>
<script type="text/javascript">
    var tab = null;
    var accordion = null;
    var tree = null;
    var timer1;
    var timer2;
    $(function() {
        //布局
        $("#layout1").ligerLayout({
            topHeight:35,
            leftWidth: 180,
            bottomHeight: 25,
            height: '100%',
            heightDiff: -20,
            space: 4,
            onHeightChanged: f_heightChanged
        });
        var height = $(".l-layout-center").height();
        //Tab
        $("#framecenter").ligerTab({
            height: height
        });
        //面板
        $("#accordion1").ligerAccordion({
            height: height - 24
        });
        $(".l-link").hover(function() {
            $(this).addClass("l-link-over");
        },
        function() {
            $(this).removeClass("l-link-over");
        });
        //树Tab
        $("#framecenter").ligerTab({
            height: height,
            onBeforeSelectTabItem: function(a) {
                if (a == 'home') {
                    $("#menuLoad").html('<spring:message code="my.homepage"/>');
                } else {
                    $.post('/login/getMenuLoad', {
                        "tid": a
                    },
                    function(back) {
                        $("#menuLoad").html(back);
                    });
                }
            },
            onBeforeRemoveTabItem: function(a) {
                if ($("li[tabid=" + a + "]").hasClass("l-selected")) {
                    var b = $(".l-tab-content-item[tabid=" + a + "]").prev().attr("tabid");
                    if (b == 'home') {
                        $("#menuLoad").html('<spring:message code="my.homepage"/>');
                    } else {
                        $.post('/login/getMenuLoad', {
                            "tid": b
                        },
                        function(back) {
                            $("#menuLoad").html(back);
                        });
                    }
                }
            }
        });
        tab = $("#framecenter").ligerGetTabManager();
        accordion = $("#accordion1").ligerGetAccordionManager();
        $("#pageloading").hide();
        $.ajax({
            type: 'get',
            cache: false,
            contentType: 'application/json',
            url: '/login/getMainMenu',
            dataType: 'json',
            success: function(data) {
                var temp = "";
                $.each(data.mainMenuList,
                function(i, item) {
                    f_getLeftMenu(item.MENU_CODE);
                });
            },
            error: function() {
                $.ligerDialog.error('Send Error');
            }
        });
        // spf_getMessages();
        // timer2 = setInterval(spf_getMessages,10000);
    });
    
    function f_heightChanged(options) {
        if (tab) tab.addHeight(options.diff);
        if (accordion && options.middleHeight - 24 > 0) accordion.setHeight(options.middleHeight - 24);
    }
    function f_addTab(tabid, text, url) {
        tab.addTabItem({
            tabid: tabid,
            text: text,
            url: url
        });
    }

    function f_getLeftMenu(code) {
        if ($("#" + code).text() == "") {
            $.ajax({
                type: 'get',
                cache: false,
                contentType: 'application/json',
                url: '/login/getLeftMenu?mainMenu=' + code,
                dataType: 'json',
                success: function(data) {
            		var menuHtml = "";
            		$.each(data.leftMenuList,function(i, item) {
        	    		if (item.MENU_PARENT_CODE == code) {
        	    			menuHtml += '<li isexpand="false" ><span>' + item.MENU_INTRO + '</span><ul>';
        	    			$.each(data.leftMenuList,function(j, item2) {
        	    	    		if(item2.MENU_PARENT_CODE == item.MENU_CODE){
        	    	    			menuHtml += '<li url="' + item2.MENU_URL + '" tabid="' + item2.MENU_CODE + '"><span>' + item2.MENU_INTRO + '</span></li>';
        	    	        	}
        	    	    	});
        	    			menuHtml += "</ul>";
        	    		}
                    });
            		console.log(menuHtml);
                    $("#" + code).html(menuHtml);
                    $("#" + code).ligerTree({
                        checkbox: false,
                        treeLine: true,
                        parentIcon: null,
                        childIcon: null,
                        nodeWidth: 100,
                        attribute: ['nodename', 'url', 'tabid'],
                        onClick: function(node) {
                            if (!node.data.url) return;
                            var tabid = $(node.target).attr("tabid");
                            f_addTab(tabid, node.data.text, node.data.url);
                        }
                    });
                },
                error: function() {
                    $.ligerDialog.error('Send Error');
                }
            });
        }
    }

    function spf_firstLogin() {
        $.post('/login/checkFirstLogin', {
            "ADMINID": ''
        },
        function(back) {
            if (back == 'Y') {
                $dialog = $.ligerDialog.open({
                    isDrag: true,
                    showMax: true,
                    showMin: false,
                    title: '<spring:message code="change.password"/>',
                    width: 450,
                    height: 320,
                    url: '/ess/password/changePassword?MENU_CODE=ess0401'
                });
            }
        });
    }

    function spf_browse(website) {
        window.open(website);
    }

    function f_ChildWindowClose() {
        $dialog.close();
        location.href = "/login/out";
    }

    function spf_getMessages(){
        $.ajax({
            type: 'post',
            cache: false,
            contentType: 'application/json',
            url: '/message/messageManage/getMyMessageCnt?IS_READ=1',
            dataType: 'json',
            success: function(data) {
                if(data>0){
                    timer1 = setInterval(function(){ $("#warnImage").fadeOut(100).fadeIn(100);},1000); 
                    
                    $("#cnt").css("color","red");
                    $("#messageBox").html("<p>你有&nbsp;</p><p style='color:red;'>"+data+"</p><p>&nbsp;条新短消息哦！</p>");
                    $("#warnBox").fadeIn().animate({height:"194px"},1000);
                }else{
                    clearInterval(timer1);
                    $("#cnt").css("color","green");
                    spf_hideWarnBox();
                }
                $("#cnt").text("("+data+")");
            }
        });
    }
    
    function spf_hideWarnBox(){
        $("#warnBox").animate({height:"0px"},1000).fadeOut();
    }
    
    function spf_viewPersonalMessages(){
        clearInterval(timer1);
        $("#cnt").css("color","green");
        spf_hideWarnBox();
        $("#cnt").text("(0)");
        if (tab.isTabItemExist('message0103')) {
            tab.removeTabItem('message0103');
        }
        tab.addTabItem({
            tabid:'message0103',
            text:'<spring:message code="myMessage" />',
            url: '/message/messageManage/viewPersonalMessage'
        });
    }
</script>
<style type="text/css">
html,body {
    margin: 0px;
}

body {
    padding: 0px;
    margin: 0px;
    overflow: hidden;
}

.l-link {
    display: block;
    height: 26px;
    line-height: 26px;
    padding-left: 100px;
    text-decoration: underline;
    color: #333;
}

.l-link2 {
    text-decoration: underline;
    color: white;
}

.l-link-over {
    background: #FFEEAC;
    border: 1px solid #DB9F00;
}

.l-layout-top {
    background: #ffffff;
    color: #C589ED;
}

.l-layout-bottom {
    background: #E5EDEF;
    text-align: center;
}

#layout1 {
    margin: 0;
    padding: 0;
}

#pageloading {
    position: absolute;
    left: 0px;
    top: 0px;
    background: white url('/resources/images/loading.gif') no-repeat center;
    width: 100%;
    height: 100%;
    height: 700px;
    z-index: 99999;
}

.top {
    background: url(/resources/images/login/nav_bg.jpg) left top;
    height: 35px;
}

.nav_top {
    padding-left: 10px;
    width: 60px;
    height: 21px;
    background: url(/resources/images/login/nav_top_bg.jpg) left
        top;
    position: absolute;
    right: 0px;
}

.nav_top a {
    font-size: 12px;
    text-decoration: none;
}

.zh_ch {
    color: #000;
}

.en_us {
    color: #0A449C;
}

.logout {
    color: black;
    font-family: Arial
}

.userInfo {
    height: 21px;
    text-align: right;
    padding-right: 195px;
}

main_menu_bg {
    padding: 17px 0px 0px 323px;
    min-width: 680px;
    font-size: 14px;
    font-wieght: bold;
    background: url(/resources/images/login/menu_bg.jpg) no-repeat 313px
        17px;
    height: 35px;
    line-height: 30px;
}

.main_menu {
    white-space: nowrap;
    background: url(/resources/images/login/menu_bg_right.jpg) no-repeat
        right top;
    height: 35px;
}

.main_menu span {
    padding: 0px 5px 0px 5px;
}

.main_menu a {
    text-decoration: none;
    color: #FFF;
    font-weight: bold;
}
#warnBox{
    position:absolute;
    z-index:2000;
    width:312px;
    height:0px;
    background-image:url("/resources/images/myimage/warnBox.png");
    right:6px;
    bottom:46px;
}
#messageBox{
    font-size:16px;
}
#messageBox p{
    float:left;
}
</style>
</head>
<body style="padding: 0px; background: #EAEEF5;" onload="spf_firstLogin()">
    <!-- 打开QQ通信窗口
        <a style="padding-right:20px;" href="http://wpa.qq.com/msgrd?v=3&amp;uin=545435711&amp;site=qq&amp;menu=yes" target="_blank"><img style="vertical-align:bottom; border:0px" src="http://wpa.qq.com/pa?p=1:545435711:13" alt="点击这里给我发消息"></a> 
    -->
    <div class="l-loading" style="display: block" id="pageloading"></div>
    <div id="layout1" style="height:30px; width: 99.2%; margin: 0 auto; margin-top: 4px;">
        <div position="top" class="top">
            <div style="float:left;padding-left: 30px;"><img src="/resources/images/home/siping_logo2.png" height="25px;"/></div>
            <div style="float:left;" id="language" class="nav_top">&nbsp;&nbsp; <a href="/login/out" class="logout">退出</a></div>
        </div>
        <div position="left" title='<spring:message code="system.navigation"/>' id="accordion1">
            <p style="height: 1px;"></p>
            <c:forEach items="${mainMenuList}" var="mainMenuInfo" varStatus="i">
                <div style="" onclick="f_getLeftMenu('${mainMenuInfo.MENU_CODE}');"
                    title="${mainMenuInfo.MENU_INTRO}" class="l-scroll">
                    <ul id="${mainMenuInfo.MENU_CODE}" style="margin-top: 3px;"></ul>
                </div>
            </c:forEach>
        </div>
        <div position="center" id="framecenter">
            <c:if test="${userType=='EM'}">
                <div tabid="home" title='<spring:message code="my.homepage"/>'>
                    <iframe frameborder="0" name="home" id="home" src="/login/main"></iframe>
                </div>
            </c:if>
            <c:if test="${userType=='SY'}">
                <div tabid="home" title='<spring:message code="my.homepage"/>'>
                    <iframe frameborder="0" name="home" id="home" src="/login/mainSys"></iframe>
                </div>
            </c:if>
            <c:if test="${userType=='HR'}">
                <div tabid="home" title='<spring:message code="my.homepage"/>'>
                    <iframe frameborder="0" name="home" id="home" src="/login/mainHr"></iframe>
                </div>
            </c:if>
        </div>
        <div position="bottom">
            <table width="99%" cellpadding="1" cellspacing="1"
                style="height: 25px; font-size: 12px;">
                <tr>
                    <td width="25%" align="left" height="30px;">&nbsp; <spring:message code="currentPosition" />
                        <a id="menuLoad"><spring:message code="my.homepage" /></a>
                    </td>
                    <td align="right">
                        <img id="warnImage" src="/resources/images/myimage/messageGreen.jpg" style="width:20px;height:20px;"/>
                    </td>
                    <td width="75" align="right">
                        <a href="javascript:spf_viewPersonalMessages()"><spring:message code="myMessage" /></a>
                    </td>
                    <td width="30" id="cnt" align="left">
                        
                    </td>
                    <%-- <td align="right">
                        <marquee behavior="scroll" direction="left"
                            scrollamount="3" scrolldelay="75" onmouseover='this.stop()' onmouseout='this.start()'>
                            <c:forEach items="${announcementList}" var="announcement" varStatus="i">
                                <span style="cursor: pointer"> ${announcement.ANN_TYPE}:
                                    ${announcement.ANN_CONTENT} </span>&nbsp;&nbsp;&nbsp;&nbsp;
                            </c:forEach> 
                        </marquee>
                    </td> --%>
                </tr>
            </table>
        </div>
    </div>
    <!--
        &nbsp;&nbsp;软件实施：成都四平软件有限公司 (
        <a href="http://www.sipingsoft.com/">http://www.sipingsoft.com/</a>)
    -->
    <div id="warnBox">
        <table width="100%">
            <tr>
                <td colspan="2" align="right">
                    <div style="width:22px;height:15px;margin-right:9px;cursor:pointer;" onclick="spf_hideWarnBox()"></div>
                </td>
            </tr>
            <tr>
                <td height="160" width="30%" align="right">
                    <img src="/resources/images/myimage/messageGreen.jpg" style="width:25px;height:25px;"/>
                </td>
                <td id="messageBox"></td>
            </tr>
        </table>
    </div>
</body>
</html>