package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList; 
import java.util.List; 

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMFormulaDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMFormulaDaoImpl extends SqlMapClientSupport implements
		AttMFormulaDao {

	@SuppressWarnings("rawtypes")
	public List getAttMFormulaItemInfo(Object obj) {
		
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.formula.getAttMFormulaItemInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}


	public Object getAttMFormulaObjectInfo(Object object) {
		
		Object returnObj = null;
		try {
			returnObj = this.queryForObject(
					"att.formula.getAttMFormulaInfo", object);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return returnObj;
	}
	@SuppressWarnings("rawtypes")
	public List getAttMFormulaInfo(Object obj) { 
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.formula.getAttMFormulaInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	@SuppressWarnings("rawtypes")
	public List getAttMFormulaInfo(Object obj, int currentPage, int pageSize) { 
		List returnList = new ArrayList();
		try {
			returnList = this.queryForList(
					"att.formula.getAttMFormulaInfo", obj,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnList;
	}

	public int getAttMFormulaInfoCnt(Object obj) {
		int returnInt = 0;

		try {
			returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject("att.formula.getAttMFormulaInfoCnt", obj)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return returnInt;
	}
	
	public int addAttMFormulaInfo(Object obj) {

		try {

			this.insert("att.formula.addAttMFormulaInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int updateAttMFormulaInfo(Object obj) {

		try {

			this.update("att.formula.updateAttMFormulaInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	public int deleteAttMFormulaInfo(Object obj) {

		try {

			this.update("att.formula.deleteAttMFormulaInfo", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}
}
