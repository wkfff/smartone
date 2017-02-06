package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.siping.productStorage.bean.SalesMode;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.SalesModelDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class SalesModelDaoImpl extends SqlMapClientSupport implements SalesModelDao {

    @SuppressWarnings({ "rawtypes" })
    public List getSalesModelList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.salesmodel.getSalesModelList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes" })
    public List getSalesModelList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.salesmodel.getSalesModelList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getSalesModelListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.salesmodel.getSalesModelListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public String addSalesModel(Object object) {
        String resultString = "Y";
        try {
            this.insert("prostor.salesmodel.addSalesModel", object);
        } catch (SQLException e) {
            resultString = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            resultString = e.getMessage();
            e.printStackTrace();
        }
        return resultString;
    }

    @Override
    public String updateSalesModel(Object object) {
        String resultString = "Y";
        try {
            this.update("prostor.salesmodel.updateSalesModel", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String deleteSalesModel(List objlist) {
        String resultString = "Y";
        try {
            this.startTransaction();
            this.deleteForList("prostor.salesmodel.deleteSalesModel", objlist);
            this.commitTransation();
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        } finally {
            try {
                this.endTransation();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return resultString;
    }

    @Override
    public int checkSalesDistri(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.salesmodel.checkSalesDistri", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesMode> getAllSalesModes() {
        List<SalesMode> result = null;
        try {
            result = this.queryForList("prostor.salesmodel.getAllSalesModes");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public String updateSalesMobileStatus(Object object) {
        String resultString = "Y";
        try {
            this.update("prostor.salesmodel.updateSalesMobileStatus", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }
}
