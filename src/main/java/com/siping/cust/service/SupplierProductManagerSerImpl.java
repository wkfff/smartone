package com.siping.cust.service;

import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.testng.log4testng.Logger;

import com.siping.cust.dao.SupplierProductManagerDao;
import com.siping.cust.service.SupplierProductManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class SupplierProductManagerSerImpl implements SupplierProductManagerSer {

    Logger logger = Logger.getLogger(SupplierProductManagerSerImpl.class);

    @Autowired
    private SupplierProductManagerDao supplierProductMangerDao;

    @SuppressWarnings("unchecked")
    @Override
    public String addOrUpdateProduct(HttpServletRequest request) {
        String returnString;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        @SuppressWarnings("rawtypes")
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("PRODUCT_NO") != null && !("".equals(paramMap.get("PRODUCT_NO")))) {
            returnString = this.supplierProductMangerDao.updateSupplierProduct(paramMap);
        } else {
            int reCnt = this.checkSupplierProIdCnt(request);
            if(reCnt > 0){
                returnString = "商品编号已存在";
            }else{
                returnString = this.supplierProductMangerDao.addProduct(paramMap);
            }
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSupplierProductList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        int page = Integer.parseInt(paramMap.get("page").toString());
        int pageSize = Integer.parseInt(paramMap.get("pagesize").toString());
        return this.supplierProductMangerDao.getSupplierProductList(paramMap, page, pageSize);
    }

    @Override
    public String deleteSupplierProduct(HttpServletRequest request) {
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString);
        return this.supplierProductMangerDao.deleteSupplierProduct(delList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getSupplierProductCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.supplierProductMangerDao.getSupplierProductCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int checkSupplierProIdCnt(HttpServletRequest request) {
        int reCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        reCnt = this.supplierProductMangerDao.checkSupplierProIdCnt(paramMap);
        
        return reCnt;
    }

}
