package com.siping.wechat.util;

public class HandleReturnCode {

    public static String handle(int errcode){
        String str = "未知错误";
        if(errcode==0){
            str = "请求操作成功";
        }else if(errcode==-1){
            str = "系统繁忙";
        }else if(errcode==40001){
            str = "获取access_token时AppSecret错误，或者access_token无效";
        }else if(errcode==40002){
            str = "不合法的凭证类型";
        }else if(errcode==40003){
            str = "不合法的OpenID";
        }else if(errcode==40004){
            str = "不合法的媒体文件类型";
        }else if(errcode==40005){
            str = "不合法的文件类型";
        }else if(errcode==40006){
            str = "不合法的文件大小";
        }else if(errcode==40007){
            str = "不合法的媒体文件id";
        }else if(errcode==40008){
            str = "不合法的消息类型";
        }else if(errcode==40009){
            str = "不合法的图片文件大小";
        }else if(errcode==40010){
            str = "不合法的语音文件大小";
        }else if(errcode==40011){
            str = "不合法的视频文件大小";
        }else if(errcode==40012){
            str = "不合法的缩略图文件大小";
        }else if(errcode==40013){
            str = "不合法的APPID";
        }else if(errcode==40014){
            str = "不合法的access_token";
        }else if(errcode==40015){
            str = "不合法的菜单类型";
        }else if(errcode==40016){
            str = "不合法的按钮个数";
        }else if(errcode==40017){
            str = "没有设置菜单响应类型或不合法的按钮个数";
        }else if(errcode==40018){
            str = "不合法的按钮名字长度";
        }else if(errcode==40019){
            str = "不合法的按钮KEY长度";
        }else if(errcode==40020){
            str = "不合法的按钮URL长度";
        }else if(errcode==40021){
            str = "不合法的菜单版本号";
        }else if(errcode==40022){
            str = "不合法的子菜单级数";
        }else if(errcode==40023){
            str = "不合法的子菜单按钮个数";
        }else if(errcode==40024){
            str = "不合法的子菜单按钮类型";
        }else if(errcode==40025){
            str = "不合法的子菜单按钮名字长度";
        }else if(errcode==40026){
            str = "不合法的子菜单按钮KEY长度";
        }else if(errcode==40027){
            str = "不合法的子菜单按钮URL长度";
        }else if(errcode==40028){
            str = "不合法的自定义菜单使用用户";
        }else if(errcode==40029){
            str = "不合法的oauth_code";
        }else if(errcode==40030){
            str = "不合法的refresh_token";
        }else if(errcode==40031){
            str = "不合法的openid列表";
        }else if(errcode==40032){
            str = "不合法的openid列表长度";
        }else if(errcode==40033){
            str = "不合法的请求字符，不能包含\\uxxxx格式的字符";
        }else if(errcode==40035){
            str = "不合法的参数";
        }else if(errcode==40038){
            str = "不合法的请求格式";
        }else if(errcode==40039){
            str = "不合法的URL长度";
        }else if(errcode==40050){
            str = "不合法的分组id";
        }else if(errcode==40051){
            str = "分组名字不合法";
        }else if(errcode==41001){
            str = "缺少access_token参数";
        }else if(errcode==41002){
            str = "缺少appid参数";
        }else if(errcode==41003){
            str = "缺少refresh_token参数";
        }else if(errcode==41004){
            str = "缺少secret参数";
        }else if(errcode==41005){
            str = "缺少多媒体文件数据";
        }else if(errcode==41006){
            str = "缺少media_id参数";
        }else if(errcode==41007){
            str = "缺少子菜单数据";
        }else if(errcode==41008){
            str = "缺少oauth code";
        }else if(errcode==41009){
            str = "缺少openid";
        }else if(errcode==42001){
            str = "access_token超时";
        }else if(errcode==42002){
            str = "refresh_token超时";
        }else if(errcode==42003){
            str = "oauth_code超时";
        }else if(errcode==43001){
            str = "需要GET请求";
        }else if(errcode==43002){
            str = "需要POST请求";
        }else if(errcode==43003){
            str = "需要HTTPS请求";
        }else if(errcode==43004){
            str = "需要接收者关注";
        }else if(errcode==43005){
            str = "需要好友关系";
        }else if(errcode==44001){
            str = "多媒体文件为空";
        }else if(errcode==44002){
            str = "POST的数据包为空";
        }else if(errcode==44003){
            str = "图文消息内容为空";
        }else if(errcode==44004){
            str = "文本消息内容为空";
        }else if(errcode==45001){
            str = "多媒体文件大小超过限制";
        }else if(errcode==45002){
            str = "消息内容超过限制";
        }else if(errcode==45003){
            str = "标题字段超过限制";
        }else if(errcode==45004){
            str = "描述字段超过限制";
        }else if(errcode==45005){
            str = "链接字段超过限制";
        }else if(errcode==45006){
            str = "图片链接字段超过限制";
        }else if(errcode==45007){
            str = "语音播放时间超过限制";
        }else if(errcode==45008){
            str = "图文消息超过限制";
        }else if(errcode==45009){
            str = "接口调用超过限制";
        }else if(errcode==45010){
            str = "创建菜单个数超过限制";
        }else if(errcode==45015){
            str = "回复时间超过限制";
        }else if(errcode==45016){
            str = "系统分组，不允许修改";
        }else if(errcode==45017){
            str = "分组名字过长";
        }else if(errcode==45018){
            str = "分组数量超过上限";
        }else if(errcode==46001){
            str = "不存在媒体数据";
        }else if(errcode==46002){
            str = "不存在的菜单版本";
        }else if(errcode==46003){
            str = "不存在的菜单数据";
        }else if(errcode==46004){
            str = "不存在的用户";
        }else if(errcode==47001){
            str = "解析JSON/XML内容错误";
        }else if(errcode==48001){
            str = "api功能未授权";
        }else if(errcode==50001){
            str = "用户未授权该api";
        }
        return str;
    }
}
