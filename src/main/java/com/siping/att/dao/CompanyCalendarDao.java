package com.siping.att.dao;

import java.util.List;

public interface CompanyCalendarDao {
	 
	public Object getCompanyCalendar(Object obj) ;
	
	@SuppressWarnings("rawtypes")
	public List getCompanyCalendarInfo(Object object);
	 
	public int addCompanyCalendarInfo(Object object);
	 
	public int updateCompanyCalendarInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public int updateCompanyCalendarInfo(List list);
}
