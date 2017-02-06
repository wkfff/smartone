package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityProdInfoSer {
	
	@SuppressWarnings({ "rawtypes" })
	public List getProductList(HttpServletRequest request);
	
	public int getProductListCnt(HttpServletRequest request);
	
}
