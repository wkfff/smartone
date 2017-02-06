package com.siping.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.action.EmpInfoCtroller;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.web.bean.Message;
import com.siping.web.bean.Pagging;
import com.siping.web.service.MessageSer;

@Controller
@RequestMapping(value = "/message/messageManage")
public class MessageManageController {

    Logger logger = Logger.getLogger(EmpInfoCtroller.class);
    @Autowired
    private MessageSer messageSer;
    @Autowired
    private EmpInfoSer empInfoSer;

    @RequestMapping(value = "/viewSendMessage", method = RequestMethod.GET)
    public ModelAndView viewProductList(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/message/messageManage/viewSendMessage", modelMap);
    }

    @RequestMapping(value = "/viewMessageManage", method = RequestMethod.GET)
    public ModelAndView viewMessageManage(HttpServletRequest request, ModelMap modelMap) throws Exception {
        return new ModelAndView("/web/message/messageManage/viewMessageManage", modelMap);
    }

    /**
     * 获取产品信息
     * @param request
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMessageList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMessageList(HttpServletRequest request) throws Exception {
        List<Message> messageList = this.messageSer.getMessageList(request);
        int messageListCnt = this.messageSer.getMessageListCnt(request);
        Map model = new HashMap();
        model.put("Rows", messageList);
        model.put("Total", messageListCnt);

        return model;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @RequestMapping(value = "/getMyMessageList", method = RequestMethod.POST)
    @ResponseBody
    public Map getMyMessageList(HttpServletRequest request) throws Exception {
        List<Message> messageList = this.messageSer.getMyMessageList(request);
        int messageListCnt = this.messageSer.getMyMessageListCnt(request);
        Pagging page = new Pagging(Integer.valueOf(request.getParameter("page")), messageListCnt, Integer.valueOf(request.getParameter("pagesize")));

        Map model = new HashMap();
        model.put("Rows", messageList);
        model.put("Total", messageListCnt);
        model.put("page", page);
        return model;
    }

    @RequestMapping(value = "/getMyMessageCnt", method = RequestMethod.POST)
    @ResponseBody
    public int getMyMessageCnt(HttpServletRequest request) throws Exception {
        int messageListCnt = this.messageSer.getMyMessageListCnt(request);
        return messageListCnt;
    }

    @RequestMapping(value = "/sendMessageInfo", method = RequestMethod.POST)
    @ResponseBody
    public String sendMessageInfo(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.messageSer.sendMessageInfo(request);
        return returnString;
    }

    @RequestMapping(value = "/viewPersonalMessage", method = RequestMethod.GET)
    public ModelAndView viewPersonalMessage(HttpServletRequest request, ModelMap modelMap) throws Exception {
        modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
        return new ModelAndView("/web/message/messageManage/viewPersonalMessage", modelMap);
    }

    @RequestMapping(value = "/addReadMessage", method = RequestMethod.POST)
    @ResponseBody
    public String addReadMessage(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.messageSer.addReadMessage(request);
        return returnString;
    }

    @RequestMapping(value = "/deleteMessage", method = RequestMethod.POST)
    @ResponseBody
    public String deleteMessage(HttpServletRequest request) throws Exception {
        String returnString = "Y";
        returnString = this.messageSer.deleteMessage(request);
        return returnString;
    }
}
