package com.siping.pa.service.imp.salary;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List; 
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;
import org.springframework.web.multipart.MultipartFile;

import com.siping.pa.dao.salary.PaInputItemDao;
import com.siping.pa.service.salary.PaInputItemSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class PaInputItemSerImp implements PaInputItemSer {

	Logger logger = Logger.getLogger(PaInputItemSerImp.class);

	@Autowired
	private PaInputItemDao paInputItemDao;

	@Override 
	@SuppressWarnings("rawtypes")
	public Object getPaInputItemObjectInfo(HttpServletRequest request) {
		Object returnObj = new Object();
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		returnObj = paInputItemDao.getPaInputItemObjectInfo(paramMap);
		return returnObj;
	}

	@Override 
	@SuppressWarnings("rawtypes")
	public List getPaInputItemInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		// 页面提交数据
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = paInputItemDao.getPaInputItemInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = paInputItemDao.getPaInputItemInfo(paramMap);
		}
		return retrunList;
	}

	@Override 
	@SuppressWarnings("rawtypes")
	public int getPaInputItemInfoCnt(HttpServletRequest request) {
		LinkedHashMap paramMap = this.setGetPaInputItemParam(request);

		return paInputItemDao.getPaInputItemInfoCnt(paramMap);
	}
  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private LinkedHashMap setGetPaInputItemParam(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));
		
		return paramMap;
	} 

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataEmpInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paInputItemDao.getPaInputItemDataEmpInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paInputItemDao.getPaInputItemDataEmpInfo(paramMap);
		}

		return retrunList;
	}

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaInputItemDataEmpInfoCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunInt = this.paInputItemDao.getPaInputItemDataEmpInfoCnt(paramMap);
		return retrunInt;
	}

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataOtherInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paInputItemDao.getPaInputItemDataOtherInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paInputItemDao.getPaInputItemDataOtherInfo(paramMap);
		}

		return retrunList;
	}

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaInputItemDataOtherInfoCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunInt = this.paInputItemDao.getPaInputItemDataOtherInfoCnt(paramMap);
		return retrunInt;
	}
	
	@Override 
	public void addPaInputItemInfo(HttpServletRequest request) throws SQLException {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());

		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString, "add", appendMap);
		this.paInputItemDao.addPaInputItemInfo(insertList);
	}

	@Override 
	public void updatePaInputItemInfo(HttpServletRequest request) throws SQLException {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil.getRequestJsonData(jsonString, "update", appendMap);

		this.paInputItemDao.updatePaInputItemInfo(updateList);
	}

	@Override 
	@SuppressWarnings("unchecked")
	public int checkDeletePaInputItemInfo(HttpServletRequest request) {
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);

		return this.paInputItemDao.checkDeletePaInputItemInfo(paramMap);
	}

	@Override 
	@SuppressWarnings("unchecked")
	public String deletePaInputItemInfo(HttpServletRequest request) {
		String resultString = "Y";
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		try {
			resultString = this.paInputItemDao.deletePaInputItemInfo(paramMap);
		} catch (Exception e) {
			e.printStackTrace();
			resultString = e.getMessage();
		}

		return resultString;
	}

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getPaInputItemDataInfo(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());
		paramMap.put("language", Messages.getLanguage(request));

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.paInputItemDao.getPaInputItemDataInfo(paramMap,
				NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("page")),
					Integer.class), NumberUtils.parseNumber(
					ObjectUtils.toString(paramMap.get("pagesize")),
					Integer.class));
		} else {
			retrunList = this.paInputItemDao.getPaInputItemDataInfo(paramMap);
		}

		return retrunList;
	}
	

	@Override 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getPaInputItemDataInfoCnt(HttpServletRequest request) {
		int retrunInt = 0;
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("AR_ADMIN_ID", admin.getAdminID());
		paramMap.put("CPNY_ID", admin.getCpnyId());

		retrunInt = this.paInputItemDao.getPaInputItemDataInfoCnt(paramMap);
		return retrunInt;
	}
	@Override 
	public String deletePaInputItemDataInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>(); 
		appendMap.put("UD_BY", admin.getAdminID()); 
		appendMap.put("FLAG", "0"); //修改标记
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> delList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.paInputItemDao.deletePaInputItemDataInfo(delList);
	}

	@Override 
	@SuppressWarnings("unchecked")
	public String createPaInputItemInfo(HttpServletRequest request) {
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CREATED_BY", admin.getAdminID()); 
		paramMap.put("CPNY_ID", admin.getCpnyId()); 
		
		return this.paInputItemDao.createPaInputItemInfo(paramMap);
	}

	@Override 
	@SuppressWarnings("unchecked")
	public String createPaInputItemDataInfo(HttpServletRequest request) {
		LinkedHashMap<String, Object> paramMap = ObjectBindUtil.getRequestParamData(request);
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("CREATED_BY", admin.getAdminID()); 
		paramMap.put("CPNY_ID", admin.getCpnyId());
		
		return this.paInputItemDao.createPaInputItemDataInfo(paramMap);
	}

	@Override 
	public String addPaInputItemDataInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID()); 
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil.getRequestJsonData(jsonString,appendMap);

		return this.paInputItemDao.addPaInputItemDataInfo(insertList);
	}
	@Override 
	public String updatePaInputItemDataInfo(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UD_BY", admin.getAdminID());  
		appendMap.put("FLAG", "1"); //修改标记
		
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,appendMap);

		return this.paInputItemDao.updatePaInputItemDataInfo(updateList);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public String uploadPaParamExcel(MultipartFile file,HttpServletRequest request, HttpServletResponse response)
			throws IOException, SQLException, ParseException{
		List paramList = new ArrayList();
		//解析 Excel
		HSSFWorkbook workbook = new HSSFWorkbook(file.getInputStream());
		HSSFSheet sheet = workbook.getSheetAt(0);
		HSSFRow row = null;
		Map map = new LinkedHashMap();
		int rowsnum = sheet.getPhysicalNumberOfRows();
 		for(int i=2;i<rowsnum;i++){
			row = sheet.getRow(i);
			if (row != null) {
				map = this.getRowInfo(row);
			}
			if (map == null)
				continue;
			paramList.add(map);
		}
		
		//将Excel里的内容添加进考勤记录表AR_RECORDS中
 		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID()); 
		appendMap.put("CPNY_ID", admin.getCpnyId());
		
		ObjectBindUtil.getRequestListData(paramList, appendMap);
		ObjectBindUtil.getRequestListData(paramList, ObjectBindUtil.getRequestParamData(request));
		
		return this.paInputItemDao.addPaInputItemDataInfo(paramList);
	}
	
	/**
	 * 从Excel中取出具体的个人信息
	 * @throws ParseException 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map getRowInfo(HSSFRow row) throws ParseException {
		int columns = row.getPhysicalNumberOfCells();
		if(columns<3)
			return null;
		HSSFCell cellEmpid = row.getCell(0);
		HSSFCell cellParamValue = row.getCell(2);
		HSSFCell cellRemarkValue = row.getCell(3);
		String empid = "";
		String paramdata = "";
		String remark = "";
		
		//判断empid是否为空
		if (cellEmpid == null){
			return null;
		}
		empid = cellEmpid.toString().trim();
		if ("".equals(empid)){
			return null;
		}
		//判断paramvalue是否为空
		if (cellParamValue == null){
			return null;
		}
		paramdata = cellParamValue.toString().trim();
		if ("".equals(paramdata)){
			return null;
		}
		//判断remark是否为空
		if (cellRemarkValue != null){
			remark = cellRemarkValue.toString().trim();
		}

		Map map = new LinkedHashMap();
		map.put("FIELD1_VALUE", empid);
		map.put("RETURN_VALUE", paramdata);
		map.put("REMARK", remark);
		return map;
	}
}
