package com.siping.eva.dao;

import java.util.List;  

public interface BasicInfoDao {

	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodInfo(Object object);
	 
	public int getEvaPeriodInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaPeriodInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaPeriodInfo(List objectList);
	
	public int deleteEvaPeriodInfo(Object objectList);

	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeInfo(Object object);
	 
	public int getEvaPeriodTypeInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaPeriodTypeInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaPeriodTypeInfo(List objectList);
	
	public int deleteEvaPeriodTypeInfo(Object objectList);

	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeItemInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaPeriodTypeItemInfo(Object object);
	 
	public int getEvaPeriodTypeItemInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaPeriodTypeItemInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaPeriodTypeItemInfo(List objectList);
	
	public int deleteEvaPeriodTypeItemInfo(Object objectList);


	@SuppressWarnings({ "rawtypes" })
	public List getEvaTypeProcessInfo(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getEvaTypeProcessInfo(Object object);
	 
	public int getEvaTypeProcessInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public int addEvaTypeProcessInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaTypeProcessInfo(List objectList);

	@SuppressWarnings("rawtypes")
	public int updateEvaTypeProcessOrderInfo(List objectList);
	
	public int deleteEvaTypeProcessInfo(Object objectList);
}
