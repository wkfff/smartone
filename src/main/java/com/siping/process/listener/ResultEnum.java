package com.siping.process.listener;

public enum ResultEnum {
    SUCESS(0), PRE1(1), PRE2(2), PRE3(3);
    private int code;

    ResultEnum(int code) {
        this.code = code;
    }

    public int getCode() {
        return code;
    }
}
