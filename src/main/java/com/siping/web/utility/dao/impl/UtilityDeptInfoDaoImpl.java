package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityDeptInfoDao;

@Repository
public class UtilityDeptInfoDaoImpl extends SqlMapClientSupport implements UtilityDeptInfoDao {

	Logger logger = Logger.getLogger(UtilityDeptInfoDaoImpl.class);

	
	/**
	 * (non-Javadoc)
	 * 
	 * @see com.siping.web.utility.dao.UtilityDao#getDeptSelectList(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getDeptSelectList(Object object) {
		List temp = new ArrayList();
		try {
			temp = this.queryForList("utility.deptInfo.getDeptSelectList", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return temp;
	}
	/**
	 * (non-Javadoc)
	 * 
	 * @see com.siping.web.utility.dao.UtilityDao#getDeptSelectList(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getDeptTreeInfo(Object object) {
		List temp = new ArrayList();
		try {
			temp = this.queryForList("utility.deptInfo.getDeptTreeInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return temp;
	}
	@SuppressWarnings("rawtypes")
	@Override
	public List getDepartmentInfoList(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("utility.deptInfo.getDepartmentInfoList",
					obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getDepartmentInfoList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("utility.deptInfo.getDepartmentInfoList",
					obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getDepartmentInfoListCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"utility.deptInfo.getDepartmentInfoListCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
}
