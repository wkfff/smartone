<%@ page contentType="text/html; charset=UTF-8" language="java" errorPage=""%>
<!doctype html>
<html>
<head>
<title>Home</title>
<script type="text/javascript">
    //给图片绑定屏幕触控事件，进入我的订单界面
    $(".myOrder").live("tap",function() {
        spf_viewMobileOrderList();
    });

    //给图片绑定屏幕触控事件，进入账号管理界面
    $("#account").live("tap",function() {
        spf_accountManage();
    });
    
    //给图片绑定屏幕触控事件，进入购物车界面
    $("#cart").live("tap",function() {
        spf_viewCartList();
    });
  
    //给图片绑定屏幕触控事件，进入商品类别界面
    $("#goCategory").live("tap",function() {
        spf_viewMobileCategory();
    });
    
    /* document.write(new Array(100).join("<br/>"));
    var clientHeight = document.body.clientHeight;
    window.onscroll = sfp_scall;
    window.onresize = sfp_scall;
    window.onload = sfp_scall;
    function sfp_scall() {
        if(document.documentElement.scrollTop%50==0&&parseInt(document.documentElement.scrollTop)>0){
            alert(document.documentElement.scrollTop);
        }
        document.getElementById("floatFooter").style.top = (document.documentElement.scrollTop)+clientHeight-50+"px";
        document.getElementById("floatFooter").style.left=(document.documentElement.scrollLeft
                + document.documentElement.clientWidth - document
                .getElementById("floatFooter").offsetWidth) + "px";} */
    //进入个人信息修改页面 
    function spf_accountManage(){
        location.href = "/mobile/account/accountManage";
    }
</script>
<style>
    a:link,a:visited{
        text-decoration:none
    }
</style>
</head>
<body>
    <div id="floatFooter" data-role="footer" data-theme="c" style="width:100%;">
        <div style="width: 100%; height: 60px; background-color: #e6e6e6;">
            <table style="width: 100%; height: 60px; border-collapse: collapse;">
                <tr style="height: 40px;" >
                    <td width="20%" align="center">
                        <div class="homePage" style="width: 100%;height: 40px;">
                            <img src="/resources/images/myimage/home.png" style="height: 45px;"/>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div class="myOrder" style="width: 100%;height: 40px;">
                            <img src="/resources/images/myimage/order.png" style="height: 40px;"/>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div id="account" style="width: 100%;height: 40px;">
                            <img src="/resources/images/myimage/personal.png" style="height: 40px;"/>
                        </div>
                    </td>
                    <td width="20%" align="center" valign="top">
                        <div id="cart" style="width: 100%;font-size:10px;color:#e66e25;height: 40px;">
                            <img src="/resources/images/myimage/cart.png" style="height: 44px;"/>
                            <label id="listNumTip">${cartProList.size() }</label>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div id="goCategory" style="width: 100%;height: 40px;">
                            <img src="/resources/images/myimage/category.png" style="height: 40px;"/>
                        </div>
                    </td>
                </tr>
                <tr style="height: 20px;">
                    <td width="20%" align="center">
                        <div style="width: 100%; font-size: 10px;height: 20px;">
                            <a href="javascript:homePage()" style="color: #71a9ed;">主页</a>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div style="width: 100%; font-size: 10px;height: 20px;">
                            <a href="javascript:spf_viewMobileOrderList()" style="color: #71a9ed;">订单</a>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div style="width: 100%;font-size: 10px;height: 20px;">
                            <a href="javascript:spf_accountManage()" style="color: #71a9ed;">个人中心</a>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div style="width: 100%;font-size: 10px;height: 20px;">
                            <a href="javascript:spf_viewCartList()" style="color: #71a9ed;">购物车</a>
                        </div>
                    </td>
                    <td width="20%" align="center">
                        <div style="width: 100%; height: 18px; font-size: 10px;height: 20px;">
                            <a href="javascript:spf_viewMobileCategory()" style="color: #71a9ed;">类目</a>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</body>
</html>