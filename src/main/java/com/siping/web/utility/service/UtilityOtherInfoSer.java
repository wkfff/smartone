package com.siping.web.utility.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface UtilityOtherInfoSer {  
    /**
     * 菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMenuModuleSelectList(HttpServletRequest request);
    /**
     * 获取休假类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getLeaveTypeSelectList(HttpServletRequest request);
    /**
     * 获取评价类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeSelectList(HttpServletRequest request);
    /**
     * 获取工作地点下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getWorkAreaList(HttpServletRequest request);
    /**
     * 获取工作地点下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getSalaryReferenceList(HttpServletRequest request);
    /**
     * 获取评价类型流程下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeProcessSelectList(HttpServletRequest request);
    /**
     * 获取评价类型流程操作下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeOperationSelectList(HttpServletRequest request);
    /**
     * 获取评价项目下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEvTypeItemSelectList(HttpServletRequest request);
    /**
     * 获取加班类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getOTTypeSelectList(HttpServletRequest request);
    /**
     * 获取加班类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBTSelectList(HttpServletRequest request);
    /**
     * 获取费用明细类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getExpDetailTypeSelectList(HttpServletRequest request);
    /**
     * 获取工时项目下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getProSelectList(HttpServletRequest request);
    /**
     * 获取考勤项目下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getItemSelectList(HttpServletRequest request);
    /**
     * 获取离职类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getResignTypeSelectList(HttpServletRequest request);
    /**
     * 获取加班类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDisTypeSelectList(HttpServletRequest request);
    /**
     * 获取奖励级别下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRewardGradeSelectList(HttpServletRequest request);
    
    /**
     * 获取奖励类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRewardTypeSelectList(HttpServletRequest request);  
    /**
     * 获取惩戒类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPunishmentTypeSelectList(HttpServletRequest request);
    /**
     * 获取惩戒类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getTaxWaySelectList(HttpServletRequest request); 
    /**
     * 获取工作内容下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBIZSelectList(HttpServletRequest request);
    
    /**
     * 获取员工状态下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getStatusSelectList(HttpServletRequest request);
    
    /**
     * 获取家庭成员关系类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getRelationalTypeSelectList(HttpServletRequest request);
    /**
     * 获取学位下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDegreeTypeSelectList(HttpServletRequest request);
    /**
     * 获取学历下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getEduHisTypeSelectList(HttpServletRequest request);    
    /**
     * 获取归还状态下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getReturnTypeSelectList(HttpServletRequest request);
    
    /**
     * 获取货币下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getCurrencyUnitSelectList(HttpServletRequest request);
    
    /**
     * 获取家庭成员关系类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getOtherRelationlTypeSelectList(HttpServletRequest request); 
    /**
     * 获取合同类型下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getContractTypeSelectList(HttpServletRequest request);
    
    /**
     * 考勤项目下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getItemInfoSelection(HttpServletRequest request);
    /**
     * 考勤单位下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getUnitSelectList(HttpServletRequest request); 
    /**
     * 漏卡理由下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getCardtimeReasonSelectList(HttpServletRequest request); 
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getDataTypeSelectList(HttpServletRequest request);
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMC1STSelectList(HttpServletRequest request);
    /**
     * 数据类型
     */ 
    public String getMCName(HttpServletRequest request);
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMC2NDSelectList(HttpServletRequest request);
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getMCSelectList(HttpServletRequest request);
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getToolItemSelectList(HttpServletRequest request);
    /**
     * 数据类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getParameterTypeSelectList(HttpServletRequest request);
    /** 
     * 日期类型
     */
    @SuppressWarnings({ "rawtypes" })
    public List getShiftAttSelectList(HttpServletRequest request); 
    /**
     * 职位列表
     */
    @SuppressWarnings("rawtypes")
    public List getPostSelectList(HttpServletRequest request) ;
    /**
     * 职务列表
     */
    @SuppressWarnings("rawtypes")
    public List getPositionSelectList(HttpServletRequest request) ;
    
    /**
     * 职级列表
     */
    @SuppressWarnings("rawtypes")
    public List getPostGradeSelectList(HttpServletRequest request) ;
    /**
     * 职列列表
     */
    @SuppressWarnings("rawtypes")
    public List getPostColumnSelectList(HttpServletRequest request) ;
    /**
     * 职群列表
     */
    @SuppressWarnings("rawtypes")
    public List getPostGroupSelectList(HttpServletRequest request) ;
    /**
     * 获取公司列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getCompanySelectList(HttpServletRequest request) ;
    /**
     * 获取银行列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getBankSelectList(HttpServletRequest request) ;
    /**
     * 获取银行列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getProTypeCodeSelectList(HttpServletRequest request) ;
    /**
     * 获取评价期间列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getEvaPeriodSelectList(HttpServletRequest request) ;
    /**
     * 获取评价期间列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getEvaPeriodTypeSelectList(HttpServletRequest request) ;
    /**
     * 获取调整事由列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getReasonSelectList(HttpServletRequest request) ;
    /**
     * 获取CODE列表
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getActivitySelectList(HttpServletRequest request) ;
    /** 
     * @param object
     * @return
     */
    public String getModuleParameter(Object object);
    /**
     * 获取地区下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getAreasByParentID(HttpServletRequest request);
    /**
     * 获取出差区间下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getBTDurationInfo(HttpServletRequest request);

    /**
     * 获取信息
     * @param request
     * @return
     */  
    @SuppressWarnings("rawtypes")
    public Map getRequestParamData(HttpServletRequest request) ;
    
    @SuppressWarnings("rawtypes")
    public List getCustActionStateList(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getCustActionWayList(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getPurchaseTendList(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getAnnouncementTypeSelectList(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public Map getScreenGrantId(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
    public List getSyCodeSelectList(HttpServletRequest request);
    /**
     * 获取报工时生产订单及图纸号下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getProductionOrderSelectList(HttpServletRequest request);
    /**
     * 获取报工时生产订单及图纸号下拉菜单
     */
    @SuppressWarnings({ "rawtypes" })
    public List getApplyFunctionSelectList(HttpServletRequest request);
    /**
     * 付款方式
     */
    @SuppressWarnings({ "rawtypes" })
    public List getPaymentModeInfo(HttpServletRequest request);
}
