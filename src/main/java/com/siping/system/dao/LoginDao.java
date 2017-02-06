package com.siping.system.dao;

import java.util.List;

public interface LoginDao {
	/**
	 * 用户登录
	 * @param object 
	 * @return
	 */
	public Object findUser(Object object);
	/**
	 * 获取一级菜单
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getMainMenu(Object object);
	/**
	 * 获取二三级菜单
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getLeftMenu(Object object);
	/**
	 * 加载主页面
	 * @param object
	 * @return
	 */
	public String getMenuLoad(Object object);
	/**
	 * 保存登录信息
	 * @param object
	 */
	public void addLoginInfo(Object object);
	/**
	 * 加载主页面
	 * @param object
	 * @return
	 */
	public String checkFirstLogin(Object object);
}
