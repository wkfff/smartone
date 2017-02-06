package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttAnnualLeaveDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttAnnualLeaveDaoImpl extends SqlMapClientSupport implements
		AttAnnualLeaveDao {

	/**
	 * 取得个人年假信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getAttAnnualLeaveInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();

		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.annualLeave.getAttAnnualLeaveInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有个人年假列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttAnnualLeaveInfoList(Object obj) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList(
					"att.annualLeave.getAttAnnualLeaveInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得个人年假计数
	 * 
	 * @param List
	 * @return
	 */
	public int getAttAnnualLeaveInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.annualLeave.getAttAnnualLeaveInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得所有个人年假列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getAttAnnualLeaveInfoList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.annualLeave.getAttAnnualLeaveInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}
	/**
	 * 取得所有个人年假列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEsslLeaveInfo(Object obj) {
		List returnList = new ArrayList(); 
		try {
			returnList = this.queryForList(
					"att.annualLeave.getAttAnnualLeaveInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得个人年假计数
	 * 
	 * @param List
	 * @return
	 */
	public int getEsslLeaveInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.annualLeave.getAttAnnualLeaveInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得所有个人年假列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getEsslLeaveInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.annualLeave.getAttAnnualLeaveInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 删除个人年假信息
	 * 
	 * @param List
	 * @return
	 */
	public int deleteAttAnnualLeaveInfo(Object object) {

		try {
			this.delete("att.annualLeave.deleteAttAnnualLeave", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 更新个人年假信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int updateAttAnnualLeaveInfo(List list) {
		try {
			this.updateForList("att.annualLeave.updateAttAnnualLeave", list);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 插入验证
	 * 
	 * @param List
	 * @return
	 */
	public int checkAddAttAnnualLeaveInfo(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"att.annualLeave.checkAddAttAnnualLeaveInfo",
							object), "0"), Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 插入个人年假信息
	 * 
	 * @param List
	 * @return
	 */
	public int addAttAnnualLeaveInfo(Object object) {

		try {
			this.insert("att.annualLeave.addAttAnnualLeave", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 初始化个人年假
	 * 
	 * @param List
	 * @return
	 */
	public int createAttAnnualLeaveInfo(Object object) {

		try {
			this.insert("att.annualLeave.createAttAnnualLeaveInfo", object);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}
}
