package com.siping.pa.action.salary;

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

import com.siping.pa.service.salary.PaFormulaSer;
import com.siping.pa.service.salary.PaItemSer;
import com.siping.web.messages.Messages;
import com.siping.web.utility.ObjectBindUtil;

@Controller
@RequestMapping(value = "/pa/salary")
public class PaFormulaCtroller {
	Logger logger = Logger.getLogger(PaFormulaCtroller.class);

	@Autowired
	private PaFormulaSer paFormulaSer;
	@Autowired
	private PaItemSer paItemSer;

	@RequestMapping(value = "/viewPaFormulaInfo", method = RequestMethod.GET)
	public ModelAndView viewPaFormula(HttpServletRequest request, ModelMap modelMap) {

		return new ModelAndView("/pa/salary/viewPaFormulaInfo", modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaFormulaInfo(HttpServletRequest request) {
		List infoList = this.paFormulaSer.getPaFormulaInfo(request);
		int infoCnt = this.paFormulaSer.getPaFormulaInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);
		
		return model;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getPaFormulaCnInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getPaFormulaCnInfo(HttpServletRequest request) {
		List infoList = this.paFormulaSer.getPaFormulaCnInfo(request);
		int infoCnt = this.paFormulaSer.getPaFormulaInfoCnt(request);
		Map model = new HashMap();
		model.put("Rows", infoList);
		model.put("Total", infoCnt);

		return model;
	}

	@RequestMapping(value = "/addPaFormulaInfo", method = RequestMethod.GET)
	public ModelAndView addPaFormulaInfo(HttpServletRequest request, ModelMap modelMap) {
		modelMap.put("paItemInfo", this.paItemSer.getPaItemObjectInfo(request));
		modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));
		
		return new ModelAndView("/pa/salary/addPaFormulaInfo", modelMap);
	}

	@RequestMapping(value = "/viewPaFormularTool", method = RequestMethod.GET)
	public ModelAndView viewFormularTool(HttpServletRequest request,ModelMap modelMap) {
		modelMap.put("paraMap", ObjectBindUtil.getRequestParamData(request));

		return new ModelAndView("/pa/salary/viewPaFormularTool", modelMap);
	}

	@RequestMapping(value = "/addPaFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addPaFormulaInfo(HttpServletRequest request){
		
		return this.paFormulaSer.addPaFormulaInfo(request);
	}

	@RequestMapping(value = "/updatePaFormulaInfo", method = RequestMethod.GET)
	public ModelAndView updatePaFormulaView(HttpServletRequest request,ModelMap modelMap) {
		modelMap.put("paItemInfo", this.paItemSer.getPaItemObjectInfo(request));
		modelMap.put("paFormulaInfo",this.paFormulaSer.getPaFormulaObjectInfo(request));

		return new ModelAndView("/pa/salary/updatePaFormulaInfo", modelMap);
	}

	@RequestMapping(value = "/updatePaFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updatePaFormulaInfo(HttpServletRequest request){
		
		return this.paFormulaSer.updatePaFormulaInfo(request);
	}

	@RequestMapping(value = "/deletePaFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deletePaFormulaInfo(HttpServletRequest request){
		
		return this.paFormulaSer.deletePaFormulaInfo(request);
	}

	@RequestMapping(value = "/initPaFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String initPaFormulaInfo(HttpServletRequest request){

		return this.paFormulaSer.initPaFormulaInfo(request);
	}
}
