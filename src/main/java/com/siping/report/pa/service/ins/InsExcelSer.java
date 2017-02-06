package com.siping.report.pa.service.ins;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface InsExcelSer {

	public void viewInsResultReport(HttpServletRequest request,
			HttpServletResponse response); 
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	 
	public List<String> getInsTitleInfo(HttpServletRequest request) ;
	 
}
