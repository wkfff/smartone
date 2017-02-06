package com.siping.report.pa.dao.ins;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface InsResultReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);
	 
	public List<String> getInsTitleInfo(Object obj); 
	
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);
}
