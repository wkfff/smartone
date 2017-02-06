package com.siping.web.dao.impl;

import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository; 

import com.siping.web.dao.FileUploadDao;
import com.siping.web.utility.SqlMapClientSupport; 

@Repository
public class FileUploadDaoImpl extends SqlMapClientSupport implements FileUploadDao {

	Logger logger = Logger.getLogger(FileUploadDaoImpl.class);

	@Override
	public Object uploadPhoto(Object object) throws SQLException {
		return this.update("upload.uploadInfo.uploadPhoto", object);
		
	}
	
	@Override
	public Object uploadAssetPic(Object object) throws SQLException {
		return this.update("upload.uploadInfo.uploadAssetPic", object);
		
	}
	
	@Override
	public boolean createTmpPersonalInfo(Object object) throws SQLException {
		boolean result = false;
		this.update("upload.uploadInfo.createTmpPersonalInfo", object);
		result = true;
		return result;
	} 
	@SuppressWarnings("rawtypes")
	@Override
	public void updateTmpPersonalInfo(List list) throws SQLException {
		this.updateForList("upload.uploadInfo.updateTmpPersonalInfo", list);
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getColumnList(Object object) throws SQLException {
		return this.queryForList("upload.uploadInfo.getColumnList");
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getTmpInfoList(Object object) throws SQLException {
		List tmpList = this.queryForList("upload.uploadInfo.getTmpInfoList", object);
		return tmpList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public void updateTmpPersonalTitles(List list) throws SQLException {
		this.insertForList("upload.uploadInfo.updateTmpPersonalTitles", list);
		
	}

	@Override
	public void uploadContractAppendix(Object object) throws SQLException {
		this.insert("upload.uploadInfo.uploadContractAppendix", object);
	}
	
	@Override
	public void uploadProductAppendix(Object object) throws SQLException {
		this.insert("upload.uploadInfo.uploadProductAppendix", object);
	}
	
	@Override
	public void uploadCustAppendix(Object object) throws SQLException {
		this.insert("upload.uploadInfo.uploadCustAppendix", object);
	}

	@Override
	public void modifyTmpTable() throws SQLException {
		this.update("upload.uploadInfo.modifyTmpTable");		
	}

	@Override
	public void saveUploadExcel() throws SQLException {
		//Auto-generated method stub
		
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getTitleList() throws SQLException {
		return this.queryForList("upload.uploadInfo.getTitleList");
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getUpdateList(Object obj) throws SQLException {
		return this.queryForList("upload.uploadInfo.getUpdateList",obj);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getInsertList(Object obj) throws SQLException {
		return this.queryForList("upload.uploadInfo.getInsertList",obj);
	}
	
	/**
	 * 保存新员工
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void insertHire(List list) throws SQLException {
		this.insertForList("upload.uploadInfo.insertHire", list);				
	}

	/**
	 * 更新老员工
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void updateHire(List list) throws SQLException {
		this.updateForList("upload.uploadInfo.updateHire", list);				
	}

	@Override
	public Object uploadProImage(Object object) throws SQLException {
		return this.update("upload.uploadInfo.uploadProImage", object);
	}

}
