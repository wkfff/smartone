package com.siping.hrm.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
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
import org.apache.log4j.Logger;
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

import com.siping.hrm.dao.InfoStatisticsDao;
import com.siping.hrm.service.InfoStatisticsSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.EncryptUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class InfoStatisticsSerImpl implements InfoStatisticsSer {
    Logger logger = Logger.getLogger(InfoStatisticsSerImpl.class);
    @Autowired
    private InfoStatisticsDao infoStatisticsDao;

    @SuppressWarnings({ "unchecked", "rawtypes" })
    @Override
    public void downloadEmpInfoTemplate(HttpServletRequest request, HttpServletResponse response) {
        // 先取出设定了格式的Excel表，再在此表的基础上生成表头和有效性限制
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/hr_personInfo.xls");
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
            sheet = workbook.createSheet("Employee Information");
        }
        // 创建并隐藏hidden sheet
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null) {
            hidden = workbook.createSheet("hidden");
        }
        workbook.setSheetHidden(workbook.getSheetIndex(hidden), true);

        int hiddenColumn = 10; // 记录hidden表使用了多少列,第0列和第1列存放表头的CODE和DATATYPE
        int sRow = 4, eRow = 99; // 开始行数和结束行数（+1后为excel中的实际行数）

        // 生成表头和对应的数据库字段与数据类型并放在Excel表单中的相应位置
        Map tmpParamMap = new LinkedHashMap();

        // 获取必填项并载入
        tmpParamMap.put("LIKE", "#*%");
        List<HashMap> columnTitleList = this.infoStatisticsDao.getTitles(tmpParamMap);
        this.reorderList(columnTitleList);

        // 获取选填项并载入
        tmpParamMap.put("LIKE", "#%");
        tmpParamMap.put("UNLIKE", "#*%");
        List<HashMap> optionalColTitleList = this.infoStatisticsDao.getTitles(tmpParamMap);
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
            int intColLength;
            try {
    				intColLength = Integer.parseInt(columnTitleList.get(i).get("DATA_LENGTH").toString());
    			} catch (Exception e) {
	    			intColLength=20;
	    			// TODO: handle exception
	    		}
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
            String tableName = null;
            String parentCode = null;
            String columnName = null;
            String columnCode = null;
            if (strColCode.equals("POSITION_ID") || strColCode.equals("POST_GROUP_ID") || strColCode.equals("POST_ID") || strColCode.equals("POST_GRADE_ID")) {
                tableName = this.trimIDString(strColCode, "HR_", "");
                columnName = this.trimIDString(strColCode, "", "_NAME");
                columnCode = this.trimIDString(strColCode, "", "_ID");
                parentCode = null;
            } else if (strColCode.equals("DEPTID")) {
                tableName = "HR_DEPARTMENT";
                columnName = "DEPTNAME";
                columnCode = "DEPTID";
                parentCode = null;
            } else {
                tableName = "SY_CODE";
                columnName = "CODE_NAME";
                columnCode = "CODE_ID";
                if (strColCode.equals("STATUS_CODE")) { // 例外的处理
                    parentCode = "EmpStatus";
                } else if (strColCode.equals("EMP_TYPE_CODE")) {
                    parentCode = "EmpDivision";
                } else if (strColCode.equals("BORNPLACE_CODE")) {
                    parentCode = "BornPlaceCode";
                } else if (strColCode.equals("MEMBERSHIP")) {
                    parentCode = "yesOrno";
                } else if (strColCode.equals("IDCARD_TYPE_CODE")) {
                    parentCode = "RegTypeCode";
                } else if (strColCode.equals("MAJOR_CODE")) {
                    parentCode = "SubjectCode";
                } else if (strColCode.equals("SHIFT_CODE")) {
                    parentCode = "WorkShiftCode";
                } else if (strColCode.equals("SUPPLIER_CODE")) {
                    parentCode = "supplierCode";
                } else {
                    parentCode = this.capitalize(strColCode);
                }
            }

            // 设定字段显示的顺序(ORDERNO)
            cell = hiddenRow.createCell(6);
            cell.setCellValue(String.valueOf(i));

            // 查询出数字有效性的选项，设置hidden表的数据
            Map optionParamMap = new LinkedHashMap();
            optionParamMap.put("PARENT_CODE", parentCode);
            optionParamMap.put("TABLE_NAME", tableName);
            optionParamMap.put("COLUMN_NAME", columnName);
            options = this.infoStatisticsDao.getOptions(optionParamMap);
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

            // 对于专业科目特殊处理
            if (parentCode != null && parentCode.equals("SubjectCode")) {
                sheet.addValidationData(largeOptionValidation(hidden, options, hiddenColumn, sRow, eRow, i, i));
                hiddenColumn++;
                continue;
            }

            // 设置数据有效性
            sheet.addValidationData(constraintValidation(options, sRow, eRow, i, i));
        }

        // 将生成的Excel表格输出
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("人事--员工信息", "UTF-8");
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

    public HSSFDataValidation constraintValidation(String[] options, int startRow, int endRow, int startColumn, int endColumn) {
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(options);
        CellRangeAddressList regions = new CellRangeAddressList(startRow, endRow, startColumn, endColumn);
        return new HSSFDataValidation(regions, constraint);
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

    /**
     * 将"XXX_ID"转为"prefix_XXX_suffix"
     */
    public String trimIDString(String string, String prefix, String suffix) {
        String resultStr = prefix + string.substring(0, string.lastIndexOf("_ID")) + suffix;
        return resultStr;
    }

    /**
     * 为startRow 至 endRow, startColumn 至 endColumn 中间的区域设置数据有效性限制， 限制的选项为option,
     * 存储在hidden里的columnNum列.
     */
    public HSSFDataValidation largeOptionValidation(HSSFSheet hidden, String[] options, int columnNum, int startRow, int endRow, int startColumn, int endColumn) {
        for (int i = 0, length = options.length; i < length; i++) {
            HSSFRow row = hidden.getRow(i);
            if (row == null) {
                row = hidden.createRow(i);
            }
            String cellValue = options[i];
            row.createCell(columnNum - 1).setCellValue(cellValue);
        }
        // 要加入检验columnNum是不是大于26的，如果是，还要进行改变。
        String columnName = String.valueOf((char) (columnNum + 64));
        DVConstraint constraint = DVConstraint.createFormulaListConstraint("hidden!" + columnName + "1:" + columnName + options.length);
        CellRangeAddressList regions = new CellRangeAddressList(startRow, endRow, startColumn, endColumn);
        return new HSSFDataValidation(regions, constraint);
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
            // 将EMPID和CHINESENAME属性找出并放到前两位，将所有COMMENTS的#去掉
            HashMap empidMap = null;
            HashMap chineseMap = null;
            for (int i = 0; i < list.size(); i++) {
                HashMap tmpMap = list.get(i);
                if (tmpMap.get("COLUMN_NAME").toString().equals("EMPID")) {
                    empidMap = new HashMap(tmpMap);
                    list.remove(i);
                    i--;
                } else if (tmpMap.get("COLUMN_NAME").toString().equals("CHINESENAME")) {
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

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadEmpInfoTemplate(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException {
        List paramList = new ArrayList();
        // 解析 Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = sheet.getRow(3);
        Map map = new LinkedHashMap();

        // 取出Excel的表头信息,创建表TMP_PERSONAL_INFO和表TMP_PERSONAL_TITLES
        HSSFSheet hidden = workbook.getSheet("hidden");
        if (hidden == null)
            return "无效表格！";

        Map columnsTitleMap = this.getColumnsTitle(hidden);
        String titleString = (String) columnsTitleMap.get("title");
        List titleCodeList = (List) columnsTitleMap.get("titleCode");
        List dataTypeList = (List) columnsTitleMap.get("dataType");
        map.put("TITLES", titleString);
        this.infoStatisticsDao.createTmpPersonalInfo(map);

        // 取出Excel里的title有关的信息，放入TMP_PERSONAL_TITLES表中
        List titleList = this.getTitlesInfo(row, hidden);
        this.infoStatisticsDao.updateTmpPersonalTitles(titleList);

        // 取出empInfoExcel里的内容
        int i = 3;
        while (true) {
            i++;
            row = sheet.getRow(i);
            map = this.getRowInfo(row, titleCodeList, dataTypeList);
            if (map == null)
                break;
            paramList.add(map);
        }

        // 将Excel里的内容放入临时表TMP_PERSONAL_INFO
        this.infoStatisticsDao.updateTmpPersonalInfo(paramList);
        return "Y";
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

    /**
     * 取出Excel两列的数据拼接成字符串，并取出两列的长度 (EMPID varchar2(20) --> EMPID varchar2(20))
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
     * 从Excel中取出具体的个人信息
     * @throws ParseException
     */
    @SuppressWarnings({ "unchecked", "rawtypes" })
    public Map getRowInfo(HSSFRow row, List titleCodeList, List dataTypeList) throws ParseException {
        if (row == null)
            return null;
        String valuesStr = "", titlesStr = "";
        HSSFCell cell = row.getCell(0);
        if (cell == null)
            return null;
        String cellValue = cell.getStringCellValue(); // empId
        if (cellValue == null || cellValue == "")
            return null;
        Map map = new LinkedHashMap();
        map.put("EMPID", cellValue);
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

    /**
     * 获取临时表的字段名字（titleName）
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getColumnList(HttpServletRequest request, HttpServletResponse response) throws SQLException {
        return this.infoStatisticsDao.getColumnList("TMP_PERSONAL_INFO");
    }

    /**
     * 获取临时表中的数据
     */
    @SuppressWarnings("rawtypes")
    @Override
    public List getTmpInfoList() throws Exception {
        return this.infoStatisticsDao.getTmpInfoList();
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String saveEmpTmpInfo(HttpServletRequest request) throws Exception {
        String resultStr = "Y";
        // 修改临时表的内容，将内容转为code
        this.infoStatisticsDao.modifyTmpTable();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = new LinkedHashMap();
        paramMap.put("ADMIN_ID", admin.getAdminID());

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        appendMap.put("PASSWORD", EncryptUtil.MD5Encode("123456"));
        // 取出tmp表中的数据放入list中，根据修改和增加来执行不同的操作
        // List titleList = this.fileUploadDao.getTitleList();
        // 取出更新列表被移除
        // List updateList = this.infoStatisticsDao.getUpdateList(paramMap);
        // 更新更新列表被移除
        // this.infoStatisticsDao.updateHire(updateList);

        List insertList = this.infoStatisticsDao.getEmpInsertList(paramMap);
        if(insertList.size()==0){
            return resultStr = "没有新增的员工信息";
        }
        this.infoStatisticsDao.insertHire(ObjectBindUtil.getRequestListData(insertList, appendMap));
        return resultStr;
    }

    /* static info operation */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getInfoTypeList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        retrunList = this.infoStatisticsDao.getInfoTypeList(paramMap);

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getInfoTableList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        retrunList = this.infoStatisticsDao.getInfoTableList(paramMap);

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getInfoFieldList(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        retrunList = this.infoStatisticsDao.getInfoFieldList(paramMap);

        return retrunList;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getFieldInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.infoStatisticsDao.getFieldInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.infoStatisticsDao.getFieldInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getFieldInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("language", Messages.getLanguage(request));

        return this.infoStatisticsDao.getFieldInfoCnt(paramMap);
    }

    @SuppressWarnings({ "rawtypes" })
    public String getDataColumnsParam(Object paramMap) {

        List fieldList = this.infoStatisticsDao.getFieldInfo(paramMap);
        List tableList = this.infoStatisticsDao.getFieldTableInfo(paramMap);
        String sqlString = "SELECT ";
        String fromWhereString = " FROM ";
        if (fieldList.size() == 0 || tableList.size() == 0) {
            sqlString = "";
        } else {
            for (int i = 0; i < fieldList.size(); i++) {
                LinkedHashMap map = (LinkedHashMap) fieldList.get(i);
                sqlString += map.get("TABLE_ID") + "." + map.get("FIELD_ID");
                if (i == fieldList.size() - 1) {
                    sqlString += " ";
                } else {
                    sqlString += ", ";
                }
            }
            for (int i = 0; i < tableList.size(); i++) {
                LinkedHashMap map = (LinkedHashMap) tableList.get(i);
                fromWhereString += map.get("TABLE_ID");
                if (i == tableList.size() - 1) {
                    fromWhereString += " ";
                } else {
                    fromWhereString += ", ";
                }
            }
            for (int i = 0; i < tableList.size() - 1; i = i + 1) {
                LinkedHashMap map = (LinkedHashMap) tableList.get(0);
                if (tableList.size() == 1) {

                } else {
                    if (i == 0) {
                        LinkedHashMap map1 = (LinkedHashMap) tableList.get(i + 1);
                        fromWhereString += " WHERE " + map.get("TABLE_ID") + ".EMPID = " + map1.get("TABLE_ID") + ".EMPID(+)";
                    } else {
                        LinkedHashMap map1 = (LinkedHashMap) tableList.get(i + 1);
                        fromWhereString += " AND " + map.get("TABLE_ID") + ".EMPID = " + map1.get("TABLE_ID") + ".EMPID(+)";
                    }
                }
            }
        }
        return sqlString + fromWhereString;
    }

    @SuppressWarnings({ "rawtypes" })
    public String getDataColumnsCntParam(Object paramMap) {

        List tableList = this.infoStatisticsDao.getFieldTableInfo(paramMap);
        String sqlString = "SELECT COUNT(*) CNT ";
        String fromWhereString = " FROM ";
        if (tableList.size() == 0) {
            sqlString = "";
        } else {
            for (int i = 0; i < tableList.size(); i++) {
                LinkedHashMap map = (LinkedHashMap) tableList.get(i);
                fromWhereString += map.get("TABLE_ID");
                if (i == tableList.size() - 1) {
                    fromWhereString += " ";
                } else {
                    fromWhereString += ", ";
                }
            }
            for (int i = 0; i < tableList.size() - 1; i = i + 1) {
                LinkedHashMap map = (LinkedHashMap) tableList.get(0);
                if (tableList.size() == 1) {

                } else {
                    if (i == 0) {
                        LinkedHashMap map1 = (LinkedHashMap) tableList.get(i + 1);
                        fromWhereString += " WHERE " + map.get("TABLE_ID") + ".EMPID = " + map1.get("TABLE_ID") + ".EMPID(+)";
                    } else {
                        LinkedHashMap map1 = (LinkedHashMap) tableList.get(i + 1);
                        fromWhereString += " AND " + map.get("TABLE_ID") + ".EMPID = " + map1.get("TABLE_ID") + ".EMPID(+)";
                    }
                }
            }
        }
        return sqlString + fromWhereString;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public List getDataInfo(HttpServletRequest request) {
        List retrunList = new ArrayList();
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("sqlStatement", this.getDataColumnsParam(paramMap));
        paramMap.put("language", Messages.getLanguage(request));

        if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
            retrunList = this.infoStatisticsDao.getDataInfo(paramMap, NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("page")), Integer.class),
                NumberUtils.parseNumber(ObjectUtils.toString(paramMap.get("pagesize")), Integer.class));
        } else {
            retrunList = this.infoStatisticsDao.getDataInfo(paramMap);
        }

        return retrunList;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int getDataInfoCnt(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());
        paramMap.put("sqlStatement", this.getDataColumnsCntParam(paramMap));

        return this.infoStatisticsDao.getDataInfoCnt(paramMap);
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int deleteFieldInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();

        appendMap.put("CREATED_BY", admin.getAdminID());
        // 页面提交的JSON信息
        String jsonString = request.getParameter("jsonData");

        List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString, appendMap);
        if (delList.size() > 0) {
            this.infoStatisticsDao.deleteFieldInfo(delList);
            paramMap.remove("jsonData");
            paramMap.remove("HR_ADMIN_ID");
            paramMap.remove("CREATED_BY");
            paramMap.remove("CPNY_ID");
        } else {
            this.infoStatisticsDao.deleteFieldInfo(paramMap);
        }

        return 1;
    }

    @Override
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public int addFieldInfo(HttpServletRequest request) {
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        Map paramMap = ObjectBindUtil.getRequestParamData(request);
        paramMap.put("HR_ADMIN_ID", admin.getAdminID());
        paramMap.put("CREATED_BY", admin.getAdminID());
        paramMap.put("CPNY_ID", admin.getCpnyId());

        return this.infoStatisticsDao.addFieldInfo(paramMap);
    }

    @Override
    public void downloadCertificateInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/hr_certificateInfo.xls");
        File file = new File(path);
        InputStream inputStream = new FileInputStream(file);
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("人事--证书信息.xls", "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        OutputStream outputStream = response.getOutputStream();
        byte[] b = new byte[1024];
        int length;
        while ((length = inputStream.read(b)) > 0) {
            outputStream.write(b, 0, length);
        }
        inputStream.close();
        outputStream.close();
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadCertificateExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException {
        List paramList = new ArrayList();
        // 解析Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = null;
        Map map = new LinkedHashMap();
        int rowsnum = sheet.getPhysicalNumberOfRows();
        for (int i = 2; i < rowsnum; i++) {
            row = sheet.getRow(i);
            if (row != null) {
                map = this.getCertificateRowInfo(row);
            }
            if (map == null) {
                continue;
            }
            paramList.add(map);
        }
        // 将Excel里的内容添加进HR_QUALIFICATION中
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
        appendMap.put("CREATED_BY", admin.getAdminID());
        appendMap.put("CPNY_ID", admin.getCpnyId());
        LinkedHashMap<String, Object> requestParameter = ObjectBindUtil.getRequestParamData(request);
        ObjectBindUtil.getRequestListData(paramList, appendMap);
        ObjectBindUtil.getRequestListData(paramList, requestParameter);
        return this.infoStatisticsDao.addCertificateInfo(paramList);
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    private Map getCertificateRowInfo(HSSFRow row) {
        HSSFCell cellEmpid = row.getCell(0);
        HSSFCell cellQualLocation = row.getCell(3);
        HSSFCell cellQualCardName = row.getCell(4);
        HSSFCell cellQualCardNo = row.getCell(5);
        HSSFCell cellDateObtained = row.getCell(6);
        HSSFCell cellEndQualDate = row.getCell(7);
        HSSFCell cellAnnualDate = row.getCell(8);
        HSSFCell cellRemark = row.getCell(9);
        String empId = "";
        String qualCardLocation = "";
        String qualCardName = "";
        String qualCardNo = "";
        String dateObtained = "";
        String endQualDate = "";
        String annualDate = "";
        String remark = "";

        // 判断empId是否为空
        if (cellEmpid == null) {
            return null;
        }
        empId = cellEmpid.toString().trim();
        if ("".equals(empId)) {
            return null;
        }
        // 判断qualCardLocation是否为空
        if (cellQualLocation == null) {
            return null;
        }
        qualCardLocation = cellQualLocation.toString().trim();
        if ("".equals(qualCardLocation)) {
            return null;
        }
        // 判断qualCardName是否为空
        if (cellQualCardName == null) {
            return null;
        }
        qualCardName = cellQualCardName.toString().trim();
        if ("".equals(qualCardName)) {
            return null;
        }
        // 判断qualCardNo是否为空
        if (cellQualCardNo == null) {
            return null;
        }
        qualCardNo = cellQualCardNo.toString().trim();
        if ("".equals(qualCardNo)) {
            return null;
        }
        // 判断dateObtained是否为空
        if (cellDateObtained == null) {
            return null;
        }
        dateObtained = cellDateObtained.toString().trim();
        if ("".equals(dateObtained)) {
            return null;
        }
        // 判断endQualDate是否为空
        if (cellEndQualDate == null) {
            return null;
        }
        endQualDate = cellEndQualDate.toString().trim();
        if ("".equals(endQualDate)) {
            return null;
        }
        // 判断annualDate是否为空
        if (cellAnnualDate != null) {
            annualDate = cellAnnualDate.toString().trim();
        }
        // 判断remark是否为空
        if (cellRemark != null) {
            remark = cellRemark.toString().trim();
        }

        Map map = new LinkedHashMap();
        map.put("EMPID", empId);
        map.put("QUAL_LOCATION", qualCardLocation);
        map.put("QUAL_CARD_NAME", qualCardName);
        map.put("QUAL_CARD_NO", qualCardNo);
        map.put("DATE_OBTAINED", dateObtained);
        map.put("END_QUAL_DATE", endQualDate);
        map.put("ANNUAL_DATE", annualDate);
        map.put("REMARK", remark);
        return map;
    }

    @Override
    public void downloadTrainingInfoTemplate(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String path = request.getSession().getServletContext().getRealPath("/resources/excel/hr_trainingInfo.xls");
        File file = new File(path);
        InputStream inputStream = new FileInputStream(file);
        String fileName = null;
        try {
            fileName = java.net.URLEncoder.encode("人事--培训记录.xls", "UTF-8");
        } catch (UnsupportedEncodingException e1) {
            e1.printStackTrace();
        }
        response.setCharacterEncoding("utf-8");
        response.setContentType("multipart/form-data");
        response.setHeader("Content-Disposition", "attachment;fileName=" + fileName);
        OutputStream outputStream = response.getOutputStream();
        byte[] b = new byte[1024];
        int length;
        while ((length = inputStream.read(b)) > 0) {
            outputStream.write(b, 0, length);
        }
        inputStream.close();
        outputStream.close();
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public String uploadTrainingExcel(MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ParseException {
        List paramList = new ArrayList();
        // 解析Excel
        HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
        HSSFSheet sheet = workbook.getSheetAt(0);
        HSSFRow row = null;
        Map map = new LinkedHashMap();
        int rowsnum = sheet.getPhysicalNumberOfRows();
        for (int i = 2; i < rowsnum; i++) {
            row = sheet.getRow(i);
            if (row != null) {
                map = this.getTrainingRowInfo(row,request);
            }
            if (map == null) {
                continue;
            }
            paramList.add(map);
        }
        if(paramList.size()==0){
            return "请检查表格必填项是否填写数据！";
        }

        return this.infoStatisticsDao.addTrainingInfo(paramList);
    }

    // 获取培训记录中的值并检查空值
    @SuppressWarnings({ "rawtypes", "unchecked" })
    private Map getTrainingRowInfo(HSSFRow row,HttpServletRequest request) {
        HSSFCell cellEmpid = row.getCell(0);
        HSSFCell cellCourseName = row.getCell(1);
        HSSFCell cellStartDate = row.getCell(2);
        HSSFCell cellClassHour = row.getCell(3);
        HSSFCell cellTeacher = row.getCell(4);
        HSSFCell cellCourseContent = row.getCell(5);
        HSSFCell cellTeachingMethods = row.getCell(6);
        HSSFCell cellEvaluationMethods = row.getCell(7);
        HSSFCell cellMark = row.getCell(8);
        HSSFCell cellRemark = row.getCell(9);

        String empId = "";
        String courseName = "";
        String startDate = "";
        String classHour = "";
        String teacher = "";
        String courseContent = "";
        String teachingMethods = "";
        String evaluationMethods = "";
        String mark = "";
        String remark = "";

        if (cellEmpid == null) {
            return null;
        }
        empId = cellEmpid.toString().trim();
        if ("".equals(empId)) {
            return null;
        }

        if (cellCourseName == null) {
            return null;
        }
        courseName = cellCourseName.toString().trim();
        if ("".equals(courseName)) {
            return null;
        }

        if (cellStartDate == null) {
            return null;
        }
        startDate = cellStartDate.toString().trim();
        if ("".equals(startDate)) {
            return null;
        }

        if (cellClassHour == null) {
            return null;
        }
        classHour = cellClassHour.toString();
        if ("".equals(classHour)) {
            return null;
        }

        teacher = cellTeacher.toString().trim();

        courseContent = cellCourseContent.toString().trim();

        teachingMethods = cellTeachingMethods.toString().trim();

        evaluationMethods = cellEvaluationMethods.toString().trim();

        mark = cellMark.toString().trim();

        remark = cellRemark.toString().trim();

        Map map = new LinkedHashMap();
        map.put("EMPID", empId);
        map.put("COURSE_NAME", courseName);
        map.put("START_DATE", startDate);
        map.put("CLASS_HOUR", classHour);
        map.put("TEACHER", teacher);
        map.put("COURSE_CONTENT", courseContent);
        map.put("TEACHING_METHODS", teachingMethods);
        map.put("EVALUATION_METHODS", evaluationMethods);
        map.put("MARK", mark);
        map.put("REMARK", remark);
        AdminBean admin = SessionUtil.getLoginUserFromSession(request);
        map.put("CREATED_BY", admin.getAdminID());
        return map;
    }
}
