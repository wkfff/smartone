package com.siping.report.att.dao.monthly;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface AttInfoReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);
	 
	public List<String> getAttInfoTitleInfo(Object obj); 
	
	public String getAttInfoColumnInfo(Object obj); 
	
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);
}
