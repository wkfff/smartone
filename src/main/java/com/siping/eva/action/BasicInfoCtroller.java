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

import com.siping.eva.service.BasicInfoSer;
import com.siping.eva.service.KPISer;
import com.siping.hrm.service.EmpInfoSer;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/eva/basicInfo")
public class BasicInfoCtroller {

	Logger logger = Logger.getLogger(BasicInfoCtroller.class);

	@Autowired
	private BasicInfoSer basicInfoSer;
	@Autowired
	private EmpInfoSer empInfoSer;
	@Autowired
	private KPISer kpiSer;
	/**
	 * 评价期间
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaPeriodInfo", method = RequestMethod.GET)
	public ModelAndView viewevaPeriodInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		return new ModelAndView("/eva/basicInfo/viewEvaPeriodInfo", modelMap);
	}
	/**
	 * 评价类型流程期间
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaTypeProcessInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaTypeprocessInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		return new ModelAndView("/eva/basicInfo/viewEvaTypeProcessInfo", modelMap);
	}
	
	/**
	 * 评价类型
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaPeriodTypeInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaPeriodTypeInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewEvaPeriodTypeInfo", modelMap);
	}
	/**
	 * 评价项目
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaPeriodTypeItemInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaPeriodTypeItemInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewEvaPeriodTypeItemInfo", modelMap);
	}
	/**
	 * 试用评价
	 * 
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewEvaEmpNormalInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpNormalInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewEvaEmpNormalInfo", modelMap);
	}
	@RequestMapping(value = "/viewEvaEmpNormalDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaEmpNormalDetailInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewEvaEmpNormalDetailInfo", modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaPeriodInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaPeriodInfo(HttpServletRequest request) throws Exception {

		List infoList = this.basicInfoSer.getEvaPeriodInfo(request);
		int infoCnt = this.basicInfoSer.getEvaPeriodInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/saveAndUpdateEvaPeriodInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaPeriodInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.basicInfoSer.saveAndUpdateEvaPeriodInfo(request);

	}

	@RequestMapping(value = "/deleteEvaPeriodInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaPeriodInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.basicInfoSer.deleteEvaPeriodInfo(request);
		return "Y";

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaPeriodTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaPeriodTypeInfo(HttpServletRequest request) throws Exception {

		List infoList = this.basicInfoSer.getEvaPeriodTypeInfo(request);
		int infoCnt = this.basicInfoSer.getEvaPeriodTypeInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/saveAndUpdateEvaPeriodTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaPeriodTypeInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.basicInfoSer.saveAndUpdateEvaPeriodTypeInfo(request);

	}

	@RequestMapping(value = "/deleteEvaPeriodTypeInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaPeriodTypeInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.basicInfoSer.deleteEvaPeriodTypeInfo(request);
		return "Y";

	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaPeriodTypeItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaPeriodTypeItemInfo(HttpServletRequest request) throws Exception {

		List infoList = this.basicInfoSer.getEvaPeriodTypeItemInfo(request);
		int infoCnt = this.basicInfoSer.getEvaPeriodTypeItemInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/saveAndUpdateEvaPeriodTypeItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaPeriodTypeItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.basicInfoSer.saveAndUpdateEvaPeriodTypeItemInfo(request);

	}

	@RequestMapping(value = "/deleteEvaPeriodTypeItemInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaPeriodTypeItemInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.basicInfoSer.deleteEvaPeriodTypeItemInfo(request);
		return "Y";

	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEvaTypeProcessInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getEvaTypeProcessInfo(HttpServletRequest request) throws Exception {

		List infoList = this.basicInfoSer.getEvaTypeProcessInfo(request);
		int infoCnt = this.basicInfoSer.getEvaTypeProcessInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/saveAndUpdateEvaTypeProcessInfo", method = RequestMethod.POST)
	@ResponseBody
	public String saveAndUpdateEvaTypeProcessInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.basicInfoSer.saveAndUpdateEvaTypeProcessInfo(request);

	}
	
	@RequestMapping(value = "/deleteEvaTypeProcessInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteEvaTypeProcessInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		this.basicInfoSer.deleteEvaTypeProcessInfo(request);
		return "Y";

	}

	@RequestMapping(value = "/updateEvaTypeProcessOrderInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateEvaTypeProcessOrderInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return this.basicInfoSer.updateEvaTypeProcessOrderInfo(request);

	}
	
	@RequestMapping(value = "/viewEvaKpiInfo", method = RequestMethod.GET)
	public ModelAndView viewEvaKpiInfo(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewEvaKpiInfo", modelMap);
	}
	@RequestMapping(value = "/viewKpiTypeDetailInfo", method = RequestMethod.GET)
	public ModelAndView viewKpiTypeDetailInfo(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewKpiTypeDetailInfo", modelMap);
	}
	@RequestMapping(value = "/kpiItemDistribute", method = RequestMethod.GET)
	public ModelAndView kpiItemDistribute(HttpServletRequest request, ModelMap modelMap){
		return new ModelAndView("/eva/basicInfo/kpiItemDistribute", modelMap);
	}

	@RequestMapping(value = "/viewUnuseKpiItem", method = RequestMethod.GET)
	public ModelAndView viewUnuseKpiItem(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewUnuseKpiItem", modelMap);
	}
	
	@RequestMapping(value = "/viewUnuseKpiItemManager", method = RequestMethod.GET)
	public ModelAndView viewUnuseKpiItemManager(HttpServletRequest request,
			ModelMap modelMap) throws Exception {
		modelMap.put("paraMap", this.basicInfoSer.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewUnuseKpiItemManager", modelMap);
	}

	@RequestMapping(value = "/viewKpiItemManager", method = RequestMethod.GET)
	public ModelAndView viewKpiItemManager(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("basicInfo", this.empInfoSer.getBasicInfo(request));
		return new ModelAndView("/eva/basicInfo/viewKpiItemManager", modelMap);
	}

	@RequestMapping(value = "/viewUnuseManager", method = RequestMethod.GET)
	public ModelAndView viewUnuseManager(HttpServletRequest request, ModelMap modelMap){
		modelMap.put("paraMap",ObjectBindUtil.getRequestParamData(request));
		return new ModelAndView("/eva/basicInfo/viewUnuseManager", modelMap);
	}
}
