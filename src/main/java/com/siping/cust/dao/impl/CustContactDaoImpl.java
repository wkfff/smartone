package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.cust.bean.Contact;
import com.siping.cust.dao.CustContactDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CustContactDaoImpl extends SqlMapClientSupport implements
        CustContactDao {
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<Contact> getCustContactList(Object object, int page,
            int pagesize) {
        List<Contact> list = new ArrayList();
        try {
            list = this.queryForList("cust.custContact.getContactList", object,
                    page, pagesize);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return list;
    }

    @Override
    public int getCustContactsListCnt(Object object) {
        int i = 0;
        try {
            i = (Integer) this.queryForObject("cust.custContact.getContactCnt",
                    object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return i;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Object getCustContacts(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("cust.custContact.getContactList", object);
        } catch (SQLException e) {
            logger.error(e.getMessage());
        }
        return list;
    }

    @Override
    public Object addCustContact(Object object) throws SQLException {
        return this.insert("cust.custContact.addContact", object);
    }

    @Override
    public Object updateCustContact(Object object) throws SQLException {
        return this.update("cust.custContact.updateContact", object);
    }

    @Override
    public Object deleteCustContact(Object object) throws SQLException {
        return this.delete("cust.custContact.deleteContact", object);
    }

    @Override
    public Object addCustContactByWizard(Object object) throws SQLException {
        return this.insert("cust.custContact.addContactByWizard", object);
    }
}
