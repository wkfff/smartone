package com.siping.report.hrm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

public interface HrReportSer {
	@SuppressWarnings({ "rawtypes" })
	public Map viewReport(HttpServletRequest request);	
 
	public String viewReportChart(HttpServletRequest request) throws Exception;	
	/**
	 * 将每个部门的定编信息通过Excel导出
	 */
	public void getDeptQuotaByExcel(HttpServletRequest request,
			HttpServletResponse response); 
	/**
	 * 获取员工的证书信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationInfoList(HttpServletRequest request);
	/**
	 * 获取员工证书信息的记录数
	 * @param request
	 * @return
	 */
	public int getEmpQualificationInfoCnt(HttpServletRequest request) ;
	/**
	 * 获取员工证书详细信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationDetailList(HttpServletRequest request);
	/**
	 * 获取员工证书详细信息记录数
	 * @param request
	 * @return
	 */
	public int getEmpQualificationDetailCnt(HttpServletRequest request) ;
	/**
	 * 将搜索后的证件台账信息通过Excel导出
	 */
	public void getEmpQualificationInfoByExcel(HttpServletRequest request,
			HttpServletResponse response);

    public List getMenList(HttpServletRequest request);

    public int getMenCnt(HttpServletRequest request);

    public List getToolItemSelectList(HttpServletRequest request);

    public void getMenListByExcel(HttpServletRequest request, HttpServletResponse response);
}
