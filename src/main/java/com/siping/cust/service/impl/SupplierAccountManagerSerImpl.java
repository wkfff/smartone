package com.siping.cust.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.cust.dao.SupplierAccountManagerDao;
import com.siping.cust.service.SupplierAccountManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SupplierAccountManagerSerImpl implements SupplierAccountManagerSer {

    @Autowired
    private SupplierAccountManagerDao supplierAccountManagerDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addOrUpdateSupplierAccount(HttpServletRequest request) {

        String returnString;

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        paramMap.put("language", Messages.getLanguage(request));

        // 对密码的处理
        String password = paramMap.get("PASSWORD").toString();
        paramMap.put("PASSWORD", EncryptUtil.MD5Encode(password));

        if (paramMap.get("ADMINNO") != null && !"".equals(paramMap.get("ADMINNO"))) {

            returnString = this.supplierAccountManagerDao.updateSupplierAccount(paramMap);
        } else {
            // 判断用户名是否唯一

            returnString = this.checkUsernameExist(request);
            if (returnString == "Exist") {
                return returnString;
            }

            returnString = this.supplierAccountManagerDao.addSupplierAccount(paramMap);
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierModelList(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        int page = Integer.parseInt(paramMap.get("page").toString());
        int pageSize = Integer.parseInt(paramMap.get("pagesize").toString());
        return this.supplierAccountManagerDao.findSupplierAccount(paramMap, page, pageSize);
    }

    @Override
    public String deleteSupplierAccount(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString);
        return this.supplierAccountManagerDao.deleteSupplierAccount(delList);
    }

    @Override
    public int getSupplierModelCnt(HttpServletRequest request) {
        @SuppressWarnings("rawtypes")
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        return this.supplierAccountManagerDao.getSupplierAccountCnt(paramMap);
    }

    // 判断用户名是否存在
    @SuppressWarnings("unchecked")
    @Override
    public String checkUsernameExist(HttpServletRequest request) {

        @SuppressWarnings("rawtypes")
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String username = paramMap.get("USERNAME").toString();
        @SuppressWarnings("rawtypes")
        LinkedHashMap map = new LinkedHashMap();
        map.put("USERNAME", username);
        return this.supplierAccountManagerDao.checkUsernameExist(map);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getSupplierByPassword(HttpServletRequest request) {

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String password = (String) paramMap.get("OLDPASSWORD");
        paramMap.remove("OLDPASSWORD");
        paramMap.put("OLDPASSWORD", EncryptUtil.MD5Encode(password));
        return this.supplierAccountManagerDao.getSupplierByPassword(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String updateSupplierPassword(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String password = (String) paramMap.get("ENTERNEWPASSWORD");
        paramMap.remove("ENTERNEWPASSWORD");
        paramMap.put("ENTERNEWPASSWORD", EncryptUtil.MD5Encode(password));
        return this.supplierAccountManagerDao.updateSupplierPassword(paramMap);
    }

    @Override
    public String toggleSupplierActivity(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        return this.supplierAccountManagerDao.toggleSupplierActivity(paramMap);
    }

}
