package com.siping.hrm.service;
 
import java.util.List; 

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface TransferOrderSer {
  
	@SuppressWarnings({ "rawtypes" })
	public List getEmpInfoList(HttpServletRequest request);
	   
	public String getNewestEmpIDInfo(HttpServletRequest request);
	   
	public String checkEmpID(HttpServletRequest request);
	
	public int getEmpInfoCnt(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getEmpActBusinessInfoList(HttpServletRequest request);
	 
	public int getEmpActBusinessInfoCnt(HttpServletRequest request) ;
	  
	/**
	 * 提交发令
	 * @param request
	 */
	public String saveTransferOrder(HttpServletRequest request); 
	/**
	 * 查看调动
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getUpgradeInfoList(HttpServletRequest request);
	 
	public int getUpgradeInfoCnt(HttpServletRequest request) ;
	/**
	 * 查看发令
	 * 晋升 职务变更
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getExpInsideInfoList(HttpServletRequest request);
	 
	public int getExpInsideInfoCnt(HttpServletRequest request) ; 
	/**
	 * 查看担当业务变更
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getActBusinessInfoList(HttpServletRequest request);
	 
	public int getActBusinessInfoCnt(HttpServletRequest request) ; 
	/**
	 * 查看兼职
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getPluralityInfoList(HttpServletRequest request);
	 
	public int getPluralityInfoCnt(HttpServletRequest request) ; 
	/**
	 * 查看派遣
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getDispatchInfoList(HttpServletRequest request);
		 
	public int getDispatchInfoCnt(HttpServletRequest request) ;  
	/**
	 * 查看奖励
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getRewardInfoList(HttpServletRequest request);
		 
	public int getRewardInfoCnt(HttpServletRequest request) ;  
	/**
	 * 查看惩戒
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getPunishmentInfoList(HttpServletRequest request);
		 
	public int getPunishmentInfoCnt(HttpServletRequest request) ;  
	/**
	 * 查看离职
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getResignInfoList(HttpServletRequest request);
		 
	public int getResignInfoCnt(HttpServletRequest request) ;
	/**
	 * 调令取消
	 */
	public String cancelDoc(HttpServletRequest request);
	/**
	 * 恢复调令取消
	 */
	public String recoverCancel(HttpServletRequest request);
	
	/**
	 * 执行调令
	 */
	public void hrUpdateAuto();
	/**
	 * 将每月的职员调动信息通过Excel导出
	 */
	public void getTransferOrderByExcel(HttpServletRequest request,
			HttpServletResponse response); 
	/**
	 * 将每月的职员奖励信息通过Excel导出
	 */
	public void getRewardInfoByExcel(HttpServletRequest request,
			HttpServletResponse response); 
	/**
	 * 将每月的职员惩戒信息通过Excel导出
	 */
	public void getPunishmentInfoByExcel(HttpServletRequest request,
			HttpServletResponse response);  
	/**
	 * 将每月的职员离职信息通过Excel导出
	 */
	public void getResignInfoByExcel(HttpServletRequest request,
			HttpServletResponse response);  
}
