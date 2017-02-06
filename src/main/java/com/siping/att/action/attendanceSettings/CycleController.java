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

import com.siping.att.service.CycleSer;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class CycleController {
	Logger logger = Logger.getLogger(CycleController.class);
	
	@Autowired
	private CycleSer cycleSer ;
	
	@RequestMapping(value = "/viewCycleInfo",method = RequestMethod.GET)
	public ModelAndView viewCycleInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/att/attendanceSettings/viewCycleInfo",modelMap);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getCycleInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getCycleInfoList(HttpServletRequest request)throws Exception{
		
		List cycleList = this.cycleSer.getCycleInfoList(request) ;
		
		int cycleCnt = this.cycleSer.getCycleInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("Rows", cycleList) ;
		model.put("Total", cycleCnt) ;
	
		return model;		
	}
	
	@RequestMapping(value = "/addCycleInfo",method = RequestMethod.GET)
	public ModelAndView addCycleInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/att/attendanceSettings/addCycleInfo",modelMap);
	}
	
	@RequestMapping(value = "/addCycleInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addCycleInfo(HttpServletRequest request)throws Exception{
		
		this.cycleSer.addCycleInfo(request) ;
		
		return "Y";		
	}

	@RequestMapping(value = "/deleteCycleInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteCycleInfo(HttpServletRequest request)throws Exception{
		
		this.cycleSer.deleteCycleInfo(request) ;
		
		return "Y";		
	}
	@RequestMapping(value = "/updateCycleInfo",method = RequestMethod.GET)
	public ModelAndView updateCycleInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		modelMap.put("cycleInfo", cycleSer.getCycleInfo(request)) ;
		
		return new ModelAndView("/att/attendanceSettings/updateCycleInfo",modelMap);
	}
	
	@RequestMapping(value = "/updateCycleInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateCycleInfo(HttpServletRequest request)throws Exception{
		
		cycleSer.updateCycleInfo(request) ;
		
		return "Y";		
	}
}
