package com.siping.web.dao;

import java.sql.SQLException;
import java.util.List;


public interface FileUploadDao { 

	public Object uploadPhoto(Object object) throws SQLException;
	
	public Object uploadAssetPic(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateTmpPersonalInfo(List list) throws SQLException;
	
	public void modifyTmpTable() throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getColumnList(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getTmpInfoList(Object object) throws SQLException;
	
	public boolean createTmpPersonalInfo(Object object) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateTmpPersonalTitles(List list) throws SQLException;
	
	public void uploadContractAppendix(Object object) throws SQLException;
	
	public void uploadProductAppendix(Object object) throws SQLException; 
	
	public void uploadCustAppendix(Object object) throws SQLException;
	
	public void saveUploadExcel() throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getTitleList() throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getUpdateList(Object obj) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public List getInsertList(Object obj) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void insertHire(List list) throws SQLException;
	
	@SuppressWarnings("rawtypes")
	public void updateHire(List list) throws SQLException;
	
	public Object uploadProImage(Object object) throws SQLException;
}
