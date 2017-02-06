package com.siping.report.pa.service.bonus;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface BonusExcelSer {
  
	public void viewBonusResultReport(HttpServletRequest request,
			HttpServletResponse response);
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	 
	public List<String> getBonusTitleInfo(HttpServletRequest request) ;
	 
}
