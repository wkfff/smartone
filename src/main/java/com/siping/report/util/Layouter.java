package com.siping.report.util;

import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.siping.web.utility.DateUtil;

@SuppressWarnings("deprecation")
public class Layouter {

    /**
     * 创建报表
     */
    public static void buildReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildTitle(worksheet, startRowIndex, startColIndex);

        buildHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表
     */
    public static void buildInsReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildInsTitle(worksheet, startRowIndex, startColIndex);

        buildInsHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表
     */
    public static void buildPaReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildPaTitle(worksheet, startRowIndex, startColIndex);

        buildPaHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表
     */
    public static void buildAttMonthReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildAttMonthTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建公用报表
     */
    public static void buildPublicReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, String title) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildPublicTitle(worksheet, startRowIndex, startColIndex, title);

        buildPublicHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 入库单信息导出
     */
    @SuppressWarnings("rawtypes")
    public static void buildInstorReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, Map paramMap) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildInstorTitle(worksheet, startRowIndex, startColIndex, paramMap);

        /*
         * buildPublicHeaders(worksheet, startRowIndex, startColIndex,
         * titleList);
         */
        buildSalesMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);
    }

    /**
     * 入库单信息导出
     */
    public static void buildInstorReport2(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildInstorTitle2(worksheet, startRowIndex, startColIndex);
        buildSalesMonthHeaders2(worksheet, startRowIndex, startColIndex, titleList);
    }

    public static void buildPaStaReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildPaStaTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建绩效评分报表
     */
    public static void buildKpiScoreReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildKpiScoreTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建销售报表
     */
    public static void buildSalesMonthReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildSalesMonthTitle(worksheet, startRowIndex, startColIndex);

        buildSalesMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    public static void buildEmpInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildEmpInfoTitle(worksheet, startRowIndex, startColIndex);

        buildEmpInfoHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    public static void buildWhInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildWhInfoTitle(worksheet, startRowIndex, startColIndex);
        buildWhInfoHeaders(worksheet, startRowIndex, startColIndex);

    }

    /**
     * 创建报表
     */
    public static void buildAttInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildAttInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttInfoHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表
     */
    public static void buildBonusReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildBonusTitle(worksheet, startRowIndex, startColIndex);

        buildBonusHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员调动报表
     */
    public static void buildTransferOrderReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, String sheetTitle) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 3500);
        }
        buildTransferOrderTitle(worksheet, startRowIndex, startColIndex, sheetTitle);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员奖励报表
     */
    public static void buildRewardInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildRewardInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员奖励汇总报表
     */
    public static void buildSumRewardInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildSumRewardInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员惩戒报表
     */
    public static void buildPunishmentInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildPunishmentInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员惩戒汇总报表
     */
    public static void buildSumPunishmentInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildSumPunishmentInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建职员离职报表
     */
    public static void buildResignInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildResignInfoTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建部门定编信息报表
     */
    public static void buildDeptQuotaReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildDeptQuotaTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建经过搜索后证件台账信息报表
     */
    public static void buildQualificateReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildQualificateTitle(worksheet, startRowIndex, startColIndex);

        buildAttMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildInsTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月保险数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildPaTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月工资数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildAttMonthTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月考勤汇总数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建公用标题和日期
     */
    private static void buildPublicTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, String title) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(title);
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建入库单信息
     */
    @SuppressWarnings("rawtypes")
    private static void buildInstorTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, Map paramMap) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow row1 = worksheet.createRow((short) startRowIndex);
        row1.setHeight((short) 500);
        HSSFCell cellTitle = row1.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName());
        cellTitle.setCellStyle(cellStyleTitle);
        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));
        // Date header
        HSSFRow row2 = worksheet.createRow((short) startRowIndex + 1);
        row2.setHeight((short) 300);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        HSSFCell cellDate2 = row2.createCell(0);
        cellDate2.setCellValue("入库单号:" + paramMap.get("INSTORAGE_ID") + "        入库时间:" + paramMap.get("IN_DATE") + "        入库人:" + paramMap.get("ENAME"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
        HSSFRow row3 = worksheet.createRow((short) startRowIndex + 2);
        row3.setHeight((short) 300);
        HSSFCell cellDate3 = row3.createCell(0);
        cellDate3.setCellValue("采购单号:" + paramMap.get("PURCHASE_ORDER_ID") + "        供货商名称:" + paramMap.get("SUPPLIER_NAME"));
        worksheet.addMergedRegion(new CellRangeAddress(2, 2, 0, startColIndex - 1));
        cellDate2.setCellStyle(cellStyle);
        cellDate3.setCellStyle(cellStyle);

    }

    /**
     * 创建入库单信息
     */
    private static void buildInstorTitle2(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow row1 = worksheet.createRow((short) startRowIndex);
        row1.setHeight((short) 500);
        HSSFCell cellTitle = row1.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName());
        cellTitle.setCellStyle(cellStyleTitle);
        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));
    }

    /**
     * 创建公用表头
     */
    private static void buildPublicHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * /** 创建工资汇总报表标题和日期
     */
    private static void buildPaStaTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月工资汇总数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建绩效评分报表标题和日期
     */
    private static void buildKpiScoreTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月绩效汇总数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildSalesMonthTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月销售汇总数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildEmpInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildWhInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("报工数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildAttInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月考勤数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildBonusTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "月奖金数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建表头
     */
    private static void buildHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildInsHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildPaHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildAttMonthHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建销售报表表头
     */
    private static void buildSalesMonthHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 3);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建销售报表表头
     */
    private static void buildSalesMonthHeaders2(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 1);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildEmpInfoHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildWhInfoHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        HSSFCell cell1 = rowHeader.createCell(0);
        cell1.setCellValue("工号");
        cell1.setCellStyle(headerCellStyle);

        HSSFCell cell2 = rowHeader.createCell(1);
        cell2.setCellValue("姓名");
        cell2.setCellStyle(headerCellStyle);

        HSSFCell cell3 = rowHeader.createCell(2);
        cell3.setCellValue("部门");
        cell3.setCellStyle(headerCellStyle);

        HSSFCell cell4 = rowHeader.createCell(3);
        cell4.setCellValue("日期");
        cell4.setCellStyle(headerCellStyle);

        HSSFCell cell5 = rowHeader.createCell(4);
        cell5.setCellValue("星期");
        cell5.setCellStyle(headerCellStyle);

        HSSFCell cell6 = rowHeader.createCell(5);
        cell6.setCellValue("类型");
        cell6.setCellStyle(headerCellStyle);

        HSSFCell cell7 = rowHeader.createCell(6);
        cell7.setCellValue("项目名称");
        cell7.setCellStyle(headerCellStyle);

        HSSFCell cell8 = rowHeader.createCell(7);
        cell8.setCellValue("工作时数");
        cell8.setCellStyle(headerCellStyle);

        HSSFCell cell9 = rowHeader.createCell(8);
        cell9.setCellValue("工作内容");
        cell9.setCellStyle(headerCellStyle);

        HSSFCell cell10 = rowHeader.createCell(9);
        cell10.setCellValue("备注");
        cell10.setCellStyle(headerCellStyle);
    }

    /**
     * 创建表头
     */
    private static void buildAttInfoHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建表头
     */
    private static void buildBonusHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建销售报表
     */
    public static void buildOrderInfoReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildOrderReportTitle(worksheet, startRowIndex, startColIndex);

        buildOrderReportHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildOrderReportTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("销售订单导出列表");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建订单报表表头
     */
    private static void buildOrderReportHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建工单报表
     */
    public static void buildPaWhReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildPaWhTitle(worksheet, startRowIndex, startColIndex);

        buildPaWhHeaders(worksheet, startRowIndex, startColIndex, titleList);

    }

    /**
     * 创建报表标题和日期
     */
    private static void buildPaWhTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName());
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建工单表头
     */
    private static void buildPaWhHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 创建职员调动报表标题和日期
     */
    private static void buildTransferOrderTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, String sheetTitle) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "" + sheetTitle);
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建职员奖励报表标题和日期
     */
    private static void buildRewardInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "职员奖励信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建职员奖励汇总报表标题和日期
     */
    private static void buildSumRewardInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "数据");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建职员惩戒报表标题和日期
     */
    private static void buildPunishmentInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "职员惩戒信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建职员惩戒汇总报表标题和日期
     */
    private static void buildSumPunishmentInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "数据");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建职员离职报表标题和日期
     */
    private static void buildResignInfoTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "职员离职信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建部门定编信息报表标题和日期
     */
    private static void buildDeptQuotaTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName() + "定编信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建证件台账报表标题和日期
     */
    private static void buildQualificateTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("证件台账");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    public static void buildPaSumReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, String headName) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 3000);
        }
        buildPaSumTitle(worksheet, startRowIndex, startColIndex, headName);

        buildPaSumHeaders(worksheet, startRowIndex, startColIndex, titleList);
    }

    /**
     * 创建报表标题和日期
     */
    private static void buildPaSumTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, String headeName) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(headeName + "月薪酬分析总表");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建表头
     */
    private static void buildPaSumHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    public static void buildHrMenReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 3500);
        }
        buildHrMenReportTitle(worksheet, startRowIndex, startColIndex);

        buildHrMenReportHeaders(worksheet, startRowIndex, startColIndex, titleList);
    }

    /**
     * 创建报表标题和日期
     */
    private static void buildHrMenReportTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("员工花名册");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }

    /**
     * 创建表头
     */
    private static void buildHrMenReportHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            System.out.println(titleList.get(i));
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    public static void buildHrMenConstructReport(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, String title) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 3500);
        }
        buildHrMenConstructTitle(worksheet, startRowIndex, startColIndex, title);

        buildHrMenConstructHeaders(worksheet, startRowIndex + 1, startColIndex, titleList);
    }

    /**
     * 创建人员结构标题和日期
     */
    private static void buildHrMenConstructTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, String title) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue(title);
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(startRowIndex, startRowIndex, 0, startColIndex - 1));
    }

    private static void buildHrMenConstructHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    /**
     * 出库记录导出
     */
    @SuppressWarnings("rawtypes")
    public static void buildOutStorExcelInfo(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, Map paramMap) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 3500);
        }
        buildOutStorExcelTitle(worksheet, startRowIndex, startColIndex, paramMap);
        buildSalesMonthHeaders(worksheet, startRowIndex, startColIndex, titleList);
    }

    /**
     * 创建报表标题和日期
     */
    @SuppressWarnings("rawtypes")
    private static void buildOutStorExcelTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, Map paramMap) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow row1 = worksheet.createRow((short) startRowIndex);
        row1.setHeight((short) 500);
        HSSFCell cellTitle = row1.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName());
        cellTitle.setCellStyle(cellStyleTitle);
        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));
        // Date header
        HSSFRow row2 = worksheet.createRow((short) startRowIndex + 1);
        row2.setHeight((short) 300);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        HSSFCell cellDate2 = row2.createCell(0);
        cellDate2.setCellValue("出库单号:" + paramMap.get("OUTSTORAGE_ID") + "        出库时间:" + paramMap.get("OUT_DATE") + "        出库员:" + paramMap.get("OPERATOR"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
        HSSFRow row3 = worksheet.createRow((short) startRowIndex + 2);
        row3.setHeight((short) 300);
        HSSFCell cellDate3 = row3.createCell(0);
        String remarks = paramMap.get("REMARKS").toString();
        if (remarks.equals("null") || remarks == null) {
            remarks = "";
        }
        cellDate3.setCellValue("销售单号:" + paramMap.get("SALES_ORDER_ID") + "        客户名称:" + paramMap.get("CUST_NAME") + "        折扣:" + paramMap.get("DISCOUNT") + "        备注:" + remarks);
        worksheet.addMergedRegion(new CellRangeAddress(2, 2, 0, startColIndex - 1));
        cellDate2.setCellStyle(cellStyle);
        cellDate3.setCellStyle(cellStyle);
    }

    /**
     * 采购单导出
     */
    @SuppressWarnings("rawtypes")
    public static void buildPurchaseOrderExcelInfo(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList, Map paramMap, String purchaseOrderId) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            if (i == 1 || i == 2 || i == 3) {
                worksheet.setColumnWidth(i, 4500);
            } else if (i == 5) {
                worksheet.setColumnWidth(i, 7000);
            } else {
                worksheet.setColumnWidth(i, 3000);
            }
        }
        buildPurchaseOrderExcelTitle(worksheet, startRowIndex, startColIndex, paramMap, purchaseOrderId);
        buildPurchaseOrderHeaders(worksheet, startRowIndex, startColIndex, titleList);
    }

    /**
     * 创建报表标题和日期
     */
    @SuppressWarnings({ "rawtypes" })
    private static void buildPurchaseOrderExcelTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex, Map paramMap, String purchaseOrderId) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow row1 = worksheet.createRow((short) startRowIndex);
        row1.setHeight((short) 500);
        HSSFCell cellTitle = row1.createCell(0);
        cellTitle.setCellValue(worksheet.getSheetName());
        cellTitle.setCellStyle(cellStyleTitle);
        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));
        // Date header
        HSSFRow row2 = worksheet.createRow((short) startRowIndex + 1);
        row2.setHeight((short) 300);
        HSSFCell cellDate2 = row2.createCell(0);
        cellDate2.setCellValue("      采购单号:" + purchaseOrderId + "        采购人:" + paramMap.get("PURCHASER") + "        采购日期:" + paramMap.get("PURCHASE_DATE") + "      付款方式:"
            + paramMap.get("PAYMENT_MODE") + "        运输方式:" + paramMap.get("TRANSPORT_MODE"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));
    }

    /**
     * 创建采购单表头
     */
    private static void buildPurchaseOrderHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<String> titleList) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 3);
        rowHeader.setHeight((short) 500);

        for (int i = 0; i < titleList.size(); i++) {
            HSSFCell cell1 = rowHeader.createCell(i);
            cell1.setCellValue(titleList.get(i));
            cell1.setCellStyle(headerCellStyle);
        }
    }

    public static void buildWhConclusion(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildWhConclusionTitle(worksheet, startRowIndex, startColIndex);
        buildWhConclusionHeaders(worksheet, startRowIndex, startColIndex);

    }

    private static void buildWhConclusionTitle(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        HSSFCell cell1 = rowHeader.createCell(0);
        cell1.setCellValue("日期");
        cell1.setCellStyle(headerCellStyle);

        HSSFCell cell2 = rowHeader.createCell(1);
        cell2.setCellValue("姓名");
        cell2.setCellStyle(headerCellStyle);

        HSSFCell cell3 = rowHeader.createCell(2);
        cell3.setCellValue("有效工时");
        cell3.setCellStyle(headerCellStyle);

        HSSFCell cell4 = rowHeader.createCell(3);
        cell4.setCellValue("有效日");
        cell4.setCellStyle(headerCellStyle);

        HSSFCell cell5 = rowHeader.createCell(4);
        cell5.setCellValue("出勤小时");
        cell5.setCellStyle(headerCellStyle);

        HSSFCell cell6 = rowHeader.createCell(5);
        cell6.setCellValue("出勤日");
        cell6.setCellStyle(headerCellStyle);

        HSSFCell cell7 = rowHeader.createCell(6);
        cell7.setCellValue("业绩小时");
        cell7.setCellStyle(headerCellStyle);

        HSSFCell cell8 = rowHeader.createCell(7);
        cell8.setCellValue("绩效日");
        cell8.setCellStyle(headerCellStyle);

        HSSFCell cell9 = rowHeader.createCell(8);
        cell9.setCellValue("病假小时");
        cell9.setCellStyle(headerCellStyle);

        HSSFCell cell10 = rowHeader.createCell(9);
        cell10.setCellValue("病假日");
        cell10.setCellStyle(headerCellStyle);

        HSSFCell cell11 = rowHeader.createCell(10);
        cell11.setCellValue("事假小时");
        cell11.setCellStyle(headerCellStyle);

        HSSFCell cell12 = rowHeader.createCell(11);
        cell12.setCellValue("事假日");
        cell12.setCellStyle(headerCellStyle);
        
        HSSFCell cell13 = rowHeader.createCell(12);
        cell13.setCellValue("外部项目绩效日");
        cell13.setCellStyle(headerCellStyle);
        
        HSSFCell cell14 = rowHeader.createCell(13);
        cell14.setCellValue("内部项目绩效日");
        cell14.setCellStyle(headerCellStyle);

    }

    private static void buildWhConclusionHeaders(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("报工数据信息");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0, startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: " + DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0, startColIndex - 1));

    }
    public static void buildWhConclusionSum(HSSFSheet worksheet, int startRowIndex, int startColIndex) {
        // 设置列数和列的宽度
        for (int i = 0; i < startColIndex; i++) {
            worksheet.setColumnWidth(i, 5000);
        }
        buildWhConclusionTitleSum(worksheet, startRowIndex, startColIndex);
        buildWhConclusionHeadersSum(worksheet, startRowIndex, startColIndex);
    }
    private static void buildWhConclusionTitleSum(HSSFSheet worksheet,int startRowIndex, int startColIndex) {
        // Header字体
        Font font = worksheet.getWorkbook().createFont();

        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 单元格样式
        HSSFCellStyle headerCellStyle = worksheet.getWorkbook().createCellStyle();
        headerCellStyle.setFillBackgroundColor(HSSFColor.GREY_25_PERCENT.index);
        headerCellStyle.setFillPattern(CellStyle.NO_FILL);
        headerCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        headerCellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        headerCellStyle.setWrapText(true);
        headerCellStyle.setFont((HSSFFont) font);
        headerCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        headerCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // 创建字段标题
        HSSFRow rowHeader = worksheet.createRow((short) startRowIndex + 2);
        rowHeader.setHeight((short) 500);

        HSSFCell cell1 = rowHeader.createCell(0);
        cell1.setCellValue("起始月份");
        cell1.setCellStyle(headerCellStyle);

        HSSFCell cell2 = rowHeader.createCell(1);
        cell2.setCellValue("结束月份");
        cell2.setCellStyle(headerCellStyle);

        HSSFCell cell3 = rowHeader.createCell(2);
        cell3.setCellValue("姓名");
        cell3.setCellStyle(headerCellStyle);

        HSSFCell cell4 = rowHeader.createCell(3);
        cell4.setCellValue("有效工时");
        cell4.setCellStyle(headerCellStyle);

        HSSFCell cell5 = rowHeader.createCell(4);
        cell5.setCellValue("有效日");
        cell5.setCellStyle(headerCellStyle);

        HSSFCell cell6 = rowHeader.createCell(5);
        cell6.setCellValue("出勤小时");
        cell6.setCellStyle(headerCellStyle);

        HSSFCell cell7 = rowHeader.createCell(6);
        cell7.setCellValue("出勤日");
        cell7.setCellStyle(headerCellStyle);

        HSSFCell cell8 = rowHeader.createCell(7);
        cell8.setCellValue("业绩小时");
        cell8.setCellStyle(headerCellStyle);

        HSSFCell cell9 = rowHeader.createCell(8);
        cell9.setCellValue("绩效日");
        cell9.setCellStyle(headerCellStyle);

        HSSFCell cell10 = rowHeader.createCell(9);
        cell10.setCellValue("病假小时");
        cell10.setCellStyle(headerCellStyle);

        HSSFCell cell11 = rowHeader.createCell(10);
        cell11.setCellValue("病假日");
        cell11.setCellStyle(headerCellStyle);

        HSSFCell cell12 = rowHeader.createCell(11);
        cell12.setCellValue("事假小时");
        cell12.setCellStyle(headerCellStyle);
        
        HSSFCell cell13 = rowHeader.createCell(12);
        cell13.setCellValue("事假日");
        cell13.setCellStyle(headerCellStyle);
        
        HSSFCell cell14 = rowHeader.createCell(13);
        cell14.setCellValue("外部项目绩效日");
        cell14.setCellStyle(headerCellStyle);
        
        HSSFCell cell15 = rowHeader.createCell(14);
        cell15.setCellValue("内部项目绩效日");
        cell15.setCellStyle(headerCellStyle);
        }
        
        private static void buildWhConclusionHeadersSum(HSSFSheet worksheet,int startRowIndex, int startColIndex) {
        // 设置报表标题字体
        Font fontTitle = worksheet.getWorkbook().createFont();
        fontTitle.setBoldweight(Font.BOLDWEIGHT_BOLD);
        fontTitle.setFontHeight((short) 280);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) fontTitle);

        // 报表标题
        HSSFRow rowTitle = worksheet.createRow((short) startRowIndex);
        rowTitle.setHeight((short) 500);
        HSSFCell cellTitle = rowTitle.createCell(0);
        cellTitle.setCellValue("报工数据信息汇总");
        cellTitle.setCellStyle(cellStyleTitle);

        // 合并区域内的报告标题
        worksheet.addMergedRegion(new CellRangeAddress(0, 0, 0,startColIndex - 1));

        // Date header
        HSSFRow dateTitle = worksheet.createRow((short) startRowIndex + 1);
        HSSFCell cellDate = dateTitle.createCell(0);
        cellDate.setCellValue("创建时间: "+ DateUtil.getSysdateString("yyyy-MM-dd HH:mm:ss"));
        worksheet.addMergedRegion(new CellRangeAddress(1, 1, 0,startColIndex - 1));
        }

}
