package com.siping.websocket.websocket;

import java.io.IOException;
import java.nio.CharBuffer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import org.apache.catalina.websocket.WsOutbound;
import org.apache.log4j.Logger;

import com.siping.system.bean.AdminBean;
import com.siping.websocket.room.WebSocketSimpleRoom;

public class WebSocketMessageInboundPool {
    private static Logger logger = Logger.getLogger(WebSocketMessageInboundPool.class);

    /**
     * chatter 与 实际连接的一一对应关系(EMPID --- inbound)
     */
    private static final Map<String, WebSocketMessageInbound> connections = new HashMap<String, WebSocketMessageInbound>();

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static List<WebSocketMessageInbound> getAllConnectionsInPool() {
        List resultList = new ArrayList<WebSocketMessageInbound>();
        for (Object obj : WebSocketMessageInboundPool.connections.keySet()) {
            resultList.add(WebSocketMessageInboundPool.connections.get(obj));
        }
        return resultList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public static List<AdminBean> getAllChattersInPool() {
        List resultList = new ArrayList<AdminBean>();
        for (Object obj : WebSocketMessageInboundPool.connections.keySet()) {
            resultList.add(WebSocketMessageInboundPool.connections.get(obj).getChatter());
        }
        return resultList;
    }

    /**
     * 添加连接
     * @param inbound
     */
    public static void addChatterInbound(WebSocketMessageInbound inbound) {
        logger.debug(inbound.getChatter().getAdminID()+": join in chatting");
        sendMessage(inbound.getChatter().getAdminID(),new String("Logined in another place").toCharArray());
        connections.put(inbound.getChatter().getAdminID(), inbound);
    }

    /**
     * 移除连接
     * @param inbound
     */
    public static void removeChatterInbound(WebSocketMessageInbound inbound) {
        logger.debug(inbound.getChatter().getAdminID()+": exciting");
        connections.remove(inbound.getChatter().getAdminID());
    }

    /**
     * 向特定的用户发送数据
     * @param chatterID
     * @param message
     */
    public static void sendMessage(String chatterID, char[] message) {
        try {
            logger.debug("send message to chatter : [" + chatterID + "]");
            WebSocketMessageInbound inbound = connections.get(chatterID);
            if (inbound != null) {
                WsOutbound outbound = inbound.getWsOutbound();
                outbound.writeTextMessage(CharBuffer.wrap(message));
                outbound.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 向特定的房间内所有用户发送数据
     * @param room
     * @param message
     * @throws IOException
     */
    public static void sendMessage(WebSocketSimpleRoom room, char[] message) throws IOException {
        if (room != null) {
            Vector<String> chatterIDs = room.getChatterIDs();
            if (chatterIDs != null) {
                for (String chatterID : chatterIDs) {
                    WebSocketMessageInboundPool.sendMessage(chatterID, message);
                }
            }
        } else {
            sendMessage(message);
        }
    }
    
    /**
     * 所有在线用户发送数据
     * @param room
     * @param message
     * @throws IOException
     */
    public static void sendMessage(char[] message) throws IOException {
        for (WebSocketMessageInbound inbound : WebSocketMessageInboundPool.getAllConnectionsInPool()) {
            CharBuffer buffer = CharBuffer.wrap(message);
            WsOutbound outbound = inbound.getWsOutbound();
            outbound.writeTextMessage(buffer);
            outbound.flush();
        }
    }
}
