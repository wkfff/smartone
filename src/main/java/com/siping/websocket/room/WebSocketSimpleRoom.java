package com.siping.websocket.room;

import java.util.Vector;

public class WebSocketSimpleRoom {

    private String key;

    private Vector<String> chatterIDs;

    public WebSocketSimpleRoom() {
    }

    public WebSocketSimpleRoom(String key, String chatters) {
        this.key = key;
        this.chatterIDs = new Vector<String>();
        String ids[] = key.split("A");
        for (int i = 0; i < ids.length; i++) {
            if (ids[i] != "" && ids[i] != null) {
                this.chatterIDs.add(ids[i]);
            }
        }
    }

    /**
     * @return the key
     */
    public String getKey() {
        return key;
    }

    /**
     * @param key the key to set
     */
    public void setKey(String key) {
        this.key = key;
    }

    public Vector<String> getChatterIDs() {
        return chatterIDs;
    }

    public void setChatterIDs(Vector<String> chatterIDs) {
        this.chatterIDs = chatterIDs;
    }

    public void addChatterID(String chatterID) {
        if (this.chatterIDs == null) {
            this.chatterIDs = new Vector<String>();
        }
        this.chatterIDs.add(chatterID);
    }

    public void removeChatterID(String chatterID) {
        this.chatterIDs.remove(chatterID);
    }

    public boolean haveChatterID() {
        return this.chatterIDs.size() > 0;
    }
}
