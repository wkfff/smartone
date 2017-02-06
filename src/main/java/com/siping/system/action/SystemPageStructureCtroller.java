package com.siping.system.action;

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

import com.siping.system.service.SystemPageStructureSer;

@Controller
@RequestMapping(value = "/system/systemSettings")
public class SystemPageStructureCtroller {
	Logger logger = Logger.getLogger(SystemPageStructureCtroller.class);
	@Autowired
	private SystemPageStructureSer systemPageStructureSer;

	@RequestMapping(value = "/viewSystemPageStructure", method = RequestMethod.GET)
	public ModelAndView viewSystemPageStructure(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView(
				"/system/systemSettings/viewSystemPageStructure", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPageStructure", method = RequestMethod.POST)
	@ResponseBody
	public Map getPageStructure(HttpServletRequest request) {

		List infoList = this.systemPageStructureSer.getPageStructure(request);

		Map model = new HashMap();
		model.put("Rows", infoList);

		return model;
	}
  
	@RequestMapping(value = "/addPageStructureDetailInfo", method = RequestMethod.GET)
	public ModelAndView addPageStructureDetailInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("paraMap",
				this.systemPageStructureSer.getRequestParamData(request));
		return new ModelAndView(
				"/system/systemSettings/addPageStructureDetailInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPageStructureDetailItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPageStructureDetailItemInfo(HttpServletRequest request)
			throws Exception {

		List infoList = this.systemPageStructureSer
				.getPageStructureDetailItemInfo(request);
		int infoCnt = this.systemPageStructureSer
				.getPageStructureDetailItemInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/addPageStructureDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addPageStructureDetailInfo(HttpServletRequest request) {

		this.systemPageStructureSer.addPageStructureDetailInfo(request);

		return "Y";
	}
  
	/**
	 * 获取详细数据
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPageStructureDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPageStructureDetailInfo(HttpServletRequest request)
			throws Exception {

		List infoList = this.systemPageStructureSer
				.getPageStructureDetailInfo(request);
		int infoCnt = this.systemPageStructureSer
				.getPageStructureDetailInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/deletePageStructureDetailInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePageStructureDetailInfo(HttpServletRequest request) {

		this.systemPageStructureSer.deletePageStructureDetailInfo(request);

		return "Y";
	} 

	@RequestMapping(value = "/updatePageStructureDetailInfoOrder", method = RequestMethod.POST)
	@ResponseBody
	public String updatePageStructureDetailInfoOrder(HttpServletRequest request)
			throws Exception {

		String returnString = "Y";

		this.systemPageStructureSer.updatePageStructureDetailInfoOrder(request);

		return returnString;
	}
}
