package com.siping.ess.action;
  
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
  
import com.siping.eva.service.EmpEvaInfoSer;
import com.siping.hrm.service.EmpInfoSer;

@Controller
@RequestMapping(value = "/ess/infoView")
public class InfoViewCtroller {

	Logger logger = Logger.getLogger(InfoViewCtroller.class);

	@Autowired
	private EmpInfoSer empInfoSer;
	@Autowired
	private EmpEvaInfoSer empEvaInfoSer;
	  
	/**
	 * 页面跳转 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEssEmpOngoingInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpOngoingInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		  
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));  
		return new ModelAndView("/ess/infoView/viewEssEmpOngoingInfo",modelMap);
	} 
	@RequestMapping(value = "/viewEssEmpOngoingDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpOngoingDetailInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("paraMap", this.empInfoSer.getRequestParamData(request));
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));  
		return new ModelAndView("/ess/infoView/viewEssEmpOngoingDetailInfo",modelMap);
	} 
	@RequestMapping(value = "/updateEssEmpOngoingItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateEssEmpOngoingItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.updateEssEmpOngoingItemInfo(request);

	}
	@RequestMapping(value = "/updateEssEmpOngoingWorkInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateEssEmpOngoingWorkInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.updateEssEmpOngoingWorkInfo(request);

	}
}
