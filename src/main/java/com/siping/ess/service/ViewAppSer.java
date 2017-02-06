package com.siping.ess.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface ViewAppSer {

	/**
	 * 个人信息申请
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getPersonalInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getPersonalInfoList(HttpServletRequest request);

	public int getPersonalInfoListCnt(HttpServletRequest request) ;
	/**
	 * 项目信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getProInfo(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getProInfoByReim(HttpServletRequest request);

	public int getProInfoCnt(HttpServletRequest request) ;
	@SuppressWarnings({ "rawtypes" })
	public List getProMemberInfo(HttpServletRequest request);

	public int getProMemberInfoCnt(HttpServletRequest request) ;
	@SuppressWarnings({ "rawtypes" })
	public List getWorkingHoursInfo(HttpServletRequest request);

	public int getWorkingHoursInfoCnt(HttpServletRequest request) ;
	@SuppressWarnings({ "rawtypes" })
	public List getWhInfo(HttpServletRequest request);

	public int getWhInfoCnt(HttpServletRequest request) ;
	
	/**
	 * 加班信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */ 
	@SuppressWarnings("rawtypes")
	public List getOtInfo(HttpServletRequest request);

	public int getOtInfoCnt(HttpServletRequest request) ;

	/**
	 * 休假信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public List getLeaveInfo(HttpServletRequest request);

	public int getLeaveInfoCnt(HttpServletRequest request) ; 

	/**
	 * 漏卡信息查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public List getCardtimeInfo(HttpServletRequest request);

	public int getCardtimeInfoCnt(HttpServletRequest request) ;  
	/**
	 * 漏卡信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public List getCardtimeAttInfo(HttpServletRequest request);

	public int getCardtimeAttInfoCnt(HttpServletRequest request) ;  
	/**
	 * 休假信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public List getExpInfo(HttpServletRequest request);

	public int getExpInfoCnt(HttpServletRequest request) ; 
	/**
	 * 费用信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings("rawtypes")
	public List getExpDetailInfo(HttpServletRequest request);

	public int getExpDetailInfoCnt(HttpServletRequest request) ; 
	
	public String delExpDetailInfo(HttpServletRequest request);
	
	/**
	 * 出差信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */ 
	@SuppressWarnings("rawtypes")
	public List getBTInfo(HttpServletRequest request);

	public int getBTInfoCnt(HttpServletRequest request) ; 

	/**
	 * 培训信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getEmpTrainingAppView(HttpServletRequest request);
  
	/**
	 * 教育信息申请查看
	 * 
	 * @param request
	 * @return
	 * 
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getEmpEtnAppView(HttpServletRequest request);
	
	public String cancelApp(HttpServletRequest request);
	
	public String cancelWhApp(HttpServletRequest request);
	/**
	 * 恢复取消的申请
	 * @param request
	 * @return
	 */
	public String recoverCancel(HttpServletRequest request);
	
	public String delProInfo(HttpServletRequest request);
	
	public String delProMemberInfo(HttpServletRequest request);
	
	public String delWorkingHoursInfo(HttpServletRequest request);
 
	/**
	 * 审批状态查询
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getAffirmorList(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getEmpLeaveDetailInfo(HttpServletRequest request);

	public int getEmpLeaveDetailInfoCnt(HttpServletRequest request);
	
	/**
	 * 物品申请查看
	 */
	@SuppressWarnings("rawtypes")
	public List getToolInfo(HttpServletRequest request);

	public int getToolInfoCnt(HttpServletRequest request);
	
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	/**
	 * 查看项目的生产订单信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getProductionOrderInfo(HttpServletRequest request);
	/**
	 * 项目的生产订单信息的记录数
	 * @param request
	 * @return
	 */
	public int getProductionOrderInfoCnt(HttpServletRequest request) ;
}
