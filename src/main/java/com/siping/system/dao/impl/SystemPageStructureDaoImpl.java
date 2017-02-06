package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.SystemPageStructureDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SystemPageStructureDaoImpl extends SqlMapClientSupport implements
		SystemPageStructureDao {
	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.siping.system.dao.SystemPageStructureDao#getPageStructure(java.lang
	 * .Object)
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructure(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemPageStructure.getPageStructure", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}  

	public int addPageStructureInfo(Object object) {

		int rtNo = 0;
		try {
			rtNo = (Integer) this.insert("system.systemPageStructure.addPageStructureInfo",
					object); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rtNo;
	}
  
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(Object object) {

		List returnList = new ArrayList();

		try {
			returnList = this.queryForList(
					"system.systemPageStructure.getPageStructureDetailItemInfo",
					object);

		} catch (SQLException e) {
			e.printStackTrace();
		}


		return returnList;
	}

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailItemInfo(Object obj, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemPageStructure.getPageStructureDetailItemInfo",
					obj, currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getPageStructureDetailItemInfoCnt(Object object) {

		int i = 0;
		try {

			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemPageStructure.getPageStructureDetailItemInfoCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	@SuppressWarnings("rawtypes")
	public int addPageStructureDetailInfo(List objList) {

		int result = 0;
		try {
			this.insertForList(
					"system.systemPageStructure.addPageStructureDetailInfo",
					objList);
			result = 1;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"system.systemPageStructure.getPageStructureDetailInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getPageStructureDetailInfoCnt(Object object) {

		int i = 0;
		try {

			i = NumberUtils
					.parseNumber(
							ObjectUtils.toString(this
									.queryForObject(
											"system.systemPageStructure.getPageStructureDetailInfoCnt",
											object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return i;
	}

	@SuppressWarnings({ "rawtypes" })
	public List getPageStructureDetailInfo(Object object) {

		List returnList = new ArrayList();

		try {
			returnList = this
					.queryForList(
							"system.systemPageStructure.getPageStructureDetailInfo",
							object);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int deletePageStructureDetailInfo(Object object) {

		int result = 0; 
		try {

			this.delete("system.systemPageStructure.deletePageStructureDetailInfo",
					object);
			result = 1;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	@SuppressWarnings("rawtypes")
	public int updatePageStructureDetailInfoOrder(List objList) {
		int returnInt = 0;

		try {

			this.updateForList("system.systemPageStructure.updatePageStructureDetailInfoOrder", objList);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}
}
