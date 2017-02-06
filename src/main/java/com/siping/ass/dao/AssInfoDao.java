package com.siping.ass.dao;

import java.util.List;

public interface AssInfoDao {
	 
	@SuppressWarnings({ "rawtypes" })
	public List getAssetList(Object object);

	public int getAssetListCnt(Object object);

	public Object getBasicInfo(Object object);

	public Object getAssetDetail(Object object);
	    
	@SuppressWarnings("rawtypes")
	public List getBorrowRecord(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getBorrowRecordList(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getBorrowRecordList(Object object);
	
	public int getBorrowRecordListCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getAssBrokenSelectList(Object object);
	
	@SuppressWarnings("rawtypes")
	public void assReturnUpdate(List objectList);
 
}
