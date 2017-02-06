package com.siping.eva.service;

import java.util.List;  
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface BasicInfoSer {
 
	/**
	 * 评价期间
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaPeriodInfo(HttpServletRequest request); 
	 
	public int getEvaPeriodInfoCnt(HttpServletRequest request); 
	 
	public String saveAndUpdateEvaPeriodInfo(HttpServletRequest request); 
	 
	public int deleteEvaPeriodInfo(HttpServletRequest request); 
	/**
	 * 评价类型
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaPeriodTypeInfo(HttpServletRequest request); 
	 
	public int getEvaPeriodTypeInfoCnt(HttpServletRequest request);
	 
	public String saveAndUpdateEvaPeriodTypeInfo(HttpServletRequest request); 
	 
	public int deleteEvaPeriodTypeInfo(HttpServletRequest request);  
	/**
	 * 评价项目
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaPeriodTypeItemInfo(HttpServletRequest request); 
	 
	public int getEvaPeriodTypeItemInfoCnt(HttpServletRequest request);
	 
	public String saveAndUpdateEvaPeriodTypeItemInfo(HttpServletRequest request); 
	 
	public int deleteEvaPeriodTypeItemInfo(HttpServletRequest request);  
	/**
	 * 评价类型流程
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaTypeProcessInfo(HttpServletRequest request); 
	 
	public int getEvaTypeProcessInfoCnt(HttpServletRequest request);
	 
	public String saveAndUpdateEvaTypeProcessInfo(HttpServletRequest request); 
	 
	public int deleteEvaTypeProcessInfo(HttpServletRequest request); 
	 
	public String updateEvaTypeProcessOrderInfo(HttpServletRequest request); 
	
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
}
