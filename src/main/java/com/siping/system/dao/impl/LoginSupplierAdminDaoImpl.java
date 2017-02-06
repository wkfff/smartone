package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.LoginSupplierAdminDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class LoginSupplierAdminDaoImpl extends SqlMapClientSupport implements LoginSupplierAdminDao {
	
	/**
	 * 取得登陆用户权限组列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierAdminRolesGroupList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.loginSupplierAdmin.getLoginSupplierAdminRolesGroupList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		}
		
		return returnList ;
	} 
	/**
	 * 取得登陆用户信息
	 * @param List
	 * @return
	 */ 
	@Override
	public Object getLoginSupplierAdminInfoObj(Object obj) {
		Object returnObj = new Object() ;  
		try {
			returnObj =  this.queryForObject("system.loginSupplierAdmin.getLoginSupplierAdminObj", obj) ;
		} catch (SQLException e) { 
			e.printStackTrace();
		}  
		return returnObj ;
	} 
	/**
	 * 取得所有登陆用户列表
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierAdminInfo(Object obj) {
		List returnList = new ArrayList() ;  
		try {
			returnList = this.queryForList("system.loginSupplierAdmin.getLoginSupplierAdminInfo", obj);
		} catch (SQLException e) { 
			e.printStackTrace();
		} 
		return returnList ;
	}
	/**
	 * 取得所有登陆用户列表
	 * @param obj
	 * @return
	 */
	@Override
	public int getLoginSupplierAdminInfoCnt(Object obj) {
		int returnInt = 0 ; 
		try {
			returnInt = 
				NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.loginSupplierAdmin.getLoginSupplierAdminInfoCnt", obj)), Integer.class) ;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return returnInt ;
	} 
	/**
	 * 取得所有登陆用户列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierAdminInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try { 
			returnList = this.queryForList("system.loginSupplierAdmin.getLoginSupplierAdminInfo", obj, currentPage, pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return returnList ;
	} 
	/**
	 * 插入登陆者信息
	 * @param obj
	 * @return
	 */ 
	@SuppressWarnings("rawtypes")
	@Override
	public String addLoginSupplierAdminInfo(Object obj)throws SQLException {
		String resultString = "Y";
		try {
			this.insert("system.loginSupplierAdmin.addLoginSupplierAdminInfo", obj) ;
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString;
	} 
	/**
	 * 更新登陆用户信息
	 * @param obj
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public String updateLoginSupplierAdminInfo(Object obj) {
		String resultString = "Y";
		try {
			this.startTransaction() ;
			this.update("system.loginSupplierAdmin.updateLoginSupplierAdminInfo", obj) ;
			this.commitTransation() ;
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		finally {
			try {
				this.endTransation() ;
			} catch (Exception e) {
				e.printStackTrace();
			}
		 } 
		return resultString ;
	} 
	/**
	 * 删除登陆用户信息
	 * @param obj
	 * @return
	 */ 
	@Override
	public String deleteLoginSupplierAdminInfo(Object obj) {
		String resultString = "Y";
		try {
			this.delete("system.loginSupplierAdmin.deleteLoginSupplierAdminInfo", obj);
		} catch (SQLException e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}
		return resultString ;
	}
	
	/**
	 * 取得所有登陆用户部门权限信息列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierAdminDeptInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.loginSupplierAdmin.getLoginSupplierAdminDeptInfo", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		} 
		return returnList ;
	}
	
	/**
	 * 取得角色信息列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getRolesSelectList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.loginSupplierAdmin.getRolesSelectList", obj);
		} catch (SQLException e) {			
			e.printStackTrace();
		} 
		return returnList ;
	}
	
	@Override
	public int checkAdminID(Object obj) {
		int temp = 0;
		try {
			temp = Integer.parseInt(this.queryForObject(
					"system.loginSupplierAdmin.checkAdminID", obj).toString());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	
}
