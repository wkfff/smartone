package com.siping.web.utility.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.dao.UtilityPostInfoDao;
@Repository
public class UtilityPostInfoDaoImpl extends SqlMapClientSupport implements UtilityPostInfoDao {
	Logger logger = Logger.getLogger(UtilityPostInfoDaoImpl.class);

	@SuppressWarnings("rawtypes")
	@Override
	public List getPostInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"utility.postInfo.getPostInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getPostInfoList(Object object, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"utility.postInfo.getPostInfo", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@Override
	public int getPostInfoCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("utility.postInfo.getPostInfoCnt",
							object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

}
