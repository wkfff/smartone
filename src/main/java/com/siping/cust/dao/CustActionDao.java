package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.List;

import com.siping.cust.bean.Action;

public interface CustActionDao {

    @SuppressWarnings("rawtypes")
    List getCustomerActionList(Object obj);
    int getCustomerActionListCnt(Object obj);
    @SuppressWarnings("rawtypes")
    List getSimpleCustomerActionList(Object obj);
    int getSimpleCustomerActionListCnt(Object obj);
    
    @SuppressWarnings("rawtypes")
    void addCustomerAction(List obj) throws SQLException;
    void addCustomerAction(Object obj) throws SQLException;
    
    void removeCustomerAction(Object obj) throws SQLException;

    @SuppressWarnings("rawtypes")
    void updateCustomerAction(List obj) throws SQLException;
    
    void saveAction(Action action) throws SQLException; 
    List<Action> getActionByCustId(Object object)throws SQLException; 
    int getCountByCustId(Object object )  throws SQLException; 
    void updateAction(Action action) throws SQLException;
    void deleteAction(String custActionNo) throws SQLException;
    void changeActionState(Action action)  throws SQLException;
    List<Action> getCustActionByCondition(Object object) throws SQLException;
    Action getActionById(int custActionNo) throws SQLException;

}
