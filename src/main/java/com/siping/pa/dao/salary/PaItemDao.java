package com.siping.pa.dao.salary;

import java.util.List;

public interface PaItemDao {

	public Object getPaItemObjectInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaItemInfo(Object object);

	public int getPaItemInfoCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getPaItemInfo(Object object, int currentPage, int pageSize);

	@SuppressWarnings("rawtypes")
	public String addPaItemInfo(List objList);

	@SuppressWarnings("rawtypes")
	public String updatePaItemInfo(List objList);

	public int checkDeletePaItemInfo(Object object);

	public String deletePaItemInfo(Object object);

	@SuppressWarnings("rawtypes")
	public String updatePaItemInfoCalOrder(List list);

}
