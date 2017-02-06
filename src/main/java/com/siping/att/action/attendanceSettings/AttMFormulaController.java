package com.siping.att.action.attendanceSettings;

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

import com.siping.att.service.AttMFormulaSer; 
import com.siping.att.service.AttMItemSer;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class AttMFormulaController {

	Logger logger = Logger.getLogger(AttMFormulaController.class);

	@Autowired
	private AttMFormulaSer attMFormulaSer; 
	@Autowired
	private AttMItemSer attMItemSer ;

	@RequestMapping(value = "/viewAttMFormulaInfo", method = RequestMethod.GET)
	public ModelAndView viewAttMFormulaInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView("/att/attendanceSettings/viewAttMFormulaInfo",
				modelMap);
	}

	@RequestMapping(value = "/addAttMFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAttMFormulaInfo(HttpServletRequest request) throws Exception {
		String returnString = "Y";
		try {
			this.attMFormulaSer.addAttMFormulaInfo(request);
		} catch (RuntimeException e) {
			returnString = "N";
			e.printStackTrace();
		}

		return returnString;
	}

	@RequestMapping(value = "/addAttMFormulaInfo", method = RequestMethod.GET)
	public ModelAndView addAttMFormulaInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("attMItemInfo",
				this.attMItemSer.getAttMItemObjectInfo(request));
		modelMap.put("paraMap",
				this.attMFormulaSer.getRequestParamData(request));
		return new ModelAndView(
				"/att/attendanceSettings/addAttMFormulaInfo", modelMap);
	}
 
	@RequestMapping(value = "/ViewAttMFormulaTool", method = RequestMethod.GET)
	public ModelAndView ViewAttMFormulaTool(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		 
		modelMap.put("paraMap",
				this.attMFormulaSer.getRequestParamData(request));
		return new ModelAndView("/att/attendanceSettings/ViewAttMFormulaTool",
				modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getAttMFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getAttMFormulaInfo(HttpServletRequest request)
			throws Exception {

		List infoList = this.attMFormulaSer.getAttMFormulaInfo(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		return model;
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getAttMFormulaCnInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getAttMFormulaCnInfo(HttpServletRequest request)
			throws Exception {

		List infoList = this.attMFormulaSer.getAttMFormulaCnInfo(request);

		Map model = new HashMap();
		model.put("Rows", infoList);
		return model;
	}

	@RequestMapping(value = "/upadteAttMFormulaInfo", method = RequestMethod.GET)
	public ModelAndView upadteAttMFormulaInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		modelMap.put("attMItemInfo",
				this.attMItemSer.getAttMItemObjectInfo(request));
		modelMap.put("attMFormulaInfo",
				this.attMFormulaSer.getAttMFormulaObjectInfo(request));
		return new ModelAndView("/att/attendanceSettings/upadteAttMFormulaInfo",
				modelMap);
	}

	@RequestMapping(value = "/updateAttMFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String updateAttMFormulaInfo(HttpServletRequest request) throws Exception {
		String returnString = "Y";

		try {
			this.attMFormulaSer.updateAttMFormulaInfo(request);
		} catch (RuntimeException e) {
			returnString = "N";
			e.printStackTrace();
		}

		return returnString;
	}

	@RequestMapping(value = "/deleteAttMFormulaInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttMFormulaInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		String returnString = "Y";

		try {
			this.attMFormulaSer.deleteAttMFormulaInfo(request);
		} catch (RuntimeException e) {
			returnString = "Y";
			e.printStackTrace();
		}

		return returnString;
	}

}
