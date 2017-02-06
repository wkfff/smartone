package com.siping.eva.service;

import java.sql.SQLException;
import java.util.List;  
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface KPISer {
 
	/**
	 * 计划
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEvaKPIInfo(HttpServletRequest request); 
	
	public Object getKPIScoreDetail(HttpServletRequest request); 
	
	public int getEvaKPIInfoCnt(HttpServletRequest request); 
	 
	public String saveAndUpdateEvaKPIInfo(HttpServletRequest request); 
	 
	public String updateEvaKPIScore(HttpServletRequest request); 
	 
	public String updateEssEmpOngoingWorkInfo(HttpServletRequest request); 
	 
	public int deleteEvaKPIInfo(HttpServletRequest request);  
	/**
	 * 评价项目
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getKPIScoreListByKPI(HttpServletRequest request); 
	 
	public int getKPIScoreListByKPICnt(HttpServletRequest request); 
	
	@SuppressWarnings("rawtypes")
	public List getKPIScoreListByEmployee(HttpServletRequest request); 
	 
	public int getKPIScoreListByEmployeeCnt(HttpServletRequest request);
	
	public String saveAndupdateEvaKPIInfo(HttpServletRequest request); 
	 
	public String addEvaKPIScore(HttpServletRequest request); 
	 
	public String updateEssEmpOngoingItemInfo(HttpServletRequest request); 
	 
	public int deleteEvaEmpItemInfo(HttpServletRequest request);  
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public List getEvaKpiTypeInfo(HttpServletRequest request);
	
	public int getEvaKpiTypeInfoCnt(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfo(HttpServletRequest request);
	
	public int getEvaKpiItemInfoCnt(HttpServletRequest request);
	
	public void addKpiTypeInfo(HttpServletRequest request) throws SQLException;

	public void updateKpiTypeInfo(HttpServletRequest request) throws SQLException;
	
	public int checkDeleteKpiTypeInfo(HttpServletRequest request);

	public String deleteKpiTypeInfo(HttpServletRequest request);
	
	public int addKpiItemInfo(HttpServletRequest request) ;
	
	public String deleteKpiItemInfo(HttpServletRequest request);
	
	public String updateKpiItemInfo(HttpServletRequest request);
	
	public String addKpiBevalidaterInfo(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getKpiItemByMonth(HttpServletRequest request);
	
	public int getKpiItemByMonthCnt(HttpServletRequest request);
	
	public String deleteDistriKpiItemInfo(HttpServletRequest request);
	
	public int checkKpiItemDis(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getKpiItemManager(HttpServletRequest request);
	
	public int getKpiItemManagerCnt(HttpServletRequest request);
	
	public void addKpiManagerInfo(HttpServletRequest request);
	
	public String deleteKpiManagerInfo(HttpServletRequest request);
	
	public String addKpiScoreInfo(HttpServletRequest request);
	
	public void getScoreByExcel(HttpServletRequest request,
			HttpServletResponse response); 
}
