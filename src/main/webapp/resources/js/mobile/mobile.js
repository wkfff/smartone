//商品图片点击事件-图片class命名为proImage
$(".proImage").live("tap", function() {
    location.href="/mobile/productManage/viewMobileProDetail?PRODUCT_NO="+$(this).attr("pno")+
        "&OBJECT_ID="+$(this).attr("pid")+"&OBJECT_TYPE_ID=PRODUCT&page=1&pagesize=20";
});
//搜索-按钮id为searchButton
$("#searchButton").live("tap", function() {
    spf_search(1);
});

$(".areaTitle2").live("tap", function(){
    spf_search2(1,$(this).attr("no"),$(this).attr("name"));
});

//返回-按钮id为back
$("#back").live("tap", function() {
    location.href = 'javascript:history.go(-1)';
});

//主页
$(".homePage").live("tap",function(){
    homePage();
});

//添加到订单
$(".addToCart").live("tap", function(){
    var topHeight = $(this).offset().top;
    if(isNaN($("#salePrice"+$(this).attr("pno")).val()) || $("#salePrice"+$(this).attr("pno")).val() == ""){
        showTips("该商品现在不可购买",topHeight-20,1);
        return;
    }
    if(checkNumber($("#number"+$(this).attr("pno")).val())){
        $.post("/mobile/mobileOrder/addToCart", 
            [   
                
                { name: 'QUANTITY', value: $("#number"+$(this).attr("pno")).val()},
                { name: 'PRODUCT', value: $("#PRODUCT"+$(this).attr("pno")).val()}
            ]
            , function (result){
                if (result > 0){
                    showAddCartTips("添加成功",(topHeight-20),10);
                    $("#listNumTip").html(result);
                }else{
                    showTips("添加失败",topHeight-20,1);
                }
            }
        );
    }else{
        showTips("请输入正确的购买数量",(topHeight-20),1);
    }
});

//从订单移除
$(".deleteFromCart").live("tap",function(){
    if(confirm("你确定要移除该商品吗?")){
        $.post("/mobile/mobileOrder/deleteFromCart", 
            [   
                { name: 'PRODUCT_NO', value: $(this).attr("pno")}
            ]
            , function (result){
                if (result == "Y"){
                    location.href = "/mobile/mobileOrder/viewCartList?page=1&pagesize=10";
                }else{
                    showTips("移除失败",topHeight-20,1);
                }
            }
        );
    }
});

//点击继续购物按钮
$(".shoppingContinue").live("tap",function(){
    $(".buyCount").val("1");
    $(".tipsClass").remove();
});

//添加到购物车后选择查看订单按钮
$(".viewCartList").live("tap",function(){
    spf_viewCartList();
});

function homePage(){
    location.href = "/mobile/home";
}

//判断数字-是则返回true
function checkNumber(value){
    var flag = true;
    if(value == null||value == ""||isNaN(value)||value<1){
        flag = false;
    }
    return flag;
}

//我的订单
function spf_viewMobileOrderList(){
    location.href="/mobile/mobileOrder/viewMobileOrderList";
}

//查看订单确认
function spf_viewCartList(){
    location.href="/mobile/mobileOrder/viewCartList?page=1&pagesize=10";
}

//页面下方菜单栏类目查看方法
function spf_viewMobileCategory(){
    location.href="/mobile/productManage/viewMobileCategory";
}

//点击搜索按钮-搜索条件输入框id必须为search
function spf_search(page){
    location.href="/mobile/productManage/viewMobileProList?PRODUCT_CATEGORY_ID="+$("#PRODUCT_CATEGORY_ID").val()+
        "&CATEGORY_NAME="+$("#CATEGORY_NAME").val()+
        "&ROOT_CATEGORY="+$("#ROOT_CATEGORY").val()+
        "&keyWord="+$("#search").val()+
        "&page="+page+"&pagesize=10"+
        "&M_AREA_NO="+$("#M_AREA_NO").val()+
        "&M_AREA_NAME="+$("#M_AREA_NAME").val()+
        "&ASC_OR_DESC="+$("#ASC_OR_DESC").val()+
        "&ORDER_BY="+$("#ORDER_BY").val();
}

function spf_search2(page,no,name){
    location.href="/mobile/productManage/viewMobileProList?PRODUCT_CATEGORY_ID="+$("#PRODUCT_CATEGORY_ID").val()+
        "&CATEGORY_NAME="+$("#CATEGORY_NAME").val()+
        "&ROOT_CATEGORY="+$("#ROOT_CATEGORY").val()+
        "&keyWord="+$("#search").val()+
        "&page="+page+"&pagesize=10"+
        "&M_AREA_NO="+no+
        "&M_AREA_NAME="+name+
        "&ASC_OR_DESC="+$("#ASC_OR_DESC").val()+
        "&ORDER_BY="+$("#ORDER_BY").val();
}

//显示信息,tips:信息内容；height:设置top距离;time:延时多长时间;
function showAddCartTips( tips, height ,time){ 
    var windowWidth = document.documentElement.clientWidth; 
    var tipsDiv = '<div class="tipsClass"><div style="height:35px;width:'+windowWidth+'px;line-height:35px;">' + tips + '</div>' +
        '<div style="height:45px;width:'+windowWidth+'px;line-height:45px;color:white;">'+
        '<input type="button" style="width:80px;height:30px;background-color:#518def;border:1px solid #518def;color:white;" value="继续购物" class="shoppingContinue"/>'+
        '<input type="button" style="width:80px;height:30px;background-color:#fa6209;border:1px solid #fa6209;color:white;margin-left:30px;" value="查看清单" class="viewCartList"/></div>'+
        '</div>'; 
    $( '.tipsClass' ).remove();
    $( 'body' ).append( tipsDiv ); 
    $( 'div.tipsClass' ).css({ 
        'top' : height + 'px', 
        //'left' :  windowWidth / 2 + 'px', 
        'position' : 'absolute', 
        'padding' : '3px 5px', 
        'background': '#353434', 
        'font-size' : 16 + 'px', 
        'margin' : '0 auto', 
        'text-align': 'center',
        'width' : windowWidth + 'px', 
        'height': '80px',
        'color' : '#fff', 
        'opacity' : '0.7' 
    }).show(); 
    setTimeout( function(){$( 'div.tipsClass' ).fadeOut();}, ( time * 1000 ) ); 
}

//显示信息,tips:信息内容；height:设置top距离;time:延时多长时间;
function showTips( tips, height, time ){ 
    var windowWidth = document.documentElement.clientWidth; 
    var tipsDiv = '<div class="tipsClass">' + tips + '</div>'; 
    $( '.tipsClass' ).remove();
    $( 'body' ).append( tipsDiv ); 
    $( 'div.tipsClass' ).css({ 
        'top' : height + 'px', 
        //'left' :  windowWidth / 2 + 'px', 
        'position' : 'absolute', 
        'padding' : '3px 5px', 
        'background': '#353434', 
        'font-size' : 16 + 'px', 
        'margin' : '0 auto', 
        'text-align': 'center',
        'width' : windowWidth + 'px', 
        'line-height':'50px', 
        'height': '50px',
        'color' : '#fff', 
        'opacity' : '0.7' 
    }).show(); 
    setTimeout( function(){$( 'div.tipsClass' ).fadeOut();}, ( time * 1000 ) ); 
}

//退出系统
$("#loginOut").live("tap",function(){
    spf_loginOut();
});

function spf_loginOut(){
    $.cookie('sperp.username', "",{path:"/"});
    $.cookie('sperp.password', "",{path:"/"});
    $.cookie('sperp.autoLogin',"",{path:"/"});
    location.href = "/login/out";
}

//返回到账号管理界面
$("#backToAccountManage").live("tap",function(){
    location.href = "/mobile/account/accountManage";
});

$("#login-link").live("tap",function(){
    location.href = "/mobile/login/index";
});

$("#regist-link").live("tap",function(){
    location.href = "/mobile/login/register";
});