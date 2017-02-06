package com.siping.bom.bean;

import org.codehaus.jackson.annotate.JsonCreator;

public enum BomCategory {
    MATERIAL(0), DOC(1);
    private int code;

    private BomCategory(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }

    @JsonCreator
    public static BomCategory parseCategory(int code) {
        BomCategory[] types = BomCategory.values();
        for (BomCategory type : types) {
            if (type.getCode() == code) {
                return type;
            }
        }
        return MATERIAL;
    }
}
