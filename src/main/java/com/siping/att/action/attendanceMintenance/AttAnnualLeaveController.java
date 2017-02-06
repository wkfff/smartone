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

import com.siping.att.service.AttAnnualLeaveSer;
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttAnnualLeaveController {
Logger logger = Logger.getLogger(AttAnnualLeaveController.class) ;
	
	@Autowired
	private AttAnnualLeaveSer attAnnualLeaveSer ;
	
	/**
	 * 年休假信息
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/viewAttAnnualLeave",method = RequestMethod.GET)
	public ModelAndView viewAttAnnualLeave(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
      
	   return new ModelAndView("/att/attendanceMintenance/viewAttAnnualLeave",modelMap);
	}
	/**
	 * 年休假信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttAnnualLeaveInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttAnnualLeaveInfoList(HttpServletRequest request)throws Exception{
		
		List attAnnualLeaveList = this.attAnnualLeaveSer.getAttAnnualLeaveInfoList(request) ;
		
		int attAnnualLeaveCnt = this.attAnnualLeaveSer.getAttAnnualLeaveInfoCnt(request) ;
		
		Map model = new HashMap() ;
		model.put("Rows", attAnnualLeaveList) ;
		model.put("Total", attAnnualLeaveCnt) ;
		
		return model ;	
	}
	/**
	 * ess 休假申请时 
	 * 显示年休假信息
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getEsslLeaveInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getEsslLeaveInfo(HttpServletRequest request)throws Exception{
		
		List essLeaveInfo = this.attAnnualLeaveSer.getEsslLeaveInfo(request) ;
		
		int essLeaveInfoCnt = this.attAnnualLeaveSer.getEsslLeaveInfoCnt(request) ;
		
		Map model = new HashMap() ;
		model.put("Rows", essLeaveInfo) ;
		model.put("Total", essLeaveInfoCnt) ;
		
		return model ;	
	}
	
	@RequestMapping(value = "/deleteAttAnnualLeaveInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttAnnualLeaveInfo(HttpServletRequest request)throws Exception{
		
		this.attAnnualLeaveSer.deleteAttAnnualLeaveInfo(request) ;
		
		return "Y";		
	}

	@RequestMapping(value = "/updateAttAnnualLeaveView",method = RequestMethod.GET)
	public ModelAndView updateAttAnnualLeaveView(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		modelMap.put("annualLeaveInfo", this.attAnnualLeaveSer.getAttAnnualLeaveInfo(request)) ;
		
		return new ModelAndView("/att/attendanceMintenance/updateAttAnnualLeaveView",modelMap);
	}
	
	@RequestMapping(value = "/updateAttAnnualLeaveInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttAnnualLeaveInfo(HttpServletRequest request)throws Exception{
		
		this.attAnnualLeaveSer.updateAttAnnualLeaveInfo(request) ;
		
		return "Y";		
	}
	
	@RequestMapping(value = "/addAttAnnualLeaveInfo",method = RequestMethod.GET)
	public ModelAndView addAttAnnualLeaveInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/att/attendanceMintenance/addAttAnnualLeaveInfo",modelMap);
	}
	
	@RequestMapping(value = "/addAttAnnualLeaveInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAttAnnualLeaveInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		int errorInt = this.attAnnualLeaveSer.checkAddAttAnnualLeaveInfo(request) ;
		if(errorInt == 0){
			this.attAnnualLeaveSer.addAttAnnualLeaveInfo(request) ;
		}
		else{
			returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
		}
		
		return returnString ;	
	}
	
	@RequestMapping(value = "/createAttAnnualLeaveInfo",method = RequestMethod.POST)
	@ResponseBody
	public String createAttAnnualLeaveInfo(HttpServletRequest request)throws Exception{
		
		this.attAnnualLeaveSer.createAttAnnualLeaveInfo(request) ;
		
		return "Y";		
	}
	
}
