package com.siping.att.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface AttMFormulaSer {
      
	@SuppressWarnings({ "rawtypes" })
	public List getAttMFormulaCnInfo(HttpServletRequest request);


	public Object getAttMFormulaObjectInfo(HttpServletRequest request);
	@SuppressWarnings({ "rawtypes" })
	public List getAttMFormulaInfo(HttpServletRequest request);
 
	public int getAttMFormulaInfoCnt(HttpServletRequest request);
	  
	public int addAttMFormulaInfo(HttpServletRequest request);

	public int updateAttMFormulaInfo(HttpServletRequest request);

	public int deleteAttMFormulaInfo(HttpServletRequest request);

	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
}
