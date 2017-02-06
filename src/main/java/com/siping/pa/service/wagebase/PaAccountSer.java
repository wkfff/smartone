package com.siping.pa.service.wagebase;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface PaAccountSer {
	 
	@SuppressWarnings("rawtypes")
	public List getPaAccountInfo(HttpServletRequest request) ;
	 
	public int getPaAccountInfoCnt(HttpServletRequest request);
	 
	public String updatePaAccountInfo(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public List getPaWhInfoList(HttpServletRequest request);
	
	public int getPaWhInfoListCnt(HttpServletRequest request);
}
