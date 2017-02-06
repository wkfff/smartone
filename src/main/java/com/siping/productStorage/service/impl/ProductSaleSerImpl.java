package com.siping.productStorage.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.siping.cust.service.SalesSettingSer;
import com.siping.productStorage.bean.Product;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;

import org.activiti.engine.RuntimeService;
import org.apache.commons.lang.ObjectUtils;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.productStorage.bean.SalesOrder;
import com.siping.productStorage.dao.ProductSaleDao;
import com.siping.productStorage.service.ProductSaleSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.DateUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

import static com.google.common.base.Joiner.on;
import static com.google.common.base.Strings.isNullOrEmpty;
import static com.siping.web.utility.DateUtil.getSysdateString;
import static org.apache.poi.ss.usermodel.CellStyle.*;

@Service
public class ProductSaleSerImpl implements ProductSaleSer {
    public static final String FAIL = "N";
    public static final String EMPTY = "(无)";
    @Autowired
    ProductSaleDao productSaleDao;
    @Autowired
    private RuntimeService runtimeService;
    @Autowired
    private SalesSettingSer salesSettingSer;

    @Override
    public String saveSalesOrder(SalesOrder salesOrder, HttpServletRequest request) throws Exception {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        salesOrder.setOperator(currentUser);

        String salesOrderId = this.productSaleDao.getSalesOrderId();
        if (salesOrderId.equals(FAIL)) {
            return FAIL;
        }
        salesOrder.setSalesOrderId(salesOrderId);
        return this.productSaleDao.insertSalesOrder(salesOrder);
    }

    @Override
    public List<SalesOrder> getAllSalesOrders(HttpServletRequest request) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);

        return this.productSaleDao.getAllSalesOrders(currentUser);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<SalesOrder> getAllSalesOrders(HttpServletRequest request, int page, int pagesize) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if(currentUser.getAccountType()!=null&&"CU".equals(currentUser.getAccountType())){
            paramMap.put("custID", currentUser.getAdminID());
        }else{
            paramMap.put("adminID", currentUser.getAdminID());
        }
        paramMap.put("cpnyId", currentUser.getCpnyId());
        paramMap.put("isSupervisor", salesSettingSer.isSupervisor(request));
        return this.productSaleDao.getAllSalesOrders(paramMap, page, pagesize);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getAllSalesOrdersCount(HttpServletRequest request) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        if(currentUser.getAccountType()!=null&&"CU".equals(currentUser.getAccountType())){
            paramMap.put("custID", currentUser.getAdminID());
        }else{
            paramMap.put("adminID", currentUser.getAdminID());
        }
        paramMap.put("cpnyId", currentUser.getCpnyId());
        return this.productSaleDao.getAllSalesOrdersCount(paramMap);
    }

    @Override
    public SalesOrder getSalesOrder(HttpServletRequest request, String salesOrderNo) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map map = new LinkedHashMap();
        map.put("user", currentUser);
        map.put("salesOrderNo", salesOrderNo);
        return this.productSaleDao.getSalesOrder(map);
    }

    @Override
    public List<SalesOrder> searchSalesOrder(HttpServletRequest request) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);

        paramMap.put("user", currentUser);
        return this.productSaleDao.searchSalesOrder(paramMap);
    }

    @Override
    public String deleteSalesOrder(HttpServletRequest request, String salesOrderNo, String processid) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map map = new LinkedHashMap();
        map.put("user", currentUser);
        map.put("salesOrderNo", salesOrderNo);
        String returnMsg = this.productSaleDao.deleteSalesOrder(map);
        if (returnMsg == "Y" && !processid.equals("null") && !processid.equals("") && processid != null && processid != "") {
            this.runtimeService.deleteProcessInstance(processid, "个人取消申请");
        }
        return returnMsg;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map getSalesOrderInfo(HttpServletRequest request) throws Exception {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("EMPID", StringUtil.checkNull(paramMap.get("EMPID"), admin.getAdminID()));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        return this.productSaleDao.getSalesOrderInfo(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getSalesOrderDetailForCheck(HttpServletRequest request) throws Exception {
        List list = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            list = this.productSaleDao.getSalesOrderDetailForCheck(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            list = this.productSaleDao.getSalesOrderDetailForCheck(paramMap);
        }
        return list;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public int getSalesOrderDetailForCheckCnt(HttpServletRequest request) throws Exception {
        int listCnt = 0;
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        listCnt = this.productSaleDao.getSalesOrderDetailForCheckCnt(paramMap);
        return listCnt;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateSalesOrderStatus(HttpServletRequest request) throws Exception {
        String returnMsg = "N";
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("language", Messages.getLanguage(request));
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        double receivedMoney = Double.parseDouble(paramMap.get("RECEIVEDMONEY").toString());
        double money = Double.parseDouble(paramMap.get("DISCOUNT_PRICE").toString());
        String status_id = paramMap.get("STATUS_ID").toString();
        if (status_id.equals("SaleOrderState1")) {
            return returnMsg = "该订单已完成确认！";
        }
        if (receivedMoney > money) {
            return returnMsg = "已收金额不能大于应付金额！";
        } else if (receivedMoney == 0) {
            return returnMsg = "请输入已收金额！";
        } else if (receivedMoney < 0) {
            return returnMsg = "金额不能为负！";
        }
        if ((money - receivedMoney) == 0.0) {
            returnMsg = this.productSaleDao.updateSalesOrderStatus1(paramMap);
        } else {
            returnMsg = this.productSaleDao.updateSalesOrderStatus0(paramMap);
        }
        return returnMsg;
    }

    @Override
    public String salesOrderToExcel(HttpServletRequest request, HttpServletResponse response, String salesOrderNo) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map map = new LinkedHashMap();
        map.put("user", currentUser);
        map.put("salesOrderNo", salesOrderNo);
        SalesOrder salesOrder = this.productSaleDao.getSalesOrder(map);

        HSSFSheet worksheet = createSheet("销售单");

        List<String> titles = setTitles();

        setLayout(worksheet, titles, 0, salesOrder);

        // 设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("销售单-" + salesOrder.getSalesOrderId(), "UTF-8");
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

    private HSSFSheet createSheet(String fileName) {
        HSSFWorkbook workbook = new HSSFWorkbook();
        return workbook.createSheet(fileName);
    }

    private List<String> setTitles() {
        List<String> titles = new ArrayList<String>();
        titles.add("货品编号");
        titles.add("货物品名");
        titles.add("规格");
        titles.add("单位");
        titles.add("单价");
        titles.add("数量");
        titles.add("金额");
        titles.add("折扣");
        titles.add("折扣金额");
        titles.add("备注");
        return titles;
    }

    private void setLayout(HSSFSheet worksheet, List<String> titles, int startRowIndex, SalesOrder salesOrder) {
        int headerRowsCount = createHeader(worksheet, titles, startRowIndex);
        worksheet.getRow(startRowIndex).getCell(0).setCellValue(worksheet.getSheetName());
        int infoHeaderRowsCount = createInfoHeader(worksheet, titles, startRowIndex + headerRowsCount);
        setInfoHeaderContent(worksheet, startRowIndex, salesOrder, headerRowsCount);
        int tableHeaderRowsCount = createTableHeader(worksheet, titles, startRowIndex + headerRowsCount + infoHeaderRowsCount);
        int tableDataRowsCount = createTableData(worksheet, titles, salesOrder, startRowIndex + headerRowsCount + infoHeaderRowsCount + tableHeaderRowsCount);
        int tableStartRowIndex = startRowIndex + headerRowsCount + infoHeaderRowsCount + tableHeaderRowsCount;
        int sumRowsCount = createSumRow(worksheet, titles, tableStartRowIndex, salesOrder.getSoldProducts().size(), startRowIndex + headerRowsCount + infoHeaderRowsCount + tableHeaderRowsCount
            + tableDataRowsCount);
        worksheet.getRow(tableStartRowIndex + tableDataRowsCount).getCell(titles.indexOf("折扣金额")).setCellValue(salesOrder.getPrice().getPrice());
        worksheet.getRow(tableStartRowIndex + tableDataRowsCount + 1).getCell(0)
            .setCellValue("      订单折扣:" + "          " + salesOrder.getPrice().getDiscount() + "        " + "折后总金额: " + "        " + salesOrder.getPrice().getDiscountPrice());
        createFooter(worksheet, titles, salesOrder, startRowIndex + headerRowsCount + infoHeaderRowsCount + tableHeaderRowsCount + tableDataRowsCount + sumRowsCount);
    }

    private int createSumRow(HSSFSheet worksheet, List<String> titles, int tableStartRowIndex, int tableContentRowsCount, int sumStartRowIndex) {
        int sumRowsCount = 0;
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setFont(font);
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        sumRowsCount = createSumRowWithoutDiscount(worksheet, titles, sumStartRowIndex, sumRowsCount, cellStyle);

        sumRowsCount = createSumRowWithDiscount(worksheet, titles, sumStartRowIndex, sumRowsCount);

        return sumRowsCount;
    }

    private int createSumRowWithoutDiscount(HSSFSheet worksheet, List<String> titles, int sumStartRowIndex, int sumRowsCount, HSSFCellStyle cellStyle) {
        HSSFRow sumRow = worksheet.createRow(sumStartRowIndex);

        sumRowsCount++;
        for (int i = 0; i < titles.size(); i++) {
            HSSFCell cell = sumRow.createCell(i);
            cell.setCellStyle(cellStyle);

        }

        sumRow.getCell(0).setCellValue("         合计金额");

        worksheet.addMergedRegion(new CellRangeAddress(sumStartRowIndex, sumStartRowIndex, 0, titles.indexOf("折扣金额") - 1));
        return sumRowsCount;
    }

    private int createSumRowWithDiscount(HSSFSheet worksheet, List<String> titles, int sumStartRowIndex, int sumRowsCount) {
        HSSFRow discountSumRow = worksheet.createRow(sumStartRowIndex + 1);
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_LEFT);
        cellStyle.setFont(font);
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        sumRowsCount++;
        for (int i = 0; i < titles.size(); i++) {
            HSSFCell cell = discountSumRow.createCell(i);
            cell.setCellStyle(cellStyle);

        }

        worksheet.addMergedRegion(new CellRangeAddress(sumStartRowIndex + 1, sumStartRowIndex + 1, 0, titles.size() - 1));
        return sumRowsCount;
    }

    private void createFooter(HSSFSheet worksheet, List<String> titles, SalesOrder salesOrder, int footerStartRowIndex) {
        String gap ="    ";
        String empName="";
        if(salesOrder.getAffirmedEmp()!=null) {
            empName=salesOrder.getAffirmedEmp().getEmpName();
        }
        String checker = "审批人: " + empName;
        String dateTime = "制表时间: " + getSysdateString("yyyy-MM-dd HH:mm");

        HSSFCellStyle dateCellStyle = worksheet.getWorkbook().createCellStyle();
        dateCellStyle.setAlignment(CellStyle.ALIGN_RIGHT);
        HSSFRow dateRow = worksheet.createRow(footerStartRowIndex);
        HSSFCell dateCell = dateRow.createCell(0);
        dateCell.setCellStyle(dateCellStyle);

        dateCell.setCellValue(checker + gap + dateTime);
        worksheet.addMergedRegion(new CellRangeAddress(footerStartRowIndex, footerStartRowIndex, 0, titles.size() - 1));
    }

    private void setInfoHeaderContent(HSSFSheet worksheet, int startRowIndex, SalesOrder salesOrder, int headerRowsCount) {
        String gap = "        ";
        String salesOrderId = "销售单编号: " + solveEmptyField(salesOrder.getSalesOrderId());
        String orderDate = "下单日期: " + solveEmptyField(salesOrder.getFormattedOrderDate());
        String customerId = "";
        String customerName = "";
        if(salesOrder.getCustomer()!=null){
            customerId = "客户编号: " + solveEmptyField(salesOrder.getCustomer().getCustomerId());
            customerName = "客户名称: " + solveEmptyField(salesOrder.getCustomer().getCustomerName());
        }
        
        String consignee = null;
        String deliveryAddr = null;
        if(salesOrder.getReceiver() == null){
            consignee = "联系人: " + EMPTY;
            deliveryAddr = "送货地址: " + EMPTY;
        }else{
            consignee = "联系人: " + solveEmptyField(salesOrder.getReceiver().getReceiverName());
            deliveryAddr = "送货地址: " + solveEmptyField(salesOrder.getReceiver().getAddress().getWholeAddress());
        }
        

        worksheet.getRow(startRowIndex + headerRowsCount).getCell(0).setCellValue(salesOrderId + gap + orderDate);
        worksheet.getRow(startRowIndex + headerRowsCount + 1).getCell(0).setCellValue(customerId + gap + customerName + gap + consignee + gap + deliveryAddr);
    }

    private String solveEmptyField(String field) {
        if (isNullOrEmpty(field)) {
            field = EMPTY;
        }
        return field;
    }

    private int createTableData(HSSFSheet worksheet, List<String> titles, SalesOrder salesOrder, int tableDataStartRow) {
        int tableDataRowsCount = 0;
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(BORDER_THIN);
        bodyCellStyle.setBorderRight(BORDER_THIN);
        bodyCellStyle.setBorderTop(BORDER_THIN);
        bodyCellStyle.setBorderBottom(BORDER_THIN);
        List<Product> products = salesOrder.getSoldProducts();
        for (int tableRowIndex = tableDataStartRow; tableRowIndex < products.size() + tableDataStartRow; tableRowIndex++) {
            HSSFRow row = worksheet.createRow(tableRowIndex);
            tableDataRowsCount++;
            for (int tableColIndex = 0; tableColIndex < titles.size(); tableColIndex++) {
                HSSFCell cell = row.createCell(tableColIndex);
                cell.setCellStyle(bodyCellStyle);
            }
            row.getCell(0).setCellValue(products.get(tableRowIndex - tableDataStartRow).getId());
            row.getCell(1).setCellValue(products.get(tableRowIndex - tableDataStartRow).getName());
            row.getCell(2).setCellValue(products.get(tableRowIndex - tableDataStartRow).getSpecification());
            if(products.get(tableRowIndex - tableDataStartRow).getUnit()!=null)
            {
                row.getCell(3).setCellValue(products.get(tableRowIndex - tableDataStartRow).getUnit().getUnitName());
            }
            row.getCell(4).setCellValue(products.get(tableRowIndex - tableDataStartRow).getSellingPrice().getPrice());
            row.getCell(5).setCellValue(products.get(tableRowIndex - tableDataStartRow).getQuantity());
            row.getCell(6).setCellValue(products.get(tableRowIndex - tableDataStartRow).getAmount());
            row.getCell(7).setCellValue(products.get(tableRowIndex - tableDataStartRow).getSellingPrice().getDiscount());
            row.getCell(8).setCellValue(products.get(tableRowIndex - tableDataStartRow).getSellingPrice().getDiscountPrice());
            row.getCell(9).setCellValue(products.get(tableRowIndex - tableDataStartRow).getRemark());
        }
        return tableDataRowsCount;
    }

    private int createTableHeader(HSSFSheet worksheet, List<String> titles, int tableHeaderStartRow) {
        // 创建字段标题
        int tableHeaderRowsCount = 0;
        HSSFRow tableHeader = worksheet.createRow(tableHeaderStartRow);
        tableHeaderRowsCount++;
        tableHeader.setHeight((short) 500);

        // Header字体
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(NO_FILL);
        headerCellStyle.setAlignment(ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(BORDER_THIN);
        headerCellStyle.setBorderRight(BORDER_THIN);
        headerCellStyle.setBorderTop(BORDER_THIN);
        headerCellStyle.setBorderBottom(BORDER_THIN);

        for (int i = 0; i < titles.size(); i++) {
            HSSFCell cell1 = tableHeader.createCell(i);
            cell1.setCellValue(titles.get(i));
            cell1.setCellStyle(headerCellStyle);
            worksheet.setColumnWidth(i, 5000);
        }
        return tableHeaderRowsCount;
    }

    private int createInfoHeader(HSSFSheet worksheet, List<String> titles, int infoStartRowIndex) {
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(ALIGN_CENTER);
        int infoRowsCount = 0;
        for (int i = infoStartRowIndex; i < infoStartRowIndex + 3; i++) {
            HSSFRow row = worksheet.createRow(i);
            infoRowsCount++;
            row.setHeight((short) 300);
            row.createCell(0).setCellStyle(cellStyle);
            worksheet.addMergedRegion(new CellRangeAddress(i, i, 0, titles.size() - 1));
        }
        return infoRowsCount;
    }

    private int createHeader(HSSFSheet worksheet, List<String> titles, int startRowIndex) {
        int rowsCount = 0;
        HSSFRow titleRow = worksheet.createRow(startRowIndex);
        rowsCount++;
        HSSFCell titleCell = titleRow.createCell(0);
        worksheet.addMergedRegion(new CellRangeAddress(startRowIndex, startRowIndex, 0, titles.size() - 1));

        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        titleRow.setHeight((short) 500);
        titleCell.setCellStyle(cellStyleTitle);

        return rowsCount;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List<Product> getProductBySalesOrder(HttpServletRequest request, SalesOrder s) {
        AdminBean currentUser = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("adminID", currentUser.getAdminID());
        paramMap.put("cpnyId", currentUser.getCpnyId());
        paramMap.put("SALES_ORDER_NO", s.getSalesOrderNo());
        return this.productSaleDao.getProductBySalesOrder(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void saleOrdersToExcel(HttpServletRequest request, HttpServletResponse response) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());

        List<String> codeList = new ArrayList<String>();
        List<String> titleList = new ArrayList<String>();

        titleList.add("订单号");
        titleList.add("下单日期");
        titleList.add("下单人");
        titleList.add("客户名称");
        titleList.add("销售方式");
        titleList.add("出库状态");
        titleList.add("出库日期");
        titleList.add("货品编号");
        titleList.add("货品名称");
        titleList.add("规格");
        titleList.add("单位");
        titleList.add("出库数量");
        titleList.add("单价");
        titleList.add("金额");

        codeList.add("SALES_ORDER_ID");
        codeList.add("ORDER_DATE");
        codeList.add("CHINESENAME");
        codeList.add("CUST_NAME");
        codeList.add("SALES_MODE_NAME");
        codeList.add("OUT_STATUS");
        codeList.add("OUT_DATE");
        codeList.add("PRODUCT_ID");
        codeList.add("PRODUCT_NAME");
        codeList.add("SPECIFICATION");
        codeList.add("UNIT_CODE_NAME");
        codeList.add("QUANTITY");
        codeList.add("PRICE");
        codeList.add("DISCOUNT_MONEY");

        // 1.创建一个 workbook
        HSSFWorkbook workbook = new HSSFWorkbook();

        // 2.创建一个 worksheet
        HSSFSheet worksheet = workbook.createSheet("销售订单表");

        // 3.定义起始行和列
        int startRowIndex = 0;
        int startColIndex = titleList.size();

        // 4.创建title,data,headers
        // Layouter.buildPublicReport(worksheet, startRowIndex, startColIndex,
        // titleList,title);
        Layouter.buildInstorReport2(worksheet, startRowIndex, startColIndex, titleList);

        // 5.填充数据
        FillComputerManager.fillInStorExcelInfo2(worksheet, startRowIndex, startColIndex, this.productSaleDao.getSaleOrdersRecords(paramMap), codeList);

        // 6.设置reponse参数
        // 进行转码，使其支持中文文件名
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("销售单信息"+DateUtil.getSysdateString("yyyyMMdd"), "UTF-8");
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
