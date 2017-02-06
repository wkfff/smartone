package com.siping.att.dao;

import java.util.LinkedHashMap; 

public interface AttMonthCalculateDao {
	@SuppressWarnings("rawtypes")
	public String monthCalculate(LinkedHashMap object);
	/**
	* 获取月锁定
	* @param object
	* @return
	*/
	public int getMonthlyStatusCnt(Object object);
	/**
	 * 更新日锁定
	 * @param obj
	 */
	public void updateAttStatus(Object obj);

	public void insertMonthlyStatus(Object object);

	public int getMonthlyStatus(Object parameterObject);

}
