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
import com.siping.system.bean.AdminBean;
import com.siping.hrm.dao.PositionMgtDao;
import com.siping.hrm.service.PositionMgtSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PositionMgtSerImpl implements PositionMgtSer {

    Logger logger = Logger.getLogger(PositionMgtSerImpl.class);

    @Autowired
    private PositionMgtDao positionMgtDao;

    /**
     * 获取职群信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getPostGroupInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        Map paramMap = new LinkedHashMap();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPostGroupInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPostGroupInfo(paramMap);
        }

        return retrunList;
    }

    /**
     * 获取职群信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getPostGroupInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return positionMgtDao.getPostGroupInfoCnt(paramMap);
    }

    /**
     * 修改职群信息
     */
    public int updatePostGroupInfo(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        this.positionMgtDao.updatePostGroupInfo(updateList);
        return 1;
    }

    /**
     * 删除职群信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deletePostGroupInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        this.positionMgtDao.deletePostGroupInfo(paramMap);

        return 0;
    }

    /**
     * 检查职群信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int checkPostGroupInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.positionMgtDao.checkPostGroupInfo(paramMap);
    }

    /**
     * 添加职群信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int addPostGroupInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.addPostGroupInfo(paramMap);

        return 0;
    }

    /**
     * 获取职级信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getPostGradeInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPostGradeInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPostGradeInfo(paramMap);
        }

        return retrunList;
    }

    /**
     * 获取职级信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getPostGradeInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return positionMgtDao.getPostGradeInfoCnt(paramMap);
    }

    /**
     * 修改职级信息
     */
    public int updatePostGradeInfo(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        this.positionMgtDao.updatePostGradeInfo(updateList);
        return 1;
    }

    /**
     * 删除职级信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int deletePostGradeInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.deletePostGradeInfo(paramMap);

        return 0;
    }

    /**
     * 检查职级信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int checkPostGradeInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.positionMgtDao.checkPostGradeInfo(paramMap);
    }

    /**
     * 添加职级信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int addPostGradeInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.addPostGradeInfo(paramMap);

        return 0;
    }

    /**
     * 获取职位岗位信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getPostInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPostInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPostInfo(paramMap);
        }

        return retrunList;
    }

    /**
     * 获取职位岗位信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getPostInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return positionMgtDao.getPostInfoCnt(paramMap);
    }

    /**
     * 修改职位岗位信息
     */
    public int updatePostInfo(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        this.positionMgtDao.updatePostInfo(updateList);
        return 1;
    }

    /**
     * 删除职位岗位信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deletePostInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.deletePostInfo(paramMap);

        return 0;
    }

    /**
     * 检查职位岗位信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int checkPostInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.positionMgtDao.checkPostInfo(paramMap);
    }

    /**
     * 添加职位岗位信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int addPostInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.addPostInfo(paramMap);
        return 0;
    }

    /**
     * 获取职务信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public List getPositionInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPositionInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPositionInfo(paramMap);
        }

        return retrunList;
    }

    /**
     * 获取职务信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int getPositionInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return positionMgtDao.getPositionInfoCnt(paramMap);
    }

    /**
     * 修改职务信息
     */
    public int updatePositionInfo(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        this.positionMgtDao.updatePositionInfo(updateList);
        return 1;
    }

    /**
     * 删除职务信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deletePositionInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.deletePositionInfo(paramMap);
        return 0;
    }

    /**
     * 检查职务信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int checkPositionInfo(HttpServletRequest request) {
        // 页面提交数据
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.positionMgtDao.checkPositionInfo(paramMap);
    }

    /**
     * 添加职务信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public int addPositionInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.addPositionInfo(paramMap);

        return 0;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPostLevelInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPostLevelInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPostLevelInfo(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getPostLevelInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return positionMgtDao.getPostLevelInfoCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int checkPostLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.positionMgtDao.checkPostLevelInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int addPostLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        this.positionMgtDao.addPostLevelInfo(paramMap);

        return 0;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int deletePostLevelInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        this.positionMgtDao.deletePostLevelInfo(paramMap);
        return 0;
    }

    @Override
    public int updatePostLevelInfo(HttpServletRequest request) throws Exception{
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);
        this.positionMgtDao.updatePostLevelInfo(updateList);
        return 0;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPostLevelDataInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = positionMgtDao.getPostLevelDataInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = positionMgtDao.getPostLevelDataInfo(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getPostLevelDataInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return positionMgtDao.getPostLevelDataInfoCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int addOrUpdatePostLevelDataInfo(HttpServletRequest request) throws Exception{
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        // 页面提交的JSON信息
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, paramMap);
        if (paramMap.get("type").equals("update")) {
            this.positionMgtDao.updatePostLevelDataInfo(insertList);
        } else {
            this.positionMgtDao.addPostLevelDataInfo(insertList);
        }
        return 1;
    }

    @Override
    public int deletePostLevelDataInfo(HttpServletRequest request) {

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString);

        return this.positionMgtDao.deletePostLevelDataInfo(delList);
    }
}
