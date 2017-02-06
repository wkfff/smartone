package com.siping.cust.service.impl;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.mchange.v2.lang.ObjectUtils;
import com.siping.cust.dao.SupplierAccountSelfManagerDao;
import com.siping.cust.service.SupplierAccountSelfManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SupplierAccountSelfManagerSerImpl implements SupplierAccountSelfManagerSer {

    @Autowired
    private SupplierAccountSelfManagerDao supplierAccountSelfManagerDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addOrUpdateSupplierAccountSelf(HttpServletRequest request) {

        String returnString;

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        // 对密码的处理
        String password = paramMap.get("PASSWORD").toString();
        paramMap.put("PASSWORD", EncryptUtil.MD5Encode(password));

        // 判断用户名是否唯一

        if (paramMap.get("ADMINNO") != null && !"".equals(paramMap.get("ADMINNO"))) {

            returnString = this.supplierAccountSelfManagerDao.updateSupplierAccountSelf(paramMap);
        } else {
            returnString = this.checkUsernameExist(request);
            if (returnString == "Exist") {
                return returnString;
            }
            returnString = this.supplierAccountSelfManagerDao.addSupplierAccountSelf(paramMap);
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSupplierModelList(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        int page = Integer.parseInt(paramMap.get("page").toString());
        int pageSize = Integer.parseInt(paramMap.get("pagesize").toString());
        return this.supplierAccountSelfManagerDao.getSupplierAccountSelf(paramMap, page, pageSize);
    }

    @Override
    public String deleteSupplierAccountSelf(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString);
        return this.supplierAccountSelfManagerDao.deleteSupplierAccountSelf(delList);
    }

    @SuppressWarnings("unchecked")
    @Override
    public int getSupplierModelCnt(HttpServletRequest request) {
        @SuppressWarnings("rawtypes")
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.supplierAccountSelfManagerDao.getSupplierAccountSelfCnt(paramMap);
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
        return this.supplierAccountSelfManagerDao.checkUsernameExist(map);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getSupplierByPassword(HttpServletRequest request) {

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String password = (String) paramMap.get("OLDPASSWORD");
        paramMap.remove("OLDPASSWORD");
        paramMap.put("OLDPASSWORD", EncryptUtil.MD5Encode(password));
        return this.supplierAccountSelfManagerDao.getSupplierByPassword(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String updateSupplierPassword(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        String password = (String) paramMap.get("ENTERNEWPASSWORD");
        paramMap.remove("ENTERNEWPASSWORD");
        paramMap.put("ENTERNEWPASSWORD", EncryptUtil.MD5Encode(password));
        return this.supplierAccountSelfManagerDao.updateSupplierPassword(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String toggleSupplierActivity(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.supplierAccountSelfManagerDao.toggleSupplierActivity(paramMap);
    }

}
