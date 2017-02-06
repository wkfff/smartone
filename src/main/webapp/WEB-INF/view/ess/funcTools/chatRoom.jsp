<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="/resources/js/chatter/JqueryEasyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="/resources/js/chatter/JqueryEasyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="/resources/js/chatter/default.css">
<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css"
	rel="stylesheet" type="text/css" />
<script type="text/javascript"
	src="/resources/js/chatter/JqueryEasyui/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="/resources/js/chatter/JqueryEasyui/jquery.easyui.min.js"></script>
<link href="/resources/js/chatter/kindeditor/themes/default/default.css"
	rel="stylesheet" type="text/css" />
<link href="/resources/js/chatter/kindeditor/plugins/code/prettify.css"
	rel="stylesheet" type="text/css" />
<script src="/resources/js/chatter/kindeditor/kindeditor-min.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/lang/zh_CN.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/plugins/code/prettify.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/json2.js"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/html5helper.js"></script>

<link href="/resources/js/ligerUI/skins/Aqua/css/ligerui-all.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css"
	href="/resources/js/chatter/default.css">
<script src="/resources/js/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/ligerui.min.js"
	type="text/javascript"></script>
<script src="/resources/js/ligerUI/js/plugins/ligerTree.js"
	type="text/javascript"></script>
<link href="/resources/js/chatter/kindeditor/themes/default/default.css"
	rel="stylesheet" type="text/css" />
<link href="/resources/js/chatter/kindeditor/plugins/code/prettify.css"
	rel="stylesheet" type="text/css" />
<script src="/resources/js/chatter/kindeditor/kindeditor-min.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/lang/zh_CN.js"
	type="text/javascript"></script>
<script src="/resources/js/chatter/kindeditor/plugins/code/prettify.js"
	type="text/javascript"></script>

<title></title>
<script>
	var ws = null;
	var registerid = '${admin.adminID}';
	var connectURL = 'ws://${serverIP}:9090/websocket';
	var $tree;
	// 初始调用
	$(function() {
		setLoginInfo();
		connect();
		$tree = $("#testTree").ligerTree({
			method : 'post',
			url : '/ess/funcTools/getAllEmpDeptTree',
			checkbox : false,
			idFieldName : 'DEPTID',
			parentIDFieldName : 'PARENTDEPTID',
			textFieldName : 'CHINESENAME',
			topParentIDValue : 'wooribank',
			iconFieldName : 'ICON',
			isLeaf : function(data) {
				if (data.EMPID == null)
					return false;
				else
					return true;
			},
			onSuccess : function(data) {

			},
			nodeWidth : 150,
			checkbox : false,
			onSelect : onSelect
		//onContextmenu: onContextmenu
		});
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

	//创建连接
	function connect() {
		if ('WebSocket' in window) {
			ws = new WebSocket(connectURL);
			//alert("Connecting");
		} else if ('MozWebSocket' in window) {
			ws = new MozWebSocket(connectURL);
			//alert("Connecting2");
		} else {
			alert("您目前的浏览器不支持HTML5，请使用最新版的Chrome、Opera或FireFox浏览器");
			var tab = parent.tab;
			tab.removeSelectedTabItem();
		}
		ws.onopen = function(evt) {
			callRegister.parameters.name = '${admin.chineseName}';
			ws.send(JSON.stringify(callRegister));
			$('#dlgConnect').dialog('close');
			list();
		};
		ws.onclose = function(evt) {
			$('#dlgConnect').dialog('open');
			$('#dlgConnect').html('<div>closed</div>');
		};
		ws.onerror = function(evt) {
			alert(evt.data);
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
		return ' <table id="user_' + $item.empid + '"><tr><td><img src="/resources/js/chatter/user.png" /></td><td style="width:200px">'
				+ $item.name + '</td><td>' + '' + '</td></tr></table>';
	}

	function addSayItem(item) {
		var $item = $.parseJSON(item);
		var html = '<div class="sayitem"><div class="saytitle"><img src="/resources/js/chatter/chat.png"/><span>'
				+ $item.name
				+ '</span>['
				+ $item.eName
				+ ']'
				+ $item.date
				+ '</div><div class="saybody">'
				+ $item.content
				+ '<div/></div>'

		$(html).appendTo($('#contentBody'));
		var e = document.getElementById("cbdiv")
		e.scrollTop = e.scrollHeight;
	}

	var callList = {
		url : 'Handler.List',
		parameters : {}
	};
	function list() {
		ws.send(JSON.stringify(callList));
	}

	var callSay = {
		url : 'Handler.Say',
		parameters : {
			Content : ""
		}
	};
	function Say() {
		callSay.parameters.Content = mEditor.html();
		mEditor.html('');
		ws.send(JSON.stringify(callSay));
		$('#content1').focus();

	}
</script>
</head>
<body class="easyui-layout">
	<div id="dlgConnect" class="easyui-dialog" title="Basic Dialog"
		data-options="title:'Connect',modal:true,closable:true"
		style="width: 250px; height: 160px; padding: 10px">
		Connecting...</div>
	<div data-options="region:'west',title:'onlines',split:true"
		style="width: 250px; overflow: auto;">
		<div id="lstOnlines"></div>
	</div>
	<div class="easyui-tabs"
		data-options="region:'center',title:'',border:false"
		style="background: #eee;">
		<div title="公司群聊" class="easyui-layout"
			data-options="fit:true,closable:false" style="overflow: hidden;">
			<div id="cbdiv" data-options="region:'north',title:'Content'"
				style="height: 380px;">
				<div id="contentBody"></div>
			</div>
			<div data-options="region:'center',title:'Say'"
				style="height: 170px; overflow: auto;">
				<!--            <ul id="testTree"></ul>-->
				<script>
					var mEditor;
					var mHtmlItem;
					var mblockid;
					KindEditor
							.ready(function(K) {
								mEditor = K
										.create(
												'#content1',
												{
													cssPath : '/resources/js/chatter/kindeditor/plugins/code/prettify.css',
													allowFileManager : true,
													items : [
															'justifyleft',
															'justifycenter',
															'justifyright',
															'justifyfull',
															'insertorderedlist',
															'insertunorderedlist',
															'indent',
															'outdent',
															'emoticons',
															'about' ],
													afterCreate : function() {
														var self = this;
														mEditor.display = 'none';
													}
												});
								prettyPrint();
							});
				</script>
				<textarea id="content1" cols="100" rows="8"
					style="height: 150px; width: 100%; visibility: hidden; display: none;"></textarea>
				<p>
					<a id="btn" href="#" class="easyui-linkbutton" onclick="Say()">Send</a>
				</p>
			</div>
		</div>
	</div>
</body>
</html>
