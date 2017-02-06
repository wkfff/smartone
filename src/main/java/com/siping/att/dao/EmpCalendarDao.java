package com.siping.att.dao;

import java.util.List;

public interface EmpCalendarDao {
 
	@SuppressWarnings("rawtypes")
	public List getEmpCalendarList(Object object);
  
	public int deleteEmpCalendarInfo(Object object);

	public int getEmpCalendarInfo(Object object);

	public int insertEmpCalendarInfo(Object object);

}
