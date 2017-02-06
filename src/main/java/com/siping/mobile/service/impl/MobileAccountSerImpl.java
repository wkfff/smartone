package com.siping.mobile.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.mobile.dao.MobileAccountDao;
import com.siping.mobile.service.MobileAccountSer;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.LoginDao;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class MobileAccountSerImpl implements MobileAccountSer {
    Logger logger = Logger.getLogger(MobileAccountSerImpl.class);
    @Autowired
    private MobileAccountDao mobileAccountDao;
    @Autowired
    private LoginDao loginDao;
    
    /**
     * 普通员工修改密码
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updatePassword(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String oldPassword = request.getParameter("OLD_PASSWORD");
        paramMap.put("password", EncryptUtil.MD5Encode(oldPassword));
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("username", admin.getUsername());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        AdminBean user = (AdminBean) loginDao.findUser(paramMap);
        if (user == null) {
            return "WRONG_OLD_PASSWORD";
        }else{
            paramMap.put("ADMINID", admin.getAdminID());
            String newPassword = request.getParameter("NEW_PASSWORD");
            paramMap.put("UPDATE_PASSWORD", EncryptUtil.MD5Encode(newPassword));
            
            this.mobileAccountDao.updatePassword(paramMap);
           
            return "UPDATE_PASSWORD_SUCCESS";   
        }
    }

    //获取cust详细信息
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getCustomer(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CUST_ID",admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.getCustomer(paramMap);
    }

    //依据cust_id获取收货信息
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getReciverList(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CUST_ID",admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.getReciverList(paramMap);
    }

    //依据cust_id获取收货信息条数
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getReciverCnt(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CUST_ID",admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.getReciverCnt(paramMap);
    }

    //依据parent_code从sy_code中获取城市或地区list
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getSelectList(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        
        return this.mobileAccountDao.getSelectList(paramMap);
    }

    //客戶修改企業相關信息
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateCustInfo(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CUST_ID",admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.updateCustInfo(paramMap);
    }

    //客戶添加收貨人
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String insertReceiver(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getAllRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CUST_ID",admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.insertReceiver(paramMap);
    }

    //依据Receiver_id获取收货人信息
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getReceiver(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getAllRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.getReceiver(paramMap);
    }

    //修改收货人
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String updateReceiver(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.updateReceiver(paramMap);
    }

    //删除收货人
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deleteReceiver(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        
        return this.mobileAccountDao.deleteReceiver(paramMap);
    }
}
