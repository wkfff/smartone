package com.siping.cust.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.siping.cust.bean.Contact;

public interface CustContactSer {
    public String addContact(HttpServletRequest request, Contact contact) throws SQLException;

    public String updateContact(HttpServletRequest request, Contact contact) throws SQLException;

    public String deleteContact(HttpServletRequest request, String contactId) throws SQLException;

    public int getContactCnt(HttpServletRequest request);

    @SuppressWarnings("rawtypes")
    public List getContactList(HttpServletRequest request);
}
