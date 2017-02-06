package com.siping.web.utility.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface UtilityDocInfoSer {

	@SuppressWarnings("rawtypes")
	List getDocList(HttpServletRequest request);

	int getDocListCnt(HttpServletRequest request);
	
	@SuppressWarnings("rawtypes")
	List getDocTypeList(HttpServletRequest request);

	int getDocTypeListCnt(HttpServletRequest request);

}
