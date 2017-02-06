package com.siping.report.pa.dao.bonus;

import java.util.LinkedHashMap;
import java.util.List; 
import java.util.Map;

public interface BonusResultReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> list,Object obj);
	 
	public List<String> getBonusTitleInfo(Object obj); 

	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);
}
