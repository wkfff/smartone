<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title></title>
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/resources/js/chatter/default.css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js" type="text/javascript"></script>
<link href="/resources/js/chatter/kindeditor/themes/default/default.css" rel="stylesheet" type="text/css" />
<link href="/resources/js/chatter/kindeditor/plugins/code/prettify.css" rel="stylesheet" type="text/css" />
<script src="/resources/js/chatter/kindeditor/kindeditor-min.js" type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/lang/zh_CN.js" type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/plugins/code/prettify.js" type="text/javascript"></script>
<script>
    var mEditor;
    var mHtmlItem;
    var mblockid;
    KindEditor.ready(function(K) {
        mEditor = K.create(
           '#messageContent',{
               cssPath : '/resources/js/chatter/kindeditor/plugins/code/prettify.css',
               allowFileManager : true,
               resizeMode : 0,
               items : ['justifyleft', 'justifycenter',
                       'justifyright', 'justifyfull',
                       'insertorderedlist','insertunorderedlist',
                       'indent','outdent',
                       'emoticons', 'about' ],
               afterCreate : function() {
                   var self = this;
               }
           });
        prettyPrint();
    });
</script>
<script>
    var ws = null;
    var registerid = '${admin.adminID}';
    var connectURL = 'ws://${serverAddress}/websocket';
    var $tree;
    var chatterTabs;
    // 初始调用
    $(function() {
        $("#layoutChatter").ligerLayout({
            leftWidth : 225,
            height : '100%',
            space : 2
        });
        $("#layoutCenter").ligerLayout({
            topHeight : '70%',
            centerHeight : '25%',
            width : '100%',
            space : 2
        });
        chatterTabs = $("#chatterTabs").ligerTab({
            height : '100%'
        });
        /* $tree = $("#lstOnlines").ligerTree(
                {
                    method:'post',
                    url: '/chat/getAllEmpDeptTree',
                    checkbox: false,
                    idFieldName: 'DEPTID',
                    parentIDFieldName: 'PARENTDEPTID',
                    textFieldName: 'CHINESENAME',
                    topParentIDValue: 'wooribank',
                    iconFieldName :'ICON',
                    isLeaf:function(data){
                        if(data.EMPID == null)return false;
                        else return true;
                    },
                    onSuccess:function(data){
                    },
                    nodeWidth:150,
                    checkbox: false
                    //onContextmenu: onContextmenu
                 }
        ); */
        setLoginInfo();
        connect();
    });

    /************* TEST BEGIN *************************/
    function setLoginInfo() {
        //请求服务器
        $.ajax({
            type : 'get',
            url : '/websocket',
            dataType : 'json',
            async : false,
            success : function(result) {
            }
        });
    }
    /**************** TEST END **********************/
    function toOne(idAndName) {
        var sawp = idAndName.split(',');
        var id = sawp[0];
        if (id == registerid)
            return;
        var ids = id + "A" + registerid;
        var name = sawp[1];
        var titlecon = "与 " + name + " 聊天中";
        if (id == null) {
            selectTabItem("companyChatt");
        } else {
            $.post('/chat/setRoomID', {
                ids : ids
            }, function(data) {
                if (data == true) {
                }
            });
            var tabid = ids;
            if (!chatterTabs.isTabItemExist(ids)) {
                idss = registerid + "A" + id;
                if (!chatterTabs.isTabItemExist(idss)) {
                    chatterTabs.addTabItem({
                        id : ids,
                        tabid : tabid,
                        text : titlecon
                    });
                } else {
                    chatterTabs.selectTabItem(idss);
                }
            } else {
                chatterTabs.selectTabItem(ids);
            }
        }
    }

    //创建连接
    function connect() {
        /*申请websocket链接*/
        if ('WebSocket' in window) {
            ws = new WebSocket(connectURL);
        } else if ('MozWebSocket' in window) {
            ws = new MozWebSocket(connectURL);
        } else {
            alert("您目前的浏览器不支持HTML5，请使用最新版的Chrome、Opera或FireFox浏览器");
            var tab = parent.tab;
            tab.removeSelectedTabItem();
        }

        ws.onopen = function(evt) {
            callRegister.parameters.name = '${admin.chineseName}';
            ws.send(JSON.stringify(callRegister));
            //$('#dlgConnect').dialog('close');
            list();
        };

        ws.onclose = function(evt) {
            //$('#dlgConnect').dialog('open');
            //$('#dlgConnect').html('<div>closed</div>');
        };

        ws.onerror = function(evt) {
            //alert(evt.data);
        };

        ws.onmessage = function(result) {
            var $result = $.parseJSON(result.data);
            var $type = $result.type;
            var $data = $.parseJSON($result.data);
            if ($type == "register") {
                var item = getUser($data);
                $(item).appendTo($('#lstOnlines'));
            } else if ($type == 'unregister') {
                var empid = $data.empid;
                $('#user_' + empid).remove();
            } else if ($type == 'say') {
                addSayItem($result.data);
            } else if ($type == 'list') {
                $('#lstOnlines').html('');
                for ( var i = 0; i < $data.length; i++) {
                    var item = getUser($data[i]);
                    $(item).appendTo($('#lstOnlines'));
                }
            } else {
            }
        };
    }

    var callRegister = {
        url : "Handler.Register",
        parameters : {
            name : ""
        }
    };

    function getUser($item) {
        var idAndName = $item.empid + ',' + $item.name;
        return ' <div id="user_'
                + $item.empid
                + '" ondblclick="toOne(\''
                + idAndName
                + '\')" style="height:40px;background-color: #97CBFF;display:block;margin: 5px 5px 5px 15px;border:1px solid #46A3FF;padding-left:20px;" ><img src="/resources/js/chatter/user.png"  /><b style="width:110px;font-family: Tahoma, Helvetica, Arial, sans-serif;font-size: 22px;margin-top: 5px;color: #FFFFFF;">'
                + $item.name + '</b></div>';
    }

    function addSayItem(item) {
        var $item = $.parseJSON(item);
        var html = '<div class="sayitem"><div class="saytitle"><img src="/resources/js/chatter/chat.png"/><span>'
                + $item.name
                + '</span>'
                + $item.date
                + '</div><div class="saybody">'
                + $item.content
                + '<div/></div>'
        var id = $item.room;
        if (id == null || id == '') {
            id = "companyChatt";
            $(html).appendTo($("[tabid=" + id + "]"));
            var e = $("[tabid=" + id + "]");
            //e.scrollTop(e.height());
        } else {
            if (!chatterTabs.isTabItemExist(id)) {
                var titlecon = "与 " + $item.name + " 聊天中";
                chatterTabs.addTabItem({
                    id : id,
                    tabid : id,
                    text : titlecon
                });
            } else {
                chatterTabs.selectTabItem(id);
            }
            $(html).appendTo($("[tabid=" + id + "]"));
            var e = $("[tabid=" + id + "]");
            //e.scrollTop(e.height());
        }
    }

    var getListParam = {
        url : 'Handler.List',
        parameters : {}
    };

    function list() {
        ws.send(JSON.stringify(getListParam));
    }

    var callSay = {
        url : 'Handler.Say',
        parameters : {
            Content : "",
            RoomKey : ""
        }
    };

    function Say() {
        if(mEditor.html()=="")
            return;
        callSay.parameters.Content = mEditor.html();
        var id = chatterTabs.getSelectedTabItemID();
        if (id == 'companyChatt')
            id = '';
        callSay.parameters.RoomKey = id/*TODO: 显示当前选中tab的ID*/;
        mEditor.html('');
        ws.send(JSON.stringify(callSay));
        $('#messageContent').focus();
    }
</script>
<style type="text/css">
.l-link {
    display: block;
    height: 26px;
    line-height: 26px;
    padding-left: 100px;
    text-decoration: underline;
    color: #333;
}

.l-link-over {
    background: #FFEEAC;
    border: 1px solid #DB9F00;
}
</style>
</head>
<body>
    <div id="dlgConnect" style="display: none;"></div>
    <div id="layoutChatter" style="overflow: hidden; padding: -1px;">
        <div position="left" id="shiftList" style="overflow: auto; height: 95%; width: 95%;" title="聊天列表">
            <div id="lstOnlines"></div>
        </div>
        <div id="layoutCenter" position="center">
            <div id="chatterTabs" position="top"  style="height:100%">
                <div id="companyChatt" tabid="companyChatt" title="所有人聊天" lselected="true" style="height: 80%; width: 100%;"></div>
            </div>
            <div id="inputArea" position="center" style="height:100px">
                <div id="messageContent"></div>
            </div>
            <div id="sendButton" position="bottom" style="height:40px">
                <a class="l-button" style="width:79px; height:20px; float:left;margin-top:10px; margin-left:10px;" onclick="Say()">发送</a>
            </div>
        </div>
    </div>
</body>
</html>
