package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.SystemMenuDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemMenuDaoImpl extends SqlMapClientSupport implements SystemMenuDao {
	 
	/**
	 * 取得所有系统菜单列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.menu.getSystemMenuInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 取得所有系统菜单列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.menu.getSystemMenuInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	/**
	 * 取得所有系统菜单列表
	 * @param List
	 * @return
	 */
	public int getSystemMenuInfoCnt(Object obj) {
		int returnInt = 0 ; 
		try {
			returnInt = 
				NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.menu.getSystemMenuInfoCnt", obj)), Integer.class) ;
			
		} catch (SQLException e) {			
			e.printStackTrace();
		} 
		return returnInt ;
	}
}
