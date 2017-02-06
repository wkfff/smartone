package com.siping.process.bean;

import com.siping.doc.bean.MasterData;

public class ProcessRunning extends MasterData {
    private State state;
    private Type type;
    private Integer result;
    private String dataClass;
    private Long dataNo;

    public State getState() {
        return state;
    }

    public void setState(State state) {
        this.state = state;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }

    public Integer getResult() {
        return result;
    }

    public void setResult(Integer result) {
        this.result = result;
    }

    public String getDataClass() {
        return dataClass;
    }

    public void setDataClass(String dataClass) {
        this.dataClass = dataClass;
    }

    public Long getDataNo() {
        return dataNo;
    }

    public void setDataNo(Long dataNo) {
        this.dataNo = dataNo;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        ProcessRunning other = (ProcessRunning) obj;
        if (state == null) {
            if (other.state != null)
                return false;
        } else if (!state.getNo().equals(other.state.getNo()))
            return false;
        if (type == null) {
            if (other.type != null)
                return false;
        } else if (!type.getNo().equals(other.type.getNo()))
            return false;
        return true;
    }
}
