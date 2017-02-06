package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.List;

import com.siping.cust.bean.Receiver;

public interface CustReceiverDao {

    public List<Receiver> getReceiverList(Object object, int page, int pagesize);

    public int getReceiverListCnt(Object object);

    public Object getReceiver(Object object);

    public Object addReceiver(Object object) throws SQLException;//一般添加

    public Object addReceiverByWizard(Object object) throws SQLException;//通过向导方式添加

    public Object updateReceiver(Object object) throws SQLException;

    public Object deleteReceiver(Object object) throws SQLException;

}
