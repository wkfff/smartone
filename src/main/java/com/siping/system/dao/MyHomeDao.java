package com.siping.system.dao;

import java.util.List;

public interface MyHomeDao {
	@SuppressWarnings({ "rawtypes" })
	public void deleteModel(List list);

	@SuppressWarnings({ "rawtypes" })
	public void insertModel(List list);

	@SuppressWarnings({ "rawtypes" })
	public List getModel(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getHomePurview(Object object);

	public Object getHomePage(Object object);

	public void updateApp(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getApp(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getApp(Object object, int currentPage, int pageSize);
	
	public int getAppCnt(Object object);
	
	public void deletePage(Object object);

	public void updatePage(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getSyMenu(Object object);

	@SuppressWarnings({ "rawtypes" })
	public void deleteShort(List list);

	@SuppressWarnings({ "rawtypes" })
	public void insertShort(List list);

	@SuppressWarnings({ "rawtypes" })
	public List getShort(Object object);
	@SuppressWarnings({ "rawtypes" })
	public List getShortInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getShort(Object object, int currentPage, int pageSize);
	
	public int getShortCnt(Object object);
	
	public int addShortcutInfo(Object object);
	
	public int deleteShortcutInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getTipsMenu(Object object);

	public int getTipsCnt(String sm, Object object);
}
