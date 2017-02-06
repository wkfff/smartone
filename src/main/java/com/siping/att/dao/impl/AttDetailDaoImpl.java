package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttDetailDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttDetailDaoImpl extends SqlMapClientSupport implements
		AttDetailDao {
	 
	@SuppressWarnings("rawtypes")
	public List getAttDetailList(Object object) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("att.detail.getAttDetailList",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有考勤明细人员列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttDetailList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.detail.getAttDetailList", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getAttDetailListCnt(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.detail.getAttDetailListCnt", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	public int getStartDateStr(Object object) {
		int result = 0;
		try {
			result = NumberUtils.parseNumber(ObjectUtils.toString(
					this.queryForObject("att.detail.getStartDateStr", object),
					"0"), Integer.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

	public int getEndDateStr(Object object) {
		int result = 0;
		try {
			result = NumberUtils.parseNumber(ObjectUtils.toString(
					this.queryForObject("att.detail.getEndDateStr", object),
					"0"), Integer.class);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;

	}

	@SuppressWarnings("rawtypes")
	public int updateAttDetailInfo(List list) {

		try {
			this.updateForList("att.detail.updateAttDetailInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}  
	  
	@SuppressWarnings("rawtypes")
	public Map validateDetailItemType(Object object) {
		Map returnMap = new LinkedHashMap();
		try {
			returnMap = (Map) this.queryForObject("att.detail.validateDetailItemType",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return returnMap;
	}

	@SuppressWarnings("rawtypes")
	public int deleteAttDetailInfo(List list) {

		try {
			this.deleteForList("att.detail.deleteAttDetailInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
 
	public int addAttDetailInfo(Object object) { 
		try {
			this.insert("att.detail.addAttDetailInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}
 

}
