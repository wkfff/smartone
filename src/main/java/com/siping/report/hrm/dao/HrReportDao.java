package com.siping.report.hrm.dao;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface HrReportDao {
	
	@SuppressWarnings({ "rawtypes" })
	public Map viewReport(Map object);
	@SuppressWarnings({ "rawtypes" })
	public void calReport(Map object);
	/**
	 * 获得每个部门的定编信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptQuotaList(Object object);
	/**
	 * 获取员工证书信息,并分页
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationInfoList(Object object, int currentPage, int pageSize);
	/**
	 * 获取员工证书信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationInfoList(Object object);
	/**
	 * 获取员工证书信息记录数之和
	 * @param object
	 * @return
	 */
	public int getEmpQualificationInfoCnt(Object object);
	/**
	 * 获取员工证书详细信息,并分页
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationDetailList(Object object, int currentPage, int pageSize);
	/**
	 * 获取员工证书的详细信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getEmpQualificationDetailList(Object object);
	/**
	 * 获取员工证书详细信息记录数之和
	 * @param object
	 * @return
	 */
	public int getEmpQualificationDetailCnt(Object object);
	
	@SuppressWarnings({ "rawtypes" })
    public List getMenList(Object object, int currentPage, int pageSize);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMenList(Object object);
    
    public int getMenCnt(Object object);
    
    @SuppressWarnings({ "rawtypes" })
    public List getHrTitleInfo(Object object);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMenTypeConstructList(Object object);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMenEduConstructList(Object object);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMenAgeConstructList(Object object);
    
    @SuppressWarnings({ "rawtypes" })
    public List getMenWAgeConstructList(Object object);
}
