package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.ProductStorageManageDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ProductStorageManageDaoImpl extends SqlMapClientSupport implements ProductStorageManageDao{

    @SuppressWarnings("rawtypes")
    @Override
    public List getSaleOrderList(Object object, int currentPage, int pageSize) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.getSaleOrderList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getSaleOrderListCnt(Object object) {
        int orderCnt = 0;
        try {
            orderCnt = (Integer) this.queryForObject("productStorage.proStorageManage.getSaleOrderListCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderCnt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSalesOrderDetail(Object object, int currentPage, int pageSize) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.getSalesOrderDetail", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getSalesOrderDetailCnt(Object object) {
        int orderCnt = 0;
        try {
            orderCnt = (Integer) this.queryForObject("productStorage.proStorageManage.getSalesOrderDetailCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderCnt;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public List getSalesOrderInfo(Object object, int currentPage, int pageSize) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.getSalesOrderInfo", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getSalesOrderInfoCnt(Object object) {
        int orderCnt = 0;
        try {
            orderCnt = (Integer) this.queryForObject("productStorage.proStorageManage.getSalesOrderInfoCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderCnt;
    }

    @Override
    public Double getLeftQuantity(Object object) {
        double proCnt = 0;
        try {
            proCnt = (Double) this.queryForObject("productStorage.proStorageManage.getLeftQuantity", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proCnt;
    }

    @Override
    public String insertOutDetailForList(List<LinkedHashMap<String, Object>> jsonList) throws Exception {
        String returnString = "N";
        this.insertForList("productStorage.proStorageManage.insertOutDetail", jsonList);
        for(LinkedHashMap<String, Object> returnMap : jsonList){
            returnString = returnMap.get("returnMsg").toString();
            if(returnString.equals("Y")){
                break;
            }
        }
        return returnString;
    }

    @Override
    public String insertOutInfo(Object object) throws Exception {
        this.insert("productStorage.proStorageManage.insertOutInfo", object);
        return "Y";
    }

    @Override
    public String getSerialNum() {
        String returnString = "";
        try {
            returnString = this.queryForObject("productStorage.proStorageManage.getSerialNum").toString();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List viewOutStorHistoryList(Object object, int currentPage, int pageSize) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.viewOutStorHistoryList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int viewOutStorHistoryListCnt(Object object) {
        int listCnt = 0;
        try {
            listCnt = (Integer) this.queryForObject("productStorage.proStorageManage.viewOutStorHistoryListCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCnt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List viewOutStorHistoryDetail(Object object, int currentPage, int pageSize) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.viewOutStorHistoryDetail", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int viewOutStorHistoryDetailCnt(Object object) {
        int listCnt = 0;
        try {
            listCnt = (Integer) this.queryForObject("productStorage.proStorageManage.viewOutStorHistoryDetailCnt", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listCnt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String getOutStorExcelColumnInfo(Object object) {
        String returnString = "";
        List<LinkedHashMap> returnList;
        try {
            returnList = this.queryForList("productStorage.proStorageManage.getOutStorExcelColumnInfo", object);
            for(LinkedHashMap paraMap : returnList){
                returnString += paraMap.get("COLUMN_NAME").toString() + ",";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<String> getOutStorExcelTitleInfo(Object object) {
        List returnList = new ArrayList();
        LinkedHashMap paramMap = (LinkedHashMap) object;
        List codeList = (List) paramMap.get("codeList");
        try {
            for (int i = 0; i < codeList.size(); i++) {
                paramMap.put("ITEM_ID", codeList.get(i).toString());
                Object  titleName= this.queryForObject("productStorage.proStorageManage.getOutStorExcelTitleInfo", paramMap);
                returnList.add(titleName.toString());
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked"})
    @Override
    public List<LinkedHashMap> getOutStorDatasource(Map paramMap) {
        List<LinkedHashMap> returnList = new ArrayList<LinkedHashMap>();
        try {
            returnList = this.queryForList("productStorage.proStorageManage.viewOutStorHistoryDetail", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public Double getMinStorQuantity(Object object) {
        double minCnt = 0;
        try {
            minCnt = (Double) this.queryForObject("productStorage.proStorageManage.getMinStorQuantity", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return minCnt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public Map getOutstorageOrderById(Object object) {
        Map tempMap = new LinkedHashMap<Object, Object>();
        try {
            tempMap = (Map) this.queryForObject(
                    "productStorage.proStorageManage.getOutstorageOrderById", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tempMap;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List viewOutStorHistoryDetail(Object object) {
        List list = null;
        try {
            list = this.queryForList("productStorage.proStorageManage.viewOutStorHistoryDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public LinkedHashMap<String, Object> viewSaleOrderDetail(Map paramMap) throws Exception {
        return (LinkedHashMap<String, Object>) this.queryForObject("productStorage.proStorageManage.viewSaleOrderDetail", paramMap);
    }

    @Override
    public String checkReceiverPhoneNum(String saleOrderNo) throws Exception {
        return this.queryForObject("productStorage.proStorageManage.checkReceiverPhoneNum", saleOrderNo).toString();
    }
}
