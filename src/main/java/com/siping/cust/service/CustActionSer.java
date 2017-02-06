package com.siping.cust.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.cust.bean.Action;
public interface CustActionSer {
    @SuppressWarnings({ "rawtypes" })
    public List getCustomerActionList(HttpServletRequest request);
    public int getCustomerActionListCnt(HttpServletRequest request);
    public void transferCustomerAction(HttpServletRequest request) throws SQLException;
    public void addCustomerAction(HttpServletRequest request) throws SQLException;
    public String removeCustomerAction(HttpServletRequest request) throws SQLException;
    public void saveAction(Action action) throws SQLException;
    public List<Action> getActionByCustId(HttpServletRequest request)throws SQLException;
    public int getCountByCustId(HttpServletRequest request) throws SQLException;
    public void updateActon(Action action) throws SQLException;
    public void deleteAction(String custActionNo) throws SQLException;
    public void changeActionState(HttpServletRequest request) throws SQLException;
    List<Action> getCustActionByCondition(HttpServletRequest request) throws SQLException, ParseException;
    public Action getActionById(HttpServletRequest request) throws SQLException;
}
