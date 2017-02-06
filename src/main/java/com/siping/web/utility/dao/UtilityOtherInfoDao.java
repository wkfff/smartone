package com.siping.web.utility.dao;

import java.util.List;

import com.siping.process.bean.Type;
import com.siping.system.bean.AdminBean;

public interface UtilityOtherInfoDao { 

    /**
     * 获得菜单下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMenuModuleSelectList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDataTypeSelectList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMCSelectList(Object object);
    /**
     * 获得部门地点下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getWorkAreaList(Object object);
    /**
     * 获得提成参考值下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSalaryReferenceList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getToolItemSelectList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMC1STSelectList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */ 
    public String getMCName(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMC2NDSelectList(Object object);
    /**
     * 获得数据类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getParameterTypeSelectList(Object object);
    /**
     * 考勤项目下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getItemInfoSelection(Object object);
    /**
     * 考勤单位下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getUnitSelectList(Object object);
    /**
     * 漏卡理由下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeReasonSelectList(Object object);
    
    /**
     * 日期类型下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getShiftAttSelectList(Object object); 
    /**
     * 获得职位下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostSelectList(Object object);
    /**
     * 获得职务下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPositionSelectList(Object object); 
    /**
     * 获得职级下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGradeSelectList(Object object);
    /**
     * 获得职列下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostColumnSelectList(Object object);
    /**
     * 获得职群下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPostGroupSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getActivitySelectList(Object object);
    /**
     * 获取公司列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getCompanySelectList(Object object);
    /**
     * 获取银行列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBankSelectList(Object object);
    /**
     * 获取银行列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getProTypeCodeSelectList(Object object);
    /**
     * 获取评价期间列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvaPeriodSelectList(Object object);
    /**
     * 获取评价期间列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvaPeriodTypeSelectList(Object object);
    /**
     * 获取调整事由列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getReasonSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getLeaveTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeProcessSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeOperationSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeItemSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getOTTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBTSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getExpDetailTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getProSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getResignTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDisTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRewardGradeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRewardTypeSelectList(Object object);
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getTaxWaySelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBIZSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getStatusSelectList(Object object);
    
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getOtherRelationlTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRelationalTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDegreeTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEduHisTypeSelectList(Object object); 
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getReturnTypeSelectList(Object object); 
    
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getCurrencyUnitSelectList(Object object); 
    
    /**
     * 获得下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getContractTypeSelectList(Object object); 
    /**
     * 
     * @param object
     * @return
     */
    public String getModuleParameter(Object object);
    /**
     * 获取考勤月开始日期信息
     * 
     * @param object
     * @return 
     */
    public String getStartDateStr(Object object);
    /**
     * 获取考勤月结束日期信息
     * 
     * @param object
     * @return 
     */
    public String getEndDateStr(Object object);
    /**
     * 获得地区下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getAreasByParentID(Object object); 
    /**
     * 获得出差区间下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBTDurationInfo(Object object); 
    /**
     * 获得考勤项目下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getItemSelectList(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getCustActionStateList(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getCustActionWayList(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getPurchaseTendList(Object object);
    
    @SuppressWarnings("rawtypes")
    public List getAnnouncementTypeSelectList(Object object); 
    
    public Object getScreenGrantId(AdminBean admin, Type type);
    
    @SuppressWarnings("rawtypes")
    public List getSyCodeSelectList(Object object);
    /**
     * 获得报工时生产订单及图纸号列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getProductionOrderSelectList(Object object);
    /**
     * 生成流水号时应用功能下拉列表
     * @param object
     * @return
     */
    @SuppressWarnings({ "rawtypes" })
    public List getApplyFunctionSelectList(Object object);
    @SuppressWarnings({ "rawtypes" })
    public List getPaymentModeInfo(Object object);
} 
