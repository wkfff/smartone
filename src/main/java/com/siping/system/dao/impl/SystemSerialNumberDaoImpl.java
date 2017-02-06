package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.SystemSerialNumberDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemSerialNumberDaoImpl extends SqlMapClientSupport implements
SystemSerialNumberDao {
	@SuppressWarnings("rawtypes")
	@Override
	public List getAllSerialNum(Object object) {		
		List returnList = null;
		try {
			returnList = this.queryForList("system.serialNumber.getAllSerialNum", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAllSerialNum(Object object, int currentPage, int pageSize) {		
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("system.serialNumber.getAllSerialNum", object, currentPage,
					pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getAllSerialNumCnt(Object object) {
		int i = 0;
		try {
			i = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("system.serialNumber.getAllSerialNumCnt", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	@Override
	public String addSerialNum(Object object) {
		String result = "Y";
		try {
			this.insert("system.serialNumber.addSerialNum", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}

	@Override
	public String deleteSerialNum(Object object) {
		String result = "Y";
		try {
			this.update("system.serialNumber.deleteSerialNum", object);
		} catch (SQLException e) {			
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}

	@Override
	public String updateSerialNum(Object object) {
		String result = "Y";
		try {
			this.update("system.serialNumber.updateSerialNum", object);
		} catch (SQLException e) {
			e.printStackTrace();
			result = e.getMessage();
		}
		return result;
	}
	
}
