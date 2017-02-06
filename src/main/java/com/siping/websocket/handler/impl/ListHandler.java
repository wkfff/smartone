package com.siping.websocket.handler.impl;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.websocket.handler.ActionHandler;
import com.siping.websocket.room.WebSocketSimpleRoom;
import com.siping.websocket.utility.AdminBeanUtil;
import com.siping.websocket.websocket.WebSocketMessageInbound;
import com.siping.websocket.websocket.WebSocketMessageInboundPool;

public class ListHandler implements ActionHandler {

    @Override
    public String getType(JSONObject json) {
        return "list";
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String getData(JSONObject json, WebSocketMessageInbound inbound) {
        List resultList = new ArrayList();
        for (AdminBean admin : WebSocketMessageInboundPool.getAllChattersInPool()) {
            resultList.add(AdminBeanUtil.beanToMap(admin));
        }
        return JsonUtil.list2json(resultList);
    }

    @Override
    public WebSocketSimpleRoom getRoom(JSONObject json) {
        return null;
    }
}
