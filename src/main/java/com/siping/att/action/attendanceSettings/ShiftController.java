package com.siping.att.action.attendanceSettings;

import java.util.HashMap;
import java.util.LinkedHashMap;
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

import com.siping.att.service.ItemsSer;
import com.siping.att.service.ShiftSer;
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class ShiftController {
	Logger logger = Logger.getLogger(ShiftController.class);
	
	@Autowired
	private ShiftSer shiftSer ;
	
	@Autowired
	private ItemsSer itemsSer ;
	 
	@RequestMapping(value = "/viewShiftInfo",method = RequestMethod.GET)
	public ModelAndView viewShiftInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		  
		return new ModelAndView("/att/attendanceSettings/viewShiftInfo",modelMap);
	}
	 
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getShiftInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getShiftInfoList(HttpServletRequest request)throws Exception{
		
		Map modelMap = new LinkedHashMap<Object, Object>();
		
		List shiftInfoList = this.shiftSer.getShiftInfoList(request) ;		
		int shiftInfoCnt = this.shiftSer.getShiftInfoCnt(request) ;
		
		modelMap.put("Rows", shiftInfoList) ;
		modelMap.put("Total", shiftInfoCnt) ;
		
		return modelMap;		
	}
	
	@SuppressWarnings({ "rawtypes" })
	@RequestMapping(value = "/getJustShiftInfoList",method = RequestMethod.POST)
	@ResponseBody
	public List getJustShiftInfoList(HttpServletRequest request)throws Exception{
		List shiftInfoList = this.shiftSer.getShiftInfoList(request) ;				
		return shiftInfoList;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getShiftGroupInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getShiftGroupInfoList(HttpServletRequest request)throws Exception{
		
		Map modelMap = new LinkedHashMap<Object, Object>();
		
		List shiftInfoList = this.shiftSer.getShiftGroupInfoList(request) ;		
		int shiftInfoCnt = this.shiftSer.getShiftGroupInfoListCnt(request) ;
		
		modelMap.put("Rows", shiftInfoList) ;
		modelMap.put("Total", shiftInfoCnt) ;
		
		return modelMap;		
	}

	@RequestMapping(value = "/addAndUpdateShiftInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAndUpdateShiftInfo(HttpServletRequest request)throws Exception{
		String returnString = "Y" ;

		int errorNum = this.shiftSer.checkShiftInfo(request) ;
		if(errorNum == 0){
			this.shiftSer.addShiftInfo(request) ;
			this.shiftSer.updateShiftInfo(request) ;
		}
		else{
			returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
		}
		return returnString;
	}
	
	@RequestMapping(value = "/addAndUpdateShiftGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAndUpdateShiftGroupInfo(HttpServletRequest request)throws Exception{
		String returnString = "Y" ;

		int errorNum = this.shiftSer.checkShiftGroupInfo(request) ;
		if(errorNum == 0){
			this.shiftSer.addShiftGroupInfo(request) ;
			this.shiftSer.updateShiftGroupInfo(request) ;
		}
		else{
			returnString = Messages.getMessage(request, "hrms.sameDataAlreadyExists");
		}
		return returnString;
	}

	@RequestMapping(value = "/updateShiftInfo",method = RequestMethod.GET)
	public ModelAndView updateShiftInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		modelMap.put("shiftInfo", this.shiftSer.getShiftInfo(request)) ;
		
		return new ModelAndView("/att/attendanceSettings/updateShiftInfo",modelMap);
	}
	
	@RequestMapping(value = "/updateShiftGroupInfo",method = RequestMethod.GET)
	public ModelAndView updateShiftGroupInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		modelMap.put("shiftGroupInfo", this.shiftSer.getShiftGroupInfo(request)) ;
		return new ModelAndView("/att/attendanceSettings/updateShiftGroupInfo",modelMap);
	}

	@RequestMapping(value = "/deleteShiftInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteShiftInfo(HttpServletRequest request)throws Exception{
		shiftSer.deleteShiftInfo(request) ;
		return "Y";
	}
	
	@RequestMapping(value = "/deleteShiftGroupInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteShiftGroupInfo(HttpServletRequest request)throws Exception{
		shiftSer.deleteShiftGroupInfo(request) ;
		return "Y";
	}
	
	@RequestMapping(value = "/deleteShiftGroupEmpInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteShiftGroupEmpInfo(HttpServletRequest request)throws Exception{
		shiftSer.deleteShiftGroupEmpInfo(request) ;
		return "Y";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getShiftParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getShiftParameterInfo(HttpServletRequest request) {
		
		List itemParameterInfo = this.shiftSer.getShiftParameterInfo(request) ;
		
		Map model = new HashMap();
		model.put("Rows", itemParameterInfo);
	
		return model;
	}

	@RequestMapping(value = "/deleteShiftParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteShiftParameterInfo(HttpServletRequest request)throws Exception{
		
		this.shiftSer.deleteShiftParameterInfo(request) ;
		
		return "Y";
	}

	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/updateShiftParameterInfo",method = RequestMethod.GET)
	public ModelAndView updateShiftParameterInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		Map shiftParameterInfo = (Map) this.shiftSer.getShiftParameterInfoObj(request);
		
		modelMap.put("shiftParameterInfo", shiftParameterInfo) ;
		modelMap.put("itemInfoList", this.itemsSer.getItemInfoSelection(request)) ; 
		
		return new ModelAndView("/att/attendanceSettings/updateShiftParameterInfo",modelMap);
	} 

	@RequestMapping(value = "/updateShiftParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateShiftParameterInfo(HttpServletRequest request)throws Exception{
		
		this.shiftSer.updateShiftParameterInfo(request) ;
		
		return "Y";
	}

	@RequestMapping(value = "/addShiftParameterInfo",method = RequestMethod.GET)
	public ModelAndView addShiftParameterInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{

		modelMap.put("shiftInfo", this.shiftSer.getShiftInfo(request)) ;
		modelMap.put("itemInfoList", this.itemsSer.getItemInfoSelection(request)) ; 
		
		return new ModelAndView("/att/attendanceSettings/addShiftParameterInfo",modelMap);
	}

	@RequestMapping(value = "/addShiftParameterInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addShiftParameterInfo(HttpServletRequest request)throws Exception{
		
		this.shiftSer.addShiftParameterInfo(request) ;
		
		return "Y";
	}

	@RequestMapping(value = "/viewShiftGroup",method = RequestMethod.GET)
	public ModelAndView viewShiftGroup(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceSettings/viewShiftGroup",modelMap);
	}
	
	@RequestMapping(value = "/addGroupEmpInfo", method = RequestMethod.POST)
	@ResponseBody
	public String addGroupEmpInfo(HttpServletRequest request)
			throws Exception {
		int i = this.shiftSer.checkShiftGroupEmpDate(request);
		if(i>0){
			return "所申请时间与已分配时间有冲突";
		}
		this.shiftSer.addGroupEmpInfo(request);
		return "Y";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/getShiftGroupEmpInfoList",method = RequestMethod.POST)
	@ResponseBody
	public Map getShiftGroupEmpInfoList(HttpServletRequest request)throws Exception{
		
		Map modelMap = new LinkedHashMap<Object, Object>();
		
		List shiftInfoList = this.shiftSer.getShiftGroupEmpInfoList(request) ;		
		int shiftInfoCnt = this.shiftSer.getShiftGroupEmpInfoListCnt(request) ;
		
		modelMap.put("Rows", shiftInfoList) ;
		modelMap.put("Total", shiftInfoCnt) ;
		
		return modelMap;		
	}
}
