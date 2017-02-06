package com.siping.ass.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AssInfoSer {
	@SuppressWarnings({ "rawtypes" })
	public List getAssetList(HttpServletRequest request);
	
	public int getAssetListCnt(HttpServletRequest request);
	
	public Object getBasicInfo(HttpServletRequest request);

	public Object getAssetDetail(HttpServletRequest request); 
	   
	@SuppressWarnings("rawtypes")
	public List getBorrowRecord(HttpServletRequest request);
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	
	@SuppressWarnings({ "rawtypes" })
	public List getBorrowRecordList(HttpServletRequest request);
	
	public int getBorrowRecordListCnt(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getAssBrokenSelectList(HttpServletRequest request);
	
	public String assReturnUpdate(HttpServletRequest request);
}
