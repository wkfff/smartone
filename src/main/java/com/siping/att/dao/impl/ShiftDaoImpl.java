package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.ShiftDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ShiftDaoImpl extends SqlMapClientSupport implements ShiftDao {

	/**
	 * 取得班次信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getShiftInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.shift.getShiftInfoList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnObj;
	}
	
	// @Override
	public int getShiftInfoCnt(Object object) {
		int returnInt = 0;
	
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.getShiftInfoCnt", object)),
					Integer.class);
	
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
	
		return returnInt;
	}

	/**
	 * 取得所有班次信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getShiftInfoList(Object obj) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("att.shift.getShiftInfoList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有班次信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getShiftSelectionList(Object obj) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("att.shift.getShiftSelectionList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}
	/**
	 * 取得所有班次信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getShiftInfoList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.shift.getShiftInfoList", obj,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 插入班次信息
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int addShiftInfo(List obj) { 
		try { 

			this.insertForList("att.shift.addShiftInfo", obj);
 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}  

		return 0;
	}
	/**
	 * 检查班次信息并返回错误代码
	 * 
	 * @param Object
	 * @return
	 */
	public int checkShiftInfo(Object object) {
		int returnInt = 0;
	
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.checkShiftInfo", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
	
		return returnInt;
	}

	/**
	 * 更新班次信息
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public int updateShiftInfo(List obj) {

		try { 

			this.updateForList("att.shift.updateShiftInfo", obj);
 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return 0;
	}
	/**
	 * 删除班次信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteShiftInfo(Object obj) { 
		try {
			this.startTransaction();
			this.delete("att.shift.deleteShiftParameterInfo", obj);
			this.delete("att.shift.deleteShiftInfo", obj);
			this.commitTransation();
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		} finally{
			try {
				this.endTransation();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}
	/**
	 * 删除班次信息
	 * 
	 * @param Object
	 * @return
	 */
	public int deleteShiftParameterInfo(Object obj) { 
		try { 
			this.delete("att.shift.deleteShiftParameterInfo", obj);  
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}  
		return 0;
	} 
	/**
	 * 更新班次信息
	 * 
	 * @param Object
	 * @return
	 */ 
	public int updateShiftParameterInfo(Object obj) {
	
		try {  
			this.update("att.shift.updateShiftParameterInfo", obj);
	
			 
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return 0;
	}

	/**
	 * 插入班次信息
	 * 
	 * @param Object
	 * @return
	 */
	public int addShiftParameterInfo(Object obj) {
		try { 
			this.insert("att.shift.addShiftParameterInfo",
					obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return 0;
	}

	/**
	 * 取出班次参数信息
	 * 
	 * @param Object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getShiftParameterInfo(Object object) {

		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.shift.getShiftParameterInfo",
					object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得班次信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getShiftParameterInfoObj(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.shift.getShiftParameterInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnObj;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getShiftGroupInfoList(Object object) {
		List returnList = new ArrayList();

		try {
			returnList = this.queryForList("att.shift.getShiftGroupInfoList", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getShiftGroupInfoList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("att.shift.getShiftGroupInfoList", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getShiftGroupInfoListCnt(Object object) {
		int returnInt = 0;
		
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.getShiftGroupInfoCnt", object)),
					Integer.class);
	
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
	
		return returnInt;
	}

	@Override
	public int checkShiftGroupInfo(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.checkShiftGroupInfo", object)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnInt;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int addShiftGroupInfo(List object) {
		try { 
			this.insertForList("att.shift.addShiftGroupInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int updateShiftGroupInfo(List object) {
		try { 
			this.updateForList("att.shift.updateShiftGroupInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int deleteShiftGroupInfo(Object object) {
		try {
			this.startTransaction();
			this.delete("att.shift.deleteShiftGroupEmpInfo", object);
			this.delete("att.shift.deleteShiftGroupInfo", object);
			this.commitTransation();
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		} finally{
			try {
				this.endTransation();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Object getShiftGroupInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject(
					"att.shift.getShiftGroupInfoList", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnObj;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int deleteShiftGroupEmpInfo(List list) {
		try {
			this.startTransaction();
			this.deleteForList("att.shift.deleteShiftGroupEmpInfo", list);
			this.commitTransation();
		} catch (SQLException e) { 
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		} finally{
			try {
				this.endTransation();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return 0;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public int addGroupEmpInfo(List object) {
		int result = 0;
		try {
			this.insertForList("att.shift.addGroupEmpInfo", object);
			result = 1;
		} catch (SQLException e) {
					e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return result;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getShiftGroupEmpInfoList(Object object) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.shift.getShiftGroupEmpInfoList", object);
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getShiftGroupEmpInfoList(Object object, int currentPage,
			int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.shift.getShiftGroupEmpInfoList", object,
					currentPage, pageSize);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@Override
	public int getShiftGroupEmpInfoListCnt(Object object) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.getShiftGroupEmpInfoListCnt",
							object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	@Override
	public int checkShiftGroupEmpDate(Object object) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.shift.checkShiftGroupEmpDate",
							object)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) { 
			e.printStackTrace();
		}
		return returnInt;
	}
}
