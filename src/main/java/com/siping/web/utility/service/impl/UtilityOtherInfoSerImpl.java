package com.siping.web.utility.service.impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.process.bean.Type;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.dao.UtilityOtherInfoDao;
import com.siping.web.utility.service.UtilityOtherInfoSer;
import com.sun.corba.se.impl.orbutil.ObjectUtility;

@Service
public class UtilityOtherInfoSerImpl implements UtilityOtherInfoSer {

    Logger logger = Logger.getLogger(UtilityOtherInfoSerImpl.class);

    @Autowired
    private UtilityOtherInfoDao utilityOtherInfoDao;

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getMenuModuleSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getMenuModuleSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getMenuModuleSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getItemInfoSelection(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getItemInfoSelection(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getItemInfoSelection(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getUnitSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getUnitSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getUnitSelectList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getWorkAreaList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getWorkAreaList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getSalaryReferenceList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getSalaryReferenceList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getCardtimeReasonSelectList
     * (javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getCardtimeReasonSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getCardtimeReasonSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getLeaveTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getLeaveTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getLeaveTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getEvTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getEvTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getEvTypeProcessSelectList(
     * javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvTypeProcessSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getEvTypeProcessSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getEvTypeOperationSelectList
     * (javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvTypeOperationSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getEvTypeOperationSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getEvTypeItemSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvTypeItemSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getEvTypeItemSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getOTTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getOTTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getOTTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getBTSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getBTSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getBTSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getExpDetailTypeSelectList(
     * javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getExpDetailTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getExpDetailTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getProSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", admin.getAdminID());
        return this.utilityOtherInfoDao.getProSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getResignTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getResignTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getResignTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getDisTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getDisTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getDisTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getRewardGradeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getRewardGradeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getRewardGradeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getRewardTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getRewardTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getRewardTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getPunishmentTypeSelectList
     * (javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPunishmentTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getPunishmentTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getTaxWaySelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getTaxWaySelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getTaxWaySelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getBIZSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getBIZSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getBIZSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getStatusSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getStatusSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getStatusSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getRelationalTypeSelectList
     * (javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getRelationalTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getRelationalTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getRelationalTypeSelectList
     * (javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getOtherRelationlTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getOtherRelationlTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getEduHisTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEduHisTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getEduHisTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getReturnTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getReturnTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getReturnTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getCurrencyUnitSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getCurrencyUnitSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getCurrencyUnitSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getDegreeTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getDegreeTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getDegreeTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getContractTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getContractTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getContractTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getDataTypeSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getDataTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getDataTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getMC1STSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getMC1STSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getMC1STSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getMCName(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String getMCName(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getMCName(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getMC2NDSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getMC2NDSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getMC2NDSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getMC2NDSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getMCSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getMCSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see com.siping.web.utility.service.UtilitySer#getMC2NDSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getToolItemSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getToolItemSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getParameterTypeSelectList(
     * javax .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getParameterTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getParameterTypeSelectList(paramMap);
    }

    /*
     * (non-Javadoc)
     * @see
     * com.siping.web.utility.service.UtilitySer#getShiftAttSelectList(javax
     * .servlet.http.HttpServletRequest)
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getShiftAttSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.utilityOtherInfoDao.getShiftAttSelectList(paramMap);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPostSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("CPNY_ID", "");
        param.put("POST_GROUP_ID", "");
        param.put("POST_COLUMN_ID", "");
        param.put("POST_GRADE_ID", "");
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getPostSelectList(param);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPositionSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("CPNY_ID", "");
        param.put("POST_GROUP_ID", "");
        param.put("POST_COLUMN_ID", "");
        param.put("POST_GRADE_ID", "");
        param.put("POST_ID", "");
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getPositionSelectList(param);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPostGradeSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("CPNY_ID", "");
        param.put("POST_GROUP_ID", "");
        param.put("POST_COLUMN_ID", "");
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getPostGradeSelectList(param);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPostColumnSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("CPNY_ID", "");
        param.put("POST_GROUP_ID", "");
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getPostColumnSelectList(param);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPostGroupSelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("CPNY_ID", "");
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getPostGroupSelectList(param);
    }

    /**
     * 获取CODE使用状态信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getActivitySelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getActivitySelectList(param);
    }

    /**
     * 获取公司列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getCompanySelectList(HttpServletRequest request) {
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getCompanySelectList(param);
    }

    /**
     * 获取银行列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getBankSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        param.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getBankSelectList(param);
    }

    /**
     * 获取银行列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProTypeCodeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", admin.getAdminID());
        return this.utilityOtherInfoDao.getProTypeCodeSelectList(paramMap);
    }

    /**
     * 获取评价期间列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvaPeriodSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        param.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getEvaPeriodSelectList(param);
    }

    /**
     * 获取评价期间列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getEvaPeriodTypeSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getEvaPeriodTypeSelectList(paramMap);
    }

    /**
     * 获取调整事由列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getReasonSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map param = new LinkedHashMap();
        param.put("language", Messages.getLanguage(request));
        param.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getReasonSelectList(param);
    }

    /**
     * 获取模块参数
     * @param request
     * @return
     */
    @Override
    public String getModuleParameter(Object object) {

        return this.utilityOtherInfoDao.getModuleParameter(object);
    }

    /**
     * 获取公司列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getAreasByParentID(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getAreasByParentID(paramMap);
    }

    /**
     * 获取出差列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getBTDurationInfo(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        return this.utilityOtherInfoDao.getBTDurationInfo(paramMap);
    }

    /**
     * 获取出差列表
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getItemSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getItemSelectList(paramMap);
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

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getCustActionStateList(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getCustActionStateList(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getCustActionWayList(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getCustActionWayList(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getAnnouncementTypeSelectList(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getAnnouncementTypeSelectList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public Map getScreenGrantId(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        //TODO 
        Type type = new Type();
        return (Map) this.utilityOtherInfoDao.getScreenGrantId(admin, type);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getSyCodeSelectList(HttpServletRequest request) {
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.utilityOtherInfoDao.getSyCodeSelectList(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProductionOrderSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", admin.getAdminID());
        return this.utilityOtherInfoDao.getProductionOrderSelectList(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getApplyFunctionSelectList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", admin.getAdminID());
        return this.utilityOtherInfoDao.getApplyFunctionSelectList(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPaymentModeInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("EMPID", admin.getAdminID());
        return this.utilityOtherInfoDao.getPaymentModeInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getPurchaseTendList(HttpServletRequest request) {
        AdminBean adminBean = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = new LinkedHashMap();
        paramMap.put("CPNY_ID", adminBean.getCpnyId());
        return this.utilityOtherInfoDao.getPurchaseTendList(paramMap);
    }
}
