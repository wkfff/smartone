package com.siping.eva.dao;

import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.List;  

public interface KPIDao {

	@SuppressWarnings({ "rawtypes" })
	public List getEvaKPIInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaKPIInfo(Object object);
	public int getEvaKPIInfoCnt(Object object);
	
	public Object getKPIScoreDetail(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaEmpWorkInfo(List objectList);
	  
	public int checkEvaEmpEveInfo(Object object);
	  
	public int addEvaEmpEveInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public int updateEvaEmpWorkInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaKPIScore(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEssEmpOngoingWorkInfo(List objectList);
 
	public int updateEssWorkFlagInfo(Object objectList);
	 
	public int updateEssItemFlagInfo(Object objectList);
	 
	public int updateEvaItemFlagInfo(Object objectList);
	
	public int deleteEvaKPIInfo(Object objectList); 

	
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByKPI(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByKPI(Object object, int currentPage, int pageSize);
	public int getKPIScoreListByKPICnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByEmployee(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getKPIScoreListByEmployee(Object object, int currentPage, int pageSize);
	public int getKPIScoreListByEmployeeCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaKPIInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaKPIInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int addEvaKPIScore(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEssEmpOngoingItemInfo(List objectList);
	
	public int deleteEvaEmpItemInfo(Object objectList);
	
	@SuppressWarnings("rawtypes")
	public List getEvaKpiTypeInfo(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getEvaKpiTypeInfo(Object object, int currentPage, int pageSize);
	 
	public int getEvaKpiTypeInfoCnt(Object object);
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfo(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfo(Object object, int currentPage, int pageSize);
	 
	public int getEvaKpiItemInfoCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfoUnused(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfoUnused(Object object, int currentPage, int pageSize);
	 
	public int getEvaKpiItemInfoCntUnused(Object object);

	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfoUnusedManager(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getEvaKpiItemInfoUnusedManager(Object object, int currentPage, int pageSize);
	 
	public int getEvaKpiItemInfoCntUnusedManager(Object object);
	
	@SuppressWarnings("rawtypes")
	public void addKpiTypeInfo(List objList) throws SQLException;

	@SuppressWarnings("rawtypes")
	public void updateKpiTypeInfo(List objList) throws SQLException;
	
	public int checkDeleteKpiTypeInfo(Object object) ;
	
	public String deleteKpiTypeInfo(Object object) throws SQLException ;

	public int addKpiItemInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public String deleteKpiItemInfo(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public String updateKpiItemInfo(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public List getKpiItemByMonth(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getKpiItemByMonth(Object object, int currentPage, int pageSize);
	 
	public int getKpiItemByMonthCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getKpiItemByMonthIsScore(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getKpiItemByMonthIsScore(Object object, int currentPage, int pageSize);
	 
	public int getKpiItemByMonthCntIsScore(Object object);
	
	@SuppressWarnings("rawtypes")
	public String addKpiBevalidaterInfo(List objlist);
	
	@SuppressWarnings("rawtypes")
	public String deleteDistriKpiItemInfo(List objlist) ;
	
	public int checkKpiItemDis(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getKpiItemManager(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getKpiItemManager(Object object, int currentPage, int pageSize);
	 
	public int getKpiItemManagerCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public void addKpiManagerInfo(List objList);
	
	@SuppressWarnings("rawtypes")
	public String deleteKpiManagerInfo(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public String addKpiScoreInfo(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDataScoreByExcel(Object obj);
}
