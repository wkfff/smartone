package com.siping.hrm.dao;

import java.sql.SQLException;
import java.util.List;

public interface InfoStatisticsDao {
	
	public String[] getOptions(Object object );
	
	@SuppressWarnings("rawtypes")
	public List getTitles(Object obj) ;
	
	public boolean createTmpPersonalInfo(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateTmpPersonalTitles(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateTmpPersonalInfo(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getColumnList(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getTmpInfoList() throws Exception;
	
	public void modifyTmpTable() throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getUpdateList(Object obj) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getEmpInsertList(Object obj) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void insertHire(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateHire(List list) throws SQLException;
	
	/*info statistical*/
	@SuppressWarnings({ "rawtypes" })
	public List getInfoTypeList(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getInfoTableList(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getInfoFieldList(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getFieldInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getFieldTableInfo(Object object);
	
	public int getFieldInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getFieldInfo(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings({ "rawtypes" })
	public List getDataInfo(Object object);
	 
	public int getDataInfoCnt(Object object);
	 
	@SuppressWarnings("rawtypes")
	public List getDataInfo(Object object, int currentPage, int pageSize);
	 
	public int deleteFieldInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public int deleteFieldInfo(List delList);
	 
	public int addFieldInfo(Object object);
	
	@SuppressWarnings("rawtypes")
	public String addCertificateInfo(List insertList);
	/**
	 * 将培训记录插入表中
	 * @param insertList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String addTrainingInfo(List insertList);
}
