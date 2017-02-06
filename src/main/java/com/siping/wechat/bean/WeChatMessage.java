package com.siping.wechat.bean;

import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.siping.wechat.exception.MsgTypeBeyondPraseException;
import com.siping.wechat.service.WechatSer;
import com.siping.wechat.util.WeChatConstant;

@Component("wc_weChatMessage")
@Scope("request")
public class WeChatMessage {
    public static final String WECHAT_EVENT_TYPE_MESSAGE = "event";
    public static final String WECHAT_TEXT_TYPE_MESSAGE = "text";

    public String webDomain;
    private String ToUserName;
    private String FromUserName;
    private int CreateTime;
    private String MsgType;

    @Autowired
    private WechatSer wechatSer;

    public void initParam(Map<String, String> messageMap) {
        setToUserName(messageMap.get("ToUserName"));
        setFromUserName(messageMap.get("FromUserName"));
        setCreateTime(messageMap.get("CreateTime"));
        setMsgType(messageMap.get("MsgType"));
    }

    public String getWebDomain() {
        return webDomain;
    }

    public void setWebDomain(String webDomain) {
        this.webDomain = webDomain;
    }

    public String getToUserName() {
        return ToUserName;
    }

    public void setToUserName(String toUserName) {
        ToUserName = toUserName;
    }

    public String getFromUserName() {
        return FromUserName;
    }

    public void setFromUserName(String fromUserName) {
        FromUserName = fromUserName;
    }

    public int getCreateTime() {
        return CreateTime;
    }

    public void setCreateTime(String createTime) {
        if (createTime != null) {
            CreateTime = Integer.parseInt(createTime);
        }
    }

    public String getMsgType() {
        return MsgType;
    }

    public void setMsgType(String msgType) {
        MsgType = msgType;
    }

    public String getReturnMessage() {
        return "";
    }

    public String generateTextMsgXML(String content) {
        String response = "";
        try {
            String acc = WeChatConstant.WECHAT_ACCOUNT;
            if(acc!=null&&!acc.equals("")){
                response = "<xml><ToUserName>" + this.getFromUserName() + "</ToUserName><FromUserName>" + acc + "</FromUserName>";
                response += "<CreateTime>" + (int) ((new Date()).getTime() / 1000) + "</CreateTime><MsgType>" + WeChatMessage.WECHAT_TEXT_TYPE_MESSAGE + "</MsgType>";
                response += "<Content><![CDATA[" + content + "]]></Content></xml>";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }

    public static WeChatMessage getBeanFromSpringContainter(ApplicationContext appContext, Map<String, String> weChatMessageMap) {
        if (weChatMessageMap.get("MsgType").equals(WECHAT_TEXT_TYPE_MESSAGE)) {
            return (TextMessage) appContext.getBean("wc_textMessage");
        }
        if (weChatMessageMap.get("MsgType").equals(WECHAT_EVENT_TYPE_MESSAGE)) {
            return (EventMessage) appContext.getBean("wc_eventMessage");
        }
        try {
            throw new MsgTypeBeyondPraseException("MsgType beyond parsing!");
        } catch (Exception e) {
        }
        return (WeChatMessage) appContext.getBean("wc_weChatMessage");
    }
}
