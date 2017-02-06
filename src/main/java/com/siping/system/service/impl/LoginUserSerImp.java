package com.siping.system.service.impl;

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

import com.siping.cust.dao.CustManageDao;
import com.siping.hrm.dao.TransferOrderDao;
import com.siping.system.bean.AdminBean;
import com.siping.system.dao.LoginUserDao;
import com.siping.system.service.LoginUserSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class LoginUserSerImp implements LoginUserSer {

    Logger logger = Logger.getLogger(LoginUserSerImp.class);

    @Autowired
    private LoginUserDao loginUserDao;

    @Autowired
    private TransferOrderDao transferOrderDao;

    @Autowired
    private CustManageDao custManageDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getLoginUserInfoObj(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.loginUserDao.getLoginUserInfoObj(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getLoginUserRolesGroupList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.loginUserDao.getLoginUserRolesGroupList(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getLoginUserInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = loginUserDao.getLoginUserInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = loginUserDao.getLoginUserInfo(paramMap);
        }
        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addLoginUserInfo(HttpServletRequest request) throws Exception {
        String resultString = "Y";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("CREATED_BY", admin.getAdminID());

        Object loginType = paramMap.get("LOGIN_TYPE");
        if(loginType!=""&&loginType!=null){
            if(loginType.toString().equals("EM")){
                if (this.transferOrderDao.checkEmpID(paramMap) == 0) {
                    return "系统中没有编号为"+paramMap.get("ADMINID")+"的员工";
                }
            }else if(loginType.toString().equals("CU")){
                if (this.custManageDao.checkCustID(paramMap) == 0) {
                    return "系统中没有编号为"+paramMap.get("ADMINID")+"的客户";
                }
            }
        }else{
            return "请选择类型！";
        }
        if (this.loginUserDao.checkAdminID(paramMap) != 0) {
            return "编号"+paramMap.get("ADMINID")+"已被使用";
        }
        if (this.loginUserDao.checkUserName(paramMap) != 0) {
            return "账号"+paramMap.get("USERNAME")+"已被使用";
        }
        paramMap.put("PASSWORD", EncryptUtil.MD5Encode("123456"));
        resultString = this.loginUserDao.addLoginUserInfo(paramMap);
        return resultString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateLoginUserInfo(HttpServletRequest request) {
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.remove("jsonData");
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        // 权限组信息
        String screenGrantID = "";
        String[] screenGrantIDs = request.getParameterValues("SCREEN_GRANT_ID");
        if (screenGrantIDs != null) {
            for (int i = 0; i < screenGrantIDs.length; ++i) {
                screenGrantID += screenGrantIDs[i];
                if (i != screenGrantIDs.length - 1) {
                    screenGrantID += ",";
                }
            }
        }
        paramMap.put("SCREEN_GRANT_ID", screenGrantID);

        // 页面提交的JSON信息
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> insertLoginUserDeptList = ObjectBindUtil.getRequestJsonData(jsonString);
        paramMap.put("insertLoginUserDeptList", insertLoginUserDeptList);
        return this.loginUserDao.updateLoginUserInfo(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String deleteLoginUserInfo(HttpServletRequest request) {
        Map pamaMap = ObjectBindUtil.getRequestParamData(request);
        return this.loginUserDao.deleteLoginUserInfo(pamaMap);
    }

    // @Override
    @SuppressWarnings({ "rawtypes", })
    @Override
    public int getLoginUserInfoCnt(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        return loginUserDao.getLoginUserInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked", })
    @Override
    public List getLoginUserDeptInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return loginUserDao.getLoginUserDeptInfo(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked", })
    @Override
    public List getRolesSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return loginUserDao.getRolesSelectList(paramMap);
    }

}
