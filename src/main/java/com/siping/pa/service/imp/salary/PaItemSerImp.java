package com.siping.pa.service.imp.salary;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List; 

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.pa.dao.salary.PaItemDao;
import com.siping.pa.service.salary.PaItemSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaItemSerImp implements PaItemSer {

	Logger logger = Logger.getLogger(PaItemSerImp.class);

	@Autowired
	private PaItemDao paItemDao;

	@SuppressWarnings("rawtypes")
	public Object getPaItemObjectInfo(HttpServletRequest request) {
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		
		return paItemDao.getPaItemObjectInfo(paramMap);
	}

	@SuppressWarnings({ "rawtypes" })
	public List getPaItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		LinkedHashMap paramMap = this.setGetPaItemParam(request);
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = paItemDao.getPaItemInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = paItemDao.getPaItemInfo(paramMap);
		}
		return retrunList;
	}

	@SuppressWarnings("rawtypes")
	public int getPaItemInfoCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaItemParam(request);
		
		return paItemDao.getPaItemInfoCnt(paramMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaItemParam(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		return paramMap;
	} 
	@Override 
	public String addPaItemInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
		
		return this.paItemDao.addPaItemInfo(insertList);
	}

	@Override 
	public String updatePaItemInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString, "update", appendMap); 

		return this.paItemDao.updatePaItemInfo(updateList);
	}

	@Override
	@SuppressWarnings("unchecked")
	public String deletePaItemInfo(HttpServletRequest request) {
		String returnString = "Y";
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("UPDATED_BY", admin.getAdminID()); 
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		int errorInt = this.paItemDao.checkDeletePaItemInfo(paramMap);
		if (errorInt == 0) {
			returnString = this.paItemDao.deletePaItemInfo(paramMap);
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		
		return returnString;
	}

	@Override
	public String updatePaItemInfoCalOrder(HttpServletRequest request) {
		String jsonString = request.getParameter("jsonData");
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID()); 
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		List<LinkedHashMap<String, Object>> itemList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.paItemDao.updatePaItemInfoCalOrder(itemList);
	}

	@Override
	public void downloadPaDataTemplate(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getSession().getServletContext().getRealPath("/resources/template/paItemDataTemplate.xls");
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
			fileName = java.net.URLEncoder.encode("工资输入项", "UTF-8");
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
