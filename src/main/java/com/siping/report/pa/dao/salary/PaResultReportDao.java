package com.siping.report.pa.dao.salary;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface PaResultReportDao {

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasource(List<String> codeList,Object obj);
	
	@SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getPaProjectDatasource(List<String> codeList,Object obj);
	
	@SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getPaProductionDatasource(List<String> codeList,Object obj);
	
	@SuppressWarnings("rawtypes")
    public List<LinkedHashMap> getPaManageDatasource(List<String> codeList,Object obj);
	
	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getDatasourceSta(List<String> codeList,Object obj);
	 
	public List<String> getPaTitleInfo(Object obj); 
	
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list);

	public List<String> getPaWhTitleInfo(Object obj);
	
	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getWhDatasource(List<String> codeList,Object obj);

	@SuppressWarnings("rawtypes")
	public List<LinkedHashMap> getWhSumDatasource(List<String> codeList, Object obj);
	
	@SuppressWarnings("rawtypes")
	public List getPaColumns(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getPaReportSta(LinkedHashMap object);
	
	@SuppressWarnings("rawtypes")
	public int getPaReportStaCnt(LinkedHashMap paramMap);
	
	@SuppressWarnings("rawtypes")
	public List getPaItem();

	@SuppressWarnings("rawtypes")
    public Map getPaProductionTotalDatasource(List<String> codeList,Object obj);

	@SuppressWarnings("rawtypes")
    public List getPaProjectAverageDatasource(List<String> codeList,Object obj);

	@SuppressWarnings("rawtypes")
    public List getPaStaDetailList(Object obj);

    public int getPaStaDetailCnt(Object obj);
}
