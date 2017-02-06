package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.CycleDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class CycleDaoImpl extends SqlMapClientSupport implements CycleDao {

	/**
	 * 取得周期信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getCycleInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();

		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.cycle.getCycleInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有周期列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getCycleInfoList(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.cycle.getCycleInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	// @Override
	public int getCycleInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.cycle.getCycleInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得所有周期列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getCycleInfoList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {

			returnList = this.queryForList("att.cycle.getCycleInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 插入周期信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addCycleInfo(Object obj) {

		try {

			this.insert("att.cycle.addCycleInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新周期信息
	 * 
	 * @param Object
	 * @return
	 */
	public int updateCycleInfo(Object obj) {

		try {

			this.update("att.cycle.updateCycleInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除周期信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteCycleInfo(Object obj) {

		try {
			this.delete("att.cycle.deleteCycleInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}
}
