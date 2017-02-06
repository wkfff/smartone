package com.siping.system.service;

import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SystemPageStructureSer {

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructure(HttpServletRequest request);
	   
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(HttpServletRequest request);

	public int getPageStructureDetailItemInfoCnt(HttpServletRequest request);

	public int addPageStructureDetailInfo(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailInfo(HttpServletRequest request);

	public int getPageStructureDetailInfoCnt(HttpServletRequest request);

	public int deletePageStructureDetailInfo(HttpServletRequest request); 

	
	public int updatePageStructureDetailInfoOrder(HttpServletRequest request);
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
}
