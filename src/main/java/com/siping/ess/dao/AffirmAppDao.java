package com.siping.ess.dao;
 
import java.util.List;
import java.util.Map;

public interface AffirmAppDao {
	
	 
	/**
	 * 加班信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return 
	 */
	@SuppressWarnings("rawtypes")
	public Map getAffirmOtInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmOtInfo(Object object);
	/**
	 * 出差信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAffirmBTInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmBTInfo(Object object); 
	/**
	 * 休假信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAffirmLeaveInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmLeaveInfo(Object object);
	/**
	 * 漏卡信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAffirmCardtimeInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmCardtimeInfo(Object object);
	/**
	 * 费用信息申请查看
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 * @
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getAffirmExpInfo(Object object,int currentPage,int pageSize);
	@SuppressWarnings("rawtypes")
	public Map getAffirmExpInfo(Object object);
	/**
	 * 信息审核
	 * @param objectList
	 * @return 
	 */  
	@SuppressWarnings("rawtypes")
	public String affirmOtApp(List objectList);
	@SuppressWarnings("rawtypes")
	public String affirmLeaveApp(List objectList);
	@SuppressWarnings("rawtypes")
	public String affirmCardtimeApp(List objectList);
	@SuppressWarnings("rawtypes")
	public String affirmBTApp(List objectList);
	@SuppressWarnings("rawtypes")
	public String affirmExpApp(List objectList);
	/**
	 * 是否是最后审批人
	 * @param object
	 * @return
	 * @
	 */
	public boolean isLastAffirm(Object object); 
}
