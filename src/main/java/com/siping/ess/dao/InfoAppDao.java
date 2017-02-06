package com.siping.ess.dao;

import java.util.List; 
import java.util.Map;

public interface InfoAppDao {
    /**
     * 根据项目号得到已经分配的最大最小日期,以免修改日期的时候出现错误
     * @param obj
     * @return
     */
    @SuppressWarnings("rawtypes")
    public List getStartAndEndDate(Object obj);
	/**
	 * 修改个人信息
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addPersonalInfoApp(Object obj);
	/**
	 * 添加加班申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addOvertimeApp(Object obj);
	/**
	 * 添加加班申请 取加班参数
	 * @param obj
	 * @return
	 */ 
	public int getOTAppAffirmLeve(Object obj); 
	/**
	 * 添加漏卡申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addCardtimeApp(Object obj) ;
	/**
	 * 添加出差申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addBTApp(Object obj); 
	/**
	 * 添加出差申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addExpApp(Object obj); 
	/**
	 * 添加休假申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map addLeaveApp(Object obj,boolean affirmFlag); 
	/**
	 * 添加休假申请 取休假参数
	 * @param obj
	 * @return
	 */ 
	public int getLeaveAppAffirmLeve(Object obj); 
	/**
	 * 添加培训申请
	 * @param obj
	 * @return
	 */
	public boolean addTrainingApp(Object obj);
	/**
	 * 添加培训申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorList(Object obj);
	/**
	 * 添加培训申请
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEmpShift(Object obj);
	/**
	 * 剩余年假剩余福利年假
	 * @param obj
	 * @return 
	 */
	public double getEmpVacationRema(Object obj);
	/**
	 * 已经使用的休假时数
	 * @param obj
	 * @return 
	 */
	public double getEmpVacationUsed(Object obj);
	/**
	 * 未确认休假
	 * @param obj
	 * @return 
	 */
	public double getEmpVacationNotConfirm(Object obj);
	
	/**
	 * 根据EMPID 或部门ID取得审批人列表
	 * @param obj
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByEmpID(Object obj) ;
	/**
	 * 根据是否有针对部门取得审批人列表
	 * @param obj
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByDeptID(Object obj)  ;
	/**
	 * 无特殊设置取得审批人列表
	 * @param obj
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public List getAffirmorListByNormal(Object obj) ;
	/**
	 * 取加班长度
	 * @param obj
	 * @return 
	 */ 
	public double getOTlength(Object obj) ;
	/**
	 * 取工时长度
	 * @param obj
	 * @return 
	 */ 
	public double getEmpWhTotalInfo(Object obj) ; 
	/**
	 * 取工时项目
	 * @param obj
	 * @return 
	 */ 
	@SuppressWarnings("rawtypes")
	public List<Map> getEmpWhItemInfo(Object obj) ; 
	/**
	 * 取休假长度
	 * @param obj
	 * @return 
	 */ 
	public double getEmpLeavlTotalInfo(Object obj) ;
	/**
	 * 取休假长度
	 * @param obj
	 * @return 
	 */ 
	public double getLeavelength(Object obj) ;
	
	/**
	 * 取出休日和节日加班的时数
	 */
	public double getVocationOTLength(Object obj);
	
	/**
	 * 取出已生效的倒休假
	 * @param obj
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getActiveCompensationLeave(Object obj);
	
	@SuppressWarnings("rawtypes")
	public String addProInfo(List objList) ;
	
	public String addProInfo(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public String addProMemberInfo(List objList) ;
	@SuppressWarnings("rawtypes")
	public String updateProMemberInfo(List objList) ;
	
	@SuppressWarnings("rawtypes")
	public String updateProInfo(List objList) ;

	@SuppressWarnings("rawtypes")
	public Map saveWorkingHoursInfo(List objList) ; 
	
	@SuppressWarnings("rawtypes")
	public Map updateWorkingHoursInfo(List objList) ;
	
	public boolean isWhManager(Object obj) ;
	
	public Map addToolApp(Object object);
	
	public Map addToolAppAss(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getToolLoan(Object object);
	
	public Map updateWorkingHoursInfoB(Object object);
	/**
	 * 电焊、装配工人报工申请
	 * @param object
	 * @return
	 */
	public Map saveWorkingHoursInfoB(Object object);
	/**
	 * 下料工人报工申请
	 * @param object
	 * @return
	 */
	public String saveWorkingHoursInfoOther(Object object);
	public Object getWhDetail(Object object);
	
	public String getDeptLeaderId(Object obj);
	
	public String getUpperDeptLeaderId(Object obj);
	
	public String getChineseNameById(Object obj);
	
	public String getBusiTripDestination(Object obj);
	
	public String getToolName(Object obj);
	
	public String getCodeNameByCodeId(Object obj);
	
	public String getPositionByCodeId(Object obj);
	
	public String getdeptNameByCodeId(Object obj);
	
	/**
	 * 添加生产订单
	 * @param object
	 * @return
	 */
	public String addProductionOrderInfo(Object object);
	/**
	 * 添加生产订单
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String addProductionOrderInfo(List objList);
	/**
	 * 修改项目下生产订单信息
	 * @param objList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String updateProductionOrderInfo(List objList) ;
	/**
	 * 删除项目下生产订单信息
	 * @param objList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String deleteProductionOrderInfo(List objList) ;
    @SuppressWarnings("rawtypes")
    public List getAllEmpidList(Object object);
    @SuppressWarnings("rawtypes")
    public List getPersonHwConclusionList(Object object);
    @SuppressWarnings("rawtypes")
    public void addWhConclusion(List list);
    @SuppressWarnings("rawtypes")
    public List getWhConclusionList(Object object);
    public int getWhConclusionListCnt(Object object);
    @SuppressWarnings("rawtypes")
    public List getWhConclusionListSum(Object object);

}
