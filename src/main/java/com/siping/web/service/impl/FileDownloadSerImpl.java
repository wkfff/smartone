package com.siping.web.service.impl;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.web.dao.FileDownloadDao;
import com.siping.web.service.FileDownloadSer;
import com.siping.web.utility.ObjectBindUtil;

@SuppressWarnings("deprecation")
@Service
public class FileDownloadSerImpl implements FileDownloadSer{

	@Autowired
	private FileDownloadDao fileDownloadDao;

	@Override
	public void downloadExcel(String fileName, HttpServletRequest request, HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);		
		
		String filePath = request.getSession().getServletContext().getRealPath("/resources/excel")+"\\"+fileName;
		InputStream inputStream = new FileInputStream(filePath);
		OutputStream outputStream = response.getOutputStream();
		byte[] b = new byte[1024];
		int length;
		while((length = inputStream.read(b))>0){
			outputStream.write(b, 0, length);
		}
		inputStream.close();
		outputStream.close();
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void downloadProductAppendix(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//将下载文件的数据从数据库中读出
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		Map resultMap = null;
		try {
			resultMap = (Map)this.fileDownloadDao.getProductAppendixInfo(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}
		if(resultMap==null || resultMap.isEmpty()) {
			return;
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		String fileName = resultMap.get("ORIGINAL_NAME")+"."+resultMap.get("APPENDIX_FORMAT");
		fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		String filePath = request.getSession().getServletContext().getRealPath(resultMap.get("STORE_PATH").toString())
				                                                               +"\\"+resultMap.get("APPENDIX_NAME");
		InputStream inputStream = new FileInputStream(filePath);
		OutputStream outputStream = response.getOutputStream();
		byte[] b = new byte[1024];
		int length;
		while((length = inputStream.read(b))>0){
			outputStream.write(b, 0, length);
		}
		inputStream.close();
		outputStream.close();
	}
	
	@SuppressWarnings("rawtypes")
	@Override
	public void downloadCustAppendix(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//将下载文件的数据从数据库中读出
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		Map resultMap = null;
		try {
			resultMap = (Map)this.fileDownloadDao.getCustAppendixInfo(paramMap);
		} catch (SQLException e) {
			e.printStackTrace();
			return ;
		}
		if(resultMap==null || resultMap.isEmpty()) {
			return;
		}
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		String fileName = resultMap.get("ORIGINAL_NAME")+"."+resultMap.get("APPENDIX_FORMAT");
		fileName = java.net.URLEncoder.encode(fileName, "UTF-8");
		response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
		String filePath = request.getSession().getServletContext().getRealPath(resultMap.get("STORE_PATH").toString())
				                                                               +"\\"+resultMap.get("APPENDIX_NAME");
		InputStream inputStream = new FileInputStream(filePath);
		OutputStream outputStream = response.getOutputStream();
		byte[] b = new byte[1024];
		int length;
		while((length = inputStream.read(b))>0){
			outputStream.write(b, 0, length);
		}
		inputStream.close();
		outputStream.close();
	}

	@Override
	public void downloadDynamicExcel(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException {
		this.downloadPersonalInfoExcel(request, response);	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public void downloadPersonalInfoExcel(HttpServletRequest request,
			HttpServletResponse response) throws SQLException, IOException{
		//先取出设定了格式的Excel表，再在此表的基础上生成表头和有效性限制
		String path = request.getSession().getServletContext().getRealPath("/resources/excel/hr_personInfo.xls");
		InputStream input = new FileInputStream(path);
		HSSFWorkbook workbook = new HSSFWorkbook(input);
		HSSFSheet sheet = workbook.getSheetAt(0);
		if(sheet == null){
			sheet = workbook.createSheet("Personal Information");
		}
		int hiddenColumn = 10; //记录hidden表使用了多少列,第0列和第1列存放表头的CODE和DATATYPE	
		int sRow=4, eRow=99; //开始行数和结束行数（+1后为excel中的实际行数）
		
		//生成表头和对应的数据库字段与数据类型并放在Excel表单中的相应位置
		Map tmpParamMap = new LinkedHashMap();
		//获取必填项
		tmpParamMap.put("LIKE", "#*%");		
		List<HashMap> columnTitleList = this.fileDownloadDao.getTitles(tmpParamMap);
		this.reorderList(columnTitleList);
		//获取选填项
		tmpParamMap.put("LIKE", "#%");
		tmpParamMap.put("UNLIKE", "#*%");
		List<HashMap> columnTitleList1 = this.fileDownloadDao.getTitles(tmpParamMap);
		columnTitleList.addAll(columnTitleList1);
		this.trimList(columnTitleList);
		HSSFSheet hidden = workbook.getSheet("hidden");  
		if(hidden == null){
			hidden = workbook.createSheet("hidden");
		}
		workbook.setSheetHidden(workbook.getSheetIndex(hidden), true);
		HSSFRow row = sheet.createRow(3);
		HSSFCell cell = null;
		String strTitle = null,strColCode = null,strColType = null,strColLength = null;
		String[] options = null; //数据有效性限制的选项
		for(int i=0; i<columnTitleList.size();i++){
			 strTitle = (String)columnTitleList.get(i).get("COMMENTS");  //标题名
			 strColCode = (String)columnTitleList.get(i).get("COLUMN_NAME"); //字段名
			 strColType = (String)columnTitleList.get(i).get("DATA_TYPE");  //数据类型
             int intColLength = Integer.parseInt(columnTitleList.get(i).get("DATA_LENGTH").toString());//数字类型数据长度
			 intColLength = intColLength*2; //长度加倍，防止存入字符时溢出
             strColLength = String.valueOf(intColLength); //数据长度
             if(!strColType.equalsIgnoreCase("DATE")&&!strColType.equalsIgnoreCase("NUMBER")){
            	 strColType = strColType+"("+strColLength+")"; 
             }
             HSSFRow hiddenRow = hidden.getRow(i);
             if(hiddenRow == null){
            	 hiddenRow = hidden.createRow(i);
             }
			 cell = row.createCell(i);
			 cell.setCellValue(strTitle);
			 cell = hiddenRow.createCell(0);
			 cell.setCellValue(strColCode);
			 cell = hiddenRow.createCell(1);
			 cell.setCellValue(strColType);
			 
			 //设定tableName列和parentCode列
			 String tableName = null;
			 String parentCode = null;
			 String columnName = null;
			 String columnCode = null;
			 if(strColCode.equals("POSITION_ID")||strColCode.equals("POST_GROUP_ID")||
					 strColCode.equals("POST_ID")||strColCode.equals("POST_GRADE_ID")){
				 tableName = this.trimIDString(strColCode,"HR_", "");
				 columnName = this.trimIDString(strColCode, "", "_NAME");
				 columnCode = this.trimIDString(strColCode, "", "_ID");
				 parentCode = null;
			 }else if(strColCode.equals("DEPTID")){
				 tableName = "HR_DEPARTMENT";
				 columnName = "DEPTNAME";
				 columnCode = "DEPTID";
				 parentCode = null;
			 }else{
				 tableName = "SY_CODE";
				 columnName = "CODE_NAME";
				 columnCode = "CODE_ID";
				 if(strColCode.equals("STATUS_CODE")){  //例外的处理
					 parentCode = "EmpStatus";
			 	 }else if(strColCode.equals("EMP_TYPE_CODE")){
			 		 parentCode = "EmpDivision";
			 	 }else if(strColCode.equals("BORNPLACE_CODE")){  
					 parentCode = "BornPlaceCode";			 		 
			 	 }else if(strColCode.equals("MEMBERSHIP")){  
					 parentCode = "yesOrno";			 		 
			 	 }else if(strColCode.equals("IDCARD_TYPE_CODE")){  
					 parentCode = "RegTypeCode";			 		 
			 	 }else if(strColCode.equals("MAJOR_CODE")){  
					 parentCode = "SubjectCode";			 		 
			 	 }else if(strColCode.equals("SHIFT_CODE")){  
					 parentCode = "WorkShiftCode";			 		 
			 	 }else if(strColCode.equals("SUPPLIER_CODE")){  
					 parentCode = "supplierCode";			 		 
			 	 }else{
				 	parentCode = this.capitalize(strColCode);
			 	 }
			 }
			 
			 //设定字段显示的顺序(ORDERNO)
			 cell = hiddenRow.createCell(6);
			 cell.setCellValue(String.valueOf(i));
			 
			 //查询出数字有效性的选项，设置hidden表的数据
			 Map optionParamMap = new LinkedHashMap();
			 optionParamMap.put("PARENT_CODE", parentCode);
			 optionParamMap.put("TABLE_NAME", tableName);
			 optionParamMap.put("COLUMN_NAME", columnName);
			 options = this.fileDownloadDao.getOptions(optionParamMap);
			 if(options == null){  //说明此字段不是code，标记parent_code和table_name为-1，直接写入表中。
				 cell = hiddenRow.createCell(2);//parentCode
				 cell.setCellValue("-1");
				 cell = hiddenRow.createCell(3);//tableName
				 cell.setCellValue("-1");
				 cell = hiddenRow.createCell(4);//columnCode
				 cell.setCellValue("-1");
				 cell = hiddenRow.createCell(5);//columnName
				 cell.setCellValue("-1");
				 continue;
			 }else{
				 cell = hiddenRow.createCell(2);//parentCode
				 if(parentCode == null) parentCode = "-1";
				 cell.setCellValue(parentCode);
				 cell = hiddenRow.createCell(3);//tableName
				 cell.setCellValue(tableName);
				 cell = hiddenRow.createCell(4);//columnCode
				 cell.setCellValue(columnCode);
				 cell = hiddenRow.createCell(5);//columnName
				 cell.setCellValue(columnName);
			 }
			 
			 // 对于专业科目特殊处理
			 if(parentCode!= null && parentCode.equals("SubjectCode")){
				 sheet.addValidationData(largeOptionValidation(hidden, options, hiddenColumn, sRow,eRow,i,i));
				 hiddenColumn++;
				 continue;
			 }
			 
			 //设置数据有效性 
			 sheet.addValidationData(constraintValidation(options,sRow,eRow,i,i));	
		}

		//将生成的Excel表格输出
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode("人事--个人信息", "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="+fileName+".xls");
		response.setContentType("application/vnd.ms-excel");
		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		outputStream.flush();
	}
	
	public HSSFDataValidation constraintValidation(String[] options, int startRow, int endRow, int startColumn, int endColumn){
		DVConstraint constraint = DVConstraint.createExplicitListConstraint(options);
		CellRangeAddressList regions = new CellRangeAddressList(startRow,endRow,startColumn,endColumn);
		return new HSSFDataValidation( regions, constraint);
	}
	
	/**
	 * 为startRow 至 endRow, startColumn 至 endColumn 中间的区域设置数据有效性限制，
	 * 限制的选项为option, 存储在hidden里的columnNum列.
	 */
	public HSSFDataValidation largeOptionValidation(HSSFSheet hidden, String[] options, int columnNum,
			int startRow, int endRow, int startColumn, int endColumn){
		for(int i=0, length=options.length; i<length; i++){
			HSSFRow row = hidden.getRow(i);
			if(row == null) {
				row = hidden.createRow(i);
			}
			String cellValue = options[i];
			row.createCell(columnNum-1).setCellValue(cellValue);
		}
		// 要加入检验columnNum是不是大于26的，如果是，还要进行改变。
		String columnName = String.valueOf((char)(columnNum+64));
		DVConstraint constraint = DVConstraint.createFormulaListConstraint("hidden!"+columnName+"1:"+columnName+options.length);
		CellRangeAddressList regions = new CellRangeAddressList(startRow,endRow,startColumn,endColumn);
		return new HSSFDataValidation(regions, constraint);  	 
	}
	
	public HSSFDataValidation dateValidation(int startRow, int endRow, int startColumn, int endColumn){
		DVConstraint constraint = DVConstraint.createDateConstraint(DVConstraint.OperatorType.BETWEEN, "1900-01-01", "2900-01-01", "yyyy-mm-dd");
		CellRangeAddressList regions = new CellRangeAddressList(startRow,endRow,startColumn,endColumn);
		return new HSSFDataValidation(regions, constraint);
	}
	
	/**
	 * 将"XXX_YYY"格式字符串转化为"XxxYyy"格式
	 */
	public String capitalize(String str){
		String result = "";
		String[] subStr = str.split("_");
		for(int i=0; i<subStr.length;i++){
			result = result + StringUtils.capitalize(subStr[i].toLowerCase());
		}
		return result;
	}
	
	/**
	 * 将"XXX_CODE"转为"prefix_XXX_suffix"
	 */
	public String trimCodeString(String string, String prefix, String suffix){
		String resultStr = prefix+string.substring(0, string.lastIndexOf("_CODE"))+suffix;
		return resultStr;
	}
	
	/**
	 * 将"XXX_ID"转为"prefix_XXX_suffix"
	 */
	public String trimIDString(String string, String prefix, String suffix){
		String resultStr = prefix+string.substring(0, string.lastIndexOf("_ID"))+suffix;
		return resultStr;
	}
	
	/**
	 * 将list内的元素重新排序
	 * @param list
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void reorderList(List<HashMap> list){
		if(list == null ||list.size() == 0) return;
		if(list.get(0).get("COMMENTS").toString().startsWith("#*")){
			//将EMPID和CHINESENAME属性找出并放到前两位，将所有COMMENTS的#去掉
			HashMap empidMap = null;
			HashMap chineseMap = null;
			for(int i=0; i<list.size(); i++){
				HashMap tmpMap = list.get(i);
				if(tmpMap.get("COLUMN_NAME").toString().equals("EMPID")){
					empidMap = new HashMap(tmpMap);
					list.remove(i);
					i--;
				}else if(tmpMap.get("COLUMN_NAME").toString().equals("CHINESENAME")){
					chineseMap = new HashMap(tmpMap);
					list.remove(i);
					i--;
				}else{
					continue;
				}
			}
			if(empidMap != null){
				list.add(0,empidMap);
			}
			if(chineseMap != null){
				list.add(1,chineseMap);
			}
		}
	}
	
	/**
	 * 将COMMENTS的#符号去掉
	 * @param list
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void trimList(List<HashMap> list){
		if(list == null ||list.size() == 0) return;
		if(list.get(0).get("COMMENTS") == null) return;
		if(list.get(0).get("COMMENTS").toString().startsWith("#")){
			for(int i=0; i<list.size(); i++){
				HashMap tmpMap = list.get(i);
				String comments = tmpMap.get("COMMENTS").toString();
				comments = comments.substring(comments.indexOf("#")+1);
				tmpMap.put("COMMENTS", comments);
				list.remove(i);
				list.add(i, tmpMap);
			}
		}
	}
}
