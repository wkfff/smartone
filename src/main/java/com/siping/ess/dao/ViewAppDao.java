package com.siping.ess.dao;
 
import java.util.List;
import java.util.Map;

public interface ViewAppDao {
	
	 
	/**
	 * 个人信息申请
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * 
	 */ 
	public Object getPersonalInfo(Object object);
	public Object getOldPersonalInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPersonalInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getPersonalInfoList(Object object);
	 
	public int getPersonalInfoListCnt(Object object);

	/**
	 * 项目信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * 
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getProInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getProInfoByReim(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getProInfo(Object object);
	 
	public int getProInfoCnt(Object object);
	public int getProInfoCntByReim(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getProMemberInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getProMemberInfo(Object object);
	 
	public int getProMemberInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWorkingHoursInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWorkingHoursInfo(Object object);
	 
	public int getWorkingHoursInfoCnt(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getWhInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getWhInfo(Object object);
	 
	public int getWhInfoCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getToolInfo(Object object, int currentPage, int pageSize);
	@SuppressWarnings({ "rawtypes" })
	public List getToolInfo(Object object);
	 
	public int getToolInfoCnt(Object object);
	
	/**
	 * 加班信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getOtInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getOtInfo(Object object);
	 
	public int getOtInfoCnt(Object object);
	/**
	 * 教育信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public Map getEmpEtnAppView(Object object,int currentPage,int pageSize);
	/**
	 * 出差信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getBTInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getBTInfo(Object object);
	 
	public int getBTInfoCnt(Object object);  

	/**
	 * 费用信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getExpDetailInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getExpDetailInfo(Object object);
	 
	public int getExpDetailInfoCnt(Object object); 

	public String delExpDetailInfo(Object object);
	/**
	 * 休假信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getLeaveInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getLeaveInfo(Object object);
	 
	public int getLeaveInfoCnt(Object object); 
	/**
	 * 休假信息查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCardtimeInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getCardtimeInfo(Object object);
	 
	public int getCardtimeInfoCnt(Object object); 
	/**
	 * 休假信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getCardtimeAttInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getCardtimeAttInfo(Object object);
	 
	public int getCardtimeAttInfoCnt(Object object); 
	/**
	 * 费用信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getExpInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getExpInfo(Object object);
	 
	public int getExpInfoCnt(Object object); 
	/** 
	 * 培训信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public Map getEmpTrainingAppView(Object object,int currentPage,int pageSize);

	public String delWorkingHoursInfo(Object object);

	public String delProInfo(Object object);

	public String delProMemberInfo(Object object);
	@SuppressWarnings("rawtypes")
	public String delProMemberInfo(List objectList);
	/**
	 * 删除未审核个人信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelPerInfo(List objectList);
	public String RecoverCancelPerInfo(List objectList);
	@SuppressWarnings("rawtypes")
	public String cancelWhInfo(List objectList);
	public String RecoverCancelWhInfo(List objectList);
	/**
	 * 删除未审核加班信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelOtInfo(List objectList);
	/**
	 * 删除未审核休假信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelLeaveInfo(List objectList);
	/**
	 * 删除未审核出差信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelBizInfo(List objectList);
	/**
	 * 删除未审核培训信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelTrainingInfo(List objectList);
	/**
	 * 删除未审核慰问金信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelExpInfo(List objectList);
	/**
	 * 删除未审漏卡信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelCardtimeInfo(List objectList);
	
	/**
	 * 删除未审借用物品信息申请
	 */
	@SuppressWarnings("rawtypes")
	public String cancelToolInfo(List objectList);
	
	/**
	 * 审批状态查询
	 */
	@SuppressWarnings("rawtypes")
	public Map getAffirmorList(Object object );

	/**
	 * 获取个人休假信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getEmpLeaveDetailInfo(Object obj) ; 
	/**
	 * 获取个人休假信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getEmpLeaveDetailInfo(Object object, int currentPage, int pageSize);
	/**
	 * 获取个人休假信息
	 * @param object 
	 * @return
	 */ 
	public int getEmpLeaveDetailInfoCnt(Object object);
	/**
	 * 根据员工ID获取leave_no
	 */
	public List getLeave_noByEmpid(String id);
	/**
	 * 更改审核状态:同意
	 */
	public void updateLeaveAffirmflag_agree(String processInstanceId);
	/**
	 * 更改审核状态：否决
	 */
	public void updateLeaveAffirmflag_veto(String processInstanceId);
	public String RecoverCancelOtInfo(List objectList);
	public String RecoverCancelLeaveInfo(List objectList);
	public String RecoverCancelBizInfo(List objectList);
	public String RecoverCancelTrainingInfo(List objectList);
	public String RecoverCancelExpInfo(List objectList);
	public String RecoverCancelCardtimeInfo(List objectList);
	public String RecoverCancelToolInfo(List objectList);
	/**
	 * 获取项目的生产订单（分页）
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getProductionOrderInfo(Object object, int currentPage,
			int pageSize);
	/**
	 * 获取项目的生产订单
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getProductionOrderInfo(Object object);
	/**
	 * 获取项目生产订单的记录数
	 * @param object
	 * @return
	 */
	public int getProductionOrderInfoCnt(Object object);
}
