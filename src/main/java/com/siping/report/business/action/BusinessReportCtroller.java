package com.siping.report.business.action;
  
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;  
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;   
import org.springframework.web.servlet.ModelAndView;

import com.siping.web.utility.SessionUtil;

@Controller
@RequestMapping(value = "/report/business")
public class BusinessReportCtroller {
	Logger logger = Logger.getLogger(BusinessReportCtroller.class);
 
	@RequestMapping(value = "/report1", method = RequestMethod.GET)
	public ModelAndView report1(HttpServletRequest request, ModelMap modelMap) {
		
		return new ModelAndView("/report/business/report1", modelMap);
	}
	
	@RequestMapping(value = "/report2", method = RequestMethod.GET)
	public ModelAndView report2(HttpServletRequest request, ModelMap modelMap) {
		
		return new ModelAndView("/report/business/report2", modelMap);
	}

}
