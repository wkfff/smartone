package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMItemDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMItemDaoImpl extends SqlMapClientSupport implements
		AttMItemDao {

	/**
	 * 取得汇总项目信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getAttMItemObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();

		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.attMItem.getAttMItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有汇总项目列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttMItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.attMItem.getAttMItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	/**
	 * 取得所有明细列表
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getAttMItemInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.attMItem.getAttMItemInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	@Override
	public int getAttMItemInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.attMItem.getAttMItemInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}
	/**
	 * 插入汇总项目信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addAttMItemInfo(Object obj) {

		try { 
			this.insert("att.attMItem.addAttMItemInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新汇总项目信息
	 * 
	 * @param Object
	 * @return
	 */
	public int updateAttMItemInfo(Object obj) {

		try {

			this.update("att.attMItem.updateAttMItemInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除汇总项目信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteAttMItemInfo(Object obj) {

		try {
			this.delete("att.attMItem.deleteAttMItemInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 检查 汇总项目信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	public int checkDeleteAttMItemInfo(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.attMItem.checkDeleteAttMItemInfo",
							object)), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	@Override 
	public int updateAttMItemInfoCalOrder(List itemList) {
		int returnInt = 0;

		try {

			this.updateForList("att.attMItem.updateAttMItemInfoCalOrder",
					itemList);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return returnInt;
	}
}
