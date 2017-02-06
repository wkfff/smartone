package com.siping.web.utility.dao;

import java.util.List;

public interface UtilityProdInfoDao {
	@SuppressWarnings({ "rawtypes" })
	public List getProductList(Object object);
	public int getProductListCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getBasicProductList(Object object);
	public int getBasicProductListCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getStorageList(Object object);
	public int getStorageListCnt(Object object);

}
