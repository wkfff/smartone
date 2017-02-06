package com.siping.att.service;
 
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
 

public interface AttMonInfoSer {

    @SuppressWarnings({ "rawtypes" })
	public List getAttColumns(HttpServletRequest request) ; 

    @SuppressWarnings({ "rawtypes" })
    public List getAttMonInfo(HttpServletRequest request) ;
	 
	public int getAttMonInfoCnt(HttpServletRequest request);

	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request);  
}
