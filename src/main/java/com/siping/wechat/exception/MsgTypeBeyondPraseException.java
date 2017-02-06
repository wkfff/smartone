package com.siping.wechat.exception;

public class MsgTypeBeyondPraseException extends Exception {
    private static final long serialVersionUID = 1L;
    public MsgTypeBeyondPraseException() {
        super();
    }

    public MsgTypeBeyondPraseException(String message, Throwable cause) {
        super(message, cause);
    }

    public MsgTypeBeyondPraseException(String message) {
        super(message);
    }

    public MsgTypeBeyondPraseException(Throwable cause) {
        super(cause);
    }
}
