package com.siping.web.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.web.bean.Message;

public interface MessageSer {

    public List<Message> getMessageList(HttpServletRequest request);

    public int getMessageListCnt(HttpServletRequest request);

    public List<Message> getMyMessageList(HttpServletRequest request);

    public int getMyMessageListCnt(HttpServletRequest request);

    public String sendMessageInfo(HttpServletRequest request);

    public String addReadMessage(HttpServletRequest request);

    public String deleteMessage(HttpServletRequest request);
}
