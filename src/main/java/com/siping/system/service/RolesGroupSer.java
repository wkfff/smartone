package com.siping.system.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface RolesGroupSer { 
	/**
	 * 获取角色信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getRolesGroupInfo(HttpServletRequest request) ;
	/**
	 * 获取菜单信息 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public List getMenuSelectList(HttpServletRequest request) ;
	/**
	 * 获取角色信息
	 * @param request
	 * @return
	 */  
	@SuppressWarnings("rawtypes")
	public Map getRolesGroupInfoObj(HttpServletRequest request) ;
	/**
	 * 获取角色信息
	 * @param request
	 * @return
	 */  
	public int getRolesGroupInfoCnt(HttpServletRequest request) ;
	/**
	 * 获取角色ID
	 * @param request
	 * @return
	 */  
	public int getRolesGroupID(HttpServletRequest request) ; 
	/**
	 * 角色信息添加 
	 * @param request
	 * @return
	 */
	public int addRolesGroupInfo(HttpServletRequest request) ;
	/**
	 * 修改角色信息
	 * @param request
	 * @return
	 */  
	public int updateRolesGroupInfo(HttpServletRequest request) ;
	/**
	 * 删除角色信息
	 * @param request
	 * @return
	 */ 
	public int deleteRolesGroupInfo(HttpServletRequest request) ;
	/**
	 * 获取角色页面信息
	 * @param request
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getRolesGroupPageInfo(HttpServletRequest request) ;
	/**
	 * 获取角色页面信息
	 * @param request
	 * @return
	 */  
	public int getRolesGroupPageInfoCnt(HttpServletRequest request) ;
	

	@SuppressWarnings("rawtypes")
	public List getSystemMenuInfo(HttpServletRequest request) ;
	 
	public int getSystemMenuInfoCnt(HttpServletRequest request) ;
}
