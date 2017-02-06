package com.siping.hrm.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.EmpInfoDao;
import com.siping.hrm.dao.PositionMgtDao;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class EmpInfoSerImpl implements EmpInfoSer {
    Logger logger = Logger.getLogger(EmpInfoSerImpl.class);
    @Autowired
    private EmpInfoDao empInfoDao;
    
    @Autowired
    private PositionMgtDao positionMgtDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getEmpList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("admin", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        Map map = new HashMap();
        map.put("Rows", this.empInfoDao.getEmpList(paramMap));
        map.put("Total", this.empInfoDao.getEmpCnt(paramMap));
        return map;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object getBasicInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getBasicInfo(paramMap);
    }
    
    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object getEmailByEmpId(String empId) {
        return this.empInfoDao.getEmailByEmpId(empId);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateEmpInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.empInfoDao.updateDocInfo(paramMap);
        return this.empInfoDao.updateEmpInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object getPersonalInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        return this.empInfoDao.getPersonalInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPaEmpInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getPaEmpInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getPaEmpInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPaEmpInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getPaEmpInfoCnt(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getSinfoForGrid(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        String empid = request.getParameter("empid");
        if (empid == null || empid.equals("")) {
            empid = admin.getAdminID();
        }
        paramMap.put("EMPID", empid);

        return this.empInfoDao.getSinfoForGrid(paramMap, Integer.parseInt(request.getParameter("page").toString()), Integer.parseInt(request.getParameter("pagesize").toString()));
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getBizInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getBizInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getBizInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getBizInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getBizInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getHealthInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getHealthInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String updateHealthInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateHealthInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String addHealthInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addHealthInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteHealthInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteHealthInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getHealthInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getHealthInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getHealthInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getHealthInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getHealthInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addWorkExperienceInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addWorkExperienceInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteWorkExperienceInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteWorkExperienceInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateWorkExperienceInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateWorkExperienceInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getWorkExperienceInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        return this.empInfoDao.getWorkExperienceInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getWorkExperienceInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getWorkExperienceInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getWorkExperienceInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getWorkExperienceInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getWorkExperienceInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addEduInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addEduInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteEduInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteEduInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateEduInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateEduInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getEduInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getEduInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEduInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getEduInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getEduInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getEduInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getEduInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addDocInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addDocInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteDocInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteDocInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateDocInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateDocInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getDocInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        return this.empInfoDao.getDocInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDocInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getDocInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getDocInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getDocInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getDocInfoCnt(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getAppendInfoForGrid(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        String empid = request.getParameter("empid");
        if (empid == null || empid.equals("")) {
            empid = admin.getAdminID();
        }
        paramMap.put("EMPID", empid);

        return this.empInfoDao.getAppendInfoForGrid(paramMap, Integer.parseInt(request.getParameter("page").toString()), Integer.parseInt(request.getParameter("pagesize").toString()));
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addITLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addITLevelInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteITLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteITLevelInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateITLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateITLevelInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getITLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getITLevelInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getITLevelInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getITLevelInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getITLevelInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getITLevelInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getITLevelInfoCnt(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getEvalForGrid(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        String empid = request.getParameter("empid");
        if (empid == null || empid.equals("")) {
            empid = admin.getAdminID();
        }
        paramMap.put("EMPID", empid);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getEvalForGrid(paramMap, Integer.parseInt(request.getParameter("page").toString()), Integer.parseInt(request.getParameter("pagesize").toString()));
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getEvaluateForGrid(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        String empid = request.getParameter("empid");
        if (empid == null || empid.equals("")) {
            empid = admin.getAdminID();
        }
        paramMap.put("EMPID", empid);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getEvaluateForGrid(paramMap, Integer.parseInt(request.getParameter("page").toString()), Integer.parseInt(request.getParameter("pagesize").toString()));
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getExpInsideInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getExpInsideInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getExpInsideInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getExpInsideInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getExpInsideInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getResignInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getResignInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getResignInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getResignInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getResignInfoCnt(paramMap);
    }

    /**
     * 添加家庭成员信息
     */
    @Override
    public String addFamilyInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("EMPID", StringUtil.checkNull(request.getParameter("EMPID"), admin.getAdminID()));
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);

        return this.empInfoDao.addFamilyInfo(insertList);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteFamilyInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteFamilyInfo(paramMap);
    }

    /**
     * 修改家庭成员信息
     */
    @Override
    public String updateFamilyInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);

        return this.empInfoDao.updateFamilyInfo(updateList);
    }

    /**
     * 添加家庭成员信息
     */
    @Override
    public String addEmpPaInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("EMPID", StringUtil.checkNull(request.getParameter("EMPID"), admin.getAdminID()));

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
        return this.empInfoDao.addEmpPaInfo(insertList);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteEmpPaInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.deleteEmpPaInfo(paramMap);
    }

    /**
     * 修改家庭成员信息
     */
    @Override
    public String updateEmpPaInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        return this.empInfoDao.updateEmpPaInfo(updateList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getFamilyInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getFamilyInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getFamilyInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getFamilyInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getFamilyInfoCnt(paramMap);
    }

    /**
     * 添加紧急联系人信息
     */
    @Override
    public String addEmergencyContactInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("EMPID", StringUtil.checkNull(request.getParameter("EMPID"), admin.getAdminID()));

        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);

        return this.empInfoDao.addEmergencyContactInfo(insertList);
    }

    /**
     * 修改紧急联系人信息
     */
    @Override
    public String updateEmergencyContactInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);

        return this.empInfoDao.updateEmergencyContactInfo(updateList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmergencyContactInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getEmergencyContactInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getEmergencyContactInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getEmergencyContactInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getEmergencyContactInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPunishMentInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getPunishMentInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getPunishMentInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPunishMentInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getPunishMentInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getRewardInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getRewardInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getRewardInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getRewardInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getRewardInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addTrainingInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addTrainingInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteTrainingInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        return this.empInfoDao.deleteTrainingInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateTrainingInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateTrainingInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getTrainingInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        return this.empInfoDao.getTrainingInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getTrainingInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getTrainingInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getTrainingInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getTrainingInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getTrainingInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addQualificationInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addQualificationInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteQualificationInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        return this.empInfoDao.deleteQualificationInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateQualificationInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateQualificationInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getQualificationInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getQualificationInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getQualificationInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getQualificationInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getQualificationInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getQualificationInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getQualificationInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addLanuageInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.addLanuageInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String deleteLanuageInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());

        return this.empInfoDao.deleteLanuageInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateLanuageInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.updateLanuageInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getLanuageInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getLanuageInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getLanuageInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getLanuageInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getLanuageInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getLanuageInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getLanuageInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDispatchInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getDispatchInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getDispatchInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getDispatchInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getDispatchInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPluralityInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getPluralityInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getPluralityInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPluralityInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.empInfoDao.getPluralityInfoCnt(paramMap);
    }

    // @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getSuspendForGrid(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        String empid = request.getParameter("empid");
        if (empid == null || empid.equals("")) {
            empid = admin.getAdminID();
        }
        paramMap.put("EMPID", empid);

        return this.empInfoDao.getSuspendForGrid(paramMap, Integer.parseInt(request.getParameter("page").toString()), Integer.parseInt(request.getParameter("pagesize").toString()));
    }

    // @Override
    public String updateFappendInfoGrid(List<LinkedHashMap<String, Object>> list) throws Exception {
        return updateFappendInfoGrid(list, null);
    }

    // @Override
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public String updateFappendInfoGrid(List<LinkedHashMap<String, Object>> list, HttpServletRequest request) throws Exception {
        String updateBy = null;
        if (request != null) {
            updateBy = request.getParameter("updateBy");
        }
        for (Map data : list) {
            data.put("updateBy", updateBy);
            data.put("registerID", updateBy);
            if ("add".equals(data.get("__status"))) {
                this.empInfoDao.addFappendInfo(data);
            } else if ("update".equals(data.get("__status"))) {
                this.empInfoDao.updateFappendInfo(data);
            } else if ("delete".equals(data.get("__status"))) {
                this.empInfoDao.deleteFappendInfo(data);
            }
        }
        return null;
    }

    // @Override
    @SuppressWarnings({ "rawtypes" })
    public String updateQualificationInfoGrid(List<LinkedHashMap<String, Object>> list) throws Exception {
        for (Map data : list) {
            if ("add".equals(data.get("__status"))) {
                this.empInfoDao.addQualificationInfo(data);
            } else if ("update".equals(data.get("__status"))) {
                this.empInfoDao.updateQualificationInfo(data);
            } else if ("delete".equals(data.get("__status"))) {
                this.empInfoDao.deleteQualificationInfo(data);
            }
        }
        return null;
    }

    /**
     * 获取信息
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public Map getRequestParamData(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        return paramMap;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List getHrSearchEmployeeList(HttpServletRequest request) {
        List retrunList = new ArrayList();

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").toString().equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.empInfoDao.getHrSearchEmployeeList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.empInfoDao.getHrSearchEmployeeList(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public int getHrSearchEmployeeCnt(HttpServletRequest request) {
        int retrunInt = 0;

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("CPNY_ID") == null || paramMap.get("CPNY_ID").toString().equals("")) {
            paramMap.put("CPNY_ID", admin.getCpnyId());
        }
        retrunInt = this.empInfoDao.getHrSearchEmployeeCnt(paramMap);

        return retrunInt;
    }

    @Override
    public String deleteEmpInfo(HttpServletRequest request) {
        String result = "";
        // 页面参数
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> arDetailInfoList = ObjectBindUtil.getRequestJsonData(jsonString);
        this.empInfoDao.deleteEmpInfo(arDetailInfoList);
        result = "Y";
        return result;
    }
    
    
}
