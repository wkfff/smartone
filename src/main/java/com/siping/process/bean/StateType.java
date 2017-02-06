package com.siping.process.bean;

import org.codehaus.jackson.annotate.JsonCreator;
import org.codehaus.jackson.annotate.JsonValue;

public enum StateType {
    CREATE(1, true), APPROVE(2, true), ARCHIVE(3, false);
    private Boolean editable;
    private Integer id;

    StateType(Integer id, Boolean editable) {
        this.id = id;
        this.editable = editable;
    }

    @JsonValue
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Boolean getEditable() {
        return editable;
    }

    public void setEditable(Boolean editable) {
        this.editable = editable;
    }

    @JsonCreator
    public static StateType cretae(Integer id) {
        StateType[] stateTypes = StateType.values();
        for (StateType stateType : stateTypes) {
            if (stateType.getId() == id) {
                return stateType;
            }
        }
        return CREATE;
    }
}
