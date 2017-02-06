package com.siping.hrm.service;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface ContractInfoSer {
	@SuppressWarnings({ "rawtypes" })
	public List getContractInfoList(HttpServletRequest request) ;
 
	public int getContractInfoCnt(HttpServletRequest request) ;  
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	@SuppressWarnings({ "rawtypes" })
	public List getAddContractInfoList(HttpServletRequest request);
	 
	public int getAddContractInfoCnt(HttpServletRequest request) ;

	@SuppressWarnings({ "rawtypes" })
	public List getExpiredContractInfoList(HttpServletRequest request);
	 
	public int getExpiredContractInfoCnt(HttpServletRequest request) ;
	  
	public String addContractInfo(HttpServletRequest request);
	
	public void downContract(HttpServletRequest request, HttpServletResponse response) throws IOException;
	  
	public String updateContractInfo(HttpServletRequest request);
	
    public String deleteContractInfoInfo(HttpServletRequest request);
	
	public String updateExpiredContract(List<LinkedHashMap<String, Object>> list)throws Exception;
}
