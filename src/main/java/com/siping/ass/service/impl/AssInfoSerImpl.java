package com.siping.ass.service.impl;

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

import com.siping.ass.dao.AssInfoDao;
import com.siping.ass.service.AssInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class AssInfoSerImpl implements AssInfoSer {
    Logger logger = Logger.getLogger(AssInfoSerImpl.class);
    @Autowired
    private AssInfoDao assInfoDao;

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object getBasicInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));

        return this.assInfoDao.getBasicInfo(paramMap);

    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getAssetList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.assInfoDao.getAssetList(paramMap);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public int getAssetListCnt(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.assInfoDao.getAssetListCnt(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public Object getAssetDetail(HttpServletRequest request) {
        // AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("ASSET_ID") == null && paramMap.get("ASSET_NAME_CODE") == null) {
            paramMap.put("ASSET_ID", "Asset001");
        }
        return this.assInfoDao.getAssetDetail(paramMap);
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

    @SuppressWarnings("rawtypes")
    @Override
    public List getBorrowRecord(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        return this.assInfoDao.getBorrowRecord(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getBorrowRecordList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.assInfoDao.getBorrowRecordList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.assInfoDao.getBorrowRecordList(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getBorrowRecordListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.assInfoDao.getBorrowRecordListCnt(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getAssBrokenSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        return this.assInfoDao.getAssBrokenSelectList(param);
    }

    @Override
    public String assReturnUpdate(HttpServletRequest request) {
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            this.assInfoDao.assReturnUpdate(updateList);
        } catch (Exception e) {
            e.printStackTrace();
            return "N";
        }
        return "Y";
    }
}
