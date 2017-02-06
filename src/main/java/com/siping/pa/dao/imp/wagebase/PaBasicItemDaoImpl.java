package com.siping.pa.dao.imp.wagebase;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.wagebase.PaBasicItemDao; 
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaBasicItemDaoImpl extends SqlMapClientSupport implements
		PaBasicItemDao { 
	Logger logger = Logger.getLogger(PaBasicItemDao.class);
	/**
	 * 取得所有计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getPaBasicItemObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap(); 
		try {
			returnObj = (LinkedHashMap) this.queryForObject("pa.basicItem.getPaBasicItemInfo",
				obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		}
		return returnObj;
	}

	/**
	 * 取得所有计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.basicItem.getPaBasicItemInfo",
					obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有计算项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.basicItem.getPaBasicItemInfo",
				obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有计算项目信息总数
	 * 
	 * @param List
	 * @return
	 */
	public int getPaBasicItemInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"pa.basicItem.getPaBasicItemInfoCnt", obj)),
				Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 插入基础项目信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void addPaBasicItemInfo(List objList) throws SQLException{
		this.insertForList("pa.basicItem.addPaBasicItemInfo", objList);
	}
 
	/**
	 * 修改基础项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	@SuppressWarnings("rawtypes")
	public void updatePaBasicItemInfo(List objList) throws SQLException{
		this.updateForList("pa.basicItem.updatePaBasicItemInfo", objList);
	}

	/**
	 * 验证删除计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public int checkDeletePaBasicItemInfo(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
				.queryForObject("pa.basicItem.checkDeletePaBasicItemInfo",obj)), Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
			returnInt = 0;
		}
		return returnInt;
	}

	/**
	 * 删除计算项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public String deletePaBasicItemInfo(Object obj) {
		String resultString = "Y";
		try {
			this.delete("pa.basicItem.deletePaBasicItemInfo", obj);
			this.delete("pa.basicItem.deletePaBasicItemDataInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
	
	@SuppressWarnings("rawtypes")
	public String deletePaBasicItemDataInfo(List deleteList) {
		String resultString = "Y";
		try { 
			this.deleteForList("pa.basicItem.deletePaBasicItemDataInfo", deleteList);
		} catch (SQLException e) { 
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
	
	/**
	 * 取得所有工资基础项目数据信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataInfo(Object obj) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnList = this.queryForList("pa.basicItem.empID_getPaBasicItemDataInfo", obj);
			}else{ 
				returnList = this.queryForList("pa.basicItem.other_getPaBasicItemDataInfo", obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}

	/**
	 * 取得所有工资基础项目数据信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnList = this.queryForList("pa.basicItem.empID_getPaBasicItemDataInfo", obj, currentPage,pageSize);
			}else{ 
				returnList = this.queryForList("pa.basicItem.other_getPaBasicItemDataInfo", obj, currentPage,pageSize);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}

	/**
	 * 取得所有工资基础项目数据信息列表总数
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int getPaBasicItemDataInfoCnt(Object obj) {
		int returnInt = 0;
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
						"pa.basicItem.empID_getPaBasicItemDataInfoCnt", obj)),
					Integer.class);
			}else{ 
				returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
						"pa.basicItem.other_getPaBasicItemDataInfoCnt", obj)),
					Integer.class);
			}  
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	
	/**
	 * 批量更新基础项目数据
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String updatePaBasicItemDataInfo(List list) {
		String resultString = "Y";
		try {
			this.updateForList("pa.basicItem.updatePaBasicItemDataInfo", list);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 初始化要添加的基础项目数据
	 * 
	 * @param Object
	 * @return
	 */
	public String initializePaBasicItemDataInfo(Object obj) {
		String resultString = "Y";
		try {
			this.insert("pa.basicItem.initializePaBasicItemDataInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
	
	/**
	 * 添加基础项目数据
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String addPaBasicItemDataInfo(List insertList) {
		String resultString = "Y";
		try {
			this.insertForList("pa.basicItem.addPaBasicItemDataInfo", insertList);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 任务修改基础项目数据状态
	 * 
	 * @param 
	 * @return
	 */
	public String updatePaBasicItemDataActivityInfo(){
		String resultString = "Y";
		try {
			this.update("pa.basicItem.updatePaBasicItemDataActivityInfo_0");
			this.update("pa.basicItem.updatePaBasicItemDataActivityInfo_1");
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
	
	/**
	 * 添加输入项目明细
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataEmpInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.basicItem.getPaBasicItemDataEmpInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}
	
	@SuppressWarnings("rawtypes")
	public List getPaBasicItemDataEmpInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
				"pa.basicItem.getPaBasicItemDataEmpInfo", obj, currentPage,
				pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
			returnList = null;
		}
		return returnList;
	}
	
	public int getPaBasicItemDataEmpInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject("pa.basicItem.getPaBasicItemDataEmpInfoCnt", obj)),
				Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	
	/**
	 * 添加输入项目明细
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataOtherInfo(Object obj) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnList = this.queryForList("pa.basicItem.getPaBasicItemDataPostGradeInfo", obj);
			}else{
				returnList = this.queryForList("pa.basicItem.getPaBasicItemDataEmpInfo", obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaBasicItemDataOtherInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnList = this.queryForList("pa.basicItem.getPaBasicItemDataPostGradeInfo", obj, currentPage,pageSize);
			}else{
				returnList = this.queryForList("pa.basicItem.getPaBasicItemDataEmpInfo", obj, currentPage,pageSize);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPaBasicItemDataOtherInfoCnt(Object obj) {
		int returnInt = 0;
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
						"pa.basicItem.getPaBasicItemDataPostGradeInfoCnt", obj)),
					Integer.class);
			}else{
				returnInt = NumberUtils.parseNumber(
					ObjectUtils.toString(this.queryForObject(
						"pa.basicItem.getPaBasicItemDataEmpInfoCnt", obj)),
					Integer.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
}
