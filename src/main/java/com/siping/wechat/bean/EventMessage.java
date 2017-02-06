package com.siping.wechat.bean;

import java.util.LinkedHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import com.siping.system.dao.BasicMaintenanceDao;
import com.siping.web.utility.StringUtil;
import com.siping.wechat.service.WechatSer;
import com.siping.wechat.util.WeChatConstant;

@Component("wc_eventMessage")
@Scope("request")
public class EventMessage extends WeChatMessage {

    private static final String EVENT_CLICK = "CLICK";

    private String Event;
    private String EventKey;

    @Autowired
    private BasicMaintenanceDao basicMaintenanceDao;
    @Autowired
    private WechatSer wechatSer;

    public void initParam(LinkedHashMap<String, String> mesaageMap) {
        super.initParam(mesaageMap);
        setEvent(mesaageMap.get("Event"));
        setEventKey(mesaageMap.get("EventKey"));
    }

    public String getEvent() {
        return Event;
    }

    public void setEvent(String event) {
        Event = event;
    }

    public String getEventKey() {
        return EventKey;
    }

    public void setEventKey(String eventKey) {
        EventKey = eventKey;
    }

    public String getReturnMessage() {
        String response = "";
        if (this.getEvent().equals(EVENT_CLICK)) {
            // 订阅
            if (this.getEventKey().equals(WeChatConstant.EVENT_TYPE_SUBSCRIBE)) {
                return this.generateTextMsgXML(getWelcomeInfo());
            }else{
             // click事件响应内容
                String eventKey = this.getEventKey();
                WechatMenu menu = null;
                String msg = "";
                try {
                    menu = wechatSer.getMenuByMenuKey(eventKey);
                    msg = menu.getReplyText();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return this.generateTextMsgXML(msg);
            }
        }
        return response;
    }

    @SuppressWarnings("unchecked")
    private String getWelcomeInfo() {
        StringBuffer command = new StringBuffer();
        LinkedHashMap<String, Object> paramMap = new LinkedHashMap<String, Object>();
        paramMap.put("CPNY_ID", "wooribank");
        LinkedHashMap<String, Object> company = (LinkedHashMap<String, Object>) basicMaintenanceDao.getCompanyInfoObj(paramMap);
        if (company != null) {
            command.append("欢迎关注" + StringUtil.checkNull(company.get("CPNY_NAME")) + "微信公共服务账号！");
        }
        return command.toString();
    }
}
