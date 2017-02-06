package com.siping.cust.action;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siping.cust.bean.Contact;
import com.siping.cust.service.CustContactSer;
import com.siping.web.bean.ReturnResult;

@Controller
@RequestMapping("/cust/custManager")
public class CustContactCtroller {

    @Autowired
    private CustContactSer custContactSer;

    @RequestMapping("/addOrUpdateCustContact")
    @ResponseBody
    public ReturnResult addOrUpdateCustContact(HttpServletRequest request, @RequestBody Contact contact) {
        ReturnResult returnResult = new ReturnResult();
        if (contact.getContactId() == null || contact.getContactId() == ""){
            try {
                returnResult.setCode(0);
                returnResult.setMessage(this.custContactSer.addContact(request, contact));
            } catch (SQLException e) {
                returnResult.setCode(-1);
                returnResult.setMessage(e.getMessage());
            }
        } else {
            try {
                returnResult.setCode(0);
                returnResult.setMessage(this.custContactSer.updateContact(request, contact));
            } catch (SQLException e) {
                returnResult.setCode(-2);
                returnResult.setMessage(e.getMessage());
            }
        }
        return returnResult;
    }

    @RequestMapping("/deleteContact")
    @ResponseBody
    public ReturnResult deleteContact(HttpServletRequest request,@RequestParam(value="contactId", required =true) String contactId) {
        ReturnResult returnResult = new ReturnResult();
        try{
            returnResult.setCode(0);
            returnResult.setMessage(this.custContactSer.deleteContact(request, contactId));
        }catch(SQLException e){
            returnResult.setCode(-1);
            returnResult.setMessage(e.getMessage());
        }
        return returnResult;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @ResponseBody
    @RequestMapping("/getContactList")
    public Map getContactList(HttpServletRequest request) {
        List list = this.custContactSer.getContactList(request);
        int total = this.custContactSer.getContactCnt(request);
        Map map = new HashMap();
        map.put("Rows", list);
        map.put("Total", total);
        return map;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @ResponseBody
    @RequestMapping("getCustContactByCustId")
    public List<Contact> getCustContactByCustId(HttpServletRequest request) throws SQLException
    {
        List contactList=this.custContactSer.getContactList(request);
        return contactList;
    }
}
