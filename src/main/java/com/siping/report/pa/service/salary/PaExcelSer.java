package com.siping.report.pa.service.salary;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface PaExcelSer {

	public void viewPaResultReport(HttpServletRequest request, HttpServletResponse response); 
	
	public void getExcelSta(HttpServletRequest request, HttpServletResponse response);
	
	public List<String> getPaTitleInfo(HttpServletRequest request) ;
	/** 
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	
	public void viewPaWhDetailReport(HttpServletRequest request,HttpServletResponse response);
	
	public void viewPaWhReport(HttpServletRequest request,HttpServletResponse response);
	
	@SuppressWarnings("rawtypes")
	public List getPaColumns(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getPaReportSta(HttpServletRequest request);
	
	public int getPaReportStaCnt(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
    public List getPaStaDetailList(HttpServletRequest request);

    public int getPaStaDetailCnt(HttpServletRequest request);
}
