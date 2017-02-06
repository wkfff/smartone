package com.siping.report.ord.dao;

import java.util.LinkedHashMap;
import java.util.List;

public interface OrderInfoReportDao {

	String getOrderReportColumnInfo(Object obj);

	List<String> getOrderReportTitleInfo(Object obj);

	@SuppressWarnings("rawtypes")
	List<LinkedHashMap> getDataInfo(List<String> codeList,Object obj);

}
