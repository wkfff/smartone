package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityDeptInfoSer {  
	/**
	 * 获取部门下拉菜单
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptSelectList(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getDeptTreeInfo(HttpServletRequest request);
	
	/** 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDepartmentInfoList(HttpServletRequest request) ;
	/** 
	 * @param request
	 * @return
	 */
	public int getDepartmentInfoListCnt(HttpServletRequest request) ;
	
}
