package com.siping.eva.service;

import java.util.List;  
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EmpEvaInfoSer {
 
	/**
	 * 计划
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaEmpWorkInfo(HttpServletRequest request); 
	
	@SuppressWarnings("rawtypes")
	public List getEvaEmpEveInfo(HttpServletRequest request); 
	
	public int getEvaEmpWorkInfoCnt(HttpServletRequest request); 
	 
	public String saveAndUpdateEvaEmpWorkInfo(HttpServletRequest request); 
	 
	public String updateEvaEmpOngoingWorkInfo(HttpServletRequest request); 
	 
	public String updateEssEmpOngoingWorkInfo(HttpServletRequest request); 
	 
	public int deleteEvaEmpWorkInfo(HttpServletRequest request);  
	/**
	 * 评价项目
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaEmpItemInfo(HttpServletRequest request); 
	 
	public int getEvaEmpItemInfoCnt(HttpServletRequest request); 
	 
	public String saveAndUpdateEvaEmpItemInfo(HttpServletRequest request); 
	 
	public String updateEvaEmpOngoingItemInfo(HttpServletRequest request); 
	 
	public String updateEssEmpOngoingItemInfo(HttpServletRequest request); 
	 
	public int deleteEvaEmpItemInfo(HttpServletRequest request);  
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
}
