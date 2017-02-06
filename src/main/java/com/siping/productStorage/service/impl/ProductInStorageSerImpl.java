package com.siping.productStorage.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.dao.ProductInStorageDao;
import com.siping.productStorage.dao.StorageManageDao;
import com.siping.productStorage.service.ProductInStorageSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class ProductInStorageSerImpl implements ProductInStorageSer {

    Logger logger = Logger.getLogger(ProductSerImpl.class);
    @Autowired
    private ProductInStorageDao productInStorageDao;
    @Autowired
    private StorageManageDao storageManageDao;

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getProInColumns(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getProInColumns(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getSupplierList(HttpServletRequest request) {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        list = this.productInStorageDao.getSupplierList(paramMap);
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String productInStore(HttpServletRequest request) throws Exception {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);

        // 获取jsonDate
        String jsonString = request.getParameter("jsonData");
        String purchase = request.getParameter("PURCHASE_ORDER_ID");
        String supplierno = request.getParameter("SUPPLIER_NO");

        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        List<LinkedHashMap<String, Object>> storageList = storageManageDao.getStorageList(paramMap);

        List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString);

        // 先获取入库单号，然后再进行插入入库单，然后再插入商品操作。
        String serialNum = request.getParameter("INSTORAGE_ID");
        if (serialNum == null || "".equals(serialNum) || "null".equals(serialNum)) {
            serialNum = this.productInStorageDao.getInStorageSerialNum();
            paramMap.put("INSTORAGE_ID", serialNum);
            this.productInStorageDao.addInStorageList(paramMap);
        } else {
            // 如果有入库单号，且状态STATUS为1，那么界面点击为保存按钮，即更新该暂存入库记录为完成
            if (paramMap.get("STATUS") != null && "1".equals(paramMap.get("STATUS"))) {
                this.productInStorageDao.updateInStorage(paramMap);
            }
        }

        List<LinkedHashMap<String, Object>> list = new ArrayList<LinkedHashMap<String, Object>>();
        LinkedHashMap<String, Object> map = null;
        for (int i = 0; i < updateList.size(); i++) {

            for (int k = 0; k < storageList.size(); k++) {
            	int st=(Integer) storageList.get(k).get("STORAGENO");
            	String st_no=Integer.toString(st);
            	
               // String st_no = (String) storageList.get(k).get("STORAGENO");
                if (updateList.get(i).get("STO" + st_no) != null && !"".equals(updateList.get(i).get("STO" + st_no))) {
                    map = new LinkedHashMap<String, Object>();
                    map.put("STORAGE_NO", st_no);
                    map.put("PRODUCT_NO", updateList.get(i).get("PRODUCT_NO"));
                    map.put("UNIT_PRICE", updateList.get(i).get("UNIT_PRICE"));
                    map.put("QUANTITY", updateList.get(i).get("STO" + st_no));
                    map.put("QUANTITY_UNIT_CODE", updateList.get(i).get("QUANTITY_UNIT_CODE"));
                    map.put("EMPID", admin.getAdminID());
                    map.put("CPNY_ID", admin.getCpnyId());
                    map.put("INSTORAGE_ID", serialNum);
                    map.put("PURCHASE_ORDER_ID", purchase);
                    map.put("SUPPLIER_NO", supplierno);
                    list.add(map);
                }
            }
        }
        return this.productInStorageDao.productInStore(list);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getInstorageList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getInstorageList(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public List getPurchaseOrderList(Map paramMap) {
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productInStorageDao.getPurchaseOrderList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productInStorageDao.getPurchaseOrderList(paramMap);
        }
    }

    @SuppressWarnings({ "rawtypes" })
    @Override
    public int getPurchaseOrderListCnt(Map paramMap) {
        return this.productInStorageDao.getPurchaseOrderListCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getWaitingInStorageSum(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getWaitingInStorageSum(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getProductWaitingInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getProductWaitingInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getInStorHistoryList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productInStorageDao.getInStorHistoryList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productInStorageDao.getInStorHistoryList(paramMap);
        }
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getInStorHistoryListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.productInStorageDao.getInStorHistoryListCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getInStorDetailList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.productInStorageDao.getInStorDetailList(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            return this.productInStorageDao.getInStorDetailList(paramMap);
        }

    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getInStorDetailListCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getInStorDetailListCnt(paramMap);

    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void viewProInstorReport(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 附加信息
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        // 页面提交的JSON信息
        // String jsonCodeString =
        // attMonthReportDao.getAttMonthColumnInfo(paramMap);
        List<String> codeList = new ArrayList<String>();
        List<String> titleList = new ArrayList<String>();

        titleList.add("货品编码");
        titleList.add("货物品名");
        // titleList.add("货号");
        titleList.add("规格");
        // titleList.add("CAS");
        titleList.add("单价");
        titleList.add("入库数量");
        titleList.add("单位");
        titleList.add("入库仓");
        titleList.add("货位");

        codeList.add("PRODUCT_ID");
        codeList.add("PRODUCT_NAME");
        // codeList.add("PRODUCT_NUM");
        codeList.add("SPECIFICATION");
        // codeList.add("PRODUCT_CAS");
        codeList.add("UNIT_PRICE");
        codeList.add("QUANTITY");
        codeList.add("UNIT_NAME");
        codeList.add("STORAGE_NAME");
        codeList.add("STOR_ADDR");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("入库记录表");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        // 4.创建title,data,headers
        // Layouter.buildPublicReport(worksheet, startRowIndex, startColIndex,
        // titleList,title);
        Layouter.buildInstorReport(worksheet, startRowIndex, startColIndex, titleList, paramMap);

        // 5.填充数据
        FillComputerManager.fillInStorExcelInfo(worksheet, startRowIndex, startColIndex, this.productInStorageDao.getInStorDetailList(paramMap), codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode(paramMap.get("INSTORAGE_ID") + "-入库单信息", "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getInstorOrderById(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.productInStorageDao.getInstorOrderById(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void exportInstorRecords(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        List<String> codeList = new ArrayList<String>();
        List<String> titleList = new ArrayList<String>();

        titleList.add("入库单号");
        titleList.add("入库时间");
        titleList.add("供货商");
        titleList.add("货品编号");
        titleList.add("货品名称");
        titleList.add("规格");
        titleList.add("单位");
        titleList.add("数量");
        titleList.add("单价");
        titleList.add("入库仓库");

        codeList.add("INSTORAGE_ID");
        codeList.add("IN_DATE");
        codeList.add("SUPPLIER_NAME");
        codeList.add("PRODUCT_ID");
        codeList.add("PRODUCT_NAME");
        codeList.add("SPECIFICATION");
        codeList.add("UNIT_NAME");
        codeList.add("QUANTITY");
        codeList.add("UNIT_PRICE");
        codeList.add("STORAGE_NAME");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("入库记录表");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        // 4.创建title,data,headers
        // Layouter.buildPublicReport(worksheet, startRowIndex, startColIndex,
        // titleList,title);
        Layouter.buildInstorReport2(worksheet, startRowIndex, startColIndex, titleList);

        // 5.填充数据
        FillComputerManager.fillInStorExcelInfo2(worksheet, startRowIndex, startColIndex, this.productInStorageDao.getInstorRecords(paramMap), codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("入库单信息"+DateUtil.getSysdateString("yyyyMMdd"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        // 确保发送的当前文本格式
        response.setContentType("application/vnd.ms-excel");

        // 7. 输出流
        Writer.write(response, worksheet);
    }
}
