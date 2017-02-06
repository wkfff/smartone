package com.siping.report.hrm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface HrEmpInfoExcelSer {

	public void viewEmpInfoReport(HttpServletRequest request,
			HttpServletResponse response); 
	 
	public List<String> getEmpInfoTitleInfo(HttpServletRequest request) ;
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	 
}
