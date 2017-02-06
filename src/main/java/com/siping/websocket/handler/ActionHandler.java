package com.siping.websocket.handler;

import org.json.JSONObject;

import com.siping.websocket.room.WebSocketSimpleRoom;
import com.siping.websocket.websocket.WebSocketMessageInbound;

public interface ActionHandler {

    public String getType(JSONObject json);

    public WebSocketSimpleRoom getRoom(JSONObject json);

    public String getData(JSONObject json, WebSocketMessageInbound inbound);
}
