package com.siping.web.utility.service;

import com.siping.productStorage.bean.Employee;

import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

public interface UtilityEmpInfoSer {  
 
	@SuppressWarnings({ "rawtypes" })
	public List getEmpInfoList(HttpServletRequest request);
	/** 
	 * @param request
	 * @return
	 */
	public int getEmpInfoListCnt(HttpServletRequest request);
	/** 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getEmpBasicInfo(HttpServletRequest request);
	/** 
	 * 判断是否是考勤员
	 * @param object
	 * @return
	 */
	public boolean isSupervisor(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
	public List getAttSearchEmployeeList(HttpServletRequest request) ;
	 
	public int getAttSearchEmployeeCnt(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
	public List getHrSearchEmployeeList(HttpServletRequest request) ;
	 
	public int getHrSearchEmployeeCnt(HttpServletRequest request);

    @SuppressWarnings({ "rawtypes" })
	public List getProSearchEmployeeInfo(HttpServletRequest request) ;
	 
	public int getProSearchEmployeeInfoCnt(HttpServletRequest request);
	/**
	 * 获取信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) ;
	
	@SuppressWarnings("rawtypes")
	public List getCustSearchEmployeeList(HttpServletRequest request);
	
	public int getCustSearchEmployeeCnt(HttpServletRequest request);

    List<Employee> getAllEmployeesUsingBeanMap(HttpServletRequest request);

    Employee getEmpBasicInfoUsingBeanMap(HttpServletRequest request);
}
