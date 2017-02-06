package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.DynamicGroupDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class DynamicGroupDaoImpl extends SqlMapClientSupport implements
		DynamicGroupDao {

	/**
	 * 取得动态组信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getDynamicGroup(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap(); 
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.dynamicGroup.getDynamicGroupInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnObj;
	}

	/**
	 * 取得所有班次信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupSelectionList(Object obj) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("att.dynamicGroup.getDynamicGroupSelectionList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	} 
	/**
	 * 取得所有动态组列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupList(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getDynamicGroupInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有动态组信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getDynamicGroupInfo", obj, currentPage,
					pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getDynamicGroupCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.dynamicGroup.getDynamicGroupInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 插入动态组信息
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int addDynamicGroupInfo(List obj) {
		int returnInt = 0;
		try {

			this.insertForList("att.dynamicGroup.addDynamicGroupInfo", obj);

		} catch (SQLException e) {
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {
			returnInt = 1;
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 更新动态组信息
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int updateDynamicGroupInfo(List obj) {
		int returnInt = 0;
		try {

			this.updateForList("att.dynamicGroup.updateDynamicGroupInfo", obj);

		} catch (SQLException e) {
			returnInt = 1;
			e.printStackTrace();
		} catch (Exception e) {
			returnInt = 1;
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 删除动态组信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteDynamicGroupInfo(Object obj) {

		try {
			this.delete("att.dynamicGroup.deleteDynamicGroupInfo", obj);
			this.delete("att.dynamicGroup.deleteDynamicGroupInfoPerson", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	@SuppressWarnings("rawtypes")
	public List getLoginUserDeptList(Object obj) {
		
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.dynamicGroup.getDeptList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getDynamicGroupEmpInfo(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getDynamicGroupEmpInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;

	}

	/**
	 * 取得所有动态组信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDynamicGroupEmpInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getDynamicGroupEmpInfo", obj, currentPage,
					pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	} 
	public int getDynamicGroupEmpInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.dynamicGroup.getDynamicGroupEmpInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}
	@SuppressWarnings("rawtypes")
	public int addDynamicGroupEmpInfo(List object) {
		
		int result = 0;
		try {
			this.insertForList("att.dynamicGroup.addDynamicGroupEmpInfo", object);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return result;
	}

	public int checkDynamicGroupEmpInfo(Object object) {
		
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.dynamicGroup.checkDynamicGroupEmpInfo",
							object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	public int deleteDynamicGroupEmpInfo(Object object) {
		
		try {
			this.deleteForList("att.dynamicGroup.deleteDynamicGroupEmpInfo",
					(List) object);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return 0;
	}
	/**
	 * 取得所有动态组列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getNonDynamicGroupEmpInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getNonDynamicGroupEmpInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有动态组信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getNonDynamicGroupEmpInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.dynamicGroup.getNonDynamicGroupEmpInfo", obj, currentPage,
					pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getNonDynamicGroupEmpInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
							"att.dynamicGroup.getNonDynamicGroupEmpInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}

}
