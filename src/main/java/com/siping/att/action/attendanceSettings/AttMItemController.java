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

import com.siping.att.service.AttMItemSer; 
import com.siping.web.messages.Messages;

@Controller
@RequestMapping(value = "/att/attendanceSettings")
public class AttMItemController {
	Logger logger = Logger.getLogger(AttMItemController.class);
	
	@Autowired
	private AttMItemSer attMItemSer ;
	
	@RequestMapping(value = "/viewAttMItemInfo",method = RequestMethod.GET)
	public ModelAndView viewAttMItem(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		return new ModelAndView("/att/attendanceSettings/viewAttMItemInfo",modelMap);
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttMItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttMItemInfo(HttpServletRequest request)throws Exception{
		
		List infoList = this.attMItemSer.getAttMItemInfo(request) ;
		int infoCnt = this.attMItemSer.getAttMItemInfoCnt(request) ;
		
		Map model=new HashMap();
		model.put("Rows", infoList) ;
		model.put("Total", infoCnt) ;
	
		return model;		
	}
	
	@RequestMapping(value = "/addAttMItemInfo",method = RequestMethod.GET)
	public ModelAndView addAttMItemInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceSettings/addAttMItemInfo",modelMap);
	}
	
	@RequestMapping(value = "/addAttMItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public String addAttMItemInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;

		this.attMItemSer.addAttMItemInfo(request) ;
		
		return returnString;
	}
	
	@RequestMapping(value = "/updateAttMItemInfo",method = RequestMethod.GET)
	public ModelAndView updateAttMItemInfo(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		
		modelMap.put("attMItemInfo", this.attMItemSer.getAttMItemObjectInfo(request)) ;
		
		return new ModelAndView("/att/attendanceSettings/updateAttMItemInfo",modelMap);
	}
	
	@RequestMapping(value = "/updateAttMItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttMItemInfo(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;

		attMItemSer.updateAttMItemInfo(request) ;
		
		return returnString;
	}
	
	@RequestMapping(value = "/deleteAttMItemInfo",method = RequestMethod.POST)
	@ResponseBody
	public String deleteAttMItemInfo(HttpServletRequest request)throws Exception{
		 
		String returnString = "Y";

		int errorInt = this.attMItemSer.checkDeleteAttMItemInfo(request);
		if (errorInt == 0) {
			this.attMItemSer.deleteAttMItemInfo(request) ;
		} else {
			returnString = Messages.getMessage(request, "hrms.canNotdelete");
		}
		return returnString;
	}
	
	@RequestMapping(value = "/updateAttMItemInfoCalOrder",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttMItemInfoCalOrder(HttpServletRequest request)throws Exception{
		
		String returnString = "Y" ;
		
		this.attMItemSer.updateAttMItemInfoCalOrder(request) ;
		
		return returnString;
	}
	
}
