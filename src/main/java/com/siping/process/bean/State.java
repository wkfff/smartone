package com.siping.process.bean;

import java.util.List;

import com.siping.doc.bean.MasterData;

public class State extends MasterData{
    private Type type;
    private State nexState;
    private List<State> preState;

    public Type getType() {
        return type;
    }
    public void setType(Type type) {
        this.type = type;
    }
    public State getNexState() {
        return nexState;
    }
    public void setNexState(State nexState) {
        this.nexState = nexState;
    }
    public List<State> getPreState() {
        return preState;
    }
    public void setPreState(List<State> preState) {
        this.preState = preState;
    }
}
