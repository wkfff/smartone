package com.siping.websocket.handler;

import com.siping.websocket.handler.impl.ListHandler;
import com.siping.websocket.handler.impl.RegisterHandler;
import com.siping.websocket.handler.impl.SayHandler;
import com.siping.websocket.handler.impl.UnregisterHandler;

public class HandlerFactory {
    public static ActionHandler createActionHandler(String handlerName) {
        if (handlerName.equals("Handler.Register")) {
            return new RegisterHandler();
        } else if (handlerName.equals("Handler.List")) {
            return new ListHandler();
        } else if (handlerName.equals("Handler.Say")) {
            return new SayHandler();
        } else if (handlerName.equals("Handler.Unregister")) {
            return new UnregisterHandler();
        }
        return new SayHandler();
    }
}
