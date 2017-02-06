package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface AttMonthSer {

    @SuppressWarnings({ "rawtypes" })
	public List getAttColumns(HttpServletRequest request) ; 

    @SuppressWarnings({ "rawtypes" })
    public List getAttMonthInfo(HttpServletRequest request) ;
	 
	public int getAttMonthInfoCnt(HttpServletRequest request);
	   
	public int updateAttMonthInfo(HttpServletRequest request);

}
