package com.siping.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.salary.PaInputItemDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaInputItemDaoImpl extends SqlMapClientSupport implements PaInputItemDao {

	/**
	 * 取得所有工资输入项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getPaInputItemObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap();
		try {
			returnObj = (LinkedHashMap) this.queryForObject("pa.paInputItem.getPaInputItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnObj;
	}

	/**
	 * 取得所有工资输入项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paInputItem.getPaInputItemInfo",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有工资输入项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paInputItem.getPaInputItemInfo",
				obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有工资输入项目信息总数
	 * 
	 * @param List
	 * @return
	 */
	public int getPaInputItemInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"pa.paInputItem.getPaInputItemInfoCnt", obj)),
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
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataEmpInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"pa.paInputItem.getPaInputItemDataEmpInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	
	@SuppressWarnings("rawtypes")
	public List getPaInputItemDataEmpInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
				"pa.paInputItem.getPaInputItemDataEmpInfo", obj, currentPage,
					pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	
	public int getPaInputItemDataEmpInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(
				ObjectUtils.toString(this.queryForObject(
					"pa.paInputItem.getPaInputItemDataEmpInfoCnt", obj)),
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
	public List getPaInputItemDataOtherInfo(Object obj) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnList = this.queryForList("pa.paInputItem.getPaInputItemDataPostGradeInfo", obj);
			}else{
				returnList = this.queryForList("pa.paInputItem.getPaInputItemDataEmpInfo", obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataOtherInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnList = this.queryForList(
					"pa.paInputItem.getPaInputItemDataPostGradeInfo", obj, currentPage,
						pageSize);
			}else if(paraMap.get("MC_CODE").toString().equals("DEPTID")){
				returnList = this.queryForList("pa.paInputItem.getPaInputItemDataDeptIdInfo", obj, currentPage,
						pageSize);
			}else{
				returnList = this.queryForList(
					"pa.paInputItem.getPaInputItemDataEmpInfo", obj, currentPage,
						pageSize);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	} 
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public int getPaInputItemDataOtherInfoCnt(Object obj) {
		int returnInt = 0;
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap)obj;
		try {
			if(paraMap.get("MC_CODE").toString().equals("POST_GRADE")){
				returnInt = NumberUtils.parseNumber(this.queryForObject(
						"pa.paInputItem.getPaInputItemDataPostGradeInfoCnt", obj).toString(),
							Integer.class);
			}else if(paraMap.get("MC_CODE").toString().equals("DEPTID")){
				returnInt = NumberUtils.parseNumber(this.queryForObject(
						"pa.paInputItem.getPaInputItemDataDeptIdInfoCnt", obj).toString(),
							Integer.class);
			}else{
				returnInt = NumberUtils.parseNumber(this.queryForObject(
						"pa.paInputItem.getPaInputItemDataEmpInfoCnt", obj).toString(),Integer.class);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
	/**
	 * 插入工资输入项目信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void addPaInputItemInfo(List objList) throws SQLException {
		this.insertForList("pa.paInputItem.addPaInputItemInfo", objList);
	}
 
	/**
	 * 修改工资输入项目信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void updatePaInputItemInfo(List objList) throws SQLException {
		this.updateForList("pa.paInputItem.updatePaInputItemInfo", objList);
	}

	/**
	 * 验证删除工资输入项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public int checkDeletePaInputItemInfo(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(this.queryForObject("pa.paInputItem.checkDeletePaInputItemInfo", obj).toString(),
				Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}

	/**
	 * 删除工资输入项目信息
	 * 
	 * @param List
	 * @return
	 */
	@Override
	public String deletePaInputItemInfo(Object obj) {
		String resultString = "Y";
		try {
			this.startTransaction(); 
			this.delete("pa.paInputItem.deletePaInputItemDataInfo", obj);
			this.delete("pa.paInputItem.deletePaInputItemInfo", obj);
			this.commitTransation();
		} catch (SQLException e) { 
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}


	/**
	 * 工资输入项目初始化
	 * 
	 * @param Object
	 * @return
	 */
	public String createPaInputItemInfo(Object obj) {
		String resultString = "Y";
		try {
			this.insert("pa.paInputItem.createPaInputItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 初始化要添加的输入项目数据
	 * 
	 * @param Object
	 * @return
	 */
	
	public String createPaInputItemDataInfo(Object obj) {
		String resultString = "Y";
		try {
			this.insert("pa.paInputItem.createPaInputItemDataInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataInfo(Object obj) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnList = this.queryForList("pa.paInputItem.empID_getPaInputItemDataInfo", obj);
			}else{ 
				returnList = this.queryForList("pa.paInputItem.other_getPaInputItemDataInfo", obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	/**
	 * 取得所有保险输入项目信息列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnList = this.queryForList("pa.paInputItem.empID_getPaInputItemDataInfo", obj, currentPage,
					pageSize);
			}else{ 
				returnList = this.queryForList("pa.paInputItem.other_getPaInputItemDataInfo", obj, currentPage,
					pageSize);
			} 
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 取得所有保险输入项目信息总数
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int getPaInputItemDataInfoCnt(Object obj) {
		int returnInt = 0;
		LinkedHashMap<Object, Object> paraMap = (LinkedHashMap<Object, Object>) obj;
		try {
			if(paraMap.get("MC_CODE").equals("EMPID")){
				returnInt = NumberUtils.parseNumber(this.queryForObject(
					"pa.paInputItem.empID_getPaInputItemDataInfoCnt", obj).toString(),
						Integer.class);
			}else{ 
				returnInt = NumberUtils.parseNumber(this.queryForObject(
					"pa.paInputItem.other_getPaInputItemDataInfoCnt", obj).toString(),
						Integer.class);
			}  
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnInt;
	}
 
	/**
	 * 批量插入工资输入项目数据
	 * 
	 * @param List
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public String addPaInputItemDataInfo(List insertList) {
		String resultString = "Y";
		try {
			this.updateForList("pa.paInputItem.addPaInputItemDataInfo", insertList);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
	/**
	 * 批量更新保险输入项目数据
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String updatePaInputItemDataInfo(List updateList) {
		String resultString = "Y";
		try { 
			this.startTransaction();
			this.insertForList("pa.paInputItem.insert_updatePaInputItemDataInfo",updateList);
			this.updateForList("pa.paInputItem.updatePaInputItemDataInfo",updateList);
			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}

	/**
	 * 删除保险输入项目数据信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public String deletePaInputItemDataInfo(List deleteList) {
		String resultString = "Y";
		try {
			this.startTransaction();
			this.insertForList("pa.paInputItem.insert_updatePaInputItemDataInfo",deleteList);
			this.deleteForList("pa.paInputItem.deletePaInputItemDataInfo", deleteList);
			this.commitTransation();
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}finally{
			try {
				this.endTransation();
			} catch (SQLException e) { 
				e.printStackTrace();
			}
		}
		return resultString;
	}
}
