package com.siping.pa.service.salary;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface PaItemSer {
	
	
	public Object getPaItemObjectInfo(HttpServletRequest request) ;
	
	
	@SuppressWarnings("rawtypes")
	public List getPaItemInfo(HttpServletRequest request) ;
	
	
	public int getPaItemInfoCnt(HttpServletRequest request);
	 
	
	public String addPaItemInfo(HttpServletRequest request) throws SQLException;
	
	
	public String updatePaItemInfo(HttpServletRequest request) throws SQLException;
	
	public String deletePaItemInfo(HttpServletRequest request);
	
	
	public String updatePaItemInfoCalOrder(HttpServletRequest request);


	public void downloadPaDataTemplate(HttpServletRequest request,HttpServletResponse response);
	
}
