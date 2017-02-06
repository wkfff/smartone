package com.siping.eva.action;

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
import com.siping.eva.service.EmpEvaInfoSer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.system.bean.AdminBean;
import com.siping.web.utility.ObjectBindUtil;
import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/eva/empEvaInfo")
public class EmpEvaInfoCtroller {

	Logger logger = Logger.getLogger(EmpEvaInfoCtroller.class);

	@Autowired
	private EmpEvaInfoSer empEvaInfoSer;
	@Autowired
	private EmpInfoSer empInfoSer; 
 
	/**
	 * 转正评价
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaEmpSettingInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpSettingInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.empEvaInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/empEvaInfo/viewEvaEmpSettingInfo", modelMap);
	}
	@RequestMapping(value = "/viewEvaEmpSettingDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpNormalDetailInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.empEvaInfoSer.getRequestParamData(request));
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		return new ModelAndView("/eva/empEvaInfo/viewEvaEmpSettingDetailInfo", modelMap);
	}
	@RequestMapping(value = "/viewEvaEmpOngoingInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpOngoingInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.empEvaInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/empEvaInfo/viewEvaEmpOngoingInfo", modelMap);
	}
	@RequestMapping(value = "/viewEvaEmpOngoingDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpOngoingDetailInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception { 
		modelMap.put("paraMap", this.empEvaInfoSer.getRequestParamData(request));
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request)); 
		return new ModelAndView("/eva/empEvaInfo/viewEvaEmpOngoingDetailInfo", modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaEmpWorkInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaEmpWorkInfo(HttpServletRequest request) throws Exception {

		List infoList = this.empEvaInfoSer.getEvaEmpWorkInfo(request);
		int infoCnt = this.empEvaInfoSer.getEvaEmpWorkInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaEmpEveInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaEmpEveInfo(HttpServletRequest request) throws Exception {

		List infoList = this.empEvaInfoSer.getEvaEmpEveInfo(request); 

		Map model = new HashMap();
		model.put("Rows", infoList); 

		return model;
	}
	@RequestMapping(value = "/saveAndUpdateEvaEmpWorkInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaEmpWorkInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.saveAndUpdateEvaEmpWorkInfo(request);

	}

	@RequestMapping(value = "/updateEvaEmpOngoingWorkInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateEvaEmpOngoingWorkInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.updateEvaEmpOngoingWorkInfo(request);

	}

	@RequestMapping(value = "/updateEvaEmpOngoingItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateEvaEmpOngoingItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.updateEvaEmpOngoingItemInfo(request);

	}
	
	@RequestMapping(value = "/deleteEvaEmpWorkInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaEmpWorkInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.empEvaInfoSer.deleteEvaEmpWorkInfo(request);
		return "Y";

	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaEmpItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaEmpItemInfo(HttpServletRequest request) throws Exception {

		List infoList = this.empEvaInfoSer.getEvaEmpItemInfo(request);
		int infoCnt = this.empEvaInfoSer.getEvaEmpItemInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/saveAndUpdateEvaEmpItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaEmpItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.empEvaInfoSer.saveAndUpdateEvaEmpItemInfo(request);

	}

	@RequestMapping(value = "/deleteEvaEmpItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaEmpItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.empEvaInfoSer.deleteEvaEmpItemInfo(request);
		return "Y";

	}
	@RequestMapping(value = "/viewKpiScore", method = RequestMethod.GET)
	public ModelAndView viewKpiScore(HttpServletRequest request, ModelMap modelMap){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		modelMap.put("validaterEmpId", admin.getAdminID());
		return new ModelAndView("/eva/empEvaInfo/viewKpiScore", modelMap);
	}
	@RequestMapping(value = "/viewKpiScoreManage", method = RequestMethod.GET)
	public ModelAndView viewKpiScoreManage(HttpServletRequest request, ModelMap modelMap){
		AdminBean admin = SessionUtil.getLoginUserFromSession(request);
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		modelMap.put("validaterEmpId", admin.getAdminID());
		return new ModelAndView("/eva/empEvaInfo/viewKpiScoreManage", modelMap);
	}
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/viewOneKpiScore", method = RequestMethod.GET)
	public ModelAndView viewOneKpiScore(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		
		Map paramMap = ObjectBindUtil.getRequestParamData(request);
		modelMap.put("month", paramMap.get("month"));
		return new ModelAndView("/eva/empEvaInfo/viewOneKpiScore", modelMap);
	}
}
