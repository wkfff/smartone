package com.siping.productStorage.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.siping.productStorage.bean.Product;

import org.springframework.stereotype.Repository;

import com.siping.productStorage.dao.ProductDao;
import com.siping.web.utility.SqlMapClientSupport;

@Repository
public class ProductDaoImpl extends SqlMapClientSupport implements ProductDao {

    @SuppressWarnings({"rawtypes"})
    public List getProductList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProductList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings({"rawtypes"})
    public List getProductList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProductList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getProductListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.product.getProductListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @Override
    public synchronized String addProduct(Object object) {
        String returnInt = "Y";
        try {
            this.insert("prostor.product.addProduct", object);
        } catch (SQLException e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        }
        return returnInt;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProColumns(Object object) {
        List returnList = new ArrayList();
        try {
            returnList = this.queryForList("prostor.product.getProColumns", object);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return returnList;
    }

    @Override
    public String updateProduct(Object object) {
        String resultString = "Y";
        try {
            this.update("prostor.product.updateProduct", object);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public int checkProductId(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.product.checkProductId", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String deleteProduct(List objlist) {
        String resultString = "Y";
        try {
            this.startTransaction();
            this.deleteForList("prostor.product.deleteProduct", objlist);
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

    @SuppressWarnings("rawtypes")
    @Override
    public List getProductSymple(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProductSymple", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProductByOrder(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProductByOrder", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProStorageDetail(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProStorageDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    @SuppressWarnings("rawtypes")
    @Override
    public List getProSaleDetail(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProSaleDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    @SuppressWarnings("rawtypes")
    @Override
    public List getProPropertyValueDetail(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProPropertyValueDetail", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProStorDetailList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProStorDetailList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProStorDetailList(Object object, int currentPage, int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProStorDetailList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getProStorDetailListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.product.getProStorDetailListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProSaleDetailList(Object object) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProSaleDetailList", object);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProSaleDetailList(Object object, int currentPage,
                                     int pageSize) {
        List list = new ArrayList();
        try {
            list = this.queryForList("prostor.product.getProSaleDetailList", object, currentPage, pageSize);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int getProSaleDetailListCnt(Object object) {
        int temp = 0;
        try {
            temp = Integer.parseInt(this.queryForObject("prostor.product.getProSaleDetailListCnt", object).toString());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return temp;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
    public List<Product> getProductsBySalesMode(Map paramMap) {
        List<Product> resultList = new ArrayList<Product>();
        try {
            resultList = this.queryForList("prostor.product.getProductsBySalesMode", paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public String addProductForList(List objList) {
        String returnInt = "Y";
        try {
            this.insertForList("prostor.product.addProduct", objList);
        } catch (SQLException e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        } catch (Exception e) {
            returnInt = e.getMessage();
            e.printStackTrace();
        }
        return returnInt;
    }
    
    @SuppressWarnings("rawtypes")
    @Override
    public String updateProductForListById(List objList) {
        String resultString = "Y";
        try {
            this.updateForList("prostor.product.updateProductById", objList);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }
    
    @Override
    public String getProductNoById(Object obj) {
        String resultString = "";
        try {
            resultString = (String)this.queryForObject("prostor.product.getProductNoById", obj);
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }

    @Override
    public String getProductIdSerial() {
        String resultString = "";
        try {
            resultString = (String)this.queryForObject("prostor.product.getProductIdSerial");
        } catch (SQLException e) {
            e.printStackTrace();
            resultString = e.getMessage();
        }
        return resultString;
    }


    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<HashMap> getTitles(Map tmpParamMap) {
        List resultList = null;
        try {
            resultList = this.queryForList("prostor.product.queryProColumnTitles", tmpParamMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public String[] getOptions(Map optionParamMap) {
        List list = null;
        try {
            list = this.queryForList("prostor.product.queryProCellOptions", optionParamMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return this.list2StringArray(list);
    }

    @SuppressWarnings("rawtypes")
    public String[] list2StringArray(List list) {
        if (list == null || list.size() == 0)
            return null;
        Object[] objects = list.toArray();
        String[] resultArray = new String[list.size()];
        // Cast Object[] to String[]
        for (int i = 0, j = 0; i < objects.length; i++) {
            if (objects[i] != null) {
                resultArray[j] = (String) objects[i];
                j++;
            }
        }
        return resultArray;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void createTmpProductInfo(Map map) throws Exception {
        this.update("prostor.product.createTempProInfo", map);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTmpProductTitles(List titleList) throws Exception {
        this.insertForList("prostor.product.updateTempProTitles", titleList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public void updateTmpProductInfo(List paramList) throws Exception {
        this.updateForList("prostor.product.updateTempProInfo", paramList);
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProColumnList() throws Exception {
        return this.queryForList("prostor.product.getProColumnList");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProTmpInfoList() throws Exception {
        return this.queryForList("prostor.product.getProTmpInfoList");
    }

    @Override
    public void modifyProTmpTable() throws Exception {
        this.update("prostor.product.modifyProTmpTable");
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getProInsertList(Map paramMap) throws Exception{
        return this.queryForList("prostor.product.getProInsertList", paramMap);
    }

    @Override
    public void insertPro(List<LinkedHashMap<String, Object>> requestListData) throws Exception{
        this.insertForList("prostor.product.insertPro", requestListData);
    }
}
