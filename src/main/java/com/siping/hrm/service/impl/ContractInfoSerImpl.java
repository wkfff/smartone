package com.siping.hrm.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.ObjectUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.NumberUtils;

import com.siping.hrm.dao.ContractInfoDao;
import com.siping.hrm.service.ContractInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.messages.Messages;
import com.siping.web.utility.FileDeleteUtil;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Service
public class ContractInfoSerImpl implements ContractInfoSer {

	Logger logger = Logger.getLogger(ContractInfoSerImpl.class);

	@Autowired
	private ContractInfoDao contractInfoDao;

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public List getContractInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 

		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.contractInfoDao.getContractInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.contractInfoDao.getContractInfoList(paramMap);
		}

		return retrunList;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getContractInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());

		return this.contractInfoDao.getContractInfoCnt(paramMap);
	}
	@Override
	@SuppressWarnings({ "rawtypes"})
	public Map getRequestParamData(HttpServletRequest request) { 
		Map paramMap = ObjectBindUtil.getRequestParamData(request); 

		return paramMap;
	}
   
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getAddContractInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		Map paramMap = ObjectBindUtil.getRequestParamData(request); 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		 
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.contractInfoDao.getAddContractInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.contractInfoDao.getAddContractInfoList(paramMap);
		} 
		return retrunList;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getAddContractInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());

		return this.contractInfoDao.getAddContractInfoCnt(paramMap);
	} 
	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List getExpiredContractInfoList(HttpServletRequest request) {
		List retrunList = new ArrayList();
		Map paramMap = ObjectBindUtil.getRequestParamData(request); 
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());
		paramMap.put("language", Messages.getLanguage(request)); 
		 
		if (paramMap.get("page") != null && paramMap.get("pagesize") != null) {
			retrunList = this.contractInfoDao.getExpiredContractInfoList(paramMap,
					NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("page")),
							Integer.class), NumberUtils.parseNumber(
							ObjectUtils.toString(paramMap.get("pagesize")),
							Integer.class));
		} else {
			retrunList = this.contractInfoDao.getExpiredContractInfoList(paramMap);
		} 
		return retrunList;
	}

	@Override
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int getExpiredContractInfoCnt(HttpServletRequest request) {
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		paramMap.put("HR_ADMIN_ID", admin.getAdminID());

		return this.contractInfoDao.getExpiredContractInfoCnt(paramMap);
	}
	/**
	 * 新签合同
	 */
	@Override 
	public String addContractInfo(HttpServletRequest request){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("CREATED_BY", admin.getAdminID());	
		String jsonString = request.getParameter("jsonData");
		List<LinkedHashMap<String, Object>> insertList = ObjectBindUtil
				.getRequestJsonData(jsonString, appendMap);
		return this.contractInfoDao.addContractInfo(insertList);
	}

	/**
	 * 新签合同
	 */
	@Override 
	public String updateContractInfo(HttpServletRequest request){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);

		LinkedHashMap<String, Object> appendMap = new LinkedHashMap<String, Object>();
		appendMap.put("UPDATED_BY", admin.getAdminID());

		String jsonString = request.getParameter("jsonData");

		List<LinkedHashMap<String, Object>> updateList = ObjectBindUtil
				.getRequestJsonData(jsonString,"update", appendMap);

		return this.contractInfoDao.updateContractInfo(updateList);
	}
	/**
	 * 删除合同
	 */
	@SuppressWarnings("rawtypes")
	@Override 
	public String deleteContractInfoInfo(HttpServletRequest request){
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		return this.contractInfoDao.deleteContractInfoInfo(paramMap);
	}
	
	@Override
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String updateExpiredContract(List<LinkedHashMap<String, Object>> list)
			throws Exception {
		@SuppressWarnings("unused")
		List messageList = new ArrayList();
		List errList = new ArrayList();
		String temp = "";
		if (list != null && list.size() > 0) {
			for (LinkedHashMap<String, Object> map : list) {
				try {
					map.put("CONTRACTPERIOD", Integer.valueOf(map.get(
							"CONTRACTPERIOD").toString()) + 1);
					this.contractInfoDao.saveExpiredContract(map);
				} catch (Exception e) {
					errList.add(map.get("EMPID"));
					e.printStackTrace();
				}
			}
		}
		if (errList.size() > 0) {
			temp = "EMPID为" + errList.toString().toString() + "保存续签合同出错！";
		}
		return temp;
	}
	/**
	 * 由合同模板生成文档后，进行下载
	 * @throws IOException 
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public void downContract(HttpServletRequest request,
			HttpServletResponse response)throws IOException {
		response.reset();
		String Contract_type_code = request.getParameter("CONTRACT_TYPE_CODE");
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		Map map = this.contractInfoDao.getContractInfo(paramMap);
		//String jsonString = request.getParameter("jsonData");
		//List<LinkedHashMap<String, Object>> list = ObjectBindUtil.getRequestJsonData(jsonString);
		String projectPath = request.getSession().getServletContext().getRealPath("/");
		String templatePath = null;//获取合同模板的路径
		String tempContractPath = null;//设置替换后的临时文件夹的路径
		String tempContractFolder = projectPath + "resources/temp/tempContract";//设置临时文件夹
		String fileName = null;//设置输出后文件的名字
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");
		String dateString = formatter.format(new Date());
		
		if ("ContractType100".equals(Contract_type_code)) {
			templatePath = projectPath + "resources/template/Contract/LabourContractTemplate.doc";
			tempContractPath = projectPath + "resources/temp/tempContract/LabourContract.doc";
			fileName = "劳动合同_"+map.get("EMPNAME").toString()+dateString+".doc";
		} else if ("ContractType110".equals(Contract_type_code)) {
			templatePath = projectPath + "resources/template/Contract/SecrecyAgreementTemplate.doc";
			tempContractPath = projectPath + "resources/temp/tempContract/SecrecyAgreement.doc";
			fileName = "保密协议_"+map.get("EMPNAME").toString()+dateString+".doc";
		} else if ("ContractType120".equals(Contract_type_code)) {
			templatePath = projectPath + "resources/template/Contract/TheCompetitionAgreementTemplate.doc";
			tempContractPath = projectPath  + "resources/temp/tempContract/TheCompetitionAgreement.doc";
			fileName = "竞业限制合同_"+map.get("EMPNAME").toString()+dateString+".doc";
		} else if ("ContractType130".equals(Contract_type_code)){
			templatePath = projectPath + "resources/template/Contract/ElectricianTrainingContractTemplate.doc";
			tempContractPath= projectPath  + "resources/temp/tempContract/ElectricianTrainingContract.doc";
			fileName = "电工培训合同_"+map.get("EMPNAME").toString()+dateString+".doc";
		}
		File file = null;
		fileName = java.net.URLEncoder.encode(fileName, "utf-8");
		
		this.contractInfoDao.generateWord(map, templatePath, tempContractPath);
		file = new File(tempContractPath);
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "inline; fileName="+fileName);
		
		InputStream inputStream = null;
		try{
			inputStream = new FileInputStream(file);
		}catch(IOException e){
			file = new File(templatePath);
			inputStream = new FileInputStream(file);
		}finally{
			OutputStream outputStream = response.getOutputStream();
			byte[] b = new byte[1024];
			int length;
			while((length = inputStream.read(b))>0){
				outputStream.write(b, 0, length);
			}
			inputStream.close();
			outputStream.close();
			FileDeleteUtil.deleteAllFile(tempContractFolder);//删除临时文件夹下的所有文件
		}
	}
}
