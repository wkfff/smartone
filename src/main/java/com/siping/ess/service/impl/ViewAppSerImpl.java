package com.siping.ess.service.impl;

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

import com.siping.ess.dao.ViewAppDao;
import com.siping.ess.service.ViewAppSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.MapUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ViewAppSerImpl implements ViewAppSer {

    Logger logger = Logger.getLogger(ViewAppSerImpl.class);

    @Autowired
    private ViewAppDao viewAppDao;

    public ViewAppDao getViewAppDao() {
        return viewAppDao;
    }

    public void setViewAppDao(ViewAppDao viewAppDao) {
        this.viewAppDao = viewAppDao;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getPersonalInfo(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map returnMap = new LinkedHashMap<Object, Object>();
        Map returnOldMap = new LinkedHashMap<Object, Object>();
        try {
            paramMap.put("language", Messages.getLanguage(request));
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
            returnMap = (Map) this.viewAppDao.getPersonalInfo(paramMap);
            returnOldMap = (Map) this.viewAppDao.getOldPersonalInfo(paramMap);
            returnMap = MapUtil.checkInfoMaps(returnMap, returnOldMap);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPersonalInfoList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getPersonalInfoList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getPersonalInfoList(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getPersonalInfoListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getPersonalInfoListCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getWhInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getWhInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getWhInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getWhInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getWhInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getProInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getProInfo(paramMap);
        }

        return retrunList;
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProInfoByReim(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", ObjectBindUtil.getRequestParamData(request).get("EMPID"));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getProInfoByReim(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getProInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getProInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", ObjectBindUtil.getRequestParamData(request).get("EMPID"));
        return this.viewAppDao.getProInfoCntByReim(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProMemberInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getProMemberInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getProMemberInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getProMemberInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getProMemberInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getWorkingHoursInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getWorkingHoursInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getWorkingHoursInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getWorkingHoursInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getWorkingHoursInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getOtInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getOtInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getOtInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getOtInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getOtInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getEmpEtnAppView(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            paramMap.put("language", Messages.getLanguage(request));
            paramMap.put("adminID", admin.getAdminID());
            paramMap.put("affirmID", admin.getAdminID());
            if (paramMap.get("qryType") == null || paramMap.get("qryType").toString().isEmpty()) {
                paramMap.put("qryType", 3);
            }
            if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
                returnMap = this.viewAppDao.getEmpEtnAppView(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getLeaveInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getLeaveInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getLeaveInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getLeaveInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getLeaveInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getCardtimeInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getCardtimeInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getCardtimeInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getCardtimeInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        return this.viewAppDao.getCardtimeInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getCardtimeAttInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getCardtimeAttInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getCardtimeAttInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getCardtimeAttInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        return this.viewAppDao.getCardtimeAttInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getExpInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getExpInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getExpInfo(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getExpInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getExpInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getExpDetailInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getExpDetailInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getExpDetailInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getExpDetailInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getExpDetailInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getBTInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getBTInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getBTInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getBTInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getBTInfoCnt(paramMap);
    }

    /**
     * 获取物品信息
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getToolInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getToolInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getToolInfo(paramMap);
        }
        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getToolInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getToolInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getEmpTrainingAppView(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            paramMap.put("language", Messages.getLanguage(request));
            paramMap.put("adminID", admin.getAdminID());
            paramMap.put("affirmID", admin.getAdminID());
            if (paramMap.get("qryType") == null || paramMap.get("qryType").toString().isEmpty()) {
                paramMap.put("qryType", 3);
            }
            if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
                returnMap = this.viewAppDao.getEmpTrainingAppView(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    @Override
    public String cancelApp(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        String appType = request.getParameter("appType");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            if (appType.equals("OtInfo")) {
                this.viewAppDao.cancelOtInfo(updateList);
            } else if (appType.equals("LeaveInfo")) {
                this.viewAppDao.cancelLeaveInfo(updateList);
            } else if (appType.equals("BTInfo")) {
                this.viewAppDao.cancelBizInfo(updateList);
            } else if (appType.equals("TrainingInfo")) {
                this.viewAppDao.cancelTrainingInfo(updateList);
            } else if (appType.equals("ExpInfo")) {
                this.viewAppDao.cancelExpInfo(updateList);
            } else if (appType.equals("CardtimeInfo")) {
                this.viewAppDao.cancelCardtimeInfo(updateList);
            } else if (appType.equals("ToolInfo")) {
                this.viewAppDao.cancelToolInfo(updateList);
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "notCancel";
        }
        return "cancel";
    }

    @Override
    public String cancelWhApp(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);

        return this.viewAppDao.cancelWhInfo(updateList);
    }

    /**
     * 恢复取消的申请
     * @param request
     * @return
     */
    public String recoverCancel(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());
        String jsonString = request.getParameter("jsonData");
        String appType = request.getParameter("appType");
        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        try {
            if (appType.equals("perInfo")) {
                this.viewAppDao.RecoverCancelPerInfo(updateList);
            } else if (appType.equals("whInfo")) {
                this.viewAppDao.RecoverCancelWhInfo(updateList);
            } else if (appType.equals("OtInfo")) {
                this.viewAppDao.RecoverCancelOtInfo(updateList);
            } else if (appType.equals("LeaveInfo")) {
                this.viewAppDao.RecoverCancelLeaveInfo(updateList);
            } else if (appType.equals("BTInfo")) {
                this.viewAppDao.RecoverCancelBizInfo(updateList);
            } else if (appType.equals("TrainingInfo")) {
                this.viewAppDao.RecoverCancelTrainingInfo(updateList);
            } else if (appType.equals("ExpInfo")) {
                this.viewAppDao.RecoverCancelExpInfo(updateList);
            } else if (appType.equals("CardtimeInfo")) {
                this.viewAppDao.RecoverCancelCardtimeInfo(updateList);
            } else if (appType.equals("ToolInfo")) {
                this.viewAppDao.RecoverCancelToolInfo(updateList);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public String delWorkingHoursInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        this.viewAppDao.delWorkingHoursInfo(paramMap);
        return "Y";
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public String delProInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("UPDATED_BY", admin.getAdminID());

        return this.viewAppDao.delProInfo(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public String delProMemberInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("UPDATED_BY", admin.getAdminID());

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        if (delList.size() > 0) {
            return this.viewAppDao.delProMemberInfo(delList);
        } else {
            return this.viewAppDao.delProMemberInfo(paramMap);
        }
    }

    @Override
    @SuppressWarnings({ "rawtypes" })
    public String delExpDetailInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        this.viewAppDao.delExpDetailInfo(paramMap);
        return "Y";
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getAffirmorList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("affirmID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));
        Map returnMap = new LinkedHashMap<Object, Object>();
        try {
            returnMap = viewAppDao.getAffirmorList(paramMap);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnMap;
    }

    /**
     * 获取个人流程信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getEmpLeaveDetailInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        try {
            paramMap.put("language", Messages.getLanguage(request));
            paramMap.put("HR_ADMIN_ID", admin.getAdminID());
            if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
                retrunList = this.viewAppDao.getEmpLeaveDetailInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                    NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
            } else {
                retrunList = this.viewAppDao.getEmpLeaveDetailInfo(paramMap);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return retrunList;
    }

    /**
     * 获取个人流程信息
     * @param request
     * @return
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getEmpLeaveDetailInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        return this.viewAppDao.getEmpLeaveDetailInfoCnt(paramMap);
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

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProductionOrderInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.viewAppDao.getProductionOrderInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.viewAppDao.getProductionOrderInfo(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getProductionOrderInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());

        return this.viewAppDao.getProductionOrderInfoCnt(paramMap);
    }

}
