package com.siping.productStorage.dao.impl;

import com.siping.productStorage.bean.Product;
import com.siping.productStorage.bean.SYCode;
import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.dao.ProductSaleDao;
import com.siping.web.utility.SqlMapClientSupport;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ProductSaleDaoImpl extends SqlMapClientSupport implements ProductSaleDao {

    private static final String GET_SALE_ORDERS_RECORDS = "prostor.productSale.getSaleOrdersRecords";
    private static final String BUSINESS_DATA_READY = "businessDataReady";
    public static final String INSERT_SALES_ORDER = "prostor.productSale.insertSalesOrder";
    public static final String INSERT_PRODUCT_IN_SALES_ORDER = "prostor.productSale.insertProductInSalesOrder";
    public static final String GET_SALES_ORDER_ID_SERIAL_NUM = "prostor.productSale.getSalesOrderIdSerialNum";
    public static final String SUCCESS = "Y";
    public static final String FAIL = "N";
    public static final String GET_ALL_SALES_ORDER = "prostor.productSale.getAllSalesOrder";
    public static final String GET_ALL_SALES_ORDERS_COUNT = "prostor.productSale.getAllSalesOrdersCount";
    public static final String GET_SALES_ORDER = "prostor.productSale.getSalesOrder";
    public static final String GET_SALES_ORDER_BY_ID = "prostor.productSale.getSalesOrderById";
    public static final String SEARCH_SALES_ORDER = "prostor.productSale.searchSalesOrder";
    public static final String DELETE_SALES_ORDER = "prostor.productSale.deleteSalesOrder";
    public static final String DELETE_SALES_ORDER_DETAIL = "prostor.productSale.deleteSalesOrderDetail";
    public static final String GET_SALESORDER_INFO = "prostor.productSale.getSalesOrderInfo";
    public static final String GET_DETAIL_FORCHECK = "prostor.productSale.getSalesOrderDetailForCheck";
    public static final String GET_DETAIL_FORCHECK_CNT = "prostor.productSale.getSalesOrderDetailForCheckCnt";
    public static final String UPDATE_ORDER_STATUS0 = "prostor.productSale.updateSalesOrderStatus0";
    public static final String UPDATE_ORDER_STATUS1 = "prostor.productSale.updateSalesOrderStatus1";
    public static final String GET_PRODUCT_BY_SALESORDER = "prostor.productSale.getProductBySalesOrder";
    @Autowired
    private RuntimeService runtimeService;
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String insertSalesOrder(SalesOrder obj) throws Exception {
        String result = SUCCESS;
        String processID = "";
    /*        Object approverId = "";
        Map checkMap = this.systemSer.getApproverId("CheckType002");
        if(checkMap!=null){
            Object checkKey = checkMap.get("CHECK_KEY");
            approverId = checkMap.get("APPROVERID");
            if (checkKey.toString().equals("1") && approverId == null) {
                return "检测到系统还没有设置销售单审核人，请联系系统管理员";
            }
            if (checkKey.toString().equals("1")) {
                String serialNum = obj.getSalesOrderId();
                Map processParam = new LinkedHashMap<String, Object>();
                processParam.put("salesLink", "<a href='javascript:spf_checkSalesOrder(" + serialNum + ")'>点击查看需要审核的信息</a>");
                processParam.put("leader", approverId);
                processParam.put("accountant", "");
                ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("SalesOrderProcess", processParam);
                processID = processInstance.getProcessInstanceId();
            }
        }*/
        ProcessInstance processInstance = null;
        if (obj.getTaobaoOrderId()==null||"".equals(obj.getTaobaoOrderId())) {
            String serialNum = obj.getSalesOrderId();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            String currentTime = formatter.format(new Date());
            Map processParam = new LinkedHashMap<String, Object>();
            processParam.put("empid", obj.getOwner().getEmpId());
            processParam.put("applicant", obj.getOwner().getEmpName());
            processParam.put("application_time", currentTime);
            processParam.put("salesLink", "<a href='javascript:spf_checkSalesOrder(\"" + serialNum + "\")'>点击查看需要审核的信息</a>");
            processInstance = runtimeService.startProcessInstanceByKey("SalesOrderProcess", processParam);
            processID = processInstance.getProcessInstanceId();
            obj.setProcessid(processID);

            SYCode sycode = new SYCode();
            sycode.setCodeId("affirm0");
            obj.setAffirmFlag(sycode);
        }else{
            SYCode sycode = new SYCode();
            sycode.setCodeId("affirm1");
            obj.setAffirmFlag(sycode);
        }

        this.insert(INSERT_SALES_ORDER, obj);
        this.insert(INSERT_PRODUCT_IN_SALES_ORDER, obj);

        if(processInstance != null){
            Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId()).activityId(BUSINESS_DATA_READY).singleResult();
            if (execution != null) {
                runtimeService.signal(execution.getId());
            }
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesOrder> getAllSalesOrders(Object obj) {
        List<SalesOrder> resultList = null;
        try {
            resultList = this.queryForList(GET_ALL_SALES_ORDER, obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesOrder> getAllSalesOrders(Object obj, int page, int pagesize) {
        List<SalesOrder> resultList = null;
        try {
            resultList = this.queryForList(GET_ALL_SALES_ORDER, obj, page, pagesize);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public int getAllSalesOrdersCount(Object obj) {
        int result = 0;
        try {
            result = (Integer) this.queryForObject(GET_ALL_SALES_ORDERS_COUNT, obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public SalesOrder getSalesOrder(Object obj) {
        SalesOrder result = null;
        try {
            result = (SalesOrder) this.queryForObject(GET_SALES_ORDER, obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    
    @Override
    public SalesOrder getSalesOrderById(Object obj) {
        SalesOrder result = null;
        try {
            result = (SalesOrder) this.queryForObject(GET_SALES_ORDER_BY_ID, obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    @Override
    public String getSalesOrderId() {
        String result = FAIL;
        try {
            result = (String) this.getSqlMapClient().queryForObject(GET_SALES_ORDER_ID_SERIAL_NUM);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<SalesOrder> searchSalesOrder(Object obj) {
        List<SalesOrder> resultList = null;
        try {
            resultList = this.queryForList(SEARCH_SALES_ORDER, obj);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @Override
    public String deleteSalesOrder(Object obj) {
        String result = SUCCESS;
        try {
            startTransaction();
            this.delete(DELETE_SALES_ORDER, obj);
            this.delete(DELETE_SALES_ORDER_DETAIL, obj);
            commitTransation();
        } catch (Exception e) {
            e.printStackTrace();
            result = FAIL;
        } finally {
            try {
                endTransation();
            } catch (Exception e) {
                e.printStackTrace();
                result = FAIL;
            }
        }
        return result;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSalesOrderDetailForCheck(Object object, int currentPage, int pageSize) throws Exception {
        List returnList = null;
        returnList = this.queryForList(GET_DETAIL_FORCHECK, object, currentPage, pageSize);
        return returnList;
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSalesOrderDetailForCheck(Object object) throws Exception {
        List returnList = null;
        returnList = this.queryForList(GET_DETAIL_FORCHECK, object);
        return returnList;
    }

    @Override
    public int getSalesOrderDetailForCheckCnt(Object object) throws Exception {
        int returnCnt = 0;
        returnCnt = (Integer) this.queryForObject(GET_DETAIL_FORCHECK_CNT, object);
        return returnCnt;
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public Map getSalesOrderInfo(Object object) throws Exception {
        Map returnMap = null;
        returnMap = (Map) this.queryForObject(GET_SALESORDER_INFO, object);
        return returnMap;
    }

    @Override
    public String updateSalesOrderStatus0(Object object) throws Exception {
        String returnMsg = "N";
        try {
            this.update(UPDATE_ORDER_STATUS0, object);
            returnMsg = "Y";
        } catch (SQLException e) {
            e.printStackTrace();
            returnMsg = "Data Update Error";
        }
        return returnMsg;
    }

    @Override
    public String updateSalesOrderStatus1(Object object) throws Exception {
        String returnMsg = "N";
        try {
            this.update(UPDATE_ORDER_STATUS1, object);
            returnMsg = "Y";
        } catch (SQLException e) {
            e.printStackTrace();
            returnMsg = "Data Update Error";
        }
        return returnMsg;
    }

    @SuppressWarnings("unchecked")
    @Override
    public List<Product> getProductBySalesOrder(Object object) {
        List<Product> resultList = null;
        try {
            resultList = this.queryForList(GET_PRODUCT_BY_SALESORDER,object);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List<LinkedHashMap> getSaleOrdersRecords(Map paramMap) {
        List<LinkedHashMap> list = new ArrayList<LinkedHashMap>();
        try {
            list = this.queryForList(GET_SALE_ORDERS_RECORDS, paramMap);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
