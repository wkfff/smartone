package com.siping.websocket.handler.impl;

import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.websocket.handler.ActionHandler;
import com.siping.websocket.room.WebSocketRoomManager;
import com.siping.websocket.room.WebSocketSimpleRoom;
import com.siping.websocket.utility.AdminBeanUtil;
import com.siping.websocket.websocket.WebSocketMessageInbound;

public class SayHandler implements ActionHandler {

    @Override
    public String getType(JSONObject json) {
        return "say";
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String getData(JSONObject json, WebSocketMessageInbound inbound) {
        JSONObject parameters = null;
        String resultString = null;
        AdminBean admin = inbound.getChatter();
        Map resultMap = AdminBeanUtil.beanToMap(admin);
        try {
            Object obj = json.get("parameters");
            parameters = (JSONObject) obj;
            resultMap.put("room", parameters.get("RoomKey"));
            resultMap.put("content", parameters.get("Content"));
            resultString = JsonUtil.map2json(resultMap);
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }

        return resultString;
    }

    @Override
    public WebSocketSimpleRoom getRoom(JSONObject json) {
        String roomKey = null;
        try {
            Object obj = json.get("parameters");
            JSONObject parameters = (JSONObject) obj;
            roomKey = parameters.get("RoomKey").toString();
        } catch (JSONException e) {
            e.printStackTrace();
            return null;
        }
        WebSocketSimpleRoom room = WebSocketRoomManager.getRoom(roomKey);
        return room;
    }

}
