package com.siping.report.att.service.monthly;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AttInfoExcelSer {

	public void viewAttInfoReport(HttpServletRequest request,
			HttpServletResponse response); 
	 
	public List<String> getAttInfoTitleInfo(HttpServletRequest request) ;
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	 
}
