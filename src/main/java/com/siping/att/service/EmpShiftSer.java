package com.siping.att.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface EmpShiftSer {
	 
    @SuppressWarnings({ "rawtypes" })
	public List getShift010();
 
	public int addEmpShift(HttpServletRequest request); 

    @SuppressWarnings({ "rawtypes" })
	public List getShiftSelectedInfo(HttpServletRequest request);
    
    @SuppressWarnings({ "rawtypes" })
	public List getSchedulingEmpInfo(HttpServletRequest request);
    
   	public int getSchedulingEmpInfoCnt(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
	public List getEmpShiftDetailInfo(HttpServletRequest request);
    
   	public int getEmpShiftDetailInfoCnt(HttpServletRequest request);
    
   	public int addShiftedInfo(HttpServletRequest request);
    
   	public int deleteShiftedInfo(HttpServletRequest request);
    
   	public int upShiftedInfo(HttpServletRequest request);
    
   	public int downShiftedInfo(HttpServletRequest request);
   	
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
}
