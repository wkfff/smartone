package com.siping.productStorage.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

import com.siping.productStorage.bean.SalesMode;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import com.siping.productStorage.dao.SalesModelDao;
import com.siping.productStorage.service.SalesModelSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;


@Service
public class SalesModelSerImpl implements SalesModelSer {
    Logger logger = Logger.getLogger(SalesModelSerImpl.class);
    @Autowired
    private SalesModelDao salesModeDao;

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public List getSalesModelList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.salesModeDao.getSalesModelList(paramMap, NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("page")), Integer.class), NumberUtils.parseNumber(
                    ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.salesModeDao.getSalesModelList(paramMap);
        }
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public int getSalesModelListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.salesModeDao.getSalesModelListCnt(paramMap);
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @Override
    public String addOrUpdateSalesModel(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        List<Map> list = this.salesModeDao.getSalesModelList(paramMap);
        if (list.size() > 0) {
            if (list.size() == 1 && (paramMap.get("SALES_MODE_NAME").toString()).equals(list.get(0).get("SALES_MODE_NAME").toString())
                    && paramMap.get("SALES_MODE_NO") != null && (list.get(0).get("SALES_MODE_NO").toString()).equals(paramMap.get("SALES_MODE_NO").toString())) {
                returnString = this.salesModeDao.updateSalesModel(paramMap);
            } else {
                returnString = "该销售方式已存在";
            }
        } else {
            if (paramMap.get("SALES_MODE_NO") != null && !"".equals(paramMap.get("SALES_MODE_NO"))) {
                returnString = this.salesModeDao.updateSalesModel(paramMap);
            } else {
                returnString = this.salesModeDao.addSalesModel(paramMap);
            }
        }

        return returnString;
    }

    @Override
    public String deleteSalesModel(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        for(LinkedHashMap<String, Object> map : delList){
            if(map.get("SALES_MODE_NO")!=null&&map.get("SALES_MODE_NO").toString().equals("0")){
                return "默认销售方式不能删除！";
            }
        }
        return this.salesModeDao.deleteSalesModel(delList);
    }

    @SuppressWarnings({"rawtypes", "unchecked"})
    @Override
    public int checkSalesDistri(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        Map paramMap = null;
        int temp = 0;
        for (int i = 0; i < delList.size(); i++) {
            paramMap = delList.get(i);
            paramMap.put("CPNY_ID", admin.getCpnyId());
            temp += this.salesModeDao.checkSalesDistri(paramMap);
        }

        return temp;
    }

    @Override
    public List<SalesMode> getAllSalesModes() {
        return this.salesModeDao.getAllSalesModes();
    }

    @SuppressWarnings({"unchecked", "rawtypes"})
    @Override
    public String updateSalesMobileStatus(HttpServletRequest request) {
        String returnString = "Y";
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        returnString = this.salesModeDao.updateSalesMobileStatus(paramMap);
        return returnString;
    }
}
