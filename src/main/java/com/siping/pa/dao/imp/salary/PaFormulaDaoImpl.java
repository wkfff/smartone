package com.siping.pa.dao.imp.salary;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.salary.PaFormulaDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaFormulaDaoImpl extends SqlMapClientSupport implements PaFormulaDao {
	/**
	 * 取得工资计算公式信息
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Object getPaFormulaObjectInfo(Object obj) {
		LinkedHashMap returnObj = new LinkedHashMap(); 
		try {
			returnObj = (LinkedHashMap) this.queryForObject("pa.paFormula.getPaFormulaInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnObj;
	}

	/**
	 * 取得所有工资计算公式列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaFormulaInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paFormula.getPaFormulaInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getPaFormulaInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paFormula.getPaFormulaInfo",obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	public int getPaFormulaInfoCnt(Object obj) {
		int returnInt = 0;
		try {
			returnInt = NumberUtils.parseNumber(this.queryForObject("pa.paFormula.getPaFormulaInfoCnt", obj).toString(),Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}

	/**
	 * 取得所有工资计算公式所需要的项目列表
	 * 
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getFormulaItemInfo(Object obj) {
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList("pa.paFormula.getFormulaItemInfo",obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnList;
	}

	/**
	 * 插入工资公式
	 * 
	 * @param Object
	 * @return
	 */
	public String addPaFormulaInfo(Object obj) {
		String resultString = "Y";
		try {
			this.insert("pa.paFormula.addPaFormulaInfo", obj);
		} catch (SQLException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (Exception e) {
			resultString = e.getMessage();
			e.printStackTrace();
		}
		return resultString;
	}

	/**
	 * 更新工资公式
	 * 
	 * @param Object
	 * @return
	 */
	public String updatePaFormulaInfo(Object obj) {
		String resultString = "Y";
		try {
			this.update("pa.paFormula.updatePaFormulaInfo", obj);
		} catch (SQLException e) {
			resultString = e.getMessage();
			e.printStackTrace();
		} catch (Exception e) {
			resultString = e.getMessage();
			e.printStackTrace();
		}
		return resultString;
	}

	/**
	 * 删除工资公式
	 * 
	 * @param Object
	 * @return
	 */
	public String deletePaFormulaInfo(Object obj) {
		String resultString = "Y";
		try {
			this.delete("pa.paFormula.deletePaFormulaInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}

	/**
	 * 初始化工资公式
	 * 
	 * @param Object
	 * @return
	 */
	public String initPaFormulaInfo(Object obj) {
		String resultString = "Y";
		try {
			this.insert("pa.paFormula.initPaFormulaInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	}
}
