package com.siping.system.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.system.dao.LoginSupplierDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class LoginSupplierDaoImpl extends SqlMapClientSupport implements LoginSupplierDao {
	
	/**
	 * 取得登陆用户权限组列表
	 * @param List
	 * @return
	 */
	@SuppressWarnings({ "rawtypes" })
	@Override
	public List getLoginSupplierRolesGroupList(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.loginSupplier.getLoginSupplierRolesGroupList", obj);
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
	public Object getLoginSupplierInfoObj(Object obj) {
		Object returnObj = new Object() ;  
		try {
			returnObj =  this.queryForObject("system.loginSupplier.getLoginSupplierObj", obj) ;
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
	public List getLoginSupplierInfo(Object obj) {
		List returnList = new ArrayList() ;  
		try {
			returnList = this.queryForList("system.loginSupplier.getLoginSupplierInfo", obj);
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
	public int getLoginSupplierInfoCnt(Object obj) {
		int returnInt = 0 ; 
		try {
			returnInt = 
				NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("system.loginSupplier.getLoginSupplierInfoCnt", obj)), Integer.class) ;
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
	public List getLoginSupplierInfo(Object obj, int currentPage, int pageSize) {
		List returnList = new ArrayList() ;
		try { 
			returnList = this.queryForList("system.loginSupplier.getLoginSupplierInfo", obj, currentPage, pageSize);
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
	public String addLoginSupplierInfo(Object obj)throws SQLException {
		String resultString = "Y";
		try {
			this.insert("system.loginSupplier.addLoginSupplierInfo", obj) ;
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
	public String updateLoginSupplierInfo(Object obj) {
		String resultString = "Y";
		try {
			this.startTransaction() ;
			this.update("system.loginSupplier.updateLoginSupplierInfo", obj) ;
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
	public String deleteLoginSupplierInfo(Object obj) {
		String resultString = "Y";
		try {
			this.delete("system.loginSupplier.deleteLoginSupplierInfo", obj);
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
	public List getLoginSupplierDeptInfo(Object obj) {
		List returnList = new ArrayList() ;
		try {
			returnList = this.queryForList("system.loginSupplier.getLoginSupplierDeptInfo", obj);
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
			returnList = this.queryForList("system.loginSupplier.getRolesSelectList", obj);
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
					"system.loginSupplier.checkAdminID", obj).toString());
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return temp;
	}
	
}
