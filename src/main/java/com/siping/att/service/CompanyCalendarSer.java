package com.siping.att.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface CompanyCalendarSer {
 
	public String getCompanyCalendarInfoHtml(HttpServletRequest request) ;
	
    @SuppressWarnings({ "rawtypes" })
	public List getCompanyCalendarInfo(HttpServletRequest request) ;
	 
	public int addCompanyCalendarInfo(HttpServletRequest request) ;
	 
	public int updateCompanyCalendarInfo(HttpServletRequest request) ;
	
}
