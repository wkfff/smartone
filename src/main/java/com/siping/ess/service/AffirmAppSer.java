package com.siping.ess.service;
 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
 

public interface AffirmAppSer {

	 
	/**
	 * 加班信息申请审批
	 * @param request
	 * @return
	 * @
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmOtInfo(HttpServletRequest request);
	/**
	 * 休假信息申请审批
	 * @param request
	 * @return
	 * @
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmLeaveInfo(HttpServletRequest request);
	/**
	 * 休假信息申请审批
	 * @param request
	 * @return
	 * @
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmCardtimeInfo(HttpServletRequest request);
	/**
	 * 费用信息申请审批
	 * @param request
	 * @return
	 * @
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmExpInfo(HttpServletRequest request);
	/**
	 * 出差信息申请审批
	 * @param request
	 * @return
	 * @
	 */
	@SuppressWarnings({ "rawtypes" }) 
	public Map getAffirmBTInfo(HttpServletRequest request);
	
	/**
	 * 信息审核
	 * @param request
	 */
	public String affirmApp(HttpServletRequest request);
	
}
