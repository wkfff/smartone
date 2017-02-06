package com.siping.eva.dao;

import java.util.List;  

public interface EmpEvaInfoDao {

	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpWorkInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpWorkInfo(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpEveInfo(Object object);
	
	public int getEvaEmpWorkInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaEmpWorkInfo(List objectList);
	  
	public int checkEvaEmpEveInfo(Object object);
	  
	public int addEvaEmpEveInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public int updateEvaEmpWorkInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaEmpOngoingWorkInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEssEmpOngoingWorkInfo(List objectList);
 
	public int updateEssWorkFlagInfo(Object objectList);
	 
	public int updateEssItemFlagInfo(Object objectList);
	 
	public int updateEvaItemFlagInfo(Object objectList);
	
	public int deleteEvaEmpWorkInfo(Object objectList); 
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpItemInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaEmpItemInfo(Object object);
	 
	public int getEvaEmpItemInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaEmpItemInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaEmpItemInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaEmpOngoingItemInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEssEmpOngoingItemInfo(List objectList);
	
	public int deleteEvaEmpItemInfo(Object objectList); 
}
