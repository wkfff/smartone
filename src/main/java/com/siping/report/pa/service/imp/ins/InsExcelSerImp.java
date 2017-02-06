package com.siping.report.pa.service.imp.ins;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.siping.report.pa.dao.ins.InsResultReportDao;
import com.siping.report.pa.service.ins.InsExcelSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class InsExcelSerImp implements InsExcelSer {

	Logger logger = Logger.getLogger(InsExcelSerImp.class);

	@Autowired
	private InsResultReportDao insResultReportDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public void viewInsResultReport(HttpServletRequest request,
			HttpServletResponse response) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		// 页面提交的JSON信息
		String jsonCodeString = request.getParameter("jsonData_code");
		List<String> codeList = new ArrayList<String>();
		if (jsonCodeString != null) {
			codeList = StringUtil.hashToList(StringUtil
					.stringToHash(jsonCodeString));
		}
		paramMap.put("codeList", codeList);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		List<String> titleList = this.insResultReportDao
				.getInsTitleInfo(paramMap);

		// 1.创建一个 workbook
		HSSFWorkbook workbook = new HSSFWorkbook();

		// 2.创建一个 worksheet
		HSSFSheet worksheet = workbook.createSheet(paramMap.get("PA_MONTH").toString());

		// 3.定义起始行和列
		int startRowIndex = 0;
		int startColIndex = titleList.size();

		// 4.创建title,data,headers
		Layouter.buildInsReport(worksheet, startRowIndex, startColIndex, titleList);

		// 5.填充数据
		FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,
				getDatasource(codeList, paramMap), codeList);

		// 6.设置reponse参数
		// 进行转码，使其支持中文文件名
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode(paramMap.get("PA_MONTH").toString()+"月保险数据信息", "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		response.setHeader("Content-Disposition", "inline; filename="
				+ fileName + ".xls");
		// 确保发送的当前文本格式
		response.setContentType("application/vnd.ms-excel");

		// 7. 输出流
		Writer.write(response, worksheet);

	}
	
	/**
	 * 读取报表
	 */
	@SuppressWarnings("rawtypes")
	public List<Map> readReport(InputStream inp) {

		List<Map> computerList = new ArrayList<Map>();

		try {
			String cellStr = null;

			Workbook wb = WorkbookFactory.create(inp);

			Sheet sheet = wb.getSheetAt(0);// 取得第一个sheets

			// 从第四行开始读取数据
			for (int i = 1; i <= sheet.getLastRowNum(); i++) {

				Map computer = new LinkedHashMap<Object, Object>();
				Map addComputer = new LinkedHashMap();

				Row row = sheet.getRow(i); // 获取行(row)对象
				System.out.println(row);
				if (row == null) {
					// row为空的话,不处理
					continue;
				}

				for (int j = 0; j < row.getLastCellNum(); j++) {

					Cell cell = row.getCell(j); // 获得单元格(cell)对象

					// 转换接收的单元格
					cellStr = ConvertCellStr(cell, cellStr);

					// 将单元格的数据添加至一个对象
					addComputer = addingComputer(j, computer, cellStr);

				}
				// 将添加数据后的对象填充至list中
				computerList.add(addComputer);
			}

		} catch (InvalidFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (inp != null) {
				try {
					inp.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			} else {

			}
		}
		return computerList;

	}

	/**
	 * 从数据库获得所有的Computer信息.
	 */
	@SuppressWarnings({ "rawtypes" })
	private List<LinkedHashMap> getDatasource(List<String> codeList, Object obj) {
		return insResultReportDao.getDatasource(codeList, obj);
	}

	/**
	 * 读取报表的数据后批量插入
	 */
	@SuppressWarnings("rawtypes")
	public int insertComputer(List<Map> list) {
		return insResultReportDao.insertComputer(list);

	}

	/**
	 * 获得单元格的数据添加至computer
	 * 
	 * @param j
	 *            列数
	 * @param computer
	 *            添加对象
	 * @param cellStr
	 *            单元格数据
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private Map addingComputer(int j, Map computer, String cellStr) {
		switch (j) {
		case 0:
			// computer.setId(0);
			break;
		case 1:
			computer.put("BRAND", cellStr);
			break;
		case 2:
			computer.put("CPU", cellStr);
			break;
		case 3:
			computer.put("GPU", cellStr);
			break;
		case 4:
			computer.put("MEMORY", cellStr);
			break;
		case 5:
			computer.put("PRICE", cellStr);
			break;
		}

		return computer;
	}

	/**
	 * 把单元格内的类型转换至String类型
	 */
	private String ConvertCellStr(Cell cell, String cellStr) {

		switch (cell.getCellType()) {

		case Cell.CELL_TYPE_STRING:
			// 读取String
			cellStr = cell.getStringCellValue().toString();
			break;

		case Cell.CELL_TYPE_BOOLEAN:
			// 得到Boolean对象的方法
			cellStr = String.valueOf(cell.getBooleanCellValue());
			break;

		case Cell.CELL_TYPE_NUMERIC:

			// 先看是否是日期格式
			if (DateUtil.isCellDateFormatted(cell)) {

				// 读取日期格式
				cellStr = cell.getDateCellValue().toString();

			} else {

				// 读取数字
				cellStr = String.valueOf(cell.getNumericCellValue());
			}
			break;

		case Cell.CELL_TYPE_FORMULA:
			// 读取公式
			cellStr = cell.getCellFormula().toString();
			break;
		}
		return cellStr;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<String> getInsTitleInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		// 页面提交的JSON信息
		String jsonCodeString = request.getParameter("jsonData_code");
		List<String> codeList = new ArrayList<String>();
		if (jsonCodeString != null) {
			codeList = StringUtil.hashToList(StringUtil
					.stringToHash(jsonCodeString));
		}
		paramMap.put("codeList", codeList);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request)); 
		List<String> titleList = this.insResultReportDao
				.getInsTitleInfo(paramMap);
		return titleList;
	}
	/**
	 * 获取信息
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public Map getRequestParamData(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		return paramMap;
	}
}
