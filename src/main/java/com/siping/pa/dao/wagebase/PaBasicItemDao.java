package com.siping.pa.dao.wagebase;

import java.sql.SQLException;
import java.util.List;

public interface PaBasicItemDao {

	public Object getPaBasicItemObjectInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(Object object);

	public int getPaBasicItemInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(Object object, int currentPage, int pageSize);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataInfo(Object object);

	public int getPaBasicItemDataInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataInfo(Object object, int currentPage,
			int pageSize);

	@SuppressWarnings("rawtypes")
	public void addPaBasicItemInfo(List objectList) throws SQLException;

	@SuppressWarnings("rawtypes")
	public void updatePaBasicItemInfo(List objectList) throws SQLException;

	public int checkDeletePaBasicItemInfo(Object object);

	public String deletePaBasicItemInfo(Object object);

	@SuppressWarnings("rawtypes")
	public String deletePaBasicItemDataInfo(List deleteList);
	
	@SuppressWarnings("rawtypes")
	public String updatePaBasicItemDataInfo(List list);

	public String initializePaBasicItemDataInfo(Object object);

	@SuppressWarnings("rawtypes")
	public String addPaBasicItemDataInfo(List list);
	/**
	 * 任务修改基础项目数据状态
	 * @return
	 */
	public String updatePaBasicItemDataActivityInfo();

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataEmpInfo(Object object);

	public int getPaBasicItemDataEmpInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataEmpInfo(Object object, int currentPage,
			int pageSize);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataOtherInfo(Object object);

	public int getPaBasicItemDataOtherInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataOtherInfo(Object object, int currentPage,
			int pageSize);
}
