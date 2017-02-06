package com.siping.report.ess.dao;

import java.util.LinkedHashMap;
import java.util.List; 

public interface EssInfoReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getWhDataInfo(Object obj);
	  
}
