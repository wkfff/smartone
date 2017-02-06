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

import com.siping.att.service.DynamicGroupSer;
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class DynamicGroupController {
	Logger logger = Logger.getLogger(DynamicGroupController.class);

	@Autowired
	private DynamicGroupSer dynamicGroupSer;

	@RequestMapping(value = "/viewDynamicGroupInfo", method = RequestMethod.GET)
	public ModelAndView viewDynamicGroupInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {

		return new ModelAndView("/att/attendanceSettings/viewDynamicGroupInfo",
				modelMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getDynamicGroupInfoList", method = RequestMethod.POST)
	@ResponseBody
	public Map getDynamicGroupInfoList(HttpServletRequest request)
			throws Exception {

		List dynamicGroupInfoList = this.dynamicGroupSer
				.getDynamicGroupList(request);

		int dynamicGroupInfoCnt = this.dynamicGroupSer
				.getDynamicGroupCnt(request);

		Map model = new HashMap();
		model.put("Rows", dynamicGroupInfoList);
		model.put("Total", dynamicGroupInfoCnt);

		return model;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getDynamicGroupEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getDynamicGroupEmpInfo(HttpServletRequest request)
			throws Exception {

		List dynamicGroupEmpInfo = this.dynamicGroupSer
				.getDynamicGroupEmpInfo(request);

		int dynamicGroupEmpInfoCnt = this.dynamicGroupSer
				.getDynamicGroupEmpInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", dynamicGroupEmpInfo);
		model.put("Total", dynamicGroupEmpInfoCnt);

		return model;
	}

	@RequestMapping(value = "/addAndUpdateDynamicGroupInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addAndUpdateDynamicGroupInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		String returnString = "Y";

		int errorAInt = this.dynamicGroupSer.addDynamicGroupInfo(request);
		int errorUInt = this.dynamicGroupSer.updateDynamicGroupInfo(request);
		if(errorAInt != 0){
			returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
		}if(errorUInt != 0){ 
			returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
		}	
		return returnString;
	} 

	@RequestMapping(value = "/updateDynamicGroupInfo", method = RequestMethod.GET)
	public ModelAndView updateDynamicGroupInfo(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) throws Exception {
		modelMap.put("DynamicGroup", dynamicGroupSer.getDynamicGroup(request));
		return new ModelAndView(
				"/att/attendanceSettings/updateDynamicGroupInfo");
	}

	@RequestMapping(value = "/updateDynamicGroup", method = RequestMethod.POST)
	@ResponseBody
	public String updateDynamicGroup(HttpServletRequest request)
			throws Exception {

		this.dynamicGroupSer.updateDynamicGroupInfo(request);

		return "Y";

	}

	@RequestMapping(value = "/addDynamicGroupEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addDynamicGroupEmpInfo(HttpServletRequest request)
			throws Exception {
	
		this.dynamicGroupSer.addDynamicGroupEmpInfo(request);
	
		return "Y";
	
	}

	@RequestMapping(value = "/deleteDynamicGroupEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteDynamicGroupEmpInfo(HttpServletRequest request)
			throws Exception {
	
		this.dynamicGroupSer.deleteDynamicGroupEmpInfo(request);
	
		return "Y";
	
	}

	@RequestMapping(value = "/deleteDynamicGroupInfo", method = RequestMethod.POST)
	@ResponseBody
	public String deleteDynamicGroupInfo(HttpServletRequest request)
			throws Exception {

		this.dynamicGroupSer.deleteDynamicGroupInfo(request);

		return "Y";

	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getNonDynamicGroupEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public Map getNonDynamicGroupEmpInfo(HttpServletRequest request)
			throws Exception {

		List dynamicGroupEmpInfo = this.dynamicGroupSer
				.getNonDynamicGroupEmpInfo(request);

		int dynamicGroupEmpInfoCnt = this.dynamicGroupSer
				.getNonDynamicGroupEmpInfoCnt(request);

		Map model = new HashMap();
		model.put("Rows", dynamicGroupEmpInfo);
		model.put("Total", dynamicGroupEmpInfoCnt);

		return model;
	}

}
