package com.siping.system.dao;

import java.util.List;  

public interface SystemPageStructureDao {
	

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructure(Object object) ;
    
	public int addPageStructureInfo(Object object) ; 
	 
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(Object object) ;

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(Object object,int currentPage, int pageSize);
	 
	public int getPageStructureDetailItemInfoCnt(Object object) ;
	
	 
	@SuppressWarnings("rawtypes")
	public int addPageStructureDetailInfo(List objList) ;
	

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailInfo(Object object) ;

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailInfo(Object object,int currentPage, int pageSize);
	 
	public int getPageStructureDetailInfoCnt(Object object) ;
	 
	public int deletePageStructureDetailInfo(Object object); 
	
	@SuppressWarnings("rawtypes")
	public int updatePageStructureDetailInfoOrder(List objList) ;
	
}
