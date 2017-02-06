package com.siping.hrm.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface TransferOrderDao {

    public Object getNextTransNo();

    @SuppressWarnings({ "rawtypes" })
    public List getEmpInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getEmpInfoList(Object object);

    public String getNewestEmpIDInfo(Object object);

    public int getEmpInfoCnt(Object object);

    @SuppressWarnings({ "rawtypes" })
    public List getEmpActBusinessInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getEmpActBusinessInfoList(Object object);

    public int getEmpActBusinessInfoCnt(Object object);

    /**
     * 查看业务变更
     */
    @SuppressWarnings({ "rawtypes" })
    public List getActBusinessInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getActBusinessInfoList(Object object);

    public int getActBusinessInfoCnt(Object object);

    /**
     * @param obj
     */
    public String saveResign(Object obj);

    public String saveExperience(Object obj);

    /**
     * @param obj
     */
    public String saveReward(Object obj);

    /**
     * @param obj
     */
    public String savePunishment(Object obj);

    /**
     * @param obj
     */
    public String saveDispath(Object obj);

    /**
     * @param obj
     */
    public String saveDispathEnd(Object obj);

    /**
     * @param obj
     */
    public String savePlurality(Object obj);

    /**
     * @param obj
     */
    public String savePluralityEnd(Object obj);

    /**
     * @param obj
     */
    public String saveBusiness(Object obj);

    /**
     * 员工入职
     * @param obj
     */
    public String saveHire(Object obj);

    /**
     * 工号唯一检查
     * @param obj
     * @return
     */
    public int checkEmpID(Object obj);

    /**
     * 唯一检查
     * @param obj
     * @return
     */
    public List<LinkedHashMap<String, Object>> checkArrayListMember(List<LinkedHashMap<String, Object>> objectList);

    public void hrUpdateAuto();

    /**
     * 查看调动
     */
    @SuppressWarnings({ "rawtypes" })
    public List getUpgradeInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getUpgradeInfoList(Object object);

    public int getUpgradeInfoCnt(Object object);

    /**
     * 查看发令
     */
    @SuppressWarnings({ "rawtypes" })
    public List getGeneralDocInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getGeneralDocInfoList(Object object);

    public int getGeneralDocInfoCnt(Object object);

    /**
     * 查看兼职
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPluralityInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getPluralityInfoList(Object object);

    public int getPluralityInfoCnt(Object object);

    /**
     * 查看派遣
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDispatchInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getDispatchInfoList(Object object);

    public int getDispatchInfoCnt(Object object);

    /**
     * 查看奖励
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getRewardInfoList(Object object);

    /**
     * 每个月的奖励信息汇总
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSumRewardInfoList(Object object);

    public int getRewardInfoCnt(Object object);

    /**
     * 查看惩戒
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentInfoList(Object object);

    /**
     * 每个月的惩戒信息汇总
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSumPunishmentInfoList(Object object);

    public int getPunishmentInfoCnt(Object object);

    /**
     * 查看离职
     */
    @SuppressWarnings({ "rawtypes" })
    public List getResignInfoList(Object object, int currentPage, int pageSize);

    @SuppressWarnings({ "rawtypes" })
    public List getResignInfoList(Object object);

    public int getResignInfoCnt(Object object);

    /**
     * 取消调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelExpInsideInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelExpInsideInfoRecover(List objectList);

    /**
     * 取消担当调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelActBusinessInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelActBusinessInfoRecover(List objectList);

    /**
     * 取消派遣调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelDispatchInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelDispatchInfoRecover(List objectList);

    /**
     * 取消奖励调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelRewardInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelRewardInfoRecover(List objectList);

    /**
     * 取消兼职调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelPluralityInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelPluralityInfoRecover(List objectList);

    /**
     * 取消惩戒调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelPunishMentInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelPunishMentInfoRecover(List objectList);

    /**
     * 取消离职调令
     * @param objectList
     */
    @SuppressWarnings("rawtypes")
    public void cancelResignInfo(List objectList);

    @SuppressWarnings("rawtypes")
    public void cancelResignInfoRecover(List objectList);

}
