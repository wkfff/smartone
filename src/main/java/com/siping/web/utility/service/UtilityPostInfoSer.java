package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityPostInfoSer {
	@SuppressWarnings({ "rawtypes" })
	public List getPostInfoList(HttpServletRequest request) ;
	 
	public int getPostInfoCnt(HttpServletRequest request);
}
