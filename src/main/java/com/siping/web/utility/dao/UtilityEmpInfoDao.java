package com.siping.web.utility.dao;

import com.siping.productStorage.bean.Employee;
import com.siping.system.bean.AdminBean;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface UtilityEmpInfoDao { 
	/**
	 * 获取个人信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getEmpInfoList(Object obj) ;
	/**
	 * 获取个人信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getEmpInfoList(Object object, int currentPage, int pageSize);
	/**
	 * 获取个人信息
	 * @param object 
	 * @return
	 */ 
	public int getEmpInfoListCnt(Object object);
	/**
	 * 
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getEmpBasicInfo(Object object);
	/**
	 * 判断是否是考勤员
	 * @param object
	 * @return
	 */
	public boolean isSupervisor(Object object);
	

	@SuppressWarnings("rawtypes")
	public List getAttSearchEmployeeList(Object object);

	@SuppressWarnings("rawtypes")
	public List getAttSearchEmployeeList(Object object, int currentPage, int pageSize);
	 
	public int getAttSearchEmployeeCnt(Object object);

	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeList(Object object);

	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeList(Object object, int currentPage, int pageSize);
	 
	public int getHrSearchEmployeeCnt(Object object);
	@SuppressWarnings("rawtypes")
	public List getProSearchEmployeeInfo(Object object);

	@SuppressWarnings("rawtypes")
	public List getProSearchEmployeeInfo(Object object, int currentPage, int pageSize);
	 
	public int getProSearchEmployeeInfoCnt(Object object);
	
	public int getCustSearchEmployeeCnt(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getCustSearchEmployeeList(Object object, int currentPage, int pageSize);
	
	@SuppressWarnings("rawtypes")
	public List getCustSearchEmployeeList(Object object);
	
	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeListScore(Object object);

	@SuppressWarnings("rawtypes")
	public List getHrSearchEmployeeListScore(Object object, int currentPage, int pageSize);

    List<Employee> getAllEmployeesUsingBeanMap(Object obj);

    Employee getEmpBasicInfoUsingBeanMap(Object obj);
}
