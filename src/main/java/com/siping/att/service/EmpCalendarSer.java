package com.siping.att.service;

import javax.servlet.http.HttpServletRequest;

public interface EmpCalendarSer {
	//EmpCalendarSerImp 
	public String getEmpCalendarViewHtml(HttpServletRequest request) ;
 
	public int updateEmpCalendarInfo(HttpServletRequest request) ;

}
