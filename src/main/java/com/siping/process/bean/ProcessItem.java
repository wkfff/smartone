package com.siping.process.bean;

import com.siping.doc.bean.MasterData;

/**
 * 流转状态节点
 * @author Mx
 */
public class ProcessItem extends MasterData {
    private Type type;
    private State state;
    private StateType stateType;
    private State nextState;
    private State preState1;
    private State preState2;
    private State preState3;
    private ProcessModel processModel;

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public State getNextState() {
        return nextState;
    }

    public void setNextState(State nextState) {
        this.nextState = nextState;
    }

    public State getPreState1() {
        return preState1;
    }

    public void setPreState1(State preState1) {
        this.preState1 = preState1;
    }

    public State getPreState2() {
        return preState2;
    }

    public void setPreState2(State preState2) {
        this.preState2 = preState2;
    }

    public State getPreState3() {
        return preState3;
    }

    public void setPreState3(State preState3) {
        this.preState3 = preState3;
    }

    public StateType getStateType() {
        return stateType;
    }

    public void setStateType(StateType stateType) {
        this.stateType = stateType;
    }

    public ProcessModel getProcessModel() {
        return processModel;
    }

    public void setProcessModel(ProcessModel processModel) {
        this.processModel = processModel;
    }
}
