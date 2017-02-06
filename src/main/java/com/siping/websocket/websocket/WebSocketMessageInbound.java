package com.siping.websocket.websocket;

import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.util.Map;

import org.apache.catalina.websocket.MessageInbound;
import org.apache.catalina.websocket.WsOutbound;
import org.json.JSONException;
import org.json.JSONObject;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.JsonUtil;
import com.siping.websocket.room.WebSocketSimpleRoom;
import com.siping.websocket.utility.JsonParser;

public class WebSocketMessageInbound extends MessageInbound {

    private final AdminBean chatter;

    public WebSocketMessageInbound(AdminBean chatter) {
        this.chatter = chatter;
    }

    public AdminBean getChatter() {
        return this.chatter;
    }

    @Override
    protected void onOpen(WsOutbound outbound) {
        // 触发连接事件，在连接池中添加连接
        WebSocketMessageInboundPool.addChatterInbound(this);
    }

    @Override
    protected void onClose(int status) {
        // 触发关闭事件，在连接池中移除连接
        WebSocketMessageInboundPool.removeChatterInbound(this);
        // 通知其他在线用户此人下线
        try {
            onTextMessage(CharBuffer.wrap("{url:\"Handler.Unregister\"}"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void onBinaryMessage(ByteBuffer message) throws IOException {
        throw new UnsupportedOperationException("Binary message not supported.");
    }

    @SuppressWarnings("rawtypes")
    @Override
    protected void onTextMessage(CharBuffer message) throws IOException {
        JSONObject json = null;
        char[] resultMessage = null;
        Map resultMap = null;
        try {
            json = new JSONObject(message.toString());
            resultMap = JsonParser.parse(json, this);
            resultMessage = JsonUtil.map2json(resultMap).toCharArray();
        } catch (JSONException e) {
            e.printStackTrace();
            return;
        }
        WebSocketMessageInboundPool.sendMessage((WebSocketSimpleRoom) resultMap.get("room"), resultMessage);
    }
}
