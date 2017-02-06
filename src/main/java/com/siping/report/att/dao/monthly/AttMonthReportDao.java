package com.siping.report.att.dao.monthly;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface AttMonthReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);
	 
	public List<String> getAttMonthTitleInfo(Object obj); 
	
	public String getAttMonthColumnInfo(Object obj); 
	
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);
}
