package com.siping.pa.dao.imp;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.PaBasicDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PaBasicDaoImpl extends SqlMapClientSupport implements PaBasicDao {
	/**
	 * 根据工资权限取得人员信息列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(Object obj) {
		List returnList = new ArrayList() ;
		
		returnList = this.getPaSearchEmployeeList(obj, -1, -1) ;
		
		
		return returnList ;
	}
	
	/**
	 * 根据工资权限取得人员信息列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getPaSearchEmployeeList(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try {
			if (currentPage > -1 && pageSize > -1){
				returnList = this.queryForList("pa.basic.getPaSearchEmployeeList", obj, currentPage, pageSize);
			}
			else{
				returnList = this.queryForList("pa.basic.getPaSearchEmployeeList", obj);
			}
			
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	}
	
	/**
	 * 根据工资权限取得人员信息人数
	 * @param List
	 * @return
	 */ 
	public int getPaSearchEmployeeCnt(Object obj) {
		int returnInt = 0 ;
		
		try {
			returnInt = 
				NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("pa.basic.getPaSearchEmployeeCnt", obj)), Integer.class) ;
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnInt ;
	}
}
