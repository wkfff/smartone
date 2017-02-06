package com.siping.productStorage.dao;

import java.util.List;
import java.util.Map;


public interface StorageManageDao {

	String addNewStorage(Object paramObj);

	@SuppressWarnings("rawtypes")
	List getStorageList(Map paramMap);

	@SuppressWarnings("rawtypes")
	List getStorageList(Map paramMap, int currentPage, int pagesize);

    String deleteStorage(Object param);

    String updateStorage(Object param);
    
    @SuppressWarnings("rawtypes")
	List getStorageName(Map paramMap);
    
    int getStorageCount(Object obj);

    int getProductCountInStorage(Object obj);
    
    @SuppressWarnings("rawtypes")
	List getStorageProList(Map paramMap, int currentPage, int pagesize);
    @SuppressWarnings("rawtypes")
	Integer getStorageProListCnt(Map paramMap);
    
    public String moveStorage(Object param);
    
    public int checkStorageId(Object param);
}
