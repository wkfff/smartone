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
  
import com.siping.att.service.AttProgressSer; 

@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttProgressController {
Logger logger = Logger.getLogger(AttProgressController.class);
	
	@Autowired
	private AttProgressSer attProgressSer;
	
	@RequestMapping(value = "/viewAttProgress",method = RequestMethod.GET)
	public ModelAndView viewAttMonth(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
      
	   return new ModelAndView("/att/attendanceMintenance/viewAttProgress",modelMap);
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/getAttProgressInfo",method = RequestMethod.POST)
	@ResponseBody
	public Map getAttProgressInfo(HttpServletRequest request)throws Exception{
		
		List infoList = this.attProgressSer.getAttProgressInfo(request) ;
		
		Map model=new HashMap();
		model.put("Rows", infoList) ;
	 
		
		return model ;	
	}
	
	@RequestMapping(value = "/updateAttProgressInfo",method = RequestMethod.POST)
	@ResponseBody
	public String updateAttProgressInfo(HttpServletRequest request)throws Exception{
		
		this.attProgressSer.updateAttProgressInfo(request) ;
		
		return "Y";		
	}
}
