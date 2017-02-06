package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityMatInfoSer {
	
	@SuppressWarnings({ "rawtypes" })
	public List getMaterialList(HttpServletRequest request);
	
	public int getMaterialListCnt(HttpServletRequest request);
	
}
