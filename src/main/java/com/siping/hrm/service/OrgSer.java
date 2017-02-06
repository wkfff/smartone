package com.siping.hrm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface OrgSer { 
	/**
	 * 部门信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfo(HttpServletRequest request);
	/**
	 * 部门信息
	 * @param request
	 * @return
	 */ 
	public int getDeptInfoCnt(HttpServletRequest request);
	/**
	 * 部门信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public Map getDeptInfoObj(HttpServletRequest request);
	/**
	 * 修改部门信息
	 * @param request
	 * @return
	 */
	public String updateDeptInfo(HttpServletRequest request) ;
	/**
	 * 增加部门信息
	 * @param request
	 * @return
	 */
	public String addDeptInfo(HttpServletRequest request) ;
	/**
	 * 删除部门信息
	 * @param request
	 * @return
	 */
	public String deleteDeptInfo(HttpServletRequest request) ; 
	/**
	 * 部门信息
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptInfoTree(HttpServletRequest request);	 
	/**
	 * 部门信息
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getDeptLevel(Map param);
	/**
	 * 定编信息
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getDeptQuotaList(HttpServletRequest request);
	/**
	 * 定编信息
	 * @param request
	 * @return
	 */
	public int getDeptQuotaListCnt(HttpServletRequest request);
	/**
	 * 增加定编信息
	 * @param request
	 * @return
	 */
	public String addDeptQuotaInfo(HttpServletRequest request) ;
	/**
	 * 修改定编信息
	 * @param request
	 * @return
	 */
	public String updateDeptQuotaInfo(HttpServletRequest request);
	/**
	 * 删除定编信息
	 * @param request
	 * @return
	 */
	public String deleteDeptQuotaInfo(HttpServletRequest request) ; 
	/**
	 * 将一个部门人员批量转移到其他部门
	 * @param request
	 * @return
	 */
	public String massTransferEmployees(HttpServletRequest request);
	
	public int checkDeptChildren(HttpServletRequest request);
}




