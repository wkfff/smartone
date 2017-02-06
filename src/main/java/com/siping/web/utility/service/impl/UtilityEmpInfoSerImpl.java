package com.siping.web.utility.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.siping.productStorage.bean.Employee;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityEmpInfoDao;
import com.siping.web.utility.dao.UtilityOtherInfoDao;
import com.siping.web.utility.service.UtilityEmpInfoSer;

@Service
public class UtilityEmpInfoSerImpl implements UtilityEmpInfoSer {

    Logger logger = Logger.getLogger(UtilityEmpInfoSerImpl.class);

    @Autowired
    private UtilityEmpInfoDao utilityEmpInfoDao;

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getEmpBasicInfo(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Map getEmpBasicInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        if (paramMap == null || paramMap.get("EMPID") == null || paramMap.get("EMPID").toString().equals("")) {
            paramMap.put("EMPID", admin.getAdminID());
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityEmpInfoDao.getEmpBasicInfo(paramMap);
    }

    /**
     * 获取个人信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.utilityEmpInfoDao.getEmpInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.utilityEmpInfoDao.getEmpInfoList(paramMap);
        }
        return retrunList;
    }

    /**
     * 获取个人信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getEmpInfoListCnt(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        return this.utilityEmpInfoDao.getEmpInfoListCnt(paramMap);
    }

    /**
     * 判断是否是考勤员
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public boolean isSupervisor(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("ADMINID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("supervisorRoleNo", this.utilityOtherInfoDao.getModuleParameter("supervisorRoleNo"));
        return this.utilityEmpInfoDao.isSupervisor(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getAttSearchEmployeeList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("AR_ADMIN_ID") == null || paramMap.get("AR_ADMIN_ID").toString().equals("")) {
            paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.utilityEmpInfoDao.getAttSearchEmployeeList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.utilityEmpInfoDao.getAttSearchEmployeeList(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getAttSearchEmployeeCnt(HttpServletRequest request) {
        int retrunInt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("AR_ADMIN_ID") == null || paramMap.get("AR_ADMIN_ID").toString().equals("")) {
            paramMap.put("AR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());
        retrunInt = this.utilityEmpInfoDao.getAttSearchEmployeeCnt(paramMap);
        return retrunInt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getHrSearchEmployeeList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            if (paramMap.get("NOT_DEPT") == null) {
                paramMap.put("DEPTID", admin.getDeptID());
            }
        }
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            if (paramMap.get("PA_MONTH") == null) {
                retrunList = this.utilityEmpInfoDao.getHrSearchEmployeeList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
            } else {
                retrunList = this.utilityEmpInfoDao.getHrSearchEmployeeListScore(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
            }
        } else {
            if (paramMap.get("PA_MONTH") == null) {
                retrunList = this.utilityEmpInfoDao.getHrSearchEmployeeList(paramMap);
            } else {
                retrunList = this.utilityEmpInfoDao.getHrSearchEmployeeListScore(paramMap);
            }
        }
        return retrunList;
    }

    @Override
    public List<Employee> getAllEmployeesUsingBeanMap(HttpServletRequest request) {
        AdminBean adminBean = SessionUtil.getLoginUserFromSession(request);
        return this.utilityEmpInfoDao.getAllEmployeesUsingBeanMap(adminBean);
    }

    @Override
    public Employee getEmpBasicInfoUsingBeanMap(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        if (paramMap == null || paramMap.get("EMPID") == null || paramMap.get("EMPID").toString().equals("")) {
            paramMap.put("EMPID", admin.getAdminID());
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityEmpInfoDao.getEmpBasicInfoUsingBeanMap(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getHrSearchEmployeeCnt(HttpServletRequest request) {
        int retrunInt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());

        retrunInt = this.utilityEmpInfoDao.getHrSearchEmployeeCnt(paramMap);

        return retrunInt;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getProSearchEmployeeInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.utilityEmpInfoDao.getProSearchEmployeeInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.utilityEmpInfoDao.getProSearchEmployeeInfo(paramMap);
        }
        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getProSearchEmployeeInfoCnt(HttpServletRequest request) {
        int retrunInt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("HR_ADMIN_ID") == null || paramMap.get("HR_ADMIN_ID").toString().equals("")) {
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("DEPTID") == null || paramMap.get("DEPTID").toString().equals("")) {
            paramMap.put("DEPTID", admin.getDeptID());
        }
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        retrunInt = this.utilityEmpInfoDao.getProSearchEmployeeInfoCnt(paramMap);
        return retrunInt;
    }

    /**
     * 获取信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    @Override
    public Map getRequestParamData(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return paramMap;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getCustSearchEmployeeList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("CR_ADMIN_ID") == null || paramMap.get("CR_ADMIN_ID").toString().equals("")) {
            paramMap.put("CR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("CR_DEPTID") == null || paramMap.get("CR_DEPTID").toString().equals("")) {
            return null;
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.utilityEmpInfoDao.getCustSearchEmployeeList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.utilityEmpInfoDao.getCustSearchEmployeeList(paramMap);
        }
        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getCustSearchEmployeeCnt(HttpServletRequest request) {
        int retrunInt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap == null || paramMap.get("CR_ADMIN_ID") == null || paramMap.get("CR_ADMIN_ID").toString().equals("")) {
            paramMap.put("CR_ADMIN_ID", admin.getAdminID());
        }
        if (paramMap == null || paramMap.get("CR_DEPTID") == null || paramMap.get("CR_DEPTID").toString().equals("")) {
            return 0;
        }
        paramMap.put("CPNY_ID", admin.getCpnyId());
        retrunInt = this.utilityEmpInfoDao.getCustSearchEmployeeCnt(paramMap);

        return retrunInt;
    }

}
