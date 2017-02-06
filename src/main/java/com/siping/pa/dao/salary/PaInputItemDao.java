package com.siping.pa.dao.salary;

import java.sql.SQLException;
import java.util.List;

public interface PaInputItemDao {
	
	public Object getPaInputItemObjectInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(Object object); 
	 
	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(Object object, int currentPage, int pageSize);
	 
	public int getPaInputItemInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataEmpInfo(Object object);
	 
	public int getPaInputItemDataEmpInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataEmpInfo(Object object, int currentPage, int pageSize);
		  
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataOtherInfo(Object object);
	 
	public int getPaInputItemDataOtherInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataOtherInfo(Object object, int currentPage, int pageSize);
		
	@SuppressWarnings("rawtypes")
	public void addPaInputItemInfo(List objList) throws SQLException;

	@SuppressWarnings("rawtypes")
	public void updatePaInputItemInfo(List objList) throws SQLException;
	
	public int checkDeletePaInputItemInfo(Object object) ;
	
	public String deletePaInputItemInfo(Object object) throws SQLException ;
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataInfo(Object object);
	 
	public int getPaInputItemDataInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataInfo(Object object, int currentPage, int pageSize);
	 
	public String createPaInputItemInfo(Object obj) ;
	 
	public String createPaInputItemDataInfo(Object object) ;
	 
	@SuppressWarnings("rawtypes")
	public String deletePaInputItemDataInfo(List objlist) ;
	 
	@SuppressWarnings("rawtypes")
	public String updatePaInputItemDataInfo(List objlist) ;
	
	@SuppressWarnings("rawtypes")
	public String addPaInputItemDataInfo(List objlist) ;
	
}
