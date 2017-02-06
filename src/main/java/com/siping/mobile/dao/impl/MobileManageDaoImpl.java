package com.siping.mobile.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.siping.mobile.dao.MobileManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class MobileManageDaoImpl extends SqlMapClientSupport implements MobileManageDao {
    @SuppressWarnings({"rawtypes"})
    public List getMobileAreaList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("mobile.mobileManage.getMobileAreaList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings({"rawtypes"})
    public List getMobileAreaList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("mobile.mobileManage.getMobileAreaList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getMobileAreaListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("mobile.mobileManage.getMobileAreaListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }
    
    @Override
    public String deleteMobileArea(Object obj) {
        String result = "Y";
        try {
            this.delete("mobile.mobileManage.deleteMobileArea",obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public String addMobileAreaInfo(List list) {
        String result = "Y";
        try {
            this.insertForList("mobile.mobileManage.addMobileAreaInfo",list);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public String updateMobileAreaInfo(List list) {
        String result = "Y";
        try {
            this.updateForList("mobile.mobileManage.updateMobileAreaInfo",list);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @Override
    public String deleteProductByArea(Object obj) {
        String result = "Y";
        try {
            this.delete("mobile.mobileManage.deleteProductByArea",obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public String saveProductToArea(List list) {
        String result = "Y";
        try {
            this.insertForList("mobile.mobileManage.saveProductToArea",list);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @SuppressWarnings({"rawtypes"})
    public List getMobileAdv(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("mobile.mobileManage.getMobileAdv", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getMobileAdvCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("mobile.mobileManage.getMobileAdvCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }
    
    @Override
    public String addOrUpdateMobileAdv(Object obj) {
        String result = "Y";
        try {
            this.insert("mobile.mobileManage.addOrUpdateMobileAdv",obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @Override
    public String deleteMobileAdv(Object obj) {
        String result = "Y";
        try {
            this.delete("mobile.mobileManage.deleteMobileAdv",obj);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
    
    @Override
    public String getSalesModeNoByCu(String CUST_ID) {
        String result = "";
        try {
            result = (String) this.queryForObject("mobile.mobileManage.getSalesModeNoByCu",CUST_ID);
        } catch (SQLException e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        return result;
    }
}
