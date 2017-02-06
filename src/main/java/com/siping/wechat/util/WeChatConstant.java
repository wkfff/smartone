package com.siping.wechat.util;

/**
 * 微信接口的常量参数类
 */
public class WeChatConstant {

    /**
     * 微信账号
     */
    public static final String WECHAT_ACCOUNT = "SipingSoft";

    /**
     * 微信appid
     */
    public static final String APPID = "wxf80f6cff0b60cc82";

    /**
     * 微信appsecret
     */
    public static final String APPSECRET = "ef62ee09c46536cf6ec44654b9d40e29";

    /**
     * url的认证token
     */
    public static final String TOKEN = "sipingsoft";

    /**
     * 获取服务的access_token，和oauth或的access_token截然不同，7200s会过期，系统则会每3600s刷新一次，参见com.
     * siping.wechat.task.impl.WechatScheduledImpl的access_token刷新机制
     */
    public static String ACCESS_TOKEN = "";

    /**
     * 信息类型常量
     */
    public static final String WECHAT_EVENT_TYPE_MESSAGE = "event";// 点击事件
    public static final String WECHAT_NEWS_TYPE_MESSAGE = "news";// 图文信息
    public static final String WECHAT_TEXT_TYPE_MESSAGE = "text";// 文本
    /**
     * 事件类型常量
     */
    /********************************************************************/
    public static final String EVENT_TYPE_SUBSCRIBE = "subscribe"; // 订阅事件
    public static final String EVENT_TYPE_UNSUBSCRIBE = "unsubscribe";// 取消订阅
    public static final String REQ_MESSAGE_TYPE_EVENT = "event"; // 事件

    /**
     * 官方提供的服务url，使用时需要将部分参数做替换，如ACCESS_TOKEN需要替换为具体的access_token值
     */
    public static final String GET_USERINFO_URL = "https://api.weixin.qq.com/cgi-bin/user/info?access_token=" + "ACCESS_TOKEN&openid=OPENID&lang=zh_CN";
    public static final String GTE_ACCESSTOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token?grant_type=" + "client_credential&appid=APPID&secret=APPSECRET";
    public static final String GET_OAUTH_URL = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" + "APPID&secret=SECRET&code=CODE&grant_type=authorization_code";
    public static final String GET_OAUTH_USER = "https://api.weixin.qq.com/sns/userinfo?access_token=ACCESS_TOKEN&openid=OPENID";
    public static final String GET_USER_OPENID = "https://api.weixin.qq.com/cgi-bin/user/get?access_token=" + "ACCESS_TOKEN&next_openid=NEXT_OPENID&lang=zh_CN";
    public static final String GET_MENU_CREATE_URL = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
}
