package com.siping.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.salary.PaItemDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaItemDaoImpl extends SqlMapClientSupport implements PaItemDao {

	/**
	 * 取得所有工资计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getPaItemObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject("pa.paItem.getPaItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnObj;
	}

	/**
	 * 取得所有工资计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	public List getPaItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paItem.getPaItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}

	/**
	 * 取得所有工资计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */

	@SuppressWarnings("rawtypes")
	public List getPaItemInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paItem.getPaItemInfo", obj,currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}

	/**
	 * 取得所有工资计算项目信息总数
	 * 
	 * @param List
	 * @return
	 */
	public int getPaItemInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
				.queryForObject("pa.paItem.getPaItemInfoCnt", obj)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 插入工资计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public String addPaItemInfo(List objList) {
		String resultString = "Y";
		try {
			this.insertForList("pa.paItem.addPaItemInfo", objList);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 修改工资计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public String updatePaItemInfo(List objList) {
		String resultString = "Y";
		try {
			this.updateForList("pa.paItem.updatePaItemInfo", objList);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 验证删除工资计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public int checkDeletePaItemInfo(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("pa.paItem.checkDeletePaItemInfo", obj)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 删除工资计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public String deletePaItemInfo(Object obj) {
		String resultString = "Y";
		try {
			this.delete("pa.paItem.deletePaItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 修改计算顺序
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public String updatePaItemInfoCalOrder(List objList) {
		String resultString = "Y";
		try {
			this.updateForList("pa.paItem.updatePaItemInfoCalOrder", objList);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
}
