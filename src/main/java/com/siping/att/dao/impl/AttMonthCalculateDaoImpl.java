package com.siping.att.dao.impl;

import java.sql.SQLException;
import java.util.LinkedHashMap; 

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.att.dao.AttMonthCalculateDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class AttMonthCalculateDaoImpl extends SqlMapClientSupport implements
		AttMonthCalculateDao {

	@SuppressWarnings("rawtypes")
	@Override
	public String monthCalculate(LinkedHashMap paramMap) {
		String returnString = ""; 
		try { 
			this.insert("att.attMonthCalculate.monthCalculate", paramMap); 
			returnString = ObjectUtils.toString(paramMap.get("empID"));
		} catch (SQLException e) {
			returnString = e.getMessage(); 
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return returnString;
	} 
	/**
	 * 更新日锁定
	 * @param obj
	 */
	@Override
	public int getMonthlyStatusCnt(Object obj) {

		int result = 0;
		try {
			result = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"att.attMonthCalculate.getMonthlyStatusCnt", obj)),
					Integer.class);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 更新日锁定
	 * @param obj
	 */
	@Override
	public void updateAttStatus(Object obj) {
		try {

			//this.update("att.attMonthCalculate.updateDetailLock", obj);废除更新ar_detail_lock表锁定，锁定后无法申请
			this.update("att.attMonthCalculate.updateDailyAttStatus", obj);
			//this.update("att.attMonthCalculate.updateMonthlyAttStatus", obj);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@Override
	public void insertMonthlyStatus(Object parameterObject) { 
		try { 
			this.insert("att.attMonthCalculate.insertMonthlyStatus",
					parameterObject);

		}  catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
 
	@Override
	public int getMonthlyStatus(Object parameterObject) {

		int result = 0;
		try {

			result = NumberUtils.parseNumber(ObjectUtils.toString(this
					.queryForObject(
							"att.attMonthCalculate.getMonthlyStatus", parameterObject)),
					Integer.class); 

		}  catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
