package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.att.dao.CompanyCalendarDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CompanyCalendarDaoImpl extends SqlMapClientSupport implements
		CompanyCalendarDao {

	/**
	 * 取得公司日历信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getCompanyCalendar(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap(); 
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.companyCalendar.getCompanyCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有公司日历信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getCompanyCalendarInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.companyCalendar.getCompanyCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 插入公司日历信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addCompanyCalendarInfo(Object obj) {

		try {
			this.insert("att.companyCalendar.addCompanyCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新公司日历信息
	 * 
	 * @param Object
	 * @return
	 */
	public int updateCompanyCalendarInfo(Object obj) {

		try {
			this.update("att.companyCalendar.updateCompanyCalendarInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	// @Override
	@SuppressWarnings("rawtypes")
	public int updateCompanyCalendarInfo(List list) {
		try {
			this.updateForList(
					"att.companyCalendar.updateCompanyCalendarInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return 0;
	}

	/**
	 * 删除公司日历信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteCompanyCalendarInfo(Object obj) {

		return 0;
	}
}
