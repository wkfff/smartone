package com.siping.system.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface MyHomeSer {
	public void updateModel(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public List getModel(HttpServletRequest request);

	public Object getHomePurview(HttpServletRequest request);

	public Object getHomePage(HttpServletRequest request);

	public void updateApp(HttpServletRequest request);
	/**
	 * 主页提示信息
	 * @param request
	 * @return 
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getApp(HttpServletRequest request);
 
	public int getAppCnt(HttpServletRequest request);
	
	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenu(HttpServletRequest request);

	public Object getTips(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public List getAffirmInfo(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public List getConfirmInfo(HttpServletRequest request);

	@SuppressWarnings({ "rawtypes" })
	public List getPerViewInfo(HttpServletRequest request);
	

	/**
	 * 获取快捷方式信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getShort(HttpServletRequest request) ;
	@SuppressWarnings("rawtypes")
	public List getShortInfo(HttpServletRequest request) ;
	
	public String getShortcutsInfo(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public Map getLoginUserAppInfo(HttpServletRequest request) ;
	
	public int getShortCnt(HttpServletRequest request) ;
	 
	public int addShortcutInfo(HttpServletRequest request) ;
	 
	public int deleteShortcutInfo(HttpServletRequest request) ;

	/**
	 * 获取生日信息
	 * @param request
	 * @return
	 */ 
	
}
