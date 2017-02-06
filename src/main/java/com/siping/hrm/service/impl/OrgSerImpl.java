package com.siping.hrm.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.OrgDao;
import com.siping.hrm.service.OrgSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class OrgSerImpl implements OrgSer {
    Logger logger = Logger.getLogger(OrgSerImpl.class);

    @Autowired
    private OrgDao orgDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDeptInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        List retrunList = new ArrayList();

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.orgDao.getDeptInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.orgDao.getDeptInfo(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getDeptInfoObj(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }

        return this.orgDao.getDeptInfoObj(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getDeptInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }

        return this.orgDao.getDeptInfoCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String updateDeptInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if(paramMap.get("DATE_CREATED") == null ||paramMap.get("DATE_CREATED") == ""){
        	paramMap.put("DATE_CREATED", null);
        }
        if(paramMap.get("DATE_ENDED") == null ||paramMap.get("DATE_ENDED") == ""){
        	paramMap.put("DATE_ENDED", null);
        }
        return this.orgDao.updateDeptInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addDeptInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if(paramMap.get("DATE_CREATED") == null ||paramMap.get("DATE_CREATED") == ""){
        	paramMap.put("DATE_CREATED", null);
        }
        if(paramMap.get("DATE_ENDED") == null ||paramMap.get("DATE_ENDED") == ""){
        	paramMap.put("DATE_ENDED", null);
        }
        return this.orgDao.addDeptInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteDeptInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.orgDao.deleteDeptInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDeptInfoTree(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return orgDao.getDeptInfoTree(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getDeptLevel(Map param) {
        List list = new ArrayList();
        list = orgDao.getDeptLevel(param);
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getDeptQuotaList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        List returnList = new ArrayList();

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            returnList = this.orgDao.getDeptQuotaList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            returnList = this.orgDao.getDeptQuotaList(paramMap);
        }

        return returnList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getDeptQuotaListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }

        return this.orgDao.getDeptQuotaListCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteDeptQuotaInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.orgDao.deleteDeptQuotaInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addDeptQuotaInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        int num = 0;
        num = this.getPostIdCnt(request);
        // System.out.println(num);
        if (num < 1) {
            // 页面提交数据
            return this.orgDao.addDeptQuotaInfo(paramMap);
        } else {
            return this.orgDao.updateDeptQuotaInfo(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private int getPostIdCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }

        return this.orgDao.getPostIdCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateDeptQuotaInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        // 页面提交数据
        paramMap.put("UPDATED_BY", admin.getAdminID());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", paramMap);

        return this.orgDao.updateDeptQuotaInfo(updateList);
    }

    @SuppressWarnings("unchecked")
    @Override
    public String massTransferEmployees(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap<String, Object> appendMap = ObjectBindUtil.getRequestParamData(request);
        appendMap.put("UPDATED_BY", admin.getAdminID());
        if (appendMap.get("CPNY_ID") == null || appendMap.get("CPNY_ID").equals("")) {
            appendMap.put("CPNY_ID", admin.getCpnyId());
        }

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        return this.orgDao.massTransferEmployees(updateList);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int checkDeptChildren(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.orgDao.checkDeptChildren(paramMap);
    }
}
