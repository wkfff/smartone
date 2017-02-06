package com.siping.ess.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface PersonInfoSer {
  
	@SuppressWarnings({ "rawtypes" }) 
	public Map getEducationInfoList(HttpServletRequest request)throws Exception;

	@SuppressWarnings({ "rawtypes" }) 
	public Map getEvaluateforList(HttpServletRequest request)throws Exception;
	
}
