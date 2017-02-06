package com.siping.cust.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.cust.bean.Receiver;

public interface CustReceiverSer {

    public String addReceiver(HttpServletRequest request, Receiver receiver) throws SQLException;

    public String updateReceiver(HttpServletRequest request, Receiver receiver) throws SQLException;

    public String deleteReceiver(HttpServletRequest request, String receiverId) throws SQLException;

    public int getReceiverCnt(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getReceiverList(HttpServletRequest request);

    public Object getReceiver(HttpServletRequest request);
}
