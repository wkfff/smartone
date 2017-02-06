package com.siping.system.dao;
 
import java.util.List;
import java.util.Map;

public interface RolesGroupDao {
	/**
	 * 获取角色信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public Map getRolesGroupInfoObj(Object obj) ;
	/**
	 * 获取角色信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getRolesGroupInfo(Object obj) ;
	/**
	 * 获取菜单信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	public List getMenuSelectList(Object obj) ;
	/**
	 * 获取角色信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getRolesGroupInfo(Object object, int currentPage, int pageSize);
	/**
	 * 获取角色信息
	 * @param object 
	 * @return
	 */ 
	public int getRolesGroupInfoCnt(Object object);
	/**
	 * 获取角色ID
	 * @param object 
	 * @return
	 */ 
	public int getRolesGroupID(Object object);
	
	/**
	 * 添加角色信息
	 * @param object
	 * @return
	 */ 
	public int addRolesGroupInfo(Object object); 
	/**
	 * 添加角色信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public int addRolesGroupInfo(List object); 
	/**
	 * 修改角色信息
	 * @param object
	 * @return
	 */  
	public int updateRolesGroupInfo(Object object); 
	/**
	 * 修改角色信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public int updateRolesGroupInfo(List object); 
	/**
	 * 删除角色信息
	 * @param object
	 * @return
	 */ 
	public int deleteRolesGroupInfo(Object object); 
	/**
	 * 删除角色信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public int deleteRolesGroupInfo(List object); 
	/**
	 * 获取角色页面信息
	 * @param object
	 * @return
	 */ 
	@SuppressWarnings({ "rawtypes" })
	public List getRolesGroupPageInfo(Object object);
	/**
	 * 获取角色页面信息
	 * @param object
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	public List getRolesGroupPageInfo(Object object, int currentPage, int pageSize); 
	/**
	 * 获取角色页面信息
	 * @param object
	 * @return
	 */
	public int getRolesGroupPageInfoCnt(Object object);

	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object object);
	
	@SuppressWarnings({ "rawtypes" })
	public List getSystemMenuInfo(Object object, int currentPage, int pageSize);

	public int getSystemMenuInfoCnt(Object object);
}
