package com.siping.cust.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.cust.bean.Receiver;
import com.siping.cust.dao.CustReceiverDao;
import com.siping.cust.service.CustReceiverSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CustReseiverSerImpl implements CustReceiverSer {

    @Autowired
    private CustReceiverDao custReceiverDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addReceiver(HttpServletRequest request, Receiver receiver) throws SQLException {
        String returnString;
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("admin", SessionUtil.getLoginUserFromSession(request));
        param.put("receiver", receiver);
        returnString = (String) this.custReceiverDao.addReceiver(param);
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String updateReceiver(HttpServletRequest request, Receiver receiver) throws SQLException {
        String returnString;
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("admin", SessionUtil.getLoginUserFromSession(request));
        param.put("receiver", receiver);
        returnString = this.custReceiverDao.updateReceiver(param).toString();
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deleteReceiver(HttpServletRequest request, String receiverId) throws SQLException {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        paramMap.put("receiverId", receiverId);
        return this.custReceiverDao.deleteReceiver(paramMap).toString();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getReceiverCnt(HttpServletRequest request) {
        int i;
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        i = this.custReceiverDao.getReceiverListCnt(paramMap);
        return i;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getReceiverList(HttpServletRequest request) {
        List list = new ArrayList();
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        list = this.custReceiverDao.getReceiverList(param, NumberUtils.parseNumber(ObjectUtils.toString(param.get("page")), Integer.class),
            NumberUtils.parseNumber(ObjectUtils.toString(param.get("pagesize")), Integer.class));
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Object getReceiver(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.custReceiverDao.getReceiver(paramMap);
    }
}
