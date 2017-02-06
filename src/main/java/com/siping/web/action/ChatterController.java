package com.siping.web.action;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.web.service.ChatterInfoSer;
import com.siping.web.utility.SessionUtil;
import com.siping.websocket.room.WebSocketRoomManager;

@Controller
@RequestMapping(value = "/chat")
public class ChatterController {

    @Autowired
    private ChatterInfoSer chatterInfoSer;

    @RequestMapping(value = "/enterRoom")
    public ModelAndView enterRoom(HttpServletRequest request, ModelMap modelMap) {
        modelMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        InetAddress addr = null;
        try {
            addr = InetAddress.getLocalHost();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
        String ip = addr.getHostAddress().toString();// 获得本机IP
        modelMap.put("serverAddress", ip + ":"+ request.getServerPort() );
        modelMap.put("deptList", chatterInfoSer.getChatterDeptTree());
        return new ModelAndView("/web/chatter/chatRoom", modelMap);
    }

    @RequestMapping(value = "/getAllEmpDeptTree", method = RequestMethod.POST)
    public List getAllEmpDeptTree(HttpServletRequest request, ModelMap modelMap) {
        return chatterInfoSer.getAllEmpDeptTree();
    }

    @RequestMapping(value = "/setRoomID", method = RequestMethod.POST)
    @ResponseBody
    public boolean setRoomID(HttpServletResponse response, HttpServletRequest request) {
        String ids = request.getParameter("ids");
        return WebSocketRoomManager.setRoom(ids);
    }
}
