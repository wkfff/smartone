package com.siping.att.action.attendanceMintenance;

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
import com.siping.att.service.EmpShiftSer;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class EmpShiftController {
Logger logger = Logger.getLogger(EmpShiftController.class);
	
	@Autowired
	private EmpShiftSer empShiftSer;
	@Autowired
	private DynamicGroupSer dynamicGroupSer ;
	
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/addEmpShiftInfo",method = RequestMethod.GET)
	public ModelAndView addEmpShiftInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List dynamicGroupList = this.dynamicGroupSer.getDynamicGroupList(request) ;
		modelMap.put("dynamicGroupList", dynamicGroupList) ; 
		return new ModelAndView("/att/attendanceMintenance/addEmpShiftInfo",modelMap);
	} 
	@RequestMapping(value = "/viewGroupEmpInfo",method = RequestMethod.GET)
	public ModelAndView viewGroupEmpInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		modelMap.put("paraMap", this.empShiftSer.getRequestParamData(request)) ; 
		return new ModelAndView("/att/attendanceMintenance/viewGroupEmpInfo",modelMap);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getShiftedInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getShiftSelectedInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List returnList = this.empShiftSer.getShiftSelectedInfo(request) ; 

		Map model = new HashMap();
		model.put("Rows", returnList);
		return model;
	}  
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getSchedulingEmpInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getSchedulingEmpInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List returnList = this.empShiftSer.getSchedulingEmpInfo(request) ;
		int returnListCnt = this.empShiftSer.getSchedulingEmpInfoCnt(request) ;
		Map model = new HashMap();
		model.put("Rows", returnList);
		model.put("Total", returnListCnt);
		return model;		
	}
	@RequestMapping(value = "/viewEmpShiftDetailInfo",method = RequestMethod.GET)
	public ModelAndView viewEmpShiftDetailInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("paraMap", this.empShiftSer.getRequestParamData(request)) ; 
		return new ModelAndView("/att/attendanceMintenance/viewEmpShiftDetailInfo",modelMap);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getEmpShiftDetailInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getEmpShiftDetailInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		List returnList = this.empShiftSer.getEmpShiftDetailInfo(request) ;
		int returnListCnt = this.empShiftSer.getEmpShiftDetailInfoCnt(request) ;
		Map model = new HashMap();
		model.put("Rows", returnList);
		model.put("Total", returnListCnt);
		return model;
	}

	@RequestMapping(value = "/addShiftedInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addShiftedInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String returnString = "Y" ; 
		try {
			this.empShiftSer.addShiftedInfo(request) ;
		} catch (RuntimeException e) { 
			e.printStackTrace();
			returnString = "员工安排班次失败" ;
		} 
		return returnString;
	}
	@RequestMapping(value = "/deleteShiftedInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteShiftedInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String returnString = "Y" ; 
		try {
			this.empShiftSer.deleteShiftedInfo(request) ;
		} catch (RuntimeException e) {
			e.printStackTrace();
			returnString = "Y" ;
		}
		return returnString;
	}
	@RequestMapping(value = "/upShiftedInfo",method = RequestMethod.POST)
	@ResponseBody
	public String upShiftedInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String returnString = "Y" ;
		try {
			this.empShiftSer.upShiftedInfo(request) ;
		} catch (RuntimeException e) { 
			e.printStackTrace();
			returnString = "Y" ;
		}
		return returnString;
	}
	@RequestMapping(value = "/downShiftedInfo",method = RequestMethod.POST)
	@ResponseBody
	public String downShiftedInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String returnString = "Y" ; 
		try {
			this.empShiftSer.downShiftedInfo(request) ;
		} catch (RuntimeException e) { 
			e.printStackTrace();
			returnString = "Y" ;
		} 
		return returnString;
	}
	
	@RequestMapping(value = "/addEmpShift",method = RequestMethod.POST)
	@ResponseBody
	public String addEmpShift(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		String returnString = "Y" ;
		try {
			this.empShiftSer.addEmpShift(request) ;
		} catch (RuntimeException e) {
			returnString = "Y" ;
			e.printStackTrace(); 
		}
		return returnString;
	}
}
