package com.siping.att.service.impl;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import org.springframework.web.multipart.MultipartFile;
import com.siping.att.dao.AttCardRecordDao;
import com.siping.att.service.AttCardRecordSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class AttCardRecordSerImp implements AttCardRecordSer{
	Logger logger = Logger.getLogger(AttCardRecordSerImp.class);

	@Autowired
	private AttCardRecordDao attCardRecordDao;
	@SuppressWarnings({ "rawtypes", "unchecked", "unused" })
	public List getAttCardRecordInfo(HttpServletRequest request){
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		//paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request));
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null){
			retrunList = attCardRecordDao.getAttCardRecordInfo(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = attCardRecordDao.getAttCardRecordInfo(paramMap);
		}
		return retrunList;
	}
	@SuppressWarnings({ "rawtypes" })
	public int getAttCardRecordInfoCnt(HttpServletRequest request){
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return attCardRecordDao.getAttCardRecordInfoCnt(paramMap);
	};
	public String updateAttCardRecordInfo(HttpServletRequest request) {
		String result = "";
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> arAttCardRecordInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		this.attCardRecordDao.updateAttCardRecordInfo(arAttCardRecordInfoList);
		result = "Y";
		return result;
	}
	public String deleteAttCardRecordInfo(HttpServletRequest request){
		String result = "";
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> arAttCardRecordInfoList = ObjectBindUtil
				.getRequestJsonData(jsonString);
		this.attCardRecordDao.deleteAttCardRecordInfo(arAttCardRecordInfoList);
		result = "Y";
		return result;
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String addAttCardRecordInfo(HttpServletRequest request){
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		String supervisorId = admin.getAdminID();
		paramMap.put("OPERATOR_ID", supervisorId);
		this.attCardRecordDao.addAttCardRecordInfo(paramMap);
		return "Y";
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public String uploadMacRecodsByExcel(MultipartFile file,
			HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ParseException{
		//解析 Excel
		HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
		HSSFSheet sheet = workbook.getSheetAt(0);
		HSSFRow row = null;
		int rows = sheet.getLastRowNum();

		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		List paramList = new ArrayList();
		for(int i = 0;i<rows;i++){
			row = sheet.getRow(i);
			if (row != null) {
				this.getRowInfo(row,admin.getAdminID(),paramList);
			}
		}
		//将Excel里的内容添加进考勤记录表AR_MAC_RECORDS中
		this.attCardRecordDao.addAtrecordInfoList(paramList);
		return "Y";
	}
	/**
	 * 从Excel中取出具体的个人信息
	 * @throws ParseException 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String getRowInfo(HSSFRow row,String createdBy,List paramList) throws ParseException {
		int columns = row.getLastCellNum();
		//小于5则没有打卡时间，此行数据略过
		if(columns<5)
			return null;
		HSSFCell cellEmpid = row.getCell(0);				//第一列为员工ID，已固定
		HSSFCell cellArdate = row.getCell(3);				//第四俩为打卡日期，已固定
		int timesLength = columns-4;
		HSSFCell[] cells = new HSSFCell[timesLength];		//设为用于存储打卡所有时间长度减4。
		String empid = "";
		String ar_date_str = "";
		//判断empid是否为空
		if (cellEmpid == null){
			return null;
		}
		empid = parseDateNumberToString(cellEmpid); // empId
		if ("".equals(empid)){
			return null;
		}
		//判断考勤日期是否为空,格式是否正确
		if(cellArdate == null)
			return null;
		ar_date_str = parseDateNumberToString(cellArdate);
		if ("".equals(ar_date_str))
			return null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");				//用于判断日期格式是否正确，错误则跳过此行
		try {
			sdf.parse(ar_date_str);
		} catch (Exception e) {
			//如果抛异常，则格式错误，此行跳过
			return null;
		}
		
		for(int i=0;i<timesLength;i++){
			cells[i]=row.getCell(i+4);
		}
		//循环所有打卡时间
		SimpleDateFormat sdfTime = new SimpleDateFormat("HH:MM:SS");
		String temp = "";
		Map map = null;
		for(int i=0;i<timesLength;i++){
			map = new LinkedHashMap();
			if(cells[i]!=null){
				temp = parseDateNumberToString(cells[i]);							//临时变量
				if (!"".equals(temp)) {
					try {
						sdfTime.parse(temp);
					} catch (Exception e) {
						//如格式有误，则抛出异常，此次循环跳过
						continue;
					}
					map.put("EMPID", empid);
					map.put("ATT_DATE", ar_date_str);
					map.put("R_TIME", ar_date_str + " " + temp);
					map.put("CREATED_BY", createdBy);
					map.put("IN_FLAG", "M");
					paramList.add(map);
				}
			}
		}
		return "Y";
	}
	/**
	 * 对从Excel中取出的数据进行转码成String
	 * @throws ParseException 
	 */
	public String parseDateNumberToString(HSSFCell cell) throws ParseException{
		String value = "";
		switch (cell.getCellType()) {
			case Cell.CELL_TYPE_FORMULA:
				value = cell.getCellFormula()+"";
				break;
			case Cell.CELL_TYPE_NUMERIC:
				//如果是时间格式，那么getNumericCellValue为小数，需转
				double partDay = cell.getNumericCellValue();
				if(partDay<1){
					int hour = (int) (partDay*24);
					int minute = (int) ((partDay*24*60)%60);
					int second = (int) ((partDay*24*60*60)%60);
					value = hour+":"+minute+":"+second;
				}else{
					value = String.valueOf(partDay);
				}
				break;
			case Cell.CELL_TYPE_STRING:
				value = ""+cell.getStringCellValue();
				break;
			case Cell.CELL_TYPE_BOOLEAN:
				value = ""+cell.getBooleanCellValue();
			break;
			default:
		}
		return value.trim();
	}

	@Override
	public void downloadAttRecordsTemplate(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getSession().getServletContext().getRealPath("/resources/excel/Ar_Mac_Records.xls");
		HSSFWorkbook workbook = null;
		try{
			InputStream input = new FileInputStream(path);
			workbook = new HSSFWorkbook(input);
		}catch(Exception e){
			e.printStackTrace();
			return ;
		}
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode("考勤--打卡信息", "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="+fileName+".xls");
		response.setContentType("application/vnd.ms-excel");
		try{
			ServletOutputStream outputStream = response.getOutputStream();
			workbook.write(outputStream);
			outputStream.flush();
		}catch(Exception e){
			e.printStackTrace();
			return;
		}
	}
}
