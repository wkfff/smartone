package com.siping.websocket.room;

import java.util.HashMap;
import java.util.Map;

public class WebSocketRoomManager {
    private static final Map<String, WebSocketSimpleRoom> provider = new HashMap<String, WebSocketSimpleRoom>();

    public static void addChatter(String roomKey, String chatter) {
        WebSocketSimpleRoom room = provider.get(roomKey);
        if (room == null) {
            System.out.println("add room : " + roomKey);
            room = new WebSocketSimpleRoom(roomKey, chatter);
            provider.put(roomKey, room);
        } else {
            room.addChatterID(chatter);
        }
    }

    public static void removeChatter(String roomKey, String chatter) {
        WebSocketSimpleRoom room = provider.get(roomKey);
        if (room != null) {
            System.out.println("remove chatter : " + chatter);
            room.removeChatterID(chatter);
        }
        if (!room.haveChatterID()) {
            provider.remove(roomKey);
            System.out.println("remove room : " + roomKey);
        }
    }

    public static boolean haveChatter(String key) {
        WebSocketSimpleRoom room = provider.get(key);
        if (room != null) {
            return room.haveChatterID();
        } else {
            return false;
        }
    }

    public static WebSocketSimpleRoom getRoom(String key) {
        if (key == null) {
            return null;
        }
        return provider.get(key);
    }

    public static boolean setRoom(String key) {
        if (key != null) {
            if (getRoom(key) == null) {
                WebSocketSimpleRoom room = new WebSocketSimpleRoom(key, key);
                provider.put(key, room);
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    }
}
