package com.siping.cust.dao;

import java.sql.SQLException;
import java.util.List;

import com.siping.cust.bean.Contact;

public interface CustContactDao {

    public List<Contact> getCustContactList(Object object, int page, int pagesize);

    public int getCustContactsListCnt(Object object);

    public Object getCustContacts(Object object);

    public Object addCustContact(Object object) throws SQLException;//一般添加

    public Object addCustContactByWizard(Object object) throws SQLException;//通过向导添加

    public Object updateCustContact(Object object) throws SQLException;

    public Object deleteCustContact(Object object) throws SQLException;

}
