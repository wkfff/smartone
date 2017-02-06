package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMonInfoDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMonInfoDaoImpl extends SqlMapClientSupport implements AttMonInfoDao {

	@SuppressWarnings("rawtypes")
	@Override
	public List getAttColumns(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMonInfo.getAttColumns",obj);
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
			returnList = this.queryForList("att.attMonInfo.getAttSqlColumns",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}
	
	@SuppressWarnings("rawtypes")
	public List getAttMonInfo(Object object) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList("att.attMonInfo.getAttMonInfo",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getAttMonInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMonInfo.getAttMonInfo",
					obj, currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getAttMonInfoCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.attMonInfo.getAttMonInfoCnt", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}
}
