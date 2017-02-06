package com.siping.hrm.action;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.siping.hrm.service.ContractInfoSer;
import com.siping.web.utility.JsonUtil;

@Controller
@RequestMapping(value = "/hrm/contractInfo")
public class ContractInfoCtroller {

	Logger logger = Logger.getLogger(ContractInfoCtroller.class);

	@Autowired
	private ContractInfoSer contractInfoSer;

	@RequestMapping(value = "/viewContractInfo", method = RequestMethod.GET)
	public ModelAndView viewContractInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/hrm/contractInfo/viewContractInfo", modelMap);
	}
	@RequestMapping(value = "/viewEmpContractInfo", method = RequestMethod.GET)
	public ModelAndView viewEmpContractInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("paraMap", this.contractInfoSer.getRequestParamData(request)) ; 
		return new ModelAndView("/hrm/contractInfo/viewEmpContractInfo", modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getContractInfoList", method = RequestMethod.POST)
	@ResponseBody
	public Map getContractInfoList(HttpServletRequest request) throws Exception {

		List contractInfoList = this.contractInfoSer
				.getContractInfoList(request);
		int contractCnt = this.contractInfoSer.getContractInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", contractInfoList);
		model.put("Total", contractCnt);

		return model;
	}

	/**
	 * 签订合同
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addContractInfo", method = RequestMethod.GET)
	public ModelAndView addContractInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/hrm/contractInfo/addContractInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getAddContractInfoList", method = RequestMethod.POST)
	@ResponseBody
	public Map getAddContractInfoList(HttpServletRequest request)
			throws Exception {

		List contractInfoList = this.contractInfoSer
				.getAddContractInfoList(request);
		int contractCnt = this.contractInfoSer.getAddContractInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", contractInfoList);
		model.put("Total", contractCnt);
		return model;
	} 
	/**
	 * 新签合同
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/addContractInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addContractInfo(HttpServletRequest request) throws Exception {
		 
		String returnString = this.contractInfoSer.addContractInfo(request);
		return returnString;
	}
	/**
	 * 新签合同
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateContractInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateContractInfo(HttpServletRequest request) throws Exception {
		 
		String returnString = this.contractInfoSer.updateContractInfo(request);
		return returnString;
	}
	/**
	 * 删除合同
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteContractInfoInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteContractInfoInfo(HttpServletRequest request) throws Exception {
		 
		String returnString = this.contractInfoSer.deleteContractInfoInfo(request);
		return returnString;
	}
	/**
	 * 依据合同模板生成新的文档并下载
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value="/downloadContract",method = RequestMethod.GET)
	public void downloadContract(HttpServletRequest request, HttpServletResponse response) throws IOException {
		this.contractInfoSer.downContract(request, response);
	} 

	/**
	 * 续签合同
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewExpiredContractInfo", method = RequestMethod.GET)
	public ModelAndView viewExpiredContractInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		return new ModelAndView("/hrm/contractInfo/viewExpiredContractInfo",
				modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getExpiredContractInfoList", method = RequestMethod.POST)
	@ResponseBody
	public Map getExpiredContractInfoList(HttpServletRequest request)
			throws Exception {
		List contractInfoList = this.contractInfoSer
				.getExpiredContractInfoList(request);
		int contractCnt = this.contractInfoSer.getExpiredContractInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", contractInfoList);
		model.put("Total", contractCnt);
		return model; 
	}

	/**
	 * 续签合同
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateExpiredContract", method = RequestMethod.POST)
	@ResponseBody
	public String updateExpiredContract(HttpServletRequest request)
			throws Exception {
		logger.info("updateContractByInsertList.start......");
		String temp = this.contractInfoSer.updateExpiredContract(JsonUtil
				.getUpdateList(request));
		return temp;
	}

}
