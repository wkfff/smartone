package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ObjectUtils;
import org.springframework.stereotype.Repository;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.dao.PurchaseOrderDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class PurchaseOrderDaoImpl extends SqlMapClientSupport implements PurchaseOrderDao {

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplier(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getSupplier", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierProduct(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getSupplierProduct", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public String addPurchaseOrder(Object object) throws Exception {
        String result = "Y";
        this.insert("prostor.purchaseOrder.addPurchaseOrder", object);
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String addPurchaseOrderDetail(List objList) throws Exception {
        String result = "Y";
        this.insertForList("prostor.purchaseOrder.addPurchaseOrderDetail", objList);
        return result;
    }

    @SuppressWarnings({})
    @Override
    public String getPurchaseSerialNum(Object obj) {
        String result = "";
        try {
            result = this.queryForObject("prostor.purchaseOrder.getPurchaseSerialNum", obj).toString();
        } catch (SQLException e) {
            result = e.getMessage();
            e.printStackTrace();
        }
        return result;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPurchaseOrderList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getPurchaseOrderList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseOrderList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getPurchaseOrderList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public int getPurchaseOrderCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("prostor.purchaseOrder.getPurchaseOrderCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseOrderDetailList(Object object, int currentPage, int pageSize) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getPurchaseOrderDetailList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseOrderDetailList(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.purchaseOrder.getPurchaseOrderDetailList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnList;
    }
    @Override
    public int getPurchaseOrderDetailCnt(Object object) {
        int returnInt = 0;
        try {
            returnInt = NumberUtils.parseNumber(ObjectUtils.toString(this.queryForObject("prostor.purchaseOrder.getPurchaseOrderDetailCnt", object)), Integer.class);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnInt;
    }

    @Override
    public String deletePurchaseOrder(Object object) {
        String resultString = "Y";
        try {
            this.update("prostor.purchaseOrder.deletePurchaseOrder", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Map getPurchaseOrder(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject("prostor.purchaseOrder.getPurchaseOrder", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    @Override
    public String updatePurchaseOrder(Object object) throws SQLException {
        String resultString = "Y";
        this.update("prostor.purchaseOrder.updatePurchaseOrder", object);
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String updatePurchaseOrderDetail(List objList) {
        String resultString = "Y";
        try {
            this.updateForList("prostor.purchaseOrder.updatePurchaseOrderDetail", objList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String deletePurchaseOrderDetail(Object object) {
        String resultString = "Y";
        try {
            this.update("prostor.purchaseOrder.deletePurchaseOrderDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }
    
    @SuppressWarnings({})
    @Override
    public String getPurchaseOrderId(Object obj) {
        String result = "";
        try {
            result = this.queryForObject("prostor.purchaseOrder.getPurchaseOrderId", obj).toString();
        } catch (SQLException e) {
            result = e.getMessage();
            e.printStackTrace();
        }
        return result;
    }
}
