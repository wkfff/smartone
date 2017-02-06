function clickIE4() {
    if (event.button == 2) {
        return false;
    }
}

function clickNS4(e) {
    if (document.layers || document.getElementById && !document.all) {
        if (e.which == 2 || e.which == 3) {
            return false;
        }
    }
}

function OnDeny() {
    if (event.ctrlKey || event.keyCode == 78 && event.ctrlKey || event.altKey || event.altKey && event.keyCode == 115) {
        return false;
    }
}

if (document.layers) {
    document.captureEvents(Event.MOUSEDOWN);
    document.onmousedown = clickNS4;
    document.onkeydown = OnDeny();
} else if (document.all && !document.getElementById) {
    document.onmousedown = clickIE4;
    document.onkeydown = OnDeny();
}

document.oncontextmenu = new Function("return false");

// 处理键盘事件 禁止后退键 密码或单行、多行文本框除外
function forbidBackSpace(e) {
    var ev = e || window.event; // 获取event对象
    var obj = ev.target || ev.srcElement; // 获取事件源
    var t = obj.type || obj.getAttribute('type'); // 获取事件源类型
    // 获取作为判断条件的事件类型
    var vReadOnly = obj.readOnly;
    var vDisabled = obj.disabled;
    // 处理undefined值情况
    vReadOnly = (vReadOnly == undefined) ? false : vReadOnly;
    vDisabled = (vDisabled == undefined) ? true : vDisabled;
    // 当敲Backspace键时，事件源类型为密码或单行、多行文本的，
    // 并且readOnly属性为true或disabled属性为true的，则退格键失效
    var flag1 = ev.keyCode == 8 && (t == "password" || t == "text" || t == "textarea") && (vReadOnly == true || vDisabled == true);
    // 当敲Backspace键时，事件源类型非密码或单行、多行文本的，则退格键失效
    var flag2 = ev.keyCode == 8 && t != "password" && t != "text" && t != "textarea";
    // 判断
    if (flag2 || flag1)
        return false;
}
// 禁止后退键 作用于Firefox、Opera
document.onkeypress = forbidBackSpace;
// 禁止后退键 作用于IE、Chrome
document.onkeydown = forbidBackSpace;