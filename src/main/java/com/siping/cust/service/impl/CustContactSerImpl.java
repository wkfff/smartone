package com.siping.cust.service.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.cust.bean.Contact;
import com.siping.cust.dao.CustContactDao;
import com.siping.cust.service.CustContactSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class CustContactSerImpl implements CustContactSer {

    @Autowired
    private CustContactDao custContactDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addContact(HttpServletRequest request, Contact contact) throws SQLException {
        String returnString;
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("admin", SessionUtil.getLoginUserFromSession(request));
        param.put("contact", contact);
        returnString = (String) this.custContactDao.addCustContact(param);
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateContact(HttpServletRequest request, Contact contact) throws SQLException {
        String returnString;
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("admin", SessionUtil.getLoginUserFromSession(request));
        param.put("contact", contact);
        returnString = this.custContactDao.updateCustContact(param).toString();
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deleteContact(HttpServletRequest request, String contactId) throws SQLException {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("contactId", contactId);
        paramMap.put("admin", SessionUtil.getLoginUserFromSession(request));
        return this.custContactDao.deleteCustContact(paramMap).toString();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getContactCnt(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        int i = this.custContactDao.getCustContactsListCnt(paramMap);
        return i;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getContactList(HttpServletRequest request) {
        LinkedHashMap param = ObjectBindUtil.getRequestParamData(request);
        param.put("language", Messages.getLanguage(request));
        List list;
        if(param.get("page")!=null)
        {
             list = this.custContactDao.getCustContactList(param, NumberUtils.parseNumber(ObjectUtils.toString(param.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(param.get("pagesize")), Integer.class));           
        }else {
             list = (List) this.custContactDao.getCustContacts(param);
        }

        return list;
    }
}
