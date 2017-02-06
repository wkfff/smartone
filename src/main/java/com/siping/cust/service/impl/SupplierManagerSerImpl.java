package com.siping.cust.service.impl;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import org.springframework.web.multipart.MultipartFile;
import org.testng.log4testng.Logger;

import com.siping.cust.dao.SupplierManagerDao;
import com.siping.cust.service.SupplierManagerSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

/***
 * ProductStorageSupplierSerImpl:供货提供商Ser
 */
@Service
public class SupplierManagerSerImpl implements SupplierManagerSer {

    Logger logger = Logger.getLogger(SupplierManagerSerImpl.class);// 用于捕获当前类所发生的异常
    // 注入Dao
    @Autowired
    private SupplierManagerDao supplierManagerDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String addOrUpdateSupplierModel(HttpServletRequest request) {
        // 用于返回是否发生异常的情况
        String returnString;
        // SESSION用户信息
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据,用于页面获取提交的数据,ObjectBindUtil这个方法作用于提取放在request中的数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        // 提取用户的一些基本信息，放入到Map集合中，便于保存
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("UPDATE_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        paramMap.put("language", Messages.getLanguage(request));

        // 从前台获取数据，先放到
        if (paramMap.get("SUPPLIER_NO") != null
                && !"".equals(paramMap.get("SUPPLIER_NO"))) {
            returnString = this.supplierManagerDao
                    .updateSupplierModel(paramMap);
        } else {
            returnString = this.supplierManagerDao.addProduct(paramMap);
        }
        return returnString;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public List getSupplierModelList(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        // 页面提交数据,用于页面获取提交的数据,ObjectBindUtil这个方法作用于提取放在request中的数据
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));
        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            return this.supplierManagerDao.getSupplierModelList(paramMap,
                    NumberUtils.parseNumber(
                            ObjectUtils.toString(paramMap.get("page")),
                            Integer.class), NumberUtils.parseNumber(
                            ObjectUtils.toString(paramMap.get("pagesize")),
                            Integer.class));
        }
        return this.supplierManagerDao.getSuppliserModelList(paramMap);
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String deleteSupplierModel(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap appendMap = ObjectBindUtil.getRequestParamData(request);
        appendMap.put("UPDATE_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        return this.supplierManagerDao.deleteSupplierModel(appendMap);
    }

    @Override
    public int getSupplierModelCnt(HttpServletRequest request) {
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        int temp = this.supplierManagerDao.getSupplierModelCnt(paramMap);

        return temp;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Object getSupplierDetatil(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("SUPPLIER_ID", admin.getCpnyId());
        paramMap.put("ADMINID", admin.getAdminID());
        return this.supplierManagerDao.getSupplierDetatil(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public int getSupplierProductCountCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        // cpnyId保存的是供应商的编号
        paramMap.put("SUPPLIER_NO", admin.getCpnyId());
        return this.supplierManagerDao.getSupplierProductCountCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String updateSupplierBySupplier(HttpServletRequest request) {

        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("SUPPLIER_ID", admin.getCpnyId());
        paramMap.put("UPDATED_BY", admin.getAdminID());
        return this.supplierManagerDao.updateSupplierBySupplier(paramMap);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public void downloadSupperliersTemp(HttpServletRequest request, HttpServletResponse response) {
        //先取出设定了格式的Excel表，再在此表的基础上生成表头和有效性限制
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/supperliersImport.xls");
        HSSFWorkbook workbook = null;
        try {
            InputStream input = new FileInputStream(path);
            workbook = new HSSFWorkbook(input);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }

        HSSFSheet sheet = workbook.getSheetAt(0);
        if (sheet == null) {
            sheet = workbook.createSheet("supperliers Information");
        }
        // 创建并隐藏hidden sheet
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null) {
            hidden = workbook.createSheet("hidden");
        }
        workbook.setSheetHidden(workbook.getSheetIndex(hidden), true);

        int sRow = 4, eRow = 199; // 开始行数和结束行数（+1后为excel中的实际行数）

        // 生成表头和对应的数据库字段与数据类型并放在Excel表单中的相应位置
        Map tmpParamMap = new LinkedHashMap();

        // 获取必填项并载入
        tmpParamMap.put("LIKE", "#*%");
        List<HashMap> columnTitleList = this.supplierManagerDao.getExcelTitles(tmpParamMap);
        this.reorderList(columnTitleList);

        // 获取选填项并载入
        tmpParamMap.put("LIKE", "#%");
        tmpParamMap.put("UNLIKE", "#*%");
        List<HashMap> optionalColTitleList = this.supplierManagerDao.getExcelTitles(tmpParamMap);
        columnTitleList.addAll(optionalColTitleList);

        this.trimList(columnTitleList);

        // 创建Title Row
        HSSFRow row = sheet.createRow(3);
        HSSFCell cell = null;
        String strTitle = null, strColCode = null, strColType = null, strColLength = null;
        String[] options = null; // 数据有效性限制的选项
        for (int i = 0; i < columnTitleList.size(); i++) {
            strTitle = (String) columnTitleList.get(i).get("COMMENTS"); // 标题名
            strColCode = (String) columnTitleList.get(i).get("COLUMN_NAME"); // 字段名
            strColType = (String) columnTitleList.get(i).get("DATA_TYPE"); // 数据类型
            int intColLength = Integer.parseInt(columnTitleList.get(i).get("DATA_LENGTH").toString());// 数字类型数据长度
            intColLength = intColLength * 2; // 长度加倍，防止存入字符时溢出
            strColLength = String.valueOf(intColLength); // 数据长度
            if (!strColType.equalsIgnoreCase("DATE") && !strColType.equalsIgnoreCase("NUMBER")) {
                strColType = strColType + "(" + strColLength + ")";
            }
            HSSFRow hiddenRow = hidden.getRow(i);
            if (hiddenRow == null) {
                hiddenRow = hidden.createRow(i);
            }
            cell = row.createCell(i);
            cell.setCellValue(strTitle);
            cell = hiddenRow.createCell(0);
            cell.setCellValue(strColCode);
            cell = hiddenRow.createCell(1);
            cell.setCellValue(strColType);

            // 设定tableName列和parentCode列
            String tableName = "SY_CODE";
            String parentCode = "";
            String columnName = "CODE_NAME";
            String columnCode = "CODE_ID";
            if (strColCode.equals("SUPPLIER_TYPE")) {
                parentCode = "CustomerTypeCode";
            }else {
                parentCode = this.capitalize(strColCode);
            }

            // 设定字段显示的顺序(ORDERNO)
            cell = hiddenRow.createCell(6);
            cell.setCellValue(String.valueOf(i));

            // 查询出数字有效性的选项，设置hidden表的数据
            Map optionParamMap = new LinkedHashMap();
            optionParamMap.put("PARENT_CODE", parentCode);
            optionParamMap.put("TABLE_NAME", tableName);
            optionParamMap.put("COLUMN_NAME", columnName);
            options = this.supplierManagerDao.getColunmOptions(optionParamMap);
            if (options == null) { // 说明此字段不是code，标记parent_code和table_name为-1，直接写入表中。
                cell = hiddenRow.createCell(2);// parentCode
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(3);// tableName
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(4);// columnCode
                cell.setCellValue("-1");
                cell = hiddenRow.createCell(5);// columnName
                cell.setCellValue("-1");
                continue;
            } else {
                cell = hiddenRow.createCell(2);// parentCode
                if (parentCode == null)
                    parentCode = "-1";
                cell.setCellValue(parentCode);
                cell = hiddenRow.createCell(3);// tableName
                cell.setCellValue(tableName);
                cell = hiddenRow.createCell(4);// columnCode
                cell.setCellValue(columnCode);
                cell = hiddenRow.createCell(5);// columnName
                cell.setCellValue(columnName);
            }
            // 设置数据有效性
            sheet.addValidationData(constraintValidation(options, sRow, eRow, i, i));
        }

        // 将生成的Excel表格输出
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("供货商信息导入", "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setHeader("Content-Disposition", "inline; filename=" + fileName + ".xls");
        response.setContentType("application/vnd.ms-excel");
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.flush();
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
    }

    /**
     * 将list内的元素重新排序
     * @param list
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void reorderList(List<HashMap> list) {
        if (list == null || list.size() == 0)
            return;
        if (list.get(0).get("COMMENTS").toString().startsWith("#*")) {
            // 将ID和ENAME属性找出并放到前两位，将所有COMMENTS的#去掉
            HashMap empidMap = null;
            HashMap chineseMap = null;
            for (int i = 0; i < list.size(); i++) {
                HashMap tmpMap = list.get(i);
                if (tmpMap.get("COLUMN_NAME").toString().equals("SUPPLIER_ID")) {
                    empidMap = new HashMap(tmpMap);
                    list.remove(i);
                    i--;
                } else if (tmpMap.get("COLUMN_NAME").toString().equals("SUPPLIER_NAME")) {
                    chineseMap = new HashMap(tmpMap);
                    list.remove(i);
                    i--;
                } else {
                    continue;
                }
            }
            if (empidMap != null) {
                list.add(0, empidMap);
            }
            if (chineseMap != null) {
                list.add(1, chineseMap);
            }
        }
    }

    /**
     * 将COMMENTS的#符号去掉
     * @param list
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public void trimList(List<HashMap> list) {
        if (list == null || list.size() == 0)
            return;
        if (list.get(0).get("COMMENTS") == null)
            return;
        if (list.get(0).get("COMMENTS").toString().startsWith("#")) {
            for (int i = 0; i < list.size(); i++) {
                HashMap tmpMap = list.get(i);
                String comments = tmpMap.get("COMMENTS").toString();
                comments = comments.substring(comments.indexOf("#") + 1);
                tmpMap.put("COMMENTS", comments);
                list.remove(i);
                list.add(i, tmpMap);
            }
        }
    }

    /**
     * 将"XXX_YYY"格式字符串转化为"XxxYyy"格式
     */
    public String capitalize(String str) {
        String result = "";
        String[] subStr = str.split("_");
        for (int i = 0; i < subStr.length; i++) {
            result = result + StringUtils.capitalize(subStr[i].toLowerCase());
        }
        return result;
    }

    @SuppressWarnings("deprecation")
    public HSSFDataValidation constraintValidation(String[] options, int startRow, int endRow, int startColumn, int endColumn) {
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(options);
        CellRangeAddressList regions = new CellRangeAddressList(startRow, endRow, startColumn, endColumn);
        return new HSSFDataValidation(regions, constraint);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadSupplierInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception{
        List paramList = new ArrayList();
        // 解析 Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = sheet.getRow(3);
        Map map = new LinkedHashMap();

        // 取出Excel的表头信息,创建表
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null){
            return "无效表格！";
        }

        Map columnsTitleMap = this.getColumnsTitle(hidden);
        String titleString = (String) columnsTitleMap.get("title");
        List titleCodeList = (List) columnsTitleMap.get("titleCode");
        List dataTypeList = (List) columnsTitleMap.get("dataType");
        map.put("TITLES", titleString);
        this.supplierManagerDao.createTempSupplierInfo(map);

        // 取出Excel里的title有关的信息，放入表中
        List titleList = this.getTitlesInfo(row, hidden);
        this.supplierManagerDao.updateTempSupplierTitles(titleList);

        // 取出Excel里的内容
        int i = 3;
        while (true) {
            i++;
            row = sheet.getRow(i);
            map = this.getRowInfo(row, titleCodeList, dataTypeList);
            if (map == null)
                break;
            paramList.add(map);
        }

        // 将Excel里的内容放入临时表
        this.supplierManagerDao.updateTempSupplierInfo(paramList);
        return "Y";
    }

    /**
     * 取出Excel两列的数据拼接成字符串，并取出两列的长度 
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    private Map getColumnsTitle(HSSFSheet sheet) {
        Map result = new LinkedHashMap();
        List titleCodeList = new ArrayList();
        List dataTypeList = new ArrayList();
        String columnsTitle = "";
        String tmpStr = "";
        int i = 0, j = 0;
        while (true) {
            HSSFRow row = sheet.getRow(i);
            if (row == null)
                break;
            HSSFCell cell = row.getCell(j);
            if (cell == null)
                break;
            tmpStr = cell.getStringCellValue();
            titleCodeList.add(tmpStr);
            columnsTitle = columnsTitle + tmpStr + " ";
            cell = row.getCell(j + 1);
            tmpStr = cell.getStringCellValue();
            dataTypeList.add(tmpStr);
            columnsTitle = columnsTitle + tmpStr + ",";
            i++;
        }
        columnsTitle = columnsTitle.substring(0, columnsTitle.lastIndexOf(","));
        result.put("title", columnsTitle);
        result.put("length", i);
        result.put("titleCode", titleCodeList);
        result.put("dataType", dataTypeList);
        return result;
    }

    /**
     * 从Excel中取出表头的code、name和data type等信息
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    List getTitlesInfo(HSSFRow titleRow, HSSFSheet hidden) {
        List result = new ArrayList();
        HSSFRow row = null;
        int i = 0;
        String cellValue = "";
        while (true) {
            Map map = new LinkedHashMap();
            row = hidden.getRow(i);
            if (row == null || row.getCell(0) == null)
                break;
            cellValue = titleRow.getCell(i).getStringCellValue();
            map.put("TITLE_NAME", cellValue);
            cellValue = row.getCell(0).getStringCellValue();
            map.put("TITLE_CODE", cellValue);
            cellValue = row.getCell(1).getStringCellValue();
            map.put("DATA_TYPE", cellValue);
            cellValue = row.getCell(2).getStringCellValue();
            map.put("PARENT_CODE", cellValue);
            cellValue = row.getCell(3).getStringCellValue();
            map.put("TABLE_NAME", cellValue);
            cellValue = row.getCell(4).getStringCellValue();
            map.put("COLUMN_CODE", cellValue);
            cellValue = row.getCell(5).getStringCellValue();
            map.put("COLUMN_NAME", cellValue);
            cellValue = row.getCell(6).getStringCellValue();
            map.put("ORDERNO", cellValue);
            result.add(map);
            i++;
        }
        return result;
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    public Map getRowInfo(HSSFRow row, List titleCodeList, List dataTypeList) throws ParseException {
        if (row == null)
            return null;
        String valuesStr = "", titlesStr = "";
        HSSFCell cell = row.getCell(0);
        if (cell == null)
            return null;
        String cellValue = cell.getStringCellValue(); // CUST_ID
        if (cellValue == null || cellValue == "")
            return null;
        Map map = new LinkedHashMap();
        map.put("SUPPLIER_ID", cellValue);
        valuesStr = "''" + cellValue + "''";
        titlesStr = (String) titleCodeList.get(0);
        // 增加对于数据格式的判断（需要先在生成模板时加上去）
        for (int i = 1; i < titleCodeList.size(); i++) {
            cell = row.getCell(i);
            if (cell == null) {
                continue;
            }
            if (((String) dataTypeList.get(i)).equals("DATE")) { // 判断日期并解析
                String dateValue = this.parseDate2String(cell);
                if (dateValue != null) {
                    // map.put(titleCodeList.get(i), dateValue);
                    valuesStr = valuesStr + ", to_date(''" + dateValue + "'',''yyyy-MM-dd'') ";
                    titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                }
            } else {
                int cellType = cell.getCellType();
                if (cellType == Cell.CELL_TYPE_STRING) {
                    if (cell.getStringCellValue().equals("")) {
                        cellValue = "";
                    } else {
                        cellValue = cell.getStringCellValue();
                        valuesStr = valuesStr + ",''" + cellValue + "''";
                        titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                    }
                } else if (cellType == Cell.CELL_TYPE_NUMERIC) {
                    cellValue = String.valueOf(cell.getNumericCellValue());
                    valuesStr = valuesStr + ",''" + cellValue + "''";
                    titlesStr = titlesStr + "," + (String) titleCodeList.get(i);
                }
                // map.put(titleCodeList.get(i), cellValue);
            }
        }
        map.put("VALUESSTR", valuesStr);
        map.put("TITLESSTR", titlesStr);
        return map;
    }

    public String parseDate2String(HSSFCell cell) throws ParseException {
        Date dateValue = null;
        String stringValue = null;
        int cellType = cell.getCellType();
        if (cellType == Cell.CELL_TYPE_STRING) {
            String cellValue = cell.getStringCellValue();
            if (cellValue != null && cellValue != "") {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                dateValue = format.parse(cellValue);
                if (dateValue != null) { // cellValue符合"yyyy-MM-dd"格式
                    return cellValue;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        } else {
            dateValue = cell.getDateCellValue();
            if (dateValue != null) {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                stringValue = format.format(dateValue);
                return stringValue;
            } else
                return null;
        }
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierColumnList() throws Exception {
        return this.supplierManagerDao.getSupplierColumnList();
    }

    @SuppressWarnings("rawtypes")
    @Override
    public List getSupplierTmpList() throws Exception {
        return this.supplierManagerDao.getSupplierTmpList();
    }

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public String saveSupplierTmpInfo(HttpServletRequest request) throws Exception {
        String resultStr = "Y";
        // 修改临时表的内容，将内容转为code
        this.supplierManagerDao.modifySupplierTmpTable();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap.put("ADMIN_ID", admin.getAdminID());

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());

        List insertList = this.supplierManagerDao.getSupplierInsertList(paramMap);
        if(insertList.size()==0){
            return resultStr = "没有新增信息";
        }
        this.supplierManagerDao.insertSupplier(ObjectBindUtil.getRequestListData(insertList, appendMap));
        return resultStr;
    }
}
