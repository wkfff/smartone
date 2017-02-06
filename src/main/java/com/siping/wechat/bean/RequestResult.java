package com.siping.wechat.bean;

/**
 * 处理结果返回类
 * @author Mx
 *
 */
public class RequestResult {
    /**
     * 处理结果编号0代表成功，其他代表失败
     */
    int code=0;
    /**
     * 如果出错的信息
     */
    String message;
    public int getCode() {
        return code;
    }
    public void setCode(int code) {
        this.code = code;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
}
