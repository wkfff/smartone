package com.siping.mobile.dao;

import java.util.List;
import java.util.Map;

public interface MobileAccountDao {
    @SuppressWarnings("rawtypes")
    public Map getAccountType(Object object);

    public String updatePassword(Object object) throws Exception;

    @SuppressWarnings("rawtypes")
    public Map getCustomer(Object object);

    @SuppressWarnings("rawtypes")
    public List getReciverList(Object object);

    public int getReciverCnt(Object object);

    @SuppressWarnings("rawtypes")
    public List getSelectList(Object object);

    public String updateCustInfo(Object object) throws Exception;

    public String insertReceiver(Object object) throws Exception;

    @SuppressWarnings("rawtypes")
    public Map getReceiver(Object object);

    public String updateReceiver(Object object) throws Exception;

    public String deleteReceiver(Object object) throws Exception;
}
