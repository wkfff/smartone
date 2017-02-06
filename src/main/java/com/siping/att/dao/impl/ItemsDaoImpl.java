package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.ItemsDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ItemsDaoImpl extends SqlMapClientSupport implements ItemsDao {

	/**
	 * 取得明细项目信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public Object getItemObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.item.getItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnObj;
	}

	/**
	 * 取得所有明细项目列表
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.item.getItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}
	/**
	 * 取得所有明细项目列表
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getItemInfoSelection(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.item.getItemInfoSelection", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	} 
	@Override
	public int getItemInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.item.getItemInfoCnt", obj)),
					Integer.class);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得所有明细列表
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getItemInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.item.getItemInfo", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
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
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getItemInfoTree(Object obj) {
		List returnList = new ArrayList();
		try {
			List<Map> itemGroupList = this.queryForList(
					"att.item.getItemGroupInfo", obj);
			if (itemGroupList.size() > 0) {
				for (Map itemGroupMap : itemGroupList) {
					Map returnMap = new LinkedHashMap<Object, Object>();
					returnMap.put("ITEM_NO",
							itemGroupMap.get("ITEM_GROUP_CODE"));
					returnMap.put("ITEM_NAME",
							itemGroupMap.get("ITEM_GROUP_NAME"));
					returnMap.put("DEPTH", itemGroupMap.get("DEPTH"));
					returnList.add(returnMap);
					List<Map> itemInfoList = this.queryForList(
							"att.item.getItemInfoTree", itemGroupMap);
					if (itemInfoList.size() > 0) {
						for (Map itemInfoMap : itemInfoList) {
							returnList.add(itemInfoMap);
						}
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 插入明细项目信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	public int addItemInfo(Object obj) {
		int returnInt = 1;
		try {
			this.insert("att.item.addItemInfo", obj);

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
	 * 插入明细项目信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	public int checkItemInfo(Object obj) {
		int returnInt = 1;
		try {
			returnInt = (Integer) this.queryForObject("att.item.checkItemInfo",
					obj);

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
	 * 更新明细项目信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	public int updateItemInfo(Object obj) {

		try {

			this.update("att.item.updateItemInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除明细项目信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	public int deleteItemInfo(Object obj) {

		try {
			this.delete("att.item.deleteItemInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 取出明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getItemParameterInfoList(Object object) {

		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.item.getItemParameterInfo",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}/**
	 * 取出明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public List getAppTypeSelectionList(Object object) {

		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.item.getAppTypeSelectionList",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取出明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	public Object getItemParameterInfo(Object object) {

		Object returnObject = new Object();
		try {
			returnObject = this.queryForObject("att.item.getItemParameterInfo",
					object);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnObject;
	}

	/**
	 * 插入明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addItemParameterInfo(Object obj) {

		try {

			this.insert("att.item.addItemParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 修改明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	public int updateItemParameterInfo(Object obj) {

		try {

			this.update("att.item.updateItemParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}

	/**
	 * 删除明细项目参数信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteItemParameterInfo(Object obj) {

		try {

			this.delete("att.item.deleteItemParameterInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return 0;
	}
}
