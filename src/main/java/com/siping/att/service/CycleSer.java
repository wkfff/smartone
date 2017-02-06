package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CycleSer {
 
	public Object getCycleInfo(HttpServletRequest request) ;

    @SuppressWarnings({ "rawtypes" })
	public List getCycleInfoList(HttpServletRequest request) ;
	 
	public int getCycleInfoCnt(HttpServletRequest request) ;
	 
	public int addCycleInfo(HttpServletRequest request) ;
	 
	public int updateCycleInfo(HttpServletRequest request) ;
	 
	public int deleteCycleInfo(HttpServletRequest request) ;
}
