/*弹出层js*/
var EX = {
    addEvent : function(k, v) {
        var me = this;
        if (me.addEventListener)
            me.addEventListener(k, v, false);
        else if (me.attachEvent)
            me.attachEvent("on" + k, v);
        else
            me["on" + k] = v;
    },
    removeEvent : function(k, v) {
        var me = this;
        if (me.removeEventListener)
            me.removeEventListener(k, v, false);
        else if (me.detachEvent)
            me.detachEvent("on" + k, v);
        else
            me["on" + k] = null;
    },
    stop : function(evt) {
        evt = evt || window.event;
        evt.stopPropagation ? evt.stopPropagation() : evt.cancelBubble = true;
    }
};
document.getElementById('pop').onclick = EX.stop;
var url = '#';
function showPopup() {
    var menuSize = $("#menusSize").val();
    if(menuSize>=3){
        alert("一级菜单最多可创建三个！");
        return;
    }
    $("#saveMenuBtn").show();
    $("#updateMenuBtn").hide();
    $("#menuId").val(0);
    $("#menuName").val("");
    $("#parentMenuId").attr("disabled",true);
    $("#maxHanzi").text(4);
    $("#maxLetter").text(8);
    var o = document.getElementById('pop');
    o.style.display = "";
    /*setTimeout(function() {
        EX.addEvent.call(document, 'click', hide);
    });*/
}
function showPopupForUp(id,name){
    $("#saveMenuBtn").hide();
    $("#updateMenuBtn").show();
    $("#menuId").val(id);
    $("#menuName").val(name);
    $("#parentMenuId").attr("disabled",true);
    $("#parentMenuId").val(null);
    var o = document.getElementById('pop');
    o.style.display = "";
    /*setTimeout(function() {
        EX.addEvent.call(document, 'click', hide);
    });*/
}
function showPopupForAdd(parentId){
    $("#saveMenuBtn").show();
    $("#updateMenuBtn").hide();
    $("#menuId").val(0);
    $("#menuName").val("");
    $("#parentMenuId").attr("disabled",false);
    $("#parentMenuId").val(parentId);
    $("#maxHanzi").text(8);
    $("#maxLetter").text(16);
    var o = document.getElementById('pop');
    o.style.display = "";
    /*setTimeout(function() {
        EX.addEvent.call(document, 'click', hide);
    });*/
}
function hide() {
    var o = document.getElementById('pop');
    o.style.display = "none";
    EX.removeEvent.call(document, 'click', hide);
}