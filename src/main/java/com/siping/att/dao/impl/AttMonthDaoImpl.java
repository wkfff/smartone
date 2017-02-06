package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMonthDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMonthDaoImpl extends SqlMapClientSupport implements AttMonthDao {

	@SuppressWarnings("rawtypes")
	@Override
	public List getAttColumns(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMonth.getAttColumns",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getAttSqlColumns(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMonth.getAttSqlColumns",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	
	@SuppressWarnings("rawtypes")
	public List getAttMonthInfo(Object object) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList("att.attMonth.getAttMonthInfo",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getAttMonthInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMonth.getAttMonthInfo",
					obj, currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getAttMonthInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.attMonth.getAttMonthInfoCnt", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	public int updateAttMonthInfo(Object object) {

		try {
			this.update("att.attMonth.updateAttMonthInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

}
