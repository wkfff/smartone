package com.siping.hrm.dao;

import java.util.List;
import java.util.Map;

public interface OrgDao { 
	/**
	 * 部门信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getDeptInfoObj(Object object) ;
	/**
	 * 部门信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfo(Object object) ;
	/**
	 * 部门信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptInfo(Object object,int currentPage, int pageSize); 
	/**
	 * 部门信息
	 * @param object
	 * @return
	 */
	public int getDeptInfoCnt(Object object) ;
	/**
	 * 修改部门信息
	 * @param object
	 * @return
	 */ 
	public String updateDeptInfo(Object object);
	/**
	 * 修改部门信息
	 * @param object
	 * @return
	 */ 
	public String addDeptInfo(Object object);
	/**
	 * 删除部门信息
	 * @param object
	 * @return
	 */ 
	public String deleteDeptInfo(Object object);
	/**
	 * 部门信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfoTree(Object object);
	/**
	 * 部门信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptLevel(Object object);
	/**
	 * 定编信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptQuotaList(Object object);
	/**
	 * 定编信息
	 * @param object
	 * @return
	 */
	public int getDeptQuotaListCnt(Object object);
	/**
	 * 定编信息
	 * @param obj
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptQuotaList(Object obj, int currentPage, int pageSize);
	/**
	 * 添加定编信息
	 * @param object
	 * @return
	 */
	public String addDeptQuotaInfo(Object object);
	/**
	 * 添加定编信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String addDeptQuotaInfo(List objList);
	/**
	 * 获取定编信息中该公司的部门所包含的对应职位的个数
	 * @param object
	 * @return
	 */
	public int getPostIdCnt(Object object);
	/**
	 * 删除定编信息
	 * @param object
	 * @return
	 */
	public String deleteDeptQuotaInfo(Object object);
	/**
	 * 修改定编信息
	 * @param object
	 * @return
	 */
	public String updateDeptQuotaInfo(Object object);
	/**
	 * 修改定编信息
	 * @param object
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String updateDeptQuotaInfo(List objList) ;
	/**
	 * 将一个部门人员批量转移到其他部门
	 * @param objList
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String massTransferEmployees(List objList) ;
	
	public int checkDeptChildren(Object object);
}
