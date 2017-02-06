package com.siping.cust.service.impl;

import com.siping.cust.bean.Customer;
import com.siping.cust.dao.CustInfoDao;
import com.siping.cust.service.*;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CustInfoSerImpl implements CustInfoSer {
    Logger logger = Logger.getLogger(CustInfoSer.class);
    @Autowired
    private CustInfoDao custInfoDao;

    @Autowired
    private SalesSettingSer salesSettingSer;

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public List getCustomerList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("EMP_ID", admin.getAdminID());
        paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));

        return getCustomerListAccordingToPaging(paramMap);
    }

    private List getCustomerListAccordingToPaging(Map paramMap) {
        if (isPagingOn(paramMap)){
            return this.custInfoDao.getCustomerList(paramMap, Integer.parseInt(paramMap.get("page").toString()),
                    Integer.parseInt(paramMap.get("pagesize").toString()));
        } else {
            return this.custInfoDao.getCustomerList(paramMap);
        }
    }

    private boolean isPagingOn(Map paramMap) {
        return paramMap.get("page") != null || paramMap.get("pagesize") != null;
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public int getCustomerListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("EMP_ID", admin.getAdminID());
        paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        return this.custInfoDao.getCustomerListCnt(paramMap);
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @Override
    public Object getCustomerDetail(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("CUST_ID") == null) {
            return null;
        }
        return this.custInfoDao.getCustomerDetail(paramMap);
    }

    @Override
    public List getAllCustomerList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("EMP_ID", admin.getAdminID());
        return getAllCustomersListAccordingToPaging(paramMap);
    }

    @Override
    public List<Customer> getAllCustomerListUsingBeanMap(HttpServletRequest request) {
        AdminBean adminBean = SessionUtil.getLoginUserFromSession(request);
        return this.custInfoDao.getAllCustomerListUsingBeanMap(adminBean);
    }

    private List getAllCustomersListAccordingToPaging(Map paramMap) {
        if (isPagingOn(paramMap)) {
            return this.custInfoDao.getAllCustomerList(paramMap, Integer.parseInt(paramMap.get("page").toString()),
                    Integer.parseInt(paramMap.get("pagesize").toString()));
        } else {
            return this.custInfoDao.getAllCustomerList(paramMap);
        }
    }
}
