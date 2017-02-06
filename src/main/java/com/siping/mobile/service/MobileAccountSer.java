package com.siping.mobile.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


public interface MobileAccountSer {
    public String updatePassword(HttpServletRequest request) throws Exception;

    @SuppressWarnings("rawtypes")
    public Map getCustomer(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getReciverList(HttpServletRequest request);

    public int getReciverCnt(HttpServletRequest request) ;

    @SuppressWarnings("rawtypes")
    public List getSelectList(HttpServletRequest request);

    public String updateCustInfo(HttpServletRequest request) throws Exception;

    public String insertReceiver(HttpServletRequest request) throws Exception;

    @SuppressWarnings("rawtypes")
    public Map getReceiver(HttpServletRequest request);

    public String updateReceiver(HttpServletRequest request) throws Exception;

    public String deleteReceiver(HttpServletRequest request) throws Exception;
}
