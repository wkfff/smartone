package com.siping.report.util;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;

import com.siping.web.utility.DateUtil;

public class FillComputerManager {

    @SuppressWarnings({ "rawtypes" })
    public static void fillReport(HSSFSheet worksheet, int startRowIndex,
            int startColIndex, List<LinkedHashMap> datasource,
            List<String> codeList) {

        // Row offset
        startRowIndex += 2;

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = startRowIndex; i + startRowIndex - 2 < datasource.size() + 2; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short) i + 1);

            LinkedHashMap dataMap = datasource.get(i-2);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();  
                // Retrieve the id value
                HSSFCell cell1 = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell1.setCellValue("");
                }else{
                    cell1.setCellValue(dataMap.get(code).toString());
                }
                cell1.setCellStyle(bodyCellStyle);
            }

        }
    }
    
    @SuppressWarnings({ "rawtypes" })
    public static void newFillReport(HSSFSheet worksheet, int startRowIndex,
            int startColIndex, List<LinkedHashMap> datasource,
            List<String> codeList) {

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(false); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = 0 ; i < datasource.size(); i++) {
            HSSFRow row = worksheet.createRow((short) startRowIndex + i );

            LinkedHashMap dataMap = datasource.get(i);
            
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();  
                // Retrieve the id value
                HSSFCell cell1 = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell1.setCellValue("");
                }else{
                    cell1.setCellValue(dataMap.get(code).toString());
                }
                cell1.setCellStyle(bodyCellStyle);
            }
        }
    }
    
       @SuppressWarnings({ "rawtypes" })
        public static void fillPaSumReport(HSSFSheet worksheet, int startRowIndex,
                int startColIndex, List<LinkedHashMap> datasource,
                List<String> codeList) {
            //保存开始行以用于合并
            int statRowIndexTmp = startRowIndex;

            // Create cell style for the body
            HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
            bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
            bodyCellStyle.setWrapText(false); // 是否自动换行.
            bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
            bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
            bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
            bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
            
            // 设置报表标题字体
            Font font = worksheet.getWorkbook().createFont();
            font.setBoldweight(Font.BOLDWEIGHT_BOLD);
            
            HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
            cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
            cellStyleTitle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
            cellStyleTitle.setWrapText(true);
            cellStyleTitle.setFont((HSSFFont) font);
            cellStyleTitle.setBorderLeft(CellStyle.BORDER_THIN);
            cellStyleTitle.setBorderRight(CellStyle.BORDER_THIN);
            cellStyleTitle.setBorderTop(CellStyle.BORDER_THIN);
            cellStyleTitle.setBorderBottom(CellStyle.BORDER_THIN);
            // Create body
            for (int i = startRowIndex; i - statRowIndexTmp < datasource.size() ; i++) {
                // Create a new row
                HSSFRow row = worksheet.createRow((short) i + 1);
                LinkedHashMap dataMap = datasource.get(i-statRowIndexTmp);
                for(int j=0;j<codeList.size();j++){
                    String code = codeList.get(j).toString();  
                    // Retrieve the id value
                    HSSFCell cell1 = row.createCell(j);
                    if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                        cell1.setCellValue("");
                    }else{
                        cell1.setCellValue(dataMap.get(code).toString());
                    }
                    if (j == 0) {
                        cell1.setCellStyle(cellStyleTitle);
                    } else {
                        cell1.setCellStyle(bodyCellStyle);
                    }
                }
            }
            worksheet.addMergedRegion(new CellRangeAddress(statRowIndexTmp+1, datasource.size()+statRowIndexTmp,0,0));
        }
       
    @SuppressWarnings({ "rawtypes" })
    public static void fillWhReport(HSSFSheet worksheet, int startRowIndex,
            int startColIndex, List<LinkedHashMap> datasource) {

        // Row offset
        startRowIndex += 2;

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(false); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = startRowIndex; i + startRowIndex - 2 < datasource.size() + 2; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short) i + 1);

            LinkedHashMap dataMap = datasource.get(i-2);
            HSSFCell cell1 = row.createCell(0);
            if(dataMap.get("EMPID") == null||dataMap.get("EMPID").equals("")){
                cell1.setCellValue("");
            }else{
                cell1.setCellValue(dataMap.get("EMPID").toString());
            }
            cell1.setCellStyle(bodyCellStyle);
            HSSFCell cell2 = row.createCell(1);
            if(dataMap.get("CHINESENAME") == null||dataMap.get("CHINESENAME").equals("")){
                cell2.setCellValue("");
            }else{
                cell2.setCellValue(dataMap.get("CHINESENAME").toString());
            }
            cell2.setCellStyle(bodyCellStyle);
            HSSFCell cell3 = row.createCell(2);
            if(dataMap.get("DEPTNAME") == null||dataMap.get("DEPTNAME").equals("")){
                cell3.setCellValue("");
            }else{
                cell3.setCellValue(dataMap.get("DEPTNAME").toString());
            }
            cell3.setCellStyle(bodyCellStyle);

            HSSFCell cell4 = row.createCell(3);
            if(dataMap.get("START_DATE") == null||dataMap.get("START_DATE").equals("")){
                cell4.setCellValue("");
            }else{
                cell4.setCellValue(dataMap.get("START_DATE").toString());
            }
            cell4.setCellStyle(bodyCellStyle);

            HSSFCell cell5 = row.createCell(4);
            if(dataMap.get("WEEKDAY") == null||dataMap.get("WEEKDAY").equals("")){
                cell5.setCellValue("");
            }else{
                cell5.setCellValue(dataMap.get("WEEKDAY").toString());
            }
            cell5.setCellStyle(bodyCellStyle);

            HSSFCell cell6 = row.createCell(5);
            if(dataMap.get("TYPE_NAME") == null||dataMap.get("TYPE_NAME").equals("")){
                cell6.setCellValue("");
            }else{
                cell6.setCellValue(dataMap.get("TYPE_NAME").toString());
            }
            cell6.setCellStyle(bodyCellStyle);
            
            HSSFCell cell7 = row.createCell(6);
            if(dataMap.get("PRO_NAME") == null||dataMap.get("PRO_NAME").equals("")){
                cell7.setCellValue("");
            }else{
                cell7.setCellValue(dataMap.get("PRO_NAME").toString());
            }
            cell7.setCellStyle(bodyCellStyle);
            
            HSSFCell cell8 = row.createCell(7);
            if(dataMap.get("WORK_HOUR") == null||dataMap.get("WORK_HOUR").equals("")){
                cell8.setCellValue("");
            }else{
                cell8.setCellValue(dataMap.get("WORK_HOUR").toString());
            }
            cell8.setCellStyle(bodyCellStyle);
            
            HSSFCell cell9 = row.createCell(8);
            if(dataMap.get("WORK_CONTENT") == null||dataMap.get("WORK_CONTENT").equals("")){
                cell9.setCellValue("");
            }else{
                cell9.setCellValue(dataMap.get("WORK_CONTENT").toString());
            }
            cell9.setCellStyle(bodyCellStyle);
            
            HSSFCell cell10 = row.createCell(9);
            if(dataMap.get("REMARK") == null||dataMap.get("REMARK").equals("")){
                cell10.setCellValue("");
            }else{
                cell10.setCellValue(dataMap.get("REMARK").toString());
            }
            cell10.setCellStyle(bodyCellStyle);

        }
    }
    @SuppressWarnings({ "rawtypes", "deprecation" })
    public static void deptQuotaReport(HSSFSheet worksheet, int startRowIndex,
            int startColIndex, List<LinkedHashMap> datasource,
            List<String> codeList) {
        //保存开始行以用于合并
        int statRowIndexTmp = startRowIndex;

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(false); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        
        // 设置报表标题字体
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);

        // 标题单元格样式
        HSSFCellStyle cellStyleTitle = worksheet.getWorkbook().createCellStyle();
        cellStyleTitle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyleTitle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
        cellStyleTitle.setWrapText(true);
        cellStyleTitle.setFont((HSSFFont) font);
        cellStyleTitle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyleTitle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyleTitle.setBorderTop(CellStyle.BORDER_THIN);
        cellStyleTitle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = startRowIndex; i - statRowIndexTmp < datasource.size() ; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short) i + 1);

            LinkedHashMap dataMap = datasource.get(i-statRowIndexTmp);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();  
                // Retrieve the id value
                HSSFCell cell1 = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell1.setCellValue("");
                }else{
                    cell1.setCellValue(dataMap.get(code).toString());
                }
                if (j == 0) {
                    cell1.setCellStyle(cellStyleTitle);
                } else {
                    cell1.setCellStyle(bodyCellStyle);
                }
            }
        }
        worksheet.addMergedRegion(new CellRangeAddress(statRowIndexTmp+1, datasource.size()+statRowIndexTmp,0,0));
    }
    

    @SuppressWarnings({ "rawtypes"})
    public static void fillOutStorExcelInfo(HSSFSheet worksheet, int startRowIndex,int startColIndex,
            List<LinkedHashMap> datasource,List<String> codeList,String discount) {
        // Row offset
        startRowIndex += 4;
        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        // Create body
        for (int i = startRowIndex; i < datasource.size()+startRowIndex; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short)i);
            LinkedHashMap dataMap = datasource.get(i-startRowIndex);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();
                // Retrieve the id value
                HSSFCell cell = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell.setCellValue("");
                }else if(j==4||j==5||j==6||j==7||j==8){//均为数字类型，需要转换，否则无法套用求和公式
                    cell.setCellValue(Double.parseDouble(dataMap.get(code).toString()));
                }else{
                    cell.setCellValue(dataMap.get(code).toString());
                }
                cell.setCellStyle(bodyCellStyle);
            }
        }
        //合计金额
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setFont(font);
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        int sumRowIndex = datasource.size()+startRowIndex;
        HSSFRow sumRow = worksheet.createRow(sumRowIndex);
        for(int i=0;i<codeList.size();i++){
            if(i==0){
                HSSFCell cell0 = sumRow.createCell(i);
                cell0.setCellValue("合计折后金额:");
                cell0.setCellStyle(cellStyle);
            }else if(i==12){
                HSSFCell cell12 = sumRow.createCell(i);
                int firstRowIndex = startRowIndex+1;
                cell12.setCellFormula("SUM(I"+firstRowIndex+":I"+sumRowIndex+")*"+discount);
                cell12.setCellStyle(cellStyle);
            }else{
                HSSFCell celli = sumRow.createCell(i);
                celli.setCellStyle(cellStyle);
            }
        }
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex,sumRowIndex, 0, startColIndex-2));
        //附上表的生成日期
        HSSFCellStyle dateCellStyle = worksheet.getWorkbook().createCellStyle();
        dateCellStyle.setAlignment(CellStyle.ALIGN_RIGHT);
        HSSFRow dateRow = worksheet.createRow(sumRowIndex+1);
        HSSFCell dateCell = dateRow.createCell(0);
        dateCell.setCellValue("制表时间: "+DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        dateCell.setCellStyle(dateCellStyle);
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex+1,sumRowIndex+1, 0, startColIndex-1));
    }
    @SuppressWarnings({ "rawtypes"})
    public static void fillInStorExcelInfo(HSSFSheet worksheet, int startRowIndex,int startColIndex,
            List<LinkedHashMap> datasource,List<String> codeList) {
        // Row offset
        startRowIndex += 4;
        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        // Create body
        for (int i = startRowIndex; i < datasource.size()+startRowIndex; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short)i);
            LinkedHashMap dataMap = datasource.get(i-startRowIndex);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();
                // Retrieve the id value
                HSSFCell cell = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell.setCellValue("");
                }else{
                    cell.setCellValue(dataMap.get(code).toString());
                }
                cell.setCellStyle(bodyCellStyle);
            }
        }
        //合计金额

        int sumRowIndex = datasource.size()+startRowIndex;

        //附上表的生成日期
        HSSFCellStyle dateCellStyle = worksheet.getWorkbook().createCellStyle();
        dateCellStyle.setAlignment(CellStyle.ALIGN_RIGHT);
        HSSFRow dateRow = worksheet.createRow(sumRowIndex);
        HSSFCell dateCell = dateRow.createCell(0);
        dateCell.setCellValue("制表时间: "+DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        dateCell.setCellStyle(dateCellStyle);
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex,sumRowIndex, 0, startColIndex-1));
    }

    @SuppressWarnings({ "rawtypes", "deprecation"})
    public static void fillInStorExcelInfo2(HSSFSheet worksheet, int startRowIndex,int startColIndex,
            List<LinkedHashMap> datasource,List<String> codeList) {
        // Row offset
        startRowIndex += 2;
        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        // Create body
        for (int i = startRowIndex; i < datasource.size()+startRowIndex; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short)i);
            LinkedHashMap dataMap = datasource.get(i-startRowIndex);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();
                // Retrieve the id value
                HSSFCell cell = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell.setCellValue("");
                }else{
                    cell.setCellValue(dataMap.get(code).toString());
                }
                cell.setCellStyle(bodyCellStyle);
            }
        }
        int sumRowIndex = datasource.size()+startRowIndex;
        //附上表的生成日期
        HSSFCellStyle dateCellStyle = worksheet.getWorkbook().createCellStyle();
        dateCellStyle.setAlignment(CellStyle.ALIGN_RIGHT);
        HSSFRow dateRow = worksheet.createRow(sumRowIndex);
        HSSFCell dateCell = dateRow.createCell(0);
        dateCell.setCellValue("制表时间: "+DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        dateCell.setCellStyle(dateCellStyle);
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex,sumRowIndex, 0, startColIndex-1));
    }
    @SuppressWarnings({ "rawtypes"})
    public static void fillOutPurchaseOrderExcelInfo(HSSFSheet worksheet, int startRowIndex,int startColIndex,
            List<LinkedHashMap> datasource,List<String> codeList,Map paramMap) {
        // Row offset
        startRowIndex += 4;
        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(true); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        // Create body
        for (int i = startRowIndex; i < datasource.size()+startRowIndex; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short)i);
            LinkedHashMap dataMap = datasource.get(i-startRowIndex);
            for(int j=0;j<codeList.size();j++){
                String code = codeList.get(j).toString();
                // Retrieve the id value
                HSSFCell cell = row.createCell(j);
                if(dataMap.get(code) == null||dataMap.get(code).equals("")){
                    cell.setCellValue("");
                    bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
                }else if(j==6||j==7||j==8){//第6、7、8列均为数字类型，需要转换，否则无法套用求和公式
                    cell.setCellValue(Double.parseDouble(dataMap.get(code).toString()));
                }else{
                    cell.setCellValue(dataMap.get(code).toString());
                }
                cell.setCellStyle(bodyCellStyle);
            }
        }
        //合计金额
        Font font = worksheet.getWorkbook().createFont();
        font.setBoldweight(Font.BOLDWEIGHT_BOLD);
        HSSFCellStyle cellStyle = worksheet.getWorkbook().createCellStyle();
        cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        cellStyle.setFont(font);
        cellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        cellStyle.setBorderRight(CellStyle.BORDER_THIN);
        cellStyle.setBorderBottom(CellStyle.BORDER_THIN);
        int sumRowIndex = datasource.size()+startRowIndex;
        HSSFRow sumRow = worksheet.createRow(sumRowIndex);
        for(int i=0;i<codeList.size();i++){
            if(i==0){
                HSSFCell cell0 = sumRow.createCell(i);
                cell0.setCellValue("合计金额:");
                cell0.setCellStyle(cellStyle);
            }else if(i==7){
                HSSFCell cell7 = sumRow.createCell(i);
                int firstRowIndex = startRowIndex+1;
                cell7.setCellFormula("SUM(H"+firstRowIndex+":H"+sumRowIndex+")");
                cell7.setCellStyle(cellStyle);
            }else{
                HSSFCell celli = sumRow.createCell(i);
                celli.setCellStyle(cellStyle);
            }
        }
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex,sumRowIndex, 0, startColIndex-2));
        //附上表的生成日期
        HSSFCellStyle dateCellStyle = worksheet.getWorkbook().createCellStyle();
        dateCellStyle.setAlignment(CellStyle.ALIGN_RIGHT);
        HSSFRow dateRow = worksheet.createRow(sumRowIndex+1);
        HSSFCell dateCell = dateRow.createCell(0);
        dateCell.setCellValue("审批人: "+paramMap.get("CHECKER")+"     制表时间: "+DateUtil.getSysdateString("yyyy-MM-dd HH:mm"));
        dateCell.setCellStyle(dateCellStyle);
        worksheet.addMergedRegion(new CellRangeAddress(sumRowIndex+1,sumRowIndex+1, 0, startColIndex-1));
    }
    @SuppressWarnings({ "rawtypes" })
    public static void fillWhConclusion(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<LinkedHashMap> datasource) {

        // Row offset
        startRowIndex += 2;

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(false); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = startRowIndex; i + startRowIndex - 2 < datasource.size() + 2; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short) i + 1);

            LinkedHashMap dataMap = datasource.get(i - 2);
            HSSFCell cell1 = row.createCell(0);
            if (dataMap.get("MONTH") == null || dataMap.get("MONTH").equals("")) {
                cell1.setCellValue("");
            } else {
                cell1.setCellValue(dataMap.get("MONTH").toString());
            }
            cell1.setCellStyle(bodyCellStyle);
            HSSFCell cell2 = row.createCell(1);
            if (dataMap.get("CHINESENAME") == null || dataMap.get("CHINESENAME").equals("")) {
                cell2.setCellValue("");
            } else {
                cell2.setCellValue(dataMap.get("CHINESENAME").toString());
            }
            cell2.setCellStyle(bodyCellStyle);
            HSSFCell cell3 = row.createCell(2);
            if (dataMap.get("TOTAL_WH") == null || dataMap.get("TOTAL_WH").equals("")) {
                cell3.setCellValue("");
            } else {
                cell3.setCellValue(dataMap.get("TOTAL_WH").toString());
            }
            cell3.setCellStyle(bodyCellStyle);

            HSSFCell cell4 = row.createCell(3);
            if (dataMap.get("TOTAL_WD") == null || dataMap.get("TOTAL_WD").equals("")) {
                cell4.setCellValue("");
            } else {
                cell4.setCellValue(dataMap.get("TOTAL_WD").toString());
            }
            cell4.setCellStyle(bodyCellStyle);

            HSSFCell cell5 = row.createCell(4);
            if (dataMap.get("WEI_1_HOUR") == null || dataMap.get("WEI_1_HOUR").equals("")) {
                cell5.setCellValue("");
            } else {
                cell5.setCellValue(dataMap.get("WEI_1_HOUR").toString());
            }
            cell5.setCellStyle(bodyCellStyle);

            HSSFCell cell6 = row.createCell(5);
            if (dataMap.get("WEI_1_DAY") == null || dataMap.get("WEI_1_DAY").equals("")) {
                cell6.setCellValue("");
            } else {
                cell6.setCellValue(dataMap.get("WEI_1_DAY").toString());
            }
            cell6.setCellStyle(bodyCellStyle);

            HSSFCell cell7 = row.createCell(6);
            if (dataMap.get("WEI_2_HOUR") == null || dataMap.get("WEI_2_HOUR").equals("")) {
                cell7.setCellValue("");
            } else {
                cell7.setCellValue(dataMap.get("WEI_2_HOUR").toString());
            }
            cell7.setCellStyle(bodyCellStyle);

            HSSFCell cell8 = row.createCell(7);
            if (dataMap.get("WEI_2_DAY") == null || dataMap.get("WEI_2_DAY").equals("")) {
                cell8.setCellValue("");
            } else {
                cell8.setCellValue(dataMap.get("WEI_2_DAY").toString());
            }
            cell8.setCellStyle(bodyCellStyle);

            HSSFCell cell9 = row.createCell(8);
            if (dataMap.get("WEI_3_HOUR") == null || dataMap.get("WEI_3_HOUR").equals("")) {
                cell9.setCellValue("");
            } else {
                cell9.setCellValue(dataMap.get("WEI_3_HOUR").toString());
            }
            cell9.setCellStyle(bodyCellStyle);

            HSSFCell cell10 = row.createCell(9);
            if (dataMap.get("WEI_3_DAY") == null || dataMap.get("WEI_3_DAY").equals("")) {
                cell10.setCellValue("");
            } else {
                cell10.setCellValue(dataMap.get("WEI_3_DAY").toString());
            }
            cell10.setCellStyle(bodyCellStyle);

            HSSFCell cell11 = row.createCell(10);
            if (dataMap.get("WEI_4_HOUR") == null || dataMap.get("WEI_4_HOUR").equals("")) {
                cell11.setCellValue("");
            } else {
                cell11.setCellValue(dataMap.get("WEI_4_HOUR").toString());
            }
            cell11.setCellStyle(bodyCellStyle);

            HSSFCell cell12 = row.createCell(11);
            if (dataMap.get("WEI_4_DAY") == null || dataMap.get("WEI_4_DAY").equals("")) {
                cell12.setCellValue("");
            } else {
                cell12.setCellValue(dataMap.get("WEI_4_DAY").toString());
            }
            cell12.setCellStyle(bodyCellStyle);
            
            HSSFCell cell13 = row.createCell(12);
            if (dataMap.get("WEI_5_DAY") == null || dataMap.get("WEI_5_DAY").equals("")) {
                cell13.setCellValue("");
            } else {
                cell13.setCellValue(dataMap.get("WEI_5_DAY").toString());
            }
            cell13.setCellStyle(bodyCellStyle);
            
            HSSFCell cell14 = row.createCell(13);
            if (dataMap.get("WEI_6_DAY") == null || dataMap.get("WEI_6_DAY").equals("")) {
                cell14.setCellValue("");
            } else {
                cell14.setCellValue(dataMap.get("WEI_6_DAY").toString());
            }
            cell14.setCellStyle(bodyCellStyle);

        }
    }
    @SuppressWarnings({ "rawtypes" })
    public static void fillWhConclusionSum(HSSFSheet worksheet, int startRowIndex, int startColIndex, List<LinkedHashMap> datasource) {

        // Row offset
        startRowIndex += 2;

        // Create cell style for the body
        HSSFCellStyle bodyCellStyle = worksheet.getWorkbook().createCellStyle();
        bodyCellStyle.setAlignment(CellStyle.ALIGN_CENTER);
        bodyCellStyle.setWrapText(false); // 是否自动换行.
        bodyCellStyle.setBorderLeft(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderRight(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderTop(CellStyle.BORDER_THIN);
        bodyCellStyle.setBorderBottom(CellStyle.BORDER_THIN);

        // Create body
        for (int i = startRowIndex; i + startRowIndex - 2 < datasource.size() + 2; i++) {
            // Create a new row
            HSSFRow row = worksheet.createRow((short) i + 1);

            LinkedHashMap dataMap = datasource.get(i - 2);
            HSSFCell cell1 = row.createCell(0);
            if (dataMap.get("START_MONTH") == null || dataMap.get("START_MONTH").equals("")) {
                cell1.setCellValue("");
            } else {
                cell1.setCellValue(dataMap.get("START_MONTH").toString());
            }
            cell1.setCellStyle(bodyCellStyle);
            HSSFCell cell2 = row.createCell(1);
            if (dataMap.get("END_MONTH") == null || dataMap.get("END_MONTH").equals("")) {
                cell2.setCellValue("");
            } else {
                cell2.setCellValue(dataMap.get("END_MONTH").toString());
            }
            cell2.setCellStyle(bodyCellStyle);
            HSSFCell cell3 = row.createCell(2);
            if (dataMap.get("CHINESENAME") == null || dataMap.get("CHINESENAME").equals("")) {
                cell3.setCellValue("");
            } else {
                cell3.setCellValue(dataMap.get("CHINESENAME").toString());
            }
            cell3.setCellStyle(bodyCellStyle);

            HSSFCell cell4 = row.createCell(3);
            if (dataMap.get("TOTAL_WH") == null || dataMap.get("TOTAL_WH").equals("")) {
                cell4.setCellValue("");
            } else {
                cell4.setCellValue(dataMap.get("TOTAL_WH").toString());
            }
            cell4.setCellStyle(bodyCellStyle);

            HSSFCell cell5 = row.createCell(4);
            if (dataMap.get("TOTAL_WD") == null || dataMap.get("TOTAL_WD").equals("")) {
                cell5.setCellValue("");
            } else {
                cell5.setCellValue(dataMap.get("TOTAL_WD").toString());
            }
            cell5.setCellStyle(bodyCellStyle);

            HSSFCell cell6 = row.createCell(5);
            if (dataMap.get("WEI_1_HOUR") == null || dataMap.get("WEI_1_HOUR").equals("")) {
                cell6.setCellValue("");
            } else {
                cell6.setCellValue(dataMap.get("WEI_1_HOUR").toString());
            }
            cell6.setCellStyle(bodyCellStyle);

            HSSFCell cell7 = row.createCell(6);
            if (dataMap.get("WEI_1_DAY") == null || dataMap.get("WEI_1_DAY").equals("")) {
                cell7.setCellValue("");
            } else {
                cell7.setCellValue(dataMap.get("WEI_1_DAY").toString());
            }
            cell7.setCellStyle(bodyCellStyle);

            HSSFCell cell8 = row.createCell(7);
            if (dataMap.get("WEI_2_HOUR") == null || dataMap.get("WEI_2_HOUR").equals("")) {
                cell8.setCellValue("");
            } else {
                cell8.setCellValue(dataMap.get("WEI_2_HOUR").toString());
            }
            cell8.setCellStyle(bodyCellStyle);

            HSSFCell cell9 = row.createCell(8);
            if (dataMap.get("WEI_2_DAY") == null || dataMap.get("WEI_2_DAY").equals("")) {
                cell9.setCellValue("");
            } else {
                cell9.setCellValue(dataMap.get("WEI_2_DAY").toString());
            }
            cell9.setCellStyle(bodyCellStyle);

            HSSFCell cell10 = row.createCell(9);
            if (dataMap.get("WEI_3_HOUR") == null || dataMap.get("WEI_3_HOUR").equals("")) {
                cell10.setCellValue("");
            } else {
                cell10.setCellValue(dataMap.get("WEI_3_HOUR").toString());
            }
            cell10.setCellStyle(bodyCellStyle);

            HSSFCell cell11 = row.createCell(10);
            if (dataMap.get("WEI_3_DAY") == null || dataMap.get("WEI_3_DAY").equals("")) {
                cell11.setCellValue("");
            } else {
                cell11.setCellValue(dataMap.get("WEI_3_DAY").toString());
            }
            cell11.setCellStyle(bodyCellStyle);

            HSSFCell cell12 = row.createCell(11);
            if (dataMap.get("WEI_4_HOUR") == null || dataMap.get("WEI_4_HOUR").equals("")) {
                cell12.setCellValue("");
            } else {
                cell12.setCellValue(dataMap.get("WEI_4_HOUR").toString());
            }
            cell12.setCellStyle(bodyCellStyle);

            HSSFCell cell13 = row.createCell(12);
            if (dataMap.get("WEI_4_DAY") == null || dataMap.get("WEI_4_DAY").equals("")) {
                cell13.setCellValue("");
            } else {
                cell13.setCellValue(dataMap.get("WEI_4_DAY").toString());
            }
            cell13.setCellStyle(bodyCellStyle);

            HSSFCell cell14 = row.createCell(13);
            if (dataMap.get("WEI_5_DAY") == null || dataMap.get("WEI_5_DAY").equals("")) {
                cell14.setCellValue("");
            } else {
                cell14.setCellValue(dataMap.get("WEI_5_DAY").toString());
            }
            cell14.setCellStyle(bodyCellStyle);

            HSSFCell cell15 = row.createCell(14);
            if (dataMap.get("WEI_6_DAY") == null || dataMap.get("WEI_6_DAY").equals("")) {
                cell15.setCellValue("");
            } else {
                cell15.setCellValue(dataMap.get("WEI_6_DAY").toString());
            }
            cell15.setCellStyle(bodyCellStyle);

        }
    }
}
