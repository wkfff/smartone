package com.siping.websocket.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.websocket.StreamInbound;
import org.apache.catalina.websocket.WebSocketServlet;

import com.siping.system.bean.AdminBean;
import com.siping.web.utility.SessionUtil;
import com.siping.websocket.websocket.WebSocketMessageInbound;

@WebServlet(urlPatterns = { "/websocket" })
public class WebSocketWebSocketServlet extends WebSocketServlet {
    private static final long serialVersionUID = 1L;

    private AdminBean chatter;

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        if (admin != null) {
            this.chatter = admin;
        }
        super.doGet(request, response);
    }

    @Override
    protected StreamInbound createWebSocketInbound(String subProtocol, HttpServletRequest request) {
        System.out.println("Create a new Instance of webSocketServlet for a new chatter");
        return new WebSocketMessageInbound(chatter);
    }
}
