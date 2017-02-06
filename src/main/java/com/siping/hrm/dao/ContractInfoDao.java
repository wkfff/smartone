package com.siping.hrm.dao;

import java.util.List;

public interface ContractInfoDao {
	@SuppressWarnings({ "rawtypes" })
	public List getContractInfoList(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getContractInfoList(Object object, int currentPage,
			int pageSize);
 
	public int getContractInfoCnt(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getAddContractInfoList(Object object, int currentPage,
			int pageSize);

	@SuppressWarnings({ "rawtypes" })
	public List getAddContractInfoList(Object object);
	 
	public int getAddContractInfoCnt(Object object);
  
	@SuppressWarnings({ "rawtypes" })
	public List getExpiredContractInfoList(Object object, int currentPage,
			int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getExpiredContractInfoList(Object object);
	 
	public int getExpiredContractInfoCnt(Object object);
    
	@SuppressWarnings("rawtypes")
	public String addContractInfo(List objList);
	@SuppressWarnings("rawtypes")
	public void generateWord(java.util.Map map, String inputDoc, String outputDoc);
	@SuppressWarnings("rawtypes")
	public java.util.Map getContractInfo(Object object);
	@SuppressWarnings("rawtypes")
	public String updateContractInfo(List objList);
	
	public String deleteContractInfoInfo(Object object);
	
	public void saveExpiredContract(Object object);
}
