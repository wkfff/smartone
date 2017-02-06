package com.siping.pa.service.wagebase;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PaBasicItemSer {
	public Object getPaBasicItemObjectInfo(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(HttpServletRequest request) ;
	
	public int getPaBasicItemInfoCnt(HttpServletRequest request);
	 
	public void addPaBasicItemInfo(HttpServletRequest request) throws SQLException;
	
	public void updatePaBasicItemInfo(HttpServletRequest request) throws SQLException;
	
	public int checkDeletePaBasicItemInfo(HttpServletRequest request) ;
	
	public String deletePaBasicItemInfo(HttpServletRequest request);
	
	public String deletePaBasicItemDataInfo(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataInfo(HttpServletRequest request);
	
	public int getPaBasicItemDataInfoCnt(HttpServletRequest request);
	 
	public String initializePaBasicItemDataInfo(HttpServletRequest request) ;
	 
	public String updatePaBasicItemDataInfo(HttpServletRequest request);
	  
	public String addPaBasicItemDataInfo(HttpServletRequest request);
	/**
	 * 任务修改基础项目数据状态
	 * @return
	 */
	public int updatePaBasicItemDataActivityInfo() ;
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataEmpInfo(HttpServletRequest request) ;
	 
	public int getPaBasicItemDataEmpInfoCnt(HttpServletRequest request);
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataOtherInfo(HttpServletRequest request) ;
	 
	public int getPaBasicItemDataOtherInfoCnt(HttpServletRequest request);
}
