package com.siping.wechat.exception;

public class EventMessageBeyondPraseException extends Exception {
    private static final long serialVersionUID = 1L;
    public EventMessageBeyondPraseException() {
        super();
    }

    public EventMessageBeyondPraseException(String message, Throwable cause) {
        super(message, cause);
    }

    public EventMessageBeyondPraseException(String message) {
        super(message);
    }

    public EventMessageBeyondPraseException(Throwable cause) {
        super(cause);
    }
}
