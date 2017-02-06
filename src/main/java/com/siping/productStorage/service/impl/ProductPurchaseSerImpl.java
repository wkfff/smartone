package com.siping.productStorage.service.impl;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.RuntimeService;
import org.activiti.engine.runtime.Execution;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.dao.PurchaseOrderDao;
import com.siping.productStorage.service.ProductPurchaseSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.system.service.SystemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.SqlMapClientSupport;
import com.siping.web.utility.StringUtil;

@Service
public class ProductPurchaseSerImpl extends SqlMapClientSupport implements ProductPurchaseSer {

    private static final String BUSINESS_DATA_READY = "businessDataReady";
    Logger logger = Logger.getLogger(ProductPurchaseSerImpl.class);
    @Autowired
    private PurchaseOrderDao purchaseOrderDao;
    @Autowired
    private RuntimeService runtimeService;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSupplier(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.getSupplier(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSupplierProduct(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.getSupplierProduct(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String addPurchaseOrder(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        String processID = "";
        // 获取流水号
        LinkedHashMap<String, Object> serialNumMap = new LinkedHashMap<String, Object>();
        serialNumMap.put("PURCHASE_ID", "");
        String serialNum = this.purchaseOrderDao.getPurchaseSerialNum(serialNumMap);

        // 获取向PROSTOR_PURCHASE_ORDER插入的参数
        LinkedHashMap paramMapForOrder = ObjectBindUtil.getRequestParamData(request);

        Map processParam = new LinkedHashMap<String, Object>();
        processParam.put("purchaseLink", "<a href='javascript:spf_checkPurchaseOrder(\"" + serialNum + "\")'>点击查看需要审核的信息</a>");
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        String currentTime = formatter.format(new Date());
        processParam.put("empid", paramMapForOrder.get("EMPID"));
        processParam.put("applicant",paramMapForOrder.get("EMP_NAME"));
        processParam.put("application_time", currentTime);
        ProcessInstance processInstance = runtimeService.startProcessInstanceByKey("PurchaseOrderProcess", processParam);
        processID = processInstance.getProcessInstanceId();

        paramMapForOrder.put("CPNY_ID", admin.getCpnyId());
        paramMapForOrder.put("CREATED_BY", admin.getAdminID());
        paramMapForOrder.put("SERIAL_NUM", serialNum);
        paramMapForOrder.put("PROCESSID", processID);

        // 获取向PROSTOR_PURCHAER_ORDER_DETAIL插入的参数
        String jsonString = request.getParameter("jsonData");
        List<LinkedHashMap<String, Object>> paramListForDetail = ObjectBindUtil.getRequestJsonData(jsonString);
        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> map = null;
        for (int i = 0; i < paramListForDetail.size(); i++) {
            map = paramListForDetail.get(i);
            map.put("CPNY_ID", admin.getCpnyId());
            map.put("CREATED_BY", admin.getAdminID());
            map.put("SERIAL_NUM", serialNum);
            list.add(map);
        }

        this.purchaseOrderDao.addPurchaseOrder(paramMapForOrder);// 向采购单中添加
        this.purchaseOrderDao.addPurchaseOrderDetail(list);// 向采购单详情中添加

        Execution execution = runtimeService.createExecutionQuery().processInstanceId(processInstance.getProcessInstanceId())
            .activityId(BUSINESS_DATA_READY).singleResult();
        if(execution!=null){
            runtimeService.signal(execution.getId());
        }
        return "Y";
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPurchaseOrderList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.purchaseOrderDao.getPurchaseOrderList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.purchaseOrderDao.getPurchaseOrderList(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getPurchaseOrderCnt(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.getPurchaseOrderCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getPurchaseOrderDetailList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.purchaseOrderDao.getPurchaseOrderDetailList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.purchaseOrderDao.getPurchaseOrderDetailList(paramMap);
        }

        return retrunList;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getPurchaseOrderDetailCnt(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.getPurchaseOrderDetailCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deletePurchaseOrder(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        String returnString = this.purchaseOrderDao.deletePurchaseOrder(paramMap);
        String processId = paramMap.get("PROCESSID").toString();
        if (returnString == "Y"&&!processId.equals("null")&&!processId.equals("")&&processId!=null&&processId!="") {
            this.runtimeService.deleteProcessInstance(processId, "个人取消申请");
        }
        return returnString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getPurchaseOrder(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.getPurchaseOrder(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updatePurchaseOrder(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 获取向PROSTOR_PURCHASE_ORDER插入的参数
        LinkedHashMap paramMapForOrder = ObjectBindUtil.getRequestParamData(request);
        paramMapForOrder.put("CPNY_ID", admin.getCpnyId());
        paramMapForOrder.put("UPDATED_BY", admin.getAdminID());

        // 获取向PROSTOR_PURCHAER_ORDER_DETAIL插入的参数
        String insertJsonString = request.getParameter("insertJsonData");
        List<LinkedHashMap<String, Object>> insertParamListForDetail = ObjectBindUtil.getRequestJsonData(insertJsonString);
        List<LinkedHashMap<String, Object>> insertList = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> insertmap = null;
        for (int i = 0; i < insertParamListForDetail.size(); i++) {
            insertmap = insertParamListForDetail.get(i);
            insertmap.put("CPNY_ID", admin.getCpnyId());
            insertmap.put("CREATED_BY", admin.getAdminID());
            insertList.add(insertmap);
        }

        // 获取向PROSTOR_PURCHAER_ORDER_DETAIL更新的参数
        String updateJsonString = request.getParameter("updateJsonData");
        List<LinkedHashMap<String, Object>> updateParamListForDetail = ObjectBindUtil.getRequestJsonData(updateJsonString);
        List<LinkedHashMap<String, Object>> updateList = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> map = null;
        for (int i = 0; i < updateParamListForDetail.size(); i++) {
            map = updateParamListForDetail.get(i);
            map.put("CPNY_ID", admin.getCpnyId());
            map.put("UPDATED_BY", admin.getAdminID());
            updateList.add(map);
        }

        String flagOrder = null;
        String flagInsertOrderDetail = null;
        String flagUpdateOrderDetail = null;

        flagOrder = this.purchaseOrderDao.updatePurchaseOrder(paramMapForOrder);// 向采购单中添加
        // 判断插入的list是否为空,如果为空就不执行相应插入采购单详情操作
        if (insertList.size() == 0) {
            flagInsertOrderDetail = "Y";
        } else {
            flagInsertOrderDetail = this.purchaseOrderDao.addPurchaseOrderDetail(insertList);// 向采购单详情中添加
        }
        flagUpdateOrderDetail = this.purchaseOrderDao.updatePurchaseOrderDetail(updateList);

        // 判断是否都插入成功
        if ("Y".equals(flagOrder) && "Y".equals(flagInsertOrderDetail) && "Y".equals(flagUpdateOrderDetail)) {
            return "Y";
        }
        return "N";
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String deletePurchaseOrderDetail(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.purchaseOrderDao.deletePurchaseOrderDetail(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String purchaseOrderToExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        // 表格中数据对应的字段
        List<String> codeList = new ArrayList<String>();
        codeList.add("PRODUCT_ID");
        codeList.add("PRODUCT_NAME");
        codeList.add("SPECIFICATION");
        // codeList.add("PRODUCT_CAS");
        codeList.add("UNIT_CODE");
        codeList.add("SUPPLIER");
        codeList.add("UNIT_PRICE");
        codeList.add("QUANTITY");
        codeList.add("SUM_MONEY");
        // 表格的列名
        List<String> titleList = new ArrayList<String>();
        titleList.add("货品编号");
        titleList.add("品名");
        titleList.add("规格");
        // titleList.add("CAS");
        titleList.add("单位");
        titleList.add("供货商");
        titleList.add("单价");
        titleList.add("数量");
        titleList.add("金额");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();
        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("采购单");
        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();
        //获取采购单流水号
        String purhcaseOrderId = this.purchaseOrderDao.getPurchaseOrderId(paramMap);
        // 4.创建title,data,headers
        Layouter.buildPurchaseOrderExcelInfo(worksheet, startRowIndex, startColIndex, titleList, paramMap,purhcaseOrderId);
        // 5.填充数据
        List dataList = this.purchaseOrderDao.getPurchaseOrderDetailList(paramMap);
        FillComputerManager.fillOutPurchaseOrderExcelInfo(worksheet, startRowIndex, startColIndex, dataList, codeList, paramMap);
        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        
        try {
            fileName = java.net.URLEncoder.encode("采购单-" + purhcaseOrderId, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
        return "Y";
    }
}
