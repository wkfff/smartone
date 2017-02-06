package com.siping.report.ord.service.impl;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.siping.report.ord.dao.OrderInfoReportDao;
import com.siping.report.ord.service.OrderInfoReportSer;
import com.siping.report.util.FillComputerManager;
import com.siping.report.util.Layouter;
import com.siping.report.util.Writer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;
import com.siping.web.utility.StringUtil;

@Service
public class OrderInfoReportSerImpl implements OrderInfoReportSer {

	@Autowired
	private OrderInfoReportDao orderInfoReportDao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public void exportOrderList(HttpServletRequest request,
			HttpServletResponse response) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		// 附加信息
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		// 页面提交的JSON信息
		String jsonCodeString = orderInfoReportDao.getOrderReportColumnInfo(paramMap); 
		List<String> codeList = new ArrayList<String>();
		if (jsonCodeString != null) {
			codeList = StringUtil.hashToList(StringUtil.stringToHash(jsonCodeString));
		}
		paramMap.put("codeList", codeList);
		List<String> titleList = this.orderInfoReportDao.getOrderReportTitleInfo(paramMap);

		// 1.创建一个 workbook
		HSSFWorkbook workbook = new HSSFWorkbook();

		// 2.创建一个 worksheet
		HSSFSheet worksheet = workbook.createSheet("订单信息");

		// 3.定义起始行和列
		int startRowIndex = 0;
		int startColIndex = titleList.size();

		// 4.创建title,data,headers 
		Layouter.buildOrderInfoReport(worksheet, startRowIndex, startColIndex, titleList);

		// 5.填充数据
		FillComputerManager.fillReport(worksheet, startRowIndex, startColIndex,getDatasource(codeList, paramMap), codeList);

		// 6.设置reponse参数
		// 进行转码，使其支持中文文件名
		String fileName = null;
		try {
			fileName = java.net.URLEncoder.encode("订单列表信息", "UTF-8");
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
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getOrderReportTitleInfo(HttpServletRequest request) {
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
		List<String> titleList = this.orderInfoReportDao.getOrderReportTitleInfo(paramMap);
		return titleList;
	}

	/**
	 * 从数据库获得所有的报表信息.
	 */
	@SuppressWarnings({ "rawtypes" })
	private List<LinkedHashMap> getDatasource(List<String> codeList, Object obj) {
		return this.orderInfoReportDao.getDataInfo(codeList, obj);
	}

}
