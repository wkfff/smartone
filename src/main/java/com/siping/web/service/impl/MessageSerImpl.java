package com.siping.web.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.system.bean.AdminBean;
import com.siping.web.bean.Message;
import com.siping.web.dao.MessageDao;
import com.siping.web.service.MessageSer;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

@Service
public class MessageSerImpl implements MessageSer {
    Logger logger = Logger.getLogger(MessageSerImpl.class);
    @Autowired
    private MessageDao messageDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String sendMessageInfo(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("MESSAGE_NO", "");

        messageDao.addMessageInfo(paramMap);
        /*
         * if("DEPTID".equals(paramMap.get("MESSAGE_TYPE"))||"SCREEN_GRANT_ID".
         * equals(paramMap.get("MESSAGE_TYPE"))){
         * messageDao.addMessageEmp(paramMap); }
         */

        String jsonString = request.getParameter("jsonData");
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("MESSAGE_NO", paramMap.get("MESSAGE_NO"));
        appendMap.put("MESSAGE_TYPE", paramMap.get("MESSAGE_TYPE"));

        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        // 去重，去自身
        for (int i = 0; i < insertList.size() - 1; i++) {
            if (admin.getAdminID().equals(insertList.get(i).get("EMPID").toString())) {
                insertList.remove(i);
                continue;
            }
            for (int j = insertList.size() - 1; j > i; j--) {
                if (insertList.get(j).equals(insertList.get(i))) {
                    insertList.remove(j);
                }
            }
        }

        messageDao.addMessageEmp(insertList);

        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Message> getMessageList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("OWNER") != null) {
            paramMap.put("OWNER", admin.getAdminID());
        }

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.messageDao.getMessageList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.messageDao.getMessageList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getMessageListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("OWNER") != null) {
            paramMap.put("OWNER", admin.getAdminID());
        }

        return this.messageDao.getMessageListCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Message> getMyMessageList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("EMPID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.messageDao.getMyMessageList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.messageDao.getMyMessageList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getMyMessageListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if(admin != null){
        	paramMap.put("EMPID", admin.getAdminID());
        	paramMap.put("CPNY_ID", admin.getCpnyId());
        }else{
        	paramMap.put("EMPID", "");
        	paramMap.put("CPNY_ID", "");
        }

        return this.messageDao.getMyMessageListCnt(paramMap);
    }

    @Override
    public String addReadMessage(HttpServletRequest request) {
        String returnString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String jsonString = request.getParameter("jsonData");
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("EMPID", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        this.messageDao.addReadMessage(insertList);

        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteMessage(HttpServletRequest request) {
        String result = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.messageDao.deleteMessage(paramMap);

        return result;
    }
}
