package com.siping.websocket.utility;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.siping.websocket.handler.ActionHandler;
import com.siping.websocket.handler.HandlerFactory;
import com.siping.websocket.websocket.WebSocketMessageInbound;

public class JsonParser {
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public static Map parse(JSONObject json, WebSocketMessageInbound inbound) throws JSONException {
        ActionHandler actionHandler = HandlerFactory.createActionHandler(json.get("url").toString());
        Map resultMap = new HashMap<String, String>();
        resultMap.put("type", actionHandler.getType(json));
        resultMap.put("data", actionHandler.getData(json, inbound));
        resultMap.put("room", actionHandler.getRoom(json));
        return resultMap;
    }
}
