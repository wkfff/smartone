package com.siping.process.bean;

import java.util.List;

import com.siping.doc.bean.MasterData;

/**
 * 类型
 * @author Mx
 */
public class Type extends MasterData {
    private List<State> states;
    private List<Grant> grants;
    private Type parentType;
    private State defaultState;

    public List<State> getStates() {
        return states;
    }

    public void setStates(List<State> states) {
        this.states = states;
    }

    public List<Grant> getGrants() {
        return grants;
    }

    public void setGrants(List<Grant> grants) {
        for(Grant grant : grants){
            grant.setType(this);
        }
        this.grants = grants;
    }

    public State getDefaultState() {
        return defaultState;
    }

    public void setDefaultState(State defaultState) {
        this.defaultState = defaultState;
    }

    public Type getParentType() {
        return parentType;
    }

    public void setParentType(Type parentType) {
        this.parentType = parentType;
    }

    public Long getParentNo() {
        if (parentType != null) {
            return parentType.getNo();
        } else {
            return null;
        }
    }

}
