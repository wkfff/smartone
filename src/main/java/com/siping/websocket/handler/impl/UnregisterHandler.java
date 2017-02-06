package com.siping.websocket.handler.impl;

import java.util.Map;

import org.json.JSONObject;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.websocket.handler.ActionHandler;
import com.siping.websocket.room.WebSocketSimpleRoom;
import com.siping.websocket.utility.AdminBeanUtil;
import com.siping.websocket.websocket.WebSocketMessageInbound;

public class UnregisterHandler implements ActionHandler {

    @Override
    public String getType(JSONObject json) {
        return "unregister";
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String getData(JSONObject json, WebSocketMessageInbound inbound) {
        AdminBean admin = inbound.getChatter();
        Map resultMap = AdminBeanUtil.beanToMap(admin);
        return JsonUtil.map2json(resultMap);
    }

    @Override
    public WebSocketSimpleRoom getRoom(JSONObject json) {
        return null;
    }

}
