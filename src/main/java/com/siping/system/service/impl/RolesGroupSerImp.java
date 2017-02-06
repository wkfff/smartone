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

import com.siping.system.bean.AdminBean;
import com.siping.system.dao.RolesGroupDao;
import com.siping.system.service.RolesGroupSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class RolesGroupSerImp implements RolesGroupSer {

    Logger logger = Logger.getLogger(RolesGroupSerImp.class);

    @Autowired
    private RolesGroupDao rolesGroupDao;

    /**
     * 获取角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getRolesGroupInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = rolesGroupDao.getRolesGroupInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = rolesGroupDao.getRolesGroupInfo(paramMap);
        }
        return retrunList;
    }

    /**
     * 获取菜单信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getMenuSelectList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        retrunList = rolesGroupDao.getMenuSelectList(paramMap);
        return retrunList;
    }

    /**
     * 获取角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Map getRolesGroupInfoObj(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));

        return rolesGroupDao.getRolesGroupInfoObj(paramMap);
    }

    /**
     * 获取角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int getRolesGroupInfoCnt(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        return rolesGroupDao.getRolesGroupInfoCnt(paramMap);
    }

    /**
     * 获取角色ID
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int getRolesGroupID(HttpServletRequest request) {

        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        return rolesGroupDao.getRolesGroupID(paramMap);
    }

    /**
     * 添加角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int addRolesGroupInfo(HttpServletRequest request) {
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        // 附加信息
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        try {
            this.rolesGroupDao.addRolesGroupInfo(paramMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * 修改角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int updateRolesGroupInfo(HttpServletRequest request) {
        // session用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        // 附加信息
        paramMap.put("UPDATE_BY", admin.getAdminID());

        this.rolesGroupDao.updateRolesGroupInfo(paramMap);

        return 0;
    }

    /**
     * 删除角色信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public int deleteRolesGroupInfo(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return rolesGroupDao.deleteRolesGroupInfo(paramMap);
    }

    /**
     * 获取角色页面信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getRolesGroupPageInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = rolesGroupDao.getRolesGroupPageInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = rolesGroupDao.getRolesGroupPageInfo(paramMap);
        }
        return retrunList;
    }

    /**
     * 获取角色页面信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getRolesGroupPageInfoCnt(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return rolesGroupDao.getRolesGroupPageInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    public List getSystemMenuInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.rolesGroupDao.getSystemMenuInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.rolesGroupDao.getSystemMenuInfo(paramMap);
        }
        return retrunList;
    }

    // @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getSystemMenuInfoCnt(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.rolesGroupDao.getSystemMenuInfoCnt(paramMap);
    }
}
