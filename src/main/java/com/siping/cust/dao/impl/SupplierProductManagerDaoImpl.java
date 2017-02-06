package com.siping.cust.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.cust.dao.SupplierProductManagerDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SupplierProductManagerDaoImpl extends SqlMapClientSupport implements SupplierProductManagerDao {

	
	@Override
	public String addProduct(Object object) {
		String returnString="Y";
		 try {
				 this.insert("cust.SupplierProduct.addNewSupplierProduct",object);
		} catch (SQLException e) {
			e.printStackTrace();
			returnString=e.getMessage();
		}
		 return returnString;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getSupplierProductList(Object object, int currentPage,
			int pageSize) {
		List list=new ArrayList();
		try {
			list=this.queryForList("cust.SupplierProduct.getSupplierProductList",object,currentPage,pageSize);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String deleteSupplierProduct(List list) {
		String returnString="Y";
		try {
			this.deleteForList("cust.SupplierProduct.deleteSupplierProduct",list);
		} catch (SQLException e) {
			
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}

	@Override
	public String updateSupplierProduct(Object object) {
		String returnString="Y";
		try {
			this.update("cust.SupplierProduct.updateSupplierProduct",object);
		} catch (SQLException e) {
			returnString=e.getMessage();
			e.printStackTrace();
		}
		return returnString;
	}

	@Override
	public int getSupplierProductCnt(Object object) {
		int temp=0;
		try {
			temp=Integer.parseInt(this.queryForObject("cust.SupplierProduct.getSupplierProductCnt",object).toString());
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return temp;
	}

    @Override
    public int checkSupplierProIdCnt(Object object) {
        int temp=0;
        try {
            temp=Integer.parseInt(this.queryForObject("cust.SupplierProduct.checkSupplierProIdCnt",object).toString());
        } catch (Exception e) {
            e.printStackTrace();
        } 
        return temp;
    }

}
