package com.siping.report.hrm.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface HrEmpInfoReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);
	 
	public List<String> getEmpInfoTitleInfo(Object obj); 
	
	public String getEmpInfoColumnInfo(Object obj); 
	
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);
}
