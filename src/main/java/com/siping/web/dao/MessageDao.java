package com.siping.web.dao;

import java.util.List;

import com.siping.web.bean.Message;

public interface MessageDao {
    public List<Message> getMessageList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getMessageList(Object object, int currentPage, int pageSize);

    public int getMessageListCnt(Object object);

    public String addMessageInfo(Object object);

    @SuppressWarnings("rawtypes")
    public String addMessageEmp(List objectList);

    public String addMessageEmp(Object obj);

    @SuppressWarnings({ "rawtypes" })
    public List getMyMessageList(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getMyMessageList(Object object, int currentPage, int pageSize);

    public int getMyMessageListCnt(Object object);

    @SuppressWarnings("rawtypes")
    public String addReadMessage(List objectList);

    public String deleteMessage(Object object);
}
