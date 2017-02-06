package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.cust.dao.SupplierAccountSelfManagerDao;
import com.siping.web.utility.SqlMapClientSupport;
@Repository
public  class SupplierAccountSelfManagerDaoImpl  extends SqlMapClientSupport   implements SupplierAccountSelfManagerDao {

	@Override
	public String addSupplierAccountSelf(Object object) {
		String returnString="Y";
		try {
			this.insert("cust.supplierAccountSelf.insertSupplierAccountSelf",object);
		} catch (SQLException e) {
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}

	@Override
	public String updateSupplierAccountSelf(Object object) {
		String resultString="Y";
		try {
			this.update("cust.supplierAccountSelf.updateSupplierAccountSelf",object);
		} catch (SQLException e) {
			resultString=e.getMessage();
			e.printStackTrace();
		}
		return resultString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getSupplierAccountSelf(Object object, int currentPage, int pageSize) {
		List list=new ArrayList();
		try {
			list=this.queryForList("cust.supplierAccountSelf.getSupplierAccountSelfList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int getSupplierAccountSelfCnt(Object object) {
		
		int temp=0;
	    try {
			temp= Integer.parseInt(this.queryForObject("cust.supplierAccountSelf.getSupplierAccountSelfCnt",object).toString());
		} catch (NumberFormatException e) {
			
			e.printStackTrace();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	    return temp;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSupplierAccountSelf(List objectList) {
		String returnString="Y";
		try {
			this.deleteForList("cust.supplierAccountSelf.deleteSupplierAccountSelf",objectList);
		} catch (SQLException e) {
			
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}
//查找用户名是否存在
	@Override
	public String checkUsernameExist(Object object) {
		String returnString="NoExist";
		int temp=0;
		try {
			temp=Integer.parseInt(this.queryForObject("cust.supplierAccountSelf.checkUsernameExist",object).toString());
			if(temp>0)
			{
				returnString="Exist";
			}
		} catch (SQLException e) {
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString ;
	}

	@Override
	public int getSupplierByPassword(Object object) {
		
		int temp=0;
		try {
			temp=Integer.parseInt(this.queryForObject("cust.supplierAccountSelf.getSupplierByPassword", object).toString());
		} catch (Exception e) {
			
			e.printStackTrace();
		} 
		return temp;
	}

	@Override
	public String updateSupplierPassword(Object object) {
		
		String returnString="Y";
		try {
			this.update("cust.supplierAccountSelf.updateSupplierPassword",object);
		} catch (SQLException e) {
			
			
			e.printStackTrace();
			returnString=e.getMessage();
		}
		return returnString;
	}

	@Override
	public String toggleSupplierActivity(Object object) {
		
		String returnString="Y";
		try {
			this.update("cust.supplierAccountSelf.toggleSupplierActivity",object);
		} catch (SQLException e) {
			
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}

	

}
