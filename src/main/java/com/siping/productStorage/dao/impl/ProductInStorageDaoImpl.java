package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.ProductInStorageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ProductInStorageDaoImpl extends SqlMapClientSupport implements ProductInStorageDao {

    @SuppressWarnings("rawtypes")
    @Override
    public List getProInColumns(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.proInStorage.getProInColumns", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getSupplierList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String productInStore(List objlist) throws Exception {
        String returnString = "Y";
        this.insertForList("prostor.proInStorage.productInStore", objlist);
        return returnString;
    }

    @Override
    public String getInStorageSerialNum() {
        String result = "";
        try {
            result = this.queryForObject("prostor.proInStorage.getInStorageSerialNum").toString();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public String addInStorageList(Object object) throws Exception {
        String returnInt = "Y";
        this.insert("prostor.proInStorage.addInStorageList", object);
        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getInstorageList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getInstorageList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public String updateInStorage(Object object) throws Exception {
        String resultString = "Y";
        this.update("prostor.proInStorage.updateInStorage", object);
        return resultString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseOrderList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getPurchaseOrderList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getPurchaseOrderList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getPurchaseOrderList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getPurchaseOrderListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.proInStorage.getPurchaseOrderListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public int getWaitingInStorageSum(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.proInStorage.getWaitingInStorageSum", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProductWaitingInfo(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getProductWaitingInfo", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getInStorHistoryList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getInStorHistoryList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getInStorHistoryList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getInStorHistoryList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getInStorHistoryListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.proInStorage.getInStorHistoryListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getInStorDetailList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getInStorDetailList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getInStorDetailList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.proInStorage.getInStorDetailList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getInStorDetailListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.proInStorage.getInStorDetailListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Map getInstorOrderById(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject("prostor.proInStorage.getInstorOrderById", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<LinkedHashMap> getInstorRecords(Map paramMap) {
        List<LinkedHashMap> list = new ArrayList<LinkedHashMap>();
        try {
            list = this.queryForList("prostor.proInStorage.getInstorRecords", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
