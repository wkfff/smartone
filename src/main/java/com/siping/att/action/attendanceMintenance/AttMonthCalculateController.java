package com.siping.att.action.attendanceMintenance;

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

 
import com.siping.att.service.AttMonthCalculateSer;


@Controller
@RequestMapping(value = "/att/attendanceMintenance")
public class AttMonthCalculateController {
	Logger logger = Logger.getLogger(AttMonthCalculateController.class);
	
	@Autowired
	private AttMonthCalculateSer attMonthCalculateSer;
	
	@RequestMapping(value = "/viewAttMonthCalculate",method = RequestMethod.GET)
	public ModelAndView viewAttMonthCalculate(HttpServletRequest request,
				HttpServletResponse response,ModelMap modelMap) throws Exception{
		return new ModelAndView("/att/attendanceMintenance/viewAttMonthCalculate",modelMap);
	}
	
	@RequestMapping(value = "/monthCalculate",method = RequestMethod.POST)
	@ResponseBody
	public String detailCalculate(HttpServletRequest request)throws Exception{
		String returnString = this.attMonthCalculateSer.monthCalculate(request);
		return returnString;
	}
}
