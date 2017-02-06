package com.siping.productStorage.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface StorageManageSer {

	public String saveStorage(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getStorageList(HttpServletRequest request);

    public String deleteStorage(HttpServletRequest request);
    
    public int getStorageCount(HttpServletRequest request);
    
    @SuppressWarnings("rawtypes")
	public List getStorageName(HttpServletRequest request);
    @SuppressWarnings("rawtypes")
	public List getStorageProList(HttpServletRequest request);
	public Integer getStorageProListCnt(HttpServletRequest request);
	
	public String moveStorage(HttpServletRequest request);
}
